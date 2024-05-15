function get_prev_pentad, day=day, pentad=pentad
  ;
  ; this returns the previous pentad
  ; 
  ; important note:
  ;   eithe the day or the pentad need to be set but not both
  ;
  ; inputs:
  ;   day: a day in the current pentad
  ;   pentad: the current pentad
  ;
  ; outputs: 
  ;   prev_pentad: returns the previous pentad as an integer
  ;
  ;------------------------------------------------------------------
  
  
  if (keyword_set(day) eq 0) then day = 0
  if (keyword_set(pentad) eq 0) then pentad = 0
  
  if (day ge 1  and day le 5)  or (pentad eq 1) then prev_pentad = 6
  if (day ge 6  and day le 10) or (pentad eq 2) then prev_pentad = 1
  if (day ge 11 and day le 15) or (pentad eq 3) then prev_pentad = 2
  if (day ge 16 and day le 20) or (pentad eq 4) then prev_pentad = 3
  if (day ge 21 and day le 25) or (pentad eq 5) then prev_pentad = 4
  if (day ge 26 and day le 31) or (pentad eq 6) then prev_pentad = 5
  
  if(day le 0 or day ge 32) and (pentad le 0 or pentad ge 7) then message, 'Day or pentad is not within range.' 
  
  return, prev_pentad
  
end



