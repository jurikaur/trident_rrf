<<<<<<< HEAD
M18 z
M17 Z
G4 P150

G91              ; relative positioning
G1 H2 Z10 F6000   ; lift Z relative to current position
G90              ; absolute positioning
M401
G1 X150 Y150 F6000 ; go to first probe point
G30 K0 ;Z-99999              ; home Z by probing the bed
M402

; Uncomment the following lines to lift Z after probing
G91             ; relative positioning
G1 Z5 F100      ; lift Z relative to current position
G90             ; absolute positioning
=======
; /sys/homez.g  v2.5
; Called to home the Z axis with probe K0
 
; ====================---------------------------------------------------------
; Settings section
; ====================
 
; Nozzle clearance (gets overridden if you have global.Nozzle_CL)
var Clearance           = 10                                                   ; The "safe" clearance you want to have between the noszzle and bed before moving the printhead
 
; Don't touch anyting bellow this point(unless you know what you're doing)!!
; ====================---------------------------------------------------------
 
if exists(global.Nozzle_CL)
  set var.Clearance = {global.Nozzle_CL}
 
; ====================---------------------------------------------------------
; Lower Z axis
; ====================
 
; Lower Z if needed
if !move.axes[2].homed                                                       ; If Z isn't homed
  ; Lower Z currents, speed & accel
  M98 P"/sys/lib/current/z_current_low.g"                                  ; Set low Z currents
  M98 P"/sys/lib/speed/speed_probing.g"                                    ; set low speed & accel
  G91                                                                        ; Relative positioning
  G1 Z{var.Clearance} F9000 H1                                               ; Lower Z(bed) relative to current position
  G90                                                                        ; Absolute positioning
  M98 P"/sys/lib/current/z_current_high.g"                                 ; Restore normal Z currents
elif move.axes[2].userPosition < {var.Clearance}                             ; If Z is homed but less than var.Clearance
  ; Lower Z currents, speed & accel
  M98 P"/sys/lib/current/z_current_low.g"                                  ; Set low Z currents
  M98 P"/sys/lib/speed/speed_probing.g"                                    ; set low speed & accel
  G1 Z{var.Clearance} F9000                                                  ; Move to Z var.Clearance
  M98 P"/sys/lib/current/z_current_high.g"                                 ; Restore normal Z currents
 
; ====================---------------------------------------------------------
; Home Z axis
; ====================
 
  ; Lower currents
  M98 P"/sys/lib/current/xy_current_low.g"                                     ; Set low XY currents
 
  ; Move to bed center and home Z
  M98 P"/sys/lib/goto/bed_center.g"                                            ; Move to bed center
  M98 P"/sys/lib/speed/speed_probing.g"                                        ; Set low speed & accel
  G30 K0 Z-99999                                                               ; Probe the center of the bed
  M400                                                                         ; Wait for moves to finish
 
; ====================---------------------------------------------------------
; Finish up
; ====================
 
  ; Full currents, speed & accel
  M98 P"/sys/lib/current/z_current_high.g"                                     ; Restore normal Z currents
  M98 P"/sys/lib/current/xy_current_high.g"                                    ; Set high XY currents
  M98 P"/sys/lib/speed/speed_printing.g"                                       ; Restore normal speed & accels
 
; Uncomment the following lines to lower Z(bed) after probing
G90                                                                            ; Absolute positioning
G1 Z{var.Clearance} F2400                                                      ; Move to Z var.Clearance
 
M402 P0                                                                      ; Return the hotend to the temperature it had before probing
>>>>>>> 8fd77e3018ad59a09184f993677f09c623c95735
