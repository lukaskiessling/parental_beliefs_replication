include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace 

set matsize 3000

global parental_characteristics female age white college_degree employment_all hh_income_log single_parent num_children_total2 gender_composition

use "${PATH_OUT_DATA}data_panel.dta", clear

foreach x in w ls {
    if "`x'" == "w" local x2 "y_{ij}"
    if "`x'" == "ls" local x2 "ls_{ij}"
    if "`x'" == "w" local x3 "earnings"
    if "`x'" == "ls" local x3 "life satisfaction"

    if "`x'" == "w" local sample_mean_text "Mean exp. income (in USD)"
    if "`x'" == "ls" local sample_mean_text "Mean exp. life satis. (0-100)"
    
    ** baseline regressions 
    sum `x' if scenario == 2, d
    local mean_`x' = round(`r(mean)', 1)

    reg ln_`x' warmth control neighborhood, cluster(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "No"
    eststo reg_`x'_all_1a

    reg ln_`x' warmth control neighborhood $parental_characteristics, cluster(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "Controls"
    eststo reg_`x'_all_1b

    reghdfe ln_`x' warmth control neighborhood, cluster(id) absorb(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "FE"
    eststo reg_`x'_all_1c

    reg ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood, cluster(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "No"
    eststo reg_`x'_all_2a

    reg ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood $parental_characteristics, cluster(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "Controls"
    eststo reg_`x'_all_2b
    
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood, cluster(id) absorb(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "FE"
    eststo reg_`x'_all_2c

    * triple interaction
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood warmth_control_neighborhood, cluster(id) absorb(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_triple_int

    esttab reg_`x'_all_1a reg_`x'_all_1b reg_`x'_all_1c reg_`x'_all_2a reg_`x'_all_2b reg_`x'_all_2c returns_`x'_triple_int ///
        using `"${PATH_OUT_TABLES}scenarios_`x'.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label booktabs nonotes ///
        nomtitles nodepvars nogaps ///
        order(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood warmth_control_neighborhood) ///
        varlabels(warmth_control "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ High control}}" warmth_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ Good neighborhood}}" control_neighborhood "\multirow{2}{*}{\shortstack[l]{High control \\ \qquad $\times$ Good neighborhood}}" warmth_control_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth $\times$ High control \\ \qquad $\times$ Good neighborhood}}") ///
        refcat(female "\emph{Individual-level controls}", nolabel) ///
        mgroups("log. of expected `x3' at age 30 ($\log(`x2')$)", ///
        pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
        stats(sample_mean_`x' controls N N_clust r2, fmt(%18.0g str %18.0g %18.0g %04.3f) labels("`sample_mean_text'" "Controls for heterogeneity" `"Observations"' `"Individuals"' "\(R^2\)")) substitute(\_ _) ///
        drop(_cons $parental_characteristics)

    ** split by randomization group
    * by gender
    sum `x' if scenario == 2 & scenario_female == 0, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if scenario_female == 0, cluster(id) absorb(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "FE"
    eststo split_`x'_male

    sum `x' if scenario == 2 & scenario_female == 1, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if scenario_female == 1, cluster(id) absorb(id)
    estadd local sample_mean_`x' = `mean_`x''
    estadd local controls "FE"
    eststo split_`x'_female

    matrix coefficients_blank = e(b)
    matrix coefficients = coefficients_blank
    
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood ///
        c.scenario_female#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood), cluster(id) absorb(id)

    ** test equality of set of coefficients
    * all coefficients
    testparm c.scenario_female#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood)
    local test_all = `r(p)'
    * only main parenting terms
    testparm c.scenario_female#c.(warmth control warmth_control)
    local test_parenting = `r(p)'
    * only neighborhood terms
    testparm c.scenario_female#c.(neighborhood warmth_neighborhood control_neighborhood)
    local test_neighborhood = `r(p)'

    foreach x3 in warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood {
        local coefficient_b = _b[c.scenario_female#c.`x3']
        local coefficient_se = _se[c.scenario_female#c.`x3']
        local p_`x3' = 2*ttail(e(df_r),abs(_b[c.scenario_female#c.`x3']/_se[c.scenario_female#c.`x3']))
        display "p_`x3': " `p_`x3''
    }
    matrix coefficients[1,1] = `p_warmth'
    matrix coefficients[1,2] = `p_control'
    matrix coefficients[1,3] = `p_neighborhood'
    matrix coefficients[1,4] = `p_warmth_control'
    matrix coefficients[1,5] = `p_warmth_neighborhood'
    matrix coefficients[1,6] = `p_control_neighborhood'
    * add tests to results
    matrix coefficients = [coefficients, `test_parenting', `test_neighborhood', `test_all']
    ereturn post coefficients
    eststo p_values_gender

    * by age category
    forvalues a = 1/3 {
        sum `x' if scenario == 2 & age_cat == `a', d
        local mean_`x' = round(`r(mean)', 1)
        reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if age_cat == `a', cluster(id) absorb(id)
        estadd local sample_mean_`x' = `mean_`x''
        estadd local controls "FE"
        eststo split_`x'_age_`a'
    }

    * test age cat 1 vs age cat 2
    matrix coefficients = coefficients_blank
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood ///
        c.age_6_9#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood) if age_cat == 1 | age_cat == 2, cluster(id) absorb(id)
    
    ** test equality of set of coefficients
    * all coefficients
    testparm c.age_6_9#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood)
    local test_all = `r(p)'
    * only main parenting terms
    testparm c.age_6_9#c.(warmth control warmth_control)
    local test_parenting = `r(p)'
    * only neighborhood terms
    testparm c.age_6_9#c.(neighborhood warmth_neighborhood control_neighborhood)
    local test_neighborhood = `r(p)'

    foreach x3 in warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood {
        local coefficient_b = _b[c.age_6_9#c.`x3']
        local coefficient_se = _se[c.age_6_9#c.`x3']
        local p_`x3' = 2*ttail(e(df_r),abs(_b[c.age_6_9#c.`x3']/_se[c.age_6_9#c.`x3']))
        display "p_`x3': " `p_`x3''
    }
    matrix coefficients[1,1] = `p_warmth'
    matrix coefficients[1,2] = `p_control'
    matrix coefficients[1,3] = `p_neighborhood'
    matrix coefficients[1,4] = `p_warmth_control'
    matrix coefficients[1,5] = `p_warmth_neighborhood'
    matrix coefficients[1,6] = `p_control_neighborhood'
    * add tests to results
    matrix coefficients = [coefficients, `test_parenting', `test_neighborhood', `test_all']
    ereturn post coefficients
    eststo p_values_age_1_2

    * test age cat 1 vs age cat 3
    matrix coefficients = coefficients_blank
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood ///
        c.age_6_9#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood) if age_cat == 1 | age_cat == 3, cluster(id) absorb(id)

    ** test equality of set of coefficients
    * all coefficients
    testparm c.age_6_9#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood)
    local test_all = `r(p)'
    * only main parenting terms
    testparm c.age_6_9#c.(warmth control warmth_control)
    local test_parenting = `r(p)'
    * only neighborhood terms
    testparm c.age_6_9#c.(neighborhood warmth_neighborhood control_neighborhood)
    local test_neighborhood = `r(p)'
    
    foreach x3 in warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood {
        local coefficient_b = _b[c.age_6_9#c.`x3']
        local coefficient_se = _se[c.age_6_9#c.`x3']
        local p_`x3' = 2*ttail(e(df_r),abs(_b[c.age_6_9#c.`x3']/_se[c.age_6_9#c.`x3']))
        display "p_`x3': " `p_`x3''
    }
    matrix coefficients[1,1] = `p_warmth'
    matrix coefficients[1,2] = `p_control'
    matrix coefficients[1,3] = `p_neighborhood'
    matrix coefficients[1,4] = `p_warmth_control'
    matrix coefficients[1,5] = `p_warmth_neighborhood'
    matrix coefficients[1,6] = `p_control_neighborhood'
    * add tests to results
    matrix coefficients = [coefficients, `test_parenting', `test_neighborhood', `test_all']
    ereturn post coefficients
    eststo p_values_age_1_3

    * test age cat 2 vs age cat 3
    matrix coefficients = coefficients_blank
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood ///
        c.age_10_12#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood) if age_cat == 2 | age_cat == 3, cluster(id) absorb(id)

    ** test equality of set of coefficients
    * all coefficients
    testparm c.age_10_12#c.(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood)
    local test_all = `r(p)'
    * only main parenting terms
    testparm c.age_10_12#c.(warmth control warmth_control)
    local test_parenting = `r(p)'
    * only neighborhood terms
    testparm c.age_10_12#c.(neighborhood warmth_neighborhood control_neighborhood)
    local test_neighborhood = `r(p)'
    
    foreach x3 in warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood {
        local coefficient_b = _b[c.age_10_12#c.`x3']
        local coefficient_se = _se[c.age_10_12#c.`x3']
        local p_`x3' = 2*ttail(e(df_r),abs(_b[c.age_10_12#c.`x3']/_se[c.age_10_12#c.`x3']))
        display "p_`x3': " `p_`x3''
    }
    matrix coefficients[1,1] = `p_warmth'
    matrix coefficients[1,2] = `p_control'
    matrix coefficients[1,3] = `p_neighborhood'
    matrix coefficients[1,4] = `p_warmth_control'
    matrix coefficients[1,5] = `p_warmth_neighborhood'
    matrix coefficients[1,6] = `p_control_neighborhood'
    * add tests to results
    matrix coefficients = [coefficients, `test_parenting', `test_neighborhood', `test_all']
    ereturn post coefficients
    eststo p_values_age_2_3

    esttab split_`x'_male split_`x'_female p_values_gender split_`x'_age_1 split_`x'_age_2 split_`x'_age_3 p_values_age_1_2 p_values_age_1_3 p_values_age_2_3 ///
        using `"${PATH_OUT_TABLES}scenarios_`x'_gender_age.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label  booktabs nonotes ///
        refcat(c8 "\emph{Tests of coefficients}", nolabel) ///
        mtitles("\begin{tabular}{c}Boys\end{tabular}" "\begin{tabular}{c}Girls\end{tabular}" "\begin{tabular}{c}(1)=(2)\end{tabular}" "\begin{tabular}{c}6-9\\ years\end{tabular}" "\begin{tabular}{c}10-12 \\years\end{tabular}" "\begin{tabular}{c}13-16\\ years\end{tabular}" "\begin{tabular}{c}(4)=(5)\end{tabular}" "\begin{tabular}{c}(4)=(6)\end{tabular}" "\begin{tabular}{c}(5)=(6)\end{tabular}") nodepvars nogaps ///
        varlabels(warmth_control "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ High control}}" warmth_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ Good neighborhood}}" control_neighborhood "\multirow{2}{*}{\shortstack[l]{High control \\ \qquad $\times$ Good neighborhood}}") ///
        mgroups("$\log(`x2')$ " "$ p $-value" "$\log(`x2')$ " "$ p $-values", ///
        pattern(1 0 1 1 0 0 1 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
        stats(sample_mean_`x' controls N N_clust r2, fmt(%18.0g str %18.0g %18.0g %04.3f) labels("`sample_mean_text'" "Controls for heterogeneity" `"Observations"' `"Individuals"' "\(R^2\)")) substitute(\_ _) ///
        drop(_cons c8 c9 c10)

}

*** new main table with returns in wage and life satisfaction domain
esttab reg_w_all_1a reg_w_all_1b reg_w_all_1c reg_w_all_2a reg_w_all_2b reg_w_all_2c reg_ls_all_1c reg_ls_all_2c ///
    using `"${PATH_OUT_TABLES}scenarios_main.tex"', ///
    replace  ///
    nobaselevels ///
    b(%4.3f) se(%4.3f) ///
    star(* .1 ** .05 *** .01) ///
    label booktabs nonotes ///
    nomtitles nodepvars nogaps ///
    order(warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood) ///
    refcat(female "\emph{Individual-level controls}", nolabel) ///
    mgroups("log. of exp. wage at age 30 ($\log\big(y_{ij}\big)$)" "$\log\big(ls_{ij}\big)$ ", ///
    pattern(1 0 0 0 0 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
    varlabels(warmth_control "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ High control}}" warmth_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ Good neighborhood}}" control_neighborhood "\multirow{2}{*}{\shortstack[l]{High control \\ \qquad $\times$ Good neighborhood}}" warmth_control_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth $\times$ High control \\ \qquad $\times$ Good neighborhood}}") ///
    stats(sample_mean_w sample_mean_ls controls N N_clust r2, fmt(%18.0g %18.0g str %18.0g %18.0g %04.3f) ///
    labels("Mean exp. income (in USD)" "Mean exp. life satisfaction (0-100)" "Controls" `"Observations"' `"Individuals"' "\(R^2\)")) substitute(\_ _) drop(_cons)


*** Robustness checks: split sample by respondent's gender and certainty about beliefs
foreach x in w ls {
    if "`x'" == "w" local x2 "y_{ij}"
    if "`x'" == "ls" local x2 "ls_{ij}"
    
    if "`x'" == "w" local sample_mean_text "Mean expected income (in USD)"
    if "`x'" == "ls" local sample_mean_text "Mean expected life satisfaction (0-100)"

    ** robustness: restrict sample
    * exclude those who report not to be a main caregiver
    sum `x' if scenario == 2 & main_caregiver <= 2, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if main_caregiver <= 2, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_caregiver
    
    *split sample by certainty about responses
    sum `x' if scenario == 2 & certainty_about_beliefs >= 3, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if certainty_about_beliefs >= 3, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_certain
    
    sum `x' if scenario == 2 & certainty_about_beliefs < 3, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if certainty_about_beliefs <3, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_uncertain

    * exclude those with top/bottom 5% in response times
    sum time_scenarios, d
    local time_scenarios_p5 = r(p5)
    local time_scenarios_p95 = r(p95)
    sum `x' if scenario == 2 & time_scenarios >= `time_scenarios_p5' & time_scenarios <= `time_scenarios_p95', d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if time_scenarios >= `time_scenarios_p5' & time_scenarios <= `time_scenarios_p95', cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_responsetime

    * focus on those who moved in the last five years
    sum `x' if scenario == 2 & nb_length<= 3, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if nb_length_d <= 3, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_moving

    * same gender sample
    sum `x' if scenario == 2 & scenario_own_child3 == 1, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if scenario_own_child3 == 1, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_same_gender
    
    * same age sample
    sum `x' if scenario == 2 & scenario_own_child2 == 1, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if scenario_own_child2 == 1, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_same_age

    * same gender and age sample
    sum `x' if scenario == 2 & scenario_own_child == 1, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood if scenario_own_child == 1, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_same_gender_age

    * add triple interaction of warmth x control x neighborhood
    sum `x' if scenario == 2, d
    local mean_`x' = round(`r(mean)', 1)
    reghdfe ln_`x' warmth control neighborhood warmth_control warmth_neighborhood control_neighborhood warmth_control_neighborhood, cluster(id) absorb(id)
    estadd local sample_mean = `mean_`x''
    estadd local controls "FE"
    eststo returns_`x'_triple_int

    if "`x'" == "w" local x3 "earnings"
    if "`x'" == "ls" local x3 "life satisfaction"

    esttab returns_`x'_caregiver returns_`x'_certain returns_`x'_responsetime returns_`x'_moving returns_`x'_same_gender returns_`x'_same_age returns_`x'_same_gender_age /*returns_`x'_triple_int*/ ///
        using `"${PATH_OUT_TABLES}scenarios_`x'_robustness.tex"', ///
        replace  ///
        nobaselevels ///
        b(%4.3f) se(%4.3f) ///
        star(* .1 ** .05 *** .01) ///
        label  booktabs nonotes ///
        mtitles("\begin{tabular}{c}Main \\ caregivers\end{tabular}" "\begin{tabular}{c}Certain \\ response\end{tabular}" "\begin{tabular}{c}Response\\ time\end{tabular}" "\begin{tabular}{c}Moved\\ last 5 yrs.\end{tabular}" "\begin{tabular}{c}Same\\ sex\end{tabular}" "\begin{tabular}{c}Same\\ age\end{tabular}" "\begin{tabular}{c}Same \\sex+age\end{tabular}" "\begin{tabular}{c}All\end{tabular}") nodepvars nogaps ///
        mgroups("log. of expected `x3' at age 30 ($\log(`x2')$)", ///
        pattern(1 0 0 0 0 0 0 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) ///
        varlabels(warmth_control "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ High control}}" warmth_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth \\ \qquad $\times$ Good neighborhood}}" control_neighborhood "\multirow{2}{*}{\shortstack[l]{High control \\ \qquad $\times$ Good neighborhood}}" warmth_control_neighborhood "\multirow{2}{*}{\shortstack[l]{High warmth $\times$ High control \\ \qquad $\times$ Good neighborhood}}") ///
        stats(sample_mean controls N N_clust r2, fmt(%18.0g str %18.0g %18.0g %04.3f) labels("`sample_mean_text'" "Controls for heterogeneity" `"Observations"' `"Individuals"' "\(R^2\)")) substitute(\_ _) ///
        drop(_cons)
        
}

**** Barcharts of expectations
* winsorize expected wages for figure
gen w_winsorized = w
sum w_winsorized, d
replace w_winsorized = r(p99) if w_winsorized>=r(p99) & w_winsorized!=.
replace w_winsorized = r(p1) if w_winsorized<=r(p1) & w_winsorized!=.	

reg w i.scenario, cluster(id)
margins, at(scenario=(1(1)8)) post
eststo scenario_estimates_w
* confidence level of 68.3 corresponds to +/- 1 SE
coefplot (scenario_estimates_w, keep(6._at) fcolor("0 78 159") lcolor(gs0)) ///
    (scenario_estimates_w, keep(5._at) fcolor("0 78 159") lcolor(gs0)) ///
    (scenario_estimates_w, keep(7._at) fcolor("0 78 159") lcolor(gs0)) ///
    (scenario_estimates_w, keep(8._at) fcolor("0 78 159") lcolor(gs0)) ///
    (scenario_estimates_w, keep(2._at) fcolor("251 185 0") lcolor(gs0)) ///
    (scenario_estimates_w, keep(1._at) fcolor("251 185 0") lcolor(gs0)) ///
    (scenario_estimates_w, keep(3._at) fcolor("251 185 0") lcolor(gs0)) ///
    (scenario_estimates_w, keep(4._at) fcolor("251 185 0") lcolor(gs0)), ///
    vertical offset(0) recast(bar) levels(68.3)  ciopts(recast(rcap) lcolor(gs0) lwidth(medthick)) citop ///
    xline(4.5, lcolor(black)) xlabel(1 `""Low" "Low""' 2 `""Low" "High""' 3 `""High" "Low""' 4 `""High" "High""' 5 `""Low" "Low""' 6 `""Low" "High""' 7 `""High" "Low""' 8 `""High" "High""' , labgap(*1.75)) ///
    ytitle("Child's expected earnings at age 30" "(in today's USD +/- s.e.m.)", height(9) size(normal)) ylabel(20000(10000)60000, glcolor(gs14)) ///
    barwidth(0.5) graphregion(color(white)) bgcolor(white) fcolor(gs10) lcolor(gs10) mlabposition(12) mlabgap(*2) legend(off) ///
    text(58500 2.5 "Bad neighborhood ({it:n{superscript:L}})", place(c)) text(58500 6.5 "Good neighborhood ({it:n{superscript:H}})", place(c)) ///
        text(16900 -.01 "Warmth:", place(c)) text(15125 -.01 "Control:", place(c))
graph export "${PATH_OUT_FIGURES}expected_earnings_color.pdf", as(pdf) replace

coefplot (scenario_estimates_w, keep(6._at) fcolor(gs5*.70) lcolor(gs0)) ///
    (scenario_estimates_w, keep(5._at) fcolor(gs5*.70) lcolor(gs0)) ///
    (scenario_estimates_w, keep(7._at) fcolor(gs5*.70) lcolor(gs0)) ///
    (scenario_estimates_w, keep(8._at) fcolor(gs5*.70) lcolor(gs0)) ///
    (scenario_estimates_w, keep(2._at) fcolor(gs13*.50) lcolor(gs0)) ///
    (scenario_estimates_w, keep(1._at) fcolor(gs13*.50) lcolor(gs0)) ///
    (scenario_estimates_w, keep(3._at) fcolor(gs13*.50) lcolor(gs0)) ///
    (scenario_estimates_w, keep(4._at) fcolor(gs13*.50) lcolor(gs0)), ///
    vertical offset(0) recast(bar) levels(68.3)  ciopts(recast(rcap) lcolor(gs0) lwidth(medthick)) citop ///
    xline(4.5, lcolor(black)) xlabel(1 `""{it:w{superscript:L}c{superscript:L}}" "({it:y{subscript:1}})""' 2 `""{it:w{superscript:L}c{superscript:H}}" "({it:y{subscript:2}})""' 3 `""{it:w{superscript:H}c{superscript:L}}" "({it:y{subscript:3}})""' 4 `""{it:w{superscript:H}c{superscript:H}}" "({it:y{subscript:4}})""' 5 `""{it:w{superscript:L}c{superscript:L}}" "({it:y{subscript:5}})""' 6 `""{it:w{superscript:L}c{superscript:H}}" "({it:y{subscript:6}})""' 7 `""{it:w{superscript:H}c{superscript:L}}" "({it:y{subscript:7}})""' 8 `""{it:w{superscript:H}c{superscript:H}}" "({it:y{subscript:8}})""', labgap(*1.5)) ///
    ytitle("Child's expected earnings at age 30" "(in today's USD +/- s.e.m.)", height(9) size(normal)) ylabel(20000(10000)60000, glcolor(gs14)) ///
    barwidth(0.5) graphregion(color(white)) bgcolor(white) fcolor(gs10) lcolor(gs10) mlabposition(12) mlabgap(*2) legend(off) ///
    text(58500 2.5 "Bad neighborhood ({it:n{superscript:L}})", place(c)) text(58500 6.5 "Good neighborhood ({it:n{superscript:H}})", place(c))
graph export "${PATH_OUT_FIGURES}expected_earnings.pdf", as(pdf) replace

** correlation of wage and life satisfaction expectations
bysort id: gen index = _n
sum correlation_w_ls if index==1, d
local mean_correlation = r(mean)
hist correlation_w_ls if index==1, frac graphregion(color(white)) bgcolor(white) ///
    addplot(pci 0 `mean_correlation' 0.31 `mean_correlation', lcolor(black%70) lwidth(medthick)) ///
    xtitle("Individual-level correlations of wage" "and life satisfaction expectations", size(medlarge)) ytitle("Fraction", size(medlarge)) ///
    xlabel(,labsize(medlarge)) ylabel(,labsize(medlarge) glcolor(gs14)) fcolor(gs10*0.50) lcolor(gs10) gap(10) start(-1) width(0.05) legend(off) xsize(1.25) ysize(1)
graph export "${PATH_OUT_FIGURES}correlation_w_ls.pdf", as(pdf) replace

sum correlation_spearman_w_ls if index==1, d
local mean_correlation = r(mean)
hist correlation_spearman_w_ls if index==1, frac graphregion(color(white)) bgcolor(white) ///
    addplot(pci 0 `mean_correlation' 0.31 `mean_correlation', lcolor(black%70) lwidth(medthick)) ///
    xtitle("Individual-level rank correlations of wage" "and life satisfaction expectations", size(medlarge)) ytitle("Fraction", size(medlarge)) ///
    xlabel(,labsize(medlarge)) ylabel(,labsize(medlarge) glcolor(gs14)) fcolor(gs10*0.50) lcolor(gs10) gap(10) start(-1) width(0.05) legend(off) xsize(1.25) ysize(1)
graph export "${PATH_OUT_FIGURES}correlation_spearman_w_ls.pdf", as(pdf) replace

log close