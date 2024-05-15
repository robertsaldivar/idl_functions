function doy_first_day_month, year, month
  ;
  ;
  ; this function is going to return the the firts day of month as day of year.
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
  
  
  first_day_of_month = [1, 32, 60, 91,  121, 152, 182, 213, 244, 274, 305, 335]
  
  if is_leap(year) then first_day_of_month = [first_day_of_month[0:1], first_day_of_month[2:11]+1]
  
  return, first_day_of_month[month-1]
  
end
