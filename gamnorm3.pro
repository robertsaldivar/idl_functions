FUNCTION gamnorm3, raincube, xdim, ydim, zdim, badvalue
  ; 
  ; this function will read in precip data for each of the years
  ; in the precip climatology. gamma parameters will then be
  ; calculated for the cube and these parameters will be written out to file
  ; this function calculates the alpha, beta and norain values for
  ; the input raincube from the program
  ;
  ; inputs:
  ;   raincube: incoming historical rain array
  ;   xdim: x-dimension of the raincube
  ;   ydim: y-dimension of the raincube
  ;   zdim: z-dimension (years) of the raincube
  ;   badvalue: value to be ignored; typically -9999
  ;   
  ; outputs:
  ;   gp_shape: gamnorm_params[*,*,0], shape
  ;   gp_scale: gamnorm_params[*,*,1], scale
  ;   gp_norain_prob: gamnorm_params[*,*,2], probability of no rain
  ;   gp_stdev: gamnorm_params[*,*,3], standard deviation of raincube
  ;   gp_pvals: gamnorm_params[*,*,4], positive values of raincube
  ;   gp_mean_value: gamnorm_params[*,*,5], mean value of raincube
  ;   gp_psum: gamnorm_params[*,*,6], value of raincube
  ;   gp_logsum: gamnorm_params[*,*,7], log value of raincube
  ;----------------------------------------------------------------------
  ;  ***  pete added these next 3 lines 2023.11.21  ---------------------
  ;  *** Robert moved to this code chunk to /home/chc-source/saldivar/code/pros/make_gamnorm3.pro
;  a = [[''],['   gp_shape: gamnorm_params[*,*,0], shape'], ['   gp_scale: gamnorm_params[*,*,1], scale'], ['   gp_norain_prob: gamnorm_params[*,*,2], probability of no rain'], ['   gp_stdev: gamnorm_params[*,*,3], standard deviation of raincube']]
;  b = [['   gp_pvals: gamnorm_params[*,*,4], positive values of raincube'], ['   gp_mean_value: gamnorm_params[*,*,5], mean value of raincube'], ['   gp_psum: gamnorm_params[*,*,6], value of raincube'], ['   gp_logsum: gamnorm_params[*,*,7], log value of raincube']]
;  gp_hdr = [[a],[b],['']]
  ;----------------------------------------------------------------------
  
  gampar        = DBLARR(xdim,ydim,8) + badvalue    ; added stdev, max, mean and flag layers 2018.02.15
  aveimage      = DBLARR(xdim,ydim)
  nyears        = DOUBLE(zdim)
  normthresh    = double(160)                     ;   threshold for shape param

  for x=0,xdim-1 do begin
    for y=0,ydim-1 do begin
      pixel = raincube[x,y,*]      ; suggested change - pete 2018.02
      gampar[x,y,3] = stddev(pixel)
      gampar[x,y,5] = mean(pixel)
      pvals  =        0                       ; number of positive values can be integer - pete
      psum   = double(0)                        ; sum of positive values
      logsum = double(0)

      for z=0,nyears-1 do begin   ; can probable rework this loop    - pete
        if pixel[z] gt 0 AND pixel[z] ne badvalue then begin
          psum = psum + pixel[z]    ; sum up read pixel data into array ; changed this 2018.02.16 - pet
          pvals = pvals + 1             ;   keep track of # of good data
          logsum = logsum + alog(DOUBLE(pixel[z]))
        endif
      endfor
      
      ;check to see if pixel is masked.  if the pixel is a water pixel
      ;set parameter values to default.  if the pixel is not masked
      ;then calculate the parameter values for that pixel.

      if pixel[0] eq badvalue then begin    ; assumes if first value of time series for pixel is bad, they are all bad...
        aveimage[x,y]   = double(badvalue)
        gampar[x,y,*]   = double(badvalue)
      endif else begin
        if psum eq 0 then begin
          aveimage[x,y]   = double(0)
          gampar[x,y,0:1] = double(0)
          gampar[x,y,2]   = double(1)
        endif else begin
          ;calculate the average
          if pvals gt 0 then aveimage[x,y] = psum / pvals ELSE aveimage[x,y] = 0

          ;calculate the percent of no rain events in the pixel array
          gampar[x,y,2] = (nyears - pvals) / nyears

          if pvals gt 1 then begin
            bigA = alog(aveimage[x,y]) - (logsum/pvals)   ; what is bigA? - pete
            if bigA gt 0 then begin
              gampar[x,y,0] = (1.0+sqrt((4.0*bigA/3.0)+1.0)) / (4.0*bigA)
              gampar[x,y,1] = aveimage[x,y] / gampar[x,y,0]
            endif else begin
              gampar[x,y,0] = 0.0
              gampar[x,y,1] = 0.00001 ; this is to prevent dividing by zero in spi_transform3
            endelse
          endif else begin
            gampar[x,y,0] = 0.0
            gampar[x,y,1] = 0.00001
          endelse
        endelse
      endelse

      ; if shape value is greater than 'normthresh' then calculate mean and std
      if gampar[x,y,0] gt normthresh AND pvals gt 1 then begin
        gampar[x,y,0] = 10000.00 + (psum / pvals)
        gampar[x,y,1] = STDDEV(pixel(where(pixel gt 0)))
      endif
      if(mean(pixel) lt 1) then gampar[x,y,2] = badvalue    ;  do not calculate is mean of precip less than 1 mm
    
    ; these parameters are to be used to calculate a new shape, scale and no rain probability in the spi_transform3
      gampar[x,y,4] = pvals
      gampar[x,y,6] = psum
      gampar[x,y,7] = logsum
    
    endfor  ; enx y loop
  endfor  ; enx x loop
  
  gampar[*,*,0] = reverse(gampar[*,*,0],2)
  gampar[*,*,1] = reverse(gampar[*,*,1],2)
  gampar[*,*,2] = reverse(gampar[*,*,2],2)
  gampar[*,*,3] = reverse(gampar[*,*,3],2)
  gampar[*,*,4] = reverse(gampar[*,*,4],2)
  gampar[*,*,5] = reverse(gampar[*,*,5],2)
  gampar[*,*,6] = reverse(gampar[*,*,6],2)
  gampar[*,*,7] = reverse(gampar[*,*,7],2)
  
  return, gampar
END
