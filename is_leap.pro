; version 1.0.0
; 
; IS_LEAP utility returns true or false if the year is a leap year.
; 
; -- INPUT PARAMETERS --
; year; integer
; 
; -- RETURN VALUE --
; true or false if the year is a leap year.
; 
; -- OPTIONAL INPUT PARAMETERS --
; 
; -- HISTORY --
; 2011/01/12, Marty Landsfeld created
;
; -- TODO --
; check number of input parameters and type
;

FUNCTION IS_LEAP, year
  
  day_of_year_3_1 = 59
  
  jul_day_1_1 = JULDAY(1, 1, year)
  jul_day_3_1 = jul_day_1_1 + day_of_year_3_1
  CALDAT, jul_day_3_1, month, day

  if(month EQ 3) then return, 0 $
  else return, 1
  
END
