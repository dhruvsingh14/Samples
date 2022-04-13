use states2, clear

reg inverse_energy nlogtox nlogden house

*1.1.
estat hettest //heteroscedasticity post-estimation

*1.2.
vif //testing multicollinearity post-estimation

*1.3.
twoway scatter energy house || lfit energy house
twoway scatter inverse_energy house || lfit inverse_energy house

*twoway scatter energy nlogtox || lfit energy nlogtox
*twoway scatter inverse_energy nlogtox || lfit inverse_energy nlogtox

*2 Model Diagnostics are all Post Estimation Measures

*2.2.
predict cooksd, cooksd

list state cooksd 

*2.4.
list state cooksd if cooksd>4/45

*2.5.
dfbeta

describe state _dfbeta_1 _dfbeta_2 _dfbeta_3

list state _dfbeta_1 _dfbeta_2 _dfbeta_3

list state _dfbeta_1 _dfbeta_2 _dfbeta_3 if abs(_dfbeta_1)>0.2981|abs(_dfbeta_2)>0.2981|abs(_dfbeta_3)>0.2981




