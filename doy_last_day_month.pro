function doy_last_day_month, year, month
  ;
  ;
  ; this function is going to return the the last day of month as day of year.
  ; 
  ; inputs:
  ;   year: the year that is being evaluated
  ;   month: the month that is being evaluated
  ;   
  ; outputs: returns the last day of the input month in day of year format as an integer.
  ;
  ;
  ;---------------------------------------------------------------------------------------
  ;
  
  
  last_day_of_month = [31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]
  
  if is_leap(year) then last_day_of_month = [last_day_of_month[0], last_day_of_month[1:11]+1]
  
  return, last_day_of_month[month-1]
  
end