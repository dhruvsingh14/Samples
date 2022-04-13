use basket, clear

*Q1.a.
reg rebounds height

*twoway (scatter rebounds height)

*Q1.b.
corr rebounds height
corr height rebounds

*Q1.c.
*Some doubts and difficulty w/ invttaail
display invttail(9, 0.025)

*Q1.d.
graph twoway (lfit rebounds height) (scatter rebounds height)

*Q2
edit

*II.1.
use cigarette, clear
list

*II.2.
reg carbon nicotine

*II.3.
graph twoway (lfit carbon nicotine) (scatter carbon nicotine)
