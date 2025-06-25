var thisMacroHeatOn = false
if tools[0].active[0] < {global.nozzleProbeTemperature}         ; check if the heater is powered and up to temp
    M568 P0 S{global.nozzleProbeTemperature} A2                 ; if cold set the nozzle temperature to 150 degrees
    M116 P0                                                     ; wait for the nozzle to reach temperature
    set var.thisMacroHeatOn = true                              ; set variable to show this macro set the temp
if heat.heaters[1].current < tools[0].active[0]
    M116 P0

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "leveling"
  ;M98 P"/sys/lib/sb_leds.g"

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

;set SZP in touch mode
M558 H8 ; set dive height 8mm
M98 P"szp_mode_touch.g" ; SZP to normal mode

M913 Z50 ;lower motor current to 50%

M561

G30 P0 X25 Y30 Z-99999
G30 P1 X150 Y270 Z-99999
G30 P2 X270 Y30 Z-99999 S3
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

M558 H5:5 ; set dive height to 3mm
while move.calibration.initial.deviation > 0.005
  if iterations >= 8
    echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
    break
  echo "Deviation over threshold. Executing pass" , iterations+2, "deviation", move.calibration.initial.deviation
  G30 P0 X25 Y30 Z-99999
  G30 P1 X150 Y270 Z-99999
  G30 P2 X270 Y30 Z-99999 S3
  echo "Current deviation: " ^ move.calibration.initial.deviation
  continue
echo "Final deviation: " ^ move.calibration.initial.deviation

G1 Z20 ; lower bed 20mm

G28 Z ; home Z

M98 P"szp_mode_normal.g"
M913 Z100 ;set motor current to 100%

G1 Z20
; LED status
if exists(global.sb_leds)
  set global.sb_leds = "ready"
  ;M98 P"/sys/lib/sb_leds.g"

if var.thisMacroHeatOn = true                                   ; check if the heater temperature was set by this macro
    M568 P0 S0 A0                                               ; turn the hotend off