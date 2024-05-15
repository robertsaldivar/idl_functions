function pentads_in_dekad, dekad
  ;
  ; this function returns a two element array of the pentads within a dekad
  ; 
  ; inputs:
  ;   dekad: the dekad to be evaluated
  ;   
  ; outputs:
  ;   pentad_array: a two element array of the pentads within a dekad
  ;   
  ; written by Robert Saldivar, 2021/11/24
  ;
  ;---------------------------------------------------------------------------
  
  p1 = 2*(dekad-1)+1
  p2 = p1+1
  pentad_array = [p1,p2]
  
  return, pentad_array
  
  end