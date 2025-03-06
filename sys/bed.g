; LED status
if exists(global.sb_leds)
  set global.sb_leds = "leveling"
  ;M98 P"/sys/lib/sb_leds.g"

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

M561
M558 K0 H8 F500 ;1000
G90
G1 Z{var.probe_height} ;F2000
M401

G30 K0 P0 X15 Y30 Z-99999
G30 K0 P1 X160 Y285 Z-99999
G30 K0 P2 X295 Y30 Z-99999 S3
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

M558 K0 H4 F300 ;500

G30 K0 P0 X15 Y30 Z-99999
G30 K0 P1 X160 Y285 Z-99999
G30 K0 P2 X295 Y30 Z-99999 S3
echo "Current medium pass deviation: " ^ move.calibration.initial.deviation

M558 K0 H2 F120
while move.calibration.initial.deviation > 0.005
  if iterations >= 5
    echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
    break
  echo "Deviation over threshold. Executing pass" , iterations+3, "deviation", move.calibration.initial.deviation
  G30 K0 P0 X15 Y30 Z-99999
  G30 K0 P1 X160 Y285 Z-99999
  G30 K0 P2 X295 Y30 Z-99999 S3
  echo "Current deviation: " ^ move.calibration.initial.deviation
  continue
echo "Final deviation: " ^ move.calibration.initial.deviation
M558 K0 F600:180
G28 Z

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"
  ;M98 P"/sys/lib/sb_leds.g"