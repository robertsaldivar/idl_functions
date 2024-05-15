function get_dekad_last_day, year, month, dekad
  ;
  ; this function returns the last day in a dekad for a given month
  ; 
  ; inputs:
  ;   year: the year that is being evaluated. this is for calucalting leap years
  ;   month: the month that is being calculated
  ;   dekad: the dekad that is being evaluated
  ;   
  ; output: returns the last day of a dekad of a month as an interger 
  ; 
  ;-----------------------------------------------------------------------
  
  
  if (dekad eq 1) then last_day = 10
  if (dekad eq 2) then last_day = 20
  if (dekad eq 3) then last_day = n_days_month(year,month)   
  
  return, last_day
  
end