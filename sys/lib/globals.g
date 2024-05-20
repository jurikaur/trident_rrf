if !exists(global.RunDaemon)
  global RunDaemon = true

if !exists(global.ventilateChamber)
  global ventilateChamber = 0 ; Exhaust filter timer

if !exists(global.chamber_leds)
  global chamber_leds = 0 ; Chamber light %

if !exists(global.sb_leds)
  global sb_leds = "boot" ; Neopixel led color

if !exists(global.z_probe_height)
  global z_probe_height = 25 ; z probe height for safe attach/detach probe