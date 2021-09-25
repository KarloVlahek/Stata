* ssc install outreg2
* set more off

//Nunn
local baseline_controls "age age2 male urban_dum i.education i.occupation i.religion i.living_conditions district_ethnic_frac frac_ethnicity_in_district i.isocode"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"

//Karlo
local baseline_controls "district_ethnic_frac frac_ethnicity_in_district i.isocode"
local colonial_controls "malaria_ecology total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33"


*******************************************************************************************************************************************
*******************************************************************************************************************************************
*******************************************************************************************************************************************
//Table 1 - Sum stats 
sum litRegion primEduRegion exports export_area export_pop distsea stateFragIndex agriRegion total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density if exports !=.


//Table 2
reg litRegion export_area, vce(cluster murdock_name)
outreg2 using vlahek_regTable2_033121.doc, replace dec(4)
reg litRegion export_pop, vce(cluster murdock_name)
outreg2 using vlahek_regTable2_033121.doc, append dec(4)
reg litRegion ln_export_area, vce(cluster murdock_name)
outreg2 using vlahek_regTable2_033121.doc, append dec(4)
reg litRegion ln_export_pop, vce(cluster murdock_name)
outreg2 using vlahek_regTable2_033121.doc, append dec(4)

//Table 3
reg primEduRegion export_area, vce(cluster murdock_name)
outreg2 using vlahek_regTable3_033121.doc, replace dec(4)
reg primEduRegion export_pop, vce(cluster murdock_name)
outreg2 using vlahek_regTable3_033121.doc, append dec(4)
reg primEduRegion ln_export_area, vce(cluster murdock_name)
outreg2 using vlahek_regTable3_033121.doc, append dec(4)
reg primEduRegion ln_export_pop, vce(cluster murdock_name)
outreg2 using vlahek_regTable3_033121.doc, append dec(4)

//Table 4 -  colonial controls + pop density intially
reg litRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density, vce(cluster murdock_name)
outreg2 using vlahek_regTable4_033121.doc, replace dec(4)
reg litRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density, vce(cluster murdock_name)
outreg2 using vlahek_regTable4_033121.doc, append dec(4)
reg primEduRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density, vce(cluster murdock_name)
outreg2 using vlahek_regTable4_033121.doc, append dec(4)
reg primEduRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density, vce(cluster murdock_name)
outreg2 using vlahek_regTable4_033121.doc, append dec(4)

//Table 4b -  colonial controls + pop density intially
reg litRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable4b_033121.doc, replace dec(4)
reg litRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable4b_033121.doc, append dec(4)
reg primEduRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable4b_033121.doc, append dec(4)
reg primEduRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable4b_033121.doc, append dec(4)

//Table 5 -  colonial controls + pop density intially + current Institution 
reg litRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable5_033121.doc, replace dec(4)
reg litRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable5_033121.doc, append dec(4)
reg primEduRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable5_033121.doc, append dec(4)
reg primEduRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion i.colonizers, vce(cluster murdock_name)
outreg2 using vlahek_regTable5_033121.doc, append dec(4)


//Table 5b -  colonial controls + pop density intially + current Institution 
reg litRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion, vce(cluster murdock_name)
outreg2 using vlahek_regTable5b_033121.doc, replace dec(4)
reg litRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion, vce(cluster murdock_name)
outreg2 using vlahek_regTable5b_033121.doc, append dec(4)
reg primEduRegion ln_export_area total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion, vce(cluster murdock_name)
outreg2 using vlahek_regTable5b_033121.doc, append dec(4)
reg primEduRegion ln_export_pop total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density stateFragIndex agriRegion, vce(cluster murdock_name)
outreg2 using vlahek_regTable5b_033121.doc, append dec(4)

*************************************************************** To be Revisited ************************************************************
/*

//Table 6 -  colonial controls + pop density intially + current Institution + IV REG
ivregress 2sls litRegion stateFragIndex agriRegion i.colonizers total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density (ln_export_area = distsea), vce(cluster murdock_name)
outreg2 using vlahek_regTable6_033121.doc, append dec(4)
ivregress 2sls litRegion stateFragIndex agriRegion i.colonizers total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density (ln_export_pop = distsea), vce(cluster murdock_name)
outreg2 using vlahek_regTable6_033121.doc, append dec(4)
ivregress 2sls primEduRegion stateFragIndex agriRegion i.colonizers total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density (ln_export_area = distsea), vce(cluster murdock_name)
outreg2 using vlahek_regTable6_033121.doc, append dec(4)
ivregress 2sls primEduRegion stateFragIndex agriRegion i.colonizers total_missions_area_times1000 explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density (ln_export_pop = distsea), vce(cluster murdock_name)
outreg2 using vlahek_regTable6_033121.doc, append dec(4)


//Table 7 - baseline controls + colonial controls  ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line
reg litRegion export_area total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable7.doc, replace dec(4)
reg litRegion export_pop total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable7.doc, append dec(4)
reg litRegion ln_export_area total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable7.doc, append dec(4)
reg litRegion ln_export_pop total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable7.doc, append dec(4)

//Table 8 - baseline controls + colonial controls ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line
reg primEduRegion export_area total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable8.doc, replace dec(4)
reg primEduRegion export_pop total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable8.doc, append dec(4)
reg primEduRegion ln_export_area total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable8.doc, append dec(4)
reg primEduRegion ln_export_pop total_missions_area explorer_contact railway_contact cities_1400_dum i.v30 v33 ln_init_pop_density fishing dist_Saharan_node dist_Saharan_line, vce(cluster murdock_name)
outreg2 using vlahek_regTable8.doc, append dec(4)
*/
*************************************************************** END of To be Revisited ************************************************************



