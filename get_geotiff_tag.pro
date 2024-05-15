function get_geotiff_tag, resolution=resolution, x=x, y=y, chc_region=chc_region, i=i,  j=j, k=k, z=z, resz=resz, gt_model_type_geokey=gt_model_type_geokey, $
               gt_raster_type_geokey=gt_raster_type_geokey, geographic_type_geokey=geographic_type_geokey, geogangular_units_geokey=geogangular_units_geokey
  ;
  ;
  ; inputs:
  ;   x: the longitude for the upper left corner
  ;   y: the latitude for the upper left corner
  ;   resoltuion: spatial resolution in degrees for latitude and longitude
  ;   gt_model_type_geokey: the Model Type Geographic
  ;   gt_raster_type_geokey: Raster Pixel is the area
  ;   geogangular_units_geokey: the Angular Degree
  ;   chc_region: a region commonly used by the climate hazard center. setting chc_region will set x and y for the region. 
  ;     some regions will also set the resolution
  ;     chc_region list:
  ;       africia or arc2: x=-20, y=40
  ;       asia: x=60, y=40
  ;       aphrodite_japan: x=123, y=46
  ;       aphrodite_ma: x=60, y=55
  ;       aprhodite_me: x=20, y=45
  ;       aprhodite_ru: x=15, y=84
  ;       camerc: x=-93, y=23.5
  ;       carib: x=-86, y=25
  ;       centrends: x=28, y=18
  ;       cordex_afr: x=-24.86, y=42.46, resolution=0.44
  ;       eac: x=27, y=6
  ;       ea: x=22, y=23
  ;       global50: x=-180, y=50
  ;       global60: x=-180, y=60
  ;       global70: x=-180, y=70
  ;       global80: x=-180, y=80
  ;       global90: x=-180, y=90
  ;       india: x=65, y=40
  ;       indonesia: x=90, y=20
  ;       latamer: x=-120, y=35
  ;       latam: x=-120, y=33
  ;       *nldas: x=-125, y=50
  ;       persiann_ccs: x=-180, y=60, resolution=0.04
  ;       tamsat: x=-19.011999, y=38.025002, resolution=0.0375
  ;       whem: x=-125, y=50
  ;       
  ;  example of use:
  ;   africa_p05_gtag = get_geotiff_tag(resolution=0.05, chc_region='africa')
  ;  or:
  ;   africa_p05_gtag = get_geotiff_tag(resolution=0.05, x=-20, y=40)
  ;   
  ;       
  ; Outputs:
  ;   returns a structure that will serve as a geotiff tag will the input x.y and resolution variables
  ; 
  ; Created by Robert Saldivar
  ; 
  ; Created on 2021/5/19
  ;
  ;------------------------------------------------------------------------------------------------------------
  
  if (n_elements(i) eq 0) then i=0
  if (n_elements(j) eq 0) then j=0
  if (n_elements(k) eq 0) then k=0
  if (n_elements(x) eq 0) then x=0
  if (n_elements(y) eq 0) then y=0
  if (n_elements(z) eq 0) then z=0
  if (n_elements(resolution) eq 0) then resolution=0
  if (n_elements(resz) eq 0) then resz = 0
  if (n_elements(gt_model_type_geokey) eq 0) then gt_model_type_geokey = 2
  if (n_elements(gt_raster_type_geokey) eq 0) then gt_raster_type_geokey = 1
  if (n_elements(geographic_type_geokey) eq 0) then geographic_type_geokey = 4326
  if (n_elements(geogangular_units_geokey) eq 0) then geogangular_units_geokey = 9102
  
  if(n_elements(chc_region) eq 0) then chc_region = 'not set'
  chc_region = chc_region.tolower()  
  if(chc_region eq 'africa' or chc_region eq 'arc2') then x=-20 
  if(chc_region eq 'africa' or chc_region eq 'asia' or chc_region eq 'india' or chc_region eq 'arc2') then y=40
  if(chc_region eq 'aphrodite_japan') then x=123
  if(chc_region eq 'aprhodite_japan') then y=46
  if(chc_region eq 'asia' or chc_region eq 'aprhodite_ma') then x=60
  if(chc_region eq 'aprhodite_ma') then y=55
  if(chc_region eq 'aprhodite_me') then x=20
  if(chc_region eq 'aprhodite_me') then y=45
  if(chc_region eq 'aprhodite_ru') then x=15
  if(chc_region eq 'aprhodite_ru') then y=84
  if(chc_region eq 'camerc') then x=-93
  if(chc_region eq 'camerc') then y=23.5
  if(chc_region eq 'carib') then x=-86
  if(chc_region eq 'carib') then y=25
  if(chc_region eq 'centrends') then x=28
  if(chc_region eq 'centrends') then y=18
  if(chc_region eq 'cordex_afr') then x=-24.86
  if(chc_region eq 'cordex_afr') then y=42.46
  if(chc_region eq 'eac') then x=27
  if(chc_region eq 'eac') then y=6
  if(chc_region eq 'ea') then x=22
  if(chc_region eq 'ea') then y=23
  if(chc_region eq 'global50' or chc_region eq 'global60' or $
     chc_region eq 'global70' or chc_region eq 'global90' or chc_region eq 'persiann_ccs')then x=-180
  if(chc_region eq 'global50' or chc_region eq 'nldas' or chc_region eq 'whem') then y=50  
  if(chc_region eq 'global60' or chc_region eq 'persiann_ccs') then y=60
  if(chc_region eq 'global70') then y=70
  if(chc_region eq 'global90') then y=90
  if(chc_region eq 'india') then x=65
  if(chc_region eq 'indonesia') then x=90 
  if(chc_region eq 'indonesia') then y=20
  if(chc_region eq 'latamer' or chc_region eq 'latam') then x=-120 
  if(chc_region eq 'latamer') then y=35
  if(chc_region eq 'latam') then y=33
  if(chc_region eq 'nldas' or chc_region eq 'whem') then x=-125
  if(chc_region eq 'tamsat') then x=-19.011999
  if(chc_region eq 'tamsat') then y=38.025002
  if(chc_region eq 'cordex_afr') then resolution =0.44
  if(chc_region eq 'persiann_ccs') then resolution=0.04
  if(chc_region eq 'tamsat') then resolution=0.037500001
  
  g_tags = { $
  modeltiepointtag: [i, j, k, x, y, z], $
  modelpixelscaletag: [resolution, resolution, resz], $
  gtmodeltypegeokey: gt_model_type_geokey, $
  gtrastertypegeokey: gt_raster_type_geokey, $
  geographictypegeokey: geographic_type_geokey, $
  geogangularunitsgeokey: geogangular_units_geokey $
  }
  
  return, g_tags
  
  end
  
  
  