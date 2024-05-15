function get_dekad_first_day, dekad
  ;
  ;
  ; this function returns the first day of the dekad of a month
  ; 
  ; inputs:
  ;   dekad: the first, second or third dekad of the month
  ;   
  ; output: returns the first day of a dekad in a month as an integer
  ; 
  ;-------------------------------------------------------------------------

  
  if (dekad eq 1) then first_day = 1
  if (dekad eq 2) then first_day = 11
  if (dekad eq 3) then first_day = 21
  
  return, first_day
  
end