; Pause macro file
if !exists(global.cancel_statistics)
  global cancel_statistics = ""
set global.cancel_statistics = """" ^ job.file.fileName ^ """," ^ state.time ^ "," ^ job.duration ^ ",0," ^ job.rawExtrusion

var probe_height = 25
if exists(global.z_probe_height)
  set var.probe_height = global.z_probe_height

M83					; relative extruder moves
G1 E-3 F2500		; retract 3mm
G91					; relative moves
G1 Z{var.probe_height} F5000			; raise nozzle 
G90					; absolute moves
M98 P"/sys/lib/purge-bucket.g" ; move to purge bucket position
;G1 X20 Y20

; LED status
if exists(global.sb_leds)
  set global.sb_leds = "busy"
  ;M98 P"/sys/lib/sb_leds.g"
