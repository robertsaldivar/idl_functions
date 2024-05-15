; version 1.0.0
; 
; DOY_TO_CAL utility returns a 3 element array of ints of the calendar 
; date given day of the year and doy of the year as integers.
; 
; -- INPUT PARAMETERS --
; year
; doy, day of year
; 
; -- RETURN VALUE --
; Int array containing year, month, day.
; An array of [0, 0, 0] is returned if doy is out of bounds.
; 
; -- OPTIONAL INPUT PARAMETERS --
; 
; -- HISTORY --
; 2011/04/8, Marty Landsfeld created
;
; -- TODO --
; check input parameters type, write is_number() function.
;


FUNCTION DOY_TO_CAL, year, doy
    
  if (N_PARAMS() lt 2) then message, 'Incorrect number of parameters'

  IF(IS_LEAP(year)) THEN $
    d = [0,31,60,91,121,152,182,213,244,274,305,335,366] $
  ELSE $
    d = [0,31,59,90,120,151,181,212,243,273,304,334,365]
  
  IF(doy GT d[12] OR doy LT 1) THEN RETURN, [0,0,0]
  
  month = 1
  WHILE(doy GT d[month]) DO month++
  day = doy - d[month-1]
  
  return, [year, month, day]
  
END
