if sensors.probes[0].value[0] == 1000
  M564 H1 ; forbid movement of axes that have not been homed
  G90 ; Absolute Positioning
  ;G1 X52 Y285 F3000 ; go to probe location
  G1 X94 Y285 F6000
  G1 Y305 ; activate bump-dock
  G1 Y280 ; move away with deployed probe
  M400 S1 ; Wait all moves to finish
  if sensors.probes[0].value[0] == 1000
    abort "Probe attach failed"
G1 X150 Y150 ; go to bed center
;G1 X181 Y274 F6000 ; go to Z enstop