; Configuration file for Duet 3 Mini 5+ (firmware version 3.3)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v3.3.16 on Thu Nov 23 2023 20:11:54 GMT+0200 (Eastern European Standard Time)

; General preferences
M575 P1 S1 B57600                                ; enable support for PanelDue
G90                                              ; send absolute coordinates...
M83                                              ; ...but relative extruder moves
M550 P"VT1011"                                   ; set printer name
M669 K1                                          ; select CoreXY mode

; Wait a moment for the CAN expansion boards to start
G4 S2

; Network
M552 P192.168.90.200 S1                          ; enable network and set IP address
M553 P255.255.255.0                              ; set netmask
M554 P192.168.90.1                               ; set gateway
M586 P0 S1                                       ; enable HTTP
M586 P1 S1                                       ; enable FTP
M586 P2 S0                                       ; disable Telnet

;          --- Drive map ---
; (While looking at the printer top down)

;             0.0-----0.1
;              |  0.2  |
;              |-------|
;              |0.3|0.4|
;               ---+---
;                Front

; Drives for X & Y
M569 P0.0 S1 D2                                    ; physical drive 0.0 goes forwards
M569 P0.1 S1 D2                                    ; physical drive 0.1 goes forwards

; Drives for Z
M569 P0.2 S0 D3                                     ; physical drive 0.2 goes backwards Stealthchop  | Z1
M569 P0.3 S0 D3                                    ; physical drive 0.3 goes backwards Stealthchop  | Z0
M569 P0.4 S0 D3                                    ; physical drive 0.4 goes backwards Stealthchop  | Z2

; Drive for Extruder 
M569 P121.0 S0 D2                                   ; physical drive 121.0 goes backwards

; Motor mapping and steps per mm
M584 X0.0 Y0.1 Z0.3:0.2:0.4 E121.0               ; set drive mapping
M350 X16 Y16 Z16 E16 I1                          ; configure microstepping with interpolation
M92 X160 Y160 Z800                               ; set steps per mm
M92 E617.6470588                                 ; galileo 2 steps per mm

; Drive currents
M906 X1700 Y1700 Z1000 E700 I30                   ; set motor currents (mA) and motor idle factor in per cent
M84 X Y Z E0 S30                                 ; Set idle timeout

; Axis accelerations and speeds
M566 X500 Y500 Z120 E300 P1                       ; set maximum instantaneous speed changes (mm/min)
M203 X18000 Y18000 Z900 E7200                    ; set maximum speeds (mm/min)
M201 X8000 Y8000.00 Z350 E2000                    ; set accelerations (mm/s^2)

; Reduced accelerations
;M201.1 X500 Y500 Z80 E500                        ; Set reduced acceleration for special move types (mm/s²)

; Printing and travel accelerations
M204 P5000 T7000                                 ; Set printing acceleration and travel accelerations (mm/s²)


; Axis Limits
M208 X0 Y0 Z0 S1                                  ; set axis minimal

M208 X300 Y305 Z240 S0                           ; set axis maximal

; Endstops
M574 X2 S1 P"121.io1.in"                         ; configure sensorless endstop for high end on X
M574 Y2 S1 P"io6.in"                             ; configure sensorless endstop for high end on Y

; Klicky
M558 P8 C"^121.io2.in" T18000 F600:180 H2 A10 S0.01   ; set Z probe type to KLICKY and the dive height + speeds
G31 P500 X0 Y28 Z4.80                            ; 5,4 set Z probe trigger value, offset and trigger height(Z_offset - bigger number bed closer to nozzle)

; Bed leveling
M671 X-50:150:350 Y18:348:18 S5                  ; front left, back, front right
M557 X15:285 Y30:285 P5                         ; define grid for mesh bed compensation, bed mesh distance 83mm to get 4x4 square

; Accelerometer
M955 P121.0 I10                                  ; Configure accelerometer
M593 P"mzv" F25 S0.1                            ; disabled 3.5.0rc1 has layer shift issues when IS enabled

; Heaters
; Bed heater
M308 S0 P"temp0" Y"thermistor" T100000 B4725 C7.06e-8 A"Bed" ; 4138 configure sensor 0 as thermistor on pin temp0
M950 H0 C"out0" T0                               ; create bed heater output on out0 and map it to sensor 0
M307 H0 B0 S1.00                                 ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                          ; map heated bed to heater 0
M143 H0 S120                                     ; set temperature limit for heater 0 to 120C
M143 H0 A2 C0 S120                               ; Make sure bed heater stays below 120C
M143 H0 A1 C0 S125                               ; Make sure bed heater shuts down at 125C

; Hodend heater
M308 S1 P"121.temp0" Y"pt1000" A"Hotend"         ; configure sensor 1 as thermistor on pin 121.temp0
M950 H1 C"121.out0" T1                           ; create nozzle heater output on 121.out0 and map it to sensor 1
M307 H1 B0 S1.00                                 ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S350                                     ; set temperature limit for heater 1 to 350C


; Chamber heater
M308 S9 P"temp1" Y"thermistor" A"Chamber" T100000 B4725 C7.06e-8 ; Chamber thermistor conf - ATC Semitec 104NT-4-R025H42G
M950 H9 C"io5.in" Q1 T9                           ; dummy port used
M307 H9 B0 S1.00
M141 H9 ; fake chamber heater for reporting in DWC
M143 H9 P0 S40 A2
M143 H9 P1 S60

; Duet5+ mcu temp
M308 S3 Y"mcu-temp" A"MCU"                       ; Configure sensor 2 as MCU temperature
M912 P0 S-2.9                                    ; MCU temp calibration parameters

; toolhead temp
M308 S12 Y"mcu-temp" P"121.dummy" A"1LC MCU"

; Fans
;Part cooling
M950 F0 C"121.out1"                              ; create fan 0 on pin 121.out1 and set its frequency
M106 P0 S0 H-1 C"Part Cooling"                   ; set fan 0 value. Thermostatic control is turned off

;Hotend fan
M950 F1 C"121.out2"                              ; create fan 1 on pin 121.out2 and set its frequency
M106 P1 S1 H1 T45 C"Hotend Fan"                  ; set fan 1 value. Thermostatic control is turned on

; Bed fan
M950 F2 C"out3"                                  ; create fan 2 on pin out3 and set its frequency
M106 P2 C"BEDF_12V" S0 H-1                       ; set fan 2 value. Thermostatic control is turned on

; Exhaust fan
M950 F3 C"out6"                                  ; create fan 3 on pin out6 and set its frequency
M106 P3 C"EXHAUSTF" S0 B0.1 H9 T45               ; set fan 3 value. Thermostatic control is turned on

; Nevermore filter
M950 F4 C"out5"                                  ; create fan 4 on pin out5 and set its frequency
M106 P4 C"FILTER" S0 B0.1 H0 T90                 ; set fan 4 value. Thermostatic control is turned on

; Tools
M563 P0 S"Mosquito Magnum" D0 H1 F0              ; define tool 0
G10 P0 X0 Y0 Z0                                  ; set tool 0 axis offsets
G10 P0 R0 S0                                     ; set initial tool 0 active and standby temperatures to 0C

; Custom settings are not defined

; Miscellaneous
M950 P0 C"out1"                                  ; Create output Port0 attached to out1 connector for LED lights
M501                                             ; load saved parameters from non-volatile memory
T0                                               ; select first tool