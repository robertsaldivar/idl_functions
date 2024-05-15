; version 1.0.0
; 
; N_DAYS_MONTH utility returns the number of days in a given
; the year and month as integers.
; 
; -- INPUT PARAMETERS --
; year, integer
; month, integer
;
; -- RETURN VALUE --
; the number of days in a given the year and month as integers.
; 
; -- OPTIONAL INPUT PARAMETERS --
; 
; -- HISTORY --
; 2011/04/7, Marty Landsfeld created
;
; -- TODO --
; check number of input parameters and type
; could add ability to send month in as a 3 letter string and 
; full word string
;

FUNCTION N_DAYS_MONTH, year, month

  
  n_days = [31,28,31,30,31,30,31,31,30,31,30,31]
  IF(IS_LEAP(year)) then n_days[1] = 29
  
  return, n_days[month-1]
  
END
  