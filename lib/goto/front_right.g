; /sys/lib/goto/front_right.g
; called to move the nozzle to front bed center

G90                                                                            ; Absolute positioning
G1 X{(global.bed_x - (global.bed_x / 4))} Y0 F6000                             ; Move to the center of the bed