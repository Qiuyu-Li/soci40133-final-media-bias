import excel "C:\Users\86188\Desktop\Thesis Twitter Misogyny\Output\Distribution of terms in the final dataset.xlsx", sheet("Sheet1") firstrow clear

rename A term

egen sum_all = sum(Alltweets)
egen sum_with_state = sum(Tweetswithstatetags)
egen sum_with_county = sum(Tweetswithcountytags)
egen sum_with_city = sum(Tweetswithcitytags)

gen prop0 = Alltweets / sum_all
gen prop1 = Tweetswithstatetags / sum_with_state
gen prop2 = Tweetswithcountytags / sum_with_county
gen prop3 = Tweetswithcitytags / sum_with_city

reshape long prop, i(term) j(prop_cat)

forvalues i = 1/3 {
    preserve
	keep if prop_cat == 0 | prop_cat == `i'
	ksmirnov prop,by(prop_cat)
	restore
}