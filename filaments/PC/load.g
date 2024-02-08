; filaments/PC/load.g
; Called when M701 S"PC" is sent

; ====================---------------------------------------------------------
; Settings section
; ====================

; Filament settings

var FilamentType        = "PC"       ; Input the filament type (only for the message)

; Message placeholders
var Message1 = "N/A"

; ====================---------------------------------------------------------
; Message section
; ====================

; Generate message
set var.Message1 = "" ^ var.FilamentType ^ " filament loaded"

; Filament loaded message
M118 P0 S{var.Message1}                                                        ; Send message to DWC
M118 P2 S{var.Message1}                                                        ; Send message to PanelDue