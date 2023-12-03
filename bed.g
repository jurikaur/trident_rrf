; bed.g
; called to perform automatic bed compensation via G32
;
; generated by RepRapFirmware Configuration Tool v3.3.16 on Thu Nov 23 2023 20:11:53 GMT+0200 (Eastern European Standard Time)
; bed.g  v2.1
; Called as response to G32
; Used to tram the bed

; ====================---------------------------------------------------------
; Question code
; ====================

; Ask to make sure you want to tram the bed or not
;if global.bed_trammed 
;  M291 S3 R"Bed tramming" P"The bed is allready trammed, want to tram it again?"
;else
;  M291 S3 R"Bed tramming" P"Are you sure you want to tram the bed?"

; ====================---------------------------------------------------------
; Prepare to probe
; ====================

; Report whats going on
M291 R"Bed tramming" P"Please wait..." T0                                      ; Tramming bed message

M561                                                                           ; Clear any bed transform
M290 R0 S0                                                                     ; Reset baby stepping
M84 E0                                                                         ; Disable extruder stepper

; Lower Z relative to current position if needed
if !move.axes[2].homed                                                         ; If Z ain't homed
  G91                                                                          ; Relative positioning
  G1 Z{global.Nozzle_CL} F9000 H1                                              ; Lower Z(bed) relative to current position	
  G90                                                                          ; Absolute positioning
elif move.axes[2].userPosition < {global.Nozzle_CL}                            ; If Z is homed and less than global.Nozzle_CL
  G1 Z{global.Nozzle_CL} F9000                                                 ; Move to Z global.Nozzle_CL

; ====================---------------------------------------------------------
; Home all axes
; ====================

; Make sure all axes are homed, and home Z again anyways
if !move.axes[0].homed || !move.axes[1].homed                                  ; If X & Y axes aren't homed

  ; Home X & Y axis
  M98 P"/sys/homex.g"
  M98 P"/sys/homey.g"

; Home Z axis
  M98 P"/sys/homez.g"
; Move to bed center and home Z
  M98 P"/sys/lib/goto/bed_center.g"                                              ; Move to bed center
  G30 K0 Z-99999                                                                 ; Probe the center of the bed

M400                                                                           ; Wait for moves to finish

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
M98 P"/sys/lib/goto/bed_center.g"                                              ; Move to bed center
M98 P"/sys/lib/speed/speed_probing.g"                                          ; Set low speed & accel
G30 K0 Z-99999                                                                 ; Probe the center of the bed
M400                                                                           ; Wait for moves to finish

set global.bed_trammed = true                                                  ; Set global state


; Uncomment the following lines to lower Z(bed) after probing
G90                                                                            ; Absolute positioning
G1 Z5 F2400                                                                    ; Move to Z 10

M291 R"Bed tramming" P"Done" T5                                                ; Bed tramming done message

; If using Voron TAP, report that probing is completed
if exists(global.TAPPING)
  set global.TAPPING = false
  M402 P0                                                                      ; Return the hotend to the temperature it had before probing



