function mean_cube_w_missing, in_data, missing_value=missing_value

  ; ----------------------------------------------------------
  ; MEAN_CUBE_W_MISSING takes a 3-D data array and caluclate the
  ; mean in the Z direction, taking into account any missing values.
  ;
  ; inputs:
  ;   data: 3-D data array
  ;   missing_value: If set, do not include in calculation
  ;
  ; outputs:
  ;   returns the 2-D mean array
  ; ----------------------------------------------------------
  
  if keyword_set(missing_value) then begin
    i_missing = where(in_data eq missing_value, n_missing)
    if n_missing gt 0 then in_data[i_missing] = !values.F_NAN
  endif

  data_mean = mean(in_data, dimension=3, /nan)
  
  if keyword_set(missing_value) then begin
    i_missing = where(finite(data_mean, /nan, sign =-1), n_missing)
    ii_missing = where(finite(data_mean, /nan), n2_missing)
    if n_missing gt 0 then data_mean[i_missing] = missing_value
    if n2_missing gt 0 then data_mean[ii_missing] = missing_value
  endif
  
  return, data_mean
end