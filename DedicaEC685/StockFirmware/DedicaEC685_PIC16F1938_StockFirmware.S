        processor 16f1938
        radix dec

        #include <xc.inc>

; The recognition of labels and registers is not always good, therefore
; be treated cautiously the results.

        CONFIG  FOSC     = INTOSC
        CONFIG  WDTE     = ON
        CONFIG  PWRTE    = OFF ;ON
        CONFIG  MCLRE    = ON
        CONFIG  CP       = OFF
        CONFIG  CPD      = OFF
        CONFIG  BOREN    = ON
        CONFIG  CLKOUTEN = OFF
        CONFIG  IESO     = OFF
        CONFIG  FCMEN    = OFF
        CONFIG  WRT      = OFF
;        CONFIG  VCAPEN   = RA6
        CONFIG  PLLEN    = OFF
        CONFIG  STVREN   = ON
        CONFIG  BORV     = LO
 ;       CONFIG  DEBUG    = OFF
        CONFIG  LVP      = OFF

  ;      __idlocs 0xFFFF

;===============================================================================
; DATA address definitions

Common_RAM      equ     0x0070                              ; size: 16 bytes

;===============================================================================
; CODE area

        ; code

PSECT   resetVec,class=CODE,delta=2

org     0x0                                ; address: 0x0000
vector_reset:                                               ; address: 0x0000

        pagesel   label_004
        goto    label_004


PSECT   interruptVec,class=CODE,delta=2
global vector_reset
vector_int:                                                 ; address: 0x0004

        pagesel   label_002
        btfsc   T0IF                                ; reg: 0x00b, bit: 2
        btfss   T0IE                                ; reg: 0x00b, bit: 5
        goto    label_002
        pagesel function_018
	pcall   function_018
	retfie

psect	code
label_002:                                                  ; address: 0x000b

        movlb   0x00
        btfss   CCP2IF                                ; reg: 0x012, bit: 0
        ljmp    label_003
        movlb   0x01
        btfss   CCP2IE                                ; reg: 0x092, bit: 0
        ljmp    label_003
        ;movlp   0x1a
        fcall    function_070
        retfie

label_003:                                                  ; address: 0x0014

        movlb   0x00
        btfss   TMR2IF                                ; reg: 0x011, bit: 1
        ljmp    0x001d
        movlb   0x01
        btfss   TMR2IE                                ; reg: 0x091, bit: 1
        ljmp    0x001d
        ;movlp   0x23
        fcall    function_088
        retfie
        movlb   0x00
        btfss   ADIF                                  ; reg: 0x011, bit: 6
        ljmp    0x0026
        movlb   0x01
        btfss   ADIE                                  ; reg: 0x091, bit: 6
        ljmp    0x0026
        ;movlp   0x08
        fcall    function_019
        retfie
        movlb   0x00
        btfss   RCIF                                  ; reg: 0x011, bit: 5
        ljmp    0x002f
        movlb   0x01
        btfss   RCIE                                  ; reg: 0x091, bit: 5
        ljmp    0x002f
        ;movlp   0x10
        fcall    function_045
        retfie
        movlb   0x00
        btfss   TXIF                                  ; reg: 0x011, bit: 4
        retfie
        movlb   0x01
        btfss   TXIE                                  ; reg: 0x091, bit: 4
        retfie
        ;movlp   0x10
        fcall    function_044
        retfie

label_004:                                                  ; address: 0x0038

        clrf    BSR                                         ; reg: 0x008
        ;movlp   0x08
        ljmp    label_209

function_000:                                               ; address: 0x003b

        movlb   0x02
        movf    0x6e, W                                     ; reg: 0x16e
        movlb   0x03
        movwf   0x50                                        ; reg: 0x1d0
        movlb   0x02
        movf    0x6d, W                                     ; reg: 0x16d
        movlb   0x03
        movwf   0x4f                                        ; reg: 0x1cf
        movlb   0x00
        bcf     0x3e, 0x1                                   ; reg: 0x03e
        fcall    function_040
        ;movlp   0x00
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        bsf     RB1                                  ; reg: 0x00d, bit: 1
        movf    (Common_RAM + 9), W                         ; reg: 0x079
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfsc   (Common_RAM + 9), 0x6                       ; reg: 0x079
        ljmp    label_005
        movf    0x4f, F                                     ; reg: 0x04f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_005
        movlw   0x0a
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        movlw   0x1e
        movwf   0x57                                        ; reg: 0x057
        movlb   0x01
        clrf    0x42                                        ; reg: 0x0c2
        ljmp    label_006

label_005:                                                  ; address: 0x005a

        movlb   0x02
        movf    0x6e, W                                     ; reg: 0x16e
        iorwf   0x6d, W                                     ; reg: 0x16d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_006
        movlb   0x00
        clrf    0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        bcf     RB1                                  ; reg: 0x00d, bit: 1
        movlb   0x01
        clrf    0x42                                        ; reg: 0x0c2
        incf    0x42, F                                     ; reg: 0x0c2
        movlb   0x00
        bcf     0x41, 0x4                                   ; reg: 0x041

label_006:                                                  ; address: 0x0068

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_007
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_007
        btfss   0x3a, 0x4                                   ; reg: 0x03a
        ljmp    label_008
        movlb   0x02
        movf    0x6e, W                                     ; reg: 0x16e
        iorwf   0x6d, W                                     ; reg: 0x16d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_008
        movlw   0x01
        subwf   0x6d, F                                     ; reg: 0x06d
        movlw   0x00
        subwfb  0x6e, F                                     ; reg: 0x06e
        ljmp    label_008

label_007:                                                  ; address: 0x007c

        lslf    0x21, W                                     ; reg: 0x021
        addlw   0x35
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa9
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movlb   0x02
        movwf   0x6d                                        ; reg: 0x16d
        moviw   1[FSR0]
        movwf   0x6e                                        ; reg: 0x16e

label_008:                                                  ; address: 0x0088

        movlb   0x00
        btfss   0x3b, 0x6                                   ; reg: 0x03b
        ljmp    label_010
        bcf     0x3b, 0x6                                   ; reg: 0x03b
        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_009
        movlw   0x32
        movlb   0x01
        movwf   0x5d                                        ; reg: 0x0dd
        movlw   0x10
        movlb   0x00
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        incf    0x4d, F                                     ; reg: 0x04d

label_009:                                                  ; address: 0x0097

        movlb   0x02
        clrf    0x51                                        ; reg: 0x151
        incf    0x51, F                                     ; reg: 0x151

label_010:                                                  ; address: 0x009a

        movlb   0x00
        movf    0x5b, W                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_015
        movf    0x50, W                                     ; reg: 0x050
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_011
        movf    0x50, W                                     ; reg: 0x050
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_014

label_011:                                                  ; address: 0x00a6

        btfss   0x3a, 0x4                                   ; reg: 0x03a
        ljmp    label_014
        decf    0x5b, F                                     ; reg: 0x05b
        ljmp    label_014

label_012:                                                  ; address: 0x00aa

        ;movlp   0x26
        fcall    function_096
        ;movlp   0x00
        ljmp    label_132

label_013:                                                  ; address: 0x00ae

        fcall    function_009
        ;movlp   0x00
        ljmp    label_132

label_014:                                                  ; address: 0x00b1

        movf    0x50, W                                     ; reg: 0x050
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_013
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_012
        ljmp    label_132

label_015:                                                  ; address: 0x00bc

        ;movlp   0x10
        fcall    function_046
        ;movlp   0x00
        movlb   0x03
        movf    0x6d, W                                     ; reg: 0x1ed
        iorwf   0x6c, W                                     ; reg: 0x1ec
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_016
        movlb   0x00
        btfss   0x3a, 0x4                                   ; reg: 0x03a
        ljmp    label_131
        movlw   0x01
        movlb   0x03
        subwf   0x6c, F                                     ; reg: 0x1ec
        movlw   0x00
        subwfb  0x6d, F                                     ; reg: 0x1ed
        ljmp    label_131

label_016:                                                  ; address: 0x00cd

        movlb   0x01
        movf    0x6f, W                                     ; reg: 0x0ef
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_131
        clrf    0x6f                                        ; reg: 0x06f
        incf    0x6f, F                                     ; reg: 0x06f
        ljmp    label_131

label_017:                                                  ; address: 0x00d5

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movf    0x6f, W                                     ; reg: 0x0ef
        movlb   0x00
        movwf   0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f
        movlw   0x05

label_018:                                                  ; address: 0x00dc

        lslf    0x2e, F                                     ; reg: 0x02e
        rlf     0x2f, F                                     ; reg: 0x02f
        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_018
        movlw   0x57
        addwf   0x2e, F                                     ; reg: 0x02e
        movlw   0x02
        addwfc  0x2f, F                                     ; reg: 0x02f
        movf    0x23, F                                     ; reg: 0x023
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_019
        lslf    0x23, W                                     ; reg: 0x023
        fcall    function_013
        ;movlp   0x00
        subwf   0x2e, F                                     ; reg: 0x02e
        movf    0x6b, W                                     ; reg: 0x06b
        subwfb  0x2f, F                                     ; reg: 0x02f

label_019:                                                  ; address: 0x00ed

        movf    0x23, W                                     ; reg: 0x023
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_049
        lslf    0x23, W                                     ; reg: 0x023
        fcall    function_013
        ;movlp   0x00
        addwf   0x2e, F                                     ; reg: 0x02e
        movf    0x6b, W                                     ; reg: 0x06b
        addwfc  0x2f, F                                     ; reg: 0x02f
        ljmp    label_049

label_020:                                                  ; address: 0x00f8

        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0xe1
        movwf   0x6a                                        ; reg: 0x06a
        movlw   0xff
        addwfc  0x2f, W                                     ; reg: 0x02f
        movwf   0x6b                                        ; reg: 0x06b
        movf    0x2b, W                                     ; reg: 0x02b
        subwf   0x6b, W                                     ; reg: 0x06b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_021
        movf    0x2a, W                                     ; reg: 0x02a
        subwf   0x6a, W                                     ; reg: 0x06a

label_021:                                                  ; address: 0x0104

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_027
        movlb   0x01
        movf    0x55, F                                     ; reg: 0x0d5
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_027
        movlw   0x00
        movlb   0x02
        subwf   0x44, W                                     ; reg: 0x144
        movlw   0x33
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x43, W                                     ; reg: 0x143
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_025
        movlb   0x00
        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0x08
        movwf   0x6a                                        ; reg: 0x06a
        movlw   0x00
        addwfc  0x2f, W                                     ; reg: 0x02f
        movwf   0x6b                                        ; reg: 0x06b
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_022
        movf    0x6a, W                                     ; reg: 0x06a
        subwf   0x2a, W                                     ; reg: 0x02a

label_022:                                                  ; address: 0x011e

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_025
        btfss   0x3f, 0x2                                   ; reg: 0x03f
        ljmp    label_026
        movlw   0x63
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x03
        movwf   0x2f                                        ; reg: 0x02f
        movlb   0x01
        clrf    0x4a                                        ; reg: 0x0ca
        incf    0x4a, F                                     ; reg: 0x0ca
        movlw   0x0a
        movlb   0x03
        movwf   0x45                                        ; reg: 0x1c5
        clrf    0x46                                        ; reg: 0x1c6
        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x03
        ljmp    label_024

label_023:                                                  ; address: 0x0131

        lslf    0x45, F                                     ; reg: 0x045
        rlf     0x46, F                                     ; reg: 0x046

label_024:                                                  ; address: 0x0133

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_023
        ljmp    label_026

label_025:                                                  ; address: 0x0136

        movlb   0x00
        clrf    0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f

label_026:                                                  ; address: 0x0139

        movlb   0x02
        movf    0x44, W                                     ; reg: 0x144
        iorwf   0x43, W                                     ; reg: 0x143
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        movlw   0xa0
        movwf   0x43                                        ; reg: 0x043
        movlw   0x0f
        movwf   0x44                                        ; reg: 0x044
        movlb   0x00
        clrf    0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f
        ljmp    label_132

label_027:                                                  ; address: 0x0146

        movlb   0x00
        bsf     0x3f, 0x2                                   ; reg: 0x03f
        movlw   0xc4
        movlb   0x02
        movwf   0x43                                        ; reg: 0x143
        movlw   0x09
        movwf   0x44                                        ; reg: 0x144
        ljmp    label_132

label_028:                                                  ; address: 0x014e

        bsf     0x3e, 0x3                                   ; reg: 0x03e
        clrf    0x34                                        ; reg: 0x034
        clrf    0x35                                        ; reg: 0x035
        movlw   0x78
        movlb   0x01
        movwf   0x59                                        ; reg: 0x0d9
        ljmp    label_132

label_029:                                                  ; address: 0x0155

        movlw   0x14
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        clrf    0x3a                                        ; reg: 0x0ba
        movlb   0x00
        bsf     0x3e, 0x2                                   ; reg: 0x03e
        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7

label_030:                                                  ; address: 0x015d

        movlw   0x1e
        ljmp    label_088

label_031:                                                  ; address: 0x015f

        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        bsf     0x3e, 0x3                                   ; reg: 0x03e
        movlw   0x58
        movlb   0x03
        movwf   0x6c                                        ; reg: 0x1ec
        movlw   0x02
        movwf   0x6d                                        ; reg: 0x1ed
        ljmp    label_132

label_032:                                                  ; address: 0x0169

        bcf     0x3e, 0x6                                   ; reg: 0x03e
        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        movf    0x37, F                                     ; reg: 0x037
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_037
        movlw   0x02
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0xbd
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfss   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_033
        bcf     0x3c, 0x7                                   ; reg: 0x03c
        movf    0x31, W                                     ; reg: 0x031
        movlb   0x02
        movwf   0x22                                        ; reg: 0x122
        movlb   0x00
        movf    0x30, W                                     ; reg: 0x030
        movlb   0x02
        movwf   0x21                                        ; reg: 0x121
        ;movlp   0x14
        fcall    function_049
        ;movlp   0x00
        movlw   0x05
        fcall    function_001
        ;movlp   0x00
        ljmp    label_030

label_033:                                                  ; address: 0x0187

        btfss   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_035

label_034:                                                  ; address: 0x0189

        movlw   0xff
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movwf   0x3a                                        ; reg: 0x0ba
        ljmp    label_030

label_035:                                                  ; address: 0x018e

        btfsc   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_030
        movlb   0x02
        movf    0x22, W                                     ; reg: 0x122
        movlb   0x01
        movwf   0x3a                                        ; reg: 0x0ba
        movlb   0x02
        movf    0x21, W                                     ; reg: 0x121

label_036:                                                  ; address: 0x0196

        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movlb   0x00
        bsf     0x3e, 0x2                                   ; reg: 0x03e
        ljmp    label_030

label_037:                                                  ; address: 0x019b

        decfsz  0x37, W                                     ; reg: 0x037
        ljmp    label_030
        movlw   0x02
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0xbd
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfss   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_038
        bcf     0x3c, 0x7                                   ; reg: 0x03c
        movlw   0xbc
        movlb   0x02
        movwf   0x23                                        ; reg: 0x123
        movlw   0x02
        movwf   0x24                                        ; reg: 0x124
        ;movlp   0x14
        fcall    function_049
        ;movlp   0x00
        movlw   0x06
        fcall    function_001
        ;movlp   0x00
        ljmp    label_030

label_038:                                                  ; address: 0x01b2

        btfsc   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_034
        btfsc   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_030
        movlb   0x02
        movf    0x24, W                                     ; reg: 0x124
        movlb   0x01
        movwf   0x3a                                        ; reg: 0x0ba
        movlb   0x02
        movf    0x23, W                                     ; reg: 0x123
        ljmp    label_036

label_039:                                                  ; address: 0x01bd

        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfsc   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_040
        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_132

label_040:                                                  ; address: 0x01c4

        movlw   0x06
        movwf   0x4d                                        ; reg: 0x04d
        movlw   0x1e
        ljmp    label_091

label_041:                                                  ; address: 0x01c8

        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_043

label_042:                                                  ; address: 0x01cc

        bsf     0x3e, 0x3                                   ; reg: 0x03e
        ljmp    label_132

label_043:                                                  ; address: 0x01ce

        movf    0x37, F                                     ; reg: 0x037
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_044
        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_045

label_044:                                                  ; address: 0x01d3

        decfsz  0x37, W                                     ; reg: 0x037
        ljmp    label_046
        btfss   (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_046

label_045:                                                  ; address: 0x01d7

        movlw   0xff
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movwf   0x3a                                        ; reg: 0x0ba

label_046:                                                  ; address: 0x01db

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        ljmp    label_132

label_047:                                                  ; address: 0x01de

        movf    0x58, F                                     ; reg: 0x058
        ljmp    label_095

label_048:                                                  ; address: 0x01e0

        movlw   0x3c
        movlb   0x01
        movwf   0x55                                        ; reg: 0x0d5
        clrf    0x59                                        ; reg: 0x0d9
        movlb   0x00
        clrf    0x4d                                        ; reg: 0x04d
        bsf     0x3f, 0x5                                   ; reg: 0x03f
        bsf     0x3b, 0x4                                   ; reg: 0x03b
        movlb   0x01
        movf    0x6f, W                                     ; reg: 0x0ef
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x6f, F                                     ; reg: 0x0ef
        movlw   0x01
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x77
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_132
        clrf    0x4f                                        ; reg: 0x04f
        incf    0x4f, F                                     ; reg: 0x04f
        ljmp    label_132

label_049:                                                  ; address: 0x01f7

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_020
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_028
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_029
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_031
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_032
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_039
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_041
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_047
        xorlw   0x0f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_042
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_048
        ljmp    label_132

label_050:                                                  ; address: 0x0217

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_051
        movlw   0x40
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x02
        movwf   0x2f                                        ; reg: 0x02f

label_051:                                                  ; address: 0x0220

        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_052
        movlw   0x01
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xca
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_132
        ljmp    label_068

label_052:                                                  ; address: 0x022b

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_054
        movlw   0x98
        fcall    function_017
        ;movlp   0x00

label_053:                                                  ; address: 0x0230

        movlb   0x00
        bsf     0x3e, 0x2                                   ; reg: 0x03e
        ljmp    label_132

label_054:                                                  ; address: 0x0233

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_055
        movlw   0x03
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        bsf     0x3d, 0x3                                   ; reg: 0x03d
        ljmp    label_132

label_055:                                                  ; address: 0x023c

        clrf    0x4f                                        ; reg: 0x04f
        incf    0x4f, F                                     ; reg: 0x04f

label_056:                                                  ; address: 0x023e

        movlb   0x00
        clrf    0x4d                                        ; reg: 0x04d
        ljmp    label_132

label_057:                                                  ; address: 0x0241

        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_058
        movlw   0x32
        movwf   0x34                                        ; reg: 0x034
        clrf    0x35                                        ; reg: 0x035
        ljmp    label_042

label_058:                                                  ; address: 0x0248

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_061
        btfss   (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_060
        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132

label_059:                                                  ; address: 0x0250

        movlw   0x02
        ljmp    label_062

label_060:                                                  ; address: 0x0252

        movlw   0x0c
        movwf   0x4f                                        ; reg: 0x04f
        ljmp    label_071

label_061:                                                  ; address: 0x0255

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_063
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_132
        movlw   0x03

label_062:                                                  ; address: 0x025c

        movwf   0x4d                                        ; reg: 0x04d
        ljmp    label_132

label_063:                                                  ; address: 0x025e

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_064
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_059
        ljmp    label_132

label_064:                                                  ; address: 0x0265

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        ljmp    label_132

label_065:                                                  ; address: 0x0268

        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_066
        movlb   0x02
        clrf    0x50                                        ; reg: 0x150
        movlb   0x00
        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        movlw   0x03
        movwf   0x4f                                        ; reg: 0x04f
        ljmp    label_132

label_066:                                                  ; address: 0x0275

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_067
        movlw   0x2c
        movwf   0x34                                        ; reg: 0x034
        movlw   0x01
        movwf   0x35                                        ; reg: 0x035
        bcf     0x41, 0x4                                   ; reg: 0x041
        movlb   0x01
        fcall    function_012
        ;movlp   0x00
        movlw   0x02
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xab
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_042
        ljmp    label_132

label_067:                                                  ; address: 0x0287

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_069
        movlb   0x01
        fcall    function_012
        ;movlp   0x00
        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_068
        movlw   0x03
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        bsf     0x41, 0x4                                   ; reg: 0x041

label_068:                                                  ; address: 0x0296

        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_042
        ljmp    label_132

label_069:                                                  ; address: 0x0299

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_072
        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlw   0x63
        movlb   0x00
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x03
        movwf   0x2f                                        ; reg: 0x02f
        bsf     0x3e, 0x2                                   ; reg: 0x03e
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_070
        movlw   0x36
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movlw   0x01
        movwf   0x3a                                        ; reg: 0x0ba
        movlb   0x00
        bsf     0x41, 0x4                                   ; reg: 0x041
        ljmp    label_053

label_070:                                                  ; address: 0x02af

        btfss   0x38, 0x6                                   ; reg: 0x038
        ljmp    label_132
        bcf     0x41, 0x4                                   ; reg: 0x041

label_071:                                                  ; address: 0x02b2

        clrf    0x4d                                        ; reg: 0x04d
        ljmp    label_100

label_072:                                                  ; address: 0x02b4

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_073
        btfsc   0x38, 0x6                                   ; reg: 0x038
        ljmp    label_071
        ljmp    label_132

label_073:                                                  ; address: 0x02bb

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x05
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        bsf     0x3d, 0x1                                   ; reg: 0x03d

label_074:                                                  ; address: 0x02c0

        movlw   0x03
        ljmp    label_127

label_075:                                                  ; address: 0x02c2

        movlw   0x0a
        subwf   0x57, W                                     ; reg: 0x057
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_076
        movf    0x57, W                                     ; reg: 0x057
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_076
        clrf    0x4f                                        ; reg: 0x04f
        incf    0x4f, F                                     ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d

label_076:                                                  ; address: 0x02cc

        btfss   0x3f, 0x0                                   ; reg: 0x03f
        ljmp    label_081
        bcf     0x3f, 0x0                                   ; reg: 0x03f
        movlw   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xe1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_077
        bcf     0x3f, 0x3                                   ; reg: 0x03f
        ljmp    label_078

label_077:                                                  ; address: 0x02d8

        bsf     0x3f, 0x3                                   ; reg: 0x03f

label_078:                                                  ; address: 0x02d9

        movlw   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x8a
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_079
        movlw   0x4c
        ljmp    label_080

label_079:                                                  ; address: 0x02e2

        movlw   0x90

label_080:                                                  ; address: 0x02e3

        movlb   0x02
        movwf   0x4f                                        ; reg: 0x14f

label_081:                                                  ; address: 0x02e5

        movlw   0x4f
        movlb   0x00
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x02
        movwf   0x2f                                        ; reg: 0x02f
        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        ljmp    label_086

label_082:                                                  ; address: 0x02ed

        movf    0x2f, W                                     ; reg: 0x02f
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_083
        movf    0x2e, W                                     ; reg: 0x02e
        subwf   0x2a, W                                     ; reg: 0x02a

label_083:                                                  ; address: 0x02f3

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfsc   0x3b, 0x1                                   ; reg: 0x03b
        bsf     0x3e, 0x3                                   ; reg: 0x03e
        movlb   0x01
        clrf    0x6f                                        ; reg: 0x0ef
        movlw   0x00
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xe1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_084
        movlw   0x02
        movlb   0x01
        movwf   0x6f                                        ; reg: 0x0ef
        ljmp    label_132

label_084:                                                  ; address: 0x0304

        movlw   0x01
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xc9
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_132
        movlb   0x01
        clrf    0x6f                                        ; reg: 0x0ef
        incf    0x6f, F                                     ; reg: 0x0ef
        ljmp    label_132

label_085:                                                  ; address: 0x030f

        movf    0x57, F                                     ; reg: 0x057
        ljmp    label_103

label_086:                                                  ; address: 0x0311

        movlb   0x00
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_082
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_085
        ljmp    label_132

label_087:                                                  ; address: 0x031a

        fcall    function_014
        ;movlp   0x00
        movlw   0x5a

label_088:                                                  ; address: 0x031d

        movlb   0x00
        ljmp    label_091

label_089:                                                  ; address: 0x031f

        fcall    function_014
        ;movlp   0x00
        movlb   0x00
        ljmp    label_094

label_090:                                                  ; address: 0x0323

        movlw   0xc8
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x02
        movwf   0x2f                                        ; reg: 0x02f
        bsf     0x3e, 0x1                                   ; reg: 0x03e
        movlw   0xfa

label_091:                                                  ; address: 0x0329

        movwf   0x34                                        ; reg: 0x034
        clrf    0x35                                        ; reg: 0x035
        ljmp    label_132

label_092:                                                  ; address: 0x032c

        movlw   0x00
        subwf   0x35, W                                     ; reg: 0x035
        movlw   0x96
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x34, W                                     ; reg: 0x034
        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_095
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_094

label_093:                                                  ; address: 0x0337

        movlw   0xff
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movwf   0x3a                                        ; reg: 0x0ba
        ljmp    label_132

label_094:                                                  ; address: 0x033c

        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034

label_095:                                                  ; address: 0x033e

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_042
        ljmp    label_132

label_096:                                                  ; address: 0x0341

        btfsc   0x22, 0x0                                   ; reg: 0x022
        ljmp    label_097
        bsf     0x22, 0x0                                   ; reg: 0x022
        bsf     0x51, 0x4                                   ; reg: 0x051

label_097:                                                  ; address: 0x0345

        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        clrf    0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        clrf    0x34                                        ; reg: 0x034
        clrf    0x35                                        ; reg: 0x035
        bcf     RB1                                  ; reg: 0x00d, bit: 1
        ljmp    label_132

label_098:                                                  ; address: 0x034f

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_087
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_089
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_042
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_090
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_092
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_096
        ljmp    label_132

label_099:                                                  ; address: 0x0363

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        ljmp    label_105

label_100:                                                  ; address: 0x036b

        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_132

label_101:                                                  ; address: 0x036d

        movlw   0x13
        fcall    function_001
        ;movlp   0x0f
        fcall    function_037
        ;movlp   0x00
        ;movlp   0x14
        fcall    function_048
        ;movlp   0x00
        movlb   0x00
        bsf     0x51, 0x4                                   ; reg: 0x051
        fcall    function_005
        ;movlp   0x19
        fcall    function_066
        ;movlp   0x00
        movlb   0x00
        bsf     0x51, 0x3                                   ; reg: 0x051
        ljmp    label_100

label_102:                                                  ; address: 0x037e

        movf    0x58, F                                     ; reg: 0x058

label_103:                                                  ; address: 0x037f

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_074
        ljmp    label_132

label_104:                                                  ; address: 0x0382

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_100
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_101

label_105:                                                  ; address: 0x0389

        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_102
        ljmp    label_132

label_106:                                                  ; address: 0x038d

        btfsc   0x36, 0x5                                   ; reg: 0x036
        ljmp    label_123
        movlw   0x77
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x01
        movwf   0x2f                                        ; reg: 0x02f
        ljmp    label_123

label_107:                                                  ; address: 0x0394

        nop
        ljmp    label_132

label_108:                                                  ; address: 0x0396

        btfss   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_042
        ljmp    label_132

label_109:                                                  ; address: 0x0399

        clrf    0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f
        movlw   0x0a
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        clrf    0x3a                                        ; reg: 0x0ba
        ljmp    label_053

label_110:                                                  ; address: 0x03a0

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_042
        movlw   0x82

label_111:                                                  ; address: 0x03a6

        fcall    function_016
        ;movlp   0x00
        ljmp    label_053

label_112:                                                  ; address: 0x03a9

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        btfss   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_113
        movlw   0x7e
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movlw   0x04
        movwf   0x3a                                        ; reg: 0x0ba
        ljmp    label_119

label_113:                                                  ; address: 0x03b4

        movlw   0xc8
        ljmp    label_111

label_114:                                                  ; address: 0x03b6

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_042

label_115:                                                  ; address: 0x03bb

        movlw   0x32
        fcall    function_016
        ;movlp   0x00
        incf    0x58, F                                     ; reg: 0x058
        ljmp    label_053

label_116:                                                  ; address: 0x03c0

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        btfss   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_115
        movlw   0xfa
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        clrf    0x3a                                        ; reg: 0x0ba
        ljmp    label_118

label_117:                                                  ; address: 0x03ca

        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x00
        btfss   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_115
        movlw   0xb6
        fcall    function_017
        ;movlp   0x00

label_118:                                                  ; address: 0x03d2

        movlw   0x04

label_119:                                                  ; address: 0x03d3

        movlb   0x02
        movwf   0x58                                        ; reg: 0x158
        ljmp    label_053

label_120:                                                  ; address: 0x03d6

        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_042
        clrf    0x4d                                        ; reg: 0x04d
        bsf     0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_132

label_121:                                                  ; address: 0x03db

        btfsc   0x22, 0x0                                   ; reg: 0x022
        ljmp    label_122
        bsf     0x22, 0x0                                   ; reg: 0x022
        bsf     0x51, 0x4                                   ; reg: 0x051

label_122:                                                  ; address: 0x03df

        bcf     0x43, 0x7                                   ; reg: 0x043
        bcf     0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_055

label_123:                                                  ; address: 0x03e2

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_107
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_108
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_109
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_110
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_112
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_114
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_116
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_117
        xorlw   0x0f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_114
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_114
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_114
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_120
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_121
        ljmp    label_132

label_124:                                                  ; address: 0x040b

        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_125
        clrf    0x4d                                        ; reg: 0x04d
        incf    0x4d, F                                     ; reg: 0x04d

label_125:                                                  ; address: 0x040f

        movlb   0x01
        movf    0x5d, F                                     ; reg: 0x0dd
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_093
        btfss   (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_126
        clrf    0x47                                        ; reg: 0x047
        movlw   0x66
        movlb   0x00
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x02
        movwf   0x2f                                        ; reg: 0x02f
        ljmp    label_132

label_126:                                                  ; address: 0x041e

        btfss   (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_132
        movlw   0x05
        movlb   0x00

label_127:                                                  ; address: 0x0422

        movwf   0x4f                                        ; reg: 0x04f
        ljmp    label_056

label_128:                                                  ; address: 0x0424

        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        btfss   (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_129
        movlw   0xff
        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movwf   0x3a                                        ; reg: 0x0ba

label_129:                                                  ; address: 0x042b

        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_056
        ljmp    label_132

label_130:                                                  ; address: 0x042e

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_124
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_128
        ljmp    label_132

label_131:                                                  ; address: 0x0436

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_132
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_075
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_106
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_017
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_098
        xorlw   0x0d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_099
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_099
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_075
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_050
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_065
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_099
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_057
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_104
        xorlw   0x1f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_130

label_132:                                                  ; address: 0x0462

        movlb   0x00
        btfss   0x36, 0x1                                   ; reg: 0x036
        ljmp    label_133
        bcf     0x3e, 0x1                                   ; reg: 0x03e
        fcall    function_015
        ;movlp   0x00

label_133:                                                  ; address: 0x0468

        movlb   0x00
        clrf    0x43                                        ; reg: 0x043
        fcall    function_007
        ;movlp   0x1c
        fcall    function_075
        ;movlp   0x00
        fcall    function_002
        ;movlp   0x00
        fcall    function_003
        ;movlp   0x00
        fcall    function_004
        ;movlp   0x00
        fcall    function_006
        ;movlp   0x00
        fcall    function_008
        ;movlp   0x00
        movlb   0x00
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_134
        movlb   0x01
        movf    0x63, W                                     ; reg: 0x0e3
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_134
        decfsz  0x63, F                                     ; reg: 0x063
        ljmp    label_134
        movlb   0x00
        bsf     0x51, 0x5                                   ; reg: 0x051

label_134:                                                  ; address: 0x0483

        movlb   0x00
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        return
        movlb   0x01
        movf    0x58, W                                     ; reg: 0x0d8
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decfsz  0x58, F                                     ; reg: 0x0d8
        return
        movlb   0x00
        bsf     0x51, 0x3                                   ; reg: 0x051
        return

function_001:                                               ; address: 0x048e

        movwf   (Common_RAM + 4)                            ; reg: 0x074
        ljmp    label_149

label_135:                                                  ; address: 0x0490

        movlb   0x01
        fcall    function_011
        movlw   0x13
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_136:                                                  ; address: 0x0496

        movlb   0x01
        fcall    function_011
        movlw   0x09
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_137:                                                  ; address: 0x049c

        movlb   0x01
        clrf    0x48                                        ; reg: 0x0c8
        incf    0x48, F                                     ; reg: 0x0c8
        movlw   0x0c
        movlb   0x00
        movwf   0x58                                        ; reg: 0x058
        movlw   0x07
        movlb   0x01
        movwf   0x3d                                        ; reg: 0x0bd
        clrf    0x3e                                        ; reg: 0x0be
        movlw   0x06
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_138:                                                  ; address: 0x04aa

        movlb   0x01
        clrf    0x48                                        ; reg: 0x0c8
        incf    0x48, F                                     ; reg: 0x0c8
        movlw   0x04
        movlb   0x00
        movwf   0x58                                        ; reg: 0x058
        movlw   0x2c
        movlb   0x01
        movwf   0x3d                                        ; reg: 0x0bd
        movlw   0x01
        movwf   0x3e                                        ; reg: 0x0be
        movf    0x74, W                                     ; reg: 0x0f4
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_140

label_139:                                                  ; address: 0x04b9

        movlw   0x03
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_140:                                                  ; address: 0x04bd

        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_142

label_141:                                                  ; address: 0x04c1

        movlw   0x04
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_142:                                                  ; address: 0x04c5

        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x05
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_144

label_143:                                                  ; address: 0x04c9

        movlb   0x02
        clrf    0x4e                                        ; reg: 0x14e
        return

label_144:                                                  ; address: 0x04cc

        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x06
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return

label_145:                                                  ; address: 0x04d0

        movlb   0x02
        clrf    0x4e                                        ; reg: 0x14e
        incf    0x4e, F                                     ; reg: 0x14e
        return

label_146:                                                  ; address: 0x04d4

        fcall    function_010
        ;movlp   0x00
        xorlw   0x08
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_139
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x09
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_141
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x0a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlw   0x05
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_147:                                                  ; address: 0x04e5

        fcall    function_010
        ;movlp   0x00
        xorlw   0x0d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_145
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x0e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_143
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlw   0x08
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_148:                                                  ; address: 0x04f6

        fcall    function_010
        ;movlp   0x00
        xorlw   0x10
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_143
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x11
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_145
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x12
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlw   0x0a
        movlb   0x02
        movwf   0x4e                                        ; reg: 0x14e
        return

label_149:                                                  ; address: 0x0507

        movf    (Common_RAM + 4), W                         ; reg: 0x074
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_135
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_137
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_138
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_138
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_138
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_138
        xorlw   0x0e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_146
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_146
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_146
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_136
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_136
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_147
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_147
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_147
        xorlw   0x1f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_148
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_148
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_148
        xorlw   0x01
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_137

function_002:                                               ; address: 0x053f

        movf    0x3a, W                                     ; reg: 0x03a
        iorwf   0x39, W                                     ; reg: 0x039
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_162
        movlb   0x00
        decfsz  0x4c, W                                     ; reg: 0x04c
        ljmp    label_150
        movlw   0x05
        movwf   0x4c                                        ; reg: 0x04c
        ljmp    label_162

label_150:                                                  ; address: 0x0549

        movf    0x4c, W                                     ; reg: 0x04c
        xorlw   0x05
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_162
        clrf    0x4c                                        ; reg: 0x04c
        ljmp    label_162

label_151:                                                  ; address: 0x054f

        movlb   0x01
        movf    0x3a, W                                     ; reg: 0x0ba
        iorwf   0x39, W                                     ; reg: 0x0b9
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_163
        movlb   0x00
        btfss   0x36, 0x2                                   ; reg: 0x036
        ljmp    label_152
        movf    0x5b, W                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_163

label_152:                                                  ; address: 0x055a

        clrf    0x30                                        ; reg: 0x030
        clrf    0x31                                        ; reg: 0x031
        clrf    0x4c                                        ; reg: 0x04c
        incf    0x4c, F                                     ; reg: 0x04c
        ljmp    label_163

label_153:                                                  ; address: 0x055f

        btfss   0x36, 0x2                                   ; reg: 0x036
        ljmp    label_155
        movf    0x5b, F                                     ; reg: 0x05b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_155

label_154:                                                  ; address: 0x0564

        movlw   0x05
        ljmp    label_161

label_155:                                                  ; address: 0x0566

        movlb   0x01
        incf    0x39, W                                     ; reg: 0x0b9
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x3a, W                                     ; reg: 0x0ba
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_156
        movlb   0x00
        bsf     0x43, 0x2                                   ; reg: 0x043
        ljmp    label_163

label_156:                                                  ; address: 0x056f

        movlb   0x00
        bsf     0x43, 0x2                                   ; reg: 0x043
        movlb   0x01
        movf    0x3a, W                                     ; reg: 0x0ba
        movlb   0x00
        subwf   0x31, W                                     ; reg: 0x031
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_157
        movlb   0x01
        movf    0x39, W                                     ; reg: 0x0b9
        movlb   0x00
        subwf   0x30, W                                     ; reg: 0x030

label_157:                                                  ; address: 0x057b

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_154
        ljmp    label_163

label_158:                                                  ; address: 0x057e

        movlb   0x01
        movf    0x3a, W                                     ; reg: 0x0ba
        iorwf   0x39, W                                     ; reg: 0x0b9
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_160

label_159:                                                  ; address: 0x0583

        movlb   0x00
        clrf    0x4c                                        ; reg: 0x04c
        ljmp    label_163

label_160:                                                  ; address: 0x0586

        movlw   0x03
        movlb   0x00

label_161:                                                  ; address: 0x0588

        movwf   0x4c                                        ; reg: 0x04c
        ljmp    label_163

label_162:                                                  ; address: 0x058a

        movlb   0x00
        movf    0x4c, W                                     ; reg: 0x04c
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_151
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_153
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_159
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_158

label_163:                                                  ; address: 0x0598

        movlb   0x00
        btfsc   0x3c, 0x2                                   ; reg: 0x03c
        return
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        clrf    0x59                                        ; reg: 0x059
        movlw   0xbc
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        movlw   0x02
        movwf   0x42                                        ; reg: 0x142
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        btfsc   0x3e, 0x6                                   ; reg: 0x03e
        ljmp    label_164
        movlw   0x28
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        clrf    0x42                                        ; reg: 0x142
        return

label_164:                                                  ; address: 0x05b1

        movlw   0xf4
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        movlw   0x01
        movwf   0x42                                        ; reg: 0x142
        return

function_003:                                               ; address: 0x05b7

        movlb   0x00
        btfss   0x3e, 0x1                                   ; reg: 0x03e
        ljmp    label_170
        movlb   0x01
        movf    0x4a, W                                     ; reg: 0x0ca
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_165
        movf    0x4a, W                                     ; reg: 0x04a
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return

label_165:                                                  ; address: 0x05c3

        movlb   0x00
        ljmp    label_167

label_166:                                                  ; address: 0x05c5

        movf    0x4c, W                                     ; reg: 0x04c
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_167
        movf    0x4c, W                                     ; reg: 0x04c
        xorlw   0x04
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return

label_167:                                                  ; address: 0x05cd

        movf    0x5b, W                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_169

label_168:                                                  ; address: 0x05d0

        movlb   0x01
        incf    0x49, F                                     ; reg: 0x0c9
        return

label_169:                                                  ; address: 0x05d3

        incf    0x4d, F                                     ; reg: 0x04d
        return

label_170:                                                  ; address: 0x05d5

        btfsc   0x3e, 0x2                                   ; reg: 0x03e
        ljmp    label_166
        btfss   0x3e, 0x3                                   ; reg: 0x03e
        return
        movf    0x5b, W                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_171
        movlb   0x01
        movf    0x49, W                                     ; reg: 0x0c9
        xorlw   0xff
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_168

label_171:                                                  ; address: 0x05e2

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0xff
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_169

function_004:                                               ; address: 0x05e7

        movlb   0x00
        btfss   0x3b, 0x4                                   ; reg: 0x03b
        ljmp    label_172
        bcf     0x3b, 0x4                                   ; reg: 0x03b
        movlw   0x05
        movlb   0x01
        movwf   0x63                                        ; reg: 0x0e3
        incf    0x28, W                                     ; reg: 0x0a8
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x29, W                                     ; reg: 0x0a9
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_172
        incf    0x28, F                                     ; reg: 0x028
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x29, F                                     ; reg: 0x029

label_172:                                                  ; address: 0x05f6

        movlb   0x00
        btfss   0x3d, 0x3                                   ; reg: 0x03d
        ljmp    label_173
        bcf     0x3d, 0x3                                   ; reg: 0x03d
        movlw   0x05
        movlb   0x01
        movwf   0x63                                        ; reg: 0x0e3
        incf    0x33, W                                     ; reg: 0x0b3
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x34, W                                     ; reg: 0x0b4
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_173
        incf    0x33, F                                     ; reg: 0x033
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x34, F                                     ; reg: 0x034

label_173:                                                  ; address: 0x0605

        movlb   0x00
        btfss   0x3d, 0x1                                   ; reg: 0x03d
        ljmp    label_174
        bcf     0x3d, 0x1                                   ; reg: 0x03d
        movlw   0x05
        movlb   0x01
        movwf   0x63                                        ; reg: 0x0e3
        incf    0x35, W                                     ; reg: 0x0b5
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x36, W                                     ; reg: 0x0b6
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_174
        incf    0x35, F                                     ; reg: 0x035
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x36, F                                     ; reg: 0x036

label_174:                                                  ; address: 0x0614

        movlb   0x00
        btfss   0x3c, 0x6                                   ; reg: 0x03c
        ljmp    label_175
        movlb   0x01
        clrf    0x20                                        ; reg: 0x0a0
        clrf    0x21                                        ; reg: 0x0a1
        clrf    0x22                                        ; reg: 0x0a2
        clrf    0x23                                        ; reg: 0x0a3
        clrf    0x24                                        ; reg: 0x0a4
        clrf    0x25                                        ; reg: 0x0a5
        clrf    0x26                                        ; reg: 0x0a6
        clrf    0x27                                        ; reg: 0x0a7
        movlw   0x05
        movwf   0x63                                        ; reg: 0x0e3
        movlb   0x00
        bcf     0x3c, 0x6                                   ; reg: 0x03c
        movlb   0x01
        movf    0x2a, W                                     ; reg: 0x0aa
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2a, F                                     ; reg: 0x0aa

label_175:                                                  ; address: 0x0629

        movlb   0x00
        btfss   0x39, 0x0                                   ; reg: 0x039
        return
        bcf     0x39, 0x0                                   ; reg: 0x039
        movf    0x4f, W                                     ; reg: 0x04f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_176
        movlw   0x1e
        movlb   0x01
        movwf   0x63                                        ; reg: 0x0e3

label_176:                                                  ; address: 0x0633

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_178
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_177
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_177
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_178

label_177:                                                  ; address: 0x0644

        movlb   0x01
        incf    0x3f, F                                     ; reg: 0x0bf

label_178:                                                  ; address: 0x0646

        movlw   0x00
        movlb   0x01
        subwf   0x2e, W                                     ; reg: 0x0ae
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_179
        movlw   0xff
        subwf   0x2d, W                                     ; reg: 0x02d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_179
        movlw   0xff
        subwf   0x2c, W                                     ; reg: 0x02c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_179
        movlw   0xff
        subwf   0x2b, W                                     ; reg: 0x02b

label_179:                                                  ; address: 0x0655

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_180
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_180
        movf    0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_180
        movlb   0x01
        incf    0x2b, F                                     ; reg: 0x0ab
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2c, F                                     ; reg: 0x0ac
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2d, F                                     ; reg: 0x0ad
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2e, F                                     ; reg: 0x0ae

label_180:                                                  ; address: 0x0667

        movlw   0x00
        movlb   0x01
        subwf   0x32, W                                     ; reg: 0x0b2
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_181
        movlw   0xff
        subwf   0x31, W                                     ; reg: 0x031
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_181
        movlw   0xff
        subwf   0x30, W                                     ; reg: 0x030
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_181
        movlw   0xff
        subwf   0x2f, W                                     ; reg: 0x02f

label_181:                                                  ; address: 0x0676

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_182
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_182
        movlb   0x01
        incf    0x2f, F                                     ; reg: 0x0af
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x30, F                                     ; reg: 0x0b0
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x31, F                                     ; reg: 0x0b1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x32, F                                     ; reg: 0x0b2

label_182:                                                  ; address: 0x0685

        movlb   0x00
        incf    0x30, W                                     ; reg: 0x030
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x31, W                                     ; reg: 0x031
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_183
        incf    0x30, F                                     ; reg: 0x030
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x31, F                                     ; reg: 0x031

label_183:                                                  ; address: 0x068e

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        movlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_185
        movlb   0x01
        subwf   0x23, W                                     ; reg: 0x0a3
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_184
        movlw   0xff
        subwf   0x22, W                                     ; reg: 0x022
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_184
        movlw   0xff
        subwf   0x21, W                                     ; reg: 0x021
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_184
        movlw   0xff
        subwf   0x20, W                                     ; reg: 0x020

label_184:                                                  ; address: 0x06a1

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        incf    0x20, F                                     ; reg: 0x020
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x21, F                                     ; reg: 0x021
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x22, F                                     ; reg: 0x022
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x23, F                                     ; reg: 0x023
        return

label_185:                                                  ; address: 0x06ab

        movlb   0x01
        subwf   0x27, W                                     ; reg: 0x0a7
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_186
        movlw   0xff
        subwf   0x26, W                                     ; reg: 0x026
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_186
        movlw   0xff
        subwf   0x25, W                                     ; reg: 0x025
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_186
        movlw   0xf9
        subwf   0x24, W                                     ; reg: 0x024

label_186:                                                  ; address: 0x06b9

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        movlw   0x06
        addwf   0x24, F                                     ; reg: 0x024
        movlw   0x01
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addwf   0x25, F                                     ; reg: 0x025
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addwf   0x26, F                                     ; reg: 0x026
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addwf   0x27, F                                     ; reg: 0x027
        return

function_005:                                               ; address: 0x06c5

        movlb   0x02
        clrf    0x20                                        ; reg: 0x120
        movlw   0x60
        movwf   0x21                                        ; reg: 0x121
        clrf    0x22                                        ; reg: 0x122
        movlw   0xcc
        movwf   0x23                                        ; reg: 0x123
        clrf    0x24                                        ; reg: 0x124
        movlw   0x6e
        movwf   0x25                                        ; reg: 0x125
        clrf    0x26                                        ; reg: 0x126
        movwf   0x27                                        ; reg: 0x127
        clrf    0x28                                        ; reg: 0x128
        movlw   0x5a
        movwf   0x29                                        ; reg: 0x129
        clrf    0x2a                                        ; reg: 0x12a
        movlw   0x2c
        movwf   0x2b                                        ; reg: 0x12b
        movlw   0x01
        movwf   0x2c                                        ; reg: 0x12c
        return

function_006:                                               ; address: 0x06da

        ljmp    label_190

label_187:                                                  ; address: 0x06db

        movf    0x3e, W                                     ; reg: 0x03e
        iorwf   0x3d, W                                     ; reg: 0x03d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlw   0x1e
        movwf   0x3d                                        ; reg: 0x03d
        clrf    0x3e                                        ; reg: 0x03e
        incf    0x48, F                                     ; reg: 0x048
        return

label_188:                                                  ; address: 0x06e4

        movf    0x3e, W                                     ; reg: 0x03e
        iorwf   0x3d, W                                     ; reg: 0x03d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlb   0x00
        decf    0x58, F                                     ; reg: 0x058
        movf    0x58, W                                     ; reg: 0x058
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_189
        movlb   0x01
        decf    0x48, F                                     ; reg: 0x0c8
        movlw   0x07
        movwf   0x3d                                        ; reg: 0x0bd
        clrf    0x3e                                        ; reg: 0x0be
        return

label_189:                                                  ; address: 0x06f3

        movlb   0x01
        clrf    0x48                                        ; reg: 0x0c8
        return

label_190:                                                  ; address: 0x06f6

        movlb   0x01
        movf    0x48, W                                     ; reg: 0x0c8
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_187
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_188

function_007:                                               ; address: 0x0702

        bcf     0x3d, 0x0                                   ; reg: 0x03d
        movlb   0x01
        movf    0x47, W                                     ; reg: 0x0c7
        xorlw   0x00
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movf    0x4e, F                                     ; reg: 0x0ce
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_191
        movlb   0x00
        bsf     0x3d, 0x0                                   ; reg: 0x03d

label_191:                                                  ; address: 0x070d

        movlb   0x00
        bsf     0x3d, 0x2                                   ; reg: 0x03d
        movlw   0xff
        movlb   0x01
        movwf   0x52                                        ; reg: 0x0d2
        return

function_008:                                               ; address: 0x0713

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_200
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_192
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_192
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_200

label_192:                                                  ; address: 0x0724

        btfss   0x3a, 0x3                                   ; reg: 0x03a
        return
        movlb   0x01
        movf    0x5a, W                                     ; reg: 0x0da
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decfsz  0x5a, F                                     ; reg: 0x0da
        return
        movlw   0x0a
        movwf   0x5a                                        ; reg: 0x0da
        movf    0x5b, F                                     ; reg: 0x0db
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_199
        movlw   0x09
        subwf   0x3f, W                                     ; reg: 0x03f
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_193
        movlw   0x0a
        ljmp    label_198

label_193:                                                  ; address: 0x0736

        movf    0x3f, F                                     ; reg: 0x03f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_194
        movlb   0x00
        clrf    0x49                                        ; reg: 0x049
        ljmp    label_199

label_194:                                                  ; address: 0x073c

        clrf    (Common_RAM + 5)                            ; reg: 0x075
        ljmp    label_196

label_195:                                                  ; address: 0x073e

        movlw   0x0a
        subwf   (Common_RAM + 5), W                         ; reg: 0x075
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_197
        incf    (Common_RAM + 5), F                         ; reg: 0x075

label_196:                                                  ; address: 0x0743

        movf    (Common_RAM + 5), W                         ; reg: 0x075
        addlw   0x2a
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa9
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        movf    INDF0, W                                    ; reg: 0x000
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x3f, W                                     ; reg: 0x03f
        subwf   (Common_RAM + 4), W                         ; reg: 0x074
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_195

label_197:                                                  ; address: 0x0750

        movf    (Common_RAM + 5), W                         ; reg: 0x075

label_198:                                                  ; address: 0x0751

        movlb   0x00
        movwf   0x49                                        ; reg: 0x049

label_199:                                                  ; address: 0x0753

        movlb   0x01
        clrf    0x3f                                        ; reg: 0x0bf
        return

label_200:                                                  ; address: 0x0756

        movlw   0x0a
        movlb   0x01
        movwf   0x5a                                        ; reg: 0x0da
        movlw   0x1e
        movwf   0x5b                                        ; reg: 0x0db
        movlw   0x05
        ljmp    label_198

function_009:                                               ; address: 0x075d

        movlb   0x00
        btfsc   0x22, 0x0                                   ; reg: 0x022
        ljmp    label_201
        bsf     0x22, 0x0                                   ; reg: 0x022
        bsf     0x51, 0x4                                   ; reg: 0x051

label_201:                                                  ; address: 0x0762

        btfsc   0x44, 0x0                                   ; reg: 0x044
        nop
        movlb   0x00
        btfss   0x44, 0x1                                   ; reg: 0x044
        ljmp    label_202
        movlb   0x02
        movf    0x52, W                                     ; reg: 0x152
        movwf   0x77                                        ; reg: 0x177
        movf    0x53, W                                     ; reg: 0x153
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x01
        movwf   0x3a                                        ; reg: 0x0ba
        movf    0x76, W                                     ; reg: 0x0f6
        movwf   0x39                                        ; reg: 0x0b9
        movlb   0x00
        bsf     0x3e, 0x2                                   ; reg: 0x03e

label_202:                                                  ; address: 0x0773

        btfss   0x44, 0x2                                   ; reg: 0x044
        ljmp    label_203
        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlb   0x02
        movf    0x54, W                                     ; reg: 0x154
        movlb   0x00
        movwf   0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f

label_203:                                                  ; address: 0x077c

        btfss   0x44, 0x4                                   ; reg: 0x044
        ljmp    label_204
        bcf     RB1                                  ; reg: 0x00d, bit: 1
        ljmp    label_205

label_204:                                                  ; address: 0x0780

        bsf     RB1                                  ; reg: 0x00d, bit: 1

label_205:                                                  ; address: 0x0781

        btfss   0x44, 0x6                                   ; reg: 0x044
        return
        clrf    0x50                                        ; reg: 0x050
        incf    0x50, F                                     ; reg: 0x050
        return

function_010:                                               ; address: 0x0786

        movlb   0x01
        clrf    0x48                                        ; reg: 0x0c8
        incf    0x48, F                                     ; reg: 0x0c8
        movlw   0x03
        movlb   0x00
        movwf   0x58                                        ; reg: 0x058
        movlw   0x2c
        movlb   0x01
        movwf   0x3d                                        ; reg: 0x0bd
        movlw   0x01
        movwf   0x3e                                        ; reg: 0x0be
        movf    0x74, W                                     ; reg: 0x0f4
        return

function_011:                                               ; address: 0x0793

        clrf    0x48                                        ; reg: 0x048
        incf    0x48, F                                     ; reg: 0x048
        movlw   0x03
        movlb   0x00
        movwf   0x58                                        ; reg: 0x058
        movlw   0x1e
        movlb   0x01
        movwf   0x3d                                        ; reg: 0x0bd
        clrf    0x3e                                        ; reg: 0x0be
        return

function_012:                                               ; address: 0x079d

        clrf    0x47                                        ; reg: 0x047
        movlw   0x02
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xaa
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        movlw   0x2d
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x03
        movwf   0x2f                                        ; reg: 0x02f
        return

function_013:                                               ; address: 0x07ab

        addlw   0x3b
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa9
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movwf   0x6a                                        ; reg: 0x06a
        moviw   1[FSR0]
        movwf   0x6b                                        ; reg: 0x06b
        movf    0x6a, W                                     ; reg: 0x06a
        return

function_014:                                               ; address: 0x07b7

        movlw   0x1a
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x02
        movwf   0x2f                                        ; reg: 0x02f
        movlb   0x01
        clrf    0x47                                        ; reg: 0x0c7
        movlw   0xff
        movwf   0x39                                        ; reg: 0x0b9
        movwf   0x3a                                        ; reg: 0x0ba
        return

function_015:                                               ; address: 0x07c1

        bcf     0x3e, 0x2                                   ; reg: 0x03e
        bcf     0x3e, 0x3                                   ; reg: 0x03e
        clrf    0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f
        movlb   0x01
        clrf    0x39                                        ; reg: 0x0b9
        clrf    0x3a                                        ; reg: 0x0ba
        clrf    0x47                                        ; reg: 0x0c7
        return

function_016:                                               ; address: 0x07ca

        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        clrf    0x3a                                        ; reg: 0x0ba
        movlb   0x02
        clrf    0x58                                        ; reg: 0x158
        return

function_017:                                               ; address: 0x07d0

        movlb   0x01
        movwf   0x39                                        ; reg: 0x0b9
        movlw   0x03
        movwf   0x3a                                        ; reg: 0x0ba
        return

function_018:                                               ; address: 0x07d5

        movlw   0xc6
        movlb   0x00
        subwf   TMR0, F                                     ; reg: 0x015
        bcf     T0IF                                ; reg: 0x00b, bit: 2
        movlb   0x01
        movf    0x67, W                                     ; reg: 0x0e7
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_206
        decfsz  0x67, F                                     ; reg: 0x067
        ljmp    label_206
        movlb   0x00
        movf    PORTA, W                                    ; reg: 0x00c
        movlb   0x01
        movwf   0x4b                                        ; reg: 0x0cb
        bcf     0x4b, 0x2                                   ; reg: 0x0cb
        movf    0x4b, W                                     ; reg: 0x0cb
        movlb   0x00
        movwf   PORTA                                       ; reg: 0x00c

label_206:                                                  ; address: 0x07e7

        movlb   0x01
        movf    0x68, W                                     ; reg: 0x0e8
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decfsz  0x68, F                                     ; reg: 0x0e8
        return
        movlb   0x00
        btfss   0x52, 0x2                                   ; reg: 0x052
        return
        movlb   0x01
        movf    0x52, W                                     ; reg: 0x0d2
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlb   0x02
        movf    0x38, W                                     ; reg: 0x138
        subwf   0x48, W                                     ; reg: 0x148
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_207
        movf    0x37, W                                     ; reg: 0x037
        subwf   0x47, W                                     ; reg: 0x047

label_207:                                                  ; address: 0x07fa

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        movlb   0x00
        bsf     RA2                                  ; reg: 0x00c, bit: 2
        return
        return

function_019:                                               ; address: 0x0800

        bcf     ADIF                                  ; reg: 0x011, bit: 6
        movf    T2CON, W                                    ; reg: 0x01c

label_208:                                                  ; address: 0x0802

        movlb   0x03
        movwf   0x3e                                        ; reg: 0x1be
        movlb   0x01
        movf    ADRESL, W                                   ; reg: 0x09b
        movlb   0x03
        movwf   0x3d                                        ; reg: 0x1bd
        movlb   0x00
        bcf     ADIF                                  ; reg: 0x011, bit: 6
        bsf     0x39, 0x3                                   ; reg: 0x039
        return

label_209:                                                  ; address: 0x080c

        clrf    (Common_RAM + 6)                            ; reg: 0x076
        clrf    (Common_RAM + 7)                            ; reg: 0x077
        clrf    (Common_RAM + 8)                            ; reg: 0x078
        clrf    (Common_RAM + 9)                            ; reg: 0x079
        movlw   0x20
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0x00
        movwf   FSR0H                                       ; reg: 0x005
        movlw   0x3d
        ;movlp   0x10
        fcall    function_043
        ;movlp   0x08

label_210:                                                  ; address: 0x0818

        movlw   0xa0
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0x00
        movwf   FSR0H                                       ; reg: 0x005
        movlw   0x4f
        ;movlp   0x10
        fcall    function_043
        ;movlp   0x08
        movlw   0x20

label_211:                                                  ; address: 0x0821

        movwf   FSR0L                                       ; reg: 0x004
        movlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        movlw   0x4d
        ;movlp   0x10
        fcall    function_043
        ;movlp   0x08

label_212:                                                  ; address: 0x0828

        movlw   0xa0
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        movlw   0x4c
        ;movlp   0x10
        fcall    function_043
        ;movlp   0x08
        movlw   0x20
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0x02
        movwf   FSR0H                                       ; reg: 0x005
        movlw   0x0e
        ;movlp   0x10
        fcall    function_043
        ;movlp   0x08
        movlb   0x01
        movlw   0x02
        movwf   0x6f                                        ; reg: 0x0ef
        movlb   0x02
        movlw   0x84
        movwf   0x6d                                        ; reg: 0x16d

label_213:                                                  ; address: 0x083e

        movlw   0x03
        movwf   0x6e                                        ; reg: 0x06e
        movlb   0x03
        movlw   0x58
        movwf   0x6c                                        ; reg: 0x1ec
        movlw   0x02
        movwf   0x6d                                        ; reg: 0x1ed
        movlb   0x00
        ljmp    label_214

label_214:                                                  ; address: 0x0847

        bcf     GIE                                 ; reg: 0x00b, bit: 7
        clrwdt
        fcall    function_021
        ;movlp   0x08
        clrwdt
        fcall    function_022

label_215:                                                  ; address: 0x084d

        ;movlp   0x08
        clrwdt

label_216:                                                  ; address: 0x084f

        fcall    function_032
        ;movlp   0x08
        clrwdt
        fcall    function_023
        ;movlp   0x08
        clrwdt
        fcall    function_024
        ;movlp   0x08
        clrwdt
        clrwdt
        fcall    function_025
        clrwdt
        ;movlp   0x18
        fcall    function_062
        ;movlp   0x08
        clrwdt
        fcall    function_026
        clrwdt
        bsf     PEIE                                ; reg: 0x00b, bit: 6
        bsf     GIE                                 ; reg: 0x00b, bit: 7

label_217:                                                  ; address: 0x0863

        clrwdt
        ;movlp   0x18
        fcall    function_063
        ;movlp   0x08

label_218:                                                  ; address: 0x0867

        clrwdt
        fcall    function_027
        clrwdt
        ;movlp   0x25
        fcall    function_089

label_219:                                                  ; address: 0x086c

        ;movlp   0x08
        clrwdt
        ;movlp   0x14
        fcall    function_051

label_220:                                                  ; address: 0x0870

        ;movlp   0x08
        clrwdt
        movlb   0x00
        btfss   0x39, 0x2                                   ; reg: 0x039
        ljmp    label_217
        clrwdt
        fcall    function_020
        clrwdt
        ;movlp   0x00
        fcall    function_000
        ;movlp   0x08
        clrwdt
        fcall    function_029

label_221:                                                  ; address: 0x087d

        clrwdt
        ;movlp   0x19
        fcall    function_064
        ;movlp   0x08
        clrwdt
        fcall    function_028

label_222:                                                  ; address: 0x0883

        ;movlp   0x08
        clrwdt
        ljmp    label_217

function_020:                                               ; address: 0x0886

        movlb   0x00
        bcf     0x36, 0x3                                   ; reg: 0x036
        bcf     0x36, 0x7                                   ; reg: 0x036
        bcf     0x36, 0x2                                   ; reg: 0x036
        bcf     0x36, 0x6                                   ; reg: 0x036
        bcf     0x36, 0x1                                   ; reg: 0x036
        movlb   0x01
        movf    0x24, W                                     ; reg: 0x0a4
        addwf   0x20, W                                     ; reg: 0x0a0

label_223:                                                  ; address: 0x088f

        movlb   0x00
        movwf   0x5d                                        ; reg: 0x05d
        movlb   0x01
        movf    0x25, W                                     ; reg: 0x0a5
        addwfc  0x21, W                                     ; reg: 0x0a1
        movlb   0x00
        movwf   0x5e                                        ; reg: 0x05e
        movlb   0x01
        movf    0x26, W                                     ; reg: 0x0a6
        addwfc  0x22, W                                     ; reg: 0x0a2
        movlb   0x00
        movwf   0x5f                                        ; reg: 0x05f
        movlb   0x01
        movf    0x27, W                                     ; reg: 0x0a7
        addwfc  0x23, W                                     ; reg: 0x0a3
        movlb   0x00
        movwf   0x60                                        ; reg: 0x060
        movlb   0x04
        movwf   0x2d                                        ; reg: 0x22d

label_224:                                                  ; address: 0x08a2

        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x04

label_225:                                                  ; address: 0x08a5

        movwf   0x2c                                        ; reg: 0x02c
        movlb   0x00
        movf    0x5e, W                                     ; reg: 0x05e
        movlb   0x04
        movwf   0x2b                                        ; reg: 0x22b
        movlb   0x00
        movf    0x5d, W                                     ; reg: 0x05d
        movlb   0x04
        movwf   0x2a                                        ; reg: 0x22a
        movlb   0x00
        movf    0x20, W                                     ; reg: 0x020
        addwf   WREG, W                                     ; reg: 0x009
        addwf   WREG, W                                     ; reg: 0x009
        addlw   0x1e
        movwf   FSR0L                                       ; reg: 0x004

label_226:                                                  ; address: 0x08b4

        movlw   0xa9
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movwf   0x5d                                        ; reg: 0x05d
        moviw   1[FSR0]
        movwf   0x5e                                        ; reg: 0x05e
        moviw   2[FSR0]

label_227:                                                  ; address: 0x08bd

        movwf   0x5f                                        ; reg: 0x05f
        moviw   3[FSR0]
        movwf   0x60                                        ; reg: 0x060
        movlb   0x04
        movf    0x2d, W                                     ; reg: 0x22d
        movlb   0x00

label_228:                                                  ; address: 0x08c3

        subwf   0x60, W                                     ; reg: 0x060
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_230
        movlb   0x04
        movf    0x2c, W                                     ; reg: 0x22c

label_229:                                                  ; address: 0x08c8

        movlb   0x00
        subwf   0x5f, W                                     ; reg: 0x05f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_230
        movlb   0x04
        movf    0x2b, W                                     ; reg: 0x22b
        movlb   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_230
        movlb   0x04
        movf    0x2a, W                                     ; reg: 0x22a
        movlb   0x00
        subwf   0x5d, W                                     ; reg: 0x05d

label_230:                                                  ; address: 0x08d6

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        bsf     0x36, 0x6                                   ; reg: 0x036

label_231:                                                  ; address: 0x08d8

        movf    0x4c, W                                     ; reg: 0x04c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_238
        movlb   0x02
        movf    0x42, W                                     ; reg: 0x142

label_232:                                                  ; address: 0x08de

        iorwf   0x41, W                                     ; reg: 0x041
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_238

label_233:                                                  ; address: 0x08e1

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_238
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_238
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x10
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_238
        movf    0x4f, W                                     ; reg: 0x04f

label_234:                                                  ; address: 0x08ef

        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_238
        movlw   0x0a
        subwf   0x59, W                                     ; reg: 0x059
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_235
        bsf     0x22, 0x0                                   ; reg: 0x022
        bsf     0x51, 0x4                                   ; reg: 0x051

label_235:                                                  ; address: 0x08f8

        bsf     0x3e, 0x6                                   ; reg: 0x03e
        movlw   0x14
        movwf   0x55                                        ; reg: 0x055
        bsf     0x36, 0x2                                   ; reg: 0x036
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x05
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_236
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_236
        movlw   0x03
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        bsf     0x36, 0x5                                   ; reg: 0x036
        ljmp    label_251

label_236:                                                  ; address: 0x0909

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x05

label_237:                                                  ; address: 0x090b

        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_251
        movf    0x4d, F                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_251
        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_251

label_238:                                                  ; address: 0x0913

        movlb   0x00
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_240
        movlb   0x02
        movf    0x42, W                                     ; reg: 0x142
        iorwf   0x41, W                                     ; reg: 0x141
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_240

label_239:                                                  ; address: 0x091b

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_241

label_240:                                                  ; address: 0x0920

        movlb   0x00
        btfsc   0x40, 0x0                                   ; reg: 0x040
        ljmp    label_243

label_241:                                                  ; address: 0x0923

        movlw   0x03

label_242:                                                  ; address: 0x0924

        movwf   0x4f                                        ; reg: 0x04f
        ljmp    label_249

label_243:                                                  ; address: 0x0926

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_247
        btfsc   0x40, 0x6                                   ; reg: 0x040
        ljmp    label_247
        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_244
        clrf    0x4d                                        ; reg: 0x04d
        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_245

label_244:                                                  ; address: 0x0932

        movlw   0x0c
        movwf   0x4d                                        ; reg: 0x04d

label_245:                                                  ; address: 0x0934

        btfsc   0x3d, 0x5                                   ; reg: 0x03d

label_246:                                                  ; address: 0x0935

        ljmp    label_251
        bsf     0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_251

label_247:                                                  ; address: 0x0938

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b

label_248:                                                  ; address: 0x093a

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_251
        btfsc   0x3d, 0x6                                   ; reg: 0x03d
        ljmp    label_251
        clrf    0x4f                                        ; reg: 0x04f
        incf    0x4f, F                                     ; reg: 0x04f

label_249:                                                  ; address: 0x0941

        clrf    0x4d                                        ; reg: 0x04d
        bsf     0x22, 0x0                                   ; reg: 0x022

label_250:                                                  ; address: 0x0943

        bsf     0x51, 0x4                                   ; reg: 0x051
        bsf     0x3e, 0x6                                   ; reg: 0x03e
        movlw   0x14
        movwf   0x55                                        ; reg: 0x055

label_251:                                                  ; address: 0x0947

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03

label_252:                                                  ; address: 0x0949

        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_253:                                                  ; address: 0x094a

        ljmp    label_260
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_255

label_254:                                                  ; address: 0x094f

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_255
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_260

label_255:                                                  ; address: 0x0957

        btfsc   0x22, 0x0                                   ; reg: 0x022
        ljmp    label_260

label_256:                                                  ; address: 0x0959

        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_258
        movlb   0x01
        movf    0x5f, W                                     ; reg: 0x0df
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_258
        decfsz  0x5f, F                                     ; reg: 0x05f
        ljmp    label_258
        movlw   0x00
        movlb   0x00
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0x03

label_257:                                                  ; address: 0x0965

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        bcf     0x3d, 0x7                                   ; reg: 0x03d

label_258:                                                  ; address: 0x0969

        movlw   0x00
        movlb   0x00
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0x2d

label_259:                                                  ; address: 0x096d

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_262
        ljmp    label_263

label_260:                                                  ; address: 0x0972

        movlw   0x14
        movlb   0x01

label_261:                                                  ; address: 0x0974

        movwf   0x5f                                        ; reg: 0x05f

label_262:                                                  ; address: 0x0975

        movlb   0x00
        bsf     0x3d, 0x7                                   ; reg: 0x03d

label_263:                                                  ; address: 0x0977

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_264:                                                  ; address: 0x097a

        ljmp    label_269
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_269

label_265:                                                  ; address: 0x0980

        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_270
        movlb   0x01
        movf    0x61, W                                     ; reg: 0x0e1

label_266:                                                  ; address: 0x0984

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_270
        decfsz  0x61, F                                     ; reg: 0x061
        ljmp    label_270
        movlb   0x00
        movf    0x31, W                                     ; reg: 0x031
        movwf   0x62                                        ; reg: 0x062
        movf    0x30, W                                     ; reg: 0x030
        movwf   0x61                                        ; reg: 0x061
        movlb   0x02
        movf    0x3d, W                                     ; reg: 0x13d
        movlb   0x00
        subwf   0x61, F                                     ; reg: 0x061
        movlb   0x02
        movf    0x3e, W                                     ; reg: 0x13e
        movlb   0x00
        subwfb  0x62, F                                     ; reg: 0x062
        movlw   0x00
        subwf   0x62, W                                     ; reg: 0x062
        movlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x61, W                                     ; reg: 0x061
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_267
        bcf     0x40, 0x0                                   ; reg: 0x040
        ljmp    label_268

label_267:                                                  ; address: 0x099e

        bsf     0x40, 0x0                                   ; reg: 0x040

label_268:                                                  ; address: 0x099f

        movf    0x31, W                                     ; reg: 0x031
        movlb   0x02
        movwf   0x3e                                        ; reg: 0x13e
        movlb   0x00
        movf    0x30, W                                     ; reg: 0x030
        movlb   0x02
        movwf   0x3d                                        ; reg: 0x13d
        movlw   0x1e
        movlb   0x01
        movwf   0x61                                        ; reg: 0x0e1
        ljmp    label_270

label_269:                                                  ; address: 0x09aa

        movlb   0x02
        clrf    0x3d                                        ; reg: 0x13d
        clrf    0x3e                                        ; reg: 0x13e
        movlw   0x1e
        movlb   0x01
        movwf   0x61                                        ; reg: 0x0e1
        movlb   0x00
        bsf     0x40, 0x0                                   ; reg: 0x040

label_270:                                                  ; address: 0x09b2

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_275
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_276
        movlb   0x01
        movf    0x60, W                                     ; reg: 0x0e0
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_276
        decfsz  0x60, F                                     ; reg: 0x060
        ljmp    label_276
        movlb   0x00
        movf    0x31, W                                     ; reg: 0x031
        movwf   0x64                                        ; reg: 0x064
        movf    0x30, W                                     ; reg: 0x030
        movwf   0x63                                        ; reg: 0x063
        movlb   0x02
        movf    0x3b, W                                     ; reg: 0x13b
        movlb   0x00
        subwf   0x63, F                                     ; reg: 0x063
        movlb   0x02
        movf    0x3c, W                                     ; reg: 0x13c
        movlb   0x00
        subwfb  0x64, F                                     ; reg: 0x064
        movlw   0x00
        subwf   0x64, W                                     ; reg: 0x064
        movlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x63, W                                     ; reg: 0x063
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_271
        bcf     0x40, 0x6                                   ; reg: 0x040
        ljmp    label_272

label_271:                                                  ; address: 0x09d6

        bsf     0x40, 0x6                                   ; reg: 0x040

label_272:                                                  ; address: 0x09d7

        movf    0x31, W                                     ; reg: 0x031
        movlb   0x02
        movwf   0x3c                                        ; reg: 0x13c
        movlb   0x00
        movf    0x30, W                                     ; reg: 0x030
        movlb   0x02
        movwf   0x3b                                        ; reg: 0x13b
        movlb   0x00
        btfss   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_273
        movlw   0x0a
        ljmp    label_274

label_273:                                                  ; address: 0x09e3

        movlw   0x14

label_274:                                                  ; address: 0x09e4

        movlb   0x01
        movwf   0x60                                        ; reg: 0x0e0
        ljmp    label_276

label_275:                                                  ; address: 0x09e7

        movlb   0x02
        clrf    0x3b                                        ; reg: 0x13b
        clrf    0x3c                                        ; reg: 0x13c
        movlw   0x14
        movlb   0x01
        movwf   0x60                                        ; reg: 0x0e0
        movlb   0x00
        bsf     0x40, 0x6                                   ; reg: 0x040

label_276:                                                  ; address: 0x09ef

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_281
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_282
        movlb   0x01
        movf    0x62, W                                     ; reg: 0x0e2
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_282
        decfsz  0x62, F                                     ; reg: 0x062
        ljmp    label_282
        movlb   0x00
        movf    0x31, W                                     ; reg: 0x031
        movwf   0x66                                        ; reg: 0x066
        movf    0x30, W                                     ; reg: 0x030
        movwf   0x65                                        ; reg: 0x065
        movlb   0x02
        movf    0x3f, W                                     ; reg: 0x13f
        movlb   0x00
        subwf   0x65, F                                     ; reg: 0x065
        movlb   0x02
        movf    0x40, W                                     ; reg: 0x140
        movlb   0x00
        subwfb  0x66, F                                     ; reg: 0x066
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_278
        movlw   0x00
        subwf   0x66, W                                     ; reg: 0x066
        movlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x65, W                                     ; reg: 0x065
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_278

label_277:                                                  ; address: 0x0a13

        bcf     0x3d, 0x6                                   ; reg: 0x03d
        ljmp    label_280

label_278:                                                  ; address: 0x0a15

        btfss   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_279
        movlw   0x00
        subwf   0x66, W                                     ; reg: 0x066
        movlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x65, W                                     ; reg: 0x065
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_277

label_279:                                                  ; address: 0x0a1e

        bsf     0x3d, 0x6                                   ; reg: 0x03d

label_280:                                                  ; address: 0x0a1f

        movf    0x31, W                                     ; reg: 0x031
        movlb   0x02
        movwf   0x40                                        ; reg: 0x140
        movlb   0x00
        movf    0x30, W                                     ; reg: 0x030
        movlb   0x02
        movwf   0x3f                                        ; reg: 0x13f
        movlw   0x1e
        movlb   0x01
        movwf   0x62                                        ; reg: 0x0e2
        ljmp    label_282

label_281:                                                  ; address: 0x0a2a

        movlb   0x02
        clrf    0x3f                                        ; reg: 0x13f
        clrf    0x40                                        ; reg: 0x140
        movlw   0x1e
        movlb   0x01
        movwf   0x62                                        ; reg: 0x0e2
        movlb   0x00
        bsf     0x3d, 0x6                                   ; reg: 0x03d

label_282:                                                  ; address: 0x0a32

        movlw   0x00
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x1f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_283
        movlw   0x03
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xa8
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_284

label_283:                                                  ; address: 0x0a41

        bsf     0x36, 0x3                                   ; reg: 0x036
        bsf     0x36, 0x1                                   ; reg: 0x036

label_284:                                                  ; address: 0x0a43

        movlw   0x00
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0x19
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_286
        btfss   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_285
        btfss   0x36, 0x2                                   ; reg: 0x036
        ljmp    label_286

label_285:                                                  ; address: 0x0a4e

        movf    0x4f, F                                     ; reg: 0x04f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_287

label_286:                                                  ; address: 0x0a51

        bcf     0x36, 0x5                                   ; reg: 0x036

label_287:                                                  ; address: 0x0a52

        movf    0x2f, W                                     ; reg: 0x02f
        iorwf   0x2e, W                                     ; reg: 0x02e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_288
        movlw   0x4c
        movwf   0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f

label_288:                                                  ; address: 0x0a59

        btfss   0x3d, 0x0                                   ; reg: 0x03d
        ljmp    label_291
        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0xb4
        movwf   0x5d                                        ; reg: 0x05d
        movlw   0xff
        addwfc  0x2f, W                                     ; reg: 0x02f
        movwf   0x5e                                        ; reg: 0x05e
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_289
        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x2a, W                                     ; reg: 0x02a

label_289:                                                  ; address: 0x0a66

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfsc   0x43, 0x2                                   ; reg: 0x043
        ljmp    label_291
        movf    0x4f, W                                     ; reg: 0x04f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_291
        movlb   0x02
        movf    0x39, W                                     ; reg: 0x139
        addlw   0x02
        movlb   0x00
        movwf   0x5d                                        ; reg: 0x05d
        movlw   0x00
        movlb   0x02
        addwfc  0x3a, W                                     ; reg: 0x13a
        movlb   0x00
        movwf   0x5e                                        ; reg: 0x05e
        movf    0x2b, W                                     ; reg: 0x02b
        subwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_290
        movf    0x2a, W                                     ; reg: 0x02a
        subwf   0x5d, W                                     ; reg: 0x05d

label_290:                                                  ; address: 0x0a7c

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_293
        movf    0x2b, W                                     ; reg: 0x02b
        movlb   0x02
        movwf   0x3a                                        ; reg: 0x13a
        movlb   0x00
        movf    0x2a, W                                     ; reg: 0x02a
        movlb   0x02
        movwf   0x39                                        ; reg: 0x139
        movlw   0x3c
        movlb   0x01
        movwf   0x66                                        ; reg: 0x0e6
        ljmp    label_293

label_291:                                                  ; address: 0x0a89

        movf    0x4f, F                                     ; reg: 0x04f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_292
        movlb   0x01
        decfsz  0x42, W                                     ; reg: 0x0c2
        ljmp    label_293

label_292:                                                  ; address: 0x0a8f

        movlw   0x3c
        movlb   0x01
        movwf   0x66                                        ; reg: 0x0e6
        movlb   0x02
        clrf    0x39                                        ; reg: 0x139
        clrf    0x3a                                        ; reg: 0x13a

label_293:                                                  ; address: 0x0a95

        movlb   0x00
        clrf    0x2e                                        ; reg: 0x02e
        clrf    0x2f                                        ; reg: 0x02f
        movlb   0x01
        movf    0x66, F                                     ; reg: 0x0e6
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlb   0x00
        bsf     0x36, 0x1                                   ; reg: 0x036
        return

function_021:                                               ; address: 0x0a9f

        movlw   0x7a
        movlb   0x01
        movwf   OSCCON                                      ; reg: 0x099
        clrf    OSCTUNE                                     ; reg: 0x098
        clrf    INTCON                                      ; reg: 0x00b
        clrf    PIE1                                        ; reg: 0x091
        clrf    PIE2                                        ; reg: 0x092
        clrf    PIE3                                        ; reg: 0x093
        movlb   0x00
        clrf    PIR1                                        ; reg: 0x011
        clrf    PIR2                                        ; reg: 0x012
        clrf    PIR3                                        ; reg: 0x013
        movlw   0x81
        movlb   0x01
        movwf   OPTION_REG                                  ; reg: 0x095
        movlb   0x02
        clrf    FVRCON                                      ; reg: 0x117
        movlw   0x40
        movlb   0x0f
        movwf   LCDCON                                      ; reg: 0x791
        movlw   0x18
        movlb   0x00
        movwf   PORTA                                       ; reg: 0x00c
        movlw   0x03
        movlb   0x03
        movwf   ANSELA                                      ; reg: 0x18c
        movlw   0xe3
        movlb   0x01
        movwf   TRISA                                       ; reg: 0x08c
        movlb   0x00
        clrf    PORTB                                       ; reg: 0x00d
        movlb   0x03
        clrf    ANSELB                                      ; reg: 0x18d
        movlw   0xfd
        movlb   0x01
        movwf   TRISB                                       ; reg: 0x08d
        movlw   0x40
        movlb   0x00
        movwf   PORTC                                       ; reg: 0x00e
        movlw   0x81
        movlb   0x01
        movwf   TRISC                                       ; reg: 0x08e
        movlb   0x00
        clrf    PORTE                                       ; reg: 0x010
        movlw   0x0f
        movlb   0x01
        movwf   TRISE                                       ; reg: 0x090
        clrwdt
        return

function_022:                                               ; address: 0x0ad0

        movlb   0x00
        clrf    0x42                                        ; reg: 0x042
        movlb   0x02
        clrf    0x5b                                        ; reg: 0x15b
        movlw   0x0e
        movlb   0x00
        movwf   0x6e                                        ; reg: 0x06e
        clrf    0x4a                                        ; reg: 0x04a
        movlb   0x03
        clrf    0x3f                                        ; reg: 0x1bf
        clrf    0x40                                        ; reg: 0x1c0
        movlb   0x00
        bcf     0x3d, 0x4                                   ; reg: 0x03d
        clrf    0x55                                        ; reg: 0x055
        return

function_023:                                               ; address: 0x0adf

        movlb   0x00
        bsf     0x3b, 0x6                                   ; reg: 0x03b
        movlb   0x01
        clrf    0x4a                                        ; reg: 0x0ca
        movlb   0x00
        clrf    0x4c                                        ; reg: 0x04c
        movlb   0x01
        clrf    0x49                                        ; reg: 0x0c9
        movlw   0x0a
        movlb   0x00
        movwf   0x4f                                        ; reg: 0x04f
        movlw   0x1e
        movwf   0x57                                        ; reg: 0x057
        clrf    0x43                                        ; reg: 0x043
        movlw   0x10
        movwf   0x52                                        ; reg: 0x052
        bcf     0x3f, 0x2                                   ; reg: 0x03f
        movf    0x5c, W                                     ; reg: 0x05c
        movlb   0x02
        movwf   0x55                                        ; reg: 0x155
        movlb   0x00
        bcf     0x3f, 0x4                                   ; reg: 0x03f
        bcf     0x3d, 0x5                                   ; reg: 0x03d
        bcf     0x43, 0x6                                   ; reg: 0x043
        bcf     0x3e, 0x6                                   ; reg: 0x03e
        bsf     0x40, 0x0                                   ; reg: 0x040
        bsf     0x40, 0x6                                   ; reg: 0x040
        movlb   0x01
        movf    0x38, W                                     ; reg: 0x0b8
        movlb   0x03
        movwf   0x4a                                        ; reg: 0x1ca
        movlb   0x01
        movf    0x37, W                                     ; reg: 0x0b7
        movlb   0x03
        movwf   0x49                                        ; reg: 0x1c9
        movlb   0x00
        bcf     0x40, 0x4                                   ; reg: 0x040
        bsf     0x3f, 0x6                                   ; reg: 0x03f
        bcf     0x3f, 0x1                                   ; reg: 0x03f
        bcf     0x3b, 0x1                                   ; reg: 0x03b
        bcf     0x40, 0x7                                   ; reg: 0x040
        bsf     0x3e, 0x5                                   ; reg: 0x03e
        bcf     0x41, 0x4                                   ; reg: 0x041
        movlb   0x01
        clrf    0x42                                        ; reg: 0x0c2
        return

function_024:                                               ; address: 0x0b0d

        movlb   0x02
        clrf    0x50                                        ; reg: 0x150
        movlw   0x39
        movlb   0x00
        movwf   TMR0                                        ; reg: 0x015
        bcf     T0IF                                ; reg: 0x00b, bit: 2
        bsf     T0IE                                ; reg: 0x00b, bit: 5
        bcf     TMR1ON                               ; reg: 0x018, bit: 0
        movlw   0x05
        movlb   0x05
        movwf   CCP2CON                                     ; reg: 0x29a
        movlb   0x00
        bcf     CCP2IF                                ; reg: 0x012, bit: 0
        movlb   0x01
        bsf     CCP2IE                                ; reg: 0x092, bit: 0
        movlw   0x20
        movlb   0x00
        movwf   T1CON                                       ; reg: 0x018
        bsf     TMR1ON                               ; reg: 0x018, bit: 0
        movlb   0x02
        bsf     CCP2SEL                             ; reg: 0x11d, bit: 0
        movlb   0x00
        clrf    TMR2                                        ; reg: 0x01a
        movlw   0x02
        movwf   T2CON                                       ; reg: 0x01c
        movlw   0xf9
        movwf   PR2                                         ; reg: 0x01b
        bsf     TMR2ON                               ; reg: 0x01c, bit: 2
        bcf     TMR2IF                                ; reg: 0x011, bit: 1
        movlb   0x01
        bsf     TMR2IE                                ; reg: 0x091, bit: 1
        movlb   0x08
        clrf    T4CON                                       ; reg: 0x417
        movlb   0x00
        bcf     TMR4IF                                ; reg: 0x013, bit: 1
        movlb   0x08
        clrf    T6CON                                       ; reg: 0x41e
        movlb   0x00
        bcf     TMR6IF                                ; reg: 0x013, bit: 3
        movlw   0x0a
        movlb   0x02
        movwf   0x66                                        ; reg: 0x166
        movlw   0x0c
        movlb   0x01
        movwf   0x45                                        ; reg: 0x0c5
        movlb   0x02
        movwf   0x67                                        ; reg: 0x167
        movlw   0x0a
        movwf   0x68                                        ; reg: 0x168
        movwf   0x65                                        ; reg: 0x165
        movlw   0x3c
        movlb   0x01
        movwf   0x4f                                        ; reg: 0x0cf
        movlw   0xc8
        movwf   0x4c                                        ; reg: 0x0cc
        movlw   0x0a
        movwf   0x4e                                        ; reg: 0x0ce
        movlw   0x1e
        movlb   0x00
        movwf   0x57                                        ; reg: 0x057
        movlw   0x3c
        movlb   0x01
        movwf   0x66                                        ; reg: 0x0e6
        movlw   0x86
        movlb   0x02
        movwf   0x33                                        ; reg: 0x133
        movlw   0x01
        movwf   0x34                                        ; reg: 0x134
        movlb   0x00
        btfss   RB5                                  ; reg: 0x00d, bit: 5
        ljmp    label_295
        bsf     0x3c, 0x0                                   ; reg: 0x03c

label_294:                                                  ; address: 0x0b55

        movlw   0x03
        movlb   0x01
        movwf   0x65                                        ; reg: 0x0e5
        return

label_295:                                                  ; address: 0x0b59

        bcf     0x3c, 0x0                                   ; reg: 0x03c
        ljmp    label_294

function_025:                                               ; address: 0x0b5b

        clrf    (Common_RAM + 9)                            ; reg: 0x079
        clrf    (Common_RAM + 8)                            ; reg: 0x078
        movlb   0x02
        clrf    0x4d                                        ; reg: 0x14d
        movlb   0x01
        bcf     0x41, 0x1                                   ; reg: 0x0c1
        return

function_026:                                               ; address: 0x0b62

        movlw   0x08
        movlb   0x03
        movwf   BAUDCON                                     ; reg: 0x19f
        movlw   0xcf
        movwf   SP1BRGL                                      ; reg: 0x19b
        movlw   0x65
        movwf   TXSTA                                       ; reg: 0x19e
        movlw   0x90
        movwf   RCSTA                                       ; reg: 0x19d
        movf    RCREG, W                                    ; reg: 0x199
        movlb   0x01
        bsf     RCIE                                  ; reg: 0x091, bit: 5
        bsf     PEIE                                ; reg: 0x00b, bit: 6
        bcf     TXIE                                  ; reg: 0x091, bit: 4
        return

function_027:                                               ; address: 0x0b71

        clrf    (Common_RAM + 9)                            ; reg: 0x079
        movlb   0x00
        btfss   0x3a, 0x2                                   ; reg: 0x03a
        ljmp    label_305
        rrf     0x5a, W                                     ; reg: 0x05a
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        rrf     (Common_RAM + 4), F                         ; reg: 0x074
        rrf     (Common_RAM + 4), W                         ; reg: 0x074
        andlw   0x01
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        movlb   0x01
        lslf    0x6a, W                                     ; reg: 0x0ea
        iorwf   0x75, W                                     ; reg: 0x0f5
        movwf   0x6a                                        ; reg: 0x0ea
        movlb   0x00
        swapf   0x5a, W                                     ; reg: 0x05a
        rrf     WREG, F                                     ; reg: 0x009
        andlw   0x01
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlb   0x01
        lslf    0x6c, W                                     ; reg: 0x0ec
        iorwf   0x74, W                                     ; reg: 0x0f4
        movwf   0x6c                                        ; reg: 0x0ec
        movlb   0x00
        movf    0x5a, W                                     ; reg: 0x05a
        andlw   0x01
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlb   0x01
        lslf    0x6b, W                                     ; reg: 0x0eb
        iorwf   0x74, W                                     ; reg: 0x0f4
        movwf   0x6b                                        ; reg: 0x0eb
        movlb   0x00
        swapf   0x5a, W                                     ; reg: 0x05a
        rrf     WREG, F                                     ; reg: 0x009
        rrf     WREG, F                                     ; reg: 0x009
        andlw   0x01
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlb   0x01
        lslf    0x6e, W                                     ; reg: 0x0ee
        iorwf   0x74, W                                     ; reg: 0x0f4
        movwf   0x6e                                        ; reg: 0x0ee
        movlb   0x00
        rrf     0x5a, W                                     ; reg: 0x05a
        rrf     WREG, F                                     ; reg: 0x009
        andlw   0x01
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlb   0x01
        lslf    0x6d, W                                     ; reg: 0x0ed
        iorwf   0x74, W                                     ; reg: 0x0f4
        movwf   0x6d                                        ; reg: 0x0ed
        movf    0x6a, W                                     ; reg: 0x0ea
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_296
        bsf     (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_297

label_296:                                                  ; address: 0x0ba9

        movf    0x6a, F                                     ; reg: 0x06a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_297
        bcf     (Common_RAM + 8), 0x3                       ; reg: 0x078

label_297:                                                  ; address: 0x0bad

        movf    0x6c, W                                     ; reg: 0x06c
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_298
        bsf     (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_299

label_298:                                                  ; address: 0x0bb3

        movf    0x6c, F                                     ; reg: 0x06c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_299
        bcf     (Common_RAM + 8), 0x5                       ; reg: 0x078

label_299:                                                  ; address: 0x0bb7

        movf    0x6b, W                                     ; reg: 0x06b
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_300
        bsf     (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_301

label_300:                                                  ; address: 0x0bbd

        movf    0x6b, F                                     ; reg: 0x06b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_301
        bcf     (Common_RAM + 8), 0x0                       ; reg: 0x078

label_301:                                                  ; address: 0x0bc1

        movf    0x6e, W                                     ; reg: 0x06e
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_302
        bsf     (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_303

label_302:                                                  ; address: 0x0bc7

        movf    0x6e, F                                     ; reg: 0x06e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_303
        bcf     (Common_RAM + 8), 0x6                       ; reg: 0x078

label_303:                                                  ; address: 0x0bcb

        movf    0x6d, W                                     ; reg: 0x06d
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_304
        bsf     (Common_RAM + 8), 0x7                       ; reg: 0x078
        ljmp    label_305

label_304:                                                  ; address: 0x0bd1

        movf    0x6d, F                                     ; reg: 0x06d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_305
        bcf     (Common_RAM + 8), 0x7                       ; reg: 0x078

label_305:                                                  ; address: 0x0bd5

        movf    (Common_RAM + 8), W                         ; reg: 0x078
        movlb   0x01
        xorwf   0x69, W                                     ; reg: 0x0e9
        movwf   0x79                                        ; reg: 0x0f9
        movf    0x78, W                                     ; reg: 0x0f8
        andwf   0x79, F                                     ; reg: 0x0f9
        comf    0x78, W                                     ; reg: 0x0f8
        movwf   0x74                                        ; reg: 0x0f4
        movf    0x78, W                                     ; reg: 0x0f8
        xorwf   0x69, W                                     ; reg: 0x0e9
        andwf   0x74, W                                     ; reg: 0x0f4
        movlb   0x00
        movwf   0x38                                        ; reg: 0x038
        movf    (Common_RAM + 8), W                         ; reg: 0x078
        movlb   0x01
        movwf   0x69                                        ; reg: 0x0e9
        movlb   0x00
        clrf    0x4b                                        ; reg: 0x04b
        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        incf    0x4b, F                                     ; reg: 0x04b
        btfsc   (Common_RAM + 8), 0x0                       ; reg: 0x078
        incf    0x4b, F                                     ; reg: 0x04b
        btfsc   (Common_RAM + 8), 0x5                       ; reg: 0x078
        incf    0x4b, F                                     ; reg: 0x04b
        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        incf    0x4b, F                                     ; reg: 0x04b
        return

function_028:                                               ; address: 0x0bf0

        bcf     GIE                                 ; reg: 0x00b, bit: 7
        movlw   0x10
        movlb   0x00
        movwf   0x52                                        ; reg: 0x052
        btfsc   0x43, 0x0                                   ; reg: 0x043
        bsf     0x52, 0x2                                   ; reg: 0x052
        btfsc   0x43, 0x2                                   ; reg: 0x043
        bcf     0x52, 0x4                                   ; reg: 0x052
        bsf     GIE                                 ; reg: 0x00b, bit: 7
        return

function_029:                                               ; address: 0x0bfa

        movlb   0x02
        clrf    0x5b                                        ; reg: 0x15b
        movlb   0x00
        movf    0x5b, W                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_313
        ljmp    label_312

label_306:                                                  ; address: 0x0c01

        fcall    function_030
        ;movlp   0x08
        ljmp    label_383

label_307:                                                  ; address: 0x0c04

        movlb   0x01
        decfsz  0x43, W                                     ; reg: 0x0c3
        ljmp    label_308
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b

label_308:                                                  ; address: 0x0c09

        movlb   0x01
        movf    0x43, W                                     ; reg: 0x0c3
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_309
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b

label_309:                                                  ; address: 0x0c10

        movlb   0x01
        movf    0x43, W                                     ; reg: 0x0c3
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_310
        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b

label_310:                                                  ; address: 0x0c17

        movlb   0x01
        movf    0x43, W                                     ; reg: 0x0c3
        xorlw   0x04
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383

label_311:                                                  ; address: 0x0c1c

        movlb   0x02
        bsf     0x5b, 0x4                                   ; reg: 0x15b
        ljmp    label_383

label_312:                                                  ; address: 0x0c1f

        movf    0x50, W                                     ; reg: 0x050
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_307
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_306
        ljmp    label_383

label_313:                                                  ; address: 0x0c2a

        btfss   0x36, 0x1                                   ; reg: 0x036
        ljmp    label_314
        movlb   0x01
        movf    0x42, F                                     ; reg: 0x0c2
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_314
        movlb   0x00
        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_383
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        bsf     0x5b, 0x5                                   ; reg: 0x15b
        ljmp    label_360

label_314:                                                  ; address: 0x0c37

        movlb   0x00
        movf    0x58, W                                     ; reg: 0x058
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_382
        fcall    function_031
        ;movlp   0x08
        ljmp    label_383

label_315:                                                  ; address: 0x0c3e

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_316
        movlw   0x0e
        movwf   0x6e                                        ; reg: 0x06e
        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b
        movlb   0x00
        clrf    0x4a                                        ; reg: 0x04a
        movlb   0x03
        clrf    0x3f                                        ; reg: 0x1bf
        incf    0x3f, F                                     ; reg: 0x1bf
        clrf    0x40                                        ; reg: 0x1c0

label_316:                                                  ; address: 0x0c4a

        movlb   0x00
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_325
        movlw   0x0c
        subwf   0x6e, W                                     ; reg: 0x06e
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_319
        movlw   0x0e
        subwf   0x6e, W                                     ; reg: 0x06e
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_319
        movf    0x4a, F                                     ; reg: 0x04a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_317
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        ljmp    label_319

label_317:                                                  ; address: 0x0c5d

        decfsz  0x4a, W                                     ; reg: 0x04a
        ljmp    label_318
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        ljmp    label_319

label_318:                                                  ; address: 0x0c62

        movf    0x4a, W                                     ; reg: 0x04a
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_319
        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b

label_319:                                                  ; address: 0x0c68

        movlw   0x06
        movlb   0x00
        subwf   0x6e, W                                     ; reg: 0x06e
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_322
        movlw   0x08
        subwf   0x6e, W                                     ; reg: 0x06e
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_322
        movf    0x4a, F                                     ; reg: 0x04a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_320
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        ljmp    label_322

label_320:                                                  ; address: 0x0c77

        decfsz  0x4a, W                                     ; reg: 0x04a
        ljmp    label_321
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        ljmp    label_322

label_321:                                                  ; address: 0x0c7c

        movf    0x4a, W                                     ; reg: 0x04a
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_322
        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b

label_322:                                                  ; address: 0x0c82

        movlb   0x00
        movf    0x6e, F                                     ; reg: 0x06e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383
        movlw   0x0e
        movwf   0x6e                                        ; reg: 0x06e
        movlw   0x02
        subwf   0x4a, W                                     ; reg: 0x04a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_324

label_323:                                                  ; address: 0x0c8c

        clrf    0x4a                                        ; reg: 0x04a
        ljmp    label_383

label_324:                                                  ; address: 0x0c8e

        incf    0x4a, F                                     ; reg: 0x04a
        ljmp    label_383

label_325:                                                  ; address: 0x0c90

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383
        movlw   0x0c
        subwf   0x6e, W                                     ; reg: 0x06e
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_328
        movlw   0x0e
        subwf   0x6e, W                                     ; reg: 0x06e
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_328
        movf    0x4a, F                                     ; reg: 0x04a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_326
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        ljmp    label_328

label_326:                                                  ; address: 0x0ca2

        decfsz  0x4a, W                                     ; reg: 0x04a
        ljmp    label_328
        btfss   0x36, 0x6                                   ; reg: 0x036
        ljmp    label_327
        movlb   0x02
        bsf     0x5b, 0x4                                   ; reg: 0x15b
        ljmp    label_328

label_327:                                                  ; address: 0x0ca9

        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b

label_328:                                                  ; address: 0x0cab

        movlw   0x06
        movlb   0x00
        subwf   0x6e, W                                     ; reg: 0x06e
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_331
        movlw   0x08
        subwf   0x6e, W                                     ; reg: 0x06e
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_331
        movf    0x4a, F                                     ; reg: 0x04a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_329
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        ljmp    label_331

label_329:                                                  ; address: 0x0cba

        decfsz  0x4a, W                                     ; reg: 0x04a
        ljmp    label_331
        btfss   0x36, 0x6                                   ; reg: 0x036
        ljmp    label_330
        movlb   0x02
        bsf     0x5b, 0x4                                   ; reg: 0x15b
        ljmp    label_331

label_330:                                                  ; address: 0x0cc1

        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b

label_331:                                                  ; address: 0x0cc3

        movlb   0x00
        movf    0x6e, F                                     ; reg: 0x06e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383
        movlw   0x0e
        movwf   0x6e                                        ; reg: 0x06e
        movf    0x4a, W                                     ; reg: 0x04a
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_324
        ljmp    label_323

label_332:                                                  ; address: 0x0ccd

        movlb   0x03
        decf    0x3f, W                                     ; reg: 0x1bf
        iorwf   0x40, W                                     ; reg: 0x1c0
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_339
        clrf    0x3f                                        ; reg: 0x03f
        clrf    0x40                                        ; reg: 0x040
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_333
        movf    0x23, W                                     ; reg: 0x023
        movlb   0x02
        movwf   0x31                                        ; reg: 0x131
        clrf    0x32                                        ; reg: 0x132

label_333:                                                  ; address: 0x0cdd

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x08
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_334
        movf    0x20, W                                     ; reg: 0x020
        movlb   0x02
        movwf   0x31                                        ; reg: 0x131
        clrf    0x32                                        ; reg: 0x132

label_334:                                                  ; address: 0x0ce6

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x09
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_335
        movf    0x21, W                                     ; reg: 0x021
        movlb   0x02
        movwf   0x31                                        ; reg: 0x131
        clrf    0x32                                        ; reg: 0x132

label_335:                                                  ; address: 0x0cef

        movlb   0x02
        movf    0x31, W                                     ; reg: 0x131
        xorlw   0x02
        iorwf   0x32, W                                     ; reg: 0x132
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_336
        movlw   0x0a
        ljmp    label_338

label_336:                                                  ; address: 0x0cf7

        decf    0x31, W                                     ; reg: 0x031
        iorwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_337
        movlw   0x14
        ljmp    label_338

label_337:                                                  ; address: 0x0cfd

        movlw   0x1e

label_338:                                                  ; address: 0x0cfe

        movlb   0x00
        movwf   0x57                                        ; reg: 0x057

label_339:                                                  ; address: 0x0d00

        movlb   0x00
        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_383
        movlw   0x15
        subwf   0x57, W                                     ; reg: 0x057
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_341

label_340:                                                  ; address: 0x0d07

        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        ljmp    label_344

label_341:                                                  ; address: 0x0d0a

        movlw   0x0b
        subwf   0x57, W                                     ; reg: 0x057
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_342
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        ljmp    label_344

label_342:                                                  ; address: 0x0d12

        movf    0x57, W                                     ; reg: 0x057
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_343
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        bsf     0x5b, 0x5                                   ; reg: 0x15b
        ljmp    label_344

label_343:                                                  ; address: 0x0d1a

        btfsc   0x3b, 0x3                                   ; reg: 0x03b
        ljmp    label_340

label_344:                                                  ; address: 0x0d1c

        movlb   0x00
        movf    0x57, F                                     ; reg: 0x057
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383
        movlw   0x1e
        movwf   0x57                                        ; reg: 0x057
        ljmp    label_383

label_345:                                                  ; address: 0x0d23

        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_347
        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_383

label_346:                                                  ; address: 0x0d28

        movlb   0x02
        ljmp    label_380

label_347:                                                  ; address: 0x0d2a

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_348
        ljmp    label_349

label_348:                                                  ; address: 0x0d2d

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_346
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_350

label_349:                                                  ; address: 0x0d35

        btfsc   0x3b, 0x3                                   ; reg: 0x03b
        ljmp    label_346
        ljmp    label_383

label_350:                                                  ; address: 0x0d38

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_383

label_351:                                                  ; address: 0x0d3d

        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        ljmp    label_354

label_352:                                                  ; address: 0x0d40

        btfss   0x3b, 0x3                                   ; reg: 0x03b
        ljmp    label_383

label_353:                                                  ; address: 0x0d42

        movlb   0x02

label_354:                                                  ; address: 0x0d43

        bsf     0x5b, 0x3                                   ; reg: 0x05b
        ljmp    label_383

label_355:                                                  ; address: 0x0d45

        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_357
        movf    0x55, W                                     ; reg: 0x055
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_356
        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_383
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        ljmp    label_379

label_356:                                                  ; address: 0x0d4f

        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_383
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_351
        ljmp    label_383

label_357:                                                  ; address: 0x0d56

        movlw   0x15
        subwf   0x57, W                                     ; reg: 0x057
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_353
        movlw   0x0b
        subwf   0x57, W                                     ; reg: 0x057
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_359

label_358:                                                  ; address: 0x0d5e

        movlb   0x02
        ljmp    label_360

label_359:                                                  ; address: 0x0d60

        movf    0x57, W                                     ; reg: 0x057
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_346
        btfss   0x3b, 0x3                                   ; reg: 0x03b
        ljmp    label_383
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b

label_360:                                                  ; address: 0x0d67

        bsf     0x5b, 0x2                                   ; reg: 0x05b
        ljmp    label_383

label_361:                                                  ; address: 0x0d69

        movlb   0x02
        decfsz  0x51, W                                     ; reg: 0x151
        ljmp    label_363
        movlb   0x00

label_362:                                                  ; address: 0x0d6d

        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_367
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        ljmp    label_367

label_363:                                                  ; address: 0x0d73

        movlb   0x00
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_367
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_364
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_365

label_364:                                                  ; address: 0x0d7b

        movf    0x55, F                                     ; reg: 0x055
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_362

label_365:                                                  ; address: 0x0d7e

        movf    0x55, W                                     ; reg: 0x055
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_366
        btfss   0x3d, 0x4                                   ; reg: 0x03d
        ljmp    label_367
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        bsf     0x5b, 0x5                                   ; reg: 0x15b
        ljmp    label_367

label_366:                                                  ; address: 0x0d88

        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        movlb   0x00
        btfsc   0x36, 0x6                                   ; reg: 0x036
        btfss   0x3b, 0x0                                   ; reg: 0x03b
        ljmp    label_367
        movlb   0x02
        bsf     0x5b, 0x4                                   ; reg: 0x15b

label_367:                                                  ; address: 0x0d91

        movlb   0x00
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_383
        movf    0x37, F                                     ; reg: 0x037
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_368
        movf    0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_368
        btfss   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_352
        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        movlb   0x00
        btfsc   0x3b, 0x0                                   ; reg: 0x03b
        ljmp    label_358
        ljmp    label_383

label_368:                                                  ; address: 0x0da2

        decfsz  0x37, W                                     ; reg: 0x037
        ljmp    label_383
        movf    0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_383
        btfss   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_369
        movlb   0x02
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        movlb   0x00
        btfsc   0x3b, 0x0                                   ; reg: 0x03b
        ljmp    label_353
        ljmp    label_383

label_369:                                                  ; address: 0x0daf

        btfsc   0x3b, 0x3                                   ; reg: 0x03b
        ljmp    label_358
        ljmp    label_383

label_370:                                                  ; address: 0x0db2

        movf    0x4d, F                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_371
        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_371

label_371:                                                  ; address: 0x0db7

        btfsc   0x3b, 0x0                                   ; reg: 0x03b
        ljmp    label_311
        ljmp    label_383

label_372:                                                  ; address: 0x0dba

        btfss   0x3a, 0x4                                   ; reg: 0x03a
        ljmp    label_373
        incf    0x4e, F                                     ; reg: 0x04e

label_373:                                                  ; address: 0x0dbd

        movlw   0x04
        subwf   0x4e, W                                     ; reg: 0x04e
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        clrf    0x4e                                        ; reg: 0x04e
        movf    0x4e, F                                     ; reg: 0x04e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_346
        decfsz  0x4e, W                                     ; reg: 0x04e
        ljmp    label_374
        ljmp    label_353

label_374:                                                  ; address: 0x0dc7

        movf    0x4e, W                                     ; reg: 0x04e
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_353
        movf    0x4e, W                                     ; reg: 0x04e
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_346
        ljmp    label_383

label_375:                                                  ; address: 0x0dd0

        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_378
        movlb   0x01
        movf    0x5d, W                                     ; reg: 0x0dd
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_377

label_376:                                                  ; address: 0x0dd7

        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        bsf     0x5b, 0x2                                   ; reg: 0x15b
        ljmp    label_380

label_377:                                                  ; address: 0x0ddb

        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_353
        btfsc   (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_358
        btfsc   (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_346
        ljmp    label_376

label_378:                                                  ; address: 0x0de2

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_383
        movlb   0x01
        movf    0x5d, W                                     ; reg: 0x0dd
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_376
        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        btfss   (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_381
        movlb   0x02

label_379:                                                  ; address: 0x0dec

        bsf     0x5b, 0x3                                   ; reg: 0x05b

label_380:                                                  ; address: 0x0ded

        bsf     0x5b, 0x5                                   ; reg: 0x05b
        ljmp    label_383

label_381:                                                  ; address: 0x0def

        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_353
        btfsc   (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_358
        btfss   (Common_RAM + 8), 0x5                       ; reg: 0x078
        ljmp    label_383
        movlb   0x00
        btfsc   0x3b, 0x0                                   ; reg: 0x03b
        ljmp    label_311
        ljmp    label_346

label_382:                                                  ; address: 0x0df9

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_355
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_370
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_361
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_372
        xorlw   0x0d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_332
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_332
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_355
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_352
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_345
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_332
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_315
        xorlw   0x1e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_375

label_383:                                                  ; address: 0x0e1e

        movlb   0x02
        movf    0x5b, W                                     ; reg: 0x15b
        movlb   0x00
        movwf   0x42                                        ; reg: 0x042
        return

function_030:                                               ; address: 0x0e23

        movlb   0x01
        movf    0x49, W                                     ; reg: 0x0c9
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_388

label_384:                                                  ; address: 0x0e29

        movlb   0x02
        bsf     0x5b, 0x4                                   ; reg: 0x15b
        return

label_385:                                                  ; address: 0x0e2c

        movlb   0x02
        bsf     0x5b, 0x6                                   ; reg: 0x15b
        return

label_386:                                                  ; address: 0x0e2f

        movlb   0x02
        bsf     0x5b, 0x3                                   ; reg: 0x15b
        return

label_387:                                                  ; address: 0x0e32

        movlb   0x02
        bsf     0x5b, 0x5                                   ; reg: 0x15b
        return

label_388:                                                  ; address: 0x0e35

        movlb   0x00
        movf    0x47, W                                     ; reg: 0x047
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_384
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_385
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_386
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_387
        xorlw   0x07
        return

function_031:                                               ; address: 0x0e45

        movlb   0x01
        decfsz  0x48, W                                     ; reg: 0x0c8
        return
        ljmp    label_394

label_389:                                                  ; address: 0x0e49

        bsf     0x5b, 0x3                                   ; reg: 0x05b
        return

label_390:                                                  ; address: 0x0e4b

        bsf     0x5b, 0x2                                   ; reg: 0x05b
        return

label_391:                                                  ; address: 0x0e4d

        bsf     0x5b, 0x5                                   ; reg: 0x05b
        return

label_392:                                                  ; address: 0x0e4f

        bsf     0x5b, 0x3                                   ; reg: 0x05b
        bsf     0x5b, 0x2                                   ; reg: 0x05b
        return

label_393:                                                  ; address: 0x0e52

        bsf     0x5b, 0x3                                   ; reg: 0x05b
        bsf     0x5b, 0x5                                   ; reg: 0x05b
        bsf     0x5b, 0x2                                   ; reg: 0x05b
        return

label_394:                                                  ; address: 0x0e56

        movlb   0x02
        movf    0x4e, W                                     ; reg: 0x14e
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_389
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_390
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_393
        xorlw   0x0e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_392
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_393
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_391
        xorlw   0x19
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_393

function_032:                                               ; address: 0x0e6e

        movlb   0x03
        clrf    EECON1                                      ; reg: 0x195
        movlb   0x00
        clrf    0x48                                        ; reg: 0x048

label_395:                                                  ; address: 0x0e72

        clrwdt
        fcall    function_042
        ;movlp   0x08

label_396:                                                  ; address: 0x0e75

        fcall    function_041
        ;movlp   0x08
        movlw   0x06
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x48, W                                     ; reg: 0x048
        fcall    function_035
        ;movlp   0x08
        addwf   0x64, W                                     ; reg: 0x064
        addlw   0x50
        fcall    function_033
        ;movlp   0x08
        movwf   INDF1                                       ; reg: 0x001
        movlb   0x00
        incf    0x64, F                                     ; reg: 0x064
        movlw   0x06
        subwf   0x64, W                                     ; reg: 0x064
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_396
        movlw   0x04
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xd3
        fcall    function_034
        ;movlp   0x08
        movlb   0x03
        movf    0x57, W                                     ; reg: 0x1d7
        movlb   0x00
        xorwf   0x29, W                                     ; reg: 0x029
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_397
        movlb   0x03
        movf    0x58, W                                     ; reg: 0x1d8
        movlb   0x00
        xorwf   0x28, W                                     ; reg: 0x028
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        clrf    0x63                                        ; reg: 0x063

label_397:                                                  ; address: 0x0e98

        incf    0x48, F                                     ; reg: 0x048
        movf    0x63, W                                     ; reg: 0x063
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_398
        movlw   0x02
        subwf   0x48, W                                     ; reg: 0x048
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_395

label_398:                                                  ; address: 0x0ea1

        movf    0x63, F                                     ; reg: 0x063
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_399
        fcall    function_036
        ;movlp   0x08
        ljmp    label_400

label_399:                                                  ; address: 0x0ea7

        fcall    function_037
        ;movlp   0x08

label_400:                                                  ; address: 0x0ea9

        clrf    0x48                                        ; reg: 0x048

label_401:                                                  ; address: 0x0eaa

        clrwdt
        fcall    function_042
        ;movlp   0x08

label_402:                                                  ; address: 0x0ead

        fcall    function_041
        ;movlp   0x08
        movlw   0x19
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x48, W                                     ; reg: 0x048
        fcall    function_035
        ;movlp   0x08
        addwf   0x64, W                                     ; reg: 0x064
        addlw   0x1e
        fcall    function_033
        ;movlp   0x08
        movwf   INDF1                                       ; reg: 0x001
        movlb   0x00
        incf    0x64, F                                     ; reg: 0x064
        movlw   0x19
        subwf   0x64, W                                     ; reg: 0x064
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_402
        movlw   0x17
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xd3
        fcall    function_034
        ;movlp   0x08
        movlb   0x03
        movf    0x6a, W                                     ; reg: 0x1ea
        movlb   0x00
        xorwf   0x29, W                                     ; reg: 0x029
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_403
        movlb   0x03
        movf    0x6b, W                                     ; reg: 0x1eb
        movlb   0x00
        xorwf   0x28, W                                     ; reg: 0x028
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        clrf    0x63                                        ; reg: 0x063

label_403:                                                  ; address: 0x0ed0

        incf    0x48, F                                     ; reg: 0x048
        movf    0x63, W                                     ; reg: 0x063
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_404
        movlw   0x02
        subwf   0x48, W                                     ; reg: 0x048
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_401

label_404:                                                  ; address: 0x0ed9

        movf    0x63, F                                     ; reg: 0x063
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_405
        ;movlp   0x23
        fcall    function_087
        ;movlp   0x08
        ljmp    label_406

label_405:                                                  ; address: 0x0ee0

        fcall    function_038
        ;movlp   0x08

label_406:                                                  ; address: 0x0ee2

        movlb   0x00
        clrf    0x48                                        ; reg: 0x048

label_407:                                                  ; address: 0x0ee4

        clrwdt
        fcall    function_042
        ;movlp   0x08

label_408:                                                  ; address: 0x0ee7

        fcall    function_041
        ;movlp   0x08
        movlw   0x0f
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x48, W                                     ; reg: 0x048
        fcall    function_035
        ;movlp   0x08
        addwf   0x64, W                                     ; reg: 0x064
        fcall    function_033
        ;movlp   0x08
        movwf   INDF1                                       ; reg: 0x001
        movlb   0x00
        incf    0x64, F                                     ; reg: 0x064
        movlw   0x0f
        subwf   0x64, W                                     ; reg: 0x064
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_408
        movlw   0x0d
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xd3
        fcall    function_034
        ;movlp   0x08
        movlb   0x03
        movf    0x60, W                                     ; reg: 0x1e0
        movlb   0x00
        xorwf   0x29, W                                     ; reg: 0x029
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_409
        movlb   0x03
        movf    0x61, W                                     ; reg: 0x1e1
        movlb   0x00
        xorwf   0x28, W                                     ; reg: 0x028
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        clrf    0x63                                        ; reg: 0x063

label_409:                                                  ; address: 0x0f09

        incf    0x48, F                                     ; reg: 0x048
        movf    0x63, W                                     ; reg: 0x063
        xorlw   0xff
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_410
        movlw   0x02
        subwf   0x48, W                                     ; reg: 0x048
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_407

label_410:                                                  ; address: 0x0f12

        movf    0x63, F                                     ; reg: 0x063
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_411
        fcall    function_039
        ;movlp   0x08
        ljmp    label_412

label_411:                                                  ; address: 0x0f18

        ;movlp   0x06
        fcall    function_005
        ;movlp   0x08

label_412:                                                  ; address: 0x0f1b

        clrwdt
        movlb   0x00
        clrf    0x64                                        ; reg: 0x064

label_413:                                                  ; address: 0x0f1e

        movf    0x64, W                                     ; reg: 0x064
        addlw   0x20
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x02
        movwf   FSR1H                                       ; reg: 0x007
        movf    0x64, W                                     ; reg: 0x064
        addlw   0xf6
        fcall    function_033
        ;movlp   0x08
        movwf   INDF1                                       ; reg: 0x001
        movlb   0x00
        incf    0x64, F                                     ; reg: 0x064
        movlw   0x0a
        subwf   0x64, W                                     ; reg: 0x064
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        ljmp    label_413

function_033:                                               ; address: 0x0f2f

        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlb   0x03
        movwf   EEADRL                                      ; reg: 0x191
        clrf    EEADRH                                      ; reg: 0x192
        bsf     RD                                  ; reg: 0x195, bit: 0
        movf    EEDATL, W                                   ; reg: 0x193
        movwf   0x75                                        ; reg: 0x1f5
        return

function_034:                                               ; address: 0x0f37

        movlb   0x00
        movwf   0x60                                        ; reg: 0x060
        movlw   0xaa
        movwf   0x29                                        ; reg: 0x029
        movf    0x60, W                                     ; reg: 0x060
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    INDF1, W                                    ; reg: 0x001
        movwf   0x28                                        ; reg: 0x028
        clrf    0x62                                        ; reg: 0x062

label_414:                                                  ; address: 0x0f42

        incf    0x62, F                                     ; reg: 0x062
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        addlw   0x02
        movwf   0x5d                                        ; reg: 0x05d
        movlw   0x00
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        movlw   0x01
        movwf   0x5e                                        ; reg: 0x05e
        xorlw   0x80
        sublw   0x80
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_415
        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x62, W                                     ; reg: 0x062

label_415:                                                  ; address: 0x0f50

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        movlb   0x00
        subwf   0x62, W                                     ; reg: 0x062
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_416
        movf    0x62, W                                     ; reg: 0x062
        addwf   0x60, W                                     ; reg: 0x060
        movwf   0x5d                                        ; reg: 0x05d
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    INDF1, W                                    ; reg: 0x001
        movwf   0x5f                                        ; reg: 0x05f
        ljmp    label_417

label_416:                                                  ; address: 0x0f60

        clrf    0x5f                                        ; reg: 0x05f

label_417:                                                  ; address: 0x0f61

        clrf    0x61                                        ; reg: 0x061

label_418:                                                  ; address: 0x0f62

        bcf     0x3b, 0x2                                   ; reg: 0x03b
        btfsc   0x29, 0x7                                   ; reg: 0x029
        bsf     0x3b, 0x2                                   ; reg: 0x03b
        lslf    0x28, F                                     ; reg: 0x028
        rlf     0x29, F                                     ; reg: 0x029
        btfsc   0x5f, 0x7                                   ; reg: 0x05f
        bsf     0x28, 0x0                                   ; reg: 0x028
        lslf    0x5f, F                                     ; reg: 0x05f
        btfss   0x3b, 0x2                                   ; reg: 0x03b
        ljmp    label_419
        movlw   0x80
        xorwf   0x29, F                                     ; reg: 0x029
        movlw   0x05
        xorwf   0x28, F                                     ; reg: 0x028

label_419:                                                  ; address: 0x0f70

        incf    0x61, F                                     ; reg: 0x061
        movlw   0x08
        subwf   0x61, W                                     ; reg: 0x061
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_414
        ljmp    label_418

function_035:                                               ; address: 0x0f76

        movwf   0x5e                                        ; reg: 0x05e
        clrf    0x5d                                        ; reg: 0x05d

label_420:                                                  ; address: 0x0f78

        movf    (Common_RAM + 4), W                         ; reg: 0x074
        btfsc   0x5e, 0x0                                   ; reg: 0x05e
        addwf   0x5d, F                                     ; reg: 0x05d
        lslf    (Common_RAM + 4), F                         ; reg: 0x074
        lsrf    0x5e, F                                     ; reg: 0x05e
        movf    0x5e, F                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_420
        movf    0x5d, W                                     ; reg: 0x05d
        return

function_036:                                               ; address: 0x0f82

        movlb   0x03
        movf    0x53, W                                     ; reg: 0x1d3
        movlb   0x00
        movwf   0x20                                        ; reg: 0x020
        movlb   0x03
        movf    0x54, W                                     ; reg: 0x1d4
        movlb   0x00
        movwf   0x21                                        ; reg: 0x021
        movlb   0x03
        movf    0x55, W                                     ; reg: 0x1d5
        movlb   0x00
        movwf   0x22                                        ; reg: 0x022
        movlb   0x03
        movf    0x56, W                                     ; reg: 0x1d6
        movlb   0x00
        movwf   0x23                                        ; reg: 0x023
        return

function_037:                                               ; address: 0x0f93

        movlw   0x02
        movlb   0x00
        movwf   0x20                                        ; reg: 0x020
        clrf    0x21                                        ; reg: 0x021
        clrf    0x22                                        ; reg: 0x022
        clrf    0x23                                        ; reg: 0x023
        incf    0x23, F                                     ; reg: 0x023
        return

function_038:                                               ; address: 0x0f9b

        movlb   0x01
        clrf    0x2f                                        ; reg: 0x0af
        clrf    0x30                                        ; reg: 0x0b0
        clrf    0x31                                        ; reg: 0x0b1
        clrf    0x32                                        ; reg: 0x0b2
        clrf    0x2b                                        ; reg: 0x0ab
        clrf    0x2c                                        ; reg: 0x0ac
        clrf    0x2d                                        ; reg: 0x0ad
        clrf    0x2e                                        ; reg: 0x0ae
        clrf    0x2a                                        ; reg: 0x0aa
        clrf    0x20                                        ; reg: 0x0a0
        clrf    0x21                                        ; reg: 0x0a1
        clrf    0x22                                        ; reg: 0x0a2
        clrf    0x23                                        ; reg: 0x0a3
        clrf    0x24                                        ; reg: 0x0a4
        clrf    0x25                                        ; reg: 0x0a5
        clrf    0x26                                        ; reg: 0x0a6
        clrf    0x27                                        ; reg: 0x0a7
        clrf    0x28                                        ; reg: 0x0a8
        clrf    0x29                                        ; reg: 0x0a9
        clrf    0x33                                        ; reg: 0x0b3
        clrf    0x34                                        ; reg: 0x0b4
        clrf    0x35                                        ; reg: 0x0b5
        clrf    0x36                                        ; reg: 0x0b6
        return

function_039:                                               ; address: 0x0fb4

        movlb   0x03
        movf    0x53, W                                     ; reg: 0x1d3
        movlb   0x02
        movwf   0x20                                        ; reg: 0x120
        movlb   0x03
        movf    0x54, W                                     ; reg: 0x1d4
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x55, W                                     ; reg: 0x1d5
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x02
        movwf   0x22                                        ; reg: 0x122
        movf    0x76, W                                     ; reg: 0x176

function_040:                                               ; address: 0x0fc1

        movwf   0x21                                        ; reg: 0x021
        movlb   0x03
        movf    0x56, W                                     ; reg: 0x1d6
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x57, W                                     ; reg: 0x1d7
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x02
        movwf   0x24                                        ; reg: 0x124
        movf    0x76, W                                     ; reg: 0x176
        movwf   0x23                                        ; reg: 0x123
        movlb   0x03
        movf    0x58, W                                     ; reg: 0x1d8
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x59, W                                     ; reg: 0x1d9
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x02
        movwf   0x26                                        ; reg: 0x126
        movf    0x76, W                                     ; reg: 0x176
        movwf   0x25                                        ; reg: 0x125
        movlb   0x03
        movf    0x5a, W                                     ; reg: 0x1da
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x5b, W                                     ; reg: 0x1db
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x02
        movwf   0x28                                        ; reg: 0x128
        movf    0x76, W                                     ; reg: 0x176
        movwf   0x27                                        ; reg: 0x127
        movlb   0x03
        movf    0x5c, W                                     ; reg: 0x1dc
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x5d, W                                     ; reg: 0x1dd
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x02
        movwf   0x2a                                        ; reg: 0x12a
        movf    0x76, W                                     ; reg: 0x176
        movwf   0x29                                        ; reg: 0x129
        movlb   0x03
        movf    0x5e, W                                     ; reg: 0x1de
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x5f, W                                     ; reg: 0x1df
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x02
        movwf   0x2c                                        ; reg: 0x12c
        movf    0x76, W                                     ; reg: 0x176
        movwf   0x2b                                        ; reg: 0x12b
        return

function_041:                                               ; address: 0x0ff5

        movf    0x64, W                                     ; reg: 0x064
        addlw   0xd3
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        return

function_042:                                               ; address: 0x0ffb

        movlw   0xff
        movlb   0x00
        movwf   0x63                                        ; reg: 0x063
        clrf    0x64                                        ; reg: 0x064
        return

function_043:                                               ; address: 0x1001

        clrwdt
        clrf    INDF0                                       ; reg: 0x000
        addfsr  FSR0, 1
        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_208
        retlw   0x00

function_044:                                               ; address: 0x1007

        movlb   0x02
        movf    0x62, W                                     ; reg: 0x162
        movlb   0x01
        subwf   0x54, W                                     ; reg: 0x0d4
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_210
        movf    0x54, W                                     ; reg: 0x054
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    INDF1, W                                    ; reg: 0x001
        movlb   0x03
        movwf   TXREG                                       ; reg: 0x19a
        movlb   0x01
        incf    0x54, F                                     ; reg: 0x0d4
        return
        bcf     TXIE                                  ; reg: 0x091, bit: 4
        movlw   0x02
        movwf   0x51                                        ; reg: 0x0d1
        return

function_045:                                               ; address: 0x101c

        movlb   0x03
        btfsc   FERR                                 ; reg: 0x19d, bit: 2
        ljmp    label_211
        btfss   0x1d, 0x1                                   ; reg: 0x01d
        ljmp    label_212
        bcf     0x1d, 0x4                                   ; reg: 0x01d
        movf    T1GCON, W                                   ; reg: 0x019
        movlb   0x01
        clrf    0x53                                        ; reg: 0x0d3
        movlb   0x03
        bsf     CREN                                 ; reg: 0x19d, bit: 4
        return
        movf    RCREG, W                                    ; reg: 0x199
        movwf   0x70                                        ; reg: 0x1f0
        movlb   0x00
        btfss   0x39, 0x7                                   ; reg: 0x039
        btfsc   0x39, 0x6                                   ; reg: 0x039
        return
        movlw   0x14
        movlb   0x01
        movwf   0x50                                        ; reg: 0x0d0
        movf    0x53, F                                     ; reg: 0x0d3
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_213
        movf    Common_RAM, W                               ; reg: 0x070
        xorlw   0x0a

label_421:                                                  ; address: 0x1036

        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movf    Common_RAM, W                               ; reg: 0x070
        movlb   0x03
        movwf   0x20                                        ; reg: 0x1a0
        movlb   0x01
        incf    0x53, F                                     ; reg: 0x0d3
        return

label_422:                                                  ; address: 0x103e

        decfsz  0x53, W                                     ; reg: 0x053
        ljmp    label_216
        movlw   0x19
        subwf   Common_RAM, W                               ; reg: 0x070
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_215
        movf    Common_RAM, W                               ; reg: 0x070

label_423:                                                  ; address: 0x1045

        movlb   0x03
        movwf   0x21                                        ; reg: 0x1a1
        movlb   0x01
        incf    0x53, F                                     ; reg: 0x0d3
        movf    0x70, W                                     ; reg: 0x0f0
        movlb   0x02
        movwf   0x61                                        ; reg: 0x161

label_424:                                                  ; address: 0x104c

        return
        clrf    0x53                                        ; reg: 0x053
        return
        movf    0x53, W                                     ; reg: 0x053
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    Common_RAM, W                               ; reg: 0x070
        movwf   INDF1                                       ; reg: 0x001
        incf    0x53, F                                     ; reg: 0x053
        movf    0x53, W                                     ; reg: 0x053

label_425:                                                  ; address: 0x1058

        movlb   0x02
        subwf   0x61, W                                     ; reg: 0x161
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        return
        movlb   0x00
        bsf     0x39, 0x7                                   ; reg: 0x039
        return

function_046:                                               ; address: 0x105f

        btfss   0x36, 0x1                                   ; reg: 0x036
        ljmp    label_217
        clrf    0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078

label_426:                                                  ; address: 0x1064

        ljmp    label_218
        movlb   0x02
        clrf    0x51                                        ; reg: 0x151
        btfss   0x79, 0x6                                   ; reg: 0x179
        ljmp    label_220
        movlb   0x00
        btfss   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_220

label_427:                                                  ; address: 0x106c

        movlw   0x0b
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        ljmp    label_223
        btfss   (Common_RAM + 9), 0x6                       ; reg: 0x079
        ljmp    label_221
        movlb   0x00
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_221
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_223
        movf    0x4d, F                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_219
        ljmp    label_223
        movlb   0x00
        btfsc   0x38, 0x6                                   ; reg: 0x038
        ljmp    label_222
        movf    (Common_RAM + 9), W                         ; reg: 0x079
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_223
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_223
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_223
        movlw   0x0b
        movwf   0x4f                                        ; reg: 0x04f

label_428:                                                  ; address: 0x108d

        movlw   0x02
        movwf   0x4d                                        ; reg: 0x04d
        movf    0x4b, F                                     ; reg: 0x04b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_224
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_225
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x08
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_225
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x09
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_225
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_225
        movlw   0x96
        movlb   0x01
        movwf   0x57                                        ; reg: 0x0d7
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_226
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_226
        movf    0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_226
        movlb   0x02
        clrf    0x50                                        ; reg: 0x150
        incf    0x50, F                                     ; reg: 0x150
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_227
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_229
        btfsc   0x38, 0x5                                   ; reg: 0x038
        btfss   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_229
        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_229
        bcf     0x41, 0x4                                   ; reg: 0x041
        movlw   0x0c
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_256
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_231
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x08
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_231
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x09
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_231
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_233
        movlb   0x01
        movf    0x57, F                                     ; reg: 0x0d7
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_233
        movlw   0x03
        movlb   0x00
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        ljmp    label_256
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_234
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_234
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_234
        movlw   0x0e
        ljmp    label_232
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x38, 0x5                                   ; reg: 0x038
        ljmp    label_237
        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_237
        movlb   0x02
        movf    0x50, F                                     ; reg: 0x150
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_237
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_256
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_256
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_228
        movlw   0x0c
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        movlw   0x1e
        movwf   0x34                                        ; reg: 0x034
        clrf    0x35                                        ; reg: 0x035
        ljmp    label_256

function_047:                                               ; address: 0x110b

        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_242
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_242
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_256
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_239
        movlw   0x0d
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_240
        movlw   0x08
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_256
        movlw   0x09
        ljmp    label_232
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_248
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_248
        movf    0x4b, W                                     ; reg: 0x04b
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_256
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_246
        movlw   0x0f
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_256
        bcf     0x3d, 0x5                                   ; reg: 0x03d
        bsf     0x43, 0x7                                   ; reg: 0x043
        ljmp    label_256
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_254
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        btfsc   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_250
        btfss   0x38, 0x5                                   ; reg: 0x038
        ljmp    label_254
        movlw   0x02
        subwf   0x4d, W                                     ; reg: 0x04d
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_252
        bsf     0x41, 0x4                                   ; reg: 0x041
        ljmp    label_253
        bcf     0x41, 0x4                                   ; reg: 0x041
        movlw   0x0c
        movwf   0x4f                                        ; reg: 0x04f
        movlw   0x05
        movwf   0x4d                                        ; reg: 0x04d
        ljmp    label_256
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x38, 0x6                                   ; reg: 0x038
        ljmp    label_256
        movlw   0x0c
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        incf    0x4d, F                                     ; reg: 0x04d
        bcf     0x41, 0x4                                   ; reg: 0x041
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x08
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_266
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_257
        movf    0x4b, F                                     ; reg: 0x04b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_266
        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_266
        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_266
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_259
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_259
        clrf    0x20                                        ; reg: 0x020
        ljmp    label_264
        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_261
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_261
        clrf    0x20                                        ; reg: 0x020
        incf    0x20, F                                     ; reg: 0x020
        ljmp    label_264
        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_265
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_265
        movlw   0x02
        movwf   0x20                                        ; reg: 0x020
        movlw   0x11
        ;movlp   0x04
        fcall    function_001
        ;movlp   0x10
        movlb   0x00
        incf    0x4d, F                                     ; reg: 0x04d
        fcall    function_048
        ;movlp   0x10
        movlb   0x00
        bsf     0x51, 0x4                                   ; reg: 0x051
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x09
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_434
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_429
        movf    0x4b, F                                     ; reg: 0x04b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_434
        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_434

label_429:                                                  ; address: 0x1190

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_434
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_430
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_430
        clrf    0x21                                        ; reg: 0x021
        ljmp    label_432

label_430:                                                  ; address: 0x1198

        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_431
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_431
        clrf    0x21                                        ; reg: 0x021
        incf    0x21, F                                     ; reg: 0x021
        ljmp    label_432

label_431:                                                  ; address: 0x119f

        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_433
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_433
        movlw   0x02
        movwf   0x21                                        ; reg: 0x021

label_432:                                                  ; address: 0x11a5

        movlw   0x12
        ;movlp   0x04
        fcall    function_001
        ;movlp   0x10
        movlb   0x00
        incf    0x4d, F                                     ; reg: 0x04d

label_433:                                                  ; address: 0x11ab

        fcall    function_048
        ;movlp   0x10
        movlb   0x00
        bsf     0x51, 0x4                                   ; reg: 0x051

label_434:                                                  ; address: 0x11af

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_440
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_435
        movf    0x4b, F                                     ; reg: 0x04b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_440
        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_440

label_435:                                                  ; address: 0x11bb

        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_440
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_436
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_436
        clrf    0x23                                        ; reg: 0x023
        ljmp    label_438

label_436:                                                  ; address: 0x11c3

        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_437
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_437
        clrf    0x23                                        ; reg: 0x023
        incf    0x23, F                                     ; reg: 0x023
        ljmp    label_438

label_437:                                                  ; address: 0x11ca

        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_439
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_439
        movlw   0x02
        movwf   0x23                                        ; reg: 0x023

label_438:                                                  ; address: 0x11d0

        movlw   0x10
        ;movlp   0x04
        fcall    function_001
        ;movlp   0x10
        movlb   0x00
        incf    0x4d, F                                     ; reg: 0x04d

label_439:                                                  ; address: 0x11d6

        fcall    function_048
        ;movlp   0x10
        movlb   0x00
        bsf     0x51, 0x4                                   ; reg: 0x051

label_440:                                                  ; address: 0x11da

        btfsc   (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_441
        btfss   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_442

label_441:                                                  ; address: 0x11de

        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_442
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_442
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_443
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_443

label_442:                                                  ; address: 0x11ec

        movlw   0x1e
        movlb   0x01
        movwf   0x5e                                        ; reg: 0x0de
        ljmp    label_444

label_443:                                                  ; address: 0x11f0

        movlb   0x01
        movf    0x5e, W                                     ; reg: 0x0de
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_444
        movlb   0x00
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_444
        movlb   0x01
        decfsz  0x5e, F                                     ; reg: 0x0de
        ljmp    label_444
        movlb   0x00
        bsf     0x3c, 0x7                                   ; reg: 0x03c

label_444:                                                  ; address: 0x11fc

        movlb   0x00
        btfss   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_445
        movlw   0x02
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xaa
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_445
        bcf     0x41, 0x4                                   ; reg: 0x041
        movlw   0x0b
        movwf   0x4f                                        ; reg: 0x04f
        movlw   0x02
        movwf   0x4d                                        ; reg: 0x04d
        ljmp    label_446

label_445:                                                  ; address: 0x120c

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_446
        movf    0x4d, W                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_446
        movlw   0x02
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xab
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_446
        bsf     0x41, 0x4                                   ; reg: 0x041
        movlw   0x03
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d

label_446:                                                  ; address: 0x1220

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_471
        movf    0x4d, F                                     ; reg: 0x04d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_455
        movlb   0x01
        bcf     0x41, 0x0                                   ; reg: 0x0c1
        movlb   0x00
        btfss   0x41, 0x4                                   ; reg: 0x041
        btfsc   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_471
        btfsc   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_447
        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_448

label_447:                                                  ; address: 0x1231

        decf    0x4b, W                                     ; reg: 0x04b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_450

label_448:                                                  ; address: 0x1234

        btfsc   0x53, 0x2                                   ; reg: 0x053
        ljmp    label_449
        btfss   0x53, 0x0                                   ; reg: 0x053
        ljmp    label_471

label_449:                                                  ; address: 0x1238

        btfss   0x40, 0x2                                   ; reg: 0x040
        ljmp    label_471

label_450:                                                  ; address: 0x123a

        bcf     0x3c, 0x7                                   ; reg: 0x03c
        btfsc   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_451
        btfsc   0x53, 0x2                                   ; reg: 0x053
        btfss   0x40, 0x2                                   ; reg: 0x040
        ljmp    label_453

label_451:                                                  ; address: 0x1240

        clrf    0x37                                        ; reg: 0x037

label_452:                                                  ; address: 0x1241

        incf    0x4d, F                                     ; reg: 0x04d
        ljmp    label_471

label_453:                                                  ; address: 0x1243

        btfsc   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_454
        btfsc   0x53, 0x0                                   ; reg: 0x053
        btfss   0x40, 0x2                                   ; reg: 0x040
        ljmp    label_471

label_454:                                                  ; address: 0x1248

        clrf    0x37                                        ; reg: 0x037
        incf    0x37, F                                     ; reg: 0x037
        ljmp    label_452

label_455:                                                  ; address: 0x124b

        movlw   0x07
        subwf   0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_466
        movf    (Common_RAM + 9), W                         ; reg: 0x079
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfsc   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_456
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_456
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x05
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_456
        movlw   0x07
        movwf   0x4d                                        ; reg: 0x04d

label_456:                                                  ; address: 0x125d

        btfsc   (Common_RAM + 8), 0x0                       ; reg: 0x078
        ljmp    label_457
        btfss   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_458

label_457:                                                  ; address: 0x1261

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_458
        movlb   0x01
        bsf     0x41, 0x0                                   ; reg: 0x0c1
        movlw   0x06
        movlb   0x00
        movwf   0x4d                                        ; reg: 0x04d
        ljmp    label_471

label_458:                                                  ; address: 0x126b

        btfss   (Common_RAM + 8), 0x0                       ; reg: 0x078
        btfsc   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_471
        btfss   0x3c, 0x7                                   ; reg: 0x03c
        ljmp    label_471
        bcf     0x3c, 0x7                                   ; reg: 0x03c
        fcall    function_049
        ;movlp   0x10
        movf    0x37, F                                     ; reg: 0x037
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_462
        movlw   0x00
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0x41
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_459
        movlw   0x41
        movlb   0x02
        movwf   0x21                                        ; reg: 0x121
        clrf    0x22                                        ; reg: 0x122
        ljmp    label_461

label_459:                                                  ; address: 0x1282

        movlw   0x02
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0xbd
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_460
        movlw   0xbc
        movlb   0x02
        movwf   0x21                                        ; reg: 0x121
        movlw   0x02
        movwf   0x22                                        ; reg: 0x122
        ljmp    label_461

label_460:                                                  ; address: 0x128f

        movf    0x31, W                                     ; reg: 0x031
        movlb   0x02
        movwf   0x22                                        ; reg: 0x122
        movlb   0x00
        movf    0x30, W                                     ; reg: 0x030
        movlb   0x02
        movwf   0x21                                        ; reg: 0x121

label_461:                                                  ; address: 0x1296

        movlw   0x05
        ;movlp   0x04
        fcall    function_001
        ;movlp   0x10
        ljmp    label_471

label_462:                                                  ; address: 0x129b

        decfsz  0x37, W                                     ; reg: 0x037
        ljmp    label_471
        movlw   0x00
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0x41
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_463
        movlw   0x41
        movlb   0x02
        movwf   0x23                                        ; reg: 0x123
        clrf    0x24                                        ; reg: 0x124
        ljmp    label_465

label_463:                                                  ; address: 0x12a9

        movlw   0x02
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0xbd
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_464
        movlw   0xbc
        movlb   0x02
        movwf   0x23                                        ; reg: 0x123
        movlw   0x02
        movwf   0x24                                        ; reg: 0x124
        ljmp    label_465

label_464:                                                  ; address: 0x12b6

        movf    0x31, W                                     ; reg: 0x031
        movlb   0x02
        movwf   0x24                                        ; reg: 0x124
        movlb   0x00
        movf    0x30, W                                     ; reg: 0x030
        movlb   0x02
        movwf   0x23                                        ; reg: 0x123

label_465:                                                  ; address: 0x12bd

        movlw   0x06
        ;movlp   0x04
        fcall    function_001
        ;movlp   0x10
        ljmp    label_471

label_466:                                                  ; address: 0x12c2

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x05
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_468
        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_471

label_467:                                                  ; address: 0x12c8

        bsf     0x3e, 0x3                                   ; reg: 0x03e
        ljmp    label_471

label_468:                                                  ; address: 0x12ca

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_469
        btfss   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_467
        ljmp    label_471

label_469:                                                  ; address: 0x12d1

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x09
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_471
        movlw   0x00
        subwf   0x31, W                                     ; reg: 0x031
        movlw   0x41
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x30, W                                     ; reg: 0x030
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_470
        movlb   0x01
        btfss   0x41, 0x0                                   ; reg: 0x0c1
        ljmp    label_471

label_470:                                                  ; address: 0x12df

        movlb   0x00
        bsf     0x3b, 0x4                                   ; reg: 0x03b

label_471:                                                  ; address: 0x12e1

        btfsc   (Common_RAM + 8), 0x5                       ; reg: 0x078
        btfss   (Common_RAM + 8), 0x3                       ; reg: 0x078
        ljmp    label_472
        movlb   0x00
        movf    0x4b, W                                     ; reg: 0x04b
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_472
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        movf    0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_473

label_472:                                                  ; address: 0x12ef

        movlw   0x32
        movlb   0x01
        movwf   0x56                                        ; reg: 0x0d6
        ljmp    label_474

label_473:                                                  ; address: 0x12f3

        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_474
        movlb   0x01
        movf    0x56, W                                     ; reg: 0x0d6
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_474
        decfsz  0x56, F                                     ; reg: 0x056
        ljmp    label_474
        movlw   0x3c
        movlb   0x00
        movwf   0x34                                        ; reg: 0x034
        clrf    0x35                                        ; reg: 0x035
        movlw   0x05
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d
        clrf    0x4e                                        ; reg: 0x04e

label_474:                                                  ; address: 0x1303

        movlb   0x00
        btfss   0x43, 0x7                                   ; reg: 0x043
        ljmp    label_477
        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_475
        movlw   0x23
        movlb   0x01
        movwf   0x46                                        ; reg: 0x0c6
        movlw   0x04
        movlb   0x02
        movwf   0x59                                        ; reg: 0x159
        ljmp    label_476

label_475:                                                  ; address: 0x130f

        movlb   0x01
        clrf    0x46                                        ; reg: 0x0c6
        movlb   0x02
        clrf    0x59                                        ; reg: 0x159

label_476:                                                  ; address: 0x1313

        movlw   0x02
        movlb   0x00
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d

label_477:                                                  ; address: 0x1317

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_483
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_478
        bsf     0x3c, 0x6                                   ; reg: 0x03c

label_478:                                                  ; address: 0x1320

        movf    0x4d, F                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   (Common_RAM + 8), 0x6                       ; reg: 0x078
        ljmp    label_479
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_479
        incf    0x4d, F                                     ; reg: 0x04d
        clrf    0x30                                        ; reg: 0x030
        clrf    0x31                                        ; reg: 0x031
        ljmp    label_482

label_479:                                                  ; address: 0x132a

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x09
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_480
        movlb   0x01
        movf    0x46, W                                     ; reg: 0x0c6
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_480
        movlb   0x00
        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_480
        movlb   0x01
        decf    0x46, F                                     ; reg: 0x0c6
        movlw   0x07
        ljmp    label_481

label_480:                                                  ; address: 0x1339

        movlb   0x00
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_482
        movlb   0x02
        movf    0x59, W                                     ; reg: 0x159
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_482
        movlb   0x00
        btfsc   0x3d, 0x5                                   ; reg: 0x03d
        ljmp    label_482
        movlb   0x02
        decf    0x59, F                                     ; reg: 0x159
        movlw   0x09

label_481:                                                  ; address: 0x1348

        movlb   0x00
        movwf   0x4d                                        ; reg: 0x04d

label_482:                                                  ; address: 0x134a

        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_483
        movlb   0x00
        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_483
        incf    0x4d, F                                     ; reg: 0x04d
        clrf    0x30                                        ; reg: 0x030
        clrf    0x31                                        ; reg: 0x031

label_483:                                                  ; address: 0x1352

        clrf    (Common_RAM + 5)                            ; reg: 0x075
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_484
        clrf    (Common_RAM + 5)                            ; reg: 0x075
        incf    (Common_RAM + 5), F                         ; reg: 0x075
        movlw   0x64
        ljmp    label_491

label_484:                                                  ; address: 0x135c

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_486
        clrf    (Common_RAM + 5)                            ; reg: 0x075
        incf    (Common_RAM + 5), F                         ; reg: 0x075
        btfss   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_485
        movlw   0x50
        movlb   0x03
        movwf   0x47                                        ; reg: 0x1c7
        clrf    0x48                                        ; reg: 0x1c8
        movlw   0x32
        ljmp    label_500

label_485:                                                  ; address: 0x136a

        movlw   0x0a
        movlb   0x03
        movwf   0x47                                        ; reg: 0x1c7
        clrf    0x48                                        ; reg: 0x1c8
        movlw   0x04
        ljmp    label_500

label_486:                                                  ; address: 0x1370

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_502
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_502
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_502
        clrf    (Common_RAM + 5)                            ; reg: 0x075
        incf    (Common_RAM + 5), F                         ; reg: 0x075
        ljmp    label_501

label_487:                                                  ; address: 0x137f

        movlb   0x00
        btfss   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_488
        movlw   0x1a
        ljmp    label_497

label_488:                                                  ; address: 0x1384

        movlw   0x21
        ljmp    label_499

label_489:                                                  ; address: 0x1386

        movlb   0x00
        btfss   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_490
        movlw   0x50
        movlb   0x03
        movwf   0x47                                        ; reg: 0x1c7
        clrf    0x48                                        ; reg: 0x1c8
        movlw   0x06
        ljmp    label_500

label_490:                                                  ; address: 0x138f

        movlw   0x60

label_491:                                                  ; address: 0x1390

        movlb   0x03
        movwf   0x47                                        ; reg: 0x1c7
        clrf    0x48                                        ; reg: 0x1c8
        movlw   0x08
        ljmp    label_500

label_492:                                                  ; address: 0x1395

        movlb   0x00
        btfss   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_493
        movlw   0x32
        ljmp    label_497

label_493:                                                  ; address: 0x139a

        movlw   0x3b
        ljmp    label_499

label_494:                                                  ; address: 0x139c

        movlb   0x00
        btfss   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_495
        movlw   0x50
        ljmp    label_497

label_495:                                                  ; address: 0x13a1

        movlw   0x59
        ljmp    label_499

label_496:                                                  ; address: 0x13a3

        movlb   0x00
        btfss   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_498
        movlw   0x12

label_497:                                                  ; address: 0x13a7

        movlb   0x03
        movwf   0x47                                        ; reg: 0x1c7
        clrf    0x48                                        ; reg: 0x1c8
        movlw   0x0c
        ljmp    label_500

label_498:                                                  ; address: 0x13ac

        movlw   0x17

label_499:                                                  ; address: 0x13ad

        movlb   0x03
        movwf   0x47                                        ; reg: 0x1c7
        clrf    0x48                                        ; reg: 0x1c8
        movlw   0x0f

label_500:                                                  ; address: 0x13b1

        movwf   0x4d                                        ; reg: 0x04d
        clrf    0x4e                                        ; reg: 0x04e
        ljmp    label_502

label_501:                                                  ; address: 0x13b4

        movlb   0x02
        movf    0x58, W                                     ; reg: 0x158
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_487
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_489
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_492
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_494
        xorlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_496
        movlw   0x03
        movlb   0x00
        movwf   0x4f                                        ; reg: 0x04f
        clrf    0x4d                                        ; reg: 0x04d

label_502:                                                  ; address: 0x13c9

        bcf     GIE                                 ; reg: 0x00b, bit: 7
        decfsz  (Common_RAM + 5), W                         ; reg: 0x075
        ljmp    label_503
        movlb   0x00
        bsf     0x3b, 0x7                                   ; reg: 0x03b
        ljmp    label_504

label_503:                                                  ; address: 0x13cf

        movlb   0x00
        bcf     0x3b, 0x7                                   ; reg: 0x03b

label_504:                                                  ; address: 0x13d1

        movlb   0x03
        movf    0x48, W                                     ; reg: 0x1c8
        movlb   0x01
        movwf   0x38                                        ; reg: 0x0b8
        movlb   0x03
        movf    0x47, W                                     ; reg: 0x1c7
        movlb   0x01
        movwf   0x37                                        ; reg: 0x0b7
        movlb   0x03
        movf    0x4e, W                                     ; reg: 0x1ce
        movwf   0x4c                                        ; reg: 0x1cc
        movf    0x4d, W                                     ; reg: 0x1cd
        movwf   0x4b                                        ; reg: 0x1cb
        bsf     GIE                                 ; reg: 0x00b, bit: 7
        movlb   0x00
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        ljmp    label_505
        movlb   0x01
        movf    0x5c, W                                     ; reg: 0x0dc
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_505
        decfsz  0x5c, F                                     ; reg: 0x05c
        ljmp    label_505
        movlb   0x00
        bsf     0x51, 0x4                                   ; reg: 0x051

label_505:                                                  ; address: 0x13ea

        movlb   0x00
        movf    0x5b, F                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        clrf    0x50                                        ; reg: 0x050
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        movf    0x4d, W                                     ; reg: 0x04d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_506
        movlw   0xa0
        movlb   0x02
        movwf   0x43                                        ; reg: 0x143
        movlw   0x0f
        movwf   0x44                                        ; reg: 0x144

label_506:                                                  ; address: 0x13f9

        movlb   0x00
        movf    0x58, W                                     ; reg: 0x058
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlw   0xc8
        movlb   0x01
        movwf   0x4c                                        ; reg: 0x0cc
        movlb   0x00
        bcf     0x3b, 0x3                                   ; reg: 0x03b
        bcf     0x3b, 0x0                                   ; reg: 0x03b
        return

function_048:                                               ; address: 0x1404

        movf    0x20, W                                     ; reg: 0x020
        movlb   0x03
        movwf   0x53                                        ; reg: 0x1d3
        movlb   0x00
        movf    0x21, W                                     ; reg: 0x021
        movlb   0x03
        movwf   0x54                                        ; reg: 0x1d4
        movlb   0x00
        movf    0x22, W                                     ; reg: 0x022
        movlb   0x03
        movwf   0x55                                        ; reg: 0x1d5
        movlb   0x00
        movf    0x23, W                                     ; reg: 0x023
        movlb   0x03
        movwf   0x56                                        ; reg: 0x1d6
        return

function_049:                                               ; address: 0x1414

        movlw   0x05
        movlb   0x01
        movwf   0x58                                        ; reg: 0x0d8
        movlw   0x07
        movlb   0x00
        movwf   0x4d                                        ; reg: 0x04d
        return

function_050:                                               ; address: 0x141b

        movlw   0xa0
        movlb   0x03
        movwf   0x20                                        ; reg: 0x1a0
        movlw   0x0e
        movwf   0x21                                        ; reg: 0x1a1
        movlw   0xf0
        movwf   0x22                                        ; reg: 0x1a2
        movlw   0x0f
        movwf   0x23                                        ; reg: 0x1a3
        clrf    0x75                                        ; reg: 0x1f5

label_507:                                                  ; address: 0x1425

        movf    (Common_RAM + 5), W                         ; reg: 0x075
        addlw   0xa4
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        addlw   0x20
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0x02
        movwf   FSR0H                                       ; reg: 0x005
        movf    INDF0, W                                    ; reg: 0x000
        movwf   INDF1                                       ; reg: 0x001
        incf    (Common_RAM + 5), F                         ; reg: 0x075
        movlw   0x0a
        subwf   (Common_RAM + 5), W                         ; reg: 0x075
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_507
        movlb   0x03
        movf    0x21, W                                     ; reg: 0x1a1
        fcall    function_052
        ;movlp   0x14
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        fcall    function_060
        ;movlp   0x14
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        movwf   INDF1                                       ; reg: 0x001
        ljmp    label_568

function_051:                                               ; address: 0x1440

        movlb   0x00
        btfss   0x39, 0x7                                   ; reg: 0x039
        return
        movlb   0x03
        movf    0x21, W                                     ; reg: 0x1a1
        fcall    function_052
        ;movlp   0x14
        movwf   0x6b                                        ; reg: 0x06b
        fcall    function_060
        ;movlp   0x14
        movf    INDF1, W                                    ; reg: 0x001
        movlb   0x00
        xorwf   0x6b, W                                     ; reg: 0x06b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x03
        movf    0x23, W                                     ; reg: 0x1a3
        movlb   0x00
        movwf   0x54                                        ; reg: 0x054
        ljmp    label_518

label_508:                                                  ; address: 0x1454

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x04
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519

label_509:                                                  ; address: 0x145d

        fcall    function_053
        ;movlp   0x14
        ljmp    label_519

label_510:                                                  ; address: 0x1460

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x04
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519

label_511:                                                  ; address: 0x1469

        fcall    function_055
        ;movlp   0x14
        ljmp    label_519

label_512:                                                  ; address: 0x146c

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x05
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlw   0x02
        movlb   0x02
        movwf   0x6a                                        ; reg: 0x16a
        movlb   0x03
        movf    0x24, W                                     ; reg: 0x1a4
        movlb   0x00
        movwf   0x53                                        ; reg: 0x053
        ljmp    label_509

label_513:                                                  ; address: 0x147d

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x09
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlw   0x02
        movwf   0x5b                                        ; reg: 0x05b
        movlw   0x03
        movwf   0x50                                        ; reg: 0x050
        movlb   0x03
        movf    0x24, W                                     ; reg: 0x1a4
        movlb   0x00
        movwf   0x44                                        ; reg: 0x044
        movlb   0x03
        movf    0x25, W                                     ; reg: 0x1a5
        movlb   0x01
        movwf   0x43                                        ; reg: 0x0c3
        movlb   0x03
        movf    0x26, W                                     ; reg: 0x1a6
        movlb   0x02
        movwf   0x52                                        ; reg: 0x152
        movlb   0x03
        movf    0x27, W                                     ; reg: 0x1a7
        movlb   0x02
        movwf   0x53                                        ; reg: 0x153
        movlb   0x03
        movf    0x28, W                                     ; reg: 0x1a8
        movlb   0x02
        movwf   0x54                                        ; reg: 0x154
        movlw   0x02
        movlb   0x00
        xorwf   0x39, F                                     ; reg: 0x039
        btfsc   0x39, 0x1                                   ; reg: 0x039
        ljmp    label_509
        ljmp    label_511

label_514:                                                  ; address: 0x14a4

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x07
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_515
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0xf0
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519

label_515:                                                  ; address: 0x14b1

        fcall    function_056
        ;movlp   0x14
        ljmp    label_519

label_516:                                                  ; address: 0x14b4

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x0a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        fcall    function_058
        ;movlp   0x14
        ljmp    label_519

label_517:                                                  ; address: 0x14c0

        movf    0x21, W                                     ; reg: 0x021
        xorlw   0x04
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        movlb   0x00
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_519
        fcall    function_050
        ;movlp   0x14
        ljmp    label_519

label_518:                                                  ; address: 0x14cc

        movlb   0x03
        movf    0x22, W                                     ; reg: 0x1a2
        xorlw   0x60
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_508
        xorlw   0x10
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_510
        xorlw   0xf0
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_513
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_512
        xorlw   0x12
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_516
        xorlw   0x05
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_514
        xorlw   0x65
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_517

label_519:                                                  ; address: 0x14e3

        movlb   0x01
        clrf    0x53                                        ; reg: 0x0d3
        movlb   0x00
        bcf     0x39, 0x7                                   ; reg: 0x039
        return

function_052:                                               ; address: 0x14e8

        movlb   0x00
        movwf   0x5d                                        ; reg: 0x05d
        movlw   0x55
        movwf   0x5e                                        ; reg: 0x05e
        clrf    0x5f                                        ; reg: 0x05f

label_520:                                                  ; address: 0x14ed

        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x5f, W                                     ; reg: 0x05f
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_521
        movf    0x5f, W                                     ; reg: 0x05f
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    INDF1, W                                    ; reg: 0x001
        xorwf   0x5e, F                                     ; reg: 0x05e
        incf    0x5f, F                                     ; reg: 0x05f
        ljmp    label_520

label_521:                                                  ; address: 0x14fa

        movf    0x5e, W                                     ; reg: 0x05e
        return

function_053:                                               ; address: 0x14fc

        clrf    (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xa0
        movlb   0x03
        movwf   0x20                                        ; reg: 0x1a0
        movlw   0x13
        movwf   0x21                                        ; reg: 0x1a1
        movlw   0x60
        movwf   0x22                                        ; reg: 0x1a2
        movlw   0x0f
        movwf   0x23                                        ; reg: 0x1a3
        fcall    function_054
        ;movlp   0x14
        movf    0x4c, W                                     ; reg: 0x04c
        movlb   0x03
        movwf   0x24                                        ; reg: 0x1a4
        movlb   0x00
        btfsc   0x3c, 0x7                                   ; reg: 0x03c
        bsf     (Common_RAM + 4), 0x0                       ; reg: 0x074
        movlb   0x01
        btfsc   0x41, 0x0                                   ; reg: 0x0c1
        bsf     0x74, 0x1                                   ; reg: 0x0f4
        movlb   0x00
        btfsc   0x36, 0x6                                   ; reg: 0x036
        bsf     (Common_RAM + 4), 0x2                       ; reg: 0x074
        btfsc   0x43, 0x7                                   ; reg: 0x043
        bsf     (Common_RAM + 4), 0x3                       ; reg: 0x074
        btfsc   0x36, 0x2                                   ; reg: 0x036
        bsf     (Common_RAM + 4), 0x4                       ; reg: 0x074
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        movlb   0x03
        movwf   0x25                                        ; reg: 0x1a5
        clrf    0x26                                        ; reg: 0x1a6
        clrf    0x27                                        ; reg: 0x1a7
        clrf    0x28                                        ; reg: 0x1a8
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        movlb   0x03
        movwf   0x29                                        ; reg: 0x1a9
        movlb   0x00
        movf    0x4d, W                                     ; reg: 0x04d
        movlb   0x03
        movwf   0x2a                                        ; reg: 0x1aa
        movlb   0x01
        movf    0x3a, W                                     ; reg: 0x0ba
        movwf   0x77                                        ; reg: 0x0f7
        movf    0x39, W                                     ; reg: 0x0b9
        movwf   0x76                                        ; reg: 0x0f6
        movf    0x77, W                                     ; reg: 0x0f7
        movlb   0x03
        movwf   0x2b                                        ; reg: 0x1ab
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x2c                                        ; reg: 0x1ac
        movlb   0x00
        movf    0x31, W                                     ; reg: 0x031
        movwf   (Common_RAM + 7)                            ; reg: 0x077
        movf    0x30, W                                     ; reg: 0x030
        movwf   (Common_RAM + 6)                            ; reg: 0x076
        movf    (Common_RAM + 7), W                         ; reg: 0x077
        movlb   0x03
        movwf   0x2d                                        ; reg: 0x1ad
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x2e                                        ; reg: 0x1ae
        movlb   0x00
        movf    0x2b, W                                     ; reg: 0x02b
        movwf   (Common_RAM + 7)                            ; reg: 0x077
        movf    0x2a, W                                     ; reg: 0x02a
        movwf   (Common_RAM + 6)                            ; reg: 0x076
        movf    (Common_RAM + 7), W                         ; reg: 0x077
        movlb   0x03
        movwf   0x2f                                        ; reg: 0x1af
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x30                                        ; reg: 0x1b0
        movf    0x50, W                                     ; reg: 0x1d0
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x4f, W                                     ; reg: 0x1cf
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movwf   0x31                                        ; reg: 0x1b1
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x32                                        ; reg: 0x1b2
        movf    0x21, W                                     ; reg: 0x1a1
        fcall    function_052
        ;movlp   0x14
        movlb   0x03
        movwf   0x33                                        ; reg: 0x1b3
        ljmp    label_568

function_054:                                               ; address: 0x1552

        movlb   0x02
        clrf    0x4c                                        ; reg: 0x14c
        btfsc   0x78, 0x3                                   ; reg: 0x178
        bsf     0x4c, 0x0                                   ; reg: 0x14c
        btfsc   0x78, 0x0                                   ; reg: 0x178
        bsf     0x4c, 0x1                                   ; reg: 0x14c
        btfsc   0x78, 0x5                                   ; reg: 0x178
        bsf     0x4c, 0x4                                   ; reg: 0x14c
        btfsc   0x78, 0x6                                   ; reg: 0x178
        bsf     0x4c, 0x5                                   ; reg: 0x14c
        btfsc   0x78, 0x7                                   ; reg: 0x178
        bsf     0x4c, 0x6                                   ; reg: 0x14c
        return

function_055:                                               ; address: 0x155f

        movlb   0x00
        clrf    0x60                                        ; reg: 0x060
        clrf    0x61                                        ; reg: 0x061
        clrf    0x62                                        ; reg: 0x062
        movlw   0xa0
        movlb   0x03
        movwf   0x20                                        ; reg: 0x1a0
        movlw   0x10
        movwf   0x21                                        ; reg: 0x1a1
        movlw   0x70
        movwf   0x22                                        ; reg: 0x1a2
        movlw   0x0f
        movwf   0x23                                        ; reg: 0x1a3
        movlb   0x00
        btfsc   0x36, 0x7                                   ; reg: 0x036
        bsf     0x62, 0x0                                   ; reg: 0x062
        btfsc   0x36, 0x6                                   ; reg: 0x036
        bsf     0x62, 0x2                                   ; reg: 0x062
        btfsc   0x36, 0x2                                   ; reg: 0x036
        bsf     0x62, 0x4                                   ; reg: 0x062
        btfsc   0x36, 0x1                                   ; reg: 0x036
        bsf     0x62, 0x6                                   ; reg: 0x062
        btfsc   0x36, 0x3                                   ; reg: 0x036
        bsf     0x62, 0x7                                   ; reg: 0x062
        movf    0x62, W                                     ; reg: 0x062
        movlb   0x03
        movwf   0x24                                        ; reg: 0x1a4
        clrf    0x25                                        ; reg: 0x1a5
        movlb   0x00
        btfsc   0x43, 0x2                                   ; reg: 0x043
        bsf     0x60, 0x2                                   ; reg: 0x060
        btfsc   0x43, 0x0                                   ; reg: 0x043
        bsf     0x60, 0x0                                   ; reg: 0x060
        btfsc   0x42, 0x2                                   ; reg: 0x042
        bsf     0x61, 0x2                                   ; reg: 0x061
        btfsc   0x42, 0x3                                   ; reg: 0x042
        bsf     0x61, 0x3                                   ; reg: 0x061
        btfsc   0x42, 0x4                                   ; reg: 0x042
        bsf     0x61, 0x4                                   ; reg: 0x061
        btfsc   0x42, 0x5                                   ; reg: 0x042
        bsf     0x61, 0x5                                   ; reg: 0x061
        movf    0x60, W                                     ; reg: 0x060
        movlb   0x03
        movwf   0x26                                        ; reg: 0x1a6
        movlb   0x00
        movf    0x61, W                                     ; reg: 0x061
        movlb   0x03
        movwf   0x27                                        ; reg: 0x1a7
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        movlb   0x03
        movwf   0x28                                        ; reg: 0x1a8
        movlb   0x00
        movf    0x4d, W                                     ; reg: 0x04d
        movlb   0x03
        movwf   0x29                                        ; reg: 0x1a9
        movlb   0x02
        movf    0x56, W                                     ; reg: 0x156
        movlb   0x03
        movwf   0x2a                                        ; reg: 0x1aa
        clrf    0x2b                                        ; reg: 0x1ab
        movlb   0x02
        movf    0x5a, W                                     ; reg: 0x15a
        movlb   0x03
        movwf   0x2c                                        ; reg: 0x1ac
        clrf    0x2d                                        ; reg: 0x1ad
        clrf    0x2e                                        ; reg: 0x1ae
        movlw   0x0b
        movwf   0x2f                                        ; reg: 0x1af
        movf    0x21, W                                     ; reg: 0x1a1
        fcall    function_052
        ;movlp   0x14
        movlb   0x03
        movwf   0x30                                        ; reg: 0x1b0
        ljmp    label_568

function_056:                                               ; address: 0x15aa

        movlb   0x03
        movf    0x26, W                                     ; reg: 0x1a6
        movlb   0x00
        movwf   0x65                                        ; reg: 0x065
        fcall    function_061
        ;movlp   0x14
        movlw   0xa0
        movwf   0x20                                        ; reg: 0x020
        movlw   0x06
        movwf   0x21                                        ; reg: 0x021
        movlw   0x95
        movwf   0x22                                        ; reg: 0x022
        movlw   0x0f
        movwf   0x23                                        ; reg: 0x023
        movlb   0x00
        clrf    0x6a                                        ; reg: 0x06a

label_522:                                                  ; address: 0x15ba

        movf    0x65, W                                     ; reg: 0x065
        subwf   0x6a, W                                     ; reg: 0x06a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_523
        movlw   0x04
        movlb   0x03
        addwf   0x21, F                                     ; reg: 0x1a1
        movlb   0x00
        movf    0x6a, W                                     ; reg: 0x06a
        movwf   0x5d                                        ; reg: 0x05d
        clrf    0x5e                                        ; reg: 0x05e
        movf    (Common_RAM + 6), W                         ; reg: 0x076
        addwf   0x5d, F                                     ; reg: 0x05d
        movf    (Common_RAM + 7), W                         ; reg: 0x077
        addwfc  0x5e, F                                     ; reg: 0x05e
        fcall    function_057
        ;movlp   0x14
        movf    0x60, W                                     ; reg: 0x060
        movwf   0x69                                        ; reg: 0x069
        movf    0x5f, W                                     ; reg: 0x05f
        movwf   0x68                                        ; reg: 0x068
        movf    0x5e, W                                     ; reg: 0x05e
        movwf   0x67                                        ; reg: 0x067
        movf    0x5d, W                                     ; reg: 0x05d
        movwf   0x66                                        ; reg: 0x066
        movf    0x6a, W                                     ; reg: 0x06a
        addwf   WREG, W                                     ; reg: 0x009
        addwf   WREG, W                                     ; reg: 0x009
        addlw   0xa6
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    0x69, W                                     ; reg: 0x069
        movwf   INDF1                                       ; reg: 0x001
        movf    0x6a, W                                     ; reg: 0x06a
        addwf   WREG, W                                     ; reg: 0x009
        addwf   WREG, W                                     ; reg: 0x009
        addlw   0xa7
        movwf   FSR1L                                       ; reg: 0x006
        movf    0x68, W                                     ; reg: 0x068
        movwf   INDF1                                       ; reg: 0x001
        movf    0x6a, W                                     ; reg: 0x06a
        addwf   WREG, W                                     ; reg: 0x009
        addwf   WREG, W                                     ; reg: 0x009
        addlw   0xa8
        movwf   FSR1L                                       ; reg: 0x006
        movf    0x67, W                                     ; reg: 0x067
        movwf   INDF1                                       ; reg: 0x001
        movf    0x6a, W                                     ; reg: 0x06a
        addwf   WREG, W                                     ; reg: 0x009
        addwf   WREG, W                                     ; reg: 0x009
        addlw   0xa9
        movwf   FSR1L                                       ; reg: 0x006
        movf    0x66, W                                     ; reg: 0x066
        movwf   INDF1                                       ; reg: 0x001
        incf    0x6a, F                                     ; reg: 0x06a
        ljmp    label_522

label_523:                                                  ; address: 0x15f3

        movlb   0x03
        movf    0x21, W                                     ; reg: 0x1a1
        fcall    function_052
        ;movlp   0x14
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        fcall    function_060
        ;movlp   0x14
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        movwf   INDF1                                       ; reg: 0x001
        ljmp    label_568

function_057:                                               ; address: 0x15fd

        clrf    0x61                                        ; reg: 0x061
        clrf    0x62                                        ; reg: 0x062
        clrf    0x63                                        ; reg: 0x063
        clrf    0x64                                        ; reg: 0x064
        movf    0x54, W                                     ; reg: 0x054
        xorlw   0x0f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_553
        movlw   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_529
        movf    0x5e, W                                     ; reg: 0x05e
        iorwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_524
        movlb   0x02
        movf    0x20, W                                     ; reg: 0x120
        ljmp    label_537

label_524:                                                  ; address: 0x1613

        decf    0x5d, W                                     ; reg: 0x05d
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_525
        movlb   0x02
        movf    0x21, W                                     ; reg: 0x121
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        movlb   0x02
        movf    0x22, W                                     ; reg: 0x122
        ljmp    label_542

label_525:                                                  ; address: 0x161e

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x02
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_526
        movlb   0x02
        movf    0x23, W                                     ; reg: 0x123
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        movlb   0x02
        movf    0x24, W                                     ; reg: 0x124
        ljmp    label_542

label_526:                                                  ; address: 0x162a

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x03
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_528

label_527:                                                  ; address: 0x162f

        clrf    0x61                                        ; reg: 0x061
        ljmp    label_551

label_528:                                                  ; address: 0x1631

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x04
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_527
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x05
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_527
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x06
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_527
        ljmp    label_553

label_529:                                                  ; address: 0x1641

        movlw   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x32
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        movlw   0x00
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_534
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x36
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_533
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x32
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_530
        movf    0x20, W                                     ; reg: 0x020
        ljmp    label_550

label_530:                                                  ; address: 0x1656

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x33
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_531
        movf    0x21, W                                     ; reg: 0x021
        ljmp    label_550

label_531:                                                  ; address: 0x165d

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x34
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_532
        movf    0x22, W                                     ; reg: 0x022
        ljmp    label_550

label_532:                                                  ; address: 0x1664

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x35
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_553
        movf    0x23, W                                     ; reg: 0x023
        ljmp    label_550

label_533:                                                  ; address: 0x166b

        movlw   0x00

label_534:                                                  ; address: 0x166c

        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x64
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        movlw   0x00
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_546
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x6c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_545
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x64
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_535
        movlb   0x01
        movf    0x23, W                                     ; reg: 0x0a3
        movlb   0x00
        movwf   0x64                                        ; reg: 0x064
        movlb   0x01
        movf    0x22, W                                     ; reg: 0x0a2
        movlb   0x00
        movwf   0x63                                        ; reg: 0x063
        movlb   0x01
        movf    0x21, W                                     ; reg: 0x0a1
        movlb   0x00
        movwf   0x62                                        ; reg: 0x062
        movlb   0x01
        movf    0x20, W                                     ; reg: 0x0a0
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        ljmp    label_553

label_535:                                                  ; address: 0x168f

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x65
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_536
        movlb   0x01
        movf    0x28, W                                     ; reg: 0x0a8
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        movlb   0x01
        movf    0x29, W                                     ; reg: 0x0a9
        ljmp    label_542

label_536:                                                  ; address: 0x169b

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x66
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_538
        movlb   0x01
        movf    0x2a, W                                     ; reg: 0x0aa

label_537:                                                  ; address: 0x16a2

        movlb   0x00
        ljmp    label_550

label_538:                                                  ; address: 0x16a4

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x67
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_539
        movlw   0x0b
        ljmp    label_544

label_539:                                                  ; address: 0x16ab

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x68
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_540
        movlw   0x0f
        ljmp    label_544

label_540:                                                  ; address: 0x16b2

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x69
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_541
        movlb   0x01
        movf    0x33, W                                     ; reg: 0x0b3
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        movlb   0x01
        movf    0x34, W                                     ; reg: 0x0b4
        ljmp    label_542

label_541:                                                  ; address: 0x16be

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x6a
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_543
        movlb   0x01
        movf    0x35, W                                     ; reg: 0x0b5
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        movlb   0x01
        movf    0x36, W                                     ; reg: 0x0b6

label_542:                                                  ; address: 0x16c9

        movlb   0x00
        movwf   0x62                                        ; reg: 0x062
        ljmp    label_552

label_543:                                                  ; address: 0x16cc

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x6b
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_553
        movlw   0x04

label_544:                                                  ; address: 0x16d2

        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        clrf    FSR1H                                       ; reg: 0x007
        moviw   0[FSR1]
        movwf   0x61                                        ; reg: 0x061
        moviw   1[FSR1] 
        movwf   0x62                                        ; reg: 0x062
        moviw   2[FSR1] 
        movwf   0x63                                        ; reg: 0x063
        moviw   3[FSR1] 
        movwf   0x64                                        ; reg: 0x064
        ljmp    label_553

label_545:                                                  ; address: 0x16de

        movlw   0x00

label_546:                                                  ; address: 0x16df

        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0xc8
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_553
        movlw   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0xcc
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_553
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0xc8
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_547
        movlw   0x0b
        ljmp    label_550

label_547:                                                  ; address: 0x16f3

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0xc9
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_548
        movlw   0x1e
        ljmp    label_550

label_548:                                                  ; address: 0x16fa

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0xca
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_549
        movlw   0x08
        ljmp    label_550

label_549:                                                  ; address: 0x1701

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0xcb
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_553
        movlw   0x0d

label_550:                                                  ; address: 0x1707

        movwf   0x61                                        ; reg: 0x061

label_551:                                                  ; address: 0x1708

        clrf    0x62                                        ; reg: 0x062

label_552:                                                  ; address: 0x1709

        clrf    0x63                                        ; reg: 0x063
        clrf    0x64                                        ; reg: 0x064

label_553:                                                  ; address: 0x170b

        movf    0x64, W                                     ; reg: 0x064
        movwf   0x60                                        ; reg: 0x060
        movf    0x63, W                                     ; reg: 0x063
        movwf   0x5f                                        ; reg: 0x05f
        movf    0x62, W                                     ; reg: 0x062
        movwf   0x5e                                        ; reg: 0x05e
        movf    0x61, W                                     ; reg: 0x061
        movwf   0x5d                                        ; reg: 0x05d
        return

function_058:                                               ; address: 0x1714

        fcall    function_061
        ;movlp   0x14
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x00
        movwf   0x66                                        ; reg: 0x066
        movlb   0x03
        movf    0x27, W                                     ; reg: 0x1a7
        movlb   0x00
        movwf   0x65                                        ; reg: 0x065
        movlb   0x03
        movf    0x28, W                                     ; reg: 0x1a8
        movlb   0x00
        movwf   0x64                                        ; reg: 0x064
        movlb   0x03
        movf    0x29, W                                     ; reg: 0x1a9
        movlb   0x00
        movwf   0x63                                        ; reg: 0x063
        movlw   0xa0
        movlb   0x03
        movwf   0x20                                        ; reg: 0x1a0
        movlw   0x07
        movwf   0x21                                        ; reg: 0x1a1
        movlw   0x90
        movwf   0x22                                        ; reg: 0x1a2
        movlw   0x0f
        movwf   0x23                                        ; reg: 0x1a3
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x00
        movwf   0x5e                                        ; reg: 0x05e
        movf    (Common_RAM + 6), W                         ; reg: 0x076
        movwf   0x5d                                        ; reg: 0x05d
        movf    0x66, W                                     ; reg: 0x066
        movwf   0x62                                        ; reg: 0x062
        movf    0x65, W                                     ; reg: 0x065
        movwf   0x61                                        ; reg: 0x061
        movf    0x64, W                                     ; reg: 0x064
        movwf   0x60                                        ; reg: 0x060
        movf    0x63, W                                     ; reg: 0x063
        movwf   0x5f                                        ; reg: 0x05f
        fcall    function_059
        ;movlp   0x14
        iorlw   0x00
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_554
        movlb   0x03
        clrf    0x26                                        ; reg: 0x1a6
        ljmp    label_555

label_554:                                                  ; address: 0x1743

        movlw   0xff
        movlb   0x03
        movwf   0x26                                        ; reg: 0x1a6

label_555:                                                  ; address: 0x1746

        movf    0x21, W                                     ; reg: 0x021
        fcall    function_052
        ;movlp   0x14
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        fcall    function_060
        ;movlp   0x14
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        movwf   INDF1                                       ; reg: 0x001
        ljmp    label_568

function_059:                                               ; address: 0x174f

        movlw   0xff
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x07
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_556
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x64
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_563

label_556:                                                  ; address: 0x175d

        clrf    (Common_RAM + 4)                            ; reg: 0x074
        movlw   0x05
        movlb   0x01
        movwf   0x58                                        ; reg: 0x0d8
        movlb   0x00
        movf    0x5e, W                                     ; reg: 0x05e
        iorwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_557
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x20                                        ; reg: 0x120
        ljmp    label_567

label_557:                                                  ; address: 0x176a

        decf    0x5d, W                                     ; reg: 0x05d
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_558
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x21                                        ; reg: 0x121
        clrf    0x22                                        ; reg: 0x122
        ljmp    label_567

label_558:                                                  ; address: 0x1773

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x02
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_559
        movf    0x60, W                                     ; reg: 0x060
        movlb   0x02
        movwf   0x24                                        ; reg: 0x124
        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x23                                        ; reg: 0x123
        ljmp    label_567

label_559:                                                  ; address: 0x1780

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x03
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_560
        movf    0x60, W                                     ; reg: 0x060
        movlb   0x02
        movwf   0x26                                        ; reg: 0x126
        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x25                                        ; reg: 0x125
        ljmp    label_567

label_560:                                                  ; address: 0x178d

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x04
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_561
        movf    0x60, W                                     ; reg: 0x060
        movlb   0x02
        movwf   0x28                                        ; reg: 0x128
        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x27                                        ; reg: 0x127
        ljmp    label_567

label_561:                                                  ; address: 0x179a

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x05
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_562
        movf    0x60, W                                     ; reg: 0x060
        movlb   0x02
        movwf   0x2a                                        ; reg: 0x12a
        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x29                                        ; reg: 0x129
        ljmp    label_567

label_562:                                                  ; address: 0x17a7

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x06
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_567
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x02
        movwf   0x2b                                        ; reg: 0x12b
        clrf    0x2c                                        ; reg: 0x12c
        ljmp    label_567

label_563:                                                  ; address: 0x17b1

        movlw   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x32
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_567
        movlw   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        movlw   0x36
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x5d, W                                     ; reg: 0x05d
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_567
        clrf    (Common_RAM + 4)                            ; reg: 0x074
        movlw   0x05
        movlb   0x01
        movwf   0x5c                                        ; reg: 0x0dc
        movlb   0x00
        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x32
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_564
        movf    0x5f, W                                     ; reg: 0x05f
        movwf   0x20                                        ; reg: 0x020
        ljmp    label_567

label_564:                                                  ; address: 0x17cc

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x33
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_565
        movf    0x5f, W                                     ; reg: 0x05f
        movwf   0x21                                        ; reg: 0x021
        ljmp    label_567

label_565:                                                  ; address: 0x17d4

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x34
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_566
        movf    0x5f, W                                     ; reg: 0x05f
        movwf   0x22                                        ; reg: 0x022
        ljmp    label_567

label_566:                                                  ; address: 0x17dc

        movf    0x5d, W                                     ; reg: 0x05d
        xorlw   0x35
        iorwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_567
        movf    0x5f, W                                     ; reg: 0x05f
        movwf   0x23                                        ; reg: 0x023

label_567:                                                  ; address: 0x17e3

        movf    (Common_RAM + 4), W                         ; reg: 0x074
        return

label_568:                                                  ; address: 0x17e5

        incf    0x21, W                                     ; reg: 0x021
        movlb   0x02
        movwf   0x62                                        ; reg: 0x162
        movlb   0x00
        bsf     0x39, 0x6                                   ; reg: 0x039
        movlb   0x01
        clrf    0x54                                        ; reg: 0x0d4
        incf    0x54, F                                     ; reg: 0x0d4
        movlb   0x03
        movf    0x20, W                                     ; reg: 0x1a0
        movwf   TXREG                                       ; reg: 0x19a
        movlb   0x01
        bsf     TXIE                                  ; reg: 0x091, bit: 4
        return

function_060:                                               ; address: 0x17f3

        movlb   0x03
        movf    0x21, W                                     ; reg: 0x1a1
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        return

function_061:                                               ; address: 0x17fa

        movlb   0x03
        movf    0x24, W                                     ; reg: 0x1a4
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x25, W                                     ; reg: 0x1a5
        movwf   0x76                                        ; reg: 0x1f6
        return
        movwi   -1[FSR1]
        movwi   -1[FSR1]

function_062:                                               ; address: 0x1802

        movlb   0x00
        bsf     0x3f, 0x0                                   ; reg: 0x03f
        clrf    0x45                                        ; reg: 0x045
        bcf     0x36, 0x4                                   ; reg: 0x036
        movlb   0x02
        clrf    CM1CON0                                     ; reg: 0x111
        clrf    CM1CON1                                     ; reg: 0x112
        clrf    CM2CON0                                     ; reg: 0x113
        clrf    CM2CON1                                     ; reg: 0x114
        clrf    FVRCON                                      ; reg: 0x117
        clrf    DACCON0                                     ; reg: 0x118
        movlw   0xd0
        movlb   0x01
        movwf   ADCON1                                      ; reg: 0x09e
        movlb   0x00
        movf    0x45, W                                     ; reg: 0x045
        addlw   0x41
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa9
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        movf    INDF0, W                                    ; reg: 0x000
        movlb   0x01
        movwf   ADCON0                                      ; reg: 0x09d
        nop
        movlb   0x01
        bsf     ADON                                ; reg: 0x09d, bit: 0
        movlb   0x00
        bcf     ADIF                                  ; reg: 0x011, bit: 6
        movlb   0x01
        bsf     ADIE                                  ; reg: 0x091, bit: 6
        movlw   0x05
        movwf   0x64                                        ; reg: 0x0e4
        return

function_063:                                               ; address: 0x1825

        movlb   0x00
        bcf     0x3a, 0x2                                   ; reg: 0x03a
        bcf     0x3a, 0x3                                   ; reg: 0x03a
        bcf     0x3a, 0x4                                   ; reg: 0x03a
        bcf     0x3a, 0x5                                   ; reg: 0x03a
        btfss   0x3a, 0x0                                   ; reg: 0x03a
        ljmp    label_428
        bcf     0x3a, 0x0                                   ; reg: 0x03a
        bsf     0x3a, 0x2                                   ; reg: 0x03a
        movlb   0x01
        movf    0x4f, W                                     ; reg: 0x0cf
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_421
        decfsz  0x4f, F                                     ; reg: 0x04f
        ljmp    label_421
        movlb   0x00
        bsf     0x39, 0x2                                   ; reg: 0x039
        movlb   0x01
        movf    0x51, W                                     ; reg: 0x0d1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_422
        decfsz  0x51, F                                     ; reg: 0x051
        ljmp    label_422
        movlb   0x00
        bcf     0x39, 0x6                                   ; reg: 0x039
        movlb   0x01
        movf    0x50, W                                     ; reg: 0x0d0
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_423
        decfsz  0x50, F                                     ; reg: 0x050
        ljmp    label_423
        clrf    0x53                                        ; reg: 0x053
        movlb   0x00
        btfss   0x39, 0x2                                   ; reg: 0x039
        ljmp    label_428
        movf    0x56, W                                     ; reg: 0x056
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_424
        decf    0x56, F                                     ; reg: 0x056
        movlb   0x01
        movf    0x4e, W                                     ; reg: 0x0ce
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x4e, F                                     ; reg: 0x0ce
        movf    0x3e, W                                     ; reg: 0x0be
        iorwf   0x3d, W                                     ; reg: 0x0bd
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_425
        movlw   0x01
        subwf   0x3d, F                                     ; reg: 0x03d
        movlw   0x00
        subwfb  0x3e, F                                     ; reg: 0x03e
        movlb   0x02
        movf    0x5d, W                                     ; reg: 0x15d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x5d, F                                     ; reg: 0x15d
        movf    0x42, W                                     ; reg: 0x142
        iorwf   0x41, W                                     ; reg: 0x141
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_426
        movlw   0x01
        subwf   0x41, F                                     ; reg: 0x041
        movlw   0x00
        subwfb  0x42, F                                     ; reg: 0x042
        movf    0x44, W                                     ; reg: 0x044
        iorwf   0x43, W                                     ; reg: 0x043
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_427
        movlw   0x01
        subwf   0x43, F                                     ; reg: 0x043
        movlw   0x00
        subwfb  0x44, F                                     ; reg: 0x044
        movlb   0x01
        movf    0x4d, W                                     ; reg: 0x0cd
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x4d, F                                     ; reg: 0x0cd
        decf    0x4c, F                                     ; reg: 0x0cc
        movlb   0x00
        bcf     0x3b, 0x3                                   ; reg: 0x03b
        bcf     0x3b, 0x0                                   ; reg: 0x03b
        bcf     0x3d, 0x4                                   ; reg: 0x03d
        movlw   0x19
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlb   0x01
        movf    0x4c, W                                     ; reg: 0x0cc
        fcall    function_047
        ;movlp   0x18
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        btfsc   (Common_RAM + 5), 0x1                       ; reg: 0x075
        bsf     0x3b, 0x3                                   ; reg: 0x03b
        btfsc   (Common_RAM + 5), 0x0                       ; reg: 0x075
        bsf     0x3b, 0x0                                   ; reg: 0x03b
        btfss   (Common_RAM + 5), 0x0                       ; reg: 0x075
        ljmp    label_569
        movlw   0x03
        subwf   (Common_RAM + 5), W                         ; reg: 0x075
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_569
        bsf     0x3d, 0x4                                   ; reg: 0x03d

label_569:                                                  ; address: 0x1887

        movlb   0x01
        movf    0x4c, F                                     ; reg: 0x0cc
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_570
        movlw   0xc8
        movwf   0x4c                                        ; reg: 0x04c

label_570:                                                  ; address: 0x188d

        movlb   0x00
        btfss   0x3a, 0x1                                   ; reg: 0x03a
        return
        bcf     0x3a, 0x1                                   ; reg: 0x03a
        bsf     0x3a, 0x3                                   ; reg: 0x03a
        movlb   0x01
        movf    0x5d, W                                     ; reg: 0x0dd
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x5d, F                                     ; reg: 0x0dd
        movlb   0x00
        btfss   0x39, 0x2                                   ; reg: 0x039
        ljmp    label_576
        movf    0x35, W                                     ; reg: 0x035
        iorwf   0x34, W                                     ; reg: 0x034
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_571
        movlw   0x01
        subwf   0x34, F                                     ; reg: 0x034
        movlw   0x00
        subwfb  0x35, F                                     ; reg: 0x035

label_571:                                                  ; address: 0x18a1

        movlb   0x02
        movf    0x64, W                                     ; reg: 0x164
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x64, F                                     ; reg: 0x164
        movf    0x63, W                                     ; reg: 0x163
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x63, F                                     ; reg: 0x163
        movlb   0x01
        movf    0x5f, W                                     ; reg: 0x0df
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x5f, F                                     ; reg: 0x0df
        movlb   0x02
        movf    0x5c, W                                     ; reg: 0x15c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x5c, F                                     ; reg: 0x15c
        movlb   0x00
        movf    0x57, W                                     ; reg: 0x057
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x57, F                                     ; reg: 0x057
        movf    0x55, W                                     ; reg: 0x055
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x55, F                                     ; reg: 0x055
        movlb   0x02
        movf    0x34, W                                     ; reg: 0x134
        iorwf   0x33, W                                     ; reg: 0x133
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_572
        movlw   0x01
        subwf   0x33, F                                     ; reg: 0x033
        movlw   0x00
        subwfb  0x34, F                                     ; reg: 0x034

label_572:                                                  ; address: 0x18c0

        movlb   0x00
        movf    0x6e, W                                     ; reg: 0x06e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x6e, F                                     ; reg: 0x06e
        movlb   0x01
        movf    0x57, W                                     ; reg: 0x0d7
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x57, F                                     ; reg: 0x0d7
        movf    0x59, W                                     ; reg: 0x0d9
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_573
        decf    0x59, F                                     ; reg: 0x059
        movlw   0x04
        ljmp    label_574

label_573:                                                  ; address: 0x18ce

        movlw   0x05

label_574:                                                  ; address: 0x18cf

        movlb   0x00
        movwf   0x5c                                        ; reg: 0x05c
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_576
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_575
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_575
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_576

label_575:                                                  ; address: 0x18e1

        movlb   0x01
        movf    0x5b, W                                     ; reg: 0x0db
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x5b, F                                     ; reg: 0x0db

label_576:                                                  ; address: 0x18e5

        movlb   0x02
        decfsz  0x68, F                                     ; reg: 0x168
        return
        movlw   0x0a
        movwf   0x68                                        ; reg: 0x168
        movlb   0x00
        bsf     0x3a, 0x4                                   ; reg: 0x03a
        btfss   0x39, 0x2                                   ; reg: 0x039
        ljmp    label_579
        movlb   0x01
        movf    0x55, W                                     ; reg: 0x0d5
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_577
        decf    0x55, F                                     ; reg: 0x055

label_577:                                                  ; address: 0x18f3

        movf    0x66, W                                     ; reg: 0x066
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        decf    0x66, F                                     ; reg: 0x066
        movlb   0x00
        bsf     0x40, 0x2                                   ; reg: 0x040
        movlb   0x02
        movf    0x6a, W                                     ; reg: 0x16a
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_578
        decf    0x6a, F                                     ; reg: 0x06a
        ljmp    label_579

label_578:                                                  ; address: 0x18fe

        movlb   0x00
        bcf     0x40, 0x2                                   ; reg: 0x040

label_579:                                                  ; address: 0x1900

        movlb   0x02
        decfsz  0x65, F                                     ; reg: 0x165
        return
        movlb   0x00
        bsf     0x3f, 0x1                                   ; reg: 0x03f
        movlw   0x03
        movlb   0x02
        movwf   0x65                                        ; reg: 0x165
        movlb   0x00
        bsf     0x3a, 0x5                                   ; reg: 0x03a
        return
        movlb   0x00
        movwf   0x5d                                        ; reg: 0x05d
        clrf    0x5f                                        ; reg: 0x05f
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_583
        clrf    0x5e                                        ; reg: 0x05e

label_580:                                                  ; address: 0x1912

        incf    0x5e, F                                     ; reg: 0x05e
        btfsc   (Common_RAM + 4), 0x7                       ; reg: 0x074
        ljmp    label_581
        lslf    (Common_RAM + 4), F                         ; reg: 0x074
        ljmp    label_580

label_581:                                                  ; address: 0x1917

        lslf    0x5f, F                                     ; reg: 0x05f
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        subwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_582
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        subwf   0x5d, F                                     ; reg: 0x05d
        bsf     0x5f, 0x0                                   ; reg: 0x05f

label_582:                                                  ; address: 0x191f

        lsrf    (Common_RAM + 4), F                         ; reg: 0x074
        decfsz  0x5e, F                                     ; reg: 0x05e
        ljmp    label_581

label_583:                                                  ; address: 0x1922

        movf    0x5f, W                                     ; reg: 0x05f
        return

function_064:                                               ; address: 0x1924

        movlb   0x00
        btfsc   0x51, 0x4                                   ; reg: 0x051
        btfsc   0x51, 0x0                                   ; reg: 0x051
        ljmp    label_584
        btfss   0x51, 0x1                                   ; reg: 0x051
        btfsc   0x51, 0x2                                   ; reg: 0x051
        ljmp    label_584
        bsf     0x51, 0x1                                   ; reg: 0x051
        bcf     0x51, 0x4                                   ; reg: 0x051
        clrf    0x46                                        ; reg: 0x046
        clrf    0x48                                        ; reg: 0x048
        ;movlp   0x14
        fcall    function_048
        ;movlp   0x19
        movlw   0x04
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xd3
        ;movlp   0x0f
        fcall    function_034
        ;movlp   0x19
        movlb   0x00
        movf    0x29, W                                     ; reg: 0x029
        movlb   0x03
        movwf   0x57                                        ; reg: 0x1d7
        movlb   0x00
        movf    0x28, W                                     ; reg: 0x028
        movlb   0x03
        movwf   0x58                                        ; reg: 0x1d8

label_584:                                                  ; address: 0x1940

        movlb   0x00
        btfss   0x51, 0x1                                   ; reg: 0x051
        ljmp    label_586
        movf    0x56, F                                     ; reg: 0x056
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_586
        movlw   0x06
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x48, W                                     ; reg: 0x048
        ;movlp   0x0f
        fcall    function_035
        ;movlp   0x19
        addwf   0x46, W                                     ; reg: 0x046
        addlw   0x50
        fcall    function_069
        ;movlp   0x19
        fcall    function_065
        ;movlp   0x19
        movlw   0x03
        movlb   0x00
        movwf   0x56                                        ; reg: 0x056
        incf    0x46, F                                     ; reg: 0x046
        movlw   0x06
        subwf   0x46, W                                     ; reg: 0x046
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_586
        incf    0x48, F                                     ; reg: 0x048
        movlw   0x02
        subwf   0x48, W                                     ; reg: 0x048
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_585
        clrf    0x46                                        ; reg: 0x046
        ljmp    label_586

label_585:                                                  ; address: 0x1961

        bcf     0x51, 0x1                                   ; reg: 0x051

label_586:                                                  ; address: 0x1962

        btfsc   0x51, 0x3                                   ; reg: 0x051
        btfsc   0x51, 0x0                                   ; reg: 0x051
        ljmp    label_587
        btfss   0x51, 0x1                                   ; reg: 0x051
        btfsc   0x51, 0x2                                   ; reg: 0x051
        ljmp    label_587
        bsf     0x51, 0x0                                   ; reg: 0x051
        bcf     0x51, 0x3                                   ; reg: 0x051
        clrf    0x46                                        ; reg: 0x046
        clrf    0x48                                        ; reg: 0x048
        fcall    function_066
        movlw   0x0d
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xd3
        ;movlp   0x0f
        fcall    function_034
        ;movlp   0x19
        movlb   0x00
        movf    0x29, W                                     ; reg: 0x029
        movlb   0x03
        movwf   0x60                                        ; reg: 0x1e0
        movlb   0x00
        movf    0x28, W                                     ; reg: 0x028
        movlb   0x03
        movwf   0x61                                        ; reg: 0x1e1

label_587:                                                  ; address: 0x197b

        movlb   0x00
        btfss   0x51, 0x0                                   ; reg: 0x051
        ljmp    label_589
        movf    0x56, F                                     ; reg: 0x056
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_589
        movlw   0x0f
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x48, W                                     ; reg: 0x048
        ;movlp   0x0f
        fcall    function_035
        ;movlp   0x19
        addwf   0x46, W                                     ; reg: 0x046
        fcall    function_069
        ;movlp   0x19
        fcall    function_065
        ;movlp   0x19
        movlw   0x03
        movlb   0x00
        movwf   0x56                                        ; reg: 0x056
        incf    0x46, F                                     ; reg: 0x046
        movlw   0x0f
        subwf   0x46, W                                     ; reg: 0x046
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_589
        incf    0x48, F                                     ; reg: 0x048
        movlw   0x02
        subwf   0x48, W                                     ; reg: 0x048
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_588
        clrf    0x46                                        ; reg: 0x046
        ljmp    label_589

label_588:                                                  ; address: 0x199b

        bcf     0x51, 0x0                                   ; reg: 0x051

label_589:                                                  ; address: 0x199c

        btfsc   0x51, 0x5                                   ; reg: 0x051
        btfsc   0x51, 0x0                                   ; reg: 0x051
        ljmp    label_590
        btfss   0x51, 0x1                                   ; reg: 0x051
        btfsc   0x51, 0x2                                   ; reg: 0x051
        ljmp    label_590
        bsf     0x51, 0x2                                   ; reg: 0x051
        bcf     0x51, 0x5                                   ; reg: 0x051
        clrf    0x46                                        ; reg: 0x046
        clrf    0x48                                        ; reg: 0x048
        fcall    function_067
        movlw   0x17
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movlw   0xd3
        ;movlp   0x0f
        fcall    function_034
        ;movlp   0x19
        movlb   0x00
        movf    0x29, W                                     ; reg: 0x029
        movlb   0x03
        movwf   0x6a                                        ; reg: 0x1ea
        movlb   0x00
        movf    0x28, W                                     ; reg: 0x028
        movlb   0x03
        movwf   0x6b                                        ; reg: 0x1eb

label_590:                                                  ; address: 0x19b5

        movlb   0x00
        btfss   0x51, 0x2                                   ; reg: 0x051
        ljmp    label_592
        movf    0x56, F                                     ; reg: 0x056
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_592
        movlw   0x19
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    0x48, W                                     ; reg: 0x048
        ;movlp   0x0f
        fcall    function_035
        ;movlp   0x19
        addwf   0x46, W                                     ; reg: 0x046
        addlw   0x1e
        fcall    function_069
        ;movlp   0x19
        fcall    function_065
        ;movlp   0x19
        movlw   0x03
        movlb   0x00
        movwf   0x56                                        ; reg: 0x056
        incf    0x46, F                                     ; reg: 0x046
        movlw   0x19
        subwf   0x46, W                                     ; reg: 0x046
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_592
        incf    0x48, F                                     ; reg: 0x048
        movlw   0x02
        subwf   0x48, W                                     ; reg: 0x048
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_591
        clrf    0x46                                        ; reg: 0x046
        ljmp    label_592

label_591:                                                  ; address: 0x19d6

        bcf     0x51, 0x2                                   ; reg: 0x051

label_592:                                                  ; address: 0x19d7

        btfss   0x51, 0x0                                   ; reg: 0x051
        btfsc   0x51, 0x1                                   ; reg: 0x051
        return
        btfss   0x51, 0x2                                   ; reg: 0x051
        btfss   EEIF                                  ; reg: 0x012, bit: 4
        return
        bcf     EEIF                                  ; reg: 0x012, bit: 4
        movlb   0x03
        bcf     WREN                                ; reg: 0x195, bit: 2
        return

function_065:                                               ; address: 0x19e1

        movwf   0x5f                                        ; reg: 0x05f
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        movlb   0x03
        movwf   EEADRL                                      ; reg: 0x191
        clrf    EEADRH                                      ; reg: 0x192
        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x03
        movwf   EEDATL                                      ; reg: 0x193
        movlb   0x00
        bcf     EEIF                                  ; reg: 0x012, bit: 4
        bcf     GIE                                 ; reg: 0x00b, bit: 7
        movlb   0x03
        bsf     WREN                                ; reg: 0x195, bit: 2
        movlw   0x55
        movwf   EECON2                                      ; reg: 0x196
        movlw   0xaa
        movwf   EECON2                                      ; reg: 0x196
        bsf     WR                                  ; reg: 0x195, bit: 1
        bsf     GIE                                 ; reg: 0x00b, bit: 7
        return

function_066:                                               ; address: 0x19f6

        movlb   0x02
        movf    0x20, W                                     ; reg: 0x120
        movlb   0x03
        movwf   0x53                                        ; reg: 0x1d3
        movlb   0x02
        movf    0x22, W                                     ; reg: 0x122
        movwf   0x77                                        ; reg: 0x177
        movf    0x21, W                                     ; reg: 0x121
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x03
        movwf   0x54                                        ; reg: 0x1d4
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x55                                        ; reg: 0x1d5
        movlb   0x02
        movf    0x24, W                                     ; reg: 0x124
        movwf   0x77                                        ; reg: 0x177
        movf    0x23, W                                     ; reg: 0x123
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x03
        movwf   0x56                                        ; reg: 0x1d6
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x57                                        ; reg: 0x1d7
        movlb   0x02
        movf    0x26, W                                     ; reg: 0x126
        movwf   0x77                                        ; reg: 0x177
        movf    0x25, W                                     ; reg: 0x125
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x03
        movwf   0x58                                        ; reg: 0x1d8
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x59                                        ; reg: 0x1d9
        movlb   0x02
        movf    0x28, W                                     ; reg: 0x128
        movwf   0x77                                        ; reg: 0x177
        movf    0x27, W                                     ; reg: 0x127
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x03
        movwf   0x5a                                        ; reg: 0x1da
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x5b                                        ; reg: 0x1db
        movlb   0x02
        movf    0x2a, W                                     ; reg: 0x12a
        movwf   0x77                                        ; reg: 0x177
        movf    0x29, W                                     ; reg: 0x129
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x03
        movwf   0x5c                                        ; reg: 0x1dc
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x5d                                        ; reg: 0x1dd
        movlb   0x02
        movf    0x2c, W                                     ; reg: 0x12c
        movwf   0x77                                        ; reg: 0x177
        movf    0x2b, W                                     ; reg: 0x12b
        movwf   0x76                                        ; reg: 0x176
        movf    0x77, W                                     ; reg: 0x177
        movlb   0x03
        movwf   0x5e                                        ; reg: 0x1de
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x5f                                        ; reg: 0x1df
        return

function_067:                                               ; address: 0x1a37

        movlb   0x01
        movf    0x23, W                                     ; reg: 0x0a3
        movlb   0x00
        movwf   0x27                                        ; reg: 0x027
        movlb   0x01
        movf    0x22, W                                     ; reg: 0x0a2
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x01
        movf    0x21, W                                     ; reg: 0x0a1
        movlb   0x00
        movwf   0x25                                        ; reg: 0x025
        movlb   0x01
        movf    0x20, W                                     ; reg: 0x0a0
        movlb   0x00
        movwf   0x24                                        ; reg: 0x024
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x03
        movwf   0x53                                        ; reg: 0x1d3
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x03
        movwf   0x54                                        ; reg: 0x1d4
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x03
        movwf   0x55                                        ; reg: 0x1d5
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x03
        movwf   0x56                                        ; reg: 0x1d6
        movlw   0x04
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        clrf    FSR1H                                       ; reg: 0x007
        fcall    function_068
        ;movlp   0x19
        movwf   0x57                                        ; reg: 0x057
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x03
        movwf   0x58                                        ; reg: 0x1d8
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x03
        movwf   0x59                                        ; reg: 0x1d9
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x03
        movwf   0x5a                                        ; reg: 0x1da
        movlb   0x01
        movf    0x2a, W                                     ; reg: 0x0aa
        movlb   0x03
        movwf   0x5d                                        ; reg: 0x1dd
        movlw   0x0b
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        fcall    function_068
        ;movlp   0x19
        movwf   0x5e                                        ; reg: 0x05e
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x03
        movwf   0x5f                                        ; reg: 0x1df
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x03
        movwf   0x60                                        ; reg: 0x1e0
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x03
        movwf   0x61                                        ; reg: 0x1e1
        movlw   0x0f
        addlw   0xa0
        movwf   FSR1L                                       ; reg: 0x006
        fcall    function_068
        ;movlp   0x19
        movwf   0x62                                        ; reg: 0x062
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x03
        movwf   0x63                                        ; reg: 0x1e3
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x03
        movwf   0x64                                        ; reg: 0x1e4
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x03
        movwf   0x65                                        ; reg: 0x1e5
        movlb   0x01
        movf    0x34, W                                     ; reg: 0x0b4
        movwf   0x77                                        ; reg: 0x0f7
        movf    0x33, W                                     ; reg: 0x0b3
        movwf   0x76                                        ; reg: 0x0f6
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x03
        movwf   0x66                                        ; reg: 0x1e6
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x03
        movwf   0x67                                        ; reg: 0x1e7
        movlb   0x01
        movf    0x29, W                                     ; reg: 0x0a9
        movwf   0x77                                        ; reg: 0x0f7
        movf    0x28, W                                     ; reg: 0x0a8
        movwf   0x76                                        ; reg: 0x0f6
        movf    0x77, W                                     ; reg: 0x0f7
        movlb   0x03
        movwf   0x5b                                        ; reg: 0x1db
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x5c                                        ; reg: 0x1dc
        movlb   0x01
        movf    0x36, W                                     ; reg: 0x0b6
        movwf   0x77                                        ; reg: 0x0f7
        movf    0x35, W                                     ; reg: 0x0b5
        movwf   0x76                                        ; reg: 0x0f6
        movf    0x77, W                                     ; reg: 0x0f7
        movlb   0x03
        movwf   0x68                                        ; reg: 0x1e8
        movf    0x76, W                                     ; reg: 0x1f6
        movwf   0x69                                        ; reg: 0x1e9
        return

function_068:                                               ; address: 0x1ab3

        moviw   0[FSR1]
        movlb   0x00
        movwf   0x24                                        ; reg: 0x024
        moviw   1[FSR1] 
        movwf   0x25                                        ; reg: 0x025
        moviw   2[FSR1] 
        movwf   0x26                                        ; reg: 0x026
        moviw   3[FSR1] 
        movwf   0x27                                        ; reg: 0x027
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x03
        return

function_069:                                               ; address: 0x1abf

        movwf   (Common_RAM + 5)                            ; reg: 0x075
        movf    0x46, W                                     ; reg: 0x046
        addlw   0xd3
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movf    INDF1, W                                    ; reg: 0x001
        return

function_070:                                               ; address: 0x1ac7

        movlb   0x00
        bcf     0x41, 0x2                                   ; reg: 0x041
        movlb   0x05
        movf    CCPR2L, W                                   ; reg: 0x298
        movlb   0x02
        movwf   0x45                                        ; reg: 0x145
        movlb   0x05
        movf    CCPR2H, W                                   ; reg: 0x299
        movlb   0x02
        movwf   0x46                                        ; reg: 0x146
        movf    0x46, W                                     ; reg: 0x146
        movlb   0x00
        movwf   0x33                                        ; reg: 0x033
        movlb   0x02
        movf    0x45, W                                     ; reg: 0x145
        movlb   0x00
        movwf   0x32                                        ; reg: 0x032
        movlb   0x03
        movf    0x51, W                                     ; reg: 0x1d1
        movlb   0x00
        subwf   0x32, F                                     ; reg: 0x032
        movlb   0x03
        movf    0x52, W                                     ; reg: 0x1d2
        movlb   0x00
        subwfb  0x33, F                                     ; reg: 0x033
        movlw   0x1f
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0x40
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_593
        btfsc   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_595

label_593:                                                  ; address: 0x1ae9

        movlw   0x19
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0xc8
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_594
        btfss   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_595

label_594:                                                  ; address: 0x1af2

        btfsc   0x3c, 0x5                                   ; reg: 0x03c
        ljmp    label_596

label_595:                                                  ; address: 0x1af4

        movlb   0x02
        movf    0x46, W                                     ; reg: 0x146
        movlb   0x03
        movwf   0x52                                        ; reg: 0x1d2
        movlb   0x02
        movf    0x45, W                                     ; reg: 0x145
        movlb   0x03
        movwf   0x51                                        ; reg: 0x1d1

label_596:                                                  ; address: 0x1afc

        movlb   0x05
        movf    CCP2CON, W                                  ; reg: 0x29a
        xorlw   0x05
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_597
        movlw   0x04
        movwf   TMR2                                        ; reg: 0x01a
        movlb   0x00
        bsf     0x41, 0x2                                   ; reg: 0x041
        ljmp    label_598

label_597:                                                  ; address: 0x1b06

        movlw   0x05
        movwf   TMR2                                        ; reg: 0x01a

label_598:                                                  ; address: 0x1b08

        movlb   0x00
        bcf     CCP2IF                                ; reg: 0x012, bit: 0
        btfsc   0x3c, 0x5                                   ; reg: 0x03c
        ljmp    label_601
        movlw   0x19
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0xc8
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_600
        movlw   0x2e
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0xe1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_600
        movlw   0x23
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0xd3
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_599
        movlb   0x02
        clrf    0x5f                                        ; reg: 0x15f
        incf    0x5e, F                                     ; reg: 0x15e
        movlw   0x1e
        subwf   0x5e, W                                     ; reg: 0x15e
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_600
        fcall    function_071
        ;movlp   0x1a
        ljmp    label_600

label_599:                                                  ; address: 0x1b2b

        movlb   0x02
        clrf    0x5e                                        ; reg: 0x15e
        incf    0x5f, F                                     ; reg: 0x15f
        movlw   0x1e
        subwf   0x5f, W                                     ; reg: 0x15f
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_600
        fcall    function_072
        ;movlp   0x1a

label_600:                                                  ; address: 0x1b34

        movlb   0x02
        incf    0x60, F                                     ; reg: 0x160
        movlw   0xc8
        subwf   0x60, W                                     ; reg: 0x160
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_650
        fcall    function_071
        ;movlp   0x1a
        ljmp    label_650

label_601:                                                  ; address: 0x1b3d

        movlw   0x1f
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0x40
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_602
        movlw   0x2e
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0xe1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_602
        btfsc   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_603

label_602:                                                  ; address: 0x1b4d

        movlw   0x19
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0xc8
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_650
        movlw   0x27
        subwf   0x33, W                                     ; reg: 0x033
        movlw   0x11
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x32, W                                     ; reg: 0x032
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfsc   0x3c, 0x4                                   ; reg: 0x03c
        ljmp    label_650

label_603:                                                  ; address: 0x1b5c

        movlb   0x02
        movf    0x57, W                                     ; reg: 0x157
        movlb   0x01
        movwf   0x68                                        ; reg: 0x0e8
        movlb   0x00
        btfss   0x52, 0x2                                   ; reg: 0x052
        ljmp    label_627
        btfss   0x3f, 0x4                                   ; reg: 0x03f
        ljmp    label_606
        bcf     0x3f, 0x4                                   ; reg: 0x03f
        fcall    function_073
        ;movlp   0x1a
        ljmp    label_605

label_604:                                                  ; address: 0x1b69

        lslf    0x47, F                                     ; reg: 0x047
        rlf     0x48, F                                     ; reg: 0x048

label_605:                                                  ; address: 0x1b6b

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_604

label_606:                                                  ; address: 0x1b6d

        movlb   0x02
        movf    0x55, W                                     ; reg: 0x155
        movlb   0x00
        xorwf   0x5c, W                                     ; reg: 0x05c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_607
        movf    0x5c, W                                     ; reg: 0x05c
        movlb   0x02
        movwf   0x55                                        ; reg: 0x155
        fcall    function_074
        ;movlp   0x1a

label_607:                                                  ; address: 0x1b78

        movlw   0x0a
        movwf   Common_RAM                                  ; reg: 0x070
        clrf    (Common_RAM + 1)                            ; reg: 0x071
        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        ljmp    label_609

label_608:                                                  ; address: 0x1b7e

        lslf    Common_RAM, F                               ; reg: 0x070
        rlf     (Common_RAM + 1), F                         ; reg: 0x071

label_609:                                                  ; address: 0x1b80

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_608
        movlb   0x02
        movf    0x36, W                                     ; reg: 0x136
        xorwf   0x71, W                                     ; reg: 0x171
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_610
        movf    0x35, W                                     ; reg: 0x035
        xorwf   Common_RAM, W                               ; reg: 0x070

label_610:                                                  ; address: 0x1b89

        movlw   0x0a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_613
        movwf   0x47                                        ; reg: 0x047
        clrf    0x48                                        ; reg: 0x048
        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x02
        ljmp    label_612

label_611:                                                  ; address: 0x1b92

        lslf    0x47, F                                     ; reg: 0x047
        rlf     0x48, F                                     ; reg: 0x048

label_612:                                                  ; address: 0x1b94

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_611
        movlw   0x0a

label_613:                                                  ; address: 0x1b97

        movwf   Common_RAM                                  ; reg: 0x070
        clrf    (Common_RAM + 1)                            ; reg: 0x071
        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        ljmp    label_615

label_614:                                                  ; address: 0x1b9c

        lslf    Common_RAM, F                               ; reg: 0x070
        rlf     (Common_RAM + 1), F                         ; reg: 0x071

label_615:                                                  ; address: 0x1b9e

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_614
        movf    Common_RAM, W                               ; reg: 0x070
        addlw   0xff
        movwf   (Common_RAM + 2)                            ; reg: 0x072
        movlw   0xff
        addwfc  (Common_RAM + 1), W                         ; reg: 0x071
        movwf   (Common_RAM + 3)                            ; reg: 0x073
        movlb   0x02
        subwf   0x48, W                                     ; reg: 0x148
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_616
        movf    (Common_RAM + 2), W                         ; reg: 0x072
        subwf   0x47, W                                     ; reg: 0x047

label_616:                                                  ; address: 0x1bac

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_617
        clrf    0x47                                        ; reg: 0x047
        clrf    0x48                                        ; reg: 0x048
        fcall    function_074
        ;movlp   0x1a

label_617:                                                  ; address: 0x1bb2

        movf    0x37, W                                     ; reg: 0x037
        addlw   0xff
        movwf   Common_RAM                                  ; reg: 0x070
        movlw   0xff
        addwfc  0x38, W                                     ; reg: 0x038
        movwf   (Common_RAM + 1)                            ; reg: 0x071

label_618:                                                  ; address: 0x1bb8

        subwf   0x48, W                                     ; reg: 0x048
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_619
        movf    Common_RAM, W                               ; reg: 0x070
        subwf   0x47, W                                     ; reg: 0x047

label_619:                                                  ; address: 0x1bbd

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_620
        movlb   0x01
        movf    0x52, W                                     ; reg: 0x0d2
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_620
        decf    0x52, F                                     ; reg: 0x052

label_620:                                                  ; address: 0x1bc4

        movlb   0x02
        incf    0x47, F                                     ; reg: 0x147
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x48, F                                     ; reg: 0x148

label_621:                                                  ; address: 0x1bc8

        movf    0x38, W                                     ; reg: 0x038
        subwf   0x48, W                                     ; reg: 0x048
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_622:                                                  ; address: 0x1bcb

        ljmp    label_623
        movf    0x37, W                                     ; reg: 0x037
        subwf   0x47, W                                     ; reg: 0x047

label_623:                                                  ; address: 0x1bce

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_625
        movlb   0x01
        movf    0x52, F                                     ; reg: 0x0d2

label_624:                                                  ; address: 0x1bd2

        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_631

label_625:                                                  ; address: 0x1bd4

        movlb   0x00

label_626:                                                  ; address: 0x1bd5

        bcf     0x52, 0x2                                   ; reg: 0x052
        ljmp    label_631

label_627:                                                  ; address: 0x1bd7

        fcall    function_073
        ;movlp   0x1a

label_628:                                                  ; address: 0x1bd9

        ljmp    label_630

label_629:                                                  ; address: 0x1bda

        lslf    0x47, F                                     ; reg: 0x047
        rlf     0x48, F                                     ; reg: 0x048

label_630:                                                  ; address: 0x1bdc

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_629
        movlw   0xff
        addwf   0x47, F                                     ; reg: 0x047
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        decf    0x48, F                                     ; reg: 0x048
        clrf    0x37                                        ; reg: 0x037
        clrf    0x38                                        ; reg: 0x038

label_631:                                                  ; address: 0x1be4

        movlb   0x00
        btfsc   0x52, 0x4                                   ; reg: 0x052
        ljmp    label_645
        btfss   0x3b, 0x7                                   ; reg: 0x03b
        ljmp    label_643
        movlb   0x01
        movf    0x38, W                                     ; reg: 0x0b8
        movlb   0x03
        xorwf   0x4a, W                                     ; reg: 0x1ca

label_632:                                                  ; address: 0x1bed

        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_634
        movlb   0x01

label_633:                                                  ; address: 0x1bf0

        movf    0x37, W                                     ; reg: 0x037
        movlb   0x03
        xorwf   0x49, W                                     ; reg: 0x1c9

label_634:                                                  ; address: 0x1bf3

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_637
        movlb   0x01
        movf    0x38, W                                     ; reg: 0x0b8

label_635:                                                  ; address: 0x1bf7

        movlb   0x03
        movwf   0x4a                                        ; reg: 0x1ca
        movlb   0x01
        movf    0x37, W                                     ; reg: 0x0b7

label_636:                                                  ; address: 0x1bfb

        movlb   0x03
        movwf   0x49                                        ; reg: 0x1c9
        movlb   0x02
        clrf    0x49                                        ; reg: 0x149
        clrf    0x4a                                        ; reg: 0x14a

label_637:                                                  ; address: 0x1c00

        movlb   0x02
        movf    0x4a, W                                     ; reg: 0x14a
        iorwf   0x49, W                                     ; reg: 0x149

label_638:                                                  ; address: 0x1c03

        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_640

label_639:                                                  ; address: 0x1c05

        movlb   0x01
        movf    0x38, W                                     ; reg: 0x0b8
        movlb   0x02
        movwf   0x4a                                        ; reg: 0x14a
        movlb   0x01
        movf    0x37, W                                     ; reg: 0x0b7
        movlb   0x02
        movwf   0x49                                        ; reg: 0x149

label_640:                                                  ; address: 0x1c0d

        movlw   0x01
        subwf   0x49, F                                     ; reg: 0x049
        movlw   0x00
        subwfb  0x4a, F                                     ; reg: 0x04a

label_641:                                                  ; address: 0x1c11

        movlb   0x00
        bsf     0x3c, 0x2                                   ; reg: 0x03c
        movlb   0x03
        movf    0x4c, W                                     ; reg: 0x1cc
        movlb   0x02
        subwf   0x4a, W                                     ; reg: 0x14a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_642
        movlb   0x03
        movf    0x4b, W                                     ; reg: 0x1cb
        movlb   0x02
        subwf   0x49, W                                     ; reg: 0x149

label_642:                                                  ; address: 0x1c1d

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_647
        movlb   0x00
        bsf     0x52, 0x4                                   ; reg: 0x052
        ljmp    label_646

label_643:                                                  ; address: 0x1c22

        movlb   0x03
        clrf    0x49                                        ; reg: 0x1c9
        clrf    0x4a                                        ; reg: 0x1ca
        movlb   0x02
        clrf    0x49                                        ; reg: 0x149
        clrf    0x4a                                        ; reg: 0x14a
        movlb   0x00
        bsf     0x3c, 0x2                                   ; reg: 0x03c

label_644:                                                  ; address: 0x1c2a

        ljmp    label_647

label_645:                                                  ; address: 0x1c2b

        movlb   0x02
        clrf    0x49                                        ; reg: 0x149
        clrf    0x4a                                        ; reg: 0x14a
        movlb   0x00

label_646:                                                  ; address: 0x1c2f

        bcf     0x3c, 0x2                                   ; reg: 0x03c

label_647:                                                  ; address: 0x1c30

        movlb   0x00

label_648:                                                  ; address: 0x1c31

        movf    PORTA, W                                    ; reg: 0x00c
        movlb   0x01
        movwf   0x4b                                        ; reg: 0x0cb
        movlw   0xeb
        andwf   0x4b, F                                     ; reg: 0x0cb
        movlb   0x00
        movf    0x52, W                                     ; reg: 0x052

label_649:                                                  ; address: 0x1c38

        movlb   0x01
        iorwf   0x4b, F                                     ; reg: 0x0cb
        movf    0x4b, W                                     ; reg: 0x0cb
        movlb   0x00
        movwf   PORTA                                       ; reg: 0x00c
        movlw   0x02
        movlb   0x01
        movwf   0x67                                        ; reg: 0x0e7

label_650:                                                  ; address: 0x1c40

        movlb   0x02
        decfsz  0x67, F                                     ; reg: 0x167
        return
        movlb   0x01
        movf    0x45, W                                     ; reg: 0x0c5
        movlb   0x02
        movwf   0x67                                        ; reg: 0x167
        movlb   0x00
        bsf     0x3a, 0x1                                   ; reg: 0x03a
        return

function_071:                                               ; address: 0x1c4a

        movlb   0x00
        bsf     0x3c, 0x5                                   ; reg: 0x03c
        bsf     0x3c, 0x4                                   ; reg: 0x03c
        movlw   0x0a
        movlb   0x01
        movwf   0x45                                        ; reg: 0x0c5
        movlw   0x2d
        movlb   0x02
        movwf   0x57                                        ; reg: 0x157
        return

function_072:                                               ; address: 0x1c54

        movlb   0x00
        bsf     0x3c, 0x5                                   ; reg: 0x03c

label_651:                                                  ; address: 0x1c56

        bcf     0x3c, 0x4                                   ; reg: 0x03c
        movlw   0x0c
        movlb   0x01
        movwf   0x45                                        ; reg: 0x0c5

label_652:                                                  ; address: 0x1c5a

        movlw   0x26
        movlb   0x02
        movwf   0x57                                        ; reg: 0x157
        return

function_073:                                               ; address: 0x1c5e

        movlw   0x0a
        movlb   0x02

label_653:                                                  ; address: 0x1c60

        movwf   0x47                                        ; reg: 0x047
        clrf    0x48                                        ; reg: 0x048
        movlb   0x00

label_654:                                                  ; address: 0x1c63

        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x02

label_655:                                                  ; address: 0x1c65

        return

function_074:                                               ; address: 0x1c66

        movf    0x36, W                                     ; reg: 0x036
        movwf   0x38                                        ; reg: 0x038
        movf    0x35, W                                     ; reg: 0x035

label_656:                                                  ; address: 0x1c69

        movwf   0x37                                        ; reg: 0x037
        return

function_075:                                               ; address: 0x1c6b

        movlw   0x02
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x97
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_659
        movf    0x5b, F                                     ; reg: 0x05b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_659
        movf    0x4f, W                                     ; reg: 0x04f

label_657:                                                  ; address: 0x1c77

        xorlw   0x05
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_658:                                                  ; address: 0x1c79

        ljmp    label_659
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_660

label_659:                                                  ; address: 0x1c7e

        btfss   0x36, 0x3                                   ; reg: 0x036
        ljmp    label_663

label_660:                                                  ; address: 0x1c80

        bcf     0x43, 0x0                                   ; reg: 0x043

label_661:                                                  ; address: 0x1c81

        movlb   0x03

label_662:                                                  ; address: 0x1c82

        clrf    0x45                                        ; reg: 0x045
        clrf    0x46                                        ; reg: 0x046
        ljmp    label_796

label_663:                                                  ; address: 0x1c85

        btfss   0x36, 0x3                                   ; reg: 0x036

label_664:                                                  ; address: 0x1c86

        btfss   0x3d, 0x0                                   ; reg: 0x03d
        ljmp    label_733
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_668

label_665:                                                  ; address: 0x1c8c

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_669

label_666:                                                  ; address: 0x1c90

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_669

label_667:                                                  ; address: 0x1c94

        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_669

label_668:                                                  ; address: 0x1c98

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_733
        decfsz  0x4d, W                                     ; reg: 0x04d
        ljmp    label_733

label_669:                                                  ; address: 0x1c9e

        movlb   0x01
        movf    0x47, F                                     ; reg: 0x0c7
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_733
        movlb   0x00
        movf    0x2f, W                                     ; reg: 0x02f
        iorwf   0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_733
        incf    0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2f, W                                     ; reg: 0x02f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_733
        bcf     0x3b, 0x1                                   ; reg: 0x03b
        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0x2e
        fcall    function_080
        ;movlp   0x1c
        movf    0x2e, W                                     ; reg: 0x02e
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_730
        addlw   0xda
        fcall    function_081
        ;movlp   0x1c

label_670:                                                  ; address: 0x1cb7

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_729
        bsf     0x43, 0x0                                   ; reg: 0x043
        fcall    function_083

label_671:                                                  ; address: 0x1cbb

        ;movlp   0x1c
        fcall    function_084
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_672:                                                  ; address: 0x1cbf

        ljmp    label_674
        movlw   0xfd

label_673:                                                  ; address: 0x1cc1

        subwf   0x2c, W                                     ; reg: 0x02c

label_674:                                                  ; address: 0x1cc2

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_678

label_675:                                                  ; address: 0x1cc4

        movlb   0x00
        fcall    function_079

label_676:                                                  ; address: 0x1cc6

        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_677
        movlw   0x04
        subwf   0x2c, W                                     ; reg: 0x02c

label_677:                                                  ; address: 0x1ccb

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_714

label_678:                                                  ; address: 0x1ccd

        movlb   0x00
        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0x0f
        fcall    function_080

label_679:                                                  ; address: 0x1cd1

        ;movlp   0x1c
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_714
        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0xf1
        fcall    function_081
        ;movlp   0x1c
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_714
        movlb   0x01
        clrf    0x3b                                        ; reg: 0x0bb
        clrf    0x3c                                        ; reg: 0x0bc

label_680:                                                  ; address: 0x1cdd

        movlb   0x00
        movf    0x49, W                                     ; reg: 0x049

label_681:                                                  ; address: 0x1cdf

        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4
        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_683
        movlw   0x01

label_682:                                                  ; address: 0x1ce7

        subwf   0x2c, W                                     ; reg: 0x02c

label_683:                                                  ; address: 0x1ce8

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_696
        movlb   0x00
        fcall    function_079

label_684:                                                  ; address: 0x1cec

        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_685
        movlw   0x03
        subwf   0x2c, W                                     ; reg: 0x02c

label_685:                                                  ; address: 0x1cf1

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0

label_686:                                                  ; address: 0x1cf2

        ljmp    label_689
        movlb   0x00
        movf    0x49, W                                     ; reg: 0x049
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_687:                                                  ; address: 0x1cf6

        ljmp    label_689
        movf    0x49, W                                     ; reg: 0x049

label_688:                                                  ; address: 0x1cf8

        addlw   0xff
        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4

label_689:                                                  ; address: 0x1cfb

        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_690
        movlw   0x05
        subwf   0x2c, W                                     ; reg: 0x02c

label_690:                                                  ; address: 0x1d02

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_692
        movlb   0x00
        movf    0x49, W                                     ; reg: 0x049
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_692
        decfsz  0x49, W                                     ; reg: 0x049
        ljmp    label_691
        movlb   0x01
        clrf    0x44                                        ; reg: 0x0c4
        ljmp    label_692

label_691:                                                  ; address: 0x1d0d

        movf    0x49, W                                     ; reg: 0x049
        addlw   0xfe
        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4

label_692:                                                  ; address: 0x1d11

        movlb   0x00
        btfss   0x60, 0x7                                   ; reg: 0x060
        ljmp    label_693
        movlw   0x02
        movlb   0x01
        subwf   0x44, W                                     ; reg: 0x0c4
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        decf    0x44, F                                     ; reg: 0x0c4

label_693:                                                  ; address: 0x1d19

        movlb   0x00
        fcall    function_082
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_694
        movlw   0x10
        subwf   0x5f, W                                     ; reg: 0x05f

label_694:                                                  ; address: 0x1d20

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_705
        movlw   0x09
        movlb   0x01
        subwf   0x44, W                                     ; reg: 0x0c4
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_705
        movf    0x59, F                                     ; reg: 0x059
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2

label_695:                                                  ; address: 0x1d29

        ljmp    label_705
        incf    0x44, F                                     ; reg: 0x044
        ljmp    label_704

label_696:                                                  ; address: 0x1d2c

        movlb   0x00
        fcall    function_084
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_697
        movlw   0xfe
        subwf   0x2c, W                                     ; reg: 0x02c

label_697:                                                  ; address: 0x1d33

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_698
        movlw   0x0a
        movlb   0x00
        subwf   0x49, W                                     ; reg: 0x049
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_698
        incf    0x49, W                                     ; reg: 0x049
        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4

label_698:                                                  ; address: 0x1d3d

        movlb   0x00
        fcall    function_084
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_699
        movlw   0xfc
        subwf   0x2c, W                                     ; reg: 0x02c

label_699:                                                  ; address: 0x1d44

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_702
        movlw   0x0a
        movlb   0x00
        subwf   0x49, W                                     ; reg: 0x049
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_702
        movlw   0x08
        subwf   0x49, W                                     ; reg: 0x049
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_700
        movlw   0x0a
        ljmp    label_701

label_700:                                                  ; address: 0x1d51

        movf    0x49, W                                     ; reg: 0x049
        addlw   0x02

label_701:                                                  ; address: 0x1d53

        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4

label_702:                                                  ; address: 0x1d55

        movlb   0x00
        fcall    function_082
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_703
        movlw   0x01
        subwf   0x5f, W                                     ; reg: 0x05f

label_703:                                                  ; address: 0x1d5c

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_705
        movlw   0x0a
        movlb   0x01
        subwf   0x44, W                                     ; reg: 0x0c4
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0

label_704:                                                  ; address: 0x1d62

        incf    0x44, F                                     ; reg: 0x044

label_705:                                                  ; address: 0x1d63

        movlb   0x00

label_706:                                                  ; address: 0x1d64

        lslf    0x49, W                                     ; reg: 0x049

label_707:                                                  ; address: 0x1d65

        addlw   0xcc
        movwf   FSR0L                                       ; reg: 0x004

label_708:                                                  ; address: 0x1d67

        movlw   0xa8
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005

label_709:                                                  ; address: 0x1d6b

        moviw   0[FSR0]
        movlb   0x03
        movwf   0x45                                        ; reg: 0x1c5
        moviw   1[FSR0]
        movwf   0x46                                        ; reg: 0x1c6

label_710:                                                  ; address: 0x1d70

        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x03
        ljmp    label_712

label_711:                                                  ; address: 0x1d74

        lslf    0x45, F                                     ; reg: 0x045
        rlf     0x46, F                                     ; reg: 0x046

label_712:                                                  ; address: 0x1d76

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_711

label_713:                                                  ; address: 0x1d78

        ljmp    label_796

label_714:                                                  ; address: 0x1d79

        movlb   0x00
        movf    0x49, W                                     ; reg: 0x049
        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4
        movf    0x4d, F                                     ; reg: 0x0cd
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_721
        movlw   0xc8
        movwf   0x4d                                        ; reg: 0x04d
        movlb   0x00
        fcall    function_082
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_715
        movlw   0x07
        subwf   0x5f, W                                     ; reg: 0x05f

label_715:                                                  ; address: 0x1d89

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0

label_716:                                                  ; address: 0x1d8a

        ljmp    label_719
        movlb   0x00
        movf    0x60, W                                     ; reg: 0x060
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x7f
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_717
        movlw   0xfa
        subwf   0x5f, W                                     ; reg: 0x05f

label_717:                                                  ; address: 0x1d95

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0

label_718:                                                  ; address: 0x1d96

        ljmp    label_719
        movlb   0x01
        clrf    0x3b                                        ; reg: 0x0bb
        clrf    0x3c                                        ; reg: 0x0bc

label_719:                                                  ; address: 0x1d9a

        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x01
        addwf   0x3b, F                                     ; reg: 0x0bb
        movlb   0x00
        movf    0x60, W                                     ; reg: 0x060

label_720:                                                  ; address: 0x1da0

        movlb   0x01
        addwfc  0x3c, F                                     ; reg: 0x0bc

label_721:                                                  ; address: 0x1da2

        fcall    function_086
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_722
        movlw   0x01
        subwf   0x3b, W                                     ; reg: 0x03b

label_722:                                                  ; address: 0x1da8

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_724
        movlb   0x01
        fcall    function_086
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_723
        movlw   0x0f
        subwf   0x3b, W                                     ; reg: 0x03b

label_723:                                                  ; address: 0x1db1

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_724
        movlw   0x0a
        movlb   0x00
        subwf   0x49, W                                     ; reg: 0x049
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_724
        incf    0x49, W                                     ; reg: 0x049
        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4

label_724:                                                  ; address: 0x1dbb

        movlb   0x01
        btfss   0x3c, 0x7                                   ; reg: 0x0bc
        ljmp    label_728
        movf    0x3c, W                                     ; reg: 0x03c
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x7f
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_725
        movlw   0xf2
        subwf   0x3b, W                                     ; reg: 0x03b

label_725:                                                  ; address: 0x1dc7

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_728
        movlb   0x00
        movf    0x49, W                                     ; reg: 0x049

label_726:                                                  ; address: 0x1dcb

        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_728

label_727:                                                  ; address: 0x1dcd

        movf    0x49, W                                     ; reg: 0x049
        addlw   0xff
        movlb   0x01
        movwf   0x44                                        ; reg: 0x0c4

label_728:                                                  ; address: 0x1dd1

        movlb   0x01
        lslf    0x44, W                                     ; reg: 0x0c4
        ljmp    label_707

label_729:                                                  ; address: 0x1dd4

        movf    0x2e, W                                     ; reg: 0x02e

label_730:                                                  ; address: 0x1dd5

        addlw   0x2e
        fcall    function_080
        ;movlp   0x1c
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_731
        bsf     0x43, 0x0                                   ; reg: 0x043
        btfss   0x2d, 0x7                                   ; reg: 0x02d
        ljmp    label_661
        movlw   0x03
        ljmp    label_732

label_731:                                                  ; address: 0x1ddf

        movf    0x2e, W                                     ; reg: 0x02e
        addlw   0xda
        fcall    function_081
        ;movlp   0x1c
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_661
        bsf     0x43, 0x0                                   ; reg: 0x043
        movlw   0x0a

label_732:                                                  ; address: 0x1de7

        movlb   0x03
        movwf   0x45                                        ; reg: 0x1c5
        clrf    0x46                                        ; reg: 0x1c6
        ljmp    label_710

label_733:                                                  ; address: 0x1deb

        fcall    function_077
        ;movlp   0x1c
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_734
        btfsc   0x3d, 0x0                                   ; reg: 0x03d
        ljmp    label_735

label_734:                                                  ; address: 0x1df2

        movlb   0x03
        clrf    0x45                                        ; reg: 0x1c5
        clrf    0x46                                        ; reg: 0x1c6
        ljmp    label_786

label_735:                                                  ; address: 0x1df6

        fcall    function_083
        ;movlp   0x1c
        movf    0x5b, W                                     ; reg: 0x05b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_736
        movf    0x50, W                                     ; reg: 0x050
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_737

label_736:                                                  ; address: 0x1dff

        incf    0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2f, W                                     ; reg: 0x02f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_741

label_737:                                                  ; address: 0x1e04

        movlw   0x0a

label_738:                                                  ; address: 0x1e05

        movlb   0x03
        movwf   0x45                                        ; reg: 0x1c5
        clrf    0x46                                        ; reg: 0x1c6
        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x03
        ljmp    label_740

label_739:                                                  ; address: 0x1e0c

        lslf    0x45, F                                     ; reg: 0x045
        rlf     0x46, F                                     ; reg: 0x046

label_740:                                                  ; address: 0x1e0e

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_739
        ljmp    label_786

label_741:                                                  ; address: 0x1e11

        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_744
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_744
        clrf    0x61                                        ; reg: 0x061

label_742:                                                  ; address: 0x1e1a

        lslf    0x61, W                                     ; reg: 0x061
        addlw   0x0a
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa9
        fcall    function_078
        ;movlp   0x1c
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_743
        incf    0x61, F                                     ; reg: 0x061
        ljmp    label_742

label_743:                                                  ; address: 0x1e24

        movf    0x61, W                                     ; reg: 0x061
        ljmp    label_738

label_744:                                                  ; address: 0x1e26

        decf    0x4f, W                                     ; reg: 0x04f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_745
        btfss   0x3b, 0x1                                   ; reg: 0x03b
        ljmp    label_781
        movlw   0x02
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x1a
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_780

label_745:                                                  ; address: 0x1e32

        movlb   0x02
        movf    0x4f, W                                     ; reg: 0x14f
        movlb   0x00
        addwf   0x2e, W                                     ; reg: 0x02e
        movwf   0x5d                                        ; reg: 0x05d
        movf    0x2f, W                                     ; reg: 0x02f
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        incf    0x2f, W                                     ; reg: 0x02f
        movwf   0x5e                                        ; reg: 0x05e
        movlb   0x03
        movf    0x44, W                                     ; reg: 0x1c4
        movlb   0x00
        subwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_746
        movlb   0x03
        movf    0x43, W                                     ; reg: 0x1c3
        movlb   0x00
        subwf   0x5d, W                                     ; reg: 0x05d

label_746:                                                  ; address: 0x1e45

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        btfss   0x3f, 0x3                                   ; reg: 0x03f
        ljmp    label_751
        btfss   0x3f, 0x6                                   ; reg: 0x03f
        ljmp    label_751
        movlw   0x0a

label_747:                                                  ; address: 0x1e4b

        movlb   0x03
        movwf   0x45                                        ; reg: 0x1c5
        clrf    0x46                                        ; reg: 0x1c6

label_748:                                                  ; address: 0x1e4e

        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x03
        ljmp    label_750

label_749:                                                  ; address: 0x1e52

        lslf    0x45, F                                     ; reg: 0x045
        rlf     0x46, F                                     ; reg: 0x046

label_750:                                                  ; address: 0x1e54

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_749
        ljmp    label_776

label_751:                                                  ; address: 0x1e57

        fcall    function_082
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_752
        movlw   0x74
        subwf   0x5f, W                                     ; reg: 0x05f

label_752:                                                  ; address: 0x1e5d

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_768
        movlb   0x00
        btfss   0x3f, 0x6                                   ; reg: 0x03f
        ljmp    label_753
        bsf     0x3f, 0x4                                   ; reg: 0x03f
        bcf     0x3f, 0x6                                   ; reg: 0x03f

label_753:                                                  ; address: 0x1e64

        clrf    0x61                                        ; reg: 0x061

label_754:                                                  ; address: 0x1e65

        lslf    0x61, W                                     ; reg: 0x061
        addlw   0xe2
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa8
        fcall    function_078
        ;movlp   0x1c

function_076:                                               ; address: 0x1e6b

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_755
        incf    0x61, F                                     ; reg: 0x061
        ljmp    label_754

label_755:                                                  ; address: 0x1e6f

        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_756
        movlw   0x21
        subwf   0x2c, W                                     ; reg: 0x02c

label_756:                                                  ; address: 0x1e75

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_758

label_757:                                                  ; address: 0x1e77

        movlb   0x00
        clrf    0x61                                        ; reg: 0x061
        ljmp    label_767

label_758:                                                  ; address: 0x1e7a

        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_759
        movlw   0x19
        subwf   0x2c, W                                     ; reg: 0x02c

label_759:                                                  ; address: 0x1e81

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_761
        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_760
        movlw   0x21
        subwf   0x2c, W                                     ; reg: 0x02c

label_760:                                                  ; address: 0x1e8a

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_761
        movlb   0x00
        movf    0x61, W                                     ; reg: 0x061
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_761
        decf    0x61, F                                     ; reg: 0x061
        ljmp    label_767

label_761:                                                  ; address: 0x1e92

        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_762
        movlw   0x10
        subwf   0x2c, W                                     ; reg: 0x02c

label_762:                                                  ; address: 0x1e99

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_764
        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_763
        movlw   0x19
        subwf   0x2c, W                                     ; reg: 0x02c

label_763:                                                  ; address: 0x1ea2

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_767

label_764:                                                  ; address: 0x1ea4

        movlb   0x00
        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_765
        movlw   0x10
        subwf   0x2c, W                                     ; reg: 0x02c

label_765:                                                  ; address: 0x1eab

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_766
        movlb   0x00
        btfsc   0x2d, 0x7                                   ; reg: 0x02d
        ljmp    label_766
        movlw   0x08
        subwf   0x61, W                                     ; reg: 0x061
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_766
        incf    0x61, F                                     ; reg: 0x061
        ljmp    label_775

label_766:                                                  ; address: 0x1eb6

        movlb   0x00
        btfss   0x2d, 0x7                                   ; reg: 0x02d
        ljmp    label_767
        movlw   0x07
        subwf   0x61, W                                     ; reg: 0x061
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_767
        movlw   0x03
        addwf   0x61, F                                     ; reg: 0x061

label_767:                                                  ; address: 0x1ebf

        movlb   0x00
        movf    0x61, W                                     ; reg: 0x061
        ljmp    label_747

label_768:                                                  ; address: 0x1ec2

        movlw   0x01
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xf3
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_773
        clrf    0x61                                        ; reg: 0x061

label_769:                                                  ; address: 0x1ecb

        lslf    0x61, W                                     ; reg: 0x061
        addlw   0xe4
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa8
        fcall    function_078
        ;movlp   0x1c
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_770
        incf    0x61, F                                     ; reg: 0x061
        ljmp    label_769

label_770:                                                  ; address: 0x1ed5

        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_771
        movlw   0x05
        subwf   0x2c, W                                     ; reg: 0x02c

label_771:                                                  ; address: 0x1edb

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_772
        movlb   0x00
        movf    0x61, W                                     ; reg: 0x061
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_772
        movlw   0xff
        addwf   0x61, F                                     ; reg: 0x061

label_772:                                                  ; address: 0x1ee3

        movlb   0x00
        fcall    function_085
        ;movlp   0x1c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x46, F                                     ; reg: 0x046
        ljmp    label_748

label_773:                                                  ; address: 0x1ee9

        fcall    function_079
        ;movlp   0x1c
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_774
        movlw   0x03
        subwf   0x2c, W                                     ; reg: 0x02c

label_774:                                                  ; address: 0x1eef

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_757
        movlb   0x00
        clrf    0x61                                        ; reg: 0x061

label_775:                                                  ; address: 0x1ef3

        incf    0x61, F                                     ; reg: 0x061
        ljmp    label_767

label_776:                                                  ; address: 0x1ef5

        movlw   0x02
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x12
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_778
        movf    0x2d, W                                     ; reg: 0x02d
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x80
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_777
        movlw   0x01
        subwf   0x2c, W                                     ; reg: 0x02c

label_777:                                                  ; address: 0x1f06

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_778
        movlb   0x00
        bsf     0x3b, 0x1                                   ; reg: 0x03b

label_778:                                                  ; address: 0x1f0a

        movlb   0x02
        movf    0x34, W                                     ; reg: 0x134
        iorwf   0x33, W                                     ; reg: 0x133
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_786
        movlw   0x01
        movlb   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xd1
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_786
        movf    0x2d, W                                     ; reg: 0x02d
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x80
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_779
        movlw   0x01
        subwf   0x2c, W                                     ; reg: 0x02c

label_779:                                                  ; address: 0x1f20

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_786
        movlb   0x00
        bsf     0x3b, 0x1                                   ; reg: 0x03b
        ljmp    label_786

label_780:                                                  ; address: 0x1f25

        bcf     0x3b, 0x1                                   ; reg: 0x03b

label_781:                                                  ; address: 0x1f26

        clrf    0x61                                        ; reg: 0x061

label_782:                                                  ; address: 0x1f27

        lslf    0x61, W                                     ; reg: 0x061
        addlw   0xf8
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa8
        fcall    function_078
        ;movlp   0x1c
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_783
        incf    0x61, F                                     ; reg: 0x061
        ljmp    label_782

label_783:                                                  ; address: 0x1f31

        fcall    function_085
        ;movlp   0x1c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x46, F                                     ; reg: 0x046
        movlb   0x00
        incf    0x5c, W                                     ; reg: 0x05c
        movlb   0x03
        ljmp    label_785

label_784:                                                  ; address: 0x1f39

        lslf    0x45, F                                     ; reg: 0x045
        rlf     0x46, F                                     ; reg: 0x046

label_785:                                                  ; address: 0x1f3b

        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_784
        movlb   0x00
        btfss   0x3f, 0x5                                   ; reg: 0x03f
        ljmp    label_786
        bcf     0x3f, 0x5                                   ; reg: 0x03f
        bsf     0x3f, 0x4                                   ; reg: 0x03f

label_786:                                                  ; address: 0x1f42

        movlb   0x00
        btfss   0x36, 0x3                                   ; reg: 0x036
        ljmp    label_787
        movlw   0x03
        movlb   0x01
        movwf   0x4a                                        ; reg: 0x0ca
        ljmp    label_795

label_787:                                                  ; address: 0x1f49

        movf    0x2f, W                                     ; reg: 0x02f
        iorwf   0x2e, W                                     ; reg: 0x02e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x3d, 0x0                                   ; reg: 0x03d
        ljmp    label_788
        btfsc   0x3d, 0x7                                   ; reg: 0x03d
        ljmp    label_795

label_788:                                                  ; address: 0x1f50

        movlb   0x01
        clrf    0x4a                                        ; reg: 0x0ca
        ljmp    label_795

label_789:                                                  ; address: 0x1f53

        movlb   0x00
        movf    0x2f, W                                     ; reg: 0x02f
        iorwf   0x2e, W                                     ; reg: 0x02e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfsc   0x36, 0x3                                   ; reg: 0x036
        ljmp    label_796
        btfss   0x3d, 0x7                                   ; reg: 0x03d
        ljmp    label_796
        movf    0x2f, W                                     ; reg: 0x02f
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_790
        movf    0x2e, W                                     ; reg: 0x02e
        subwf   0x2a, W                                     ; reg: 0x02a

label_790:                                                  ; address: 0x1f61

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_791
        incf    0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2f, W                                     ; reg: 0x02f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_792

label_791:                                                  ; address: 0x1f68

        btfss   0x3d, 0x0                                   ; reg: 0x03d
        ljmp    label_796
        movlb   0x01
        clrf    0x4a                                        ; reg: 0x0ca
        incf    0x4a, F                                     ; reg: 0x0ca
        ljmp    label_796

label_792:                                                  ; address: 0x1f6e

        movlw   0x02
        movlb   0x01
        movwf   0x4a                                        ; reg: 0x0ca
        ljmp    label_796

label_793:                                                  ; address: 0x1f72

        movlb   0x00
        bsf     0x43, 0x0                                   ; reg: 0x043
        movf    0x2f, W                                     ; reg: 0x02f
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_794
        movf    0x2e, W                                     ; reg: 0x02e
        subwf   0x2a, W                                     ; reg: 0x02a

label_794:                                                  ; address: 0x1f7a

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_796
        incf    0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2f, W                                     ; reg: 0x02f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_792
        ljmp    label_796

label_795:                                                  ; address: 0x1f82

        movlb   0x01
        movf    0x4a, W                                     ; reg: 0x0ca
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_789
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_793
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_789
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_789

label_796:                                                  ; address: 0x1f90

        movlb   0x01
        bcf     CCP2IE                                ; reg: 0x092, bit: 0
        movlb   0x03
        movf    0x46, W                                     ; reg: 0x1c6
        movlb   0x02
        movwf   0x36                                        ; reg: 0x136
        movlb   0x03
        movf    0x45, W                                     ; reg: 0x1c5
        movlb   0x02
        movwf   0x35                                        ; reg: 0x135
        movlb   0x01
        bsf     CCP2IE                                ; reg: 0x092, bit: 0
        return

function_077:                                               ; address: 0x1f9d

        movlb   0x00
        movf    0x2f, W                                     ; reg: 0x02f
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        movf    0x2e, W                                     ; reg: 0x02e
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_797
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        subwf   0x2a, W                                     ; reg: 0x02a

label_797:                                                  ; address: 0x1fa8

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_798
        incf    0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        incf    0x2f, W                                     ; reg: 0x02f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        retlw   0x00

label_798:                                                  ; address: 0x1faf

        movf    0x2f, W                                     ; reg: 0x02f
        iorwf   0x2e, W                                     ; reg: 0x02e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfss   0x3d, 0x7                                   ; reg: 0x03d
        retlw   0x00
        btfss   0x36, 0x3                                   ; reg: 0x036
        retlw   0x01
        retlw   0x00

function_078:                                               ; address: 0x1fb7

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movwf   0x5d                                        ; reg: 0x05d
        moviw   1[FSR0]
        movwf   0x5e                                        ; reg: 0x05e
        subwf   0x60, W                                     ; reg: 0x060
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x5f, W                                     ; reg: 0x05f
        return

function_079:                                               ; address: 0x1fc4

        movf    0x2d, W                                     ; reg: 0x02d
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x80
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        return

function_080:                                               ; address: 0x1fca

        movwf   0x5d                                        ; reg: 0x05d
        movlw   0x00
        addwfc  0x2f, W                                     ; reg: 0x02f
        movwf   0x5e                                        ; reg: 0x05e
        movf    0x2b, W                                     ; reg: 0x02b
        subwf   0x5e, W                                     ; reg: 0x05e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movf    0x2a, W                                     ; reg: 0x02a
        subwf   0x5d, W                                     ; reg: 0x05d
        return

function_081:                                               ; address: 0x1fd5

        movwf   0x5d                                        ; reg: 0x05d
        movlw   0xff
        addwfc  0x2f, W                                     ; reg: 0x02f
        movwf   0x5e                                        ; reg: 0x05e
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x2a, W                                     ; reg: 0x02a
        return

function_082:                                               ; address: 0x1fdf

        movf    0x60, W                                     ; reg: 0x060
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x80
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        return

function_083:                                               ; address: 0x1fe5

        movf    0x2f, W                                     ; reg: 0x02f
        movwf   0x60                                        ; reg: 0x060
        movf    0x2e, W                                     ; reg: 0x02e
        movwf   0x5f                                        ; reg: 0x05f
        movf    0x2a, W                                     ; reg: 0x02a
        subwf   0x5f, F                                     ; reg: 0x05f
        movf    0x2b, W                                     ; reg: 0x02b
        subwfb  0x60, F                                     ; reg: 0x060
        return

function_084:                                               ; address: 0x1fee

        movf    0x2d, W                                     ; reg: 0x02d
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x7f
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        return

function_085:                                               ; address: 0x1ff4

        movf    0x61, W                                     ; reg: 0x061
        movlb   0x03
        movwf   0x45                                        ; reg: 0x1c5
        clrf    0x46                                        ; reg: 0x1c6
        incf    0x45, F                                     ; reg: 0x1c5
        return

function_086:                                               ; address: 0x1ffa

        movf    0x3c, W                                     ; reg: 0x03c
        xorlw   0x80
        movwf   (Common_RAM + 15)                           ; reg: 0x07f
        movlw   0x80
        subwf   (Common_RAM + 15), W                        ; reg: 0x07f
        return

function_087:                                               ; address: 0x2313

        movlb   0x03
        movf    0x53, W                                     ; reg: 0x1d3
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x54, W                                     ; reg: 0x1d4
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x55, W                                     ; reg: 0x1d5
        movlb   0x00
        movwf   0x25                                        ; reg: 0x025
        movlb   0x03
        movf    0x56, W                                     ; reg: 0x1d6
        movlb   0x00
        movwf   0x24                                        ; reg: 0x024
        movf    0x27, W                                     ; reg: 0x027
        movlb   0x01
        movwf   0x23                                        ; reg: 0x0a3
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x01
        movwf   0x22                                        ; reg: 0x0a2
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x01
        movwf   0x21                                        ; reg: 0x0a1
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x01
        movwf   0x20                                        ; reg: 0x0a0
        movlb   0x03
        movf    0x57, W                                     ; reg: 0x1d7
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x58, W                                     ; reg: 0x1d8
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x59, W                                     ; reg: 0x1d9
        movlb   0x00
        movwf   0x25                                        ; reg: 0x025
        movlb   0x03
        movf    0x5a, W                                     ; reg: 0x1da
        movlb   0x00
        movwf   0x24                                        ; reg: 0x024
        movf    0x27, W                                     ; reg: 0x027
        movlb   0x01
        movwf   0x27                                        ; reg: 0x0a7
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x01
        movwf   0x26                                        ; reg: 0x0a6
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x01
        movwf   0x25                                        ; reg: 0x0a5
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x01
        movwf   0x24                                        ; reg: 0x0a4
        movlb   0x03
        movf    0x5d, W                                     ; reg: 0x1dd
        movlb   0x01
        movwf   0x2a                                        ; reg: 0x0aa
        movlb   0x03
        movf    0x5e, W                                     ; reg: 0x1de
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x5f, W                                     ; reg: 0x1df
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x60, W                                     ; reg: 0x1e0
        movlb   0x00
        movwf   0x25                                        ; reg: 0x025
        movlb   0x03
        movf    0x61, W                                     ; reg: 0x1e1
        movlb   0x00
        movwf   0x24                                        ; reg: 0x024
        movf    0x27, W                                     ; reg: 0x027
        movlb   0x01
        movwf   0x2e                                        ; reg: 0x0ae
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x01
        movwf   0x2d                                        ; reg: 0x0ad
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x01
        movwf   0x2c                                        ; reg: 0x0ac
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x01
        movwf   0x2b                                        ; reg: 0x0ab
        movlb   0x03
        movf    0x62, W                                     ; reg: 0x1e2
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x63, W                                     ; reg: 0x1e3
        movlb   0x00
        movwf   0x26                                        ; reg: 0x026
        movlb   0x03
        movf    0x64, W                                     ; reg: 0x1e4
        movlb   0x00
        movwf   0x25                                        ; reg: 0x025
        movlb   0x03
        movf    0x65, W                                     ; reg: 0x1e5
        movlb   0x00
        movwf   0x24                                        ; reg: 0x024
        movf    0x27, W                                     ; reg: 0x027
        movlb   0x01
        movwf   0x32                                        ; reg: 0x0b2
        movlb   0x00
        movf    0x26, W                                     ; reg: 0x026
        movlb   0x01
        movwf   0x31                                        ; reg: 0x0b1
        movlb   0x00
        movf    0x25, W                                     ; reg: 0x025
        movlb   0x01
        movwf   0x30                                        ; reg: 0x0b0
        movlb   0x00
        movf    0x24, W                                     ; reg: 0x024
        movlb   0x01
        movwf   0x2f                                        ; reg: 0x0af
        movlb   0x03
        movf    0x66, W                                     ; reg: 0x1e6
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x67, W                                     ; reg: 0x1e7
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x01
        movwf   0x34                                        ; reg: 0x0b4
        movf    0x76, W                                     ; reg: 0x0f6
        movwf   0x33                                        ; reg: 0x0b3
        movlb   0x03
        movf    0x68, W                                     ; reg: 0x1e8
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x69, W                                     ; reg: 0x1e9
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x01
        movwf   0x36                                        ; reg: 0x0b6
        movf    0x76, W                                     ; reg: 0x0f6
        movwf   0x35                                        ; reg: 0x0b5
        movlb   0x03
        movf    0x5b, W                                     ; reg: 0x1db
        movwf   0x77                                        ; reg: 0x1f7
        movf    0x5c, W                                     ; reg: 0x1dc
        movwf   0x76                                        ; reg: 0x1f6
        movf    0x77, W                                     ; reg: 0x1f7
        movlb   0x01
        movwf   0x29                                        ; reg: 0x0a9
        movf    0x76, W                                     ; reg: 0x0f6
        movwf   0x28                                        ; reg: 0x0a8
        return

function_088:                                               ; address: 0x23b2

        movlb   0x00
        bcf     TMR2IF                                ; reg: 0x011, bit: 1
        movlw   0x0c
        movlb   0x01
        iorwf   TRISC, F                                    ; reg: 0x08e
        ljmp    label_636
        movlw   0x9b
        movlb   0x00
        andwf   0x5a, F                                     ; reg: 0x05a
        btfsc   RC0                                  ; reg: 0x00e, bit: 0
        bsf     0x5a, 0x5                                   ; reg: 0x05a
        bsf     RC5                                  ; reg: 0x00e, bit: 5
        movlb   0x01
        bcf     TRISC5                               ; reg: 0x08e, bit: 5
        bsf     TRISC4                               ; reg: 0x08e, bit: 4
        movlb   0x00
        btfss   0x42, 0x3                                   ; reg: 0x042
        ljmp    label_621
        bcf     RC2                                  ; reg: 0x00e, bit: 2
        movlb   0x01
        bcf     TRISC2                               ; reg: 0x08e, bit: 2
        ljmp    label_622
        bsf     RC2                                  ; reg: 0x00e, bit: 2
        movlb   0x01
        bsf     TRISC2                               ; reg: 0x08e, bit: 2
        movlb   0x00
        btfss   0x42, 0x2                                   ; reg: 0x042
        ljmp    label_624
        bcf     RC3                                  ; reg: 0x00e, bit: 3
        movlb   0x01
        bcf     TRISC3                               ; reg: 0x08e, bit: 3
        ljmp    label_626
        bsf     RC3                                  ; reg: 0x00e, bit: 3
        movlb   0x01
        bsf     TRISC3                               ; reg: 0x08e, bit: 3
        movlb   0x02
        clrf    0x6b                                        ; reg: 0x16b
        incf    0x6b, F                                     ; reg: 0x16b
        ljmp    label_639
        movlw   0xb2
        movlb   0x00
        andwf   0x5a, F                                     ; reg: 0x05a
        btfsc   RC0                                  ; reg: 0x00e, bit: 0
        bsf     0x5a, 0x0                                   ; reg: 0x05a
        btfsc   RA7                                  ; reg: 0x00c, bit: 7
        bsf     0x5a, 0x3                                   ; reg: 0x05a
        movlb   0x01
        bsf     TRISC5                               ; reg: 0x08e, bit: 5
        movlb   0x00
        bsf     RC4                                  ; reg: 0x00e, bit: 4
        movlb   0x01
        bcf     TRISC4                               ; reg: 0x08e, bit: 4
        movlb   0x00
        btfss   0x42, 0x5                                   ; reg: 0x042
        ljmp    label_632
        bcf     RC2                                  ; reg: 0x00e, bit: 2
        movlb   0x01
        bcf     TRISC2                               ; reg: 0x08e, bit: 2
        ljmp    label_633
        bsf     RC2                                  ; reg: 0x00e, bit: 2
        movlb   0x01
        bsf     TRISC2                               ; reg: 0x08e, bit: 2
        movlb   0x00
        btfss   0x42, 0x4                                   ; reg: 0x042
        ljmp    label_635
        bcf     RC3                                  ; reg: 0x00e, bit: 3
        movlb   0x01
        bcf     TRISC3                               ; reg: 0x08e, bit: 3
        ljmp    label_638
        bsf     RC3                                  ; reg: 0x00e, bit: 3
        movlb   0x01
        bsf     TRISC3                               ; reg: 0x08e, bit: 3
        ljmp    label_638
        movlb   0x02
        movf    0x6b, W                                     ; reg: 0x16b
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_618
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_628
        movlb   0x02
        clrf    0x6b                                        ; reg: 0x16b
        movlb   0x00
        btfsc   RB2                                  ; reg: 0x00d, bit: 2
        bsf     0x5a, 0x6                                   ; reg: 0x05a
        btfsc   RB0                                  ; reg: 0x00d, bit: 0
        bsf     0x5a, 0x2                                   ; reg: 0x05a
        movlb   0x01
        movf    0x64, W                                     ; reg: 0x0e4
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_641
        decfsz  0x64, F                                     ; reg: 0x064
        ljmp    label_641
        bsf     0x1d, 0x1                                   ; reg: 0x01d
        movlb   0x00
        btfss   RB5                                  ; reg: 0x00d, bit: 5
        ljmp    label_667
        btfsc   0x3c, 0x0                                   ; reg: 0x03c
        ljmp    label_688
        movlb   0x01
        decfsz  0x65, F                                     ; reg: 0x0e5
        ljmp    label_689
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_648
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x06
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_644
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_644
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_648
        movlw   0x33
        movlb   0x01
        subwf   0x40, W                                     ; reg: 0x0c0
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_649
        incf    0x40, F                                     ; reg: 0x040
        ljmp    label_649
        movlw   0x33
        movlb   0x01
        subwf   0x40, W                                     ; reg: 0x0c0
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_649
        movlb   0x00
        bcf     0x3f, 0x3                                   ; reg: 0x03f
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    function_075
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    function_075
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    function_075
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    function_075
        movlw   0x0a
        subwf   0x59, W                                     ; reg: 0x059
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_655
        incf    0x59, F                                     ; reg: 0x059
        decfsz  0x59, W                                     ; reg: 0x059
        ljmp    label_651
        movlw   0xbc
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        movlw   0x02
        ljmp    function_073
        movf    0x59, W                                     ; reg: 0x059
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_653
        movlw   0xf4
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        movlw   0x01
        movwf   0x42                                        ; reg: 0x142
        ljmp    label_666
        btfss   0x22, 0x0                                   ; reg: 0x022
        btfsc   0x3e, 0x6                                   ; reg: 0x03e
        ljmp    label_652
        movlw   0x23
        ljmp    label_662
        btfss   0x22, 0x0                                   ; reg: 0x022
        ljmp    label_656
        bcf     0x22, 0x0                                   ; reg: 0x022
        bsf     0x51, 0x4                                   ; reg: 0x051
        movlw   0x46
        ljmp    label_662
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_658
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_657
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_658
        movlw   0x2d
        ljmp    label_662
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_654
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_664
        movlw   0xc8
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        clrf    0x42                                        ; reg: 0x142
        ljmp    label_666
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_665
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_661
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_652
        movlb   0x00
        bsf     0x3c, 0x0                                   ; reg: 0x03c
        bsf     0x39, 0x0                                   ; reg: 0x039
        ljmp    label_688
        btfss   0x3c, 0x0                                   ; reg: 0x03c
        ljmp    label_688
        movlb   0x01
        decfsz  0x65, F                                     ; reg: 0x0e5
        ljmp    label_689
        movlb   0x00
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_679
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_679
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_679
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_679
        movlw   0x0a
        subwf   0x59, W                                     ; reg: 0x059
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_676
        incf    0x59, F                                     ; reg: 0x059
        decfsz  0x59, W                                     ; reg: 0x059
        ljmp    label_670
        movlw   0xbc
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        movlw   0x02
        ljmp    label_672
        movf    0x59, W                                     ; reg: 0x059
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_673
        movlw   0xf4
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        movlw   0x01
        movwf   0x42                                        ; reg: 0x142
        ljmp    label_687
        btfss   0x22, 0x0                                   ; reg: 0x022
        btfsc   0x3e, 0x6                                   ; reg: 0x03e
        ljmp    label_671
        movlw   0x23
        ljmp    label_683
        bcf     0x3e, 0x6                                   ; reg: 0x03e
        movlw   0x46
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        clrf    0x42                                        ; reg: 0x142
        movlb   0x00
        btfss   0x22, 0x0                                   ; reg: 0x022
        ljmp    label_687
        bcf     0x22, 0x0                                   ; reg: 0x022
        bsf     0x51, 0x4                                   ; reg: 0x051
        ljmp    label_687
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_681
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x04
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_680
        movf    0x4d, W                                     ; reg: 0x04d
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_681
        movlw   0x2d
        ljmp    label_683
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0c
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_675
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_684
        movlw   0xc8
        movlb   0x02
        movwf   0x41                                        ; reg: 0x141
        clrf    0x42                                        ; reg: 0x142
        ljmp    label_687
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_686
        btfsc   0x41, 0x4                                   ; reg: 0x041
        ljmp    label_682
        movf    0x4f, W                                     ; reg: 0x04f
        xorlw   0x0b
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_671
        movlb   0x00
        bcf     0x3c, 0x0                                   ; reg: 0x03c
        movlw   0x03
        movlb   0x01
        movwf   0x65                                        ; reg: 0x0e5
        movlb   0x02
        decfsz  0x66, F                                     ; reg: 0x166
        return
        movlw   0x0a
        movwf   0x66                                        ; reg: 0x166
        movlb   0x00
        bsf     0x3a, 0x0                                   ; reg: 0x03a
        return

function_089:                                               ; address: 0x2503

        movlb   0x00
        btfss   0x39, 0x3                                   ; reg: 0x039
        ljmp    label_716
        bcf     0x39, 0x3                                   ; reg: 0x039
        lslf    0x45, W                                     ; reg: 0x045
        addlw   0xb9
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        movlb   0x03
        movf    0x3d, W                                     ; reg: 0x1bd
        addwf   INDF1, F                                    ; reg: 0x001
        addfsr  FSR1, 1
        movf    0x3e, W                                     ; reg: 0x1be
        addwfc  INDF1, F                                    ; reg: 0x001
        addfsr  FSR1, -1
        movlb   0x00
        incf    0x45, F                                     ; reg: 0x045
        movlw   0x02
        subwf   0x45, W                                     ; reg: 0x045
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_713
        clrf    0x45                                        ; reg: 0x045
        movlb   0x02
        incf    0x4b, F                                     ; reg: 0x14b
        movlw   0x20
        subwf   0x4b, W                                     ; reg: 0x14b
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_713
        movlb   0x03
        movf    0x3a, W                                     ; reg: 0x1ba
        movlb   0x00
        movwf   0x2b                                        ; reg: 0x02b
        movlb   0x03
        movf    0x39, W                                     ; reg: 0x1b9
        movlb   0x00
        movwf   0x2a                                        ; reg: 0x02a
        movlw   0x05
        lsrf    0x2b, F                                     ; reg: 0x02b
        rrf     0x2a, F                                     ; reg: 0x02a
        decfsz  WREG, F                                     ; reg: 0x009
        ljmp    label_695
        movlb   0x02
        incf    0x6c, F                                     ; reg: 0x16c
        movlw   0x05
        subwf   0x6c, W                                     ; reg: 0x16c
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_708
        clrf    0x6c                                        ; reg: 0x06c
        movlb   0x00
        movf    0x2b, W                                     ; reg: 0x02b
        movwf   0x2d                                        ; reg: 0x02d
        movf    0x2a, W                                     ; reg: 0x02a
        movwf   0x2c                                        ; reg: 0x02c
        movlb   0x03
        movf    0x41, W                                     ; reg: 0x1c1
        movlb   0x00
        subwf   0x2c, F                                     ; reg: 0x02c
        movlb   0x03
        movf    0x42, W                                     ; reg: 0x1c2
        movlb   0x00
        subwfb  0x2d, F                                     ; reg: 0x02d
        movf    0x2b, W                                     ; reg: 0x02b
        movlb   0x03
        movwf   0x42                                        ; reg: 0x1c2
        movlb   0x00
        movf    0x2a, W                                     ; reg: 0x02a
        movlb   0x03
        movwf   0x41                                        ; reg: 0x1c1
        movlb   0x00
        btfss   0x3f, 0x1                                   ; reg: 0x03f
        ljmp    label_706
        movf    0x2d, W                                     ; reg: 0x02d
        movlb   0x03
        movwf   0x44                                        ; reg: 0x1c4
        movlb   0x00
        movf    0x2c, W                                     ; reg: 0x02c
        movlb   0x03
        movwf   0x43                                        ; reg: 0x1c3
        swapf   0x43, F                                     ; reg: 0x1c3
        swapf   0x44, F                                     ; reg: 0x1c4
        movlw   0xf0
        andwf   0x44, F                                     ; reg: 0x1c4
        movf    0x43, W                                     ; reg: 0x1c3
        andlw   0x0f
        iorwf   0x44, F                                     ; reg: 0x1c4
        movlw   0xf0
        andwf   0x43, F                                     ; reg: 0x1c3
        movlb   0x00
        movf    0x2a, W                                     ; reg: 0x02a
        movlb   0x03
        addwf   0x43, F                                     ; reg: 0x1c3
        movlb   0x00
        movf    0x2b, W                                     ; reg: 0x02b
        movlb   0x03
        addwfc  0x44, F                                     ; reg: 0x1c4
        ljmp    label_708
        movlb   0x03
        clrf    0x43                                        ; reg: 0x1c3
        clrf    0x44                                        ; reg: 0x1c4
        movlb   0x02
        clrf    0x4b                                        ; reg: 0x14b
        movlb   0x00
        clrf    0x6d                                        ; reg: 0x06d
        lslf    0x6d, W                                     ; reg: 0x06d
        addlw   0xb9
        movwf   FSR1L                                       ; reg: 0x006
        movlw   0x01
        movwf   FSR1H                                       ; reg: 0x007
        clrf    INDF1                                       ; reg: 0x001
        addfsr  FSR1, 1
        clrf    INDF1                                       ; reg: 0x001
        incf    0x6d, F                                     ; reg: 0x06d
        movlw   0x02
        subwf   0x6d, W                                     ; reg: 0x06d
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_709
        movlb   0x00
        movf    0x45, W                                     ; reg: 0x045
        addlw   0x41
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa9
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        movf    INDF0, W                                    ; reg: 0x000
        iorlw   0x01
        movlb   0x01
        movwf   ADCON0                                      ; reg: 0x09d
        movlb   0x00
        bcf     ADIF                                  ; reg: 0x011, bit: 6
        movlb   0x01
        bsf     ADIE                                  ; reg: 0x091, bit: 6
        movlw   0x05
        movwf   0x64                                        ; reg: 0x0e4
        movlb   0x00
        btfss   0x3a, 0x3                                   ; reg: 0x03a
        return
        movlw   0x03
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0xc3
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_718
        movlw   0xc8
        ljmp    label_726
        movlw   0x00
        subwf   0x2b, W                                     ; reg: 0x02b
        movlw   0x1f
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        subwf   0x2a, W                                     ; reg: 0x02a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_720
        movlb   0x02
        clrf    0x56                                        ; reg: 0x156
        ljmp    label_727
        clrf    0x6d                                        ; reg: 0x06d

label_799:                                                  ; address: 0x25a1

        fcall    function_076
        ;movlp   0x25
        fcall    function_093
        ;movlp   0x25
        subwf   0x2b, W                                     ; reg: 0x02b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_800
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        subwf   0x2a, W                                     ; reg: 0x02a

label_800:                                                  ; address: 0x25aa

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_801
        incf    0x6d, F                                     ; reg: 0x06d
        ljmp    label_799

label_801:                                                  ; address: 0x25ae

        fcall    function_092
        ;movlp   0x25
        subwf   0x2a, W                                     ; reg: 0x02a
        movwf   0x5d                                        ; reg: 0x05d
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        subwfb  0x2b, W                                     ; reg: 0x02b
        fcall    function_095
        ;movlp   0x25
        fcall    function_090
        ;movlp   0x25
        fcall    function_091
        ;movlp   0x25
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_802
        movlw   0x00
        subwf   0x6b, W                                     ; reg: 0x06b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_802
        movlw   0x01
        subwf   0x6a, W                                     ; reg: 0x06a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_802
        movlw   0x00
        subwf   0x69, W                                     ; reg: 0x069

label_802:                                                  ; address: 0x25c6

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_803
        movlw   0xff
        ljmp    label_804

label_803:                                                  ; address: 0x25ca

        movf    0x69, W                                     ; reg: 0x069

label_804:                                                  ; address: 0x25cb

        movlb   0x02
        movwf   0x56                                        ; reg: 0x156
        movlb   0x00
        clrf    0x6d                                        ; reg: 0x06d

label_805:                                                  ; address: 0x25cf

        fcall    function_094
        ;movlp   0x25
        fcall    function_093
        ;movlp   0x25
        subwf   0x2f, W                                     ; reg: 0x02f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_806
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        subwf   0x2e, W                                     ; reg: 0x02e

label_806:                                                  ; address: 0x25d8

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_807
        incf    0x6d, F                                     ; reg: 0x06d
        ljmp    label_805

label_807:                                                  ; address: 0x25dc

        fcall    function_092
        ;movlp   0x25
        subwf   0x2e, W                                     ; reg: 0x02e
        movwf   0x5d                                        ; reg: 0x05d
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        subwfb  0x2f, W                                     ; reg: 0x02f
        fcall    function_095
        ;movlp   0x25
        fcall    function_090
        ;movlp   0x25
        fcall    function_091
        ;movlp   0x25
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_808
        movlw   0x00
        subwf   0x6b, W                                     ; reg: 0x06b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_808
        movlw   0x01
        subwf   0x6a, W                                     ; reg: 0x06a
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_808
        movlw   0x00
        subwf   0x69, W                                     ; reg: 0x069

label_808:                                                  ; address: 0x25f4

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_809
        movlw   0xff
        movlb   0x02
        movwf   0x5a                                        ; reg: 0x15a
        return

label_809:                                                  ; address: 0x25fa

        movf    0x69, W                                     ; reg: 0x069
        movlb   0x02
        movwf   0x5a                                        ; reg: 0x15a
        return

function_090:                                               ; address: 0x25fe

        clrf    0x65                                        ; reg: 0x065
        clrf    0x66                                        ; reg: 0x066
        clrf    0x67                                        ; reg: 0x067
        clrf    0x68                                        ; reg: 0x068

label_810:                                                  ; address: 0x2602

        btfss   0x5d, 0x0                                   ; reg: 0x05d
        ljmp    label_811
        movf    0x61, W                                     ; reg: 0x061
        addwf   0x65, F                                     ; reg: 0x065
        movf    0x62, W                                     ; reg: 0x062
        addwfc  0x66, F                                     ; reg: 0x066
        movf    0x63, W                                     ; reg: 0x063
        addwfc  0x67, F                                     ; reg: 0x067
        movf    0x64, W                                     ; reg: 0x064
        addwfc  0x68, F                                     ; reg: 0x068

label_811:                                                  ; address: 0x260c

        lslf    0x61, F                                     ; reg: 0x061
        rlf     0x62, F                                     ; reg: 0x062
        rlf     0x63, F                                     ; reg: 0x063
        rlf     0x64, F                                     ; reg: 0x064
        lsrf    0x60, F                                     ; reg: 0x060
        rrf     0x5f, F                                     ; reg: 0x05f
        rrf     0x5e, F                                     ; reg: 0x05e
        rrf     0x5d, F                                     ; reg: 0x05d
        movf    0x60, W                                     ; reg: 0x060
        iorwf   0x5f, W                                     ; reg: 0x05f
        iorwf   0x5e, W                                     ; reg: 0x05e
        iorwf   0x5d, W                                     ; reg: 0x05d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_810
        movf    0x68, W                                     ; reg: 0x068
        movwf   0x60                                        ; reg: 0x060
        movf    0x67, W                                     ; reg: 0x067
        movwf   0x5f                                        ; reg: 0x05f
        movf    0x66, W                                     ; reg: 0x066
        movwf   0x5e                                        ; reg: 0x05e
        movf    0x65, W                                     ; reg: 0x065
        movwf   0x5d                                        ; reg: 0x05d
        return

function_091:                                               ; address: 0x2623

        movf    0x60, W                                     ; reg: 0x060
        movwf   0x6c                                        ; reg: 0x06c
        movf    0x5f, W                                     ; reg: 0x05f
        movwf   0x6b                                        ; reg: 0x06b
        movf    0x5e, W                                     ; reg: 0x05e
        movwf   0x6a                                        ; reg: 0x06a
        movf    0x5d, W                                     ; reg: 0x05d
        movwf   0x69                                        ; reg: 0x069
        movf    0x6a, W                                     ; reg: 0x06a
        movwf   0x69                                        ; reg: 0x069
        movf    0x6b, W                                     ; reg: 0x06b
        movwf   0x6a                                        ; reg: 0x06a
        movf    0x6c, W                                     ; reg: 0x06c
        movwf   0x6b                                        ; reg: 0x06b
        clrf    0x6c                                        ; reg: 0x06c
        movf    0x6d, W                                     ; reg: 0x06d
        addlw   0xa3
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa8
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        movf    INDF0, W                                    ; reg: 0x000
        addwf   0x69, F                                     ; reg: 0x069
        movlw   0x01
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addwf   0x6a, F                                     ; reg: 0x06a
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addwf   0x6b, F                                     ; reg: 0x06b
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addwf   0x6c, F                                     ; reg: 0x06c
        movlw   0x00
        subwf   0x6c, W                                     ; reg: 0x06c
        return

function_092:                                               ; address: 0x2645

        lslf    0x6d, W                                     ; reg: 0x06d
        addlw   0x53
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa8
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        moviw   1[FSR0]
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        movwf   0x69                                        ; reg: 0x069
        movf    (Common_RAM + 5), W                         ; reg: 0x075
        movwf   0x6a                                        ; reg: 0x06a
        clrf    0x6b                                        ; reg: 0x06b
        clrf    0x6c                                        ; reg: 0x06c
        lslf    0x6d, W                                     ; reg: 0x06d
        addlw   0x01
        movwf   FSR0L                                       ; reg: 0x004
        movlw   0xa8
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        moviw   1[FSR0]
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        movf    (Common_RAM + 4), W                         ; reg: 0x074
        return

function_093:                                               ; address: 0x2663

        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        addlw   0x01
        movwf   FSR0H                                       ; reg: 0x005
        moviw   0[FSR0]
        movwf   (Common_RAM + 4)                            ; reg: 0x074
        moviw   1[FSR0]
        movwf   (Common_RAM + 5)                            ; reg: 0x075
        return

function_094:                                               ; address: 0x266b

        lslf    0x6d, W                                     ; reg: 0x06d
        addlw   0x03
        movwf   FSR0L                                       ; reg: 0x004
        retlw   0xa8

function_095:                                               ; address: 0x266f

        movwf   0x5e                                        ; reg: 0x05e
        clrf    0x5f                                        ; reg: 0x05f
        clrf    0x60                                        ; reg: 0x060
        movf    0x6c, W                                     ; reg: 0x06c
        movwf   0x64                                        ; reg: 0x064
        movf    0x6b, W                                     ; reg: 0x06b
        movwf   0x63                                        ; reg: 0x063
        movf    0x6a, W                                     ; reg: 0x06a
        movwf   0x62                                        ; reg: 0x062
        movf    0x69, W                                     ; reg: 0x069
        movwf   0x61                                        ; reg: 0x061
        return

function_096:                                               ; address: 0x267b

        movlb   0x00
        movf    0x4b, F                                     ; reg: 0x04b
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_812
        movlb   0x01
        clrf    0x49                                        ; reg: 0x0c9
        clrf    0x3d                                        ; reg: 0x0bd
        clrf    0x3e                                        ; reg: 0x0be
        ljmp    label_832

label_812:                                                  ; address: 0x2684

        btfss   (Common_RAM + 9), 0x3                       ; reg: 0x079
        ljmp    label_813
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_813
        movlb   0x01
        fcall    function_100
        ;movlp   0x26
        movf    0x28, W                                     ; reg: 0x028
        movlb   0x02
        movwf   0x2d                                        ; reg: 0x12d
        movlb   0x01
        movf    0x29, W                                     ; reg: 0x0a9
        ljmp    label_814

label_813:                                                  ; address: 0x2691

        btfss   (Common_RAM + 9), 0x6                       ; reg: 0x079
        ljmp    label_815
        movlb   0x01
        fcall    function_100
        ;movlp   0x26
        movf    0x33, W                                     ; reg: 0x033
        movlb   0x02
        movwf   0x2d                                        ; reg: 0x12d
        movlb   0x01
        movf    0x34, W                                     ; reg: 0x0b4

label_814:                                                  ; address: 0x269b

        movlb   0x02
        movwf   0x2e                                        ; reg: 0x12e
        clrf    0x2f                                        ; reg: 0x12f
        clrf    0x30                                        ; reg: 0x130
        ljmp    label_832

label_815:                                                  ; address: 0x26a0

        btfss   (Common_RAM + 9), 0x5                       ; reg: 0x079
        ljmp    label_817
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_817
        movlb   0x01
        fcall    function_100
        ;movlp   0x26
        movf    0x35, W                                     ; reg: 0x035
        movlb   0x02
        movwf   0x2d                                        ; reg: 0x12d
        movlb   0x01
        movf    0x36, W                                     ; reg: 0x0b6
        movlb   0x02
        movwf   0x2e                                        ; reg: 0x12e
        clrf    0x2f                                        ; reg: 0x12f
        clrf    0x30                                        ; reg: 0x130
        movlw   0x00
        subwf   0x30, W                                     ; reg: 0x130
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_816
        movlw   0x01
        subwf   0x2f, W                                     ; reg: 0x02f
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_816
        movlw   0x86
        subwf   0x2e, W                                     ; reg: 0x02e
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_816
        movlw   0xa0
        subwf   0x2d, W                                     ; reg: 0x02d

label_816:                                                  ; address: 0x26be

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_832
        clrf    0x30                                        ; reg: 0x030
        movlw   0x01
        movwf   0x2f                                        ; reg: 0x02f
        movlw   0x86
        movwf   0x2e                                        ; reg: 0x02e
        movlw   0x9f
        movwf   0x2d                                        ; reg: 0x02d
        ljmp    label_832

label_817:                                                  ; address: 0x26c8

        btfss   (Common_RAM + 9), 0x0                       ; reg: 0x079
        ljmp    label_832
        decfsz  0x4b, W                                     ; reg: 0x04b
        ljmp    label_832
        movlb   0x01
        fcall    function_100
        ;movlp   0x26
        movf    0x2a, W                                     ; reg: 0x02a
        movlb   0x02
        movwf   0x2d                                        ; reg: 0x12d
        clrf    0x2e                                        ; reg: 0x12e
        clrf    0x2f                                        ; reg: 0x12f
        clrf    0x30                                        ; reg: 0x130
        ljmp    label_832

label_818:                                                  ; address: 0x26d6

        movf    0x3e, W                                     ; reg: 0x03e
        iorwf   0x3d, W                                     ; reg: 0x03d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlb   0x00
        movf    0x47, F                                     ; reg: 0x047
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_819
        movlw   0x0a
        fcall    function_099
        ;movlp   0x26
        movlb   0x02
        movf    0x30, W                                     ; reg: 0x130
        movlb   0x04
        movwf   0x35                                        ; reg: 0x235
        movlb   0x02
        movf    0x2f, W                                     ; reg: 0x12f
        movlb   0x04
        movwf   0x34                                        ; reg: 0x234
        movlb   0x02
        movf    0x2e, W                                     ; reg: 0x12e
        movlb   0x04
        movwf   0x33                                        ; reg: 0x233
        movlb   0x02
        movf    0x2d, W                                     ; reg: 0x12d
        ljmp    label_824

label_819:                                                  ; address: 0x26f0

        decfsz  0x47, W                                     ; reg: 0x047
        ljmp    label_820
        movlw   0x0a
        fcall    function_099
        ;movlp   0x26
        ljmp    label_821

label_820:                                                  ; address: 0x26f6

        movf    0x47, W                                     ; reg: 0x047
        xorlw   0x02
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_822
        movlw   0x0a
        fcall    function_099
        ;movlp   0x26
        movlw   0x64

label_821:                                                  ; address: 0x26fe

        movlb   0x00
        movwf   0x5d                                        ; reg: 0x05d
        clrf    0x5e                                        ; reg: 0x05e
        clrf    0x5f                                        ; reg: 0x05f
        clrf    0x60                                        ; reg: 0x060
        ljmp    label_823

label_822:                                                  ; address: 0x2704

        movf    0x47, W                                     ; reg: 0x047
        xorlw   0x03
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_825
        movlw   0x0a
        fcall    function_099
        ;movlp   0x26
        movlb   0x00
        clrf    0x60                                        ; reg: 0x060
        clrf    0x5f                                        ; reg: 0x05f
        movlw   0x03
        movwf   0x5e                                        ; reg: 0x05e
        movlw   0xe8
        movwf   0x5d                                        ; reg: 0x05d

label_823:                                                  ; address: 0x2712

        movlb   0x02
        movf    0x30, W                                     ; reg: 0x130
        movlb   0x00
        movwf   0x64                                        ; reg: 0x064
        movlb   0x02
        movf    0x2f, W                                     ; reg: 0x12f
        movlb   0x00
        movwf   0x63                                        ; reg: 0x063
        movlb   0x02
        movf    0x2e, W                                     ; reg: 0x12e
        movlb   0x00
        movwf   0x62                                        ; reg: 0x062
        movlb   0x02
        movf    0x2d, W                                     ; reg: 0x12d
        movlb   0x00
        movwf   0x61                                        ; reg: 0x061
        fcall    function_098
        ;movlp   0x26
        movf    0x60, W                                     ; reg: 0x060
        movlb   0x04
        movwf   0x35                                        ; reg: 0x235
        movlb   0x00
        movf    0x5f, W                                     ; reg: 0x05f
        movlb   0x04
        movwf   0x34                                        ; reg: 0x234
        movlb   0x00
        movf    0x5e, W                                     ; reg: 0x05e
        movlb   0x04
        movwf   0x33                                        ; reg: 0x233
        movlb   0x00
        movf    0x5d, W                                     ; reg: 0x05d

label_824:                                                  ; address: 0x2731

        movlb   0x04
        movwf   0x32                                        ; reg: 0x232
        fcall    function_097
        ;movlp   0x26
        movf    0x2e, W                                     ; reg: 0x02e
        movlb   0x00
        movwf   0x58                                        ; reg: 0x058

label_825:                                                  ; address: 0x2738

        movf    0x58, W                                     ; reg: 0x058
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_827
        movlb   0x01
        incf    0x49, F                                     ; reg: 0x0c9

label_826:                                                  ; address: 0x273d

        movlw   0x46
        movwf   0x3d                                        ; reg: 0x03d
        clrf    0x3e                                        ; reg: 0x03e
        return

label_827:                                                  ; address: 0x2741

        movlw   0x03
        subwf   0x47, W                                     ; reg: 0x047
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_828
        incf    0x47, F                                     ; reg: 0x047
        return

label_828:                                                  ; address: 0x2747

        clrf    0x47                                        ; reg: 0x047
        movlw   0x90
        movlb   0x01
        movwf   0x3d                                        ; reg: 0x0bd
        movlw   0x01
        movwf   0x3e                                        ; reg: 0x0be
        return

label_829:                                                  ; address: 0x274e

        movf    0x3e, W                                     ; reg: 0x03e
        iorwf   0x3d, W                                     ; reg: 0x03d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlw   0x1e
        movwf   0x3d                                        ; reg: 0x03d
        clrf    0x3e                                        ; reg: 0x03e
        incf    0x49, F                                     ; reg: 0x049
        return

label_830:                                                  ; address: 0x2757

        movf    0x3e, W                                     ; reg: 0x03e
        iorwf   0x3d, W                                     ; reg: 0x03d
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        movlb   0x00
        decf    0x58, F                                     ; reg: 0x058
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_831
        movlb   0x01
        decf    0x49, F                                     ; reg: 0x0c9
        ljmp    label_826

label_831:                                                  ; address: 0x2762

        movlb   0x01
        clrf    0x49                                        ; reg: 0x0c9
        incf    0x49, F                                     ; reg: 0x0c9
        movlw   0x03
        movlb   0x00
        subwf   0x47, W                                     ; reg: 0x047
        btfsc   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_828
        incf    0x47, F                                     ; reg: 0x047
        movlw   0xc8
        movlb   0x01
        movwf   0x3d                                        ; reg: 0x0bd
        clrf    0x3e                                        ; reg: 0x0be
        return

label_832:                                                  ; address: 0x2770

        movlb   0x01
        movf    0x49, W                                     ; reg: 0x0c9
        xorlw   0x00
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        xorlw   0x01
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_818
        xorlw   0x03
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_829
        xorlw   0x01
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        return
        ljmp    label_830

function_097:                                               ; address: 0x277f

        movf    0x31, W                                     ; reg: 0x031
        iorwf   0x30, W                                     ; reg: 0x030
        iorwf   0x2f, W                                     ; reg: 0x02f
        iorwf   0x2e, W                                     ; reg: 0x02e
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_837
        clrf    (Common_RAM + 4)                            ; reg: 0x074

label_833:                                                  ; address: 0x2786

        incf    (Common_RAM + 4), F                         ; reg: 0x074
        btfsc   0x31, 0x7                                   ; reg: 0x031
        ljmp    label_834
        lslf    0x2e, F                                     ; reg: 0x02e
        rlf     0x2f, F                                     ; reg: 0x02f
        rlf     0x30, F                                     ; reg: 0x030
        rlf     0x31, F                                     ; reg: 0x031
        ljmp    label_833

label_834:                                                  ; address: 0x278e

        movf    0x31, W                                     ; reg: 0x031
        subwf   0x35, W                                     ; reg: 0x035
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_835
        movf    0x30, W                                     ; reg: 0x030
        subwf   0x34, W                                     ; reg: 0x034
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_835
        movf    0x2f, W                                     ; reg: 0x02f
        subwf   0x33, W                                     ; reg: 0x033
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_835
        movf    0x2e, W                                     ; reg: 0x02e
        subwf   0x32, W                                     ; reg: 0x032

label_835:                                                  ; address: 0x279c

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_836
        movf    0x2e, W                                     ; reg: 0x02e
        subwf   0x32, F                                     ; reg: 0x032
        movf    0x2f, W                                     ; reg: 0x02f
        subwfb  0x33, F                                     ; reg: 0x033
        movf    0x30, W                                     ; reg: 0x030
        subwfb  0x34, F                                     ; reg: 0x034
        movf    0x31, W                                     ; reg: 0x031
        subwfb  0x35, F                                     ; reg: 0x035

label_836:                                                  ; address: 0x27a6

        lsrf    0x31, F                                     ; reg: 0x031
        rrf     0x30, F                                     ; reg: 0x030
        rrf     0x2f, F                                     ; reg: 0x02f
        rrf     0x2e, F                                     ; reg: 0x02e
        decfsz  (Common_RAM + 4), F                         ; reg: 0x074
        ljmp    label_834

label_837:                                                  ; address: 0x27ac

        movf    0x35, W                                     ; reg: 0x035
        movwf   0x31                                        ; reg: 0x031
        movf    0x34, W                                     ; reg: 0x034
        movwf   0x30                                        ; reg: 0x030
        movf    0x33, W                                     ; reg: 0x033
        movwf   0x2f                                        ; reg: 0x02f
        movf    0x32, W                                     ; reg: 0x032
        movwf   0x2e                                        ; reg: 0x02e
        return

function_098:                                               ; address: 0x27b5

        clrf    0x65                                        ; reg: 0x065
        clrf    0x66                                        ; reg: 0x066
        clrf    0x67                                        ; reg: 0x067
        clrf    0x68                                        ; reg: 0x068
        movf    0x60, W                                     ; reg: 0x060
        iorwf   0x5f, W                                     ; reg: 0x05f
        iorwf   0x5e, W                                     ; reg: 0x05e
        iorwf   0x5d, W                                     ; reg: 0x05d
        btfsc   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_842
        clrf    0x69                                        ; reg: 0x069

label_838:                                                  ; address: 0x27c0

        incf    0x69, F                                     ; reg: 0x069
        btfsc   0x60, 0x7                                   ; reg: 0x060
        ljmp    label_839
        lslf    0x5d, F                                     ; reg: 0x05d
        rlf     0x5e, F                                     ; reg: 0x05e
        rlf     0x5f, F                                     ; reg: 0x05f
        rlf     0x60, F                                     ; reg: 0x060
        ljmp    label_838

label_839:                                                  ; address: 0x27c8

        lslf    0x65, F                                     ; reg: 0x065
        rlf     0x66, F                                     ; reg: 0x066
        rlf     0x67, F                                     ; reg: 0x067
        rlf     0x68, F                                     ; reg: 0x068
        movf    0x60, W                                     ; reg: 0x060
        subwf   0x64, W                                     ; reg: 0x064
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_840
        movf    0x5f, W                                     ; reg: 0x05f
        subwf   0x63, W                                     ; reg: 0x063
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_840
        movf    0x5e, W                                     ; reg: 0x05e
        subwf   0x62, W                                     ; reg: 0x062
        btfss   STATUS,  0x2                                   ; reg: 0x003, bit: 2
        ljmp    label_840
        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x61, W                                     ; reg: 0x061

label_840:                                                  ; address: 0x27da

        btfss   STATUS, 0x0                                   ; reg: 0x003, bit: 0
        ljmp    label_841
        movf    0x5d, W                                     ; reg: 0x05d
        subwf   0x61, F                                     ; reg: 0x061
        movf    0x5e, W                                     ; reg: 0x05e
        subwfb  0x62, F                                     ; reg: 0x062
        movf    0x5f, W                                     ; reg: 0x05f
        subwfb  0x63, F                                     ; reg: 0x063
        movf    0x60, W                                     ; reg: 0x060
        subwfb  0x64, F                                     ; reg: 0x064
        bsf     0x65, 0x0                                   ; reg: 0x065

label_841:                                                  ; address: 0x27e5

        lsrf    0x60, F                                     ; reg: 0x060
        rrf     0x5f, F                                     ; reg: 0x05f
        rrf     0x5e, F                                     ; reg: 0x05e
        rrf     0x5d, F                                     ; reg: 0x05d
        decfsz  0x69, F                                     ; reg: 0x069
        ljmp    label_839

label_842:                                                  ; address: 0x27eb

        movf    0x68, W                                     ; reg: 0x068
        movwf   0x60                                        ; reg: 0x060
        movf    0x67, W                                     ; reg: 0x067
        movwf   0x5f                                        ; reg: 0x05f
        movf    0x66, W                                     ; reg: 0x066
        movwf   0x5e                                        ; reg: 0x05e
        movf    0x65, W                                     ; reg: 0x065
        movwf   0x5d                                        ; reg: 0x05d
        return

function_099:                                               ; address: 0x27f4

        movlb   0x04
        movwf   0x2e                                        ; reg: 0x22e
        clrf    0x2f                                        ; reg: 0x22f
        clrf    0x30                                        ; reg: 0x230
        clrf    0x31                                        ; reg: 0x231
        return

function_100:                                               ; address: 0x27fa

        clrf    0x49                                        ; reg: 0x049
        incf    0x49, F                                     ; reg: 0x049
        movlb   0x00
        clrf    0x47                                        ; reg: 0x047
        movlb   0x01
        return
        retlw   0x00
        retlw   0x1e
        retlw   0x00
        retlw   0x27
        retlw   0x00
        retlw   0x31
        retlw   0x00
        retlw   0x3d
        retlw   0x00
        retlw   0x4c
        retlw   0x00
        retlw   0x5d
        retlw   0x00
        retlw   0x72
        retlw   0x00
        retlw   0x89
        retlw   0x00
        retlw   0xa3
        retlw   0x00
        retlw   0xc0
        retlw   0x00
        retlw   0xe0
        retlw   0x00
        retlw   0x03
        retlw   0x01
        retlw   0x28
        retlw   0x01
        retlw   0x4f
        retlw   0x01
        retlw   0x77
        retlw   0x01
        retlw   0xa0
        retlw   0x01
        retlw   0xc9
        retlw   0x01
        retlw   0xf2
        retlw   0x01
        retlw   0x1a
        retlw   0x02
        retlw   0x40
        retlw   0x02
        retlw   0x66
        retlw   0x02
        retlw   0x89
        retlw   0x02
        retlw   0xaa
        retlw   0x02
        retlw   0xc8
        retlw   0x02
        retlw   0xe5
        retlw   0x02
        retlw   0xff
        retlw   0x02
        retlw   0x17
        retlw   0x03
        retlw   0x2d
        retlw   0x03
        retlw   0x41
        retlw   0x03
        retlw   0x53
        retlw   0x03
        retlw   0x63
        retlw   0x03
        retlw   0x72
        retlw   0x03
        retlw   0x7f
        retlw   0x03
        retlw   0x8b
        retlw   0x03
        retlw   0x96
        retlw   0x03
        retlw   0xa0
        retlw   0x03
        retlw   0xa8
        retlw   0x03
        retlw   0xb0
        retlw   0x03
        retlw   0xb7
        retlw   0x03
        retlw   0xbd
        retlw   0x03
        retlw   0xc3
        retlw   0x03
        retlw   0x8e
        retlw   0x00
        retlw   0x80
        retlw   0x00
        retlw   0x6a
        retlw   0x00
        retlw   0x55
        retlw   0x00
        retlw   0x4b
        retlw   0x00
        retlw   0x3c
        retlw   0x00
        retlw   0x37
        retlw   0x00
        retlw   0x31
        retlw   0x00
        retlw   0x2c
        retlw   0x00
        retlw   0x28
        retlw   0x00
        retlw   0x24
        retlw   0x00
        retlw   0x22
        retlw   0x00
        retlw   0x20
        retlw   0x00
        retlw   0x20
        retlw   0x00
        retlw   0x1f
        retlw   0x00
        retlw   0x1f
        retlw   0x00
        retlw   0x1f
        retlw   0x00
        retlw   0x20
        retlw   0x00
        retlw   0x21
        retlw   0x00
        retlw   0x21
        retlw   0x00
        retlw   0x24
        retlw   0x00
        retlw   0x26
        retlw   0x00
        retlw   0x2a
        retlw   0x00
        retlw   0x2c
        retlw   0x00
        retlw   0x31
        retlw   0x00
        retlw   0x35
        retlw   0x00
        retlw   0x3a
        retlw   0x00
        retlw   0x40
        retlw   0x00
        retlw   0x47
        retlw   0x00
        retlw   0x50
        retlw   0x00
        retlw   0x55
        retlw   0x00
        retlw   0x62
        retlw   0x00
        retlw   0x6a
        retlw   0x00
        retlw   0x74
        retlw   0x00
        retlw   0x80
        retlw   0x00
        retlw   0xa0
        retlw   0x00
        retlw   0xa0
        retlw   0x00
        retlw   0xb6
        retlw   0x00
        retlw   0xd5
        retlw   0x00
        retlw   0xd5
        retlw   0x00
        retlw   0x00
        retlw   0x05
        retlw   0x0a
        retlw   0x0f
        retlw   0x14
        retlw   0x19
        retlw   0x1e
        retlw   0x23
        retlw   0x28
        retlw   0x2d
        retlw   0x32
        retlw   0x37
        retlw   0x3c
        retlw   0x41
        retlw   0x46
        retlw   0x4b
        retlw   0x50
        retlw   0x55
        retlw   0x5a
        retlw   0x5f
        retlw   0x64
        retlw   0x69
        retlw   0x6e
        retlw   0x73
        retlw   0x78
        retlw   0x7d
        retlw   0x82
        retlw   0x87
        retlw   0x8c
        retlw   0x91
        retlw   0x96
        retlw   0x9b
        retlw   0xa0
        retlw   0xa5
        retlw   0xaa
        retlw   0xaf
        retlw   0xb4
        retlw   0xb9
        retlw   0xbe
        retlw   0xc3
        retlw   0xc8
        retlw   0x00
        retlw   0x00
        retlw   0x01
        retlw   0x00
        retlw   0x02
        retlw   0x00
        retlw   0x03
        retlw   0x00
        retlw   0x04
        retlw   0x00
        retlw   0x05
        retlw   0x00
        retlw   0x06
        retlw   0x00
        retlw   0x07
        retlw   0x00
        retlw   0x08
        retlw   0x00
        retlw   0x09
        retlw   0x00
        retlw   0x0a
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x61
        retlw   0x00
        retlw   0xab
        retlw   0x00
        retlw   0xc3
        retlw   0x00
        retlw   0xeb
        retlw   0x00
        retlw   0x1f
        retlw   0x01
        retlw   0x34
        retlw   0x01
        retlw   0x42
        retlw   0x01
        retlw   0x55
        retlw   0x01
        retlw   0x62
        retlw   0x01
        retlw   0x00
        retlw   0x00
        retlw   0x0f
        retlw   0x00
        retlw   0x1f
        retlw   0x00
        retlw   0x50
        retlw   0x00
        retlw   0x60
        retlw   0x00
        retlw   0x68
        retlw   0x00
        retlw   0x91
        retlw   0x00
        retlw   0x91
        retlw   0x00
        retlw   0xa2
        retlw   0x00
        retlw   0xba
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x09
        retlw   0x00
        retlw   0x10
        retlw   0x00
        retlw   0x22
        retlw   0x00
        retlw   0x36
        retlw   0x00
        retlw   0x4c
        retlw   0x00
        retlw   0x20
        retlw   0xa1
        retlw   0x07
        retlw   0x00
        retlw   0x40
        retlw   0x0d
        retlw   0x03
        retlw   0x00
        retlw   0x80
        retlw   0x38
        retlw   0x01
        retlw   0x00
        retlw   0x00
        retlw   0x01
        retlw   0x02
        retlw   0x03
        retlw   0x04
        retlw   0x05
        retlw   0x06
        retlw   0x07
        retlw   0x08
        retlw   0x09
        retlw   0x0a
        retlw   0x1c
        retlw   0x02
        retlw   0x08
        retlw   0x07
        retlw   0x30
        retlw   0x2a
        retlw   0x08
        retlw   0x00
        retlw   0x00
        retlw   0x00
        retlw   0x08
        retlw   0x00
        retlw   0x00
        retlw   0x04

;===============================================================================
; EEDATA area
;
;        ; eeprom
;
;        org     __EEPROM_START                              ; address: 0xf000
;
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x60                                        ; '`'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0xcc
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x6e                                        ; 'n'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x6e                                        ; 'n'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x5a                                        ; 'Z'
;        db      0x00
;        db      0x01
;        db      0x00
;        db      0x2c                                        ; ','
;        db      0x00
;        db      0xa9
;        db      0x00
;        db      0x24                                        ; '$'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x60                                        ; '`'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0xcc
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x6e                                        ; 'n'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x6e                                        ; 'n'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x5a                                        ; 'Z'
;        db      0x00
;        db      0x01
;        db      0x00
;        db      0x2c                                        ; ','
;        db      0x00
;        db      0xa9
;        db      0x00
;        db      0x24                                        ; '$'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x04
;        db      0x00
;        db      0x26                                        ; '&'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x0a
;        db      0x00
;        db      0x57                                        ; 'W'
;        db      0x00
;        db      0x0d
;        db      0x00
;        db      0x06
;        db      0x00
;        db      0x06
;        db      0x00
;        db      0xdf
;        db      0x00
;        db      0x73                                        ; 's'
;        db      0x00
;        db      0x03
;        db      0x00
;        db      0x03
;        db      0x00
;        db      0x0c
;        db      0x00
;        db      0x72                                        ; 'r'
;        db      0x00
;        db      0x0c
;        db      0x00
;        db      0x72                                        ; 'r'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x19
;        db      0x00
;        db      0xca
;        db      0x00
;        db      0x6d                                        ; 'm'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x04
;        db      0x00
;        db      0x26                                        ; '&'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x0a
;        db      0x00
;        db      0x57                                        ; 'W'
;        db      0x00
;        db      0x0d
;        db      0x00
;        db      0x06
;        db      0x00
;        db      0x06
;        db      0x00
;        db      0xdf
;        db      0x00
;        db      0x73                                        ; 's'
;        db      0x00
;        db      0x03
;        db      0x00
;        db      0x03
;        db      0x00
;        db      0x0c
;        db      0x00
;        db      0x72                                        ; 'r'
;        db      0x00
;        db      0x0c
;        db      0x00
;        db      0x72                                        ; 'r'
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x19
;        db      0x00
;        db      0xca
;        db      0x00
;        db      0x6d                                        ; 'm'
;        db      0x00
;        db      0x02
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x01
;        db      0x00
;        db      0x18
;        db      0x00
;        db      0x36                                        ; '6'
;        db      0x00
;        db      0x02
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x00
;        db      0x01
;        db      0x00
;        db      0x18
;        db      0x00
;        db      0x36                                        ; '6'
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;        db      0xff
;        db      0x00
;
;        end

	END vector_reset