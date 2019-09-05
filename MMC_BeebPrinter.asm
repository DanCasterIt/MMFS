\\ EXPERIMENTAL DRIVER FOR BEEB
\\ WITH MMC CONNECTED TO PRINTER PORT

iora%=_VIA_BASE + &01
ddra%=_VIA_BASE + &03

\\ MOSI is connected to D0
\\ SCK  is connected to D1
\\ MISO is connected to D7

clockbit%=&02
        
one_clocklow%=&FF-clockbit%

\\ Start of Beeb Printer Port Specific Code

\\ Read byte (User Port)
\\ Write FF
.MMC_GetByte
.P1_ReadByte
    LDA #&FF    
    LDX #one_clocklow%
    SEC          \\ Set carry so D0 (MOSI) remains high after ROL
FOR n, 0, 7
    STX iora%    \\ Take clock (D1) low
    ROL iora%    \\ Sample D7 (MISO) into C, and take clock (D1) high
    ROL A        \\ C=1 after this, because A starts off as FF
NEXT
    RTS

\\ This is always entered with A and X with the correct values
.P1_ReadBits7
FOR n, 0, 2
    STX iora%
    ROL iora%
    ROL A
NEXT

 \\ This is always entered with A and X with the correct values
.P1_ReadBits4
FOR n, 0, 3
    STX iora%
    ROL iora%
    ROL A
NEXT
    RTS

\\ wait for response bit
\\ ie for clear bit
.P1_WaitResp
{
    LDA #&FF
    LDX #one_clocklow%
    LDY #0
.loop
    DEY
    BEQ timeout
    STX iora%
    ROL iora%
    BCS loop
.timeout
    ROL A
    RTS
}

\\ Write byte (User Port)
\\ Ignore byte in
.P1_WriteByte
{
    ASL A
FOR N, 0, 7
    ROL A
    AND #&FD
    STA iora%
    ORA #clockbit%
    STA iora%
NEXT
    RTS
}

\\ RESET DEVICE
.MMC_DEVICE_RESET
    LDA ddra%
    AND #&7F
    ORA #&03
    STA ddra%
    RTS

INCLUDE "MMC_PrinterCommon.asm"