; trigger4.g
if state.status = "processing"
    M300 S2000 P100                                                     ; play beep sound
    M291 P"Filament is stuck or filament unload button pressed" S0 T3   ; display message
    M25
else
    M98 P"0:/macros/filament-unload"