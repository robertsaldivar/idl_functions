function pentad_day_range, year, month, pentad
  ;
  ; this function returns the day range for a pentad within a month as an array
  ; 
  ; Inputs:
  ;   year: the year that is being analyzed; this is needed to account for leap years
  ;   month: the month that is being analyzed
  ;   pentad: the pentad that is being analyzed
  ; 
  ; Outputs:
  ;   day_range: an array of 3-6 numbers that represent a pentad
  ;
  ;
  ;--------------------------------------------------
  
  if (pentad eq 1) then day_range = [1:5]
  if (pentad eq 2) then day_range = [6:10]
  if (pentad eq 3) then day_range = [11:15]
  if (pentad eq 4) then day_range = [16:20]
  if (pentad eq 5) then day_range = [21:25]
  if (pentad eq 6) then day_range = [26:n_days_month(year,month)]
  
  return, day_range
  
  end