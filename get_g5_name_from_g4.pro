function get_g5_name_from_g4, g4_file, period, $ 
outdir=outdir, ext=ext, mean_data=mean_data, full_path=full_path,dot=dot, calc=calc, stns=stns
  ;
  ; this function is designed to produce the ge5 file name from on the ge4 file name
  ; 
  ; inputs:
  ;   g4_file: a file name written in g4 format
  ;   period: this the period that the g4_file is written for. 
  ;     (eg. '1day', '5day', '10day', '15day', '16day', 'pentad', 'dekad', 'monthly', '2-monthly', '3-monthly')
  ; 
  ; keywords:
  ;   outdir: if a outdir is given then the outdir will be added to the outfile
  ;   ext: use this to set the file extention as either '.tif' or '.tiff'
  ;   mean_data: set this keyword if the g4 file is a mean data file
  ;   full_path: set this keyword if the full file path is given
  ;   dot: set this keyword if there is a dot between the month and dekad/pentad
  ;   calc: set this if the dekad/pentad needs to be calculated
  ;   
  ; dependent functions:
  ;   path='/home/chc-source/saldivar/code/idl_functions/'
  ;     is_leap
  ;     doy_to_cal
  ;     n_days_month
  ;     get_pentad_first_day
  ;     get_pentad_last_day
  ;     get_dekad_first_day
  ;     get_dekad_last_day
  ;     year_pentad_to_month_pentad
  ;     year_dekad_to_month_dekad
  ;     
  ; output:
  ;   ge5_file: this variable is the file name written in g5 format
  ;   
  ; Written by Robert Saldivar on 2021/9/22
  ; 
  ; Edited 2023/7/25 Added 4,5, & 6 monthly capabilities
  ; 
  ;--------------------------------------------------------
  
  ; getting the base file name  
  g4_base_file = g4_file
  if (keyword_set(full_path)) then g4_base_file = file_basename(g4_file) 
  
  ; splitting the file name into separate parts
  g4_array = strsplit(g4_base_file, ".", /extract)

  ; setting the file name as data, anom, zscore or mean_data
  file_name = g4_array[0]

;  if ((file_name ne 'data') or (file_name ne 'anom') or (file_name ne 'zscore') or (file_name ne 'mean_data')) then file_name = 'data' 
  
  ; assigning variables from g4 name.
  year1 = g4_array[1]
  year2 = year1
  month1 = strmid(g4_array[2], 0,2)
  month2 = month1
  extension = string(g4_array[3], f='(".",a)')
  
  ; if period is 2-monthly or 3-monthly adjusting the end month and year
  if (period eq '2-monthly' or period eq '3-monthly' or period eq 'monthly' or period eq '4-monthly' or period eq '5-monthly' or period eq '6-monthly') then begin
    
    month2 = strmid(g4_array[2], 1, 2, /reverse_offset)  
    if (month1 eq 12 and period eq '2-monthly') or (month1 ge 11 and period eq '3-monthly') or (month1 ge 10 and period eq '4-monthly') or $
       (month1 ge 9 and period eq '5-monthly') or (month1 ge 8 and period eq '6-monthly') then year2 = year1+1
    
    first_day ='01'
    last_day = n_days_month(year2,month2)
    
  endif
  
  ; adjusting start and end day if period is pentad or dekad
  if (period eq 'pentad') or (period eq 'pentads') or (period eq 'dekad') or (period eq 'dekads') then begin
    
    pd = strmid(g4_array[2], 2, 1)
    
    ; if the g4 name has a dot assign pentad/dekad varible and reassign extention
    if (keyword_set(dot)) then  begin
      pd = g4_array[3]
      extension = string(g4_array[4], f='(".",a)')
    endif
    
    ; starting name process for pentads
    if (period eq 'pentad') or (period eq 'pentads') then begin
      
      ; calculates month and pentad if needed
      if (keyword_set(calc)) then begin
        mpd = year_pentad_to_month_pentad(g4_array[2])
        month1=mpd[0]
        month2=month1
        pd=mpd[1]
      endif
      
      first_day = get_pentad_first_day(pd)
      last_day = get_pentad_last_day(year2,month2,pd)
      
    endif 
    
    ; starting name process for dekads
    if (period eq 'dekad') or (period eq 'dekads') then begin
      
      ; calculates month and dekad if needed
      if (keyword_set(calc)) then begin
        mpd = year_dekad_to_month_dekad(g4_array[2])
        month1=mpd[0]
        month2=month1
        pd=mpd[1]
      endif
      
      first_day = get_dekad_first_day(pd)
      last_day = get_dekad_last_day(year2,month2,pd)
      
    endif
  endif
  
  ; calculating g5 name for 1, 5, 10, 15, 16 day periods 
  if (period eq '1day' or period eq '5day' or period eq '10day' or period eq '15day' or period eq '16day') then begin
    
    ; reassigns year1, month1, and first day based on day of year
    ymd = doy_to_cal(year1, g4_array[2])
    year1 = ymd[0]
    month1 = ymd[1]
    first_day = ymd[2]
    
    ; converts to julian date
    jul_date = julday(month1,first_day,year1)
    
    ; number of days to add based on period
    case period of
      '1day': days=0
      '5day': days=4
      '10day': days=9
      '15day': days=14
      '16day': days=15
    endcase
    
    ; adding days and setting year2, month2 and last day
    jul_date2 = jul_date+days
    caldat, jul_date2, month2, last_day, year2
    
  endif
  
  ; if keyword set, the file extention is set to ext
  if (n_elements(ext) eq 1) then extension = ext
  
  ; combines variables into g5 name
  ge5_name = string(file_name, year1, month1, first_day,  year2, month2, last_day,  extension, f='(a,"_",i4,i02,i02,"_",i4,i02,i02,a)')
  
  ; writing ge5 name for mean data files
  if (keyword_set(mean_data)) then begin
    
    year1 = strmid(g4_array[1], 0, 4)
    year2 = strmid(g4_array[1], 5, 4)
       
    last_day = n_days_month(year2,month2)
    if (period eq 'pentad') or (period eq 'pentads') then last_day = get_pentad_last_day(year2,month2,pd)
    if (period eq 'dekad') or (period eq 'dekads') then last_day = get_dekad_last_day(year2,month2,pd)
    
    ge5_name = string('mean',year1,year2,month1,first_day,month2,last_day, extension,f='(a,"_",i4,"_",i4,"_",i02,i02,"_",i02,i02,a)')
    
  endif
  
  ; this area will be for data, anomaly, zscore file names with stations
  if (keyword_set(stns)) then begin
    
    ge5_array = strsplit(ge5_name, "_", /extract)
    ge5_name = string(ge5_array[0],ge5_array[3],ge5_array[4],f='(a,"_",a,"_",a)')
    
  endif
  
  ; if outdir has been set attaching outdir to file name
  ge5_file = ge5_name
  if (n_elements(outdir) eq 1) then ge5_file = outdir + ge5_name
  
  return, ge5_file
  
end
