M558.3 K0 S0               ; S0 -> enter normal probing mode
; get the S and R values by calling M558.2 K1 S-1 in a good Z distance. 5-10mm from bed worked fine for me.
; manually move Z axis and ensure no 99999 values are being reported 
; (when coming super close to bed it may happen, but should be fine as it is not used to probe in super-close distance.)
M558.2 K0 S16 R135381