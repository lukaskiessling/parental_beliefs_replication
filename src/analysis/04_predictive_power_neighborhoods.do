include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

set scheme s1mono

set matsize 3000

set seed 12345678

*** predictive power of returns
use "${PATH_OUT_DATA}data_crosssection.dta", clear

* standardize returns for interpretation
foreach dim in warmth control neighborhood {
    foreach dom in w ls {
        regen return_`dom'_`dim'_2 = std(return_`dom'_`dim'_2), replace
    }
}

* ORIV
expand 2, generate(replicant)
gen return_warmth = return_w_warmth_2 if replicant == 0
replace return_warmth = return_ls_warmth_2 if replicant == 1
gen return_warmth_instrument = return_ls_warmth_2 if replicant == 0
replace return_warmth_instrument = return_w_warmth_2 if replicant == 1

gen return_control = return_w_control_2 if replicant == 0
replace return_control = return_ls_control_2 if replicant == 1
gen return_control_instrument = return_ls_control_2 if replicant == 0
replace return_control_instrument = return_w_control_2 if replicant == 1

gen return_neighborhood = return_w_neighborhood_2 if replicant == 0
replace return_neighborhood = return_ls_neighborhood_2 if replicant == 1
gen return_neighborhood_instrument = return_ls_neighborhood_2 if replicant == 0
replace return_neighborhood_instrument = return_w_neighborhood_2 if replicant == 1

forvalues x=0/1 {
    gen constant_`x' = replicant == `x'
}

* ORIV regressions for splits based on sociodemographic variables
sum hh_income_log, d
gen high_income = cond(hh_income_log >= `r(mean)', 1, 0)

foreach splitvar in high_income single_parent college_degree {
	local xvars_high_income female age white college_degree employment_all single_parent num_children_total2 gender_composition
	local xvars_college_degree female age white employment_all hh_income_log single_parent num_children_total2 gender_composition
	local xvars_single_parent female age white college_degree employment_all hh_income_log num_children_total2 gender_composition
	
	global xvars `xvars_`splitvar''
	
	foreach high in 0 1 {
		ivregress 2sls ps_warmth_factor (return_warmth return_control = return_warmth_instrument return_control_instrument) $xvars constant_* if `splitvar' == `high', vce(bootstrap, reps(1000)) nocons
		matrix c_w_`splitvar'_`high' = e(b)
		matrix v_w_`splitvar'_`high' = e(V)
		estadd local return_string "IV"
		estadd local controls "Yes"
		estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
		estadd local observations = e(N)/2
		eststo ps_w_`splitvar'_`high'
		
		ivregress 2sls ps_control_factor (return_control return_warmth = return_control_instrument return_warmth_instrument) $xvars constant_* if `splitvar' == `high', vce(bootstrap, reps(1000)) nocons
		matrix c_c_`splitvar'_`high' = e(b)
		matrix v_c_`splitvar'_`high' = e(V)
		estadd local return_string "IV"
		estadd local controls "Yes"
		estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
		estadd local observations = e(N)/2
		eststo ps_c_`splitvar'_`high'
		
		ivregress 2sls nb_subjective (return_neighborhood = return_neighborhood_instrument) $xvars constant_* if `splitvar' == `high', vce(bootstrap, reps(1000)) nocons
		matrix c_s_`splitvar'_`high' = e(b)
		matrix v_s_`splitvar'_`high' = e(V)
		estadd local return_string "IV"
		estadd local controls "Yes"
		estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
		estadd local observations = e(N)/2
		eststo subj_`splitvar'_`high'
		
		ivregress 2sls neighborhood_quality_1 (return_neighborhood = return_neighborhood_instrument) $xvars constant_* if `splitvar' == `high', vce(bootstrap, reps(1000)) nocons
		matrix c_f1_`splitvar'_`high' = e(b)
		matrix v_f1_`splitvar'_`high' = e(V)
		estadd local return_string "IV"
		estadd local controls "Yes"
		estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
		estadd local observations = e(N)/2
		eststo fact1_`splitvar'_`high'
		
		ivregress 2sls neighborhood_quality_2 (return_neighborhood = return_neighborhood_instrument) $xvars constant_* if `splitvar' == `high', vce(bootstrap, reps(1000)) nocons
		matrix c_f2_`splitvar'_`high' = e(b)
		matrix v_f2_`splitvar'_`high' = e(V)
		estadd local return_string "IV"
		estadd local controls "Yes"
		estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
		estadd local observations = e(N)/2
		eststo fact2_`splitvar'_`high'
	}
}

gen high_income_0 = 0
label var high_income_0 "Below-median income"
gen high_income_1 = 0
label var high_income_1 "Above-median income"

gen single_parent_0 = 0
label var single_parent_0 "Two-parent household"
gen single_parent_1 = 0
label var single_parent_1 "Single-parent household"

gen college_degree_0 = 0
label var college_degree_0 "Not college educated"
gen college_degree_1 = 0
label var college_degree_1 "College educated"

** fill in parameters from splits to construct the figure
foreach spec in w c s f1 f2 {
	* initialize matrices
	matrix coefs = J(1,4,.)
	matrix var = J(4,4,0)
	
	* high income
	matrix coefs[1,1] = c_`spec'_high_income_0[1,1]
	matrix var[1,1] = v_`spec'_high_income_0[1,1]
	matrix coefs[1,2] = c_`spec'_high_income_1[1,1]
	matrix var[2,2] = v_`spec'_high_income_1[1,1]

	* single_parent
	matrix coefs[1,3] = c_`spec'_single_parent_1[1,1]
	matrix var[3,3] = v_`spec'_single_parent_1[1,1]
	matrix coefs[1,4] = c_`spec'_single_parent_0[1,1]
	matrix var[4,4] = v_`spec'_single_parent_0[1,1]

	* initialize correct names
	matrix rownames coefs = y1
	matrix colnames coefs = high_income_0 high_income_1 single_parent_1 single_parent_0
	matrix colnames var = high_income_0 high_income_1 single_parent_1 single_parent_0
	matrix rownames var = high_income_0 high_income_1 single_parent_1 single_parent_0
		
	ereturn post coefs var
	eststo est_hetero_`spec'
}

coefplot ///
	(est_hetero_w) , bylabel("Warmth (std.)") ///
	|| (est_hetero_c), bylabel("Control (std.)") ///
	|| , xline(0) coeflabels(, wrap(14) labsize(*1.2)) xsize(1.5) ysize(1) ///
		headings(high_income_0 = "{bf:A. Financial constraints}" ///
			single_parent_1 = "{bf:B. Personal constraints}") ///
		byopts(col(2) xrescale) xlabel(, labsize(*1.2)) ///
		levels(99 95 90) ciopts(lwidth(*6 *8 *10) lcolor(*.3 *.5 *.7)) ///
		legend(order(1 "99" 2 "95" 3 "90") rows(1)) msize(*1.2) mcolor(black)
addplot 1: , b1title("Standardized coefficient on") norescaling
addplot 1: , b2title("perceived return to warmth") norescaling
addplot 2: , b1title("Standardized coefficient on") norescaling
addplot 2: , b2title("perceived return to control") norescaling
graph export "${PATH_OUT_FIGURES}/predictive_power_ps_hetero.pdf", as(pdf) replace

coefplot ///
	(est_hetero_s), bylabel(`""Subjective neighborhood quality""') ///
	|| (est_hetero_f1), bylabel(`""Economic conditions""') ///
	|| (est_hetero_f2), bylabel(`""Segregation""') ///
	|| , xline(0) coeflabels(, wrap(14) labsize(*1.2)) xsize(2) ysize(1) ///
		headings(high_income_0 = "{bf:A. Financial constraints}" ///
			single_parent_1 = "{bf:B. Personal constraints}") ///
		byopts(col(3) xrescale) xlabel(, labsize(*1.2)) ///
		levels(99 95 90) ciopts(lwidth(*6 *8 *10) lcolor(*.3 *.5 *.7)) ///
		legend(order(1 "99" 2 "95" 3 "90") rows(1)) msize(*1.2) mcolor(black)
addplot 1: , b1title("Standardized coefficient on") norescaling
addplot 1: , b2title("perceived return to neighborhoods") norescaling
addplot 2: , b1title("Standardized coefficient on") norescaling
addplot 2: , b2title("perceived return to neighborhoods") norescaling
addplot 3: , b1title("Standardized coefficient on") norescaling
addplot 3: , b2title("perceived return to neighborhoods") norescaling
graph export "${PATH_OUT_FIGURES}/predictive_power_nb_hetero.pdf", as(pdf) replace


log close