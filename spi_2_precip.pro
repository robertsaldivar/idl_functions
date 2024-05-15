function spi_2_precip, spi, shape, scale, no_rain

; this does not work currently

  ts = reform(spi,n_elements(spi))
  outrain = fltarr(n_elements(ts))

  pos_locs = where(ts gt scale)
  pvals = ts[pos_locs]

  if (shape lt 10000) then tmprain = gamma((pvals-no_rain)/(1.0-no_rain)) $
    else tmprain = norm((pvals-no_rain)/(1.0-no_rain))

  outrain[pos_locs] = tmprain
  return, outrain
  
end