function n_days_dekad, year, month, dekad
  ;
  ; This function returns the number of days in a dekad
  ; 
  ; inputs:
  ;   year: the year in the dekad is being evaluated; important for leap years
  ;   month: the month in of the dekad being evaluated; important for dekad 3
  ;   dekad: the dekad being evaluated
  ;   
  ; output: 
  ;   dekad_days: the number of days in a dekad as an interger
  ;
  ;--------------------------------------------------------------------------------------------
  
  month_days = n_days_month(year, month)
  
  dekad_days = 10
  
  if (dekad eq 3) and (month_days ne 30) then dekad_days = month_days - 20
  
  
  return, dekad_days
  
  
  end
  
  