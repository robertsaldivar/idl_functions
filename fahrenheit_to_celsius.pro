function fahrenheit_to_celsius,temp
  ; 
  ; this function calculates the celsius temperature from fahrenheight
  ; 
  ; inputs:
  ;   temp: the temperature in fahrenheit
  ;   
  ; outputs:
  ;   Returns a floating point variable to represent the temperature in celcius
  ;
  ;
  ; Writen by Robert Saldivar, 2022/11/1
  ;
  ;---------------------------------------------------------------------
  
  
  celsius = ((float(temp)-32.0)*(5.0/9.0))
  
  return, celsius
  
  end
  