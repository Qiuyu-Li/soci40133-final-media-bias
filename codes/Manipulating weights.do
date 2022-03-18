global data_path "C:/Users/86188/Desktop/Thesis Twitter Misogyny/Paper data"
global twitter_path "C:/Users/86188/Desktop/Thesis Twitter Misogyny/Paper codes/data processing"
global output_path "D:\MyTempt"

* ******************************************
* Demographics data
* ******************************************
import delimited "$data_path\ACSDP1Y2019.DP05_2022-02-27T203132 Demographics\ACSDP1Y2019.DP05_data_with_overlays_2021-11-17T073654.csv", varnames(1) rowrange(3) clear

split name, p(,) limit(2)
split name1, p(" County")

g county = strlower(name11)
g state = strlower(name2)

rename dp05_0001e total_population
rename dp05_0002e male_population
rename dp05_0003e female_population
rename dp05_0004e sex_ratio

g pop_under_25 = dp05_0005e + dp05_0006e + dp05_0007e + dp05_0008e + dp05_0009e
g pop_25_59 = dp05_0010e + dp05_0011e + dp05_0012e + dp05_0013e
g pop_over_60 = dp05_0014e + dp05_0015e + dp05_0016e + dp05_0017e

rename dp05_0018e median_age
rename dp05_0019pe perc_under_18
rename dp05_0020e over_16
rename dp05_0020pe perc_over_16
rename dp05_0021pe perc_over_18
rename dp05_0024pe perc_over_65
rename dp05_0028e sex_ratio_over_18
rename dp05_0032e sex_ratio_over_65
rename dp05_0037pe perc_white
rename dp05_0038pe perc_black
rename dp05_0070pe perc_hispanic

drop dp* name*

save "$data_path/acs_demographics",replace 

* ******************************************
* Earnings data
* ******************************************
import delimited "$data_path\ACSST1Y2019.S2001_2022-02-27T195802 Earnings\ACSST1Y2019.S2001_data_with_overlays_2022-02-27T195759.csv", varnames(1) rowrange(3) clear

split name, p(,) limit(2)
split name1, p(" County")

g county = strlower(name11)
g state = strlower(name2)

* *************************************************
rename s2001_c01_001e pop_16_with_earnings
rename s2001_c01_002e pop_16_median
rename s2001_c01_003e pop_16_full_time_with_earnings
rename s2001_c01_004e pop_16_full_time_less_than_10000
rename s2001_c01_005e pop_16_full_time_10000_15000
rename s2001_c01_006e pop_16_full_time_15000_25000
rename s2001_c01_007e pop_16_full_time_25000_35000
rename s2001_c01_008e pop_16_full_time_35000_50000
rename s2001_c01_009e pop_16_full_time_50000_65000
rename s2001_c01_010e pop_16_full_time_65000_75000
rename s2001_c01_011e pop_16_full_time_75000_10w
rename s2001_c01_012e pop_16_full_time_more_than_10w

rename s2001_c03_001e male_16_with_earnings
rename s2001_c03_002e male_16_median
rename s2001_c03_003e male_16_full_time
rename s2001_c03_004e male_16_full_time_less_than_1w
rename s2001_c03_005e male_16_full_time_10000_15000
rename s2001_c03_006e male_16_full_time_15000_25000
rename s2001_c03_007e male_16_full_time_25000_35000
rename s2001_c03_008e male_16_full_time_35000_50000
rename s2001_c03_009e male_16_full_time_50000_65000
rename s2001_c03_010e male_16_full_time_65000_75000
rename s2001_c03_011e male_16_full_time_75000_100000
rename s2001_c03_012e male_16_full_time_more_than_10w
rename s2001_c03_013e male_16_full_time_median
rename s2001_c03_014e male_16_full_time_mean

rename s2001_c04_001e perc_male_16_with_earnings
rename s2001_c04_003e perc_male_16_full_time

rename s2001_c05_001e female_16_with_earnings
rename s2001_c05_002e female_16_median
rename s2001_c05_003e female_16_full_time
rename s2001_c05_004e female_16_full_time_less_than_1w
rename s2001_c05_005e female_16_full_time_10000_15000
rename s2001_c05_006e female_16_full_time_15000_25000
rename s2001_c05_007e female_16_full_time_25000_35000
rename s2001_c05_008e female_16_full_time_35000_50000
rename s2001_c05_009e female_16_full_time_50000_65000
rename s2001_c05_010e female_16_full_time_65000_75000
rename s2001_c05_011e female_16_full_time_75000_100000
rename s2001_c05_012e female_16_full_time_10w
rename s2001_c05_013e female_16_full_time_median
rename s2001_c05_014e female_16_full_time_mean

rename s2001_c06_001e perc_female_16_with_earnings
rename s2001_c06_003e perc_female_16_full_time

drop s2001*

save "$data_path/acs_earnings",replace 

* ******************************************
* Education data
* ******************************************
import delimited "$data_path\ACSST1Y2019.S1501_2022-02-27T234610 Education\ACSST1Y2019.S1501_data_with_overlays_2021-11-17T141413.csv", varnames(1) rowrange(3) clear

split name, p(,) limit(2)
split name1, p(" County")

g county = strlower(name11)
g state = strlower(name2)

rename s1501_c01_006e	population_25_and_over
rename s1501_c01_014e	population_25_high_school
rename s1501_c01_015e	population_25_bachelor

rename s1501_c03_006e	male_pop_25_and_over
rename s1501_c03_014e	male_pop_high_school
rename s1501_c03_015e	male_pop_bachelor

rename s1501_c05_006e	female_pop_25_and_over
rename s1501_c05_014e	female_pop_high_school
rename s1501_c05_015e	female_pop_bachelor

drop s1501*
save "$data_path/acs_educatioin",replace 


* ******************************************
* Merge ACS data
* ******************************************
mer 1:1 geo_id using "$data_path/acs_demographics", nogen
mer 1:1 geo_id using "$data_path/acs_earnings", nogen

drop name* geo_id
order state county,before(population_25_and_over)

destring population_25_and_over-perc_female_16_full_time, i('N') replace

replace state = strtrim(state)
replace county = strtrim(county)

* ******************************************
* Generate Dependent Variables
* ******************************************
gen ratio_worker = (perc_male_16_with_earnings / perc_female_16_with_earnings) / sex_ratio
gen ratio_full_time = (perc_male_16_full_time / perc_female_16_full_time) / sex_ratio

gen ratio_median = male_16_median / female_16_median
gen ratio_full_time_median = male_16_full_time_median / female_16_full_time_median
gen ratio_full_time_mean = male_16_full_time_mean / female_16_full_time_mean

gen ratio_less_than_1w = (male_16_full_time_less_than_1w / male_16_full_time) / (female_16_full_time_less_than_1w / female_16_full_time)
gen ratio_10000_15000 = (male_16_full_time_10000_15000 / male_16_full_time) / (female_16_full_time_10000_15000 / female_16_full_time)
gen ratio_15000_25000 = (male_16_full_time_15000_25000 / male_16_full_time) / (female_16_full_time_15000_25000 / female_16_full_time)
gen ratio_25000_35000 = (male_16_full_time_25000_35000 / male_16_full_time) / (female_16_full_time_25000_35000 / female_16_full_time)
gen ratio_35000_50000 = (male_16_full_time_35000_50000 / male_16_full_time) / (female_16_full_time_35000_50000 / female_16_full_time)
gen ratio_50000_65000 = (male_16_full_time_50000_65000 / male_16_full_time) / (female_16_full_time_50000_65000 / female_16_full_time)
gen ratio_65000_75000 = (male_16_full_time_65000_75000 / male_16_full_time) / (female_16_full_time_65000_75000 / female_16_full_time)
gen ratio_75000_100000 = (male_16_full_time_75000_100000 / male_16_full_time) / (female_16_full_time_75000_100000 / female_16_full_time)
gen ratio_10w = (male_16_full_time_more_than_10w / male_16_full_time) / (female_16_full_time_10w / female_16_full_time)

gen male_16_full_time_10000_25000 = male_16_full_time_10000_15000 + male_16_full_time_15000_25000
gen male_16_full_time_25000_50000 = male_16_full_time_25000_35000 + male_16_full_time_35000_50000
gen male_16_full_time_50000_75000 = male_16_full_time_50000_65000 + male_16_full_time_65000_75000
gen female_16_full_time_10000_25000 = female_16_full_time_10000_15000 + female_16_full_time_15000_25000
gen female_16_full_time_25000_50000 = female_16_full_time_25000_35000 + female_16_full_time_35000_50000
gen female_16_full_time_50000_75000 = female_16_full_time_50000_65000 + female_16_full_time_65000_75000

gen ratio_10000_25000 = (male_16_full_time_10000_25000 / male_16_full_time) / (female_16_full_time_10000_25000 / female_16_full_time)
gen ratio_25000_50000 = (male_16_full_time_25000_50000 / male_16_full_time) / (female_16_full_time_25000_50000 / female_16_full_time)
gen ratio_50000_75000 = (male_16_full_time_50000_75000 / male_16_full_time) / (female_16_full_time_50000_75000 / female_16_full_time)

gen ratio_high = (male_pop_high_school / male_pop_25_and_over) / (female_pop_high_school / female_pop_25_and_over)
gen ratio_bachelor = (male_pop_bachelor / male_pop_25_and_over) / (female_pop_bachelor / female_pop_25_and_over)

save "$data_path/acs_earnings",replace

* *************************************************
* Import misogyny index data
* *************************************************

* ********************
* County
* ********************
import delimited "$twitter_path\the_county_by_key_word.csv", varnames(1) clear

rename v4 county_counts

drop if state == "hawaiÊ»i"

gen state_county = state + "_" + county

encode keyword, gen(keyword_code)

fillin state_county keyword_code

drop keyword state county _fillin

reshape wide county_counts, i(state_county) j(keyword_code)

save "$data_path/mani_county", replace

* ********************
* State
* ********************
import delimited "$twitter_path\the_state_count_by_keyword.csv", varnames(1) clear

drop if state == "hawaiʻi"

rename v3 state_counts

encode keyword, gen(keyword_code)

drop keyword

reshape wide state_counts, i(state) j(keyword_code)

save "$data_path/mani_state", replace

* *************************************************
* Merge
* *************************************************
use "$data_path/acs_earnings",replace

gen state_county = state + "_" + county

mer 1:1 state_county using "$data_path/mani_county", keep(master match) gen(mer_county)
mer m:1 state using "$data_path/mani_state", keep(master match) gen(mer_state)

drop county_counts13

corr county_counts* ratio_worker ratio_full_time ratio_median ratio_full_time_median ratio_full_time_mean

preserve
keep county_counts* ratio_worker ratio_full_time ratio_median ratio_full_time_median ratio_full_time_mean ratio_high ratio_bachelor

export delimited using "C:\Users\86188\Desktop\SOCI 40133\some_data_processing_for_the_final\corr_county.csv", replace
 
restore

* *************************************************
* State-Level
* *************************************************
gen perc_25_high_school = population_25_high_school / population_25_and_over
gen perc_25_bachelor = population_25_bachelor / population_25_and_over
encode state, gen(state_code)

global controls_state pop_16_with_earnings wm_perc_25_high_school wm_perc_25_bachelor total_population wm_perc_under_18 wm_perc_over_65 wm_perc_white wm_perc_black wm_perc_hispanic

global var_list_1 perc_25_high_school perc_25_bachelor total_population perc_under_18 perc_over_65 perc_white perc_black perc_hispanic ratio_worker ratio_full_time ratio_median ratio_full_time_median ratio_full_time_mean ratio_less_than_1w ratio_10000_25000 ratio_25000_50000 ratio_50000_75000 ratio_75000_100000 ratio_10w

global var_list_2 wm_perc_25_high_school wm_perc_25_bachelor wm_perc_under_18 wm_perc_over_65 wm_perc_white wm_perc_black wm_perc_hispanic wm_ratio_worker wm_ratio_full_time wm_ratio_median wm_ratio_full_time_median wm_ratio_full_time_mean wm_ratio_less_than_1w wm_ratio_10000_25000 wm_ratio_25000_50000 wm_ratio_50000_75000 wm_ratio_75000_100000 wm_ratio_10w wm_ratio_high wm_ratio_bachelor

foreach var of varlist $var_list_1 {
	bys state_code: egen wm_`var' = wtmean(`var'), weight(total_population)
}

bys state_code: egen wm_ratio_high = wtmean(ratio_high), weight(total_population)
bys state_code: egen wm_ratio_bachelor = wtmean(ratio_bachelor), weight(total_population)

save "$data_path/mani_before_final_step", replace

collapse (sum)pop_16_with_earnings total_population (mean) $var_list_2 state_counts*, by(state_code)

forvalues i = 1/16 {
	corr state_counts`i' wm_ratio_worker wm_ratio_full_time wm_ratio_median wm_ratio_full_time_median wm_ratio_full_time_mean
}

drop state_counts8 state_counts14

keep state_counts* wm_ratio_worker wm_ratio_full_time wm_ratio_median wm_ratio_full_time_median wm_ratio_full_time_mean wn_ratio_high wm_ratio_bachelor

export delimited using "C:\Users\86188\Desktop\SOCI 40133\some_data_processing_for_the_final\corr_state.csv", replace

/*
* *************************************************
* Education
* *************************************************
use "$data_path/before_final_step", replace

gen ratio_high = (male_pop_high_school / male_pop_25_and_over) / (female_pop_high_school / female_pop_25_and_over)
gen ratio_bachelor = (male_pop_bachelor / male_pop_25_and_over) / (female_pop_bachelor / female_pop_25_and_over)

qui foreach var of varlist ratio_high ratio_bachelor {
	reg `var' mis_index_county, r
	outreg2 using "$output_path\county_`var'", replace keep(mis_index_county) word tex label
	reg `var' mis_index_county $controls, r
	outreg2 using "$output_path\county_`var'", append keep(mis_index_county) word tex label
	reg `var' mis_index_county $controls i.state_code, r
	outreg2 using "$output_path\county_`var'", append keep(mis_index_county) word tex label
}

bys state_code: egen wm_ratio_high = wtmean(ratio_high), weight(total_population)
bys state_code: egen wm_ratio_bachelor = wtmean(ratio_bachelor), weight(total_population)

collapse (sum)pop_16_with_earnings total_population mis_index_county (mean) $var_list_2 wm_ratio_high wm_ratio_bachelor mis_index_state, by(state_code)

qui foreach var of varlist wm_ratio_high wm_ratio_bachelor {
	reg `var' mis_index_state, r
	outreg2 using "$output_path\state_`var'", replace keep(mis_index_state) word tex label
	reg `var' mis_index_state $controls_state, r
	outreg2 using "$output_path\state_`var'", append keep(mis_index_state) word tex label
}
