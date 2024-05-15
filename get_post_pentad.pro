function get_post_pentad, day=day, pentad=pentad
  ;
  ; this returns the next pentad
  ; 
  ; important note
  ;   either the day or the pentat need to be set but not both
  ; 
  ; inputs:
  ;   day: a day in the current pentad
  ;   pentad: the current pentad
  ;
  ; outputs: returns the next pentad as an integer
  ;
  ;------------------------------------------------------------------
  
  
  if (keyword_set(day) eq 0) then day = 0
  if (keyword_set(pentad) eq 0) then pentad = 0
  
  if (day ge 1  and day le 5)  or (pentad eq 1) then post_pentad = 2
  if (day ge 6  and day le 10) or (pentad eq 2) then post_pentad = 3
  if (day ge 11 and day le 15) or (pentad eq 3) then post_pentad = 4
  if (day ge 16 and day le 20) or (pentad eq 4) then post_pentad = 5
  if (day ge 21 and day le 25) or (pentad eq 5) then post_pentad = 6
  if (day ge 25 and day le 31) or (pentad eq 6) then post_pentad = 1
  
  if(day le 0 or day ge 32) and (pentad le 0 or pentad ge 7) then return, 'Day or pentad is not within range.' 
  
  return, post_pentad
  
end



