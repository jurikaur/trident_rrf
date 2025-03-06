;M307 H1 R11.861 K2.821:0.000 D0.99 E1.35 S1.00 B0 V24.1 ; Load heater tuning parameters for 200C
M307 H1 R6.653 K1.315:0.197 D1.16 E1.35 S1.00 B0 V24.2
; Filament settings

var FilamentType        = "PLA"       ; Input the filament type (only for the message)

var Default             = false        ; Use default settings (retraction and PA), true/yes or false/no

;var PA                  = 0.065         ; 3D Jake ecoPLA
var PA                  = 0.038        ; Polymaker Polyterra PLA
var RLen                = 0.8        ; Retraction length (mm)
var X_URLen             = 0.000        ; Extra unretract length (mm)
var RSpd                = 3600         ; Retraction speed (mm/min)
var URSpd               = 3600         ; Unretract speed (mm/min)
var Z_Lift              = 0.1        ; Zlift amount (mm)

; Message placeholders
var Message1 = "N/A"
var Message2 = "N/A"

; ====================---------------------------------------------------------
; Config section
; ====================

if !var.Default
  ; Pressure Advance
  M572 D0 S{var.PA}                                                            ; Set extruder 0 pressure advance to 0.1 seconds

  ;Retraction & Zlift
  M207 S{var.RLen} R{var.X_URLen} F{var.RSpd} T{var.URSpd} Z{var.Z_Lift}       ; Set firmware retraction length, extra un-retract lenght, retract speed, unretract speed & zlift
