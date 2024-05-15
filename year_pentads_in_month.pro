function year_pentads_in_month, month
  ;
  ; 
  ;
  ;
  ;-------------------------------------------------------------
  
  if (month eq 1)  then pentad_range = [1:6]
  if (month eq 2)  then pentad_range = [7:12]
  if (month eq 3)  then pentad_range = [13:18]
  if (month eq 4)  then pentad_range = [19:24]
  if (month eq 5)  then pentad_range = [25:30]
  if (month eq 6)  then pentad_range = [31:36]
  if (month eq 7)  then pentad_range = [37:42]
  if (month eq 8)  then pentad_range = [43:48]
  if (month eq 9)  then pentad_range = [49:54]
  if (month eq 10) then pentad_range = [55:60]
  if (month eq 11) then pentad_range = [61:66]
  if (month eq 12) then pentad_range = [67:72]
  
  return, pentad_range

end