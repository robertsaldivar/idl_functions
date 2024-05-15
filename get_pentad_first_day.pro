function get_pentad_first_day, pentad
  ;
  ; this function returns the first day of a given pentad
  ; 
  ; inputs:
  ;   year: the year of the selected pentad
  ;   month: the month of the selected pentad
  ;   pentad: the selected pentad
  ;   
  ; outputs:
  ;   first_day: the first day of the given pentad
  ;
  ; Written by Robert Saldivar on 2021/9/22
  ;
  ;-----------------------------------------------
  
  if (pentad eq 1) then first_day = 1
  if (pentad eq 2) then first_day = 6
  if (pentad eq 3) then first_day = 11
  if (pentad eq 4) then first_day = 16
  if (pentad eq 5) then first_day = 21
  if (pentad eq 6) then first_day = 26
  
  return, first_day
  
end