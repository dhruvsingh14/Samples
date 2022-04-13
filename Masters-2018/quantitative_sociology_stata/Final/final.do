sysuse auto

sum price mpg rep78

reg price mpg rep78

gen mpg_c = mpg -  21.2973   
gen rep78_c = rep78 - 3.405797 

reg price mpg_c rep78_c
