function subset_global_chirps_to_africa, data
  ;
  ; this function subsets the global chirps data to africa 
  ; 
  ; inputs: 
  ;   data: global chirps array of [7200,2000]
  ;   
  ; outputs:
  ;   chirps_africa: an array [1500,1600] of africa chirps data 
  ;
  ; created by Robert Saldivar, 2021/8/30
  ;
  ;----------------------------------------------------
  
  
  chirps_africa = data[3200:4699,200:1799]
  
  
  return, chirps_africa
  
  end
  
  