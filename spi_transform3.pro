FUNCTION spi_transform3, rfe, g2_shape, g2_scale, g2_p_norain, g2_mean, g2_std, g2_pvals, g2_psum, g2_logsum, meanTH=meanTH, stdTH=stdTH
  ;
  ; this function takes a single rainfall value, shape (g2_shape), scale (g2_scale) and the
  ; probability of no rainfall and returns an SPI value for the given rainfall
  ; if the SPI is greater than 5 or lower than -5 then shape & scale will be recalculated
  ; with pvals (g2_pvals), psum (g2_psum), and logsum (g2_logsum)
  ; SPI will then be calculated again
  ; 
  ; if shape is over 10000, then it is assumed to be a gaussian distribution with a 
  ; mean equal to (g2_shape - 10000), and a standard deviation equal to g2_scale
  ;  
  ; Developed by: Greg Husak September 29, 2017
  ; Updated by: Robert Saldivar September 20, 2021
  ; 
  ; Inputs:
  ;   rfe: a single value of rainfall data, ints or floats should all work the same
  ;   g2_shape: the first distribution parameter. the shape of alpha if < 10000, otherwise the mean
  ;   g2_scale: the second distribution parameter. the scale or beta, or stddev if g2_shape > 10000
  ;   g2_p_norain: the probability of no rainfall for the given interval
  ;   g2_mean: mean of time series used to calc gamnormal params
  ;   g2_std: standard deviation of time series used to cal gamnormal params
  ;   g2_pvals: the number of positive values used to calculate the shape and scale
  ;   g2_psum: the value of rfe used to calculate the shape and scale
  ;   g2_logsum: the log value of rfe used to calculate the shape and scale
  ;   
  ; keywords:
  ;   meanTH: set to 1.1; if g2_mean is less than meanTH then SPI is 0
  ;   stdTH: set to 0.0; if g2_std is less than stdTH then SPI is 0
  ;   
  ; Output:
  ;   SPI: the zscore of the rfe based on the shape and scale
  ; 
  ;---------------------------------------------------------------------------------
  
  
  if (rfe lt 0) then return, zscore = -9999 ; If the incoming rfe is less than 0 then the zscore will be -9999
  
  normflag = 10000.       ; if g2_shape is greater than normflag then it is gaussian distribution

  if ~KEYWORD_SET(meanTH) then meanTH = 1.1       ; unless set, mean ThresHold = 1.1
  if ~KEYWORD_SET(stdTH)  then stdTH  = 0.00       ; unless set, stdev ThresHold = 0.0

  zscore   =     0.0

  ; if the mean or standard deviation is less than threshold then zscore is 0
  if(g2_mean lt meanTH  OR  g2_std lt stdTH) then begin
    zscore = 0
  endif else begin

    if g2_shape gt normflag then begin    ; use gaussian to calculate spi
      zscore = (rfe-(g2_shape-normflag)) / g2_scale
      if g2_p_norain ge 0.5 then zscore = 0.0 ; added 2017.11.16 - pete n greg
    endif else begin        ; use gamma to calculate spi

      ; use gamma distribution to calculate the spi values
      dbl_g2_shape = double(g2_shape)
      dbl_g2_scale = double(g2_scale)
      dbl_rfe      = double(rfe)
      
      if  dbl_rfe gt 0 then prfe = IGAMMA(dbl_g2_shape,dbl_rfe/dbl_g2_scale) $
      else prfe=0.          ; if rain is greater than 0 calculate

      prob = g2_p_norain + ((1.0 - g2_p_norain) * prfe) ; this is the prob of this event

      if g2_p_norain gt 0.5 AND dbl_rfe le 7.0 then prob = 0.5

          if (prob ge 1.0) then prob = double(0.99999) ; returns zscore of 4.26525
          if (prob lt 0.0) then prob = double(0.00001) ; returns zscore of -4.26525
      
      ;when (1-prob) is between 0.999999921-0.99999997 then zscore is -5.41998
      ;when (1-prob) is greather than 0.99999997 then zscore is -1.00000e+12
      ;when (1-prob) is between 0.000000089-0.000000030 then zscore is 5.41998
      ;when (1-prob) is less than 0.000000030 then zscore is 8.00
      
      zscore = gauss_cvf(1.0 - prob)
    endelse
  endelse
  
  ; if zscore is less than -5 or zscore is greater than 5 then recalculate shape, scale & no rain prob
  if (zscore lt -5 or zscore gt 5) and (zscore ne -9999) then begin
     
     ; recalculating no rain probability
     if (g2_p_norain ne -9999) and (rfe gt 0) then begin
      g2_new_p_norain = (31-(g2_pvals+1)/31)
     endif else begin
      g2_new_p_norain = g2_p_norain
     endelse
     
     ; recalculating shape and scale
     pvals = g2_pvals
     if (g2_shape ne -9999) and (g2_scale ne -9999) and (rfe gt 0) and (g2_pvals gt 0) then begin
      psum = g2_psum + rfe
      pvals = g2_pvals +1
      logsum = g2_logsum + alog(double(rfe))
      aveimage = psum/pvals
      bigA = alog(aveimage)-(logsum/pvals)
      if (bigA gt 0) then begin
        g2_new_shape = (1.0+sqrt((4.0*bigA/3.0)+1.0)) / (4.0*bigA)
        g2_new_scale = aveimage/g2_new_shape
      endif else begin
        g2_new_shape = 0.0
        g2_new_scale = 0.00001 ;prevents dividing by zero
      endelse
     endif else begin
      g2_new_shape = g2_shape
      g2_new_scale = g2_scale
     endelse
     
     ; recalculating the mean and standard deviation
     new_pixel = [g2_mean, rfe]
     if (g2_mean ne -9999) and (rfe ne -9999) then begin
      g2_new_mean = ((g2_mean*30) + rfe)/31
      g2_new_std = stddev(new_pixel)
     endif else begin
      g2_new_mean = g2_mean
      g2_new_std = g2_std
     endelse
     
     ; restarting the calculation of the zscore
     if (g2_new_mean lt meanTH or g2_new_std lt stdTH) then begin
      zscore = 0
     endif else begin
      
      if (g2_new_shape gt normflag) then begin ; use gaussian to calculate spi
        zscore = (rfe-(g2_new_shape-normflag)) / g2_new_scale
        if (g2_new_p_norain gt 0.5) then zscore = 0.0 ; added 2017.11.16 - pete n greg
      endif else begin ; use gamma to calculate spi
        
        ; use gamma distribution to calculate the spi values
        dbl_g2_shape_2 = double(g2_new_shape)
        dbl_g2_scale_2 = double(g2_new_scale)
        dbl_rfe_2      = double(rfe)
        
        if (dbl_rfe_2 gt 0) then prfe_2 = IGAMMA(dbl_g2_shape_2,dbl_rfe_2/dbl_g2_scale_2) $
          else prfe_2 = 0 ; if rain is greater than 0 calculate
          
          prob_2 = g2_new_p_norain + ((1.0 - g2_new_p_norain) * prfe_2) ; this is the prob of this event
          
          if (prob_2 ge 0.999990) then prob_2 = double(0.99999) ; returns zscore of 4.26525
          if (prob_2 lt 0.000010) then prob_2 = double(0.00001) ; returns zscore of -4.26525
          zscore = gauss_cvf(1.0 - prob_2)
        
      endelse
     endelse
  endif

  return,zscore ; return the SPI value

end
