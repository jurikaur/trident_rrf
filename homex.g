; /sys/homex.g  v2.5
; called to home the X axis
; Configured for sensorless homing / stall detection on a Duet 3 Mini 5+ and LDO-42STH48-2504AC steppers on XY
 
;---/
; -/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--
; THIS MACRO ONLY WORKS WITH RRF 3.5.0b1 AND LATER!!
;--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--
;-/
 
; ====================---------------------------------------------------------
; Settings section
; ====================
 
; Nozzle clearance (gets overridden if you have global.Nozzle_CL)
var Clearance           = 10                                                    ; The "safe" clearance you want to have between the noszzle and bed before moving the printhead
 
; XY driver numbers
var X                   = 0.0                                                  ; The driver number for your X (B) stepper
var Y                   = 0.1                                                  ; The driver number for your Y (A) stepper
 
; Sensorless homing sensitivity
var Sen                 = -26                                                  ; Stall detection sensitivity
 
; Step Back Distance
var SBD                 = 2                                                    ; The distance in mm that the head moves back before homing
 
; XY Currrent Reduction
var CR                  = 20                                                   ; The % of the XY stepper max current you want to be set during homing
 
; Don't touch anyting beyond this point(unless you know what you're doing)!!
; ====================---------------------------------------------------------
 
if exists(global.Nozzle_CL)
  set var.Clearance = {global.Nozzle_CL}
 
; ====================---------------------------------------------------------
; Lower Z axis
; ====================
 
; If Z isn't allready been lowered
if !exists(param.Z)
  ; Lower Z if needed
  if !move.axes[2].homed                                                       ; If Z isn't homed
    ; Lower Z currents, speed & accel
    if fileexists("/sys/lib/current/z_current_low.g")
      M98 P"/sys/lib/current/z_current_low.g"                                  ; Set low Z currents
    else
      M913 Z60                                                                 ; Set Z motors to n% of their max current
    if fileexists("/sys/lib/speed/speed_probing.g")
      M98 P"/sys/lib/speed/speed_probing.g"                                    ; set low speed & accel
    else
      M204 P500 T1500                                                          ; Set printing acceleration and travel accelerations (mm/s²)
    G91                                                                        ; Relative positioning
    G1 Z{var.Clearance} F9000 H1                                               ; Lower Z(bed) relative to current position
    G90                                                                        ; Absolute positioning
    if fileexists("/sys/lib/current/z_current_high.g")
      M98 P"/sys/lib/current/z_current_high.g"                                 ; Restore normal Z currents
    else
      M913 Z100                                                                ; Set Z motors to 100% of their max current
  elif move.axes[2].userPosition < {var.Clearance}                             ; If Z is homed but less than var.Clearance
    ; Lower Z currents, speed & accel
    if fileexists("/sys/lib/current/z_current_low.g")
      M98 P"/sys/lib/current/z_current_low.g"                                  ; Set low Z currents
    else
      M913 Z60                                                                 ; Set Z motors to n% of their max current
    if fileexists("/sys/lib/speed/speed_probing.g")
      M98 P"/sys/lib/speed/speed_probing.g"                                    ; set low speed & accel
    else
      M204 P500 T1500                                                          ; Set printing acceleration and travel accelerations (mm/s²)
    G1 Z{var.Clearance} F9000                                                  ; Move to Z var.Clearance
    if fileexists("/sys/lib/current/z_current_high.g")
      M98 P"/sys/lib/current/z_current_high.g"                                 ; Restore normal Z currents
    else
      M913 Z100                                                                ; Set Z motors to 100% of their max current
 
; ====================---------------------------------------------------------
; Home X axis
; ====================
 
; Turn off the X stepper
M84 X                                                                          ; Disable X axis stepper(don't know why, but it's needed for now)
M400                                                                           ; Wait for moves to finish
 
; Enable stealthChop on XY steppers
M569 P{var.X} S1 D3 V10                                                        ; Set X axis driver in stealthChop mode
M569 P{var.Y} S1 D3 V10                                                        ; Set Y axis driver in stealthChop mode
 
; Enable sensorless homing
M574 X2 Y2 S4                                                                  ; Configure sensorless endstop for high end on X & Y
 
; Lower XY currents, speed & accel
if fileexists("/sys/lib/current/xy_current_low.g")
  M98 P"/sys/lib/current/xy_current_low.g" C{var.CR}                           ; Set low XY currents and pass param.C with the values set here
else
  M913 X{var.CR} Y{var.CR}                                                     ; Set X Y motors to var.CR% of their max current
if fileexists("/sys/lib/speed/speed_probing.g")
  M98 P"/sys/lib/speed/speed_probing.g"                                        ; Set low speed & accel
else
  M204 P500 T1500                                                              ; Set printing acceleration and travel accelerations (mm/s²)
M400                                                                           ; Wait for current moves to finish
 
; Stall detection parameters
M915 X Y S{var.Sen} F0 R0 H200                                                 ; Set stall detection sensitivity(-128 to +127), filter mode, action type and minimum motor full steps per second P{var.X}:{var.Y}
M400                                                                           ; Wait for moves to finish
 
G91                                                                            ; Relative positioning
 
; Unflag stalls
G1 X1.0 Y-1.0 F300 H2                                                          ; Energise motors and move them 1mm in the -X direction to ensure they are not stalled
 
; Home X axis
G1 X600 F3000 H1                                                               ; Move X axis max and stop there
G1 X{0 -var.SBD} F2000                                                         ; Move away from axis max
G1 X600 F3000 H1                                                               ; Move X axis max and stop there
G1 X{0 -var.SBD} F2000                                                         ; Move away from axis max
M400                                                                           ; Wait for moves to finish
 
G90                                                                            ; Absolute positioning
 
; Enable spread cycle on XY steppers
M569 P{var.X} S1 D2                                                            ; Set X axis driver in spread cycle mode
M569 P{var.Y} S1 D2                                                            ; Set Y axis driver in spread cycle mode
 
; ====================---------------------------------------------------------
; Finish up
; ====================
 
; Restore XY currents, speed & accel
if fileexists("/sys/lib/current/xy_current_high.g")
  M98 P"/sys/lib/current/xy_current_high.g"                                    ; Set high XY currents
else
  M913 X100 Y100                                                               ; Set X Y motors to var.100% of their max current
if fileexists("/sys/lib/speed/speed_printing.g")
  M98 P"/sys/lib/speed/speed_printing.g"                                       ; Set high speed & accel
else
  M204 P1500 T3000                                                             ; Set printing acceleration and travel accelerations (mm/s²)

G91                                                                        ; Relative positioning
G1 Z{-var.Clearance} F9000 H1                                               ; Lower Z(bed) relative to current position
G90                                                                        ; Absolute positioning
 