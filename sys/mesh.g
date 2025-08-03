; LED status
if exists(global.sb_leds)
  set global.sb_leds = "meshing"

;set z probe height variable
var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height 

G90
M557 X15:270 Y30:280 P20
G29 S2 ; Disable mesh bed compensation and clear the height map
G28 Z ; home Z
G1 Z6 ; go to Z5
M558.1 K0 S1.7 ; calibrate szp
M558 F12000
G1 Z6

G29 S0 K0; Probe the bed, save the height map in a file on the SD card, and activate mesh bed compensation
if result != 0
  abort "Mesh probing failed"

G1 Z{var.probe_height} F2400

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"