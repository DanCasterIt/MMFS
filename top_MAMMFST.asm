_MASTER_=TRUE           ; Master version
_SWRAM_=FALSE           ; Sideways RAM Version
_ROMS_=FALSE            ; Include *ROMS command (i.e. No DFS or 8271 DFS)
_UTILS_=FALSE           ; Include utilites (*DUMP etc.) (i.e. No DFS)
_TUBEHOST_=FALSE        ; Include Tube Host (i.e. no DFS or DFS 0.90)
_VIA_BASE=&FE60         ; Base Address of 6522 VIA
_TUBE_BASE=&FEE0        ; Base Address of Tube
_TURBOMMC=1             ; 1 = build for TurboMMC, and enable PB2-4 as outputs

MACRO BASE_NAME
	EQUS "Master MMFS Turbo"
ENDMACRO

INCLUDE "mmfs100.asm"