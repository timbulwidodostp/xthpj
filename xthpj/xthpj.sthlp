{smcl}
{* *! version 2.0  3December2025}{...}
{* *! Ryan Thombs, https://ryanthombs.com/}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[XT] xtreg" "help xtreg"}{...}
{vieweralsosee "[XT] xtset" "help xtset"}{...}
{viewerjumpto "Syntax" "xthpj##syntax"}{...}
{viewerjumpto "Description" "xthpj##description"}{...}
{viewerjumpto "Options" "xthpj##options"}{...}
{viewerjumpto "Demeaning Process" "xthpj##demeaning"}{...}
{viewerjumpto "Standard Errors" "xthpj##SE"}{...}
{viewerjumpto "Unbalanced Data" "xthpj##unbalanced"}{...}
{viewerjumpto "Estimating Long-Run Effects" "xthpj##lr"}{...}
{viewerjumpto "Estimating Heterogeneous Slopes" "xthpj##het"}{...}
{viewerjumpto "Examples" "xthpj##examples"}{...}
{viewerjumpto "Saved values" "xthpj##values"}{...}
{viewerjumpto "Author" "xthpj##author"}{...}
{viewerjumpto "References" "xthpj##references"}{...}
{title:Title}

{p2colset 5 14 19 2}{...}
{p2col:{bf: xthpj} {hline 2}}High dimensional half‐panel jackknife fixed‐effects estimator{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}{cmd:xthpj} {depvar} {indepvars} {ifin}, {cmdab:a:bsorb}({it:string}) {cmdab:lr}({it:string}) {cmdab:ecm} {cmdab:res:idual}({it:newvar}) {cmdab:savefe}


{synoptset 20 tabbed}{...}
{synopthdr:options}
{synoptline}
{synopt :{cmdab:a:bsorb}({it:string})}variables that identify the fixed effects to be absorbed. Pooled OLS is estimated when no variables are absorbed.{p_end}

{synopt :{cmdab:lr}({it:string})}specifies the variables to be included in the long-run cointegration vector.{p_end}

{synopt :{cmdab:ecm}}estimate an error-correction model, default is an autoregressive distributed lag (ARDL) model.{p_end}

{synopt :{cmdab:res:idual(newvar)}}save regression residuals.{p_end}

{synopt :{cmdab:savefe}}save fixed effects estimates.{p_end}
{synoptline}

{p 4 6 2}
Your data must be {cmd:xtset} before using {cmd:xthpj}; see {helpb xtset:[XT] xtset}.{p_end}
{p 4 6 2}
{it:indepvars} may contain factor variables; see {help fvvarlist}.{p_end}
{p 4 6 2}
{it:depvar} and all {it:varlists} may contain time-series operators; see {help tsvarlist}.{p_end}


{title:Contents}

{p 4}{help xthpj##description:Description}{p_end}
{p 4}{help xthpj##options:Options}{p_end}
{p 4}{help xthpj##demeaning:Demeaning Process}{p_end}
{p 4}{help xthpj##SE:Standard Errors}{p_end}
{p 4}{help xthpj##unbalanced:Unbalanced Data}{p_end}
{p 4}{help xthpj##lr:Estimating Long-Run Effects}{p_end}
{p 4}{help xthpj##het:Estimating Heterogeneous Slopes}{p_end}
{p 4}{help xthpj##examples:Examples}{p_end}
{p 4}{help xthpj##values:Saved values}{p_end}
{p 4}{help xthpj##author:Author}{p_end}
{p 4}{help xthpj##references:References}{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:xthpj} estimates the half‐panel jackknife fixed‐effects (HPJFE) estimator proposed by Chudik, Pesaran, and Yang (2018) and extends their approach 
by allowing for multiple levels of fixed effects. It is well-known that including a 
lagged dependent variable in a fixed effects regression with a small-T produces the 
Nickell bias (Nickell 1981). Chudik et al. (2018) further show that there is a small-T 
bias when any of the regressors are weakly exogeneous (regardless of whether a lagged dependent 
variable is included in the model). They show that their half‐panel jackknife approach corrects 
this bias (and size distortions) but requires that N,T -> infinity. However, T is allowed to grow 
at a slower rate than N, making it appropriate to use in large N/moderate T cases.

{pstd}
The HPJFE approach has a practical advantage over other estimators that correct the Nickell bias because it is a simple extension of the traditional fixed effects estimator. 
The HPJFE estimator works by taking the full sample of T and splitting each panel in half. Using the
full sample (B) and the two halves (Ba and Bb), the estimate of beta is then:

					2B – ½(Ba + Bb)
					
{pstd}					
In other words, the estimate is equal to twice the coefficient on the full sample minus half the coefficients on the subsamples using the traditional fixed effects estimator.
The HPJFE estimator requires an even number of time periods, which {cmd:xthpj} determines internally and drops the first temporal point as necessary.


{marker options}{...}
{title:Options}

{phang}
{cmdab:a:bsorb}({it:string}) variables that identify the fixed effects to be absorbed. Pooled OLS is estimated when no variables are absorbed.

{phang}
{cmdab:lr}({it:string}) specifies the variables to be included in the long-run cointegration vector.

{phang}
{cmdab:ecm} estimate an error-correction model, default is an autoregressive distributed lag (ARDL) model.

{phang}
{cmdab:res:idual(newvar)} save regression residuals.

{phang}
{cmdab:savefe} save fixed effects estimates.


{marker demeaning}{...}
{title:Demeaning Process}

{pstd}
{cmd:xthpj} allows for many levels of fixed effects. The data are demeaned using Correia's (2017) {cmd:reghdfe} program. For a full description of this process see the
help page for {help reghdfe} and {browse "http://scorreia.com/help/reghdfe_programming.html":reghdfe_programming}. Reghdfe version 6.12.3 is used with {cmd:xthpj}, which
can be installed from within Stata by typing {stata ssc install reghdfe:ssc install reghdfe}.


{marker SE}{...}
{title:Standard Errors}

{pstd}
The reported standard errors are based on equation 24 in Chudik, Pesaran, and Yang (2018).


{marker unbalanced}{...}
{title:Unbalanced Data}

{pstd}
Unbalanced datasets are supported. Cases with at least four observations are included in the analysis. This
ensures that each case contributes to the estimate for the full sample and the two halves. {cmd:xthpj} 
internally determines the total sample for each unit and divides the sample equally into two halves. If there 
are gaps, the data are stacked into two halves. 


{marker lr}{...}
{title:Estimating Long-Run Effects}

{pstd}
Long-run effects can be directly estimated with {cmd:xthpj} two different ways. The first is by using an autoregressive distributed lag (ARDL) model.
Users can estimate an ARDL by including the necessary variables in the long-run cointegration vector with the {cmdab:lr} option.
Users can also estimate an error correction model (ECM) by including only the lags of the variables in the {cmdab:lr} option and specifying the {cmdab:ecm} 
option. Examples are provided in the examples section.


{marker het}{...}
{title:Estimating Heterogeneous Effects}

{pstd}
Heterogeneous slopes can be estimated with the {cmdab:savefe} option. Heterogeneous slopes will be estimated for the full and two half samples. 
The user can then manually estimate the coefficient. Although there is no straightforward approach to estimating
 standard errors, the estimates can be bootstrapped. Examples are provided in the examples section.

{marker examples}{...}
{title:Examples}

{pstd}
An example dataset from Chudik, Pesaran, and Yang (2018) is available {browse "https://github.com/rthombs/xthpj/blob/main/chudik_jackknife_data.dta":here}. The
dataset contains annual observations for the 48 contiguous U.S. states from 1985–1997. The dataset was originally used by Donohue and Levitt (2001) to study 
the effect of legalized abortion on crime rates. 

{marker SDmodels}
{pstd}{cmd:xtset} data{p_end}

{phang2}{stata xtset state year}{p_end}

{p 2}{ul: Static Model}{p_end}
{pstd}Static model (Table 6, Column 1b in Chudik, Pesaran, and Yang (2018)){p_end}

{phang2}{stata xthpj y_viol x_viol prisoners police unemployment income poverty afdc weapons beer, absorb(state year)}{p_end}

{p 2}{ul: Dynamic Models}{p_end}
{pstd}Dynamic model (ARDL(1,0)) (Table 7, Column 1b in Chudik, Pesaran, and Yang (2018)){p_end}

{phang2}{stata xthpj y_viol l.y_viol x_viol prisoners police unemployment income poverty afdc weapons beer, a(state year)}{p_end}

{pstd}ARDL(1,0) with long-run effects estimated{p_end}

{phang2}{stata xthpj y_viol, lr(l.y_viol x_viol prisoners police unemployment income poverty afdc weapons beer) a(state year)}{p_end}

{pstd}ARDL(1,1) with long-run effects estimated{p_end}

{p 8}{stata xthpj y_viol, lr(l.y_viol l(0/1).(x_viol prisoners police unemployment income poverty afdc weapons beer)) a(state year)}{p_end}

{pstd}ECM(1,1) with long-run effects estimated{p_end}

{phang2}{stata xthpj d.y_viol d.x_viol d.prisoners d.police d.unemployment d.income d.poverty d.afdc d.weapons d.beer, lr(l.(y_viol x_viol prisoners police unemployment income poverty afdc weapons beer)) a(state year) ecm}{p_end}

{p 2}{ul: Heterogeneous Short-Run Effects}{p_end}
{pstd}Assuming one is interested in whether the effect of poverty varies across states, the following model can be estimated:{p_end}

{p 8}{stata xthpj y_viol x_viol prisoners police unemployment income afdc weapons beer, absorb(state year i.state##c.poverty) savefe}{p_end}

{pstd}This will create new variables in your dataset with the prefixes full_ a_ and b_, which represent the estimates for the 
full sample and each half. Then, one can create new columns for each estimate so there are no missing data:{p_end}

{p 8}{stata by state: by state: egen bt = mode( full___hdfe3__Slope1 )}{p_end}
{p 8}{stata by state: by state: egen ba = mode( a___hdfe3__Slope1 )}{p_end}
{p 8}{stata by state: by state: egen bb = mode( b___hdfe3__Slope1 )}{p_end}

{pstd}Now, a short-run coefficient for each state can be estimated:{p_end}

{p 8}{stata gen beta = (2*bt)-0.5*(ba)-0.5*(bb)}{p_end}

{pstd}To get standard errors, one can bootstrap the mean estimate. To do so, first create a variable that 
tags one distinct observation per group:{p_end}

{p 8}{stata egen cluster = tag( full___hdfe3__Slope1)}{p_end}

{pstd}Then run the {cmd:bootstrap} command:{p_end}

{p 8}{stata bootstrap: bootstrap r(mean): sum beta if cluster==1}{p_end}

{pstd}Set a seed to get reproducible results:{p_end}

{p 8}{stata bootstrap: bootstrap r(mean), seed(1234): sum beta if cluster==1}{p_end}

{p 2}{ul: Heterogeneous Short-Run and Long-Run Effects}{p_end}
{pstd}Obtaining heterogeneous long-run effects is a simple extension of the prior example. 
First, estimate a dynamic model allowing poverty and the lag of the dependent variable to vary acorss states.
A new variable equivalent to the lag of the dependent variable needs to be generated as the internal demenaing 
process of {cmd:reghdfe} does not like time series operators:{p_end}

{p 8}{stata gen ly = l.y_viol}{p_end}

{pstd}Instead of including the lag of the y_viol as an independent variable, include it as a variable to be absorbed:{p_end}

{p 8}{stata xthpj y_viol x_viol prisoners police unemployment income afdc weapons beer, absorb(state year i.state##c.ly i.state##c.poverty) savefe}{p_end}

{pstd}Then follow the same steps from the previous example:{p_end}

{p 8}{stata by state: by state: egen bt_lag = mode( full___hdfe3__Slope1 )}{p_end}
{p 8}{stata by state: by state: egen ba_lag = mode( a___hdfe3__Slope1 )}{p_end}
{p 8}{stata by state: by state: egen bb_lag = mode( b___hdfe3__Slope1 )}{p_end}

{p 8}{stata by state: by state: egen bt_pov = mode( full___hdfe4__Slope1 )}{p_end}
{p 8}{stata by state: by state: egen ba_pov = mode( a___hdfe4__Slope1 )}{p_end}
{p 8}{stata by state: by state: egen bb_pov = mode( b___hdfe4__Slope1 )}{p_end}

{pstd}Estimate short-run coefficients for each state:{p_end}

{p 8}{stata gen beta_ly = (2*bt_lag)-0.5*(ba_lag)-0.5*(bb_lag)}{p_end}
{p 8}{stata gen beta_pov = (2*bt_pov)-0.5*(ba_pov)-0.5*(bb_pov)}{p_end}

{pstd}Create a variable that tags one distinct observation per group:{p_end}

{p 8}{stata egen cluster = tag( full___hdfe3__Slope1)}

{pstd}Run the {cmd:bootstrap} command to get the standard errors for the short-run coefficients:{p_end}

{p 8}{stata bootstrap: bootstrap r(mean), rep(1000) seed(1234): sum beta_ly if cluster==1}{p_end}
{p 8}{stata bootstrap: bootstrap r(mean), rep(1000) seed(1234): sum beta_pov if cluster==1}{p_end}

{pstd}To get the long-run effect of poverty, manually calculate it. Because this is an ARDL(1,0) model, divide 
the poverty coefficient by 1-beta_ly:{p_end}

{p 8}{stata gen lr_pov = beta_pov/(1-beta_ly)}{p_end}

{pstd}Run the {cmd:bootstrap} command to get the standard errors for the long-run coefficient:{p_end}

{p 8}{stata bootstrap: bootstrap r(mean), rep(1000) seed(1234): sum lr_pov if cluster==1}

{marker values}{...}
{title:Saved Values}

{pstd}
{cmd:xthpj} saves the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt:{cmd:e(N_full)}}number of observations{p_end}
{synopt:{cmd:e(N_a)}}number of observations for first half of sample{p_end}
{synopt:{cmd:e(N_b)}}number of observations for second half of sample{p_end}
{synopt:{cmd:e(N_g)}}number of groups (cross-sectional units){p_end}
{synopt:{cmd:e(T_min)}}minimum time periods{p_end}
{synopt:{cmd:e(T_avg)}}average time periods{p_end}
{synopt:{cmd:e(T_max)}}maximum time periods{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt:{cmd:e(time)}}name of time variable{p_end}
{synopt:{cmd:e(ivar)}}name of unit variable{p_end}
{synopt:{cmd:e(cmd)}}{cmd:xthpj}{p_end}
{synopt:{cmd:e(cmdline)}}command line {p_end}
{synopt:{cmd:e(properties)}}properties of the estimation command {p_end}
{synopt:{cmd:e(depvar)}}name of dependent variable {p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}coefficient vector{p_end}
{synopt:{cmd:e(V)}}variance-covariance matrix{p_end}
{synopt:{cmd:e(b_full)}}coefficient vector for full sample{p_end}
{synopt:{cmd:e(b_a)}}coefficient vector for first half of sample{p_end}
{synopt:{cmd:e(b_b)}}coefficient vector for second half of sample{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}

{pstd}
In addition to the above, the following is stored in {cmd:r()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}    
{synopt:{cmd:r(table)}}matrix containing the coefficients with their standard errors, test statistics, p-values, and confidence intervals{p_end}

{marker author}{...}
{title:Author}

{pstd}
Ryan Thombs, Penn State University, {browse "https://ryanthombs.com/"}


{marker references}{...}
{title:References}

{phang}
Chudik, A., Pesaran, M.H., and Yang, J.C. 2018. Half‐panel jackknife fixed‐effects estimation of linear panels with weakly exogenous regressors. {it:Journal of Applied Econometrics} 33(6): 816-836.

{phang}
Correia, S. 2017. Linear Models with High-Dimensional Fixed Effects: An Efficient and Feasible Estimator. Working Paper. {browse "http://scorreia.com/research/hdfe.pdf"}.

{phang}
Donohue, J. J. III, and Levitt, S. D. 2001. The impact of legalized abortion on crime. {it:Quarterly Journal of Economics} 116: 379–420.

{phang}
Nickell, S. 1981. Biases in dynamic models with fixed effects. {it:Econometrica: Journal of the Econometric Society}: 1417-1426.



