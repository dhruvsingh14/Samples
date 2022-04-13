clear
capture cd "C:\Users\alexx\Desktop\Assign4"
if c(username)=="davidpritchard" {
cd "/Users/davidpritchard/Desktop/ECMT 676/Homework/Assignment 5"
}

use runandjump_sample1500g

*normalizing at 1500 cutoff
gen bwtnorm = bweight - 1500

*A.1

*plot frequencies using 1g 10g 25g bins
histogram bwtnorm, width(1) frequency
histogram bwtnorm, width(10) frequency
histogram bwtnorm, width(25) frequency

gen bin01 = bwtnorm + 0.5
gen bin10 = bwtnorm + 5
gen bin25 = bwtnorm + 12.5

egen x1 = cut(bwtnorm), group(300)
egen x2 = cut(bwtnorm), group(30)
egen x3 = cut(bwtnorm), group(12)


*A.2
preserve
collapse (count)bin01, by(x1)
twoway scatter bin01 x1
gen T = 0
replace T = 1 if x1 < 150
gen Tbin01 = T*bin01
reg bin01 T x1 Tbin01 
outreg2 using doc1.xls, replace ctitle(bin01 bw150g) label
reg bin01 T x1 Tbin01 if x1>=50 & x1<=250
outreg2 using doc1.xls, append ctitle(bin01 bw100g) label
reg bin01 T x1 Tbin01 if x1>=100 & x1<=200
outreg2 using doc1.xls, append ctitle(bin01 bw50g) label
restore

preserve
collapse (count)bin10, by(x2)
twoway scatter bin10 x2
gen T = 0
replace T = 1 if x2 < 15
gen Tbin10 = T*bin10
reg bin10 T x2 Tbin10
outreg2 using doc1.xls, append ctitle(bin10 bw150g) label
reg bin10 T x2 Tbin10 if x2>=5 & x2<=25
outreg2 using doc1.xls, append ctitle(bin10 bw100g) label
reg bin10 T x2 Tbin10 if x2>=10 & x2<=20
outreg2 using doc1.xls, append ctitle(bin10 bw50g) label
restore

preserve
collapse (count)bin25, by(x3)
twoway scatter bin25 x3
gen T = 0
replace T = 1 if x3 < 6
gen Tbin25 = T*bin25
reg bin25 T x3 Tbin25
outreg2 using doc1.xls, append ctitle(bin25 bw150g) label
reg bin25 T x3 Tbin25 if x3>=2 & x3<=10
outreg2 using doc1.xls, append ctitle(bin25 bw100g) label
reg bin25 T x3 Tbin25 if x3>=4 & x3<=8
outreg2 using doc1.xls, append ctitle(bin25 bw50g) label
restore

*A.3
gen T = 0
replace T = 1 if bwtnorm < 0
gen Tbwtnorm = T*bwtnorm

gen mother_white=0
replace mother_white=1 if mom_race==1

*(i) Bandwidth=90
gen weight90 = -(1/90)*abs(bwtnorm) + 1

reg mother_white T bwtnorm Tbwtnorm if bwtnorm>=-90 & bwtnorm<=90
outreg2 using doc2.xls, replace ctitle(m_whi rec90) label
reg mother_white T bwtnorm Tbwtnorm [pweight = weight90]
outreg2 using doc2.xls, append ctitle(m_whi tri90) label

reg mom_ed1 T bwtnorm Tbwtnorm if bwtnorm>=-90 & bwtnorm<=90
outreg2 using doc2.xls, append ctitle(m_edu rec90) label
reg mom_ed1 T bwtnorm Tbwtnorm [pweight = weight90]
outreg2 using doc2.xls, append ctitle(m_edu tri90) label

*(ii) Bandwidth=60
gen weight60 = -(1/60)*abs(bwtnorm) + 1

reg mother_white T bwtnorm Tbwtnorm if bwtnorm>=-60 & bwtnorm<=60
outreg2 using doc2.xls, append ctitle(m_whi rec60) label
reg mother_white T bwtnorm Tbwtnorm [pweight = weight60]
outreg2 using doc2.xls, append ctitle(m_whi tri60) label

reg mom_ed1 T bwtnorm Tbwtnorm if bwtnorm>=-60 & bwtnorm<=60 
outreg2 using doc2.xls, append ctitle(m_edu rec60) label
reg mom_ed1 T bwtnorm Tbwtnorm [pweight = weight60]
outreg2 using doc2.xls, append ctitle(m_edu tri60) label

*(iii) Bandwidth=30
gen weight30 = -(1/30)*abs(bwtnorm) + 1

reg mother_white T bwtnorm Tbwtnorm if bwtnorm>=-30 & bwtnorm<=30 
outreg2 using doc2.xls, append ctitle(m_whi rec30) label
reg mother_white T bwtnorm Tbwtnorm [pweight = weight30]
outreg2 using doc2.xls, append ctitle(m_whi tri30) label

reg mom_ed1 T bwtnorm Tbwtnorm if bwtnorm>=-30 & bwtnorm<=30 
outreg2 using doc2.xls, append ctitle(m_edu rec30) label
reg mom_ed1 T bwtnorm Tbwtnorm [pweight = weight30]
outreg2 using doc2.xls, append ctitle(m_edu tri30) label

*A.4
*51 oz ~ 1446 g => 1446 - 1500 = -54 g
*52 oz ~ 1474 g => 1474 - 1500 = -26 g
*53 oz ~ 1503 g => 1503 - 1500 = 3 g
*54 oz ~ 1531 g => 1531 - 1500 = 31 g

gen heap1=0
replace heap1=1 if bwtnorm==-54

gen heap2=0
replace heap2=1 if bwtnorm==-26

gen heap3=0
replace heap3=1 if bwtnorm==3

gen heap4=0
replace heap4=1 if bwtnorm==31

reg mother_white heap1 bwtnorm if bwtnorm>=-79 & bwtnorm<=-29 
outreg2 using doc3.xls, replace ctitle(m_whi heap1) label
reg mom_ed1 heap1 bwtnorm if bwtnorm>=-79 & bwtnorm<=-29 
outreg2 using doc3.xls, append ctitle(m_edu heap1) label

reg mother_white heap2 bwtnorm if bwtnorm>=-51 & bwtnorm<=-1 
outreg2 using doc3.xls, append ctitle(m_whi heap2) label
reg mom_ed1 heap2 bwtnorm if bwtnorm>=-51 & bwtnorm<=-1 
outreg2 using doc3.xls, append ctitle(m_edu heap2) label

reg mother_white heap3 bwtnorm if bwtnorm>=-22 & bwtnorm<=28 
outreg2 using doc3.xls, append ctitle(m_whi heap3) label
reg mom_ed1 heap3 bwtnorm if bwtnorm>=-22 & bwtnorm<=28 
outreg2 using doc3.xls, append ctitle(m_edu heap3) label

reg mother_white heap4 bwtnorm if bwtnorm>=6 & bwtnorm<=56 
outreg2 using doc3.xls, append ctitle(m_whi heap4) label
reg mom_ed1 heap4 bwtnorm if bwtnorm>=6 & bwtnorm<=56
outreg2 using doc3.xls, append ctitle(m_edu heap4) label


*B.1.
*(i) Bandwidth=90
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-90 & bwtnorm<=90, r
outreg2 using doc4.xls, replace ctitle(1yrmort rec90) label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight90], r
outreg2 using doc4.xls, append ctitle(1yrmort tri90) label

*(ii) Bandwidth=60
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-60 & bwtnorm<=60, r
outreg2 using doc4.xls, append ctitle(1yrmort rec60) label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight60], r
outreg2 using doc4.xls, append ctitle(1yrmort tri60) label

*(iii) Bandwidth=30
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-30 & bwtnorm<=30, r
outreg2 using doc4.xls, append ctitle(1yrmort rec30) label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight30], r
outreg2 using doc4.xls, append ctitle(1yrmort tri30) label

*B.2.
*(i) Bandwidth=90
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-90 & bwtnorm<=90 & bwtnorm!=0, r
outreg2 using doc5.xls, replace ctitle(zerodrop rec90) label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight90] if bwtnorm!=0, r
outreg2 using doc5.xls, append ctitle(zerodrop tri90) label

*(ii) Bandwidth=60
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-60 & bwtnorm<=60 & bwtnorm!=0, r
outreg2 using doc5.xls, append ctitle(zerodrop rec60) label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight60] if bwtnorm!=0, r
outreg2 using doc5.xls, append ctitle(zerodrop tri60) label

*(iii) Bandwidth=30
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-30 & bwtnorm<=30 & bwtnorm!=0, r
outreg2 using doc5.xls, append ctitle(zerodrop rec30) label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight30] if bwtnorm!=0, r
outreg2 using doc5.xls, append ctitle(zerodrop tri30) label


*B.3.
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-90 & bwtnorm<=90 & heap1!=1, r
outreg2 using doc6.xls, replace ctitle(mort r90 heap1) label

forv i=1(1)4{
*(i) Bandwidth=90
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-90 & bwtnorm<=90 & heap`i'!=1, r
outreg2 using doc6.xls, append ctitle(mort r90 heap`i') label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight90] if heap`i'!=1, r
outreg2 using doc6.xls, append ctitle(mort t90 heap`i') label

*(ii) Bandwidth=60
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-60 & bwtnorm<=60 & heap`i'!=1, r
outreg2 using doc6.xls, append ctitle(mort r60 heap`i') label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight60] if heap`i'!=1, r
outreg2 using doc6.xls, append ctitle(mort t60 heap`i') label

*(iii) Bandwidth=30
reg agedth5 T bwtnorm Tbwtnorm if bwtnorm>=-30 & bwtnorm<=30 & heap`i'!=1, r
outreg2 using doc6.xls, append ctitle(mort r30 heap`i') label
reg agedth5 T bwtnorm Tbwtnorm [pweight = weight30] if heap`i'!=1, r
outreg2 using doc6.xls, append ctitle(mort t30 heap`i') label
}


*B.4.
gen int11 = heap1*bwtnorm
gen int21 = heap2*bwtnorm
gen int31 = heap3*bwtnorm
gen int41 = heap4*bwtnorm

gen int12 = heap1*Tbwtnorm
gen int22 = heap2*Tbwtnorm
gen int32 = heap3*Tbwtnorm
gen int42 = heap4*Tbwtnorm

*(i) Bandwidth=90
reg agedth5 T bwtnorm Tbwtnorm int11 int11 int31 int41 ///
	int12 int22 int32 int42 if bwtnorm>=-90 & bwtnorm<=90 & bwtnorm!=0, r
outreg2 using doc7.xls, replace ctitle(mort r90 int) label
reg agedth5 T bwtnorm Tbwtnorm int11 int11 int31 int41 ///
	int12 int22 int32 int42 [pweight = weight90] if bwtnorm!=0, r
outreg2 using doc7.xls, append ctitle(mort t90 int) label

*(ii) Bandwidth=60
reg agedth5 T bwtnorm Tbwtnorm int11 int11 int31 int41 ///
	int12 int22 int32 int42 if bwtnorm>=-60 & bwtnorm<=60 & bwtnorm!=0, r
outreg2 using doc7.xls, append ctitle(mort r60 int) label
reg agedth5 T bwtnorm Tbwtnorm int11 int11 int31 int41 /// 
	int12 int22 int32 int42 [pweight = weight60] if bwtnorm!=0, r
outreg2 using doc7.xls, append ctitle(mort t60 int) label

*(iii) Bandwidth=30
reg agedth5 T bwtnorm Tbwtnorm int11 int11 int31 int41 /// 
	int12 int22 int32 int42 if bwtnorm>=-30 & bwtnorm<=30 & bwtnorm!=0, r
outreg2 using doc7.xls, append ctitle(mort r30 int) label
reg agedth5 T bwtnorm Tbwtnorm int11 int11 int31 int41 /// 
	int12 int22 int32 int42 [pweight = weight30] if bwtnorm!=0, r
outreg2 using doc7.xls, append ctitle(mort t30 int) label


*B.5.
//I would use the method in B.4. since it provides the most robust estimates.

forv i=1(1)7{
erase doc`i'.xls
erase doc`i'.txt
}
