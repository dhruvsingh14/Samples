use whites2018

log using whites2018, replace

*1.1.a
poisson ceb age educ rural

*1.1.b
poisson ceb age educ rural poverty catholic momeduc

*1.1.c
listcoef

*1.1.d
zip ceb age educ rural poverty catholic momeduc, ///
inflate(age educ rural poverty catholic momeduc) ///
vuong 



