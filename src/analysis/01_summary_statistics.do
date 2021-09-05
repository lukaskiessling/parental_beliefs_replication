include project_paths
log using `"${PATH_OUT_ANALYSIS}/log/`1'.log"', replace

use "${PATH_OUT_DATA}/data_crosssection.dta", clear

*** alternative summary statistics
cap file close table_out
qui file open table_out using `"${PATH_OUT_TABLES}summary_statistics.tex"', write replace
file write table_out "{" _n
file write table_out "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" _n
file write table_out "\begin{tabular}{l*{3}{c}}" _n
file write table_out "\toprule" _n
file write table_out "& \multicolumn{2}{c}{Sample} & CPS \\\cmidrule(lr){2-3}\cmidrule(lr){4-4}" _n
file write table_out "& Mean & SD & Mean \\\midrule" _n
file write table_out "\multicolumn{4}{l}{\emph{Sociodemographic variables}} \\" _n
sum female
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f .5705823
file write table_out "Female & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum age
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 40.89346
file write table_out "Age & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum employment_all
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f .7936755
file write table_out "Employed & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum college_degree
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f .3615282
file write table_out "College degree & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum hh_income
local mean_sample: di %5.0f r(mean)
local sd_sample: di %5.0f r(sd)
local mean_cps: di %5.0f 78017.56
file write table_out "Household income (in USD) & `mean_sample' & `sd_sample' & `mean_cps' \\" _n

file write table_out "\multicolumn{4}{l}{\emph{Family structure}} \\" _n
sum married
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 0.737608
file write table_out "Married & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum cohabitating
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
file write table_out "Cohabitating & `mean_sample' & `sd_sample' & \\" _n
sum single_parent
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
file write table_out "Single parent & `mean_sample' & `sd_sample' & \\" _n
sum num_children_total2
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 2.049465
file write table_out "Number of children & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum gender_composition
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
file write table_out "Share of female children & `mean_sample' & `sd_sample' & \\" _n

file write table_out "\multicolumn{4}{l}{\emph{Geographic distribution across census regions}} \\" _n
sum census_region_d1
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 0.1517894
file write table_out "Northeast & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum census_region_d2
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 0.2057795
file write table_out "Midwest & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum census_region_d3
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 0.3729432
file write table_out "South & `mean_sample' & `sd_sample' & `mean_cps' \\" _n
sum census_region_d4
local mean_sample: di %3.2f r(mean)
local sd_sample: di %3.2f r(sd)
local mean_cps: di %3.2f 0.2694879
file write table_out "West & `mean_sample' & `sd_sample' & `mean_cps' \\\midrule" _n

sum female
local observations = r(N)
file write table_out "Observations & `observations' & & " 
file write table_out "\\\bottomrule" _n
file write table_out "\end{tabular}" _n
file write table_out "}" _n
file close table_out

log close