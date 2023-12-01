; /sys/homeall.g  v2.5
; Called to home all axes
; Configured for sensorless homing / stall detection on a Duet 3 Mini 5+ and LDO-42STH48-2504AC steppers on XY
 
;---/
; -/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--
; THIS MACRO ONLY WORKS WITH RRF 3.5.0b1 AND LATER!!
;--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--/--
;-/
 

; ====================---------------------------------------------------------
; Home all axis
; ====================
 
M98 P"/sys/homex.g" Z"OK"                                                      ; Home X axis and pass param.Z "OK" since we allready lowered Z
M98 P"/sys/homey.g" Z"OK"                                                      ; Home Y axis and pass param.Z "OK" since we allready lowered Z
M98 P"/sys/homez.g" Z"OK"                                                      ; Home Z axis and pass param.Z "OK" since we allready lowered Z
 
; ====================---------------------------------------------------------
; Finish up
; ====================
 
