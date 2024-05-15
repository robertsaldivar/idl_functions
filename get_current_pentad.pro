function get_current_pentad, day
  ;
  ;
  ; this function return the current pentad for input day.
  ;
  ; input:
  ;   day: the day is a pentad that is begin evaluated
  ;
  ; output: returns the current pentad as an interger.
  ;
  ;------------------------------------------------------------------------------
  
  if (day ge 1)  and (day le 5)  then pentad = 1
  if (day ge 6)  and (day le 10) then pentad = 2
  if (day ge 11) and (day le 15) then pentad = 3
  if (day ge 16) and (day le 20) then pentad = 4
  if (day ge 21) and (day le 25) then pentad = 5
  if (day ge 26) and (day le 31) then pentad = 6
  
    if(day le 0) or (day ge 32) then return, 'Day is not a day in a calendar month, please check your input'
  
  return, pentad
  
end