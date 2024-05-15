function doy_last_day_dekad, year, month, day
  ;
  ;
  ; this function returns the last day of the dekad in day of year format
  ; 
  ; inputs:
  ;   year: the year being that the day and dekad are being evaluated in
  ;   month: the month that the day and dekad are being evaluated in
  ;   day: A day in the dekad that is begin evaluated.
  ;   
  ; output: will return the last in of a dekad in day of year format as an integer.
  ;
  ;--------------------------------------------------------------------------------
  
  
  last_day_dekad = [10, 20, 31, 41, 51, 59, 69, 79, 90, 100, 110, 120, 130, 140, 151, 161, 171, 181, 191, 201, 212, 222, 232, 243, 253, 263, 273, 283, 293, 304, 314, 324, 334, 344, 354, 365]
  
  
  if is_leap(year) then  last_day_dekad = [last_day_dekad[0:4], last_day_dekad[5:35]+1]
  
  last_day_dekad = last_day_dekad[get_current_period_year('dekad', year, month, day)-1]
  
  return, last_day_dekad
  
end 
  
  