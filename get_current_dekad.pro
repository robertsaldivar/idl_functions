function get_current_dekad, day
  ;
  ; this function returns the current dekad for the input day
  ;
  ; input:
  ;   day: the day is a dekad that is begin evaluated
  ;
  ; output: returns the current dekad as an interger.
  ;
  ;------------------------------------------------------------------------------
  
  
  if(day ge 1)  and (day le 10) then dekad = 1
  if(day ge 11) and (day le 20) then dekad = 2
  if(day ge 21) and (day le 31) then dekad = 3
  
  if(day le 0) or (day ge 32) then return, 'Day is not a day in a calendar month, please check your input'
  
  return, dekad
  
end