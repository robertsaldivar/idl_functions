FUNCTION quick_global_chirp,ingrid, $
  RGBCT = RGBCT, $ ; set colortable, default is 4
  FLIPUD = FLIPUD, $   ; set to change the !order
  MIN_VAL = MIN_VAL, $ ; minimum mapping value
  MAX_VAL = MAX_VAL, $ ; maximum mapping value
  MAP_TIT = MAP_TIT, $ ; title for map
  LEG_TIT = LEG_TIT  ; legend title

  ;;;;;
  ; this program takes an input grid that is [7200,2000] and maps it
  ; there are a number of follow-up things that the user can
  ; customize to tweak the output. this code is based on quick_afr_rfe
  ; which performs a similar mapping routine but at 0.1-degree
  ;
  ; DEVELOPED BY: Greg Husak  May 30, 2013
  ;
  ; ingrid = a 1500x1600 input grid, either floats or ints should work. standard africa window
  ;
  ; OPTIONAL ARGUMENTS
  ; RGBCT = integer corresponding to a color LUT
  ; FLIPUD = boolean argument, puts [0,0] in upper-left corner if specified. default is lower-left.
  ; MIN_VAL = minimum mapping value used in the data stretch for display
  ; MAX_VAL = maximum mapping value used in the data stretch for display
  ; MAP_TIT = string used as the title of the map
  ; LEG_TIT = string used to define the legend title
  ;
  ;;;;;

  if ~KEYWORD_SET(RGBCT) then RGBCT = 4 ; if no colortable, then set to 4

  if KEYWORD_SET(FLIPUD) then $
    outhandle = image(ingrid, IMAGE_DIMENSIONS=[720.,200.], IMAGE_LOCATION=[-180.,90.], $
    DIMENSIONS=[7200,2000],AXIS_STYLE=2,GRID_UNITS=2, $
    FONT_SIZE=30,RGB_TABLE=RGBCT,/ORDER) $
  else $
    outhandle = image(ingrid, IMAGE_DIMENSIONS=[720.,200.], IMAGE_LOCATION=[-180.,90.], $
    DIMENSIONS=[7200,2000],AXIS_STYLE=2,GRID_UNITS=2, $
    FONT_SIZE=30,RGB_TABLE=RGBCT)
  ; adjust for mapping keywords
  if KEYWORD_SET(MIN_VAL) then outhandle.MIN_VALUE = MIN_VAL
  if KEYWORD_SET(MAX_VAL) then outhandle.MAX_VALUE = MAX_VAL
  if KEYWORD_SET(MAP_TIT) then outhandle.TITLE = MAP_TIT

  ; if MIN and MAX are set, then adjust the legend to only show those
  ; values by creating a dummy grid that isn't mapped, but that we'll draw
  ; the legend from
  if KEYWORD_SET(MIN_VAL) OR KEYWORD_SET(MAX_VAL) then begin
    quickdump = FLTARR(2,2)
    if KEYWORD_SET(MIN_VAL) then quickdump(0,*) = MIN_VAL $
    else quickdump(0,*) = MIN(ingrid)
    if KEYWORD_SET(MAX_VAL) then quickdump(1,*) = MAX_VAL $
    else quickdump(1,*) = MAX(ingrid)
    quickdump2 = image(quickdump, IMAGE_DIMENSIONS=[720.,200.], IMAGE_LOCATION=[-180.,90.], $
      DIMENSIONS=[2,2],AXIS_STYLE=2,GRID_UNITS=2,RGB_TABLE=RGBCT, $
      MAX_VALUE=MAX_VAL,MIN_VALUE=MIN_VAL,HIDE=1,/OVERPLOT)
    c = COLORBAR(TARGET=quickdump2,ORIENTATION=0,/BORDER_ON, $
      POSITION=[0.3,0.04,0.7,0.07])
  endif else begin
    c = COLORBAR(TARGET=outhandle,ORIENTATION=0,/BORDER_ON, $
      POSITION=[0.3,0.04,0.7,0.07])
  endelse

  ; adjust for legend keywords
  if KEYWORD_SET(LEG_TIT) then c.title = LEG_TIT

  map = MAP('Geographic', $
    LIMIT = [-180., -90., 60., 90.], $
    /OVERPLOT)
  map.mapgrid.linestyle = 'dotted'
  map.mapgrid.color = [150, 150, 150]
  map.mapgrid.label_position = 0
  map.mapgrid.label_color = 'black'
  map.mapgrid.FONT_SIZE = 10

  m1 = MAPCONTINENTS(/COUNTRIES, $
    COLOR = [220, 220, 220], $
    FILL_BACKGROUND = 0)

  RETURN,outhandle

END

