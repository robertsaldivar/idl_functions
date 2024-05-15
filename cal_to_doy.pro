; version 1.0.0
; 
; CAL_TO_DOY utility returns the day of the year (DOY) given
; the year, month and day as integers.
; 
; -- INPUT PARAMETERS --
; year
; month
; day
; 
; -- RETURN VALUE --
; day of the year, integer
; 
; -- OPTIONAL INPUT PARAMETERS --
; none
; 
; -- HISTORY --
; 2011/4/6, Marty Landsfeld created
; 2011/4/15, ML added header
; 
; -- TODO --
; check number of input params and type
;

FUNCTION CAL_TO_DOY, year, month, day
    
  jul_day_1_1 = JULDAY(1, 1, year)
  jul_day = JULDAY(month, day, year)
  day_of_year = jul_day - jul_day_1_1 + 1
  
  return, day_of_year
  
END
