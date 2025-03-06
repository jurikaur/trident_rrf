; /sys/daemon.g  v2.8
; Used to execute regular tasks, the firmware executes it and once the end of file is reached it waits. If the file is not found it waits and then looks for it again.

; Loop, to be able to turn on/off daemon.g
if exists(global.RunDaemon)
  while global.RunDaemon
    ; Stuff goes below this line
    ; ---------------------------------------------------------------------------         
  
    ; Refresh chamber lights status
    ;if exists(global.chamber_leds)
    ;  if global.chamber_leds != {state.gpOut[0].pwm * 100}
    ;    set global.chamber_leds = state.gpOut[0].pwm * 100

    ; --------------------

    ;Check sb_leds status
    ;var SB_LEDS = true                                                           ; Turn on(true) / off(false) the Stealthburner led "system"
    ;if var.SB_LEDS
    ;  if fileexists("/sys/lib/sb_leds.g")
    ;    M98 P"/sys/lib/sb_leds.g"                                      ; Check if global.sb_leds has changed since last run/loop

    ;ventilate Chamber
    if exists(global.ventilateChamber)
      M98 P"0:/macros/ventilateChamber"                          ; turn off air filtration fan
    
  ; ---------------------------------------------------------------------------
    ; Daemon loop delay
    G4 S10                                                                      ; Delay running again or next command for at least 0,25 seconds