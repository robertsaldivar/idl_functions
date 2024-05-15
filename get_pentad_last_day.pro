function get_pentad_last_day, year, month, pentad
  ;
  ; this function returns the last day of a given pentad
  ; 
  ; inputs:
  ;   year: the year of the selected pentad
  ;   month: the month of the selected pentad
  ;   pentad: the selected pentad
  ;   
  ; outputs:
  ;   last_day: the last day of the given pentad
  ;
  ; Written by Robert Saldivar on 2021/9/22
  ;
  ;-----------------------------------------------

  if (pentad eq 1) then last_day = 5
  if (pentad eq 2) then last_day = 10
  if (pentad eq 3) then last_day = 15
  if (pentad eq 4) then last_day = 20
  if (pentad eq 5) then last_day = 25
  if (pentad eq 6) then last_day = n_days_month(year,month)

  return, last_day

end