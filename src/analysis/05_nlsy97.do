include project_paths

clear all

import delimited "${PATH_IN_DATA}nlsy97.csv", case(preserve) 

label define vlE0013301   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013301 vlE0013301
label define vlE0013302   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013302 vlE0013302
label define vlE0013303   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013303 vlE0013303
label define vlE0013304   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013304 vlE0013304
label define vlE0013305   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013305 vlE0013305
label define vlE0013306   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013306 vlE0013306
label define vlE0013307   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013307 vlE0013307
label define vlE0013308   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013308 vlE0013308
label define vlE0013309   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013309 vlE0013309
label define vlE0013310   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013310 vlE0013310
label define vlE0013311   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013311 vlE0013311
label define vlE0013312   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013312 vlE0013312
label define vlE0013313   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013313 vlE0013313
label define vlE0013314   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013314 vlE0013314
label define vlE0013315   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013315 vlE0013315
label define vlE0013316   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013316 vlE0013316
label define vlE0013317   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013317 vlE0013317
label define vlE0013318   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013318 vlE0013318
label define vlE0013319   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013319 vlE0013319
label define vlE0013320   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013320 vlE0013320
label define vlE0013321   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013321 vlE0013321
label define vlE0013322   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013322 vlE0013322
label define vlE0013323   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013323 vlE0013323
label define vlE0013324   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013324 vlE0013324
label define vlE0013325   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013325 vlE0013325
label define vlE0013326   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013326 vlE0013326
label define vlE0013327   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013327 vlE0013327
label define vlE0013328   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013328 vlE0013328
label define vlE0013329   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013329 vlE0013329
label define vlE0013330   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013330 vlE0013330
label define vlE0013331   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013331 vlE0013331
label define vlE0013332   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013332 vlE0013332
label define vlE0013333   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013333 vlE0013333
label define vlE0013334   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013334 vlE0013334
label define vlE0013335   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013335 vlE0013335
label define vlE0013336   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013336 vlE0013336
label define vlE0013337   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013337 vlE0013337
label define vlE0013338   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013338 vlE0013338
label define vlE0013339   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013339 vlE0013339
label define vlE0013340   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013340 vlE0013340
label define vlE0013341   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013341 vlE0013341
label define vlE0013342   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013342 vlE0013342
label define vlE0013343   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013343 vlE0013343
label define vlE0013344   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013344 vlE0013344
label define vlE0013345   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013345 vlE0013345
label define vlE0013346   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013346 vlE0013346
label define vlE0013347   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013347 vlE0013347
label define vlE0013348   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013348 vlE0013348
label define vlE0013349   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013349 vlE0013349
label define vlE0013350   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013350 vlE0013350
label define vlE0013351   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013351 vlE0013351
label define vlE0013352   0 "0: No information reported to account for week; job dates indeterminate"  1 "1: Not associated with an employer, not actively searching for an employer job"  2 "2: Not working (unemployment vs. out of labor force cannot be determined)"  3 "3: Associated with an employer, periods not working for the employer are missing"  4 "4: Unemployed"  5 "5: Out of the labor force"  6 "6: Active military service"
label values E0013352 vlE0013352
label define vlE8033100   0 "0"
label values E8033100 vlE8033100
label define vlR0000100   0 "0"
label values R0000100 vlR0000100
label define vlR0532200   1 "Yes"  0 "No"
label values R0532200 vlR0532200
label define vlR0533000   1 "Yes"  0 "No"
label values R0533000 vlR0533000
label define vlR0533100   1 "Yes"  0 "No"
label values R0533100 vlR0533100
label define vlR0533300   1 "Yes"  0 "No"
label values R0533300 vlR0533300
label define vlR0534800   1 "Yes"  0 "No"
label values R0534800 vlR0534800
label define vlR0534900   1 "Yes"  0 "No"
label values R0534900 vlR0534900
label define vlR0535200   1 "Yes"  0 "No"
label values R0535200 vlR0535200
label define vlR0535300   1 "Biological Mother"  2 "Biological Father"  3 "Adoptive Mother"  4 "Adoptive Father"  5 "Step Mother"  6 "Step Father"  7 "Female Guardian (Relative)"  8 "Male Guardian (Relative)"  9 "Foster Mother (lived with youth 2+ years)"  10 "Foster Father  (lived with youth 2+ years)"  11 "Other non-relative female (lived with youth 2+ years)"  12 "Other non-relative male (lived with youth 2+ years)"  13 "Foster Mother (lived with youth < 2 years)"  14 "Foster Father (lived with youth < 2 years)"  15 "Other non-relative female (lived with youth < 2 years)"  16 "Other non-relative male (lived with youth < 2 years)"  17 "Mother Figure (relative)"  18 "Father Figure (relative)"  19 "Mother Figure (non-relative - lived w/youth 2+ years)"  20 "Father Figure (non-relative - lived w/youth 2+ years)"  21 "Mother Figure (non-relative - lived w/youth < 2 years)"  22 "Father Figure (non-relative - lived w/youth < 2 years)"  0 "No information"
label values R0535300 vlR0535300
label define vlR0536300   1 "Male"  2 "Female"  0 "No Information"
label values R0536300 vlR0536300
label define vlR0536401   1 "1: January"  2 "2: February"  3 "3: March"  4 "4: April"  5 "5: May"  6 "6: June"  7 "7: July"  8 "8: August"  9 "9: September"  10 "10: October"  11 "11: November"  12 "12: December"
label values R0536401 vlR0536401
label define vlR0732600   1 "Yes"  0 "No"
label values R0732600 vlR0732600
label define vlR0732700   1 "Yes"  0 "No"
label values R0732700 vlR0732700
label define vlR0732900   1 "Yes"  0 "No"
label values R0732900 vlR0732900
label define vlR0734300   1 "Yes"  0 "No"
label values R0734300 vlR0734300
label define vlR0734400   1 "Yes"  0 "No"
label values R0734400 vlR0734400
label define vlR0734700   1 "Yes"  0 "No"
label values R0734700 vlR0734700
label define vlR1200100   0 "0"
label values R1200100 vlR1200100
label define vlR1200200   0 "0"
label values R1200200 vlR1200200
label define vlR1204500   0 "0"
label values R1204500 vlR1204500
label define vlR1204600   1 "Parent"  2 "Youth"
label values R1204600 vlR1204600
label define vlR1204700   0 "0"
label values R1204700 vlR1204700
label define vlR1235800   1 "Cross-sectional"  0 "Oversample"
label values R1235800 vlR1235800
label define vlR1302400   0 "NONE"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"
label values R1302400 vlR1302400
label define vlR1302500   0 "NONE"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"
label values R1302500 vlR1302500
label define vlR1302600   0 "NONE"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"
label values R1302600 vlR1302600
label define vlR1302700   0 "NONE"  1 "1ST GRADE"  2 "2ND GRADE"  3 "3RD GRADE"  4 "4TH GRADE"  5 "5TH GRADE"  6 "6TH GRADE"  7 "7TH GRADE"  8 "8TH GRADE"  9 "9TH GRADE"  10 "10TH GRADE"  11 "11TH GRADE"  12 "12TH GRADE"  13 "1ST YEAR COLLEGE"  14 "2ND YEAR COLLEGE"  15 "3RD YEAR COLLEGE"  16 "4TH YEAR COLLEGE"  17 "5TH YEAR COLLEGE"  18 "6TH YEAR COLLEGE"  19 "7TH YEAR COLLEGE"  20 "8TH YEAR COLLEGE OR MORE"  95 "UNGRADED"
label values R1302700 vlR1302700
label define vlR1482600   1 "Black"  2 "Hispanic"  3 "Mixed Race (Non-Hispanic)"  4 "Non-Black / Non-Hispanic"
label values R1482600 vlR1482600
label define vlR1486500   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R1486500 vlR1486500
label define vlR1486600   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R1486600 vlR1486600
label define vlR1486700   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R1486700 vlR1486700
label define vlR1486800   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R1486800 vlR1486800
label define vlR2563300   0 "0"
label values R2563300 vlR2563300
label define vlR2601400   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R2601400 vlR2601400
label define vlR2601500   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R2601500 vlR2601500
label define vlR2601600   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R2601600 vlR2601600
label define vlR2601700   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R2601700 vlR2601700
label define vlR3884900   0 "0"
label values R3884900 vlR3884900
label define vlR3924800   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R3924800 vlR3924800
label define vlR3924900   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R3924900 vlR3924900
label define vlR3925000   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R3925000 vlR3925000
label define vlR3925100   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R3925100 vlR3925100
label define vlR5464100   0 "0"
label values R5464100 vlR5464100
label define vlR5511100   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R5511100 vlR5511100
label define vlR5511200   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R5511200 vlR5511200
label define vlR5511300   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R5511300 vlR5511300
label define vlR5511400   1 "Uninvolved"  2 "Permissive"  3 "Authoritarian"  4 "Authoritative"
label values R5511400 vlR5511400
label define vlR7227800   0 "0"
label values R7227800 vlR7227800
label define vlR9792900   0 "0"
label values R9792900 vlR9792900
label define vlR9871900   -9 "-9: No courses with valid credits and grades"  -8 "-8: Pre-High school only"  -7 "-7: No credits earned"  -6 "-6: No courses taken"
label values R9871900 vlR9871900
label define vlS1541700   0 "0"
label values S1541700 vlS1541700
label define vlS2011500   0 "0"
label values S2011500 vlS2011500
label define vlS3812400   0 "0"
label values S3812400 vlS3812400
label define vlS5412800   0 "0"
label values S5412800 vlS5412800
label define vlS7513700   0 "0"
label values S7513700 vlS7513700
label define vlT0014100   0 "0"
label values T0014100 vlT0014100
label define vlT2016200   0 "0"
label values T2016200 vlT2016200
label define vlT3606500   0 "0"
label values T3606500 vlT3606500
label define vlT4405800   1 "YES"  0 "NO"
label values T4405800 vlT4405800
label define vlT4405900   1 "YES"  0 "NO"
label values T4405900 vlT4405900
label define vlT4406000   0 "0"
label values T4406000 vlT4406000
label define vlT4406100   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T4406100 vlT4406100
label define vlT4411200   1 "YES"  0 "NO"
label values T4411200 vlT4411200
label define vlT4411300   0 "0"
label values T4411300 vlT4411300
label define vlT4411400   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T4411400 vlT4411400
label define vlT4581900   1 "ALL OF THE TIME"  2 "MOST OF THE TIME"  3 "A GOOD BIT OF THE TIME"  4 "SOME OF THE TIME"  5 "A LITTLE OF THE TIME"  6 "NONE OF THE TIME"
label values T4581900 vlT4581900
label define vlT4583000   1 "YES"  0 "NO"
label values T4583000 vlT4583000
label define vlT5206900   0 "0"
label values T5206900 vlT5206900
label define vlT6055300   1 "YES"  0 "NO"
label values T6055300 vlT6055300
label define vlT6055400   1 "YES"  0 "NO"
label values T6055400 vlT6055400
label define vlT6055500   0 "0"
label values T6055500 vlT6055500
label define vlT6055600   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T6055600 vlT6055600
label define vlT6061300   1 "YES"  0 "NO"
label values T6061300 vlT6061300
label define vlT6061400   0 "0"
label values T6061400 vlT6061400
label define vlT6061500   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T6061500 vlT6061500
label define vlT6214200   1 "ALL OF THE TIME"  2 "MOST OF THE TIME"  3 "A GOOD BIT OF THE TIME"  4 "SOME OF THE TIME"  5 "A LITTLE OF THE TIME"  6 "NONE OF THE TIME"
label values T6214200 vlT6214200
label define vlT6215100   1 "YES"  0 "NO"
label values T6215100 vlT6215100
label define vlT6656700   0 "0"
label values T6656700 vlT6656700
label define vlT7545400   1 "YES"  0 "NO"
label values T7545400 vlT7545400
label define vlT7545500   1 "YES"  0 "NO"
label values T7545500 vlT7545500
label define vlT7545600   0 "0"
label values T7545600 vlT7545600
label define vlT7545700   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T7545700 vlT7545700
label define vlT7551400   1 "YES"  0 "NO"
label values T7551400 vlT7551400
label define vlT7551500   0 "0"
label values T7551500 vlT7551500
label define vlT7551600   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T7551600 vlT7551600
label define vlT7711600   1 "ALL OF THE TIME"  2 "MOST OF THE TIME"  3 "A GOOD BIT OF THE TIME"  4 "SOME OF THE TIME"  5 "A LITTLE OF THE TIME"  6 "NONE OF THE TIME"
label values T7711600 vlT7711600
label define vlT7712700   1 "YES"  0 "NO"
label values T7712700 vlT7712700
label define vlT8129100   0 "0"
label values T8129100 vlT8129100
label define vlT8134000   1 "Never married, cohabiting"  2 "Never married, not cohabiting"  3 "Married, spouse present"  4 "Married, spouse absent"  5 "Separated, cohabiting"  6 "Separated, not cohabiting"  7 "Divorced, cohabiting"  8 "Divorced, not cohabiting"  9 "Widowed, cohabiting"  10 "Widowed, not cohabiting"
label values T8134000 vlT8134000
label define vlT8134100   0 "Never-married"  1 "Married"  2 "Separated"  3 "Divorced"  4 "Widowed"
label values T8134100 vlT8134100
label define vlT8134300   0 "0"  1 "1"  2 "2"  3 "3"  4 "4"  5 "5"  6 "6"  7 "7"  8 "8"  9 "9"
label values T8134300 vlT8134300
label define vlT8976500   1 "YES"  0 "NO"
label values T8976500 vlT8976500
label define vlT8976600   1 "YES"  0 "NO"
label values T8976600 vlT8976600
label define vlT8976700   0 "0"
label values T8976700 vlT8976700
label define vlT8976800   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values T8976800 vlT8976800
label define vlT9112900   1 "YES A LOT"  2 "YES A LITTLE"  3 "NO NOT AT ALL"
label values T9112900 vlT9112900
label define vlT9113000   1 "YES A LOT"  2 "YES A LITTLE"  3 "NO NOT AT ALL"
label values T9113000 vlT9113000
label define vlT9113100   1 "YES A LOT"  2 "YES A LITTLE"  3 "NO NOT AT ALL"
label values T9113100 vlT9113100
label define vlT9113200   1 "YES A LOT"  2 "YES A LITTLE"  3 "NO NOT AT ALL"
label values T9113200 vlT9113200
label define vlT9113300   1 "YES A LOT"  2 "YES A LITTLE"  3 "NO NOT AT ALL"
label values T9113300 vlT9113300
label define vlT9113400   1 "YES A LOT"  2 "YES A LITTLE"  3 "NO NOT AT ALL"
label values T9113400 vlT9113400
label define vlT9113500   1 "A LOT"  2 "A LITTLE"  3 "NOT AT ALL"
label values T9113500 vlT9113500
label define vlT9113600   1 "ALL OF THE TIME"  2 "MOST OF THE TIME"  3 "A GOOD BIT OF THE TIME"  4 "SOME OF THE TIME"  5 "A LITTLE OF THE TIME"  6 "NONE OF THE TIME"
label values T9113600 vlT9113600
label define vlT9113800   1 "ALL OF THE TIME"  2 "MOST OF THE TIME"  3 "A GOOD BIT OF THE TIME"  4 "SOME OF THE TIME"  5 "A LITTLE OF THE TIME"  6 "NONE OF THE TIME"
label values T9113800 vlT9113800
label define vlT9114500   1 "YES"  0 "NO"
label values T9114500 vlT9114500
label define vlU0008900   0 "0"
label values U0008900 vlU0008900
label define vlU0956700   1 "YES"  0 "NO"
label values U0956700 vlU0956700
label define vlU0956800   1 "YES"  0 "NO"
label values U0956800 vlU0956800
label define vlU0956900   0 "0"
label values U0956900 vlU0956900
label define vlU0957000   1 "A. $1 - $5,000"  2 "B. $5,001 - $10,000"  3 "C. $10,001 - $25,000"  4 "D. $25,001 - $50,000"  5 "E. $50,001 - $100,000"  6 "F. $100,001 - $250,000"  7 "G. More than $250,000"
label values U0957000 vlU0957000
label define vlU1104000   1 "ALL OF THE TIME"  2 "MOST OF THE TIME"  3 "A GOOD BIT OF THE TIME"  4 "SOME OF THE TIME"  5 "A LITTLE OF THE TIME"  6 "NONE OF THE TIME"
label values U1104000 vlU1104000
label define vlU1105100   1 "YES"  0 "NO"
label values U1105100 vlU1105100
label define vlZ9075000   0 "0"  1 "1"  2 "2"  3 "3"  4 "4"  5 "5"  6 "6"  7 "7"  8 "8"  9 "9"
label values Z9075000 vlZ9075000
label define vlZ9079400   0 "0"  1 "1"  2 "2"  3 "3"  4 "4"  5 "5"  6 "6"  7 "7"  8 "8"  9 "9"
label values Z9079400 vlZ9079400
label define vlZ9083800   0 "None"  1 "1st grade"  2 "2nd grade"  3 "3rd grade"  4 "4th grade"  5 "5th grade"  6 "6th grade"  7 "7th grade"  8 "8th grade"  9 "9th grade"  10 "10th grade"  11 "11th grade"  12 "12th grade"  13 "1st year college"  14 "2nd year college"  15 "3rd year college"  16 "4th year college"  17 "5th year college"  18 "6th year college"  19 "7th year college"  20 "8th year college or more"  95 "Ungraded"
label values Z9083800 vlZ9083800
label define vlZ9083900   0 "None"  1 "GED"  2 "High school diploma (Regular 12 year program)"  3 "Associate/Junior college (AA)"  4 "Bachelor's degree (BA, BS)"  5 "Master's degree (MA, MS)"  6 "PhD"  7 "Professional degree (DDS, JD, MD)"
label values Z9083900 vlZ9083900

/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */
  rename E0013301 EMP_STATUS_2013_01_XRND   // EMP_STATUS_2013.01
  rename E0013302 EMP_STATUS_2013_02_XRND   // EMP_STATUS_2013.02
  rename E0013303 EMP_STATUS_2013_03_XRND   // EMP_STATUS_2013.03
  rename E0013304 EMP_STATUS_2013_04_XRND   // EMP_STATUS_2013.04
  rename E0013305 EMP_STATUS_2013_05_XRND   // EMP_STATUS_2013.05
  rename E0013306 EMP_STATUS_2013_06_XRND   // EMP_STATUS_2013.06
  rename E0013307 EMP_STATUS_2013_07_XRND   // EMP_STATUS_2013.07
  rename E0013308 EMP_STATUS_2013_08_XRND   // EMP_STATUS_2013.08
  rename E0013309 EMP_STATUS_2013_09_XRND   // EMP_STATUS_2013.09
  rename E0013310 EMP_STATUS_2013_10_XRND   // EMP_STATUS_2013.10
  rename E0013311 EMP_STATUS_2013_11_XRND   // EMP_STATUS_2013.11
  rename E0013312 EMP_STATUS_2013_12_XRND   // EMP_STATUS_2013.12
  rename E0013313 EMP_STATUS_2013_13_XRND   // EMP_STATUS_2013.13
  rename E0013314 EMP_STATUS_2013_14_XRND   // EMP_STATUS_2013.14
  rename E0013315 EMP_STATUS_2013_15_XRND   // EMP_STATUS_2013.15
  rename E0013316 EMP_STATUS_2013_16_XRND   // EMP_STATUS_2013.16
  rename E0013317 EMP_STATUS_2013_17_XRND   // EMP_STATUS_2013.17
  rename E0013318 EMP_STATUS_2013_18_XRND   // EMP_STATUS_2013.18
  rename E0013319 EMP_STATUS_2013_19_XRND   // EMP_STATUS_2013.19
  rename E0013320 EMP_STATUS_2013_20_XRND   // EMP_STATUS_2013.20
  rename E0013321 EMP_STATUS_2013_21_XRND   // EMP_STATUS_2013.21
  rename E0013322 EMP_STATUS_2013_22_XRND   // EMP_STATUS_2013.22
  rename E0013323 EMP_STATUS_2013_23_XRND   // EMP_STATUS_2013.23
  rename E0013324 EMP_STATUS_2013_24_XRND   // EMP_STATUS_2013.24
  rename E0013325 EMP_STATUS_2013_25_XRND   // EMP_STATUS_2013.25
  rename E0013326 EMP_STATUS_2013_26_XRND   // EMP_STATUS_2013.26
  rename E0013327 EMP_STATUS_2013_27_XRND   // EMP_STATUS_2013.27
  rename E0013328 EMP_STATUS_2013_28_XRND   // EMP_STATUS_2013.28
  rename E0013329 EMP_STATUS_2013_29_XRND   // EMP_STATUS_2013.29
  rename E0013330 EMP_STATUS_2013_30_XRND   // EMP_STATUS_2013.30
  rename E0013331 EMP_STATUS_2013_31_XRND   // EMP_STATUS_2013.31
  rename E0013332 EMP_STATUS_2013_32_XRND   // EMP_STATUS_2013.32
  rename E0013333 EMP_STATUS_2013_33_XRND   // EMP_STATUS_2013.33
  rename E0013334 EMP_STATUS_2013_34_XRND   // EMP_STATUS_2013.34
  rename E0013335 EMP_STATUS_2013_35_XRND   // EMP_STATUS_2013.35
  rename E0013336 EMP_STATUS_2013_36_XRND   // EMP_STATUS_2013.36
  rename E0013337 EMP_STATUS_2013_37_XRND   // EMP_STATUS_2013.37
  rename E0013338 EMP_STATUS_2013_38_XRND   // EMP_STATUS_2013.38
  rename E0013339 EMP_STATUS_2013_39_XRND   // EMP_STATUS_2013.39
  rename E0013340 EMP_STATUS_2013_40_XRND   // EMP_STATUS_2013.40
  rename E0013341 EMP_STATUS_2013_41_XRND   // EMP_STATUS_2013.41
  rename E0013342 EMP_STATUS_2013_42_XRND   // EMP_STATUS_2013.42
  rename E0013343 EMP_STATUS_2013_43_XRND   // EMP_STATUS_2013.43
  rename E0013344 EMP_STATUS_2013_44_XRND   // EMP_STATUS_2013.44
  rename E0013345 EMP_STATUS_2013_45_XRND   // EMP_STATUS_2013.45
  rename E0013346 EMP_STATUS_2013_46_XRND   // EMP_STATUS_2013.46
  rename E0013347 EMP_STATUS_2013_47_XRND   // EMP_STATUS_2013.47
  rename E0013348 EMP_STATUS_2013_48_XRND   // EMP_STATUS_2013.48
  rename E0013349 EMP_STATUS_2013_49_XRND   // EMP_STATUS_2013.49
  rename E0013350 EMP_STATUS_2013_50_XRND   // EMP_STATUS_2013.50
  rename E0013351 EMP_STATUS_2013_51_XRND   // EMP_STATUS_2013.51
  rename E0013352 EMP_STATUS_2013_52_XRND   // EMP_STATUS_2013.52
  rename E8033100 ARREST_TOTNUM_XRND 
  rename E8043500 INCARC_TOTMONTHS_XRND 
  rename R0000100 PUBID_1997 
  rename R0532200 YOUTH_BOTHBIO_01_1997   // YOUTH_BOTHBIO.01
  rename R0533000 YOUTH_HHADOPTKID_01_1997   // YOUTH_HHADOPTKID.01
  rename R0533100 YOUTH_HHBIOKID_01_1997   // YOUTH_HHBIOKID.01
  rename R0533300 YOUTH_HHSTEPKID_01_1997   // YOUTH_HHSTEPKID.01
  rename R0534800 YOUTH_NRADOPTKID_01_1997   // YOUTH_NRADOPTKID.01
  rename R0534900 YOUTH_NRBIOKID_01_1997   // YOUTH_NRBIOKID.01
  rename R0535200 YOUTH_NRSTEPKID_01_1997   // YOUTH_NRSTEPKID.01
  rename R0535300 YOUTH_PARENT_01_1997   // YOUTH_PARENT.01
  rename R0536300 SEX_1997 
  rename R0536401 BDATE_M_1997 
  rename R0536402 BDATE_Y_1997 
  rename R0732600 PARYOUTH_HHADOPTKID_1997 
  rename R0732700 PARYOUTH_HHBIOKID_1997 
  rename R0732900 PARYOUTH_HHSTEPKID_1997 
  rename R0734300 PARYOUTH_NRADOPTKID_1997 
  rename R0734400 PARYOUTH_NRBIOKID_1997 
  rename R0734700 PARYOUTH_NRSTEPKID_1997 
  rename R1200100 CV_BIO_MOM_AGE_CHILD1_1997 
  rename R1200200 CV_BIO_MOM_AGE_YOUTH_1997 
  rename R1204500 CV_INCOME_GROSS_YR_1997 
  rename R1204600 CV_HH_INCOME_SOURCE_1997 
  rename R1204700 CV_HH_NET_WORTH_P_1997 
  rename R1235800 CV_SAMPLE_TYPE_1997 
  rename R1302400 CV_HGC_BIO_DAD_1997 
  rename R1302500 CV_HGC_BIO_MOM_1997 
  rename R1302600 CV_HGC_RES_DAD_1997 
  rename R1302700 CV_HGC_RES_MOM_1997 
  rename R1482600 RACE_ETHNICITY_1997 
  rename R1486500 FP_YMPSTYL_1997 
  rename R1486600 FP_YFPSTYL_1997 
  rename R1486700 FP_YNRMPSTYL_1997 
  rename R1486800 FP_YNRFPSTYL_1997 
  rename R2563300 CV_INCOME_GROSS_YR_1998 
  rename R2601400 FP_YMPSTYL_1998 
  rename R2601500 FP_YFPSTYL_1998 
  rename R2601600 FP_YNRMPSTYL_1998 
  rename R2601700 FP_YNRFPSTYL_1998 
  rename R3884900 CV_INCOME_GROSS_YR_1999 
  rename R3924800 FP_YMPSTYL_1999 
  rename R3924900 FP_YFPSTYL_1999 
  rename R3925000 FP_YNRMPSTYL_1999 
  rename R3925100 FP_YNRFPSTYL_1999 
  rename R5464100 CV_INCOME_GROSS_YR_2000 
  rename R5511100 FP_YMPSTYL_2000 
  rename R5511200 FP_YFPSTYL_2000 
  rename R5511300 FP_YNRMPSTYL_2000 
  rename R5511400 FP_YNRFPSTYL_2000 
  rename R7227800 CV_INCOME_GROSS_YR_2001 
  rename R9792900 TRANS_GPA_HSTR 
  rename R9871900 TRANS_CRD_GPA_OVERALL_HSTR 
  rename S1541700 CV_INCOME_GROSS_YR_2002 
  rename S2011500 CV_INCOME_GROSS_YR_2003 
  rename S3812400 CV_INCOME_FAMILY_2004 
  rename S5412800 CV_INCOME_FAMILY_2005 
  rename S7513700 CV_INCOME_FAMILY_2006 
  rename T0014100 CV_INCOME_FAMILY_2007 
  rename T2016200 CV_INCOME_FAMILY_2008 
  rename T3606500 CV_INCOME_FAMILY_2009 
  rename T4405800 YINC_1400_2009   // YINC-1400
  rename T4405900 YINC_1600_2009   // YINC-1600
  rename T4406000 YINC_1700_2009   // YINC-1700
  rename T4406100 YINC_1800_2009   // YINC-1800
  rename T4411200 YINC_1400A_2009   // YINC-1400A
  rename T4411300 YINC_1700A_2009   // YINC-1700A
  rename T4411400 YINC_1800A_2009   // YINC-1800A
  rename T4581900 YHEA29_285_2009   // YHEA29-285
  rename T4583000 YHEA29_320_2009   // YHEA29-320
  rename T5206900 CV_INCOME_FAMILY_2010 
  rename T6055300 YINC_1400_2010   // YINC-1400
  rename T6055400 YINC_1600_2010   // YINC-1600
  rename T6055500 YINC_1700_2010   // YINC-1700
  rename T6055600 YINC_1800_2010   // YINC-1800
  rename T6061300 YINC_1400A_2010   // YINC-1400A
  rename T6061400 YINC_1700A_2010   // YINC-1700A
  rename T6061500 YINC_1800A_2010   // YINC-1800A
  rename T6214200 YHEA29_285_2010   // YHEA29-285
  rename T6215100 YHEA29_320_2010   // YHEA29-320
  rename T6656700 CV_INCOME_FAMILY_2011 
  rename T7545400 YINC_1400_2011   // YINC-1400
  rename T7545500 YINC_1600_2011   // YINC-1600
  rename T7545600 YINC_1700_2011   // YINC-1700
  rename T7545700 YINC_1800_2011   // YINC-1800
  rename T7551400 YINC_1400A_2011   // YINC-1400A
  rename T7551500 YINC_1700A_2011   // YINC-1700A
  rename T7551600 YINC_1800A_2011   // YINC-1800A
  rename T7711600 YHEA29_285_2011   // YHEA29-285
  rename T7712700 YHEA29_320_2011   // YHEA29-320
  rename T8129100 CV_INCOME_FAMILY_2013 
  rename T8134000 CV_MARSTAT_2013 
  rename T8134100 CV_MARSTAT_COLLAPSED_2013 
  rename T8134300 CV_BIO_CHILD_HH_2013 
  rename T8976500 YINC_1400_2013   // YINC-1400
  rename T8976600 YINC_1600_2013   // YINC-1600
  rename T8976700 YINC_1700_2013   // YINC-1700
  rename T8976800 YINC_1800_2013   // YINC-1800
  rename T9112900 YHEA29_240_2013   // YHEA29-240
  rename T9113000 YHEA29_245_2013   // YHEA29-245
  rename T9113100 YHEA29_250_2013   // YHEA29-250
  rename T9113200 YHEA29_255_2013   // YHEA29-255
  rename T9113300 YHEA29_260_2013   // YHEA29-260
  rename T9113400 YHEA29_265_2013   // YHEA29-265
  rename T9113500 YHEA29_270_2013   // YHEA29-270
  rename T9113600 YHEA29_285_2013   // YHEA29-285
  rename T9113800 YHEA29_290_2013   // YHEA29-290
  rename T9114500 YHEA29_320_2013   // YHEA29-320
  rename U0008900 CV_INCOME_FAMILY_2015 
  rename U0956700 YINC_1400_2015   // YINC-1400
  rename U0956800 YINC_1600_2015   // YINC-1600
  rename U0956900 YINC_1700_2015   // YINC-1700
  rename U0957000 YINC_1800_2015   // YINC-1800
  rename U1104000 YHEA29_285_2015   // YHEA29-285
  rename U1105100 YHEA29_320_2015   // YHEA29-320
  rename Z9075000 CVC_UI_EVER_XRND 
  rename Z9079400 CVC_GOVNT_PRG_EVER_XRND 
  rename Z9083800 CVC_HGC_EVER_XRND 
  rename Z9083900 CVC_HIGHEST_DEGREE_EVER_XRND 
  rename Z9084200 CVC_HS_DIPLOMA_XRND 
  rename Z9084400 CVC_BA_DEGREE_XRND 

  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
tolower


** define parenting styles
* for mothers
gen psstyle_mother = fp_yfpstyl_1997
replace psstyle_mother = fp_ympstyl_1998 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
replace psstyle_mother = fp_ympstyl_1999 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
replace psstyle_mother = fp_ympstyl_2000 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
* use parenting styles of non-residential parents if no residential parent is present
replace psstyle_mother = fp_ynrmpstyl_1997 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
replace psstyle_mother = fp_ynrmpstyl_1998 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
replace psstyle_mother = fp_ynrmpstyl_1999 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
replace psstyle_mother = fp_ynrmpstyl_2000 if psstyle_mother != 1 & psstyle_mother != 2 & psstyle_mother != 3 & psstyle_mother != 4
replace psstyle_mother = . if psstyle_mother<0

gen warmth_mother = 0 if psstyle_mother != .
replace warmth_mother = 1 if psstyle_mother == 2 | psstyle_mother == 4
label var warmth_mother "Warmth"
gen control_mother = 0 if psstyle_mother != .
replace control_mother = 1 if psstyle_mother == 3 | psstyle_mother == 4
label var control_mother "Control"

* for fathers
gen psstyle_father = fp_yfpstyl_1997
replace psstyle_father = fp_yfpstyl_1998 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
replace psstyle_father = fp_yfpstyl_1999 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
replace psstyle_father = fp_yfpstyl_2000 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
* use parenting styles of non-residential parents if no residential parent is present
replace psstyle_father = fp_ynrfpstyl_1997 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
replace psstyle_father = fp_ynrfpstyl_1998 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
replace psstyle_father = fp_ynrfpstyl_1999 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
replace psstyle_father = fp_ynrfpstyl_2000 if psstyle_father != 1 & psstyle_father != 2 & psstyle_father != 3 & psstyle_father != 4
replace psstyle_father = . if psstyle_father<0

gen warmth_father = 0 if psstyle_father != .
replace warmth_father = 1 if psstyle_father == 2 | psstyle_father == 4
label var warmth_father "Warmth"
gen control_father = 0 if psstyle_father != .
replace control_father = 1 if psstyle_father == 3 | psstyle_father == 4
label var control_father "Control"

* define control variables
egen age_std = std(-(bdate_y_1997 + (bdate_m_1997 - 1) / 12))
gen female = cond(sex_1997==1, 1, 0)
gen race = race_ethnicity_1997
gen white = cond(race_ethnicity_1997==4, 1, 0)

gen parental_education = cv_hgc_bio_mom_1997 if cv_hgc_bio_mom_1997 > 0
replace parental_education = cv_hgc_bio_dad_1997 if cv_hgc_bio_dad_1997 > 0 & cv_hgc_bio_dad_1997 > cv_hgc_bio_mom_1997

gen hh_income_1997_log = ln(cv_income_gross_yr_1997)

gen both_bio_parents_present_1997 = youth_bothbio_01_1997

* define outcome variables
gen log_wage_2013 = ln(yinc_1700_2013)
forvalues w = 1/9 {
	gen employment_status_w0`w' = cond(emp_status_2013_0`w'_xrnd>6, 1, 0)
}
forvalues w = 10/52 {
	gen employment_status_w`w' = cond(emp_status_2013_`w'_xrnd>6, 1, 0)
}
egen employment_status_2013 = rowmean(employment_status_w*)
drop employment_status_w*


egen hs_gpa_std = std(cond(trans_crd_gpa_overall_hstr > 0, trans_crd_gpa_overall_hstr , .))
gen num_arrests = arrest_totnum_xrnd
gen married = cond(cv_marstat_collapsed==1, 1, 0)
gen num_own_children = cv_bio_child_hh

foreach o in log_wage_2013 hs_gpa_std /*num_arrests married num_own_children*/ {
	foreach p in mo fa {
		cap drop warmth control
		gen warmth = warmth_`p'ther
		label var warmth "Warmth"
		gen control = control_`p'ther
		label var control "Control"
		reg `o' c.warmth##c.control, r
		eststo `o'_`p'
	}
}

esttab log_wage_2013_mo hs_gpa_std_mo log_wage_2013_fa hs_gpa_std_fa ///
	using `"${PATH_OUT_TABLES}nlsy97_actualreturns.tex"', ///
	replace  ///
	nobaselevels ///
	b(%4.3f) se(%4.3f) ///
	star(* .1 ** .05 *** .01) ///
	label  booktabs nonotes ///
	mtitles("log(earnings)" "HS GPA" "log(earnings)" "HS GPA") nodepvars nogaps ///    
	mgroups("Mother's Par. Style" "Father's Par. Style", ///
	pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) substitute(\_ _) ///
	stats(N r2, fmt(%18.0g %9.2g) labels(`"Observations"' "\(R^2\)")) drop(_cons)

* reshape data to show gender differences in parenting styles in NLSY97 data
gen id = _n
drop warmth control
rename psstyle_mother psstyle1
rename psstyle_father psstyle0
rename warmth_father warmth0
rename warmth_mother warmth1
rename control_mother control1
rename control_father control0

reshape long psstyle warmth control, i(id) j(mother)

foreach o in warmth control {
	sum `o', d
    local mean_return = round(`r(mean)', .01)
	reg `o' mother, cluster(id)
	eststo `o'_ps_genderdiff1
	estadd local sample_mean = `mean_return'
	estadd local controls "No"
	sum `o', d
    local mean_return = round(`r(mean)', .01)
	reg `o' mother female age_std cv_hgc_bio_mom_1997 cv_hgc_bio_dad_1997 hh_income_1997_log both_bio_parents_present_1997 i.race, cluster(id)
	eststo `o'_ps_genderdiff2
	estadd local sample_mean = `mean_return'	
	estadd local controls "Yes"
}

esttab warmth_ps_genderdiff1 warmth_ps_genderdiff2 control_ps_genderdiff1 control_ps_genderdiff2 ///
	using `"${PATH_OUT_TABLES}nlsy97_psstyles_genderdiff.tex"', ///
	replace  ///
	nobaselevels ///
	b(%4.3f) se(%4.3f) ///
	star(* .1 ** .05 *** .01) ///
	label  booktabs nonotes ///
	varlabel(mother "Mother") ///
	nomtitles nodepvars nogaps ///    
	mgroups("Warmth" "Control", ///
	pattern(1 0 1 0) prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span})) substitute(\_ _) ///
	stats(sample_mean N r2, fmt(%18.2g %18.0g %9.2g) labels("Mean of dependent variable" `"Observations"' "\(R^2\)")) drop(_cons female age_std cv_hgc_bio_mom_1997 cv_hgc_bio_dad_1997 hh_income_1997_log both_bio_parents_present_1997 *.race) 
