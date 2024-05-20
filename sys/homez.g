; LED status
if exists(global.sb_leds)
  set global.sb_leds = "homing"

M18 Z ; Disable Z motors
M17 Z ; Enable Z motors
G4 P150 ; Wait

G90 ; absolute positioning
M401 ; Deploy probe
G1 X150 Y150 F6000 ; go to first probe point
G30 K0 ; home Z by probing the bed
M402 ; Retract probe

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"