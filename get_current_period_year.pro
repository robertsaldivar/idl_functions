function get_current_period_year, period, year, month, day
  ;
  ;
  ; this functions returns the period number in a year. 
  ; ex: 84th day, 63rd pentad, 22nd dekad, 5th month
  ; 
  ; inputs:
  ;   period: the type of period being evaluate; (daily,pentad,dekad,monthly,2-monthly,3-monthly)
  ;   year: the year that is being evaluated
  ;   month: the month that is being evaluated
  ;   day: the day of the month that is being evaluated.
  ;   
  ; outputs:
  ;   current_period: the current period as an integer
  ;   
  ; written by: Robert Saldivar on 2021/5/17
  ;
  ;--------------------------------------------------------

  pentad = get_current_pentad(day)
  dekad = get_current_dekad(day)
  prev_months = get_prev_months(month)
  
  if (period eq 'daily') then begin
    
    current_period = cal_to_doy(year,month,day)
    
  endif
  
  if (period eq 'pentad') then begin
    
    current_period = (6 * (month -1) + pentad)
    
  endif
  
  if (period eq 'dekad') then begin
    
    current_period = (3 * (month -1) + dekad)
    
  endif
  
  if (period eq 'monthly') then begin
    
    current_period = month
    
  endif
  
  if (period eq '2-monthly') then begin
    
    current_period = prev_months[0]
    
  endif
  
  if (period eq '3-monthly') then begin
    
    current_period = prev_months[1]
    
  endif
  
  return, current_period
  
end
  
  
  
  