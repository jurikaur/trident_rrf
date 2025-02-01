; trigger2.g
if state.status == "processing"
    M300 S2000 P100                                     ; play beep sound
    M291 P"Ran out of filament while printing" S0 T3    ; display message
    M25
elif state.status == "pausing" || state.status == "paused"
    M291 P"Retriggered filament sensor during pause" ; display message
else
    M300 S2000 P100                     ; play beep sound
    M291 P"Ran out of filament" S0 T3   ; display message