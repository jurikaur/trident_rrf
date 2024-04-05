if !exists(param.S)
  abort "Missing parameter S filament type"
M702 ; unload previous filament
M701 S{param.S} ; load new filament
M703 ; load new filament parameters run filament config.g