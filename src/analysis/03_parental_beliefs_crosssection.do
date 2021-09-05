include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

set matsize 3000

set seed 12345678

global parental_characteristics female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition
global child_characteristics target_female target_age birthorder
global parental_prefs altruism_towards_child_std paternalism_towards_child_std malleability_of_skills_std

use "${PATH_OUT_DATA}data_crosssection.dta", clear 

foreach x in w ls {
    if "`x'" == "w" local return_w "$ R_{\text{warmth},i} $"
    if "`x'" == "w" local return_c "$ R_{\text{control},i} $"
    if "`x'" == "w" local return_n "$ R_{\text{neighb.},i} $"
    if "`x'" == "ls" local return_w "$ R_{\text{warmth},i}^{LS} $"
    if "`x'" == "ls" local return_c "$ R_{\text{control},i}^{LS} $"
    if "`x'" == "ls" local return_n "$ R_{\text{neighb.},i}^{LS} $"
    
    foreach dim in w c n {
        use "${PATH_OUT_DATA}data_crosssection.dta", clear 

        if "`dim'" == "w" local dim2 "warmth"
        if "`dim'" == "c" local dim2 "control"
        if "`dim'" == "n" local dim2 "neighborhood"

        sum return_`x'_`dim2'_2, d
        local mean_return = round(`r(mean)', .01)
        local mean_return: di %3.2f `mean_return'
        reg return_`x'_`dim2'_2 $parental_characteristics, cluster(id)
        estadd local controls "Yes"
        eststo return_`x'_`dim'_1
        estadd scalar sample_mean = `mean_return'
        testparm (age white college_degree hh_income_log single_parent num_children_total2 gender_composition)
        reg return_`x'_`dim2'_2 female age immigrant white $parental_prefs, cluster(id)
        estadd local controls "Yes"
        eststo return_`x'_`dim'_2
        estadd scalar sample_mean = `mean_return'
        reg return_`x'_`dim2'_2 $parental_characteristics $parental_prefs, cluster(id)
        estadd scalar sample_mean = `mean_return'
        testparm ($parental_characteristics)
        local test_stat = floor(100*round(`r(p)', 0.01))/100
        if `r(p)' == 0 {
            local test_stat "<0.01"
            di %6.2f `test_stat'
        }
        else if `test_stat' == 1 {
            local test_stat "1.00"
            di %6.2f `test_stat'
        }
        else {
            local test_stat "`test_stat'"
            di %6.2f `test_stat'
        }

        estadd local test_parental_char = `test_stat'
        testparm ($parental_prefs)
        estadd local test_parental_prefs = `test_stat'
        estadd local controls "Yes"
        eststo return_`x'_`dim'_3
        testparm (age white college_degree hh_income_log single_parent num_children_total2 gender_composition)
    }

    use "${PATH_OUT_DATA}data_panel.dta", clear
    * for table header
    if "`x'" == "w" local x2 "y_{ij}"
    if "`x'" == "ls" local x2 "ls_{ij}"

    reg ln_`x' warmth_control_neighborhood, cluster(id)
    matrix coefs = e(b)
    local mean_return = coefs[1,1]
    local mean_return: di %3.2f `mean_return'

    reg ln_`x' $parental_characteristics, cluster(id)
    eststo return_panel_`x'

    esttab return_panel_`x' return_`x'_w_1  return_`x'_c_1 return_`x'_n_1  ///
        using `"${PATH_OUT_TABLES}returns_`x'_production.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label  booktabs nonotes ///
        mtitles("$ \ln(`x2') $" "`return_w'" "`return_c'" "`return_n'") nodepvars nogaps ///
        mgroups("Levels" "Perceived Returns", ///
        pattern(1 1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) substitute(\_ _) ///
        stats(sample_mean N r2, fmt(%04.3f %18.0g %04.3f) labels("Average return" "Observations" "\(R^2\)")) drop(_cons)
    
    esttab return_`x'_w_3 return_`x'_c_3 return_`x'_n_3 ///
        using `"${PATH_OUT_TABLES}returns_`x'_parvalues.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label  booktabs nonotes ///
        mtitles("`return_w'" "`return_c'" "`return_n'") nodepvars nogaps ///
        mgroups("Perceived Returns", ///
        pattern(1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) substitute(\_ _) ///
        stats(sample_mean controls N r2, fmt(%04.3f str %18.0g %04.3f) labels("Average return" "Sociodemographic controls" `"Individuals"' "\(R^2\)")) drop(_cons $parental_characteristics)
    
    esttab return_`x'_w_1  return_`x'_c_1 return_`x'_n_1 return_`x'_w_3 return_`x'_c_3 return_`x'_n_3 ///
        using `"${PATH_OUT_TABLES}returns_`x'_2.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label  booktabs nonotes ///
        mtitles("`return_w'" "`return_c'" "`return_n'" "`return_w'" "`return_c'" "`return_n'") nodepvars nogaps ///
        refcat(female "\emph{Sociodemographic characteristics}" altruism_towards_child_std "\emph{Parenting values}", nolabel) ///    
        mgroups("(A) only sociodemographics" "(B) incl. parenting values", ///
        pattern(1 0 0 1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) substitute(\_ _) ///
        stats(sample_mean N r2, fmt(%04.3f %18.0g %04.3f) labels("Average return" `"Individuals"' "\(R^2\)")) drop(_cons)
    
    foreach dim in w c n {
        use "${PATH_OUT_DATA}data_crosssection.dta", clear 

        if "`dim'" == "w" local dim2 "warmth"
        if "`dim'" == "c" local dim2 "control"
        if "`dim'" == "n" local dim2 "neighborhood"
     
        * check what predicts zero returns
        sum zero_return_`x'_`dim2', d
        local mean_return = round(`r(mean)', .01)
        reg zero_return_`x'_`dim2' $parental_characteristics $parental_prefs, r
        eststo zeroret_`x'_`dim'
        estadd scalar sample_mean = `mean_return'

        * exclude those with zero returns
        sum return_`x'_`dim2' if zero_return_`x'_`dim2' == 0, d
        local mean_return = round(`r(mean)', .01)
        reg return_`x'_`dim2'_2 $parental_characteristics $parental_prefs if zero_return_`x'_`dim2' == 0, r
        eststo return_`x'_`dim'_z1
        estadd scalar sample_mean = `mean_return'

        if "`dim'" != "n" {
            sum return_`x'_`dim2' if zero_return_`x'_parenting == 0, d
            local mean_return = round(`r(mean)', .01)
            reg return_`x'_`dim2'_2 $parental_characteristics $parental_prefs if zero_return_`x'_parenting == 0, r
            eststo return_`x'_`dim'_z2
            estadd scalar sample_mean = `mean_return'            
        }
    }

    use "${PATH_OUT_DATA}data_crosssection.dta", clear 
    * check what predicts zero returns: parenting only
    sum zero_return_`x'_parenting, d
    local mean_return = round(`r(mean)', .01)
    reg zero_return_`x'_parenting $parental_characteristics $parental_prefs, r
    eststo zeroret_`x'_par
    estadd scalar sample_mean = `mean_return'
    * check what predicts zero returns: all returns
    sum zero_return_`x'_all, d
    local mean_return = round(`r(mean)', .01)
    reg zero_return_`x'_all $parental_characteristics $parental_prefs, r
    eststo zeroret_`x'_all
    estadd scalar sample_mean = `mean_return'

    esttab zeroret_`x'_par zeroret_`x'_n zeroret_`x'_all return_`x'_w_z2 return_`x'_c_z2 return_`x'_n_z1 ///
        using `"${PATH_OUT_TABLES}zero_returns_`x'_2.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label  booktabs nonotes ///
        mtitles("Parenting" "Neighb." "All" "`return_w'" "`return_c'" "`return_n'") nodepvars nogaps ///
        refcat(female "\emph{Sociodemographic characteristics}" altruism_towards_child_std "\emph{Parenting values}", nolabel) ///    
        mgroups("(A) Zero returns" "(B) Returns excluding zeros", ///
        pattern(1 0 0 1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) substitute(\_ _) ///
        stats(sample_mean N r2, fmt(%04.3f %18.0g %04.3f) labels("Mean of dependent variable" `"Individuals"' "\(R^2\)")) drop(_cons)
}


set scheme s1mono
*** distributions of returns
use "${PATH_OUT_DATA}data_crosssection.dta", clear
* generate winsorized returns for plots only
gen return_w_warmth_2b = return_w_warmth_2
gen return_w_control_2b = return_w_control_2
gen return_w_neighborhood_2b = return_w_neighborhood_2
replace return_w_warmth_2b = -0.75 if return_w_warmth_2b < -0.75
replace return_w_control_2b = -0.75 if return_w_control_2b < -0.75
replace return_w_neighborhood_2b = -0.75 if return_w_neighborhood_2b < -0.75  
replace return_w_warmth_2b = 1.25 if return_w_warmth_2b > 1.25 & return_w_warmth_2b != .
replace return_w_control_2b = 1.25 if return_w_control_2b > 1.25 & return_w_control_2b != .
replace return_w_neighborhood_2b = 1.25 if return_w_neighborhood_2b > 1.25 & return_w_neighborhood_2b != .
distplot return_w_warmth_2b return_w_control_2b return_w_neighborhood_2b, ///
    graphregion(color(white)) bgcolor(white) xlabel(-.75(0.25)1.25, labsize(medlarge)) ylabel(0(0.25)1, labsize(medlarge) glcolor(gs14)) ///
    xline(0, lcolor(black)) xtitle("Perceived returns for child's wage at age 30", size(medlarge) height(5)) ytitle("Cumulative probability", size(medlarge)) xlabel(, labsize(medlarge)) ///
    legend(off) ///
    lcolor(gs5 gs5 gs5) lwidth(thick thick thick) lpattern(shortdash dash solid) xsize(1.25) ysize(1)
graph export "${PATH_OUT_FIGURES}cdf_returns_w_2.pdf", as(pdf) replace

foreach domain in warmth control neighborhood {
    if "`domain'" == "warmth" local domainstring "warmth"
    if "`domain'" == "control" local domainstring "control"
    if "`domain'" == "neighborhood" local domainstring "neighborhoods"

    ttest return_w_`domain'_2, by(female)
    local p_ttest = floor(1000*round(`r(p)', 0.001))/1000
    display "p_ttest: `p_ttest'"
    if `r(p)' < 0.001 {
            local p_ttest "<.001"
        }
        else {
            local p_ttest "`p_ttest'"
            di %6.3f `p_ttest'
        }
    display "p_ttest: `p_ttest'"
    
    ksmirnov return_w_`domain'_2, by(female)
    local p_kstest = floor(1000*round(`r(p)', 0.001))/1000
    display "p_kstest: `p_kstest'"
    
    if `p_kstest' < 0.001 {
            local p_kstest "<.001"
        }
        else {
            local p_kstest "`p_kstest'"
            di %6.3f `p_kstest'
        }
    display "p_kstest: `p_kstest'"

    distplot return_w_`domain'_2b, over(female) ///
        graphregion(color(white)) bgcolor(white) xlabel(-.75(0.25)1.25, labsize(medlarge)) ///
        xline(0, lcolor(black)) xtitle("Perceived returns to `domainstring' for child's wage at age 30", size(medlarge) height(5)) ytitle("Cumulative probability", size(medlarge)) ///
        legend(off) text(0.1 0.8 "p-value t-test: `p_ttest'" "p-value KS-test: `p_kstest'", just(left) size(medlarge)) ylabel(0(0.25)1, labsize(medlarge) glcolor(gs14)) ///
        lcolor(midblue*0.6 cranberry) lwidth(thick thick) lpattern(dash solid) xsize(1.25) ysize(1)
    graph export "${PATH_OUT_FIGURES}cdf_returns_w_`domain'_2_gender.pdf", as(pdf) replace
}

* correlation table
use "${PATH_OUT_DATA}data_crosssection.dta", clear
label var zero_return_w_warmth "$ R_{\text{warmth},i} $"
label var zero_return_w_control "$ R_{\text{control},i} $"
label var zero_return_w_neighborhood "$ R_{\text{neighb.},i} $"

estpost correlate zero_return_w_warmth zero_return_w_control zero_return_w_neighborhood, matrix listwise
eststo correlations_returns

esttab correlations_returns ///
    using `"${PATH_OUT_TABLES}zeroreturns_w_correlations.tex"', ///
    replace unstack noobs nonum not ///
    nobaselevels ///
    b(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label nonotes booktabs ///
    nodepvars nogaps nomtitle substitute(\_ _)

* correlation table for zero returns
use "${PATH_OUT_DATA}data_crosssection.dta", clear
label var zero_return_ls_warmth "Warmth"
label var zero_return_ls_control "Control"
label var zero_return_ls_neighborhood "Neighb."
		
estpost correlate zero_return_ls_warmth zero_return_ls_control zero_return_ls_neighborhood, matrix listwise
eststo correlations_returns

esttab correlations_returns ///
    using `"${PATH_OUT_TABLES}zeroreturns_ls_correlations.tex"', ///
    replace unstack noobs nonum not ///
    nobaselevels ///
    b(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label nonotes booktabs ///
    nodepvars nogaps nomtitle substitute(\_ _)

reg return_ls_warmth_2 return_w_warmth_2, r
matrix table = r(table)
local slope_b: di %3.2f table[1,1]
display "`slope_b'"
local slope_se: di %3.2f table[2,1]
display "`slope_se'"
sum return_ls_warmth_2 return_w_warmth_2
twoway (scatter return_ls_warmth_2 return_w_warmth_2, mcolor(gs10%30)) ///
	(lfit return_ls_warmth_2 return_w_warmth_2, lwidth(thick) lcolor(black)), ///
	xsize(1) ysize(1) xlabel(-0.5(0.5)1.5) xscale(r(-0.7 1.5)) ///
	ylabel(-1(0.5)2) yscale(r(-0.7 1.2)) legend(off) ///
	xtitle("Perceived return to warmth" "(earnings domain)") ///
	ytitle("Perceived return to warmth" "(life satisfaction domain)") ///
	text(-0.85 1.05 "Slope: `slope_b' (`slope_se')", just(left))
graph export "${PATH_OUT_FIGURES}corr_returns_ind_warmth.pdf", as(pdf) replace
graph export "${PATH_OUT_FIGURES}corr_returns_ind_warmth.png", as(png) replace

reg return_ls_control_2 return_w_control_2, r
matrix table = r(table)
local slope_b: di %3.2f table[1,1]
display "`slope_b'"
local slope_se: di %3.2f table[2,1]
display "`slope_se'"
sum return_ls_control_2 return_w_control_2
twoway (scatter return_ls_control_2 return_w_control_2, mcolor(gs10%30)) ///
	(lfit return_ls_control_2 return_w_control_2, lwidth(thick) lcolor(black)), ///
	xsize(1) ysize(1) xlabel(-1(0.5)1) xscale(r(-0.7 1)) ///
	ylabel(-1(0.5)1) yscale(r(-0.7 1.2)) legend(off) ///
	xtitle("Perceived return to control" "(earnings domain)") ///
	ytitle("Perceived return to control" "(life satisfaction domain)") ///
	text(-1.1 0.6 "Slope: `slope_b' (`slope_se')", just(left))
graph export "${PATH_OUT_FIGURES}corr_returns_ind_control.pdf", as(pdf) replace
graph export "${PATH_OUT_FIGURES}corr_returns_ind_control.png", as(png) replace

reg return_ls_neighborhood_2 return_w_neighborhood_2, r
matrix table = r(table)
local slope_b: di %3.2f table[1,1]
display "`slope_b'"
local slope_se: di %3.2f table[2,1]
display "`slope_se'"
sum return_ls_neighborhood_2 return_w_neighborhood_2
twoway (scatter return_ls_neighborhood_2 return_w_neighborhood_2, mcolor(gs10%30)) ///
	(lfit return_ls_neighborhood_2 return_w_neighborhood_2, lwidth(thick) lcolor(black)), ///
	xsize(1) ysize(1) xlabel(-1(0.5)1.5) xscale(r(-0.8 1.3)) ///
	ylabel(-1(0.5)2) yscale(r(-1 1.6)) legend(off) ///
	xtitle("Perceived return to neighborhoods" "(earnings domain)") ///
	ytitle("Perceived return to neighborhoods" "(life satisfaction domain)") ///
	text(-1 1.12 "Slope: `slope_b' (`slope_se')", just(left))
graph export "${PATH_OUT_FIGURES}corr_returns_ind_neighborhood.pdf", as(pdf) replace
graph export "${PATH_OUT_FIGURES}corr_returns_ind_neighborhood.png", as(png) replace


*** predictive power of returns
use "${PATH_OUT_DATA}data_crosssection.dta", clear

foreach dim in warmth control neighborhood {
    foreach dom in w ls {
        regen return_`dom'_`dim'_2 = std(return_`dom'_`dim'_2), replace
    }
}

foreach x in w ls {
    if "`x'" == "w" local x2 "exp. wages"
    if "`x'" == "ls" local x2 "exp. LS"
    gen return_warmth = return_`x'_warmth_2
    gen return_control = return_`x'_control_2
    gen return_neighborhood = return_`x'_neighborhood_2
    reg ps_warmth_factor return_warmth $parental_characteristics, vce(bootstrap, reps(1000))
    estadd local return_string `x2'
    estadd local controls "Yes"
    estadd local observations "`e(N)'"
    eststo warmth_`x'
    reg ps_control_factor return_control $parental_characteristics, vce(bootstrap, reps(1000))
    estadd local return_string `x2'
    estadd local controls "Yes"
    estadd local observations "`e(N)'"
    eststo control_`x'
    reg nb_subjective return_neighborhood $parental_characteristics, vce(bootstrap, reps(1000))
    estadd local return_string `x2'
    estadd local controls "Yes"
    estadd local observations "`e(N)'"
    eststo neighborhood_`x'

    drop return_warmth return_control return_neighborhood
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

ivregress 2sls ps_warmth_factor (return_warmth = return_warmth_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)),0.001)
estadd local controls "Yes"
estadd local observations = e(N)/2
eststo warmth_oriv
ivregress 2sls ps_warmth_factor (return_warmth return_control = return_warmth_instrument return_control_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)),0.001)
estadd local controls "Yes"
estadd local observations = e(N)/2
eststo warmth_oriv2
ivregress 2sls ps_control_factor (return_control = return_control_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
estadd local controls "Yes"
estadd local observations = e(N)/2
eststo control_oriv
ivregress 2sls ps_control_factor (return_warmth return_control = return_warmth_instrument return_control_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd local controls "Yes"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)),0.001)
estadd local observations = e(N)/2
eststo control_oriv2
ivregress 2sls nb_subjective (return_neighborhood = return_neighborhood_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd local controls "Yes"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
estadd local observations = e(N)/2
eststo nb_subjective_oriv
ivregress 2sls neighborhood_quality_1 (return_neighborhood = return_neighborhood_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd local controls "Yes"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
estadd local observations = e(N)/2
eststo nb_factor_1_oriv
ivregress 2sls neighborhood_quality_2 (return_neighborhood = return_neighborhood_instrument) $parental_characteristics constant_*, vce(bootstrap, reps(1000)) nocons
estadd local return_string "IV"
estadd local controls "Yes"
estadd scalar r2 = round(1-e(rss)/(e(rss)+e(mss)), 0.001)
estadd local observations = e(N)/2
eststo nb_factor_2_oriv

*** all in one table
* create empty column
reg ps_warmth_factor
matrix b = e(b)
ereturn post b
eststo empty


cap file close table_out
qui file open table_out using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', write replace
file write table_out "{" _n
file write table_out "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write table_out "\begin{tabular}{l*{5}{c}}" _n
file write table_out "\toprule" _n
file write table_out "\multicolumn{6}{l}{\textit{A. Predictive power of perceived returns for warmth dimension of parenting styles}} \\" _n
file write table_out "&& \multicolumn{4}{c}{Warmth (std.)} \\\cmidrule(lr){3-6}" _n
file write table_out "&& (1) & (2) & (3) & (4) \\" _n
file write table_out "&& \begin{tabular}{c}Expected\\ earnings\end{tabular} & \begin{tabular}{c}Expected\\ life satis.\end{tabular} & \begin{tabular}{c}IV\end{tabular} & \begin{tabular}{c}IV\end{tabular} \\" _n
file close table_out

esttab empty warmth_w warmth_ls warmth_oriv warmth_oriv2 ///
    using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', ///
    append frag ///
    nobaselevels ///
    b(%4.3f) se(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label  booktabs nonotes nomtitles nonumbers nodepvar ///
    varlabel(return_warmth "$ R_{\text{warmth},i} $ (std.)" return_control "$ R_{\text{control},i} $ (std.)" ) ///
    stats(N r2, fmt( %18.0g %04.3f) labels("Observations" "\(R^2\)")) drop(_cons constant_0 constant_1 female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition) ///
    substitute(\_ _) 

qui file open table_out using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', write append
file write table_out "\midrule" _n
file write table_out "\multicolumn{6}{l}{\textit{B. Predictive power of perceived returns for control dimension of parenting styles}} \\" _n
file write table_out "&& \multicolumn{4}{c}{Control (std.)} \\\cmidrule(lr){3-6}" _n
file write table_out "&& (1) & (2) & (3) & (4) \\" _n
file write table_out "&& \begin{tabular}{c}Expected\\ earnings\end{tabular} & \begin{tabular}{c}Expected\\ life satis.\end{tabular} & \begin{tabular}{c}IV\end{tabular} & \begin{tabular}{c}IV\end{tabular} \\" _n
file close table_out

esttab empty control_w control_ls control_oriv control_oriv2 ///
    using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', ///
    append frag ///
    nobaselevels ///
    b(%4.3f) se(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label  booktabs nonotes nomtitles nonumbers nodepvar ///
    varlabel(return_warmth "$ R_{\text{warmth},i} $ (std.)" return_control "$ R_{\text{control},i} $ (std.)" ) ///
    stats(N r2, fmt(%18.0g %04.3f) labels("Observations" "\(R^2\)")) drop(_cons constant_0 constant_1 female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition) ///
    substitute(\_ _) 

qui file open table_out using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', write append
file write table_out "\midrule" _n
file write table_out "\multicolumn{6}{l}{\textit{C. Predictive power of perceived returns for neighborhood quality}} \\" _n
file write table_out "& \multicolumn{3}{c}{Subjective neighborhood quality (std.)} & \begin{tabular}{c}Economic\\conditions\end{tabular} & \begin{tabular}{c}Segre-\\ gation\end{tabular} \\\cmidrule(lr){2-4}\cmidrule(lr){5-5}\cmidrule(lr){6-6}" _n
file write table_out "& (1) & (2) & (3) & (4) & (5) \\" _n
file write table_out "& \begin{tabular}{c}Expected\\ earnings\end{tabular} & \begin{tabular}{c}Expected\\ life satis.\end{tabular} & \begin{tabular}{c}IV\end{tabular} & \begin{tabular}{c}IV\end{tabular} & \begin{tabular}{c}IV\end{tabular} \\" _n
file close table_out

esttab neighborhood_w neighborhood_ls nb_subjective_oriv nb_factor_1_oriv nb_factor_2_oriv ///
    using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', ///
    append frag ///
    nobaselevels ///
    b(%4.3f) se(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label  booktabs nonotes nomtitles nonumbers nodepvar ///
    varlabel(return_neighborhood "$ R_{\text{neighb.},i} $ (std.)") ///
    stats(N r2, fmt(%18.0g %04.3f) labels("Observations" "\(R^2\)")) drop(_cons constant_0 constant_1 female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition) ///
    substitute(\_ _) 
	
qui file open table_out using `"${PATH_OUT_TABLES}predictive_power_returns2.tex"', write append
file write table_out "\bottomrule" _n
file write table_out "\end{tabular}" _n
file write table_out "}" _n
file close table_out


** ORIV for individual-level determinants of perceived returns
matrix define coefficients = J(12,3,.)
matrix define standarderrors = J(12,3,.)
matrix define pvalues = J(12,3,.)

rename altruism_towards_child_std altruism
rename paternalism_towards_child_std paternalism
rename malleability_of_skills_std malleability

local i = 0
foreach dim in warmth control neighborhood {
    local j = 0
    local i = `i' + 1
    
    foreach det in female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability {
        * counter
        local j = `j'+1
        * define control variables
        local controls_female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability
        local controls_age female white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability
        local controls_white female age college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability
        local controls_college_degree female age white employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability
        local controls_employment_all female age white college_degree hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability
        local controls_hh_income_log female age white college_degree employment_all single_parent num_children_total2 gender_composition altruism paternalism malleability
        local controls_single_parent female age white college_degree employment_all hh_income_log num_children_total2 gender_composition altruism paternalism malleability
        local controls_num_children_total2 female age white college_degree employment_all hh_income_log single_parent gender_composition altruism paternalism malleability
        local controls_gender_composition female age white college_degree employment_all hh_income_log single_parent num_children_total2 altruism paternalism malleability
        local controls_altruism female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition paternalism malleability
        local controls_paternalism female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism malleability
        local controls_malleability female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism
        ivregress 2sls `det' (return_`dim' = return_`dim'_instrument) `controls_`det'' constant_*, vce(bootstrap, reps(1000)) nocons
        matrix e_b = e(b)
        matrix e_se = e(se)
        matrix coefficients[`j',`i'] = _b[return_`dim'] 
        matrix standarderrors[`j',`i'] = _se[return_`dim'] 
        matrix pvalues[`j',`i'] = (2*(normal(-(_b[return_`dim']/_se[return_`dim']))))
    }
}

cap file close table_out
qui file open table_out using `"${PATH_OUT_TABLES}determinants_oriv.tex"', write replace
file write table_out "{" _n
file write table_out "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write table_out "\begin{tabular}{l*{3}{c}}" _n
file write table_out "\toprule" _n
file write table_out "&\multicolumn{3}{c}{Coefficients on perc. returns} \\\cmidrule(lr){2-4}" _n
file write table_out "& (1) & (2) & (3) \\" _n
file write table_out "& $ R_{\text{warmth},i} $ & $ R_{\text{control},i} $ & $ R_{\text{neighb.},i} $ \\\midrule" _n
file write table_out "\textit{Sociodemographic characteristics} & & & \\" _n
local j = 0
foreach det in female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition altruism paternalism malleability {
    * counter
    local j = `j'+1
    
    local varlabel_female "Female"
    local varlabel_age "Age"
    local varlabel_white "White"
    local varlabel_college_degree "College degree"
    local varlabel_employment_all "Employed"
    local varlabel_hh_income_log "log(Household income)"
    local varlabel_single_parent "Single parent"
    local varlabel_num_children_total2 "Number of children"
    local varlabel_gender_composition "Share of female children"
    local varlabel_altruism "Altruism towards child (std.)"
    local varlabel_paternalism "Paternalism towards child (std.)"
    local varlabel_malleability "Malleability of skills (std.)"

    if `j' == 10 {
        file write table_out "\textit{Parenting values} & & & \\" _n
    }

    file write table_out "`varlabel_`det'' "
    forvalues i = 1/3 {
        local coef: di %4.3f coefficients[`j',`i']
        file write table_out "& `coef'"
        local star " "
        if pvalues[`j',`i'] < 0.10 {
            local star "*"
        }
        if pvalues[`j',`i'] < 0.05 {
            local star "`star'*"
        }
        if pvalues[`j',`i'] < 0.01 {
            local star "`star'*"
        }
        file write table_out "$^{`star'}$"
    }
    file write table_out "\\" _n
    forvalues i = 1/3 {
        local stderr: di %4.3f standarderrors[`j',`i']
        file write table_out "& (`stderr') "
    }
    file write table_out "\\" _n
    
}

file write table_out "\bottomrule" _n
file write table_out "\end{tabular}" _n
file write table_out "}" _n
file close table_out


*** relationship of returns in wage and life satisfaction domain
use "${PATH_OUT_DATA}data_crosssection.dta", clear

local dimensions warmth control neighborhood
foreach d in `dimensions' {
    if "`d'" == "warmth" local d2 "w"
    if "`d'" == "control" local d2 "c"
    if "`d'" == "neighborhood" local d2 "n"
        if "`d'" == "warmth" local d3 "warmth"
    if "`d'" == "control" local d3 "control"
    if "`d'" == "neighborhood" local d3 "neighb."
    * use estimated returns
    label var return_w_`d'_2 "$ R_{`d3',i} $"
    reg return_ls_`d'_2 return_w_`d'_2, r
    estadd local controls "No"
    eststo return_rel_`d'_2
    reg return_ls_`d'_2 return_w_`d'_2 $parental_characteristics, r
    estadd local controls "Yes"
    eststo return_rel_`d'_c_2
}


esttab return_rel_warmth_2 return_rel_warmth_c_2 return_rel_control_2 return_rel_control_c_2 return_rel_neighborhood_2 return_rel_neighborhood_c_2 ///
    using `"${PATH_OUT_TABLES}return_relationships_w_ls_2.tex"', ///
    replace  ///
    nobaselevels ///
    b(%4.3f) se(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label  booktabs nonotes ///
    nomtitles nodepvars nogaps ///
    order(return_w_warmth_2 return_w_control_2 return_w_neighborhood_2) ///
    mgroups("$ R_{\text{warmth},i}^{LS} $" "$ R_{\text{control},i}^{LS} $" "$ R_{\text{neighb.},i}^{LS} $", ///
    pattern(1 0 1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))  ///
    stats(controls N r2, fmt(str %18.0g %04.3f) labels("Controls" `"Individuals"' "\(R^2\)")) drop(_cons female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition) ///
    substitute(\_ _)


** figures and tables to construct parenting style factors
use "${PATH_OUT_DATA}data_crosssection.dta", clear
factor ps_warmth_1 ps_warmth_2 ps_warmth_3 ps_control_1 ps_control_2 ps_control_3 ps_control_4
screeplot, xtitle("Number of factors", size(medlarge)) ytitle(, size(medlarge)) ylabel(,glcolor(gs14) labsize(medlarge)) title("") xlabel(0(1)8, labsize(medlarge)) lwidth(medthick) mcolor(black) lcolor(black) yline(1, lcolor(black%70))
graph export "${PATH_OUT_FIGURES}ps_screeplot.pdf", as(pdf) replace

rotate
matrix loadings = e(r_L)

* create locals with items to be called
local item1 "I show my son/daughter with words and gestures that I like him/her"
local item2 "I cheer up my son/daughter when he/she is sad"
local item3 "I praise my son/daughter"
local item4 "I tend to be a strict parent"
local item5 "If my son/daughter does something against my will, I punish him/her"
local item6 "I make it clear to my son/daughter that he/she is not to break the rules or question my decisions"
local item7 "I never waive from my rules"

qui file open table_out using `"${PATH_OUT_TABLES}/ps_loadings.tex"', write replace
file write table_out "\begin{tabular}{p{9.5cm}cc}" _n
file write table_out "\toprule" _n
file write table_out "& \multicolumn{2}{c}{Rotated} \\" _n
file write table_out "& \multicolumn{2}{c}{factor loadings} \\\cmidrule(lr){2-3}" _n
file write table_out "& (1) & (2)\\" _n
file write table_out "& Warmth & Control \\\midrule" _n
file write table_out "\multicolumn{3}{l}{\emph{Warmth measures \citep{Perrisetal1980}}}\\" _n
forvalues j=1/3 {
    local factorloading1 = round(loadings[`j',1], 0.01)
    local factorloading1 : di %3.2f `factorloading1'
    local factorloading2 = round(loadings[`j',2], 0.01)
    local factorloading2 : di %3.2f `factorloading2'
    file write table_out "(`j') `item`j'' & `factorloading1' & `factorloading2' \\" _n
}
file write table_out "\multicolumn{3}{l}{\emph{Control measures \citep{Schwarzetal1997}}} \\"_n
forvalues j=4/7 {
    local factorloading1 = round(loadings[`j',1], 0.01)
        local factorloading1 : di %3.2f `factorloading1'
    local factorloading2 = round(loadings[`j',2], 0.01)
        local factorloading2 : di %3.2f `factorloading2'
    file write table_out "(`j') `item`j'' & `factorloading1' & `factorloading2' \\" _n
}
file write table_out "\bottomrule" _n _n
file write table_out "\end{tabular}" _n _n
file close table_out


******* factor analysis and screeplot for neighborhood characteristics
use "${PATH_OUT_DATA}data_crosssection.dta", clear

factor frac_coll_plus2010 med_hhinc2016 poor_share2010 singleparent_share2010 gsmn_math_g3_2013 ///
	mail_return_rate2010 jobs_total_5mi_2015 traveltime15_2010 popdensity2010 foreign_share2010 /// 
	nonwhite_share2010 

screeplot, xtitle("Number of factors", size(medlarge)) ytitle(, size(medlarge)) ylabel(,glcolor(gs14) labsize(medlarge)) title("") xlabel(0(1)11, labsize(medlarge)) lwidth(medthick) mcolor(black) lcolor(black) yline(1, lcolor(black%70))
graph export "${PATH_OUT_FIGURES}nb_screeplot.pdf", as(pdf) replace

rotate
matrix loadings = e(r_L)

* create locals with items to be called
local item1 "Fraction of residents having a college degree or more (2010)"
local item2 "Median household income (2016)"
local item3 "Poverty rate (2010)"
local item4 "Share of single-headed households with children (2010)"
local item5 "Avg. school-district level standardized test scores in 3rd grade (2013)"
local item6 "Census form return rate (2010)"
local item7 "Number of primary jobs within five miles (2015)"
local item8 "Share of working adults with commuting times of 15 minutes or less (2010)"
local item9 "Population density (per square mile; 2010)"
local item10 "Share of population born outside the U.S. (2010)"
local item11 "Share of people who are not white (2010)"

qui file open table_out using `"${PATH_OUT_TABLES}/nb_loadings.tex"', write replace
file write table_out "\begin{tabular}{p{9.5cm}cc}" _n
file write table_out "\toprule" _n
file write table_out "& \multicolumn{2}{c}{Rotated} \\" _n
file write table_out "& \multicolumn{2}{c}{factor loadings} \\\cmidrule(lr){2-3}" _n
file write table_out "& (1) & (2)\\" _n
file write table_out "& \begin{tabular}{c}Economic\\conditions\end{tabular} & Segregation \\\midrule" _n
forvalues j=1/11 {
    local factorloading1 = round(loadings[`j',1], 0.01)
    local factorloading1 : di %3.2f `factorloading1'
    local factorloading2 = round(loadings[`j',2], 0.01)
    local factorloading2 : di %3.2f `factorloading2'
    file write table_out "(`j') `item`j'' & `factorloading1' & `factorloading2' \\" _n
}
file write table_out "\bottomrule" _n _n
file write table_out "\end{tabular}" _n _n
file close table_out

log close