; /sys/lib/current/xy_current_high.g  v2.2
; Called when printing
; Used to set X Y motor currents for printing

; Stepper current %
var PCT                 = 100                                                  ; Set the % of the stepper max current you want to be set!

; Don't touch anyting bellow this point!
; -----------------------------------------------------------------------------

M913 X{var.PCT} Y{var.PCT}                                                     ; Set X Y motors to var.PCT % of their max current

if exists(param.M)                                                             ; param.M passed stands for Message (post echo message)
  echo "XY steppers at " ^ var.PCT ^ "% of max current!"