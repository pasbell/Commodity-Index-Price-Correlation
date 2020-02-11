# Commodity-and-Index-Correlation

## Objectives
The equities market volatility lies in factors as geopolitical outcomes, economic decisions and financial events. All of these can move the overall market either positively or negatively. In times of distress, the old wives' tale is that hard assets - primarily  gold - are less risky to invest in. Therefore, due to market demand, the prices of such commodity increases. The same would be inversely true - when the equity market is performing well, the values of commodities tend to decrease because of investor's optimism in market performance and their consequent investment in the equities market instead. 

Through statistical analysis, I´ll deteremine to what extent has this general believe been true for the last two years (2016-2018), on which we have seen very interesting and unique global events, as outlined in the section above. Furthermore, we want to investigate the correlation, if existent, of another commodity - Crude Oil (WTI) - with the equities market. The second objective is then to explore where does this commodity fit in the belief that equities and commodities are inversely correlated, and understand its level of dependency with gold and equities.

Crude Oil was chosen for this second objective because being one of the primary sources of energy, its price can affect the prices of other assets and can itself be affected by factors by OPEC's production target and natural disasters. Therefore, its behavior is interesting to investigate. I´ll do so by testing for independence between the Dow Jones Industrial Average (DJIA) and Crude Oil prices, in order to statistically determine whether or not the values of the two are dependent of each other. 


## Data Set
The data set used contains the daily points obtained by the Dow Jones Industrial Average Index (DJIA), and the trading prices of two commodities, Gold and Crude Oil (WTI), from the dates on which all three data sets had values from April 25th, 2016 to April 25th, 2018. This gives us a total of 504 collected data points.
* DJIA - Dow Jones Industrial Average
* GCM8 - Gold Futures
* WTI - Crude Oil


### Equities
The Dow Jones Industrial Average (DJIA) was used as a proxy of the stock market, as it tracks the 30 large-cap U.S. companies which work as a good estimate on how the overall equity market is behaving. The 30 firms are vary in their sectors, and is widely considered as a reliable index for its low risk and volatility.

### Commodities
Commodities are defined as hard, tangible assets. The most commonly traded commodities are Gold, Oil and Agriculture. The Gold Futures Index (GCM8) was chosen for this comparison, a standard index used by investors worldwide. For Oil prices, West Texas Intermediate (WTI), the priced most used by investors, also considered the benchmark for oil pricing in the U.S, was chosen.


## Conclusions
* The old wives' tale that suggests that the equities market and Gold prices behave inversely (that is, as one increases, the other decreases) cannot be explained through the data. The results show that the DJIA index and the price of Gold are independent with 95% confidence, implying there is no correlation of one between the other. Yet, the best fit line does have a downward sloping trend, from which we can infer their is some kind of negative correlation, but is extremely weak from the statistical point of view. The same result can be observed when comparing with Oil - the value of the DJIA and Oil prices are also independent. This could lead us to hypothesize that equities and commodities are independent, but this data set is too small to ensure such conclusion. Further analysis should be done to investigate this question. 
* Oil prices are dependent on Gold Prices, with 95% confidence, therefore drawing a correlation between the prices of commodities. This correlation is small though, as seen through the residual plot that gold prices do not fully explain oil prices. This indicating that it can be one factor to take into consideration, but there are many other factors involved that we need to statistically quantify to appropriately model commodity prices.
* Both equities and commodities cannot be described as normally distributed. Even though all of our three data sets have a standardized mean of approximately 0, their standard deviation differs from such distribution. This leads us to conclude that, because both equities and commodities can be influenced drastically in certain random periods of time due to geopolitical, economical or social events, data from the markets will have random deviations that cannot be explained through statistical methods.


