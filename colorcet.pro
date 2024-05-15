pro colorcet, name
  ;
  ;
  ;
  ;--------------------------------------------------------------
  
  csv_dir = '/home/chc-source/husak/colorcet/colorcet_csvs/'
  
  fname = file_search(csv_dir+name+'.csv')
  
  tmp = read_csv(fname)
  
  rgbs = [[tmp.(0)],[tmp.(1)],[tmp.(2)]]
  
  strstart = strpos(fname, '/', /reverse_search)+1
  strend   = strpos(fname, '.csv',/reverse_search)
  tblname  = strmid(fname,strstart,strend-strstart)
  
  cb = colorbar(rgb_table=rgbs, title=string(tblname,f='(a,a)'))
  
end
  