function doy_last_day_pentad, year, month, day
  ;
  ;
  ; this function returns the last day of the pentad in day of year format
  ; 
  ; inputs:
  ;   year: the year being that the day and pentad are being evaluated in
  ;   month: the month that the day and pentad are being evaluated in
  ;   day: A day in the pentad that is begin evaluated.
  ;   
  ; output: will return the last in of a pentad in day of year format as an integer.
  ;
  ;--------------------------------------------------------------------------------
  
  
  last_day_pentad = [5,    10,  15,  20,  25,  31, $
                     36,   41,  46,  51,  56,  59, $
		     64,   69,  74,  79,  84,  90, $
		     95,  100, 105, 110, 115, 120, $ 
		     125, 130, 135, 140, 145, 151, $
		     156, 161, 166, 171, 176, 181, $
		     186, 191, 196, 201, 206, 212, $
		     217, 222, 227, 232, 237, 243, $
		     248, 253, 258, 263, 268, 273, $
		     278, 283, 288, 293, 298, 304, $
		     309, 314, 319, 324, 329, 334, $
		     339, 344, 349, 354, 359, 365]
  
  
  if is_leap(year) then  last_day_pentad = [last_day_pentad[0:4], last_day_pentad[5:35]+1]
  
  last_day_pentad = last_day_pentad[get_current_period_year('pentad', year, month, day)-1]
  
  return, last_day_pentad
  
end 
  
  
