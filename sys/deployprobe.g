if sensors.probes[0].value[0] == 1000
  M564 H1
  G90
  G1 X42 Y285 F3000
  G1 Y305
  G1 Y280
  M400
  if sensors.probes[0].value[0] == 1000
    abort "Probe attach failed"
G1 X150 Y150