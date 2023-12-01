; /sys/lib/print/print_prep.g  v1.1
; Called as part of print_start.g	
; Used to make sure all axis is homed and that the bed is trammed

; ====================---------------------------------------------------------
; Prepare to probe
; ====================

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
; Homing check
; ====================

; Make sure all axes are homed, and home Z again anyways
if !move.axes[0].homed || !move.axes[1].homed                                  ; If X & Y axes aren't homed

  M98 P"/sys/homex.g"                                                          ; Home X
  M98 P"/sys/homey.g"                                                          ; Home Y

; Home Z axis
; Move to bed center and home Z
M98 P"/sys/homez.g"
M400                                                                           ; Wait for moves to finish

; ====================---------------------------------------------------------
; Check if bed is trammed
; ====================

; If the bed isn't trammed
if global.bed_trammed = false

  ; Report whats going on
  M291 R"Bed tramming" P"Please wait..." T0                                    ; Tramming bed message

  ; ====================-------------------------------------------------------
  ; Probing code
  ; ====================

  M98 P"/sys/bed.g"

  ; ====================-------------------------------------------------------
  ; Finish up
  ; ====================

  ; Uncomment the following lines to lower Z(bed) after probing
  G90                                                                          ; Absolute positioning
  G1 Z{global.Nozzle_CL} F2400                                                 ; Move to Z global.Nozzle_CL


  ; Home Z
  ; Move to bed center and home Z
  M98 P"/sys/lib/goto/bed_center.g"                                            ; Move to bed center
  M98 P"/sys/lib/speed/speed_probing.g"                                        ; Set low speed & accel
  G30 K0 Z-99999                                                               ; Probe the center of the bed

  set global.bed_trammed = true                                                ; set global state

  M291 R"Bed tramming" P"Done" T5                                              ; bed tramming done message

else
  ; ====================-------------------------------------------------------
  ; Response if trammed
  ; ====================

  ; Bed already trammed, no need to probe  
  M291 S1 R"Bed tramming" P"Bed allready trammed" T1

; Uncomment the following lines to lower Z(bed) after probing
G90                                                                            ; Absolute positioning
G1 Z{global.Nozzle_CL} F2400                                                   ; Move to Z global.Nozzle_CL

; If using Voron TAP, report that probing is completed
if exists(global.TAPPING)
  set global.TAPPING = false
  M402 P0                                                                      ; Return the hotend to the temperature it had before probing
