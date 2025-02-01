; LED status
if exists(global.sb_leds)
  set global.sb_leds = "homing"

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

M18 Z ; Disable Z motors
M17 Z ; Enable Z motors
G4 P150 ; Wait

G91              ; relative positioning
;G1 H2 Z{var.probe_height} F7000   ; lift Z relative to current position

G90 ; absolute positioning
M401 ; Deploy probe
G1 X150 Y150 F6000 ; go to first probe point
G30 K0 ; home Z by probing the bed
G1 X150 Y150 Z{2*var.probe_height}
M402 ; Retract probe

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"