function month_day_range, year, month
  ;
  ;
  ; this function returns the day range of a month as an array
  ; 
  ; Inputs:
  ;   year: the year that is being analyzed; this is needed to account for leap years
  ;   month:the month that is being analyzed
  ;   
  ; Outputs:
  ;   day_range: an array of the days of the input month
  ;
  ; written by Robert Saldivar
  ;----------------------------------------------------------
  
  ; sets the day range to the end of the month
  day_range = [1:n_days_month(year,month)]
  
  
  return, day_range
  
  
  
  end
  