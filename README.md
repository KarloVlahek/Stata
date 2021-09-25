# Stata
The Effects of the Slave Trades on Literacy Rate in Modern Day Africa

I take the relevant portions of the paper that give a general background for its motivation, and the interpretation of my code (i.e. - results). This paper recieved the Robert B. Carson Award at SUNY Oneonta (my alma mater) for the top paper in economics. Additionally, it recieved first place in the New York State Economoics Association undergraduate writring paper. There are certainly shortcomings of my thesis, which I discuss in section 5 of my [paper](https://www.linkedin.com/in/karlovlahek/detail/overlay-view/urn:li:fsd_profileTreasuryMedia:(ACoAAB7rVTEBIyTXj9z-rFTyeBeDmOwrJnxvyq8,1603152022744)/). 

Thanks for stopping by!

[Abstract]: Studies provide evidence of the impact of the slave trade in Africa and its current underdevelopment. In this paper, I show the slave trade in Africa still affects its current level of literacy rate. I combine data on African literacy rates at the regional level from the Demographic and Health Survey (DHS) with data on slave export intensity. I find a negative and significant relationship between slave export intensity and the modern literacy rate.  I control for the State Fragility Index and find a negative relationship between slave exports and literacy rates. Thus I show the long-term effects of the slave trade and its impacts that persist today. 

[Empirical Model and Results]: I first examine the relationship between the current literacy rate and slave export intensity using only the measure of literacy rate. My ordinary least squares (OLS) regression follows as:

 Education=β_0+β_1 Export+e							   (1)

where Education represents the literacy rate or primary education of a given region. Export is the identifier for my slave trade variables. This takes the form of Export/Area or Export/Pop. The variations introduced by Area and Pop account for the ethnic boundaries and populations specified in the Data section. 
Ordinary least squares (OLS) estimates of the baseline equations for literacy rate are reported in Table 2. Columns (1) – (4) represent the modern literacy rate by region. Column (1) reports estimates using slave export intensity weighed by ethnic boundaries of the nineteenth century. I find that the slave export intensity weighed by ethnic boundaries is negatively correlated with the modern literacy rate, and the correlation is significant at the 1 percent level. Column (2) takes slave export intensity weighed over the ethnic population during the colonial period as defined by Murdock. A stronger, negative magnitude is found between slave export intensity and modern literacy rate significant at the 1 percent level. That is, when weighed by ethnic population, a 1 unit increase in slave export intensity decreases literacy by 0.216.
Finally, to measure the percentage change in slave export intensity I take the natural log of both variations in Columns (3) and (4). In column (3) there is a 0.107 percent decrease in modern literacy for every 1 percent increase in slave export intensity weighed by ethnic boundaries of the nineteenth century. The percentage change in Column (3) is significant at the 1 percent level. Column (4) takes the percentage change between modern literacy rate and slave export intensity weighed by ethnic populations of the nineteenth century. I find there is a 0.501 percent decrease in modern literacy rate per region for every 1 percent increase in slave export intensity, and the percent change is significant at the 1 percent level.
In Table 3, I provide the results for primary educational attainment. Column (1) reports estimates using slave export intensity weighed over the nineteenth century ethnic boundaries. I find a negative correlation between slave export intensity and primary education significant at the 1 percent level. The same conclusion can be drawn from column (2). Weighing slave export intensity by ethnic boundaries yields a weaker magnitude than in Table 2 but is still significant at the 1 percent level. Weaker results in primary education are expected as primary education is a smaller measure of literacy.
Taking the natural log of the two variations in slave export intensity yields significant percent changes at the 1 percent level. In column (3) there is a 0.053 percent decrease in primary education rate for every 1 percent increase in slave export intensity weighed by the nineteenth century ethnic boundaries defined by Murdock (1959). Column (4) yields a stronger magnitude where a 1 percent increase in slave export intensity decreases the primary education rate by 0.245 percent.

[Controlling for Ommited Variables]: Although the negative correlation between slave export intensity and literacy rate reflects my hypothesis, omitted variables further explain the correlation. For example, if regional areas are already susceptible to lower literacy rates during the slave trade, and if that lack of literacy persists today, this may create a negative correlation between the slave trade and literacy rate. I control for variables such as colonialism, pre-colonial prosperity, settlement patterns, jurisdictional hierarchy, European influence, and modern institutions.

