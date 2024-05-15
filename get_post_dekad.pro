function get_post_dekad, day=day, dekad=dekad
  ;
  ; this returns the next dekad
  ; 
  ; important note:
  ;   either the dekad or the the need to be set but not both.
  ;
  ; inputs: 
  ;   day: a day in the current dekad
  ;   dekad: the current dekad
  ;
  ; outputs: 
  ;   returns the next dekad as an integer
  ;
  ;------------------------------------------------------------------
  
  
  if (keyword_set(day) eq 0) then day = 0
  if (keyword_set(dekad) eq 0) then dekad = 0
  
  if (day ge 1  and day le 10) or (dekad eq 1) then post_dekad = 2
  if (day ge 11 and day le 20) or (dekad eq 2) then post_dekad = 3
  if (day ge 21 and day le 31) or (dekad eq 3) then post_dekad = 1
  
  
  if(day le 0 or day ge 32) and (dekad le 0 or dekad ge 4) then return, 'Day or dekad is not within range.' 
  
  return, post_dekad
  
end
