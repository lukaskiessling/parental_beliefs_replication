include project_paths
log using `"${PATH_OUT_DATA}/log/`1'.log"', replace

import excel "${PATH_IN_DATA}PovertyEstimates.xls", sheet("Poverty Data 2016") cellrange(A4:AH3198) firstrow clear

destring FIPStxt, replace
rename FIPStxt countyFIPS

rename Ruralurban_Continuum_Code_2013 ruralurban
rename PCTPOVALL_2016 poverty_county_2016
rename MEDHHINC_2016 medhhinc_county_2016
keep countyFIPS ruralurban poverty_county_2016 medhhinc_county_2016

save "${PATH_OUT_DATA}poverty_county_data.dta", replace


clear
* import zipcode to census tract crosswalk
* retrieved from https://www.huduser.gov/portal/datasets/usps_crosswalk.html#data
import delimited "${PATH_IN_DATA}ZIP_TRACT_092018.csv"

keep zip tract res_ratio
rename zip zipcode
rename tract tract_long

tostring tract_long, gen(tract_string) format(%12.0f)
gen string_length = strlen(tract_string)
replace tract_string = "0" + tract_string if string_length==10

gen tract = substr(tract_string,6,6)
destring tract, replace
gen county = substr(tract_string,3,3)
destring county, replace
gen countyFIPS = substr(tract_string,1,5)
destring countyFIPS, replace
gen state = substr(tract_string,1,2)
destring state, replace

gen share = subinstr(res_ratio,",",".",.)
destring share, replace
replace share = -share

sort zipcode share
bysort zipcode: gen counter = _n
drop if counter != 1

drop tract_string string_length res_ratio share counter
save "${PATH_OUT_DATA}zip_to_tract_crosswalk.dta", replace

merge m:1 tract county state using "${PATH_IN_DATA}tract_covariates.dta"
drop if _merge != 3
drop _merge

gen cty2000 = state*1000 + county
merge m:1 cty2000 using "${PATH_IN_DATA}online_table4-2.dta"
drop if _merge == 2
drop _merge

merge m:1 countyFIPS using "${PATH_OUT_DATA}poverty_county_data.dta"
drop if _merge == 2
drop _merge
gen metro_indicator = cond((ruralurban<=3), 1, 0)
label var metro_indicator "Metro region"

save "${PATH_OUT_DATA}zipcode_covariates.dta", replace

************************************

clear
use "${PATH_OUT_DATA}data_cleaned.dta", clear

* some respondents gave a series of zipcodes --> use only first one
rename zipcode zipcode_string
gen zipcode = substr(zipcode_string,1,5)
destring zipcode, replace

rename state state_survey

merge m:1 zipcode using "${PATH_OUT_DATA}zipcode_covariates.dta"

drop if _merge == 2
drop _merge

* check matching by comparing states (yields info whether zipcodes are sensible)
gen matched_state = cond(state==stateFIPS, 1, 0)
tab matched_state

drop state
rename state_survey state

** generate principal factor of neighborhood characteristics
* note: use only those covariates that are available for all respondents AND which do not have correlations above .9
factor frac_coll_plus2010 med_hhinc2016 poor_share2010 singleparent_share2010 gsmn_math_g3_2013 ///
	mail_return_rate2010 foreign_share2010 nonwhite_share2010 popdensity2010 jobs_total_5mi_2015 ///
	traveltime15_2010 , factors(2)
rotate
predict neighborhood_quality_1 neighborhood_quality_2
label var neighborhood_quality_1 "Neighborhood quality 1 (economic well-being)"
label var neighborhood_quality_2 "Neighborhood quality 2 (urban and segregation)"

save "${PATH_OUT_DATA}data_crosssection.dta", replace


*********************************************************

*** reshape to individual-level panel dataset
reshape long w ln_w ls ln_ls, i(id) j(scenario)
gen warmth = 0
replace warmth = 1 if scenario == 3 | scenario == 4 | scenario == 7  | scenario == 8
label var warmth "High warmth"
gen control = 0
replace control = 1 if scenario == 1 | scenario == 4 | scenario == 5  | scenario == 8
label var control "High control"
gen neighborhood = 0
replace neighborhood = 1 if scenario == 1 | scenario == 2 | scenario == 3  | scenario == 4
label var neighborhood "Good neighborhood"
gen warmth_control = warmth*control
label var warmth_control "High warmth $\times$ High control"
gen warmth_neighborhood = warmth*neighborhood
label var warmth_neighborhood "High warmth $\times$ Good neighb."
gen control_neighborhood = control*neighborhood
label var control_neighborhood "High control $\times$ Good neighb."
gen warmth_control_neighborhood = warmth*control*neighborhood
label var warmth_control_neighborhood "High warm. $\times$ High cont. $\times$ Good neighb."

* generate correlations of wage and life satisfaction expectations by respondent
bysort id: egen correlation_w_ls = corr(w ls)
bysort id: egen correlation_log_w_ls = corr(ln_w ln_ls)
bysort id: egen correlation_spearman_w_ls = corr(w ls), spearman

save "${PATH_OUT_DATA}/data_panel.dta", replace


levelsof id, local(levels)

gen return_w_warmth_2 = .
gen return_w_control_2 = .
gen return_w_neighborhood_2 = .
gen return_w_wc_2 = .
gen return_w_wn_2 = .
gen return_w_cn_2 = .

gen return_ls_warmth_2 = .
gen return_ls_control_2 = .
gen return_ls_neighborhood_2 = .
gen return_ls_wc_2 = .
gen return_ls_wn_2 = .
gen return_ls_cn_2 = .

foreach i in `levels' {
	reg ln_w warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if id == `i', r
	matrix e_b = e(b)
	replace return_w_warmth_2 = e_b[1,1] if id == `i'
	replace return_w_control_2 = e_b[1,2] if id == `i'
	replace return_w_neighborhood_2 = e_b[1,3] if id == `i'
	replace return_w_wc_2 = e_b[1,4] if id == `i'
	replace return_w_wn_2 = e_b[1,5] if id == `i'
	replace return_w_cn_2 = e_b[1,6] if id == `i'

	reg ln_ls warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if id == `i', r
	matrix e_b = e(b)
	replace return_ls_warmth_2 = e_b[1,1] if id == `i'
	replace return_ls_control_2 = e_b[1,2] if id == `i'
	replace return_ls_neighborhood_2 = e_b[1,3] if id == `i'
	replace return_ls_wc_2 = e_b[1,4] if id == `i'
	replace return_ls_wn_2 = e_b[1,5] if id == `i'
	replace return_ls_cn_2 = e_b[1,6] if id == `i'
}

drop if scenario != 1
keep id return_w_warmth_2 return_w_control_2 return_w_neighborhood_2 return_w_wc_2 return_w_wn_2 return_w_cn_2 ///
	return_ls_warmth_2 return_ls_control_2 return_ls_neighborhood_2 return_ls_wc_2 return_ls_wn_2 return_ls_cn_2 ///
	correlation_w_ls correlation_log_w_ls correlation_spearman_w_ls

foreach o in w ls {
	foreach x in warmth control neighborhood wc wn cn {
		gen return_`o'_`x'_2_nowin = return_`o'_`x'_2
		sum return_`o'_`x'_2, d
		replace return_`o'_`x'_2 = r(p1) if return_`o'_`x'_2 <= r(p1)
		replace return_`o'_`x'_2 = r(p99) if return_`o'_`x'_2 >= r(p99) & return_`o'_`x'_2 != .
	}
}

foreach o in w ls {
	if "`o'" == "w" local o_string " "
	if "`o'" == "ls" local o_string "LS"
	label var return_`o'_warmth_2 "$ R_w^{`o_string'} $" 
	label var return_`o'_control_2 "$ R_c^{`o_string'} $" 
	label var return_`o'_neighborhood_2 "$ R_n^{`o_string'} $"
	label var return_`o'_wc_2 "$ R_{wc}^{`o_string'} $"
	label var return_`o'_wn_2 "$ R_{wn}^{`o_string'} $"
	label var return_`o'_cn_2 "$ R_{cn}^{`o_string'} $"
}

foreach x in w ls { 
	gen zero_return_`x'_warmth = cond(return_`x'_warmth_2 >= -0.002 & return_`x'_warmth_2 <= 0.002, 1, 0)
	gen zero_return_`x'_control = cond(return_`x'_control_2 >= -0.002 & return_`x'_control_2 <= 0.002, 1, 0)
	gen zero_return_`x'_neighborhood = cond(return_`x'_neighborhood_2 >= -0.002 & return_`x'_neighborhood_2 <= 0.002, 1, 0)
	gen zero_return_`x'_all = cond(zero_return_`x'_warmth + zero_return_`x'_control + zero_return_`x'_neighborhood == 3, 1, 0)
	gen zero_return_`x'_parenting = cond(zero_return_`x'_warmth + zero_return_`x'_control == 2, 1, 0)
}

save "${PATH_OUT_DATA}/estimated_returns.dta", replace

drop correlation_w_ls correlation_log_w_ls correlation_spearman_w_ls
save "${PATH_OUT_DATA}/estimated_returns2.dta", replace

* merge estimated returns to cross-sectional data
use "${PATH_OUT_DATA}/data_crosssection.dta", clear
merge 1:1 id using "${PATH_OUT_DATA}/estimated_returns.dta"
drop _merge
save "${PATH_OUT_DATA}/data_crosssection.dta", replace

* merge estimated returns to cross-sectional data
use "${PATH_OUT_DATA}/data_panel.dta", clear
merge m:1 id using "${PATH_OUT_DATA}/estimated_returns2.dta"
drop _merge
save "${PATH_OUT_DATA}/data_panel.dta", replace

log close