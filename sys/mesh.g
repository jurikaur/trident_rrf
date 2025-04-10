; LED status
if exists(global.sb_leds)
  set global.sb_leds = "meshing"

;set z probe height variable
var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height 

G90
;G1 X0 Y0 F30000
G29 S2 ; Disable mesh bed compensation and clear the height map
G31 K0 Z3 Y0 X-24.5
;M557 X45:287 Y15:280 P10
M557 X10:270 Y15:290 P10
M558.1 K0 S0.3 ; calibrate szp
G1 Z5
G29 S0 K0; Probe the bed, save the height map in a file on the SD card, and activate mesh bed compensation
if result != 0
  abort "Mesh probing failed"

G1 Z{var.probe_height} F2400

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"