function year_dekad_to_month_dekad, year_dekad
  ;
  ; this function will return a 2-element array with the month and dekad based on the dekad in a year
  ; 
  ; input;
  ;   year_dekad: The dekad within a year. Must be between 1-36
  ;   
  ; output:
  ;   returns a two element array of the month and dekad
  ;   
  ; Written by Robert Saldivar on 9/28/2021
  ;
  ;-----------------------------------------------
  
  
  if (year_dekad ge 1) and (year_dekad le 3) then month = 1
  if (year_dekad ge 4) and (year_dekad le 6) then month = 2
  if (year_dekad ge 7) and (year_dekad le 9) then month = 3
  if (year_dekad ge 10) and (year_dekad le 12) then month = 4
  if (year_dekad ge 13) and (year_dekad le 15) then month = 5
  if (year_dekad ge 16) and (year_dekad le 18) then month = 6
  if (year_dekad ge 19) and (year_dekad le 21) then month = 7
  if (year_dekad ge 22) and (year_dekad le 24) then month = 8
  if (year_dekad ge 25) and (year_dekad le 27) then month = 9
  if (year_dekad ge 28) and (year_dekad le 30) then month = 10
  if (year_dekad ge 31) and (year_dekad le 33) then month = 11
  if (year_dekad ge 34) and (year_dekad le 36) then month = 12
  if (year_dekad lt 1) or (year_dekad gt 36) then message, ' input must be between 1-36 '
  
  dekad = (year_dekad - (3*(month-1)))
  
  
  return, [month, dekad]
  
  end
  