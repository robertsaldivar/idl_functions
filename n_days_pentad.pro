function n_days_pentad, year, month, pentad
  ;
  ;
  ; This function returns the number of days in a pentad
  ; 
  ; inputs: 
  ;   year: the year being evaluated; important for leap years
  ;   month: the month being evaluated: important for pentad 6
  ;   pentad: the pentad being evaluated
  ;
  ; output: 
  ;   pentad_days: the number of days in a pentad as an interger
  ;
  ;----------------------------------------------------------------
  
  pentad_days = 5
  
  n_days = n_days_month(year, month)
  
  if (pentad eq 6) and (n_days ne 30) then pentad_days = n_days - 25
  
  return, pentad_days
  
  end
  