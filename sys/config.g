; Configuration file for RepRapFirmware on Duet 3 Mini 5+ Ethernet
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.5.0-rc.2+3 on Wed Jan 17 2024 21:14:20 GMT+0200 (Eastern European Standard Time)

; General
M550 P"VT1011" ; set hostname

; Accessories
M575 P1 S0 B57600 ; configure PanelDue support

; Network
M552 P192.168.90.200 S1 ; configure Ethernet adapter
M553 P255.255.255.0 ; set netmask
M554 P192.168.90.1 ; set gateway
M586 P0 S1 ; configure HTTP
M586 P1 S1 ; configure FTP

; Wait a moment for the CAN expansion boards to become available
G4 S2

; Accelerometers
M955 P121.0 I10 ; configure accelerometer on board #121

; Smart Drivers
M569 P0.0 S1 D2 ; driver 0.0 goes forwards (X axis)
M569 P0.1 S1 D2 ; driver 0.1 goes forwards (Y axis)
M569 P0.2 S0 D3 V2000 ; driver 0.2 goes backwards (Z axis)
M569 P0.3 S0 D3 V2000 ; driver 0.3 goes backwards (Z axis)
M569 P0.4 S0 D3 V2000 ; driver 0.4 goes backwards (Z axis)
M569 P121.0 S0 D2 ; driver 121.0 goes backwards (extruder 0)

; Motor Idle Current Reduction
M906 I30 ; set motor current idle factor
M84 S30 ; set motor current idle timeout

; Axes
M584 X0.0 Y0.1 Z0.3:0.2:0.4 ; set axis mapping
M350 X16 Y16 Z8 I1 ; configure microstepping with interpolation
M906 X1700 Y1700 Z1000 ; set axis driver currents
M92 X160 Y160 Z400 ; configure steps per mm
M208 X0:300 Y0:305 Z0:240 ; set minimum and maximum axis limits
M566 X540 Y540 Z12 ; set maximum instantaneous speed changes (mm/min)
M203 X18000 Y18000 Z900 ; set maximum speeds (mm/min)
M201 X8000 Y8000 Z350 ; set accelerations (mm/s^2)

; Extruders
M584 E121.0 ; set extruder mapping
M350 E16 I1 ; configure microstepping with interpolation
M906 E700 ; set extruder driver currents
M92 E571.8954248 ; ProtoXtruder HGX gears
;M92 E617.6470588 ; configure steps per mm galileo2
M566 E300 ; set maximum instantaneous speed changes (mm/min)
M203 E7200 ; set maximum speeds (mm/min)
M201 E2000 ; set accelerations (mm/s^2)

<<<<<<< HEAD
; Kinematics
M669 K1 ; configure CoreXY kinematics
=======
; Drive currents
M906 X1700 Y1700 Z800 E840 I30                   ; set motor currents (mA) and motor idle factor in per cent
M84 X Y Z E0 S30                                 ; Set idle timeout
>>>>>>> 8fd77e3018ad59a09184f993677f09c623c95735

; Probes
M558 K0 P8 C"121.io2.in" H2 F600:180 T18000 A10 S0.01 ; configure unfiltered digital probe via slot #0
G31 P500 X0 Y28 Z4.8 ; set Z probe trigger value, offset and trigger height

; Endstops
M574 X2 P"121.io1.in" S1 ; configure X axis endstop
M574 Y2 P"io6.in" S1 ; configure Y axis endstop
M574 Z0 ; configure Z axis endstop

<<<<<<< HEAD
; Sensors
M308 S0 P"temp0" Y"thermistor" A"Bed" T100000 B4725 C7.06e-8 ; configure sensor #0
M308 S1 P"121.temp0" Y"pt1000" A"Hotend" ; configure sensor #1
M308 S2 P"temp1" Y"thermistor" A"Chamber" T100000 B4725 C7.06e-8 ; configure sensor #2
=======
; Z-probe (Voron TAP)
M558 K0 P8 C"^121.io2.in" H2 R0.2 F300:180 T18000 A3 S0.05 ; Set Z probe type to switch and the dive height + speeds
G31 K0 P500 X0 Y0 Z-1.0                          ; Set Z probe trigger value, offset and trigger height (higher Z value = nozzle closer to bed)

; Bed leveling
M671 X150:-38:338 Y366.6:1.5:1.5 S10             ; Leadscrew locations (Rear, Right, Left)
M557 X25:275 Y25:275 S20                         ; define grid for mesh bed compensation

; Accelerometer
M955 P121.0 I10                                  ; Configure accelerometer
;M593 P"zvdd" F41                                ; disabled 3.5.0rc1 has layer shift issues when IS enabled
>>>>>>> 8fd77e3018ad59a09184f993677f09c623c95735

; Heaters
M950 H0 C"out0" T0 ; create heater #0
M143 H0 P0 T0 C0 S120 A0 ; configure heater monitor #0 for heater #0
M143 H0 P1 T0 C0 S120 A2 ; configure heater monitor #1 for heater #0
M143 H0 P2 T0 C0 S125 A1 ; configure heater monitor #2 for heater #0
M950 H1 C"121.out0" T1 ; create heater #1
M143 H1 P0 T1 C0 S350 A0 ; configure heater monitor #0 for heater #1
M950 H2 C"out2" T2 ; create heater #2
M143 H2 P0 T2 C0 S65 A0 ; configure heater monitor #0 for heater #2
M143 H2 P1 T2 C0 S65 A2 ; configure heater monitor #1 for heater #2
M143 H2 P2 T2 C0 S70 A1 ; configure heater monitor #2 for heater #2

; Heated beds
M140 P0 H0 ; configure heated bed #0

; Heated chambers
M141 P0 H2 ; configure heated chamber #0

; Fans
M950 F0 C"121.out1" ; create fan #0
M106 P0 C"Part Cooling" S0 L0 X1 B0.1 ; configure fan #0
M950 F1 C"121.out2" ; create fan #1
M106 P1 C"Hotend Fan" S0 B0.1 H1 T45 ; configure fan #1
M950 F2 C"out3" ; create fan #2
M106 P2 C"BEDF_12V" S0 L0 X1 B0.1 ; configure fan #2
M950 F3 C"out6" ; create fan #3
M106 P3 C"EXHAUSTF" S0 B0.1 H2 T45 ; configure fan #3
M950 F4 C"out5" ; create fan #4
M106 P4 C"FILTER" S0 B0.1 H0 T90 ; configure fan #4

; Tools
M563 P0 S"Mosquito Magnum" D0 H1 F0 ; create tool #0
M568 P0 R0 S0 ; set initial tool #0 active and standby temperatures to 0C

; Miscellaneous
M501 ; load saved parameters from non-volatile memory
T0 ; select first tool

; Custom settings
; Duet5+ mcu temp
M308 S3 Y"mcu-temp" A"MCU"                       ; Configure sensor 2 as MCU temperature
M912 P0 S-2.9                                    ; MCU temp calibration parameters

; toolhead temp
M308 S12 Y"mcu-temp" P"121.dummy" A"1LC MCU"

;Chamber LED
M950 P0 C"out1"                                  ; Create output Port0 attached to out1 connector for LED lights

;Input Shaper
M593 P"mzv" F25 S0.01 L0.15                           ; disabled 3.5.0rc1 has layer shift issues when IS enabled

; Bed leveling
M671 X-50:150:350 Y18:348:18 S5                  ; front left, back, front right
M557 X15:285 Y30:285 P5                         ; define grid for mesh bed compensation, bed mesh distance 83mm to get 4x4 square
