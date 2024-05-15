function get_post_months, month
  ;
  ; this function returns the two months after the input month as a 2-element array.
  ; 
  ; input:
  ;   month: the input month that the function finds the 2 months after
  ;   
  ; outputs:
  ;   after_months: a 12-element array of the the 12 months after the input array
  ;
  ; Edited 2022/9/8 added post months for 1 year from input month
  ;
  ;---------------------------------------------------------------------
  
  if (month eq 1)  then after_months = [month+1,month+2,month+3,month+4,month+5,month+6,month+7,month+8,month+9,month+10,month+11,1]
  if (month eq 2)  then after_months = [month+1,month+2,month+3,month+4,month+5,month+6,month+7,month+8,month+9,month+10,1,2]
  if (month eq 3)  then after_months = [month+1,month+2,month+3,month+4,month+5,month+6,month+7,month+8,month+9,1,2,3]
  if (month eq 4)  then after_months = [month+1,month+2,month+3,month+4,month+5,month+6,month+7,month+8,1,2,3,4]
  if (month eq 5)  then after_months = [month+1,month+2,month+3,month+4,month+5,month+6,month+7,1,2,3,4,5]
  if (month eq 6)  then after_months = [month+1,month+2,month+3,month+4,month+5,month+6,1,2,3,4,5,6]
  if (month eq 7)  then after_months = [month+1,month+2,month+3,month+4,month+5,1,2,3,4,5,6,7]
  if (month eq 8)  then after_months = [month+1,month+2,month+3,month+4,1,2,3,4,5,6,7,8]
  if (month eq 9)  then after_months = [month+1,month+2,month+3,1,2,3,4,5,6,7,8,9]
  if (month eq 10) then after_months = [month+1,month+2,1,2,3,4,5,6,7,8,9,10]
  if (month eq 11) then after_months = [month+1,1,2,3,4,5,6,7,8,9,10,11]
  if (month eq 12) then after_months = [1,2,3,4,5,6,7,8,9,10,11,12]
  
  return, after_months
  
end
  
  
  