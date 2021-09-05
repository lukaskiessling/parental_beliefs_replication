 // Header do-File with path definitions, those end up in global macros.
include project_paths
log using `"${PATH_OUT_DATA}/log/`1'.log"', replace

clear

use "${PATH_IN_DATA}survey_data.dta", clear

* impute missing values for parenting style measures
egen warmth_rowmean = rowmean(ps_warmth_1 ps_warmth_2 ps_warmth_3)
egen control_rowmean = rowmean(ps_control_1 ps_control_2 ps_control_3 ps_control_4)
forvalues i=1/3 {
	replace ps_warmth_`i' = warmth_rowmean if ps_warmth_`i' == .
}
forvalues i=1/4 {
	replace ps_control_`i' = control_rowmean if ps_control_`i' == .
}
drop warmth_rowmean
drop control_rowmean

* generate PCA-factors of parenting styles
factor ps_warmth_*
rotate
predict ps_warmth_factor
factor ps_control_*
rotate
predict ps_control_factor

gen ps_control_high = cond(ps_control_factor >=0, 1, 0)
gen ps_warmth_high = cond(ps_warmth_factor >=0, 1, 0)

* generate index to define four parenting styles in a different way:
gen ps_warmth_index = (ps_warmth_1 + ps_warmth_2 + ps_warmth_3) / 3
label var ps_warmth_index "Warmth (Index)"
gen ps_control_index = (ps_control_1 + ps_control_2 + ps_control_3 + ps_control_4) / 4
label var ps_control_index "Control (Index)"

gen ps_control_high2 = cond(ps_control_index >=3, 1, 0)
gen ps_warmth_high2 = cond(ps_warmth_index >=3, 1, 0)


* standardize some survey measures
egen altruism_towards_child_std = std(altruism_towards_child)
label var altruism_towards_child_std "Altruism towards child (std.)"

egen paternalism_towards_child_std = std(paternalism_towards_child)
label var paternalism_towards_child_std "Paternalism towards child (std.)"

* recode malleability of skills (scored negatively on a 7-point Likert scale
replace malleability_of_skills = 6 - malleability_of_skills
egen malleability_of_skills_std = std(malleability_of_skills)
label var malleability_of_skills_std "Malleability of skills (std.)"

* subjective neighborhood quality
factor nb_safety nb_goodplace nb_schoolquality
rotate
predict nb_subjective
label var nb_subjective "Neighborhood quality (subj.)"

gen nb_subjective_high = cond(nb_subjective>=0, 1, 0)


* calculate returns to neighborhoods by hand
forvalues i=1/8 {
	gen w`i' = .
	gen ls`i' = .
}
replace w1 = w_exp_1_01
replace w2 = w_exp_1_00
replace w3 = w_exp_1_10
replace w4 = w_exp_1_11
replace w5 = w_exp_0_01
replace w6 = w_exp_0_00
replace w7 = w_exp_0_10
replace w8 = w_exp_0_11
replace ls1 = ls_exp_1_01
replace ls2 = ls_exp_1_00
replace ls3 = ls_exp_1_10
replace ls4 = ls_exp_1_11
replace ls5 = ls_exp_0_01
replace ls6 = ls_exp_0_00
replace ls7 = ls_exp_0_10
replace ls8 = ls_exp_0_11

forvalues i=1/8 {
	gen ln_w`i' = ln(w`i')
	gen ln_ls`i' = ln(ls`i')
}
gen return_w_warmth = ((ln_w3 - ln_w2) + (ln_w4 - ln_w1) + (ln_w7 - ln_w6) + (ln_w8 - ln_w5)) / 4
label var return_w_warmth "$ R_{Warmth} $"
gen return_w_control = ((ln_w1 - ln_w2) + (ln_w4 - ln_w3) + (ln_w5 - ln_w6) + (ln_w8 - ln_w7)) / 4
label var return_w_control "$ R_{Control} $"
gen return_w_neighborhood = ((ln_w1 - ln_w5) + (ln_w2 - ln_w6) + (ln_w3 - ln_w7) + (ln_w4 - ln_w8)) / 4
label var return_w_neighborhood "$ R_{Neighborhood} $"
gen return_ls_warmth = ((ln_ls3 - ln_ls2) + (ln_ls4 - ln_ls3) + (ln_ls7 - ln_ls6) + (ln_ls8 - ln_ls5)) / 4
label var return_ls_warmth "$ R_{Warmth}^{LS} $"
gen return_ls_control = ((ln_ls1 - ln_ls2) + (ln_ls4 - ln_ls3) + (ln_ls5 - ln_ls6) + (ln_ls8 - ln_ls7)) / 4
label var return_ls_control "$ R_{Control}^{LS} $"
gen return_ls_neighborhood = ((ln_ls1 - ln_ls5) + (ln_ls2 - ln_ls6) + (ln_ls3 - ln_ls7) + (ln_ls4 - ln_ls8)) / 4
label var return_ls_neighborhood "$ R_{Neighborhood}^{LS} $"

gen return_w_wc = (ln_w3 + ln_w7 + ln_w2 + ln_w6) - (ln_w1 + ln_w4 + ln_w5 + ln_w8)
label var return_w_wc "$ R_{W,C} $"
gen return_w_wn = (ln_w5 + ln_w7 + ln_w2 + ln_w4) - (ln_w1 + ln_w3 + ln_w6 + ln_w8)
label var return_w_wn "$ R_{W,N} $"
gen return_w_cn = (ln_w2 + ln_w1 + ln_w7 + ln_w8) - (ln_w3 + ln_w4 + ln_w5 + ln_w6)
label var return_w_cn "$ R_{C,N} $"
gen return_ls_wc = (ln_ls3 + ln_ls7 + ln_ls2 + ln_ls6) - (ln_ls1 + ln_ls4 + ln_ls5 + ln_ls8)
label var return_w_wc "$ R_{W,C}^{LS} $"
gen return_ls_wn = (ln_ls5 + ln_ls7 + ln_ls2 + ln_ls4) - (ln_ls1 + ln_ls3 + ln_ls6 + ln_ls8)
label var return_w_wn "$ R_{W,N}^{LS} $"
gen return_ls_cn = (ln_ls2 + ln_ls1 + ln_ls7 + ln_ls8) - (ln_ls3 + ln_ls4 + ln_ls5 + ln_ls6)
label var return_w_cn "$ R_{C,N}^{LS} $"

* winsorize returns
foreach x in w ls {
	foreach d in warmth control neighborhood wc wn cn {
		gen return_`x'_`d'_nowin = return_`x'_`d' 
		sum return_`x'_`d', d
		replace return_`x'_`d' = r(p99) if return_`x'_`d' > r(p99) & return_`x'_`d' != .
		replace return_`x'_`d' = r(p1) if return_`x'_`d' < r(p1) & return_`x'_`d' != .
	}
}

save "${PATH_OUT_DATA}/data_cleaned.dta", replace 

log close