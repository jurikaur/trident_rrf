; LED status
if exists(global.sb_leds)
  set global.sb_leds = "leveling"
  ;M98 P"/sys/lib/sb_leds.g"

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

;set SZP in touch mode
M558 H8 ; set dive height 8mm
;G31 Z3 Y0 X-24.5
M558.2 S20 R144315 ; set touch drive current
M558.3 S1 F200 V1.0 ; set touch parameters

M913 Z50 ;lower motor current to 50%

M561

G30 P0 X25 Y30 Z-99999
G30 P1 X150 Y280 Z-99999
G30 P2 X270 Y30 Z-99999 S3
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

M558 H3:3 ; set dive height to 3mm
while move.calibration.initial.deviation > 0.005
  if iterations >= 8
    echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
    break
  echo "Deviation over threshold. Executing pass" , iterations+2, "deviation", move.calibration.initial.deviation
  G30 P0 X25 Y30 Z-99999
  G30 P1 X150 Y280 Z-99999
  G30 P2 X270 Y30 Z-99999 S3
  echo "Current deviation: " ^ move.calibration.initial.deviation
  continue
echo "Final deviation: " ^ move.calibration.initial.deviation

G1 Z20 ; lower bed 20mm

G28 Z ; home Z

M558.3 s0 ; set standard mode
M558.2 S16 R136744 ; set standard SZP calibration data
M913 Z100 ;set motor current to 100%

G1 Z20
; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"
  ;M98 P"/sys/lib/sb_leds.g"