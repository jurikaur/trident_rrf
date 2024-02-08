<<<<<<< HEAD
M561
M558 K0 H8 F500 ;1000
G90
G1 Z12 ;F2000
M401

G30 K0 P0 X15 Y30 Z-99999
G30 K0 P1 X150 Y285 Z-99999
G30 K0 P2 X285 Y30 Z-99999 S3
echo "Current rough pass deviation: " ^ move.calibration.initial.deviation

M558 K0 H4 F300 ;500

G30 K0 P0 X15 Y30 Z-99999
G30 K0 P1 X150 Y285 Z-99999
G30 K0 P2 X285 Y30 Z-99999 S3
echo "Current medium pass deviation: " ^ move.calibration.initial.deviation

M558 K0 H2 F120
while move.calibration.initial.deviation > 0.005
  if iterations >= 5
    echo "Error: Max attemps failed. Deviation: " ^ move.calibration.initial.deviation
    break
  echo "Deviation over threshold. Executing pass" , iterations+3, "deviation", move.calibration.initial.deviation
  G30 K0 P0 X15 Y30 Z-99999
  G30 K0 P1 X150 Y285 Z-99999
  G30 K0 P2 X285 Y30 Z-99999 S3
  echo "Current deviation: " ^ move.calibration.initial.deviation
  continue
echo "Final deviation: " ^ move.calibration.initial.deviation
M558 K0 F600:180
G28 Z
=======
; bed.g
; called to perform automatic bed compensation via G32
;
; ====================---------------------------------------------------------
; Prepare to probe
; ====================

M561                                                                           ; Clear any bed transform
M290 R0 S0                                                                     ; Reset baby stepping
M84 E0                                                                         ; Disable extruder stepper

; Lower Z relative to current position if needed
G90
G1 Z{global.Nozzle_CL} F9000                                                 ; Move to Z global.Nozzle_CL

M401

; ====================---------------------------------------------------------
; Tramming code
; ====================

; Coarse tramming pass
M558 K0 H10 F300 A1                                                            ; Increase the depth range, gets the bed mostly trammed immediately
M98 P"/sys/bed_probe_points.g"                                                 ; Probe the bed

; Fine tramming pass
while true
  ; Probe near lead screws -
  M558 K0 H2 F300:180 A3                                                       ; Reduce depth range, probe slower for better repeatability 
  M98 P"/sys/bed_probe_points.g"                                               ; Probe the bed

  ; Check results - exit loop if results are good
  if move.calibration.initial.deviation < 0.0075                                 ; If probing result is less than 0.02mm
    break                                                                      ; Stop probing

  ; Check pass limit - abort if pass limit reached
  if iterations = 5                                                            ; If probed more than 5 times
    M291 P"Bed tramming aborted!" R"Pass Limit Reached!"                       ; Abort probing, something wrong
    set global.bed_trammed = false                                             ; Set global state
    abort "Bed tramming aborted! - Pass Limit Reached!"                        ; Abort probing, something wrong

; ====================---------------------------------------------------------
; Finish up
; ====================

; Uncomment the following lines to lower Z(bed) after probing
G90                                                                            ; Absolute positioning
G1 Z{global.Nozzle_CL} F2400                                                   ; Move to Z global.Nozzle_CL


; Home Z one last time now that the bed is trammed
G28 Z
M400                                                                           ; Wait for moves to finish


; Uncomment the following lines to lower Z(bed) after probing
G90                                                                            ; Absolute positioning
G1 Z5 F2400                                                                    ; Move to Z 10
>>>>>>> 8fd77e3018ad59a09184f993677f09c623c95735
