function subset_global_modis_lst_to_africa, data
  ;
  ; this function subsets the global modis lst data to africa
  ; 
  ; inputs:
  ;   data: global modis lst array of [7200,3000]
  ;   
  ; outputs:
  ;   modis_lst_africa: an array [1500,1600] of modis lst data
  ;
  ; created by Robert Saldivar, 2021/8/30
  ;
  ;----------------------------------------------------------
  
  
  modis_lst_africa = data[3200:4699,1000:2599]
  
  
  return, modis_lst_africa
  
  end
  
  