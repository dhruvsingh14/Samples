use States, clear

reg energy house toxic density

*PART II
*II.1.

*a)

graph7 energy, bin(6) normal f 

graph7 house, bin(6) normal f 

graph7 toxic, bin(6) normal f 

graph7 density, bin(6) normal f 


*xlabel(2,3,4,5) ylabel(0,5,10)


*b) 
sum energy house toxic density, d

*II.2.
sktest energy house toxic density


*II.3.
gladder energy

gladder toxic

gladder density

*II.5.
gen inv_energy=(1/energy)

gen ln_toxic=ln(toxic)

gen ln_density=ln(density)

/*
graph7 inv_energy, bin(6) normal f 

graph7 ln_toxic, bin(6) normal f 

graph7 ln_density, bin(6) normal f 
*/

sktest inv_energy ln_toxic ln_density 

*II.6.

reg inv_energy house ln_toxic ln_density

predict error, resid

graph7 error, bin(5) normal f xlabel ylabel

sum error, d

sktest error




