function n_days_year, year
  ;
  ; This function returns the number of days in the year
  ; 
  ; input:
  ;   year: the year that is being evaluated
  ;   
  ; output: 
  ;   n_days: the number of days in a year as an integer
  ;
  ;-------------------------------------------------------------------------
  
  n_days = 365
  if (is_leap(year) eq 1) then n_days = 366
  
  return, n_days
  
end

