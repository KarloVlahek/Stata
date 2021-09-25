
set maxvar 30000

//Benin 2017 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male 
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male 
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bn2017", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bnmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bn2017", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\femalebn", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bn2017", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\agribn", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bn2017", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\litbn", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\bn2017", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\primbn", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\primbn"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\litbn"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\agribn"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\femalebn"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\HCbn", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\primbn.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\litbn.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\femalebn.dta"


//GHANA 2014 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149  v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\gh2014", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\ghmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\gh2014", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\femalegh", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\gh2014", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\agrigh", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\gh2014", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\litgh", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\gh2014", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\primgh", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\primgh"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\litgh"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\agrigh"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\femalegh"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\HCgh", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\primgh.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\litgh.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\femalegh.dta"


//Kenya 2014 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\kemr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\kemr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\keir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149  v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\keir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\kemr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\keir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\ke2014", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\keir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\kemr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\ke2014", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\femaleke", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\ke2014", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\agrike", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\ke2014", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\litke", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\ke2014", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\primke", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\primke"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\litke"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\agrike"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\femaleke"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\HCke", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\primke.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\litke.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\femaleke.dta"


//Lesotho 2014 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\ls2014", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\lsmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\ls2014", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\femalels", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\ls2014", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\agrils", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\ls2014", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\litls", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\ls2014", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\primls", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\primls"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\litls"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\agrils"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\femalels"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\HCls", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\primls.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\litls.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\femalels.dta"


//Malawi 2015 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mw2015", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mwmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mw2015", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\femalemw", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mw2015", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\agrimw", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mw2015", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\litmw", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\mw2015", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\primmw", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\primmw"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\litmw"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\agrimw"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\femalemw"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\HCmw", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\primmw.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\litmw.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\femalemw.dta"


//Mali 2018 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\ml2018", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\mlmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\ml2018", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\femaleml", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\ml2018", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\agriml", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\ml2018", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\litml", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\ml2018", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\primml", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\primml"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\litml"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\agriml"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\femaleml"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\HCml", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\primml.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\litml.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\femaleml.dta"


//Mozambique 2015 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mz2011", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mzmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mz2011", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\femalemz", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mz2011", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\agrimz", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mz2011", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\litmz", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\mz2011", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\primmz", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\primmz"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\litmz"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\agrimz"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\femalemz"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\HCmz", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\primmz.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\litmz.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\femalemz.dta"


//Namibia 2013 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nm2013", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nmmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nm2013", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\femalenm", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nm2013", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\agrinm", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nm2013", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\litnm", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\nm2013", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\primnm", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\primnm"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\litnm"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\agrinm"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\femalenm"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\HCnm", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\primnm.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\litnm.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\femalenm.dta"


//Nigeria 2018 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149  v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ng2018", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ngmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ng2018", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\femaleng", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ng2018", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\agring", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ng2018", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\litng", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\ng2018", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\primng", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\primng"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\litng"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\agring"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\femaleng"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\HCng", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\primng.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\litng.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\femaleng.dta"


//Senegal 2017 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\sn2017", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\snmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\sn2017", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\femalesn", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\sn2017", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\agrisn", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\sn2017", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\litsn", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\sn2017", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\primsn", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\primsn"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\litsn"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\agrisn"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\femalesn"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\HCsn", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\primsn.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\litsn.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\femalesn.dta"


//South Africa 2016 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zamr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zamr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zair", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zair_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zamr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zair_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\za2016", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zair_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\zamr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\za2016", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\femaleza", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\za2016", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\agriza", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\za2016", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\litza", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\za2016", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\primza", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\primza"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\litza"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\agriza"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\femaleza"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\HCza", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\primza.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\litza.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\femaleza.dta"


//TANZANIA 2015 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tz2015", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tzmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tz2015", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\femaletz", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tz2015", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\agritz", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tz2015", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\littz", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\tz2015", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\primtz", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\primtz"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\littz"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\agritz"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\femaletz"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\HCtz", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\primtz.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\littz.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\femaletz.dta"


//UGANDA 2016 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ug2016", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ugmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ug2016", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\femaleug", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ug2016", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\agriug", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ug2016", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\litug", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\ug2016", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\primug", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\primug"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\litug"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\agriug"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\femaleug"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\HCug", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\primug.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\litug.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\femaleug.dta"


//ZAMBIA 2018 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zm2018", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zmmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zm2018", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\femalezm", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zm2018", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\agrizm", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zm2018", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\litzm", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\zm2018", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\primzm", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\primzm"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\litzm"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\agrizm"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\femalezm"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\HCzm", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\primzm.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\litzm.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\femalezm.dta"


//ZIMBABWE 2015 -----------------------------------------------------------------------------------------------------------------
//male data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwmr", clear
gen male = 1
renpfix mv v
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwmr_temp", replace

//opening and using female data
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwir", clear
gen male = 0
gen primEdu = (v149 >=2 & v149 <= 5) if v149 < .
label var primEdu "completed at least prim education"
keep v000 v005 v025 v021 v023 v022 v024 v026 v101 v155 v105 v107 v133 v149 v717 primEdu male
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwir_temp", replace

// Appends male data = lsmr_tmp to female data for BothSexData 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwmr_temp", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwir_temp"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zw2015", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwir_temp.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zwmr_temp.dta"

//Creating female rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zw2015", clear 
gen female = (male == 0)
collapse (mean) female [aweight = v005], by(v000 v024)
rename female femaleRegion
label variable femaleRegion "female rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\femalezw", replace

//Creating agriculture rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zw2015", clear 
gen agri = (v717 == 4 | v717 == 5)
collapse (mean) agri [aweight = v005], by(v000 v024)
rename agri agriRegion
label variable agriRegion "agriculture rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\agrizw", replace

//Creating literacy rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zw2015", clear 
gen lit = (v155 == 2)
collapse (mean) lit [aweight = v005], by(v000 v024)
rename lit litRegion
label variable litRegion "literature rate"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\litzw", replace

//Creating primary education rate by region 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\zw2015", clear 
collapse (mean) primEdu [aweight = v005], by(v000 v024)
rename primEdu primEduRegion
label variable primEduRegion "completed at least prim education"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\primzw", replace

//merge lit and primary education 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\primzw"
sort v024
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\litzw"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\agrizw"
drop _merge
merge 1:1 v024 using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\femalezw"
drop _merge
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\HCzw", replace
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\primzw.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\litzw.dta"
erase "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\femalezw.dta"


*===========================================================================================================================================
*===========================================================================================================================================
*===========================================================================================================================================


//Benin
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\HCbn", clear
rename v000 isocode
rename v024 region
replace isocode = "BEN" if isocode == "BJ7"
gen regionNunn = "alibori" if region == 1 & isocode == "BEN"
replace regionNunn = "atacora" if region == 2 & isocode == "BEN"
replace regionNunn = "atlnatique" if region == 3 & isocode == "BEN"
replace regionNunn = "borgou" if region == 4 & isocode == "BEN"
replace regionNunn = "collines" if region == 5 & isocode == "BEN"
replace regionNunn = "couffo" if region == 6 & isocode == "BEN"
replace regionNunn = "donga" if region == 7 & isocode == "BEN"
replace regionNunn = "littoral" if region == 8 & isocode == "BEN"
replace regionNunn = "mono" if region == 9 & isocode == "BEN"
replace regionNunn = "oueme" if region == 10 & isocode == "BEN"
replace regionNunn = "plateau" if region == 11 & isocode == "BEN"
replace regionNunn = "zou" if region == 12 & isocode == "BEN"

//Benin 2013 Census https://insae.bj/images/docs/insae-statistiques/demographiques/population/Resultats%20definitifs%20RGPH4.pdf
gen femaleratioCensus = 50.3 if regionNunn == "alibori" 
replace femaleratioCensus = 50.7 if regionNunn == "atacora" 
replace femaleratioCensus = 50.9 if regionNunn == "atlnatique"
replace femaleratioCensus = 50.0 if regionNunn == "borgou" 
replace femaleratioCensus = 50.7 if regionNunn == "collines" 
replace femaleratioCensus = 53.2 if regionNunn == "couffo" 
replace femaleratioCensus = 50.1 if regionNunn == "donga"
replace femaleratioCensus = 52.0 if regionNunn == "littoral"
replace femaleratioCensus = 51.4 if regionNunn == "mono"
replace femaleratioCensus = 51.4 if regionNunn == "oueme"
replace femaleratioCensus = 51.8 if regionNunn == "plateau"
replace femaleratioCensus = 52.2 if regionNunn == "zou"

//Benin 2011 https://insae.bj/images/docs/insae-statistiques/sociales/education-alpabetisation/5.%20Taux_alphabetisation_adultes_15_ans_et_plus_2004_2011.pdf
gen litCensus = 13.1 if regionNunn == "alibori" 
replace litCensus = 27.1 if regionNunn == "atacora" 
replace litCensus = 51.3 if regionNunn == "atlnatique"
replace litCensus = 36.9 if regionNunn == "borgou" 
replace litCensus = 41.8 if regionNunn == "collines" 
replace litCensus = 35.4 if regionNunn == "couffo" 
replace litCensus = 78.0 if regionNunn == "donga"
replace litCensus = 49.5 if regionNunn == "littoral"
replace litCensus = 51.5 if regionNunn == "mono"
replace litCensus = 34.8 if regionNunn == "oueme"
replace litCensus = 37.8 if regionNunn == "plateau"
replace litCensus = 44.5 if regionNunn == "zou"

save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\HCbn_nunn", replace

//Ghana
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\HCgh", clear
rename v000 isocode
rename v024 region
replace isocode = "GHA" if isocode == "GH6"
gen regionNunn = "western" if region == 1 & isocode == "GHA"
replace regionNunn = "central" if region == 2 & isocode == "GHA"
replace regionNunn = "greater accra" if region == 3 & isocode == "GHA"
replace regionNunn = "volta" if region == 4 & isocode == "GHA"
replace regionNunn = "eastern" if region == 5 & isocode == "GHA"
replace regionNunn = "ashanti" if region == 6 & isocode == "GHA"
replace regionNunn = "brong ahafo" if region == 7 & isocode == "GHA"
replace regionNunn = "northern" if region == 8 & isocode == "GHA"
replace regionNunn = "upper east" if region == 9 & isocode == "GHA"
replace regionNunn = "upper west" if region == 10 & isocode == "GHA"


//Ghana 2010 Census file:///C:/Users/kitissk/Downloads/2010_PHC_Summary_Report_of_Final_Results.pdf
gen femaleratioCensus = 50.0 if regionNunn == "western" 
replace femaleratioCensus = 52.3 if regionNunn == "central"
replace femaleratioCensus = 51.7 if regionNunn == "greater accra"
replace femaleratioCensus = 51.9 if regionNunn == "volta" 
replace femaleratioCensus = 51.0 if regionNunn == "eastern" 
replace femaleratioCensus = 51.5 if regionNunn == "ashanti" 
replace femaleratioCensus = 50.5 if regionNunn == "brong ahafo" 
replace femaleratioCensus = 50.4 if regionNunn == "northern" 
replace femaleratioCensus = 51.6 if regionNunn == "upper east" 
replace femaleratioCensus = 51.4 if regionNunn == "upper west"

//Ghana 2010 Census file:///C:/Users/kitissk/Downloads/2010_PHC_Summary_Report_of_Final_Results.pdf
gen litCensus = 73.5 if regionNunn == "western" 
replace litCensus = 75.2 if regionNunn == "central"
replace litCensus = 88.5 if regionNunn == "greater accra"
replace litCensus = 70.7 if regionNunn == "volta" 
replace litCensus = 78.8 if regionNunn == "eastern" 
replace litCensus = 80.5 if regionNunn == "ashanti" 
replace litCensus = 66.1 if regionNunn == "brong ahafo" 
replace litCensus = 32.5 if regionNunn == "northern" 
replace litCensus = 41.0 if regionNunn == "upper east" 
replace litCensus = 40.5 if regionNunn == "upper west"

save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\HCgh_nunn", replace

//Kenya 2014
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\HCke", clear
rename v000 isocode
rename v024 region
replace isocode = "KEN" if isocode == "KE6"
gen regionNunn = "coast" if region == 1 & isocode == "KEN"
replace regionNunn = "north eastern" if region == 2 & isocode == "KEN"
replace regionNunn = "eastern" if region == 3 & isocode == "KEN"
replace regionNunn = "central" if region == 4 & isocode == "KEN"
replace regionNunn = "rift valley" if region == 5 & isocode == "KEN"
replace regionNunn = "western" if region == 7 & isocode == "KEN"
replace regionNunn = "nyanza" if region == 8 & isocode == "KEN"
replace regionNunn = "nairobi" if region == 9 & isocode == "KEN"

/*
// Kenya 2009 Census https://s3-eu-west-1.amazonaws.com/s3.sourceafrica.net/documents/21195/Census-2009.pdf
gen femaleratioCensus =  if regionNunn == "coast" 
replace femaleratioCensus =  if regionNunn == "north eastern"
replace femaleratioCensus =  if regionNunn == "eastern"
replace femaleratioCensus =  if regionNunn == "central"
replace femaleratioCensus =  if regionNunn == "rift valley" 
replace femaleratioCensus =  if regionNunn == "western" 
replace femaleratioCensus =  if regionNunn == "nyanza" 
replace femaleratioCensus =  if regionNunn == "nairobi"

//
gen litCensus =  if regionNunn == "coast" 
replace litCensus =  if regionNunn == "north eastern"
replace litCensus =  if regionNunn == "eastern"
replace litCensus =  if regionNunn == "central"
replace litCensus =  if regionNunn == "rift valley" 
replace litCensus =  if regionNunn == "western" 
replace litCensus =  if regionNunn == "nyanza" 
replace litCensus =  if regionNunn == "nairobi"
*/

save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\HCke_nunn", replace

//Lesotho 2014
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\HCls", clear
rename v000 isocode
rename v024 region
replace isocode = "LSO" if isocode == "LS6"
gen regionNunn = "butha buthe" if region == 1 & isocode == "LSO"
replace regionNunn = "leribe" if region == 2 & isocode == "LSO"
replace regionNunn = "berea" if region == 3 & isocode == "LSO"
replace regionNunn = "maseru" if region == 4 & isocode == "LSO"
replace regionNunn = "mafeteng" if region == 5 & isocode == "LSO"
replace regionNunn = "mohale'hoek" if region == 6 & isocode == "LSO"
replace regionNunn = "quthing" if region == 7 & isocode == "LSO"
replace regionNunn = "qacha's nek" if region == 8 & isocode == "LSO"
replace regionNunn = "mokhotlong" if region == 9 & isocode == "LSO"
replace regionNunn = "thaba-tseka" if region == 10 & isocode == "LSO"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\HCls_nunn", replace

//Malawi 2015
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\HCmw", clear
rename v000 isocode
rename v024 region
replace isocode = "MWI" if isocode == "MW7"
gen regionNunn = "north" if region == 1 & isocode == "MWI"
replace regionNunn = "central" if region == 2 & isocode == "MWI"
replace regionNunn = "south" if region == 3 & isocode == "MWI"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\HCmw_nunn", replace

//Mali 2018
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\HCml", clear
rename v000 isocode
rename v024 region
replace isocode = "MLI" if isocode == "ML7"
gen regionNunn = "kayes" if region == 1 & isocode == "MLI"
replace regionNunn = "koulikoro" if region == 2 & isocode == "MLI"
replace regionNunn = "sikasso" if region == 3 & isocode == "MLI"
replace regionNunn = "s_ou" if region == 4 & isocode == "MLI"
replace regionNunn = "mopti" if region == 5 & isocode == "MLI"
replace regionNunn = "tombouctou" if region == 6 & isocode == "MLI"
replace regionNunn = "gao" if region == 7 & isocode == "MLI"
replace regionNunn = "kidal" if region == 8 & isocode == "MLI"
replace regionNunn = "bamako" if region == 9 & isocode == "MLI"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\HCml_nunn", replace

//Mozambique 2011
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\HCmz", clear
rename v000 isocode
rename v024 region
replace isocode = "MOZ" if isocode == "MZ6"
gen regionNunn = "niassa" if region == 1 & isocode == "MOZ"
replace regionNunn = "cabo delgado" if region == 2 & isocode == "MOZ"
replace regionNunn = "nampula" if region == 3 & isocode == "MOZ"
replace regionNunn = "zambezia" if region == 4 & isocode == "MOZ"
replace regionNunn = "tete" if region == 5 & isocode == "MOZ"
replace regionNunn = "manica" if region == 6 & isocode == "MOZ"
replace regionNunn = "sofala" if region == 7 & isocode == "MOZ"
replace regionNunn = "inhambane" if region == 8 & isocode == "MOZ"
replace regionNunn = "gaza" if region == 9 & isocode == "MOZ"
replace regionNunn = "maputo province" if region == 10 & isocode == "MOZ"
replace regionNunn = "maputo city" if region == 11 & isocode == "MOZ"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\HCmz_nunn", replace

//Namibia 2013
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\HCnm", clear
rename v000 isocode
rename v024 region
replace isocode = "NAM" if isocode == "NM6"
gen regionNunn = "caprivi" if region == 1 & isocode == "NAM"
replace regionNunn = "erongo" if region == 2 & isocode == "NAM"
replace regionNunn = "hardap" if region == 3 & isocode == "NAM"
replace regionNunn = "karas" if region == 4 & isocode == "NAM"
replace regionNunn = "kavango" if region == 5 & isocode == "NAM"
replace regionNunn = "khomas" if region == 6 & isocode == "NAM"
replace regionNunn = "kunene" if region == 7 & isocode == "NAM"
replace regionNunn = "ohangwena" if region == 8 & isocode == "NAM"
replace regionNunn = "omaheke" if region == 9 & isocode == "NAM"
replace regionNunn = "omusati" if region == 10 & isocode == "NAM"
replace regionNunn = "oshana" if region == 11 & isocode == "NAM"
replace regionNunn = "oshikoto" if region == 12 & isocode == "NAM"
replace regionNunn = "otjozundjupa" if region == 13 & isocode == "NAM"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\HCnm_nunn", replace

//Nigeria 2018 ---- Some regions are missing 
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\HCng", clear
rename v000 isocode
rename v024 region
replace isocode = "NGA" if isocode == "NG7"
gen regionNunn = "fct" if region == 1 & isocode == "NGA"
replace regionNunn = "benue" if region == 1 & isocode == "NGA"
replace regionNunn = "kogi" if region == 1 & isocode == "NGA"
replace regionNunn = "kwara" if region == 1 & isocode == "NGA"
replace regionNunn = "niger" if region == 1 & isocode == "NGA"
replace regionNunn = "plateau" if region == 1 & isocode == "NGA"

replace regionNunn = "adamawa" if region == 2 & isocode == "NGA"
replace regionNunn = "bauchi" if region == 2 & isocode == "NGA"
replace regionNunn = "borno" if region == 2 & isocode == "NGA"
replace regionNunn = "taraba" if region == 2 & isocode == "NGA"

replace regionNunn = "kaduna" if region == 3 & isocode == "NGA"
replace regionNunn = "kano" if region == 3 & isocode == "NGA"
replace regionNunn = "katsina" if region == 3 & isocode == "NGA"
replace regionNunn = "sokoto" if region == 3 & isocode == "NGA"
replace regionNunn = "zamfara" if region == 3 & isocode == "NGA"

replace regionNunn = "abia" if region == 4 & isocode == "NGA"
replace regionNunn = "anambra" if region == 4 & isocode == "NGA"
replace regionNunn = "enugu" if region == 4 & isocode == "NGA"
replace regionNunn = "imo" if region == 4 & isocode == "NGA"

replace regionNunn = "akwa-ibom" if region == 5 & isocode == "NGA"
replace regionNunn = "bayelsa" if region == 5 & isocode == "NGA"
replace regionNunn = "cross-river" if region == 5 & isocode == "NGA"
replace regionNunn = "delta" if region == 5 & isocode == "NGA"
replace regionNunn = "edo" if region == 5 & isocode == "NGA"
replace regionNunn = "rivers" if region == 5 & isocode == "NGA"

replace regionNunn = "ekiti" if region == 6 & isocode == "NGA"
replace regionNunn = "lagos" if region == 6 & isocode == "NGA"
replace regionNunn = "ogun" if region == 6 & isocode == "NGA"
replace regionNunn = "ondo" if region == 6 & isocode == "NGA"
replace regionNunn = "osun" if region == 6 & isocode == "NGA"
replace regionNunn = "oyo" if region == 6 & isocode == "NGA"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\HCng_nunn", replace


//Senegal 2017
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\HCsn", clear
rename v000 isocode
rename v024 region
replace isocode = "SEN" if isocode == "SN7"
gen regionNunn = "dakar" if region == 1 & isocode == "SEN"
replace regionNunn = "ziguinchor" if region == 2 & isocode == "SEN"
replace regionNunn = "diourbel" if region == 3 & isocode == "SEN"
replace regionNunn = "saint louis" if region == 4 & isocode == "SEN"
replace regionNunn = "tambacounda" if region == 5 & isocode == "SEN"
replace regionNunn = "kaolack" if region == 6 & isocode == "SEN"
replace regionNunn = "thies" if region == 7 & isocode == "SEN"
replace regionNunn = "louga" if region == 8 & isocode == "SEN"
replace regionNunn = "fatick" if region == 9 & isocode == "SEN"
replace regionNunn = " kolda" if region == 10 & isocode == "SEN"
replace regionNunn = "matam" if region == 11 & isocode == "SEN"
replace regionNunn = "." if region == 12 & isocode == "SEN"
replace regionNunn = "." if region == 13 & isocode == "SEN"
replace regionNunn = "." if region == 14 & isocode == "SEN"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\HCsn_nunn", replace

//South Africa 2016
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\HCza", clear
rename v000 isocode
rename v024 region
replace isocode = "ZAF" if isocode == "ZA7"
gen regionNunn = "western cape" if region == 1 & isocode == "ZAF"
replace regionNunn = "eastern cape" if region == 2 & isocode == "ZAF"
replace regionNunn = "northern cape" if region == 3 & isocode == "ZAF"
replace regionNunn = "free state" if region == 4 & isocode == "ZAF"
replace regionNunn = "kwazulu natal" if region == 5 & isocode == "ZAF"
replace regionNunn = "north west" if region == 6 & isocode == "ZAF"
replace regionNunn = "gauteng" if region == 7 & isocode == "ZAF"
replace regionNunn = "mpumalanga" if region == 8 & isocode == "ZAF"
replace regionNunn = "limpopo" if region == 9 & isocode == "ZAF"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\HCza_nunn", replace

//Tanzania 2015
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\HCtz", clear
rename v000 isocode
rename v024 region
replace isocode = "TZA" if isocode == "TZ7"
gen regionNunn = "dodoma" if region == 1 & isocode == "TZA"
replace regionNunn = "arusha" if region == 2 & isocode == "TZA"
replace regionNunn = "kilimanjaro" if region == 3 & isocode == "TZA"
replace regionNunn = "tanga" if region == 4 & isocode == "TZA"
replace regionNunn = "morogoro" if region == 5 & isocode == "TZA"
replace regionNunn = "pwani" if region == 6 & isocode == "TZA"
replace regionNunn = "dar es salaam" if region == 7 & isocode == "TZA"
replace regionNunn = "lindi" if region == 8 & isocode == "TZA"
replace regionNunn = "mtwara" if region == 9 & isocode == "TZA"
replace regionNunn = "ruvuma" if region == 10 & isocode == "TZA"
replace regionNunn = "iringa" if region == 11 & isocode == "TZA"
replace regionNunn = "mbeya" if region == 12 & isocode == "TZA"
replace regionNunn = "singida" if region == 13 & isocode == "TZA"
replace regionNunn = "tabora" if region == 14 & isocode == "TZA"
replace regionNunn = "rukwa" if region == 15 & isocode == "TZA"
replace regionNunn = "kigoma" if region == 16 & isocode == "TZA"
replace regionNunn = "shinyanga" if region == 17 & isocode == "TZA"
replace regionNunn = "kagera" if region == 18 & isocode == "TZA"
replace regionNunn = "mwanza" if region == 19 & isocode == "TZA"
replace regionNunn = "mara" if region == 20 & isocode == "TZA"
replace regionNunn = "manyara" if region == 21 & isocode == "TZA"
replace regionNunn = "." if region == 22 & isocode == "TZA"
replace regionNunn = "." if region == 23 & isocode == "TZA"
replace regionNunn = "." if region == 24 & isocode == "TZA"
replace regionNunn = "." if region == 25 & isocode == "TZA"
replace regionNunn = "." if region == 51 & isocode == "TZA"
replace regionNunn = "south unguja" if region == 52 & isocode == "TZA"
replace regionNunn = "." if region == 53 & isocode == "TZA"
replace regionNunn = "." if region == 54 & isocode == "TZA"
replace regionNunn = "." if region == 55 & isocode == "TZA"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\HCtz_nunn", replace

//Uganda 2016
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\HCug", clear
rename v000 isocode
rename v024 region
replace isocode = "UGA" if isocode == "UG7"
gen regionNunn = "central" if region == 0  & isocode == "UGA"
replace regionNunn = "central" if region == 1  & isocode == "UGA"
replace regionNunn = "central" if region == 2  & isocode == "UGA"
replace regionNunn = "east" if region == 3 & isocode == "UGA"
replace regionNunn = "east" if region == 4 & isocode == "UGA"
replace regionNunn = "east" if region == 5 & isocode == "UGA"
replace regionNunn = "east" if region == 6 & isocode == "UGA"
replace regionNunn = "north" if region == 7 & isocode == "UGA"
replace regionNunn = "north" if region == 8 & isocode == "UGA"
replace regionNunn = "north" if region == 9 & isocode == "UGA"
replace regionNunn = "north" if region == 10 & isocode == "UGA"
replace regionNunn = "west" if region == 11 & isocode == "UGA"
replace regionNunn = "west" if region == 12 & isocode == "UGA"
replace regionNunn = "west" if region == 13 & isocode == "UGA"
replace regionNunn = "west" if region == 14 & isocode == "UGA"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\HCug_nunn", replace

//Zambia
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\HCzm", clear
rename v000 isocode
rename v024 region
replace isocode = "ZMB" if isocode == "ZM7"
gen regionNunn = "central" if region == 1 & isocode == "ZMB"
replace regionNunn = "copper belt" if region == 2 & isocode == "ZMB"
replace regionNunn = "eastern" if region == 3 & isocode == "ZMB"
replace regionNunn = "luapula" if region == 4 & isocode == "ZMB"
replace regionNunn = "lusaka" if region == 5 & isocode == "ZMB"
replace regionNunn = "." if region == 6 & isocode == "ZMB"
replace regionNunn = "northern" if region == 7 & isocode == "ZMB"
replace regionNunn = "north western" if region == 8 & isocode == "ZMB"
replace regionNunn = "southern" if region == 9 & isocode == "ZMB"
replace regionNunn = "western" if region == 10 & isocode == "ZMB"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\HCzm_nunn", replace

//Zimbabwe 2015
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\HCzw", clear
rename v000 isocode
rename v024 region
replace isocode = "ZWE" if isocode == "ZW7"
gen regionNunn = "manicaland" if region == 1 & isocode == "ZWE"
replace regionNunn = " mashonaland central" if region == 2 & isocode == "ZWE"
replace regionNunn = "mashonaland east" if region == 3 & isocode == "ZWE"
replace regionNunn = "mashonaland west" if region == 4 & isocode == "ZWE"
replace regionNunn = "matebeland north" if region == 5 & isocode == "ZWE"
replace regionNunn = "matebeleland south" if region == 6 & isocode == "ZWE"
replace regionNunn = "midlands" if region == 7 & isocode == "ZWE"
replace regionNunn = "masvingo" if region == 8 & isocode == "ZWE"
replace regionNunn = "harare" if region == 9 & isocode == "ZWE"
replace regionNunn = "bulawayo" if region == 10 & isocode == "ZWE"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\HCzw_nunn", replace


//**************************************************************************************************************************************
//**************************************************************************************************************************************
//**************************************************************************************************************************************
//**************************************************************************************************************************************
//Append
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Benin2017\HCbn_nunn", clear
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Ghana2014\HCgh_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Kenya2014\HCke_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Lesotho2014\HCls_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Malawi2015\HCmw_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mali2018\HCml_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Mozambique2011\HCmz_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Namibia2013\HCnm_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Nigeria2018\HCng_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Senegal2017\HCsn_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\SouthAfrica2016\HCza_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Tanzania2015\HCtz_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Uganda2016\HCug_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zambia2018\HCzm_nunn"
append using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\Zimbabwe2015\HCzw_nunn"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\LitData\litdata_032221", replace





//MERGING WITH NUNN DATA
use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\LitData\litdata_032221", clear
rename region regionDHS
rename regionNunn region
sort isocode region
joinby isocode region using "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\NunnData\NunnData"
save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\LitData\Karlo_data_032221", replace

use "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\LitData\Karlo_data_032221", clear
sort isocode region ethnicity
by isocode region ethnicity: gen ethnByRegionCount = _n
keep if ethnByRegionCount == 1

//NEW CODE
gen stateFragIndex = 10 if isocode == "BEN"
replace stateFragIndex = 11 if isocode == "GHA"
replace stateFragIndex = 10 if isocode == "KEN"
replace stateFragIndex = 9 if isocode == "LSO"
replace stateFragIndex = 14 if isocode == "MWI"
replace stateFragIndex = 15 if isocode == "MLI"
replace stateFragIndex = 11 if isocode == "MOZ"
replace stateFragIndex = 5 if isocode == "NAM"
replace stateFragIndex = 18 if isocode == "NGA"
replace stateFragIndex = 8 if isocode == "ZAF"
replace stateFragIndex = 11 if isocode == "TZA"
replace stateFragIndex = 16 if isocode == "UGA"
replace stateFragIndex = 12 if isocode == "ZMB"
replace stateFragIndex = 17 if isocode == "ZWE"
replace stateFragIndex = 10 if isocode == "SEN"
label var stateFragIndex "state fragility index from Polity data"

gen colonizers = 1 if isocode == "BEN"
replace colonizers = 2 if isocode == "GHA"
replace colonizers = 2 if isocode == "KEN"
replace colonizers = 2 if isocode == "LSO"
replace colonizers = 2 if isocode == "MWI"
replace colonizers = 1 if isocode == "MLI"
replace colonizers = 3 if isocode == "MOZ"
replace colonizers = 2 if isocode == "NAM"
replace colonizers = 2 if isocode == "NGA"
replace colonizers = 2 if isocode == "ZAF"
replace colonizers = 2 if isocode == "TZA"
replace colonizers = 2 if isocode == "UGA"
replace colonizers = 2 if isocode == "ZMB"
replace colonizers = 2 if isocode == "ZWE"
replace colonizers = 1 if isocode == "SEN"
label var colonizers "Colonizing countries"
label define colonizersl 1 "France" 2 "Britain" 3 "Portugal" 
label values colonizers colonizersl


gen total_missions_area_times1000 = total_missions_area*1000
label var total_missions_area_times1000 "total 1000 mission per area"

save "C:\Users\kitissk\OneDrive - SUNY at Oneonta\Senior Seminar\Senior Seminar 2020\Vlahek\VlahekData\LitData\Karlo_data_032221", replace



























