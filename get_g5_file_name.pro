function get_g5_file_name, name, year, month, day, period, extension=extension
  
  ext = '.tiff'
  if keyword_set(extension) then ext = '.tif'
  
  case period of
    '1day':   period = '01day'
    '1_day':  period = '01day'
    '5day':   period = '05day'
    '5_day':  period = '05day'
    '10_day': period = '10day'
    '15_day': period = '15day'
    '01_day': period = '01day'
    '05_day': period = '05day'
    else: ; do nothing
  endcase
  
  case period of
    '01day': day_inc = 0
    '05day': day_inc = 4
    '10day': day_inc = 9
    '15day': day_inc = 14
    '16day': day_inc = 15
    'pentad': begin
      init_day = [1,6,11,16,21,26]
      ii = where(day eq init_day)
      if ii eq -1 then message, 'Invalid init day for pentad: ' + string(day)
      if ii lt 5 then day_inc = 4 $&
      else day_inc = n_days_month(year, month) - 26
    end
    'dekad': begin
      init_day = [1,11,21]
      ii = where(day eq init_day)
      if ii eq -1 then message, 'Invalid init day for dekad: ' + string(day)
      if ii lt 2 then day_inc = 9 $&
      else day_inc = n_days_month(year, month) - 21
    end
    'monthly': day_inc = n_days_month(year, month) - 1
    '1-month': day_inc = n_days_month(year, month) - 1
    '2-monthly': begin
      day_inc = n_days_month(year, month) - 1
      y = year
      m = month + 1
      if month eq 12 then begin
        y++
        m = 1
      endif
      day_inc += n_days_month(y, m)
    end
    '3-monthly': begin
      day_inc = n_days_month(year, month) - 1
      y = year
      m = month+1
      if m eq 13 then begin
        y++
        m = 1
      endif
      day_inc += n_days_month(y, m)
      m++
      if m eq 13 then begin
        y++
        m = 1
      endif
      day_inc += n_days_month(y, m)
    end
    else: message, 'Period not valid.'
  endcase

  jday_init = julday(month, day, year)
  jday_end = julday(month, day + day_inc, year)
  
  caldat, jday_end, month_end, day_end, year_end

  file_name = string(name,  '_', year, month, day, '_', $
    year_end, month_end, day_end, ext, $
    f='(2a,i4,2(i02),a,i4,2(i02),a)')

  return, file_name
  
end