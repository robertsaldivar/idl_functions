function calc_year_pentad, month, pentad
  ;
  ; this function determines the pentad within a year
  ; 
  ; input:
  ;   month: the month of the pentad being evaluated; 1-12
  ;   pentad: the pentad within a month; 1-6
  ; 
  ; outputs:
  ;   year_pentad: the pentad within a year; 1-72
  ;   
  ; Written by Robert Saldivar on 2021/9/28
  ;
  ;-------------------------------------------------
  
  
  
  year_pentad = (6 * (month-1) + pentad)
  
  return, year_pentad
  
  
  end
  
  