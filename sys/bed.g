; LED status
if exists(global.sb_leds)
  set global.sb_leds = "leveling"
  ;M98 P"/sys/lib/sb_leds.g"

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

;set SZP in touch mode
M558 P11 C"120.i2c.ldc1612" F100:100:18000 T18000 H3:3 R0.75
G31 Z3 Y0 Z-24.5
M558.2 K0 S20 R144315
M558.3 K0 S1 F200 V1.0

M913 Z50 ;lower motor current to 50%

M561
M558 K0 H8 F100 ;1000

G30 K0 P0 X50 Y30 Z-99999
G30 K0 P1 X150 Y280 Z-99999
G30 K0 P2 X287 Y30 Z-99999 S3
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

while move.calibration.initial.deviation > 0.005
  if iterations >= 5
    echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
    break
  echo "Deviation over threshold. Executing pass" , iterations+3, "deviation", move.calibration.initial.deviation
  G30 K0 P0 X50 Y30 Z-99999
  G30 K0 P1 X150 Y280 Z-99999
  G30 K0 P2 X287 Y30 Z-99999 S3
  echo "Current deviation: " ^ move.calibration.initial.deviation
  continue
echo "Final deviation: " ^ move.calibration.initial.deviation

G28 Z

M558.3 s0
M913 Z100 ;set motor current to 100%

G1 Z20
; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"
  ;M98 P"/sys/lib/sb_leds.g"