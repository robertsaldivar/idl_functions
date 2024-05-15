function calc_year_dekad, month, dekad
  ;
  ; this function calculates the dekad within a year
  ; 
  ; inputs:
  ;   month: the month of the dekad being evaluated; 1-12
  ;   dekad: the dekad within a month; 1-3
  ;   
  ; outpust:
  ;   year_dekad: the dekad within a year; 1-36
  ;   
  ; Written by Robert Saldivar on 2021/9/28
  ;
  ;--------------------------------------------------
  
  
  
  year_dekad = ((3 * (month-1)) + dekad)
  
  return, year_dekad
  
  
  end
  
  