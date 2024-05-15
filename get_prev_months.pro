function get_prev_months, month
  ;
  ; this function returns the two months prior to the input month as a 3-element array.
  ; 
  ; 
  ; input:
  ;   month: the input month that function finds the 3 months prior
  ;   
  ;   
  ; output:
  ;   prior_months: a 12-element array of the 12 months before the input month
  ;
  ; Edited 2023/7/20 made arrays 12 elements arrays
  ; 
  ;-------------------------------------------------
  
  if (month eq 1)  then prior_months = [12,11,10,9,8,7,6,5,4,3,2,1]
  if (month eq 2)  then prior_months = [month-1,12,11,10,9,8,7,6,5,4,3,2]
  if (month eq 3)  then prior_months = [month-1,month-2,12,11,10,9,8,7,6,5,4,3]
  if (month eq 4)  then prior_months = [month-1,month-2,month-3,12,11,10,9,8,7,6,5,4]
  if (month eq 5)  then prior_months = [month-1,month-2,month-3,month-4,12,11,10,9,8,7,6,5]
  if (month eq 6)  then prior_months = [month-1,month-2,month-3,month-4,month-5,12,11,10,9,8,7,6]
  if (month eq 7)  then prior_months = [month-1,month-2,month-3,month-4,month-5,month-6,12,11,10,9,8,7]
  if (month eq 8)  then prior_months = [month-1,month-2,month-3,month-4,month-5,month-6,month-7,12,11,10,9,8]
  if (month eq 9)  then prior_months = [month-1,month-2,month-3,month-4,month-5,month-6,month-7,month-8,12,11,10,9]
  if (month eq 10) then prior_months = [month-1,month-2,month-3,month-4,month-5,month-6,month-7,month-8,month-9,12,11,10]
  if (month eq 11) then prior_months = [month-1,month-2,month-3,month-4,month-5,month-6,month-7,month-8,month-9,month-10,12,11]
  if (month eq 12) then prior_months = [month-1,month-2,month-3,month-4,month-5,month-6,month-7,month-8,month-9,month-10,month-11,12]

  return, prior_months
  
end
  