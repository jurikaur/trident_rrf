; LED status
if exists(global.sb_leds)
  set global.sb_leds = "homing"

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height
G1 X150 Y150
M913 Z50 ;lower motor current to 50%

;M18 Z ; Disable Z motors
;M17 Z ; Enable Z motors
;G4 P150 ; Wait

; do rough home
M98 P"0:/sys/rough-homez.g"

;touch probe
M558 P11 C"120.i2c.ldc1612" F100:100:18000 T18000 H3:3 R0.75
G31 Z3 Y0 Z-24.5
M558.2 K0 S20 R144315
M558.3 K0 S1 F200 V1.0
G1 Z3
G1 X150 Y150
G30
M558.3 s0
G1 Z20

M558.2 K0 S16 R136744 ; set standard SZP calibration data
M913 Z100 ;set motor current back to 100%
; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"