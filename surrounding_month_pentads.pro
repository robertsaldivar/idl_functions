function surrounding_month_pentads, month, pentad
  ;
  ; This function returns the a 5 element string array of month period combination
  ; 
  ; inputs:
  ;   month: The month in the middle of the array; ex: 4
  ;   pentad: The pentad in the middle of the array; ex: 1
  ;   
  ; outputs:
  ;   A 5-element array of a month period combination
  ;    examaple: [08.5,08.6,09.1,09.2,09.3]
  ;   
  ; written by Robert Saldivar 2021/12/10
  ;-----------------------------------------------------------------------
  
  if (pentad le 2) and (month eq 1) then month1 = 12 $
    else if (pentad le 2) then month1 = month-1 $
    else month1 = month
    
  if (pentad le 1) and (month eq 1) then month2 = 12 $
    else if (pentad le 1) then month2 = month-1 $
    else month2 = month
    
  if (pentad eq 1) then begin

    pentad1 = 5
    pentad2 = 6

  endif else if (pentad eq 2) then begin

    pentad1 = 6
    pentad2 = pentad-1

  endif else if (pentad ge 3) then begin

    pentad1 = pentad-2
    pentad2 = pentad-1

  endif
  
  month3 = month 
  pentad3 = pentad
  
  if (pentad ge 5) and (month eq 12) then month4 = 1 $
    else if (pentad ge 5) then month4 = month+1 $
    else month4 = month
    
  if (pentad ge 6) and (month eq 12) then month5 = 1 $
    else if (pentad eq 6) then month5 = month+1 $
    else month5 = month
  
  if (pentad eq 5) then begin
    
    pentad4 = 6
    pentad5 = 1
    
  endif else if (pentad eq 6) then begin
    
    pentad4 = 1
    pentad5 = 2
    
  endif else if (pentad le 4) then begin
    
    pentad4 = pentad+1
    pentad5 = pentad+2
    
  endif
  
  mp1 = string(month1,pentad1,f='(i02,".",i1)')
  mp2 = string(month2,pentad2,f='(i02,".",i1)')
  mp3 = string(month3,pentad3,f='(i02,".",i1)')
  mp4 = string(month4,pentad4,f='(i02,".",i1)')
  mp5 = string(month5,pentad5,f='(i02,".",i1)')
  
  return, [mp1,mp2,mp3,mp4,mp5]
  
end
  