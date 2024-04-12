; LED status
if exists(global.sb_leds)
  set global.sb_leds = "homing"
  M98 P"/sys/lib/sb_leds.g"

M18 z
M17 Z
G4 P150

G90              ; absolute positioning
M401
G1 X150 Y150 F6000 ; go to first probe point
G30 K0 ;Z-99999              ; home Z by probing the bed
M402

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"
  M98 P"/sys/lib/sb_leds.g"