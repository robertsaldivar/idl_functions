; this program will read in precip data for each of the years
; in the precip climatology.  gamma parameters will then be
; calculated for the cube and these parameters will be 
; written out to file.


FUNCTION gamnorm2, raincube, xdim, ydim, zdim, badvalue, MIN_POSOBS=MIN_POSOBS

; this function calculates the alpha, beta and norain values for
; the input raincube from the program
  ;print,  GAMNORM_PARAMS_HDR
  ; raincube    = incoming historical rain array
  ; xdim        = x-dimension of the raincube
  ; ydim        = y-dimension of the raincube
  ;print, GAMNORM_PARAMS_HDR2
;	gp_shape       = gamnorm_params(*,*,0)
;	gp_scale       = gamnorm_params(*,*,1)
;	gp_norain_prob = gamnorm_params(*,*,2)
;	gp_stdev       = gamnorm_params(*,*,3)
;	gp_max_value   = gamnorm_params(*,*,4)
;	gp_mean_value  = gamnorm_params(*,*,5)
;	gp_flags       = gamnorm_params(*,*,6)
;	gp_num_zeroes  = gamnorm_params(*,*,7)



; zdim        = z-dimension (years) of the raincube
; badvalue    = value to be ignored, typically -9999

;	USAGE:
;	res = gamnorm2(raincube, xdim, ydim, zdim, badvalue)
;
;	res(*,*,0) = shape
;	res(*,*,1) = scale
;	res(*,*,2) = norain_prob
;	res(*,*,3) = stdev
;	res(*,*,4) = max_value
;	res(*,*,5) = mean_value
;	res(*,*,6) = flags	;	no be extended. So far: 1 = not enough non-zeros
;	res(*,*,7) = num_zeroes      ;	# of zeroes


gampar        = DBLARR(xdim,ydim,8) + badvalue		;	added stdev, max, mean and flag layers 2018.02.15
gampar(*,*,6) = 0
aveimage      = DBLARR(xdim,ydim)
nyears        = DOUBLE(zdim)
normthresh    = double(160)                 		; 	threshold for shape param
if ~KEYWORD_SET(MIN_POSOBS) then MIN_POSOBS    = 12       ; unless we get this many non-zero rain events, return all 0 spi vals

;	zerocount = fltarr(xdim,ydim,zdim)
;	zerocount(where(raincube eq 0)) = 1
;	res(*,*,7) = total(zerocount, /3)


for x=0,xdim-1 do begin
    for y=0,ydim-1 do begin
	pixel = raincube(x,y,*)				;	suggested change - pete 2018.02
	gampar(x,y,3) = stdev(pixel)
	gampar(x,y,4) = max(pixel)
	gampar(x,y,5) = mean(pixel)
      	pvals  =        0                       ; number of positive values	can be integer - pete
      	psum   = double(0)                        ; sum of positive values
      	logsum = double(0)
      
      	for z=0,nyears-1 do begin		;	can probable rework this loop    - pete
            if pixel(z) gt 0 AND pixel(z) ne badvalue then begin
;          	psum = psum + raincube(x,y,z)	;	sum up read pixel data into array
          	psum = psum + pixel(z)		;	sum up read pixel data into array	; changed this 2018.02.16 - pet
          	pvals = pvals + 1           	; 	keep track of # of good data
          	logsum = logsum + alog(DOUBLE(pixel(z)))
            endif
      	endfor

	if(pvals lt MIN_POSOBS) then gampar(x,y,6) = 1 ; not enough non-zeros	;;;	figure out how to incorporate this... - pete
	gampar(x,y,7) = zdim - pvals

      	;check to see if pixel is masked.  if the pixel is a water pixel
      	;set parameter values to default.  if the pixel is not masked 
      	;then calculate the parameter values for that pixel.

      	if pixel(0) eq badvalue then begin		;	assumes if first value of time series for pixel is bad, they are all bad...
        	aveimage(x,y)   = double(badvalue)
        	gampar(x,y,*)   = double(badvalue)
      	endif else begin
      	    if psum eq 0 then begin
        	aveimage(x,y)   = double(0)
        	gampar(x,y,0:1) = double(0)
        	gampar(x,y,2)   = double(1)
	    endif else begin
            	;calculate the average
            	if pvals gt 0 then aveimage(x,y) = psum / pvals ELSE aveimage(x,y) = 0

            	;calculate the percent of no rain events in the pixel array
            	gampar(x,y,2) = (nyears - pvals) / nyears

            	if pvals gt 1 then begin
          	    bigA = alog(aveimage(x,y)) - (logsum/pvals)		;	what is bigA? - pete
          	    if bigA gt 0 then begin
            	    	gampar(x,y,0) = (1.0+sqrt((4.0*bigA/3.0)+1.0)) / (4.0*bigA)
            	    	gampar(x,y,1) = aveimage(x,y) / gampar(x,y,0)
          	    endif else begin
            	    	gampar(x,y,0) = 0.0
            	    	gampar(x,y,1) = 0.0
		    endelse
            	endif else begin
          		gampar(x,y,0) = 0.0
          		gampar(x,y,1) = 0.0
            	endelse
	    endelse
      	endelse

      	; if shape value is greater than 'normthresh' then calculate mean and std

      	if gampar(x,y,0) gt normthresh AND pvals gt 1 then begin
        	gampar(x,y,0) = 10000.00 + (psum / pvals)
        	gampar(x,y,1) = STDEV(pixel(where(pixel gt 0)))
      	endif
    	if(mean(pixel) lt 1) then gampar(x,y,2) = badvalue		;	 do not calculate is mean of precip less than 1 mm
    endfor	;	enx y loop
endfor	;	enx x loop

return, gampar

END

