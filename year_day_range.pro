function year_day_range, year
  ;
  ; this function returns an array with the number of days in the year
  ; 
  ; inputs:
  ;   year: the year that is being evaluated
  ;   
  ; outputs: 
  ;   day_range: an array from 1-365 or 1-366 if it is a leap year.
  ;   
  ; created by Robert saldivar on 2021/8/26
  ;
  ;----------------------------------------------------------------------------
  
  
  day_range = [1,365]
  
  if (is_leap(year) eq 1) then day_range = [1,366]
  
  return, day_range
  
  end
  
  