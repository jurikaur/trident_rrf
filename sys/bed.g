M561
M98 P"szp_mode_normal.g"
M558 A10 F600

G30 P0 X25 Y30 Z-99999
G30 P1 X150 Y270 Z-99999
G30 P2 X270 Y30 Z-99999 S3
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation


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

G1 Z80 ; lower bed 20mm
M400 ; wait for moves to finish

;if var.thisMacroHeatOn = true                                   ; check if the heater temperature was set by this macro
;    M568 P0 S0 A0                                               ; turn the hotend off