FUNCTION spi_transform2, rfe, g2_shape, g2_scale, g2_p_norain, g2_mean, g2_std, g2_flag, meanTH=meanTH, stdTH=stdTH

  ;   this is a copy of SPI_TRANSFORM.pro that we will edit to get gamnorm2 forward back to work...  - pete 2018.07
  ; start out exact....

  ;;;;;
  ; this function takes a single rainfall value, shape (g2_shape), scale (g2_scale) and the
  ; probability of no rainfall and returns an SPI value for the given rainfall.
  ;
  ; there is no error checking to make sure parameter values are valid
  ;
  ; this piece is a small function of the "precip_2_spi" function, and assumes that
  ; distribution parameters are already calculated.
  ;
  ; if shape is over 10000, then it is assumed to be a gaussian distribution with a
  ; mean equal to (g2_shape - 10000), and a standard deviation equal to g2_scale
  ;
  ; DEVELOPED BY: Greg Husak      September 29, 2017
  ;
  ; USAGE: spi = SPI_TRANSFORM(rfe,g2_shape,g2_scale,g2_p_norain)
  ; rfe         = a single value of rainfall data.  ints or floats should all work the same
  ; g2_shape    = the first distribution parameter.  the shape or alpha if < 10000, otherwise the mean
  ; g2_scale    = the second distribution parameter.  the scale or beta, or stddev if g2_shape > 10000
  ; g2_p_norain = the probability of no rainfall for the given interval
  ; g2_mean     = mean of time series used to calc gamnormal params
  ; g2_std      = standard deviation of time series used to calc gamnormal params
  ; g2_flag     = flag parameter.
  ;
  ;
  ;;;;;

  normflag = 10000.       ; if g2_shape is greater than normflag then it is gaussian distribution

  if ~KEYWORD_SET(meanTH) then meanTH = 1.0       ; unless set, mean ThresHold = 1.0
  if ~KEYWORD_SET(stdTH)  then stdTH  = 0.3       ; unless set, stdev ThresHold = 0.3

  zscore   =     0.0

  if(g2_mean lt meanTH  OR  g2_std lt stdTH) then begin
    zscore = 0
  endif else begin

    if g2_shape gt normflag then begin    ; use gaussian to calculate spi
      zscore = (rfe-(g2_shape-normflag)) / g2_scale
      if g2_p_norain gt 0.5 then zscore = 0.0 ; added 2017.11.16 - pete n greg
    endif else begin        ; use gamma to calculate spi

      ; use gamma distribution to calculate the spi values
      dbl_g2_shape = double(g2_shape)
      dbl_g2_scale = double(g2_scale)
      dbl_rfe      = double(rfe)


      if  dbl_rfe gt 0 then prfe = IGAMMA(dbl_g2_shape,dbl_rfe/dbl_g2_scale) $
      else prfe=0.          ; if rain is greater than 0 calculate

      prob = g2_p_norain + ((1.0 - g2_p_norain) * prfe) ; this is the prob of this event

      if g2_p_norain gt 0.5 AND dbl_rfe le 7.0 then prob = 0.5

      if prob ge 1.0 then prob = double(0.99999)
      zscore = gauss_cvf(1.0 - prob)

    endelse

  endelse

  return,zscore ; return the SPI value

end




