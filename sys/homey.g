; homey.g
; called to home the Y axis
;
; generated by RepRapFirmware Configuration Tool v3.4.0-LPC-STM32+4 on Thu Jul 28 2022 11:07:51 GMT-0600 (Mountain Daylight Time)
G91              ; relative positioning
G1 H2 Z10 F7000   ; lift Z relative to current position
G1 H1 Y400 F4000 ; move quickly to Y axis endstop and stop there (first pass)
G1 Y-5 F7000     ; go back a few mm
G1 H1 Y400 F360  ; move slowly to Y axis endstop once more (second pass)
G1 Y-2 F7000     ; go back a few mm
G1 H2 Z-5 F7000  ; lower Z again
G90              ; absolute positioning