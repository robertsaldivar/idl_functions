function year_pentad_to_month_pentad, year_pentad
  ;
  ; this function returns a 2-element array of the month and pentad based on the pentad in a year
  ; 
  ; input:
  ;   year_pentad: The pentad within a year. Must be between 1-72.
  ;   
  ; output:
  ;   returns a two element array of the month and pentad
  ;   
  ; Written by Robert Saldivar on 2021/9/28
  ;
  ;---------------------------------------------------
  
  
  if (year_pentad ge 1) and (year_pentad le 6) then month = 1
  if (year_pentad ge 7) and (year_pentad le 12) then month = 2
  if (year_pentad ge 13) and (year_pentad le 18) then month = 3
  if (year_pentad ge 19) and (year_pentad le 24) then month = 4
  if (year_pentad ge 25) and (year_pentad le 30) then month = 5
  if (year_pentad ge 31) and (year_pentad le 36) then month = 6
  if (year_pentad ge 37) and (year_pentad le 42) then month = 7
  if (year_pentad ge 43) and (year_pentad le 48) then month = 8
  if (year_pentad ge 49) and (year_pentad le 54) then month = 9
  if (year_pentad ge 55) and (year_pentad le 60) then month = 10
  if (year_pentad ge 61) and (year_pentad le 66) then month = 11
  if (year_pentad ge 67) and (year_pentad le 72) then month = 12
  if (year_pentad lt 1) or (year_pentad gt 72) then message, ' input must be between 1-72 '
  
  pentad = (year_pentad - (6*(month-1)))
  
  
  return, [month, pentad]
  
  end
  