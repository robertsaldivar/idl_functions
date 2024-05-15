function dekad_day_range, year, month, dekad
  ;
  ; this function returns the day range for a dekad within a month as an array
  ; 
  ; Inputs:
  ;   year: the year that is being analyzed, this is needed to account for leap years
  ;   month: the month that is being analyzed
  ;   dekad: the dekad that is being analyzed
  ;   
  ; Outputs:
  ;   day_range: an array of 8-11 that represent a dekad
  ;
  ;
  ;----------------------------------------------
  
  
  if (dekad eq 1) then day_range = [1:10]
  if (dekad eq 2) then day_range = [11:20]
  if (dekad eq 3) then day_range = [21:n_days_month(year,month)]
  
  return, day_range
  
  
  end 
 