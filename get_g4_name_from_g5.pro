function get_g4_name_from_g5, g5_file, period, $
out_dir=out_dir, ext=ext, mean_data=mean_data, full_path=full_path,dot=dot,calc=calc
  ;
  ;
  ;
  ;
  ;
  ;----------------------------------------------------------------------------------------
  
  g5_base_file = g5_file
  if (keyword_set(full_path)) then g5_base_file = file_basename(g5_file)
  
  g5_array = strsplit(g5_base_file, "_", /extract)
  
  prefix = g5_array[0]
  extension = g5_array[2], 9,4)
  
  year   = strmid(g5_array[1], 0,4)
  first_month = strmid(g5_array[1], 4,2)
  
  last_month = strmid(g5_array[2], 4,2)
  
  
  
  return, g4_file 