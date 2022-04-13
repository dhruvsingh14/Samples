display tprob(36, 1.96)

use urban, clear

list city poor homic divorce

desc

*Q2a
reg homic poor divorce


*Q2c
reg homic poor divorce, beta
