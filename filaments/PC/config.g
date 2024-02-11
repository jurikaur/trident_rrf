; filaments/ABS/config.g  (v2.1)
; Called when M703 is sent and ABS is loaded

; ====================---------------------------------------------------------
; Settings section
; ====================

; Filament settings

var FilamentType        = "PC"       ; Input the filament type (only for the message)

var Default             = false        ; Use default settings (retraction and PA), true/yes or false/no

;var PA                  = 0.045        ; Pressure advance amount (s) 0.4 brass nozzle
;var PA                  = 0.055         ; Pressure advance for Undertaker 0.4 TC nozzle + galileo2 extruder
var PA                  = 0.0725        ; PA Undertaker .4 + ProtoXtruder(HGX)
var RLen                = 0.40        ; Retraction length (mm)
var X_URLen             = 0.000        ; Extra unretract length (mm)
var RSpd                = 2100         ; Retraction speed (mm/min)
var URSpd               = 1800         ; Unretract speed (mm/min)
var Z_Lift              = 0.400        ; Zlift amount (mm)

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

; ====================---------------------------------------------------------
; Define & send messages
; ====================

if var.Default
  set var.Message1 = "" ^ var.FilamentType ^ " config applied (default settings)"
else
  set var.Message1 = "" ^ var.FilamentType ^ " config applied"
  
if move.extruders[0].pressureAdvance = 0
  set var.Message2 = "Pressure Advance disabled"
else
  set var.Message2 = "Pressure Advance set to " ^ move.extruders[0].pressureAdvance ^ " seconds"

; Config applied message
M118 P0 S{var.Message1}                                                        ; Send message to DWC
M118 P2 S{var.Message1}                                                        ; Send message to PanelDue

; Pressure advance info message
M118 P0 S{var.Message2}                                                        ; Send message to DWC
M118 P2 S{var.Message2}                                                        ; Send message to PanelDue