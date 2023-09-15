PROCESSOR   16F1938
PAGEWIDTH   132
RADIX       DEC

#include <xc.inc>
;#include "p16f1938.inc
    
	
	
;INDF0    EQU 0x000  
;INDF1    EQU 0x001  
;PCL      EQU 0x002  
;STATUS   EQU 0x003  
;FSR0L     EQU 0x004  
;FSR0H    EQU 0x005  
;FSR1L     EQU 0x006  
;FSR1H    EQU 0x007  
;BSR      EQU 0x008  
;WREG     EQU 0x009  
;PCLATH   EQU 0x00A  
;INTCON   EQU 0x00B  
;PORTA    EQU 0x00C  
;PORTB    EQU 0x00D  
;PORTC    EQU 0x00E  
;        
;PORTE    EQU 0x010  
;PIR1     EQU 0x011  
;PIR2     EQU 0x012  
;PIR3     EQU 0x013  
;         
;TMR0     EQU 0x015  
;TMR1L    EQU 0x016  
;TMR1H    EQU 0x017  
;T1CON    EQU 0x018  
;T1GCON   EQU 0x019  
;TMR2     EQU 0x01A  
;PR2      EQU 0x01B  
;T2CON    EQU 0x01C  
;        
;CPSCON0  EQU 0x01E  
;CPSCON1  EQU 0x01F  

	
; The recognition of labels and registers is not always good, therefore
; be treated cautiously the results.

CONFIG  FOSC     = INTOSC
CONFIG  WDTE     = ON
CONFIG  PWRTE    = ON
CONFIG  MCLRE    = ON
CONFIG  CP       = OFF
CONFIG  CPD      = OFF
CONFIG  BOREN    = ON
CONFIG  CLKOUTEN = OFF
CONFIG  IESO     = OFF
CONFIG  FCMEN    = OFF
CONFIG  WRT      = OFF
;    CONFIG  VCAPEN   = RA6
CONFIG  PLLEN    = OFF
CONFIG  STVREN   = ON
CONFIG  BORV     = LO
;     CONFIG  DEBUG    = OFF
CONFIG  LVP      = OFF
    
PSECT   resetVec,class=CODE,delta=2
MOVLP 0x0                
GOTO 0x38
PSECT   interruptVec,class=CODE,delta=2           
MOVLP 0x0                
BTFSC INTCON, 0x2        
BTFSS INTCON, 0x5        
GOTO 0xB                 
MOVLP 0x7                
CALL 0x7D5               
RETFIE 
psect code,class=CODE,delta=2            
MOVLB 0x0                
BTFSS PIR2, 0x0          
GOTO 0x14                
MOVLB 0x1                
BTFSS PIR2, 0x0          
GOTO 0x14                
MOVLP 0x1A               
CALL 0x2C7               
RETFIE                   
MOVLB 0x0                
BTFSS PIR1, 0x1          
GOTO 0x1D                
MOVLB 0x1                
BTFSS PIR1, 0x1          
GOTO 0x1D                
MOVLP 0x23               
CALL 0x3B2               
RETFIE                   
MOVLB 0x0                
BTFSS PIR1, 0x6          
GOTO 0x26                
MOVLB 0x1                
BTFSS PIR1, 0x6          
GOTO 0x26                
MOVLP 0x8                
CALL 0x0                 
RETFIE                   
MOVLB 0x0                
BTFSS PIR1, 0x5          
GOTO 0x2F                
MOVLB 0x1                
BTFSS PIR1, 0x5          
GOTO 0x2F                
MOVLP 0x10               
CALL 0x1C                
RETFIE                   
MOVLB 0x0                
BTFSS PIR1, 0x4          
RETFIE                   
MOVLB 0x1                
BTFSS PIR1, 0x4          
RETFIE                   
MOVLP 0x10               
CALL 0x7                 
RETFIE                   
CLRF BSR                 
MOVLP 0x8                
GOTO 0xC                 
MOVLB 0x2                
MOVF 0x6E, W             
MOVLB 0x3                
MOVWF 0x50               
MOVLB 0x2                
MOVF 0x6D, W             
MOVLB 0x3                
MOVWF 0x4F               
MOVLB 0x0                
BCF 0x3E, 0x1            
CALL 0x7C1               
MOVLP 0x0                
MOVLB 0x0                
MOVF 0x4F, W             
BTFSS STATUS, 0x2        
BSF PORTB, 0x1           
MOVF 0x79, W             
BTFSS STATUS, 0x2        
BTFSC 0x79, 0x6          
GOTO 0x5A                
MOVF 0x4F, F             
BTFSS STATUS, 0x2        
GOTO 0x5A                
MOVLW 0xA                
MOVWF 0x4F               
CLRF 0x4D                
MOVLW 0x1E               
MOVWF 0x57               
MOVLB 0x1                
CLRF 0x42                
GOTO 0x68                
MOVLB 0x2                
MOVF 0x6E, W             
IORWF 0x6D, W            
BTFSS STATUS, 0x2        
GOTO 0x68                
MOVLB 0x0                
CLRF 0x4F                
CLRF 0x4D                
BCF PORTB, 0x1           
MOVLB 0x1                
CLRF 0x42                
INCF 0x42, F             
MOVLB 0x0                
BCF 0x41, 0x4            
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x7C                
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x7C                
BTFSS 0x3A, 0x4          
GOTO 0x88                
MOVLB 0x2                
MOVF 0x6E, W             
IORWF 0x6D, W            
BTFSC STATUS, 0x2        
GOTO 0x88                
MOVLW 0x1                
SUBWF 0x6D, F            
MOVLW 0x0                
SUBWFB 0x6E, F           
GOTO 0x88                
LSLF 0x21, W             
ADDLW 0x35               
MOVWF FSR0L               
MOVLW 0xA9               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVLB 0x2                
MOVWF 0x6D               
MOVIW 1[FSR0]            
MOVWF 0x6E               
MOVLB 0x0                
BTFSS 0x3B, 0x6          
GOTO 0x9A                
BCF 0x3B, 0x6            
BTFSC 0x78, 0x3          
BTFSS 0x78, 0x6          
GOTO 0x97                
MOVLW 0x32               
MOVLB 0x1                
MOVWF 0x5D               
MOVLW 0x10               
MOVLB 0x0                
MOVWF 0x4F               
CLRF 0x4D                
INCF 0x4D, F             
MOVLB 0x2                
CLRF 0x51                
INCF 0x51, F             
MOVLB 0x0                
MOVF 0x5B, W             
BTFSC STATUS, 0x2        
GOTO 0xBC                
MOVF 0x50, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0xA6                
MOVF 0x50, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0xB1                
BTFSS 0x3A, 0x4          
GOTO 0xB1                
DECF 0x5B, F             
GOTO 0xB1                
MOVLP 0x26               
CALL 0x67B               
MOVLP 0x0                
GOTO 0x462               
CALL 0x75D               
MOVLP 0x0                
GOTO 0x462               
MOVF 0x50, W             
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x462               
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0xAE                
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0xAA                
GOTO 0x462               
MOVLP 0x10               
CALL 0x5F                
MOVLP 0x0                
MOVLB 0x3                
MOVF 0x6D, W             
IORWF 0x6C, W            
BTFSC STATUS, 0x2        
GOTO 0xCD                
MOVLB 0x0                
BTFSS 0x3A, 0x4          
GOTO 0x436               
MOVLW 0x1                
MOVLB 0x3                
SUBWF 0x6C, F            
MOVLW 0x0                
SUBWFB 0x6D, F           
GOTO 0x436               
MOVLB 0x1                
MOVF 0x6F, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x436               
CLRF 0x6F                
INCF 0x6F, F             
GOTO 0x436               
MOVLB 0x1                
CLRF 0x47                
MOVF 0x6F, W             
MOVLB 0x0                
MOVWF 0x2E               
CLRF 0x2F                
MOVLW 0x5                
LSLF 0x2E, F             
RLF 0x2F, F              
DECFSZ WREG, F           
GOTO 0xDC                
MOVLW 0x57               
ADDWF 0x2E, F            
MOVLW 0x2                
ADDWFC 0x2F, F           
MOVF 0x23, F             
BTFSS STATUS, 0x2        
GOTO 0xED                
LSLF 0x23, W             
CALL 0x7AB               
MOVLP 0x0                
SUBWF 0x2E, F            
MOVF 0x6B, W             
SUBWFB 0x2F, F           
MOVF 0x23, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x1F7               
LSLF 0x23, W             
CALL 0x7AB               
MOVLP 0x0                
ADDWF 0x2E, F            
MOVF 0x6B, W             
ADDWFC 0x2F, F           
GOTO 0x1F7               
MOVF 0x2E, W             
ADDLW 0xE1               
MOVWF 0x6A               
MOVLW 0xFF               
ADDWFC 0x2F, W           
MOVWF 0x6B               
MOVF 0x2B, W             
SUBWF 0x6B, W            
BTFSS STATUS, 0x2        
GOTO 0x104               
MOVF 0x2A, W             
SUBWF 0x6A, W            
BTFSC STATUS, 0x0        
GOTO 0x146               
MOVLB 0x1                
MOVF 0x55, F             
BTFSS STATUS, 0x2        
GOTO 0x146               
MOVLW 0x0                
MOVLB 0x2                
SUBWF 0x44, W            
MOVLW 0x33               
BTFSC STATUS, 0x2        
SUBWF 0x43, W            
BTFSC STATUS, 0x0        
GOTO 0x136               
MOVLB 0x0                
MOVF 0x2E, W             
ADDLW 0x8                
MOVWF 0x6A               
MOVLW 0x0                
ADDWFC 0x2F, W           
MOVWF 0x6B               
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x11E               
MOVF 0x6A, W             
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x136               
BTFSS 0x3F, 0x2          
GOTO 0x139               
MOVLW 0x63               
MOVWF 0x2E               
MOVLW 0x3                
MOVWF 0x2F               
MOVLB 0x1                
CLRF 0x4A                
INCF 0x4A, F             
MOVLW 0xA                
MOVLB 0x3                
MOVWF 0x45               
CLRF 0x46                
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x3                
GOTO 0x133               
LSLF 0x45, F             
RLF 0x46, F              
DECFSZ WREG, F           
GOTO 0x131               
GOTO 0x139               
MOVLB 0x0                
CLRF 0x2E                
CLRF 0x2F                
MOVLB 0x2                
MOVF 0x44, W             
IORWF 0x43, W            
BTFSS STATUS, 0x2        
GOTO 0x462               
MOVLW 0xA0               
MOVWF 0x43               
MOVLW 0xF                
MOVWF 0x44               
MOVLB 0x0                
CLRF 0x2E                
CLRF 0x2F                
GOTO 0x462               
MOVLB 0x0                
BSF 0x3F, 0x2            
MOVLW 0xC4               
MOVLB 0x2                
MOVWF 0x43               
MOVLW 0x9                
MOVWF 0x44               
GOTO 0x462               
BSF 0x3E, 0x3            
CLRF 0x34                
CLRF 0x35                
MOVLW 0x78               
MOVLB 0x1                
MOVWF 0x59               
GOTO 0x462               
MOVLW 0x14               
MOVLB 0x1                
MOVWF 0x39               
CLRF 0x3A                
MOVLB 0x0                
BSF 0x3E, 0x2            
MOVLB 0x1                
CLRF 0x47                
MOVLW 0x1E               
GOTO 0x31D               
MOVF 0x35, W             
IORWF 0x34, W            
BTFSC STATUS, 0x2        
BSF 0x3E, 0x3            
MOVLW 0x58               
MOVLB 0x3                
MOVWF 0x6C               
MOVLW 0x2                
MOVWF 0x6D               
GOTO 0x462               
BCF 0x3E, 0x6            
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
MOVF 0x37, F             
BTFSS STATUS, 0x2        
GOTO 0x19B               
MOVLW 0x2                
SUBWF 0x31, W            
MOVLW 0xBD               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
BTFSS 0x3C, 0x7          
GOTO 0x187               
BCF 0x3C, 0x7            
MOVF 0x31, W             
MOVLB 0x2                
MOVWF 0x22               
MOVLB 0x0                
MOVF 0x30, W             
MOVLB 0x2                
MOVWF 0x21               
MOVLP 0x14               
CALL 0x414               
MOVLP 0x0                
MOVLW 0x5                
CALL 0x48E               
MOVLP 0x0                
GOTO 0x15D               
BTFSS 0x3C, 0x7          
GOTO 0x18E               
MOVLW 0xFF               
MOVLB 0x1                
MOVWF 0x39               
MOVWF 0x3A               
GOTO 0x15D               
BTFSC 0x3C, 0x7          
GOTO 0x15D               
MOVLB 0x2                
MOVF 0x22, W             
MOVLB 0x1                
MOVWF 0x3A               
MOVLB 0x2                
MOVF 0x21, W             
MOVLB 0x1                
MOVWF 0x39               
MOVLB 0x0                
BSF 0x3E, 0x2            
GOTO 0x15D               
DECFSZ 0x37, W           
GOTO 0x15D               
MOVLW 0x2                
SUBWF 0x31, W            
MOVLW 0xBD               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
BTFSS 0x3C, 0x7          
GOTO 0x1B2               
BCF 0x3C, 0x7            
MOVLW 0xBC               
MOVLB 0x2                
MOVWF 0x23               
MOVLW 0x2                
MOVWF 0x24               
MOVLP 0x14               
CALL 0x414               
MOVLP 0x0                
MOVLW 0x6                
CALL 0x48E               
MOVLP 0x0                
GOTO 0x15D               
BTFSC 0x3C, 0x7          
GOTO 0x189               
BTFSC 0x3C, 0x7          
GOTO 0x15D               
MOVLB 0x2                
MOVF 0x24, W             
MOVLB 0x1                
MOVWF 0x3A               
MOVLB 0x2                
MOVF 0x23, W             
GOTO 0x196               
MOVF 0x35, W             
IORWF 0x34, W            
BTFSS STATUS, 0x2        
BTFSC 0x79, 0x3          
GOTO 0x1C4               
BTFSS 0x79, 0x0          
GOTO 0x462               
MOVLW 0x6                
MOVWF 0x4D               
MOVLW 0x1E               
GOTO 0x329               
MOVF 0x35, W             
IORWF 0x34, W            
BTFSS STATUS, 0x2        
GOTO 0x1CE               
BSF 0x3E, 0x3            
GOTO 0x462               
MOVF 0x37, F             
BTFSS STATUS, 0x2        
GOTO 0x1D3               
BTFSC 0x78, 0x3          
GOTO 0x1D7               
DECFSZ 0x37, W           
GOTO 0x1DB               
BTFSS 0x78, 0x0          
GOTO 0x1DB               
MOVLW 0xFF               
MOVLB 0x1                
MOVWF 0x39               
MOVWF 0x3A               
MOVLB 0x1                
CLRF 0x47                
GOTO 0x462               
MOVF 0x58, F             
GOTO 0x33E               
MOVLW 0x3C               
MOVLB 0x1                
MOVWF 0x55               
CLRF 0x59                
MOVLB 0x0                
CLRF 0x4D                
BSF 0x3F, 0x5            
BSF 0x3B, 0x4            
MOVLB 0x1                
MOVF 0x6F, W             
BTFSS STATUS, 0x2        
DECF 0x6F, F             
MOVLW 0x1                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0x77               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x462               
CLRF 0x4F                
INCF 0x4F, F             
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0xF8                
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x14E               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x155               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x15F               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x169               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x1BD               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x1C8               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x1DE               
XORLW 0xF                
BTFSC STATUS, 0x2        
GOTO 0x1CC               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x1E0               
GOTO 0x462               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
BTFSC 0x41, 0x4          
GOTO 0x220               
MOVLW 0x40               
MOVWF 0x2E               
MOVLW 0x2                
MOVWF 0x2F               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x22B               
MOVLW 0x1                
SUBWF 0x2B, W            
MOVLW 0xCA               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x462               
GOTO 0x296               
DECFSZ 0x4D, W           
GOTO 0x233               
MOVLW 0x98               
CALL 0x7D0               
MOVLP 0x0                
MOVLB 0x0                
BSF 0x3E, 0x2            
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x23C               
MOVLW 0x3                
MOVWF 0x4F               
CLRF 0x4D                
BSF 0x3D, 0x3            
GOTO 0x462               
CLRF 0x4F                
INCF 0x4F, F             
MOVLB 0x0                
CLRF 0x4D                
GOTO 0x462               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x248               
MOVLW 0x32               
MOVWF 0x34               
CLRF 0x35                
GOTO 0x1CC               
DECFSZ 0x4D, W           
GOTO 0x255               
BTFSS 0x78, 0x5          
GOTO 0x252               
MOVF 0x35, W             
IORWF 0x34, W            
BTFSS STATUS, 0x2        
GOTO 0x462               
MOVLW 0x2                
GOTO 0x25C               
MOVLW 0xC                
MOVWF 0x4F               
GOTO 0x2B2               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x25E               
BTFSS 0x78, 0x6          
GOTO 0x462               
MOVLW 0x3                
MOVWF 0x4D               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x265               
BTFSS 0x78, 0x6          
GOTO 0x250               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x4                
GOTO 0x462               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x275               
MOVLB 0x2                
CLRF 0x50                
MOVLB 0x0                
MOVF 0x35, W             
IORWF 0x34, W            
BTFSS STATUS, 0x2        
GOTO 0x462               
MOVLW 0x3                
MOVWF 0x4F               
GOTO 0x462               
DECFSZ 0x4D, W           
GOTO 0x287               
MOVLW 0x2C               
MOVWF 0x34               
MOVLW 0x1                
MOVWF 0x35               
BCF 0x41, 0x4            
MOVLB 0x1                
CALL 0x79D               
MOVLP 0x0                
MOVLW 0x2                
SUBWF 0x2B, W            
MOVLW 0xAB               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x1CC               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x299               
MOVLB 0x1                
CALL 0x79D               
MOVLP 0x0                
MOVF 0x35, W             
IORWF 0x34, W            
BTFSS STATUS, 0x2        
GOTO 0x296               
MOVLW 0x3                
MOVWF 0x4F               
CLRF 0x4D                
BSF 0x41, 0x4            
BTFSC 0x78, 0x6          
GOTO 0x1CC               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x2B4               
MOVLB 0x1                
CLRF 0x47                
MOVLW 0x63               
MOVLB 0x0                
MOVWF 0x2E               
MOVLW 0x3                
MOVWF 0x2F               
BSF 0x3E, 0x2            
BTFSS 0x78, 0x6          
GOTO 0x2AF               
MOVLW 0x36               
MOVLB 0x1                
MOVWF 0x39               
MOVLW 0x1                
MOVWF 0x3A               
MOVLB 0x0                
BSF 0x41, 0x4            
GOTO 0x230               
BTFSS 0x38, 0x6          
GOTO 0x462               
BCF 0x41, 0x4            
CLRF 0x4D                
GOTO 0x36B               
MOVF 0x4D, W             
XORLW 0x4                
BTFSS STATUS, 0x2        
GOTO 0x2BB               
BTFSC 0x38, 0x6          
GOTO 0x2B2               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x5                
BTFSS STATUS, 0x2        
GOTO 0x462               
BSF 0x3D, 0x1            
MOVLW 0x3                
GOTO 0x422               
MOVLW 0xA                
SUBWF 0x57, W            
BTFSC STATUS, 0x0        
GOTO 0x2CC               
MOVF 0x57, W             
BTFSC STATUS, 0x2        
GOTO 0x2CC               
CLRF 0x4F                
INCF 0x4F, F             
CLRF 0x4D                
BTFSS 0x3F, 0x0          
GOTO 0x2E5               
BCF 0x3F, 0x0            
MOVLW 0x0                
SUBWF 0x2B, W            
MOVLW 0xE1               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x2D8               
BCF 0x3F, 0x3            
GOTO 0x2D9               
BSF 0x3F, 0x3            
MOVLW 0x0                
SUBWF 0x2B, W            
MOVLW 0x8A               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x2E2               
MOVLW 0x4C               
GOTO 0x2E3               
MOVLW 0x90               
MOVLB 0x2                
MOVWF 0x4F               
MOVLW 0x4F               
MOVLB 0x0                
MOVWF 0x2E               
MOVLW 0x2                
MOVWF 0x2F               
MOVLB 0x1                
CLRF 0x47                
GOTO 0x311               
MOVF 0x2F, W             
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x2F3               
MOVF 0x2E, W             
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
BTFSC 0x3B, 0x1          
BSF 0x3E, 0x3            
MOVLB 0x1                
CLRF 0x6F                
MOVLW 0x0                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0xE1               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x304               
MOVLW 0x2                
MOVLB 0x1                
MOVWF 0x6F               
GOTO 0x462               
MOVLW 0x1                
SUBWF 0x2B, W            
MOVLW 0xC9               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x462               
MOVLB 0x1                
CLRF 0x6F                
INCF 0x6F, F             
GOTO 0x462               
MOVF 0x57, F             
GOTO 0x37F               
MOVLB 0x0                
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x2ED               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x30F               
GOTO 0x462               
CALL 0x7B7               
MOVLP 0x0                
MOVLW 0x5A               
MOVLB 0x0                
GOTO 0x329               
CALL 0x7B7               
MOVLP 0x0                
MOVLB 0x0                
GOTO 0x33C               
MOVLW 0xC8               
MOVWF 0x2E               
MOVLW 0x2                
MOVWF 0x2F               
BSF 0x3E, 0x1            
MOVLW 0xFA               
MOVWF 0x34               
CLRF 0x35                
GOTO 0x462               
MOVLW 0x0                
SUBWF 0x35, W            
MOVLW 0x96               
BTFSC STATUS, 0x2        
SUBWF 0x34, W            
MOVF 0x35, W             
IORWF 0x34, W            
BTFSC STATUS, 0x0        
GOTO 0x33E               
BTFSC STATUS, 0x2        
GOTO 0x33C               
MOVLW 0xFF               
MOVLB 0x1                
MOVWF 0x39               
MOVWF 0x3A               
GOTO 0x462               
MOVF 0x35, W             
IORWF 0x34, W            
BTFSC STATUS, 0x2        
GOTO 0x1CC               
GOTO 0x462               
BTFSC 0x22, 0x0          
GOTO 0x345               
BSF 0x22, 0x0            
BSF 0x51, 0x4            
MOVF 0x35, W             
IORWF 0x34, W            
BTFSS STATUS, 0x2        
GOTO 0x462               
CLRF 0x4F                
CLRF 0x4D                
CLRF 0x34                
CLRF 0x35                
BCF PORTB, 0x1           
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x31A               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x31F               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x1CC               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x323               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x32C               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x341               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x462               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x462               
GOTO 0x389               
INCF 0x4D, F             
GOTO 0x462               
MOVLW 0x13               
CALL 0x48E               
MOVLP 0xF                
CALL 0x793               
MOVLP 0x0                
MOVLP 0x14               
CALL 0x404               
MOVLP 0x0                
MOVLB 0x0                
BSF 0x51, 0x4            
CALL 0x6C5               
MOVLP 0x19               
CALL 0x1F6               
MOVLP 0x0                
MOVLB 0x0                
BSF 0x51, 0x3            
GOTO 0x36B               
MOVF 0x58, F             
BTFSC STATUS, 0x2        
GOTO 0x2C0               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x36B               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x36D               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x37E               
GOTO 0x462               
BTFSC 0x36, 0x5          
GOTO 0x3E2               
MOVLW 0x77               
MOVWF 0x2E               
MOVLW 0x1                
MOVWF 0x2F               
GOTO 0x3E2               
NOP                      
GOTO 0x462               
BTFSS 0x3D, 0x5          
GOTO 0x1CC               
GOTO 0x462               
CLRF 0x2E                
CLRF 0x2F                
MOVLW 0xA                
MOVLB 0x1                
MOVWF 0x39               
CLRF 0x3A                
GOTO 0x230               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
BTFSC 0x3D, 0x5          
GOTO 0x1CC               
MOVLW 0x82               
CALL 0x7CA               
MOVLP 0x0                
GOTO 0x230               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
BTFSS 0x3D, 0x5          
GOTO 0x3B4               
MOVLW 0x7E               
MOVLB 0x1                
MOVWF 0x39               
MOVLW 0x4                
MOVWF 0x3A               
GOTO 0x3D3               
MOVLW 0xC8               
GOTO 0x3A6               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
BTFSC 0x3D, 0x5          
GOTO 0x1CC               
MOVLW 0x32               
CALL 0x7CA               
MOVLP 0x0                
INCF 0x58, F             
GOTO 0x230               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
BTFSS 0x3D, 0x5          
GOTO 0x3BB               
MOVLW 0xFA               
MOVLB 0x1                
MOVWF 0x39               
CLRF 0x3A                
GOTO 0x3D2               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x0                
BTFSS 0x3D, 0x5          
GOTO 0x3BB               
MOVLW 0xB6               
CALL 0x7D0               
MOVLP 0x0                
MOVLW 0x4                
MOVLB 0x2                
MOVWF 0x58               
GOTO 0x230               
BTFSC 0x3D, 0x5          
GOTO 0x1CC               
CLRF 0x4D                
BSF 0x3D, 0x5            
GOTO 0x462               
BTFSC 0x22, 0x0          
GOTO 0x3DF               
BSF 0x22, 0x0            
BSF 0x51, 0x4            
BCF 0x43, 0x7            
BCF 0x3D, 0x5            
GOTO 0x23C               
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x394               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x396               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x399               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x3A0               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x3A9               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x3B6               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x3C0               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x3CA               
XORLW 0xF                
BTFSC STATUS, 0x2        
GOTO 0x3B6               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x3B6               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x3B6               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x3D6               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x3DB               
GOTO 0x462               
BTFSC 0x78, 0x6          
GOTO 0x40F               
CLRF 0x4D                
INCF 0x4D, F             
MOVLB 0x1                
MOVF 0x5D, F             
BTFSS STATUS, 0x2        
GOTO 0x462               
BTFSC 0x78, 0x3          
GOTO 0x337               
BTFSS 0x78, 0x0          
GOTO 0x41E               
CLRF 0x47                
MOVLW 0x66               
MOVLB 0x0                
MOVWF 0x2E               
MOVLW 0x2                
MOVWF 0x2F               
GOTO 0x462               
BTFSS 0x78, 0x5          
GOTO 0x462               
MOVLW 0x5                
MOVLB 0x0                
MOVWF 0x4F               
GOTO 0x23E               
BTFSC 0x78, 0x3          
BTFSS 0x78, 0x5          
GOTO 0x42B               
MOVLW 0xFF               
MOVLB 0x1                
MOVWF 0x39               
MOVWF 0x3A               
BTFSC 0x78, 0x6          
GOTO 0x23E               
GOTO 0x462               
MOVF 0x4D, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x40B               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x424               
GOTO 0x462               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x462               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x2C2               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x38D               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0xD5                
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x34F               
XORLW 0xD                
BTFSC STATUS, 0x2        
GOTO 0x363               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x363               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x2C2               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x217               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x268               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x363               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x241               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x382               
XORLW 0x1F               
BTFSC STATUS, 0x2        
GOTO 0x42E               
MOVLB 0x0                
BTFSS 0x36, 0x1          
GOTO 0x468               
BCF 0x3E, 0x1            
CALL 0x7C1               
MOVLP 0x0                
MOVLB 0x0                
CLRF 0x43                
CALL 0x702               
MOVLP 0x1C               
CALL 0x46B               
MOVLP 0x0                
CALL 0x53F               
MOVLP 0x0                
CALL 0x5B7               
MOVLP 0x0                
CALL 0x5E7               
MOVLP 0x0                
CALL 0x6DA               
MOVLP 0x0                
CALL 0x713               
MOVLP 0x0                
MOVLB 0x0                
BTFSS 0x3A, 0x3          
GOTO 0x483               
MOVLB 0x1                
MOVF 0x63, W             
BTFSC STATUS, 0x2        
GOTO 0x483               
DECFSZ 0x63, F           
GOTO 0x483               
MOVLB 0x0                
BSF 0x51, 0x5            
MOVLB 0x0                
BTFSS 0x3A, 0x3          
RETURN                   
MOVLB 0x1                
MOVF 0x58, W             
BTFSS STATUS, 0x2        
DECFSZ 0x58, F           
RETURN                   
MOVLB 0x0                
BSF 0x51, 0x3            
RETURN                   
MOVWF 0x74               
GOTO 0x507               
MOVLB 0x1                
CALL 0x793               
MOVLW 0x13               
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
MOVLB 0x1                
CALL 0x793               
MOVLW 0x9                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
MOVLB 0x1                
CLRF 0x48                
INCF 0x48, F             
MOVLW 0xC                
MOVLB 0x0                
MOVWF 0x58               
MOVLW 0x7                
MOVLB 0x1                
MOVWF 0x3D               
CLRF 0x3E                
MOVLW 0x6                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
MOVLB 0x1                
CLRF 0x48                
INCF 0x48, F             
MOVLW 0x4                
MOVLB 0x0                
MOVWF 0x58               
MOVLW 0x2C               
MOVLB 0x1                
MOVWF 0x3D               
MOVLW 0x1                
MOVWF 0x3E               
MOVF 0x74, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x4BD               
MOVLW 0x3                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
MOVF 0x74, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x4C5               
MOVLW 0x4                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
MOVF 0x74, W             
XORLW 0x5                
BTFSS STATUS, 0x2        
GOTO 0x4CC               
MOVLB 0x2                
CLRF 0x4E                
RETURN                   
MOVF 0x74, W             
XORLW 0x6                
BTFSS STATUS, 0x2        
RETURN                   
MOVLB 0x2                
CLRF 0x4E                
INCF 0x4E, F             
RETURN                   
CALL 0x786               
MOVLP 0x0                
XORLW 0x8                
BTFSC STATUS, 0x2        
GOTO 0x4B9               
MOVF 0x74, W             
XORLW 0x9                
BTFSC STATUS, 0x2        
GOTO 0x4C1               
MOVF 0x74, W             
XORLW 0xA                
BTFSS STATUS, 0x2        
RETURN                   
MOVLW 0x5                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
CALL 0x786               
MOVLP 0x0                
XORLW 0xD                
BTFSC STATUS, 0x2        
GOTO 0x4D0               
MOVF 0x74, W             
XORLW 0xE                
BTFSC STATUS, 0x2        
GOTO 0x4C9               
MOVF 0x74, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
RETURN                   
MOVLW 0x8                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
CALL 0x786               
MOVLP 0x0                
XORLW 0x10               
BTFSC STATUS, 0x2        
GOTO 0x4C9               
MOVF 0x74, W             
XORLW 0x11               
BTFSC STATUS, 0x2        
GOTO 0x4D0               
MOVF 0x74, W             
XORLW 0x12               
BTFSS STATUS, 0x2        
RETURN                   
MOVLW 0xA                
MOVLB 0x2                
MOVWF 0x4E               
RETURN                   
MOVF 0x74, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x490               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x49C               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x4AA               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4AA               
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x4AA               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x4AA               
XORLW 0xE                
BTFSC STATUS, 0x2        
GOTO 0x4D4               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4D4               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x4D4               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x496               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x496               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4E5               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x4E5               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4E5               
XORLW 0x1F               
BTFSC STATUS, 0x2        
GOTO 0x4F6               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4F6               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x4F6               
XORLW 0x1                
BTFSS STATUS, 0x2        
RETURN                   
GOTO 0x49C               
MOVF 0x3A, W             
IORWF 0x39, W            
BTFSS STATUS, 0x2        
GOTO 0x58A               
MOVLB 0x0                
DECFSZ 0x4C, W           
GOTO 0x549               
MOVLW 0x5                
MOVWF 0x4C               
GOTO 0x58A               
MOVF 0x4C, W             
XORLW 0x5                
BTFSC STATUS, 0x2        
GOTO 0x58A               
CLRF 0x4C                
GOTO 0x58A               
MOVLB 0x1                
MOVF 0x3A, W             
IORWF 0x39, W            
BTFSC STATUS, 0x2        
GOTO 0x598               
MOVLB 0x0                
BTFSS 0x36, 0x2          
GOTO 0x55A               
MOVF 0x5B, W             
BTFSC STATUS, 0x2        
GOTO 0x598               
CLRF 0x30                
CLRF 0x31                
CLRF 0x4C                
INCF 0x4C, F             
GOTO 0x598               
BTFSS 0x36, 0x2          
GOTO 0x566               
MOVF 0x5B, F             
BTFSS STATUS, 0x2        
GOTO 0x566               
MOVLW 0x5                
GOTO 0x588               
MOVLB 0x1                
INCF 0x39, W             
BTFSC STATUS, 0x2        
INCF 0x3A, W             
BTFSS STATUS, 0x2        
GOTO 0x56F               
MOVLB 0x0                
BSF 0x43, 0x2            
GOTO 0x598               
MOVLB 0x0                
BSF 0x43, 0x2            
MOVLB 0x1                
MOVF 0x3A, W             
MOVLB 0x0                
SUBWF 0x31, W            
BTFSS STATUS, 0x2        
GOTO 0x57B               
MOVLB 0x1                
MOVF 0x39, W             
MOVLB 0x0                
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
GOTO 0x564               
GOTO 0x598               
MOVLB 0x1                
MOVF 0x3A, W             
IORWF 0x39, W            
BTFSS STATUS, 0x2        
GOTO 0x586               
MOVLB 0x0                
CLRF 0x4C                
GOTO 0x598               
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x4C               
GOTO 0x598               
MOVLB 0x0                
MOVF 0x4C, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x54F               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x55F               
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x583               
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x57E               
MOVLB 0x0                
BTFSC 0x3C, 0x2          
RETURN                   
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
RETURN                   
CLRF 0x59                
MOVLW 0xBC               
MOVLB 0x2                
MOVWF 0x41               
MOVLW 0x2                
MOVWF 0x42               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
RETURN                   
BTFSC 0x3E, 0x6          
GOTO 0x5B1               
MOVLW 0x28               
MOVLB 0x2                
MOVWF 0x41               
CLRF 0x42                
RETURN                   
MOVLW 0xF4               
MOVLB 0x2                
MOVWF 0x41               
MOVLW 0x1                
MOVWF 0x42               
RETURN                   
MOVLB 0x0                
BTFSS 0x3E, 0x1          
GOTO 0x5D5               
MOVLB 0x1                
MOVF 0x4A, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x5C3               
MOVF 0x4A, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
RETURN                   
MOVLB 0x0                
GOTO 0x5CD               
MOVF 0x4C, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x5CD               
MOVF 0x4C, W             
XORLW 0x4                
BTFSS STATUS, 0x2        
RETURN                   
MOVF 0x5B, W             
BTFSC STATUS, 0x2        
GOTO 0x5D3               
MOVLB 0x1                
INCF 0x49, F             
RETURN                   
INCF 0x4D, F             
RETURN                   
BTFSC 0x3E, 0x2          
GOTO 0x5C5               
BTFSS 0x3E, 0x3          
RETURN                   
MOVF 0x5B, W             
BTFSC STATUS, 0x2        
GOTO 0x5E2               
MOVLB 0x1                
MOVF 0x49, W             
XORLW 0xFF               
BTFSC STATUS, 0x2        
RETURN                   
GOTO 0x5D0               
MOVF 0x4D, W             
XORLW 0xFF               
BTFSC STATUS, 0x2        
RETURN                   
GOTO 0x5D3               
MOVLB 0x0                
BTFSS 0x3B, 0x4          
GOTO 0x5F6               
BCF 0x3B, 0x4            
MOVLW 0x5                
MOVLB 0x1                
MOVWF 0x63               
INCF 0x28, W             
BTFSC STATUS, 0x2        
INCF 0x29, W             
BTFSC STATUS, 0x2        
GOTO 0x5F6               
INCF 0x28, F             
BTFSC STATUS, 0x2        
INCF 0x29, F             
MOVLB 0x0                
BTFSS 0x3D, 0x3          
GOTO 0x605               
BCF 0x3D, 0x3            
MOVLW 0x5                
MOVLB 0x1                
MOVWF 0x63               
INCF 0x33, W             
BTFSC STATUS, 0x2        
INCF 0x34, W             
BTFSC STATUS, 0x2        
GOTO 0x605               
INCF 0x33, F             
BTFSC STATUS, 0x2        
INCF 0x34, F             
MOVLB 0x0                
BTFSS 0x3D, 0x1          
GOTO 0x614               
BCF 0x3D, 0x1            
MOVLW 0x5                
MOVLB 0x1                
MOVWF 0x63               
INCF 0x35, W             
BTFSC STATUS, 0x2        
INCF 0x36, W             
BTFSC STATUS, 0x2        
GOTO 0x614               
INCF 0x35, F             
BTFSC STATUS, 0x2        
INCF 0x36, F             
MOVLB 0x0                
BTFSS 0x3C, 0x6          
GOTO 0x629               
MOVLB 0x1                
CLRF 0x20                
CLRF 0x21                
CLRF 0x22                
CLRF 0x23                
CLRF 0x24                
CLRF 0x25                
CLRF 0x26                
CLRF 0x27                
MOVLW 0x5                
MOVWF 0x63               
MOVLB 0x0                
BCF 0x3C, 0x6            
MOVLB 0x1                
MOVF 0x2A, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
INCF 0x2A, F             
MOVLB 0x0                
BTFSS 0x39, 0x0          
RETURN                   
BCF 0x39, 0x0            
MOVF 0x4F, W             
BTFSC STATUS, 0x2        
GOTO 0x633               
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x63               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x646               
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x644               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x644               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x646               
MOVLB 0x1                
INCF 0x3F, F             
MOVLW 0x0                
MOVLB 0x1                
SUBWF 0x2E, W            
BTFSS STATUS, 0x2        
GOTO 0x655               
MOVLW 0xFF               
SUBWF 0x2D, W            
BTFSS STATUS, 0x2        
GOTO 0x655               
MOVLW 0xFF               
SUBWF 0x2C, W            
BTFSS STATUS, 0x2        
GOTO 0x655               
MOVLW 0xFF               
SUBWF 0x2B, W            
BTFSC STATUS, 0x0        
GOTO 0x667               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x667               
MOVF 0x4D, W             
BTFSC STATUS, 0x2        
GOTO 0x667               
MOVLB 0x1                
INCF 0x2B, F             
BTFSC STATUS, 0x2        
INCF 0x2C, F             
BTFSC STATUS, 0x2        
INCF 0x2D, F             
BTFSC STATUS, 0x2        
INCF 0x2E, F             
MOVLW 0x0                
MOVLB 0x1                
SUBWF 0x32, W            
BTFSS STATUS, 0x2        
GOTO 0x676               
MOVLW 0xFF               
SUBWF 0x31, W            
BTFSS STATUS, 0x2        
GOTO 0x676               
MOVLW 0xFF               
SUBWF 0x30, W            
BTFSS STATUS, 0x2        
GOTO 0x676               
MOVLW 0xFF               
SUBWF 0x2F, W            
BTFSC STATUS, 0x0        
GOTO 0x685               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x685               
MOVLB 0x1                
INCF 0x2F, F             
BTFSC STATUS, 0x2        
INCF 0x30, F             
BTFSC STATUS, 0x2        
INCF 0x31, F             
BTFSC STATUS, 0x2        
INCF 0x32, F             
MOVLB 0x0                
INCF 0x30, W             
BTFSC STATUS, 0x2        
INCF 0x31, W             
BTFSC STATUS, 0x2        
GOTO 0x68E               
INCF 0x30, F             
BTFSC STATUS, 0x2        
INCF 0x31, F             
MOVF 0x4F, W             
XORLW 0xC                
MOVLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x6AB               
MOVLB 0x1                
SUBWF 0x23, W            
BTFSS STATUS, 0x2        
GOTO 0x6A1               
MOVLW 0xFF               
SUBWF 0x22, W            
BTFSS STATUS, 0x2        
GOTO 0x6A1               
MOVLW 0xFF               
SUBWF 0x21, W            
BTFSS STATUS, 0x2        
GOTO 0x6A1               
MOVLW 0xFF               
SUBWF 0x20, W            
BTFSC STATUS, 0x0        
RETURN                   
INCF 0x20, F             
BTFSC STATUS, 0x2        
INCF 0x21, F             
BTFSC STATUS, 0x2        
INCF 0x22, F             
BTFSC STATUS, 0x2        
INCF 0x23, F             
RETURN                   
MOVLB 0x1                
SUBWF 0x27, W            
BTFSS STATUS, 0x2        
GOTO 0x6B9               
MOVLW 0xFF               
SUBWF 0x26, W            
BTFSS STATUS, 0x2        
GOTO 0x6B9               
MOVLW 0xFF               
SUBWF 0x25, W            
BTFSS STATUS, 0x2        
GOTO 0x6B9               
MOVLW 0xF9               
SUBWF 0x24, W            
BTFSC STATUS, 0x0        
RETURN                   
MOVLW 0x6                
ADDWF 0x24, F            
MOVLW 0x1                
BTFSC STATUS, 0x0        
ADDWF 0x25, F            
BTFSC STATUS, 0x0        
ADDWF 0x26, F            
BTFSC STATUS, 0x0        
ADDWF 0x27, F            
RETURN                   
MOVLB 0x2                
CLRF 0x20                
MOVLW 0x60               
MOVWF 0x21               
CLRF 0x22                
MOVLW 0xCC               
MOVWF 0x23               
CLRF 0x24                
MOVLW 0x6E               
MOVWF 0x25               
CLRF 0x26                
MOVWF 0x27               
CLRF 0x28                
MOVLW 0x5A               
MOVWF 0x29               
CLRF 0x2A                
MOVLW 0x2C               
MOVWF 0x2B               
MOVLW 0x1                
MOVWF 0x2C               
RETURN                   
GOTO 0x6F6               
MOVF 0x3E, W             
IORWF 0x3D, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVLW 0x1E               
MOVWF 0x3D               
CLRF 0x3E                
INCF 0x48, F             
RETURN                   
MOVF 0x3E, W             
IORWF 0x3D, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVLB 0x0                
DECF 0x58, F             
MOVF 0x58, W             
BTFSC STATUS, 0x2        
GOTO 0x6F3               
MOVLB 0x1                
DECF 0x48, F             
MOVLW 0x7                
MOVWF 0x3D               
CLRF 0x3E                
RETURN                   
MOVLB 0x1                
CLRF 0x48                
RETURN                   
MOVLB 0x1                
MOVF 0x48, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
RETURN                   
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x6DB               
XORLW 0x3                
BTFSS STATUS, 0x2        
RETURN                   
GOTO 0x6E4               
BCF 0x3D, 0x0            
MOVLB 0x1                
MOVF 0x47, W             
XORLW 0x0                
BTFSS STATUS, 0x2        
RETURN                   
MOVF 0x4E, F             
BTFSS STATUS, 0x2        
GOTO 0x70D               
MOVLB 0x0                
BSF 0x3D, 0x0            
MOVLB 0x0                
BSF 0x3D, 0x2            
MOVLW 0xFF               
MOVLB 0x1                
MOVWF 0x52               
RETURN                   
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x756               
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x724               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x724               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x756               
BTFSS 0x3A, 0x3          
RETURN                   
MOVLB 0x1                
MOVF 0x5A, W             
BTFSS STATUS, 0x2        
DECFSZ 0x5A, F           
RETURN                   
MOVLW 0xA                
MOVWF 0x5A               
MOVF 0x5B, F             
BTFSS STATUS, 0x2        
GOTO 0x753               
MOVLW 0x9                
SUBWF 0x3F, W            
BTFSS STATUS, 0x0        
GOTO 0x736               
MOVLW 0xA                
GOTO 0x751               
MOVF 0x3F, F             
BTFSS STATUS, 0x2        
GOTO 0x73C               
MOVLB 0x0                
CLRF 0x49                
GOTO 0x753               
CLRF 0x75                
GOTO 0x743               
MOVLW 0xA                
SUBWF 0x75, W            
BTFSC STATUS, 0x0        
GOTO 0x750               
INCF 0x75, F             
MOVF 0x75, W             
ADDLW 0x2A               
MOVWF FSR0L               
MOVLW 0xA9               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVF INDF0, W            
MOVWF 0x74               
MOVF 0x3F, W             
SUBWF 0x74, W            
BTFSS STATUS, 0x0        
GOTO 0x73E               
MOVF 0x75, W             
MOVLB 0x0                
MOVWF 0x49               
MOVLB 0x1                
CLRF 0x3F                
RETURN                   
MOVLW 0xA                
MOVLB 0x1                
MOVWF 0x5A               
MOVLW 0x1E               
MOVWF 0x5B               
MOVLW 0x5                
GOTO 0x751               
MOVLB 0x0                
BTFSC 0x22, 0x0          
GOTO 0x762               
BSF 0x22, 0x0            
BSF 0x51, 0x4            
BTFSC 0x44, 0x0          
NOP                      
MOVLB 0x0                
BTFSS 0x44, 0x1          
GOTO 0x773               
MOVLB 0x2                
MOVF 0x52, W             
MOVWF 0x77               
MOVF 0x53, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x1                
MOVWF 0x3A               
MOVF 0x76, W             
MOVWF 0x39               
MOVLB 0x0                
BSF 0x3E, 0x2            
BTFSS 0x44, 0x2          
GOTO 0x77C               
MOVLB 0x1                
CLRF 0x47                
MOVLB 0x2                
MOVF 0x54, W             
MOVLB 0x0                
MOVWF 0x2E               
CLRF 0x2F                
BTFSS 0x44, 0x4          
GOTO 0x780               
BCF PORTB, 0x1           
GOTO 0x781               
BSF PORTB, 0x1           
BTFSS 0x44, 0x6          
RETURN                   
CLRF 0x50                
INCF 0x50, F             
RETURN                   
MOVLB 0x1                
CLRF 0x48                
INCF 0x48, F             
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x58               
MOVLW 0x2C               
MOVLB 0x1                
MOVWF 0x3D               
MOVLW 0x1                
MOVWF 0x3E               
MOVF 0x74, W             
RETURN                   
CLRF 0x48                
INCF 0x48, F             
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x58               
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x3D               
CLRF 0x3E                
RETURN                   
CLRF 0x47                
MOVLW 0x2                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0xAA               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
RETURN                   
MOVLW 0x2D               
MOVWF 0x2E               
MOVLW 0x3                
MOVWF 0x2F               
RETURN                   
ADDLW 0x3B               
MOVWF FSR0L               
MOVLW 0xA9               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVWF 0x6A               
MOVIW 1[FSR0]            
MOVWF 0x6B               
MOVF 0x6A, W             
RETURN                   
MOVLW 0x1A               
MOVWF 0x2E               
MOVLW 0x2                
MOVWF 0x2F               
MOVLB 0x1                
CLRF 0x47                
MOVLW 0xFF               
MOVWF 0x39               
MOVWF 0x3A               
RETURN                   
BCF 0x3E, 0x2            
BCF 0x3E, 0x3            
CLRF 0x2E                
CLRF 0x2F                
MOVLB 0x1                
CLRF 0x39                
CLRF 0x3A                
CLRF 0x47                
RETURN                   
MOVLB 0x1                
MOVWF 0x39               
CLRF 0x3A                
MOVLB 0x2                
CLRF 0x58                
RETURN                   
MOVLB 0x1                
MOVWF 0x39               
MOVLW 0x3                
MOVWF 0x3A               
RETURN                   
MOVLW 0xC6               
MOVLB 0x0                
SUBWF TMR0, F            
BCF INTCON, 0x2          
MOVLB 0x1                
MOVF 0x67, W             
BTFSC STATUS, 0x2        
GOTO 0x7E7               
DECFSZ 0x67, F           
GOTO 0x7E7               
MOVLB 0x0                
MOVF PORTA, W            
MOVLB 0x1                
MOVWF 0x4B               
BCF 0x4B, 0x2            
MOVF 0x4B, W             
MOVLB 0x0                
MOVWF PORTA              
MOVLB 0x1                
MOVF 0x68, W             
BTFSS STATUS, 0x2        
DECFSZ 0x68, F           
RETURN                   
MOVLB 0x0                
BTFSS 0x52, 0x2          
RETURN                   
MOVLB 0x1                
MOVF 0x52, W             
BTFSC STATUS, 0x2        
RETURN                   
MOVLB 0x2                
MOVF 0x38, W             
SUBWF 0x48, W            
BTFSS STATUS, 0x2        
GOTO 0x7FA               
MOVF 0x37, W             
SUBWF 0x47, W            
BTFSC STATUS, 0x0        
RETURN                   
MOVLB 0x0                
BSF PORTA, 0x2           
RETURN                   
RETURN                   
BCF PIR1, 0x6            
MOVF T2CON, W            
MOVLB 0x3                
MOVWF 0x3E               
MOVLB 0x1                
MOVF PR2, W              
MOVLB 0x3                
MOVWF 0x3D               
MOVLB 0x0                
BCF PIR1, 0x6            
BSF 0x39, 0x3            
RETURN                   
CLRF 0x76                
CLRF 0x77                
CLRF 0x78                
CLRF 0x79                
MOVLW 0x20               
MOVWF FSR0L               
MOVLW 0x0                
MOVWF FSR0H              
MOVLW 0x3D               
MOVLP 0x10               
CALL 0x1                 
MOVLP 0x8                
MOVLW 0xA0               
MOVWF FSR0L               
MOVLW 0x0                
MOVWF FSR0H              
MOVLW 0x4F               
MOVLP 0x10               
CALL 0x1                 
MOVLP 0x8                
MOVLW 0x20               
MOVWF FSR0L               
MOVLW 0x1                
MOVWF FSR0H              
MOVLW 0x4D               
MOVLP 0x10               
CALL 0x1                 
MOVLP 0x8                
MOVLW 0xA0               
MOVWF FSR0L               
MOVLW 0x1                
MOVWF FSR0H              
MOVLW 0x4C               
MOVLP 0x10               
CALL 0x1                 
MOVLP 0x8                
MOVLW 0x20               
MOVWF FSR0L               
MOVLW 0x2                
MOVWF FSR0H              
MOVLW 0xE                
MOVLP 0x10               
CALL 0x1                 
MOVLP 0x8                
MOVLB 0x1                
MOVLW 0x2                
MOVWF 0x6F               
MOVLB 0x2                
MOVLW 0x84               
MOVWF 0x6D               
MOVLW 0x3                
MOVWF 0x6E               
MOVLB 0x3                
MOVLW 0x58               
MOVWF 0x6C               
MOVLW 0x2                
MOVWF 0x6D               
MOVLB 0x0                
GOTO 0x47                
BCF INTCON, 0x7          
CLRWDT                   
CALL 0x29F               
MOVLP 0x8                
CLRWDT                   
CALL 0x2D0               
MOVLP 0x8                
CLRWDT                   
CALL 0x66E               
MOVLP 0x8                
CLRWDT                   
CALL 0x2DF               
MOVLP 0x8                
CLRWDT                   
CALL 0x30D               
MOVLP 0x8                
CLRWDT                   
CLRWDT                   
CALL 0x35B               
CLRWDT                   
MOVLP 0x18               
CALL 0x2                 
MOVLP 0x8                
CLRWDT                   
CALL 0x362               
CLRWDT                   
BSF INTCON, 0x6          
BSF INTCON, 0x7          
CLRWDT                   
MOVLP 0x18               
CALL 0x25                
MOVLP 0x8                
CLRWDT                   
CALL 0x371               
CLRWDT                   
MOVLP 0x25               
CALL 0x503               
MOVLP 0x8                
CLRWDT                   
MOVLP 0x14               
CALL 0x440               
MOVLP 0x8                
CLRWDT                   
MOVLB 0x0                
BTFSS 0x39, 0x2          
GOTO 0x63                
CLRWDT                   
CALL 0x86                
CLRWDT                   
MOVLP 0x0                
CALL 0x3B                
MOVLP 0x8                
CLRWDT                   
CALL 0x3FA               
CLRWDT                   
MOVLP 0x19               
CALL 0x124               
MOVLP 0x8                
CLRWDT                   
CALL 0x3F0               
MOVLP 0x8                
CLRWDT                   
GOTO 0x63                
MOVLB 0x0                
BCF 0x36, 0x3            
BCF 0x36, 0x7            
BCF 0x36, 0x2            
BCF 0x36, 0x6            
BCF 0x36, 0x1            
MOVLB 0x1                
MOVF 0x24, W             
ADDWF 0x20, W            
MOVLB 0x0                
MOVWF 0x5D               
MOVLB 0x1                
MOVF 0x25, W             
ADDWFC 0x21, W           
MOVLB 0x0                
MOVWF 0x5E               
MOVLB 0x1                
MOVF 0x26, W             
ADDWFC 0x22, W           
MOVLB 0x0                
MOVWF 0x5F               
MOVLB 0x1                
MOVF 0x27, W             
ADDWFC 0x23, W           
MOVLB 0x0                
MOVWF 0x60               
MOVLB 0x4                
MOVWF 0x2D               
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x4                
MOVWF 0x2C               
MOVLB 0x0                
MOVF 0x5E, W             
MOVLB 0x4                
MOVWF 0x2B               
MOVLB 0x0                
MOVF 0x5D, W             
MOVLB 0x4                
MOVWF 0x2A               
MOVLB 0x0                
MOVF 0x20, W             
ADDWF WREG, W            
ADDWF WREG, W            
ADDLW 0x1E               
MOVWF FSR0L               
MOVLW 0xA9               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVWF 0x5D               
MOVIW 1[FSR0]            
MOVWF 0x5E               
MOVIW 2[FSR0]            
MOVWF 0x5F               
MOVIW 3[FSR0]            
MOVWF 0x60               
MOVLB 0x4                
MOVF 0x2D, W             
MOVLB 0x0                
SUBWF 0x60, W            
BTFSS STATUS, 0x2        
GOTO 0xD6                
MOVLB 0x4                
MOVF 0x2C, W             
MOVLB 0x0                
SUBWF 0x5F, W            
BTFSS STATUS, 0x2        
GOTO 0xD6                
MOVLB 0x4                
MOVF 0x2B, W             
MOVLB 0x0                
SUBWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0xD6                
MOVLB 0x4                
MOVF 0x2A, W             
MOVLB 0x0                
SUBWF 0x5D, W            
BTFSS STATUS, 0x0        
BSF 0x36, 0x6            
MOVF 0x4C, W             
BTFSS STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x113               
MOVLB 0x2                
MOVF 0x42, W             
IORWF 0x41, W            
BTFSS STATUS, 0x2        
GOTO 0x113               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
GOTO 0x113               
MOVF 0x4F, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x113               
MOVF 0x4F, W             
XORLW 0x10               
BTFSC STATUS, 0x2        
GOTO 0x113               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
GOTO 0x113               
MOVLW 0xA                
SUBWF 0x59, W            
BTFSC STATUS, 0x0        
GOTO 0xF8                
BSF 0x22, 0x0            
BSF 0x51, 0x4            
BSF 0x3E, 0x6            
MOVLW 0x14               
MOVWF 0x55               
BSF 0x36, 0x2            
MOVF 0x4F, W             
XORLW 0x5                
BTFSC STATUS, 0x2        
GOTO 0x109               
MOVF 0x4F, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x109               
MOVLW 0x3                
MOVWF 0x4F               
CLRF 0x4D                
BSF 0x36, 0x5            
GOTO 0x147               
MOVF 0x4F, W             
XORLW 0x5                
BTFSS STATUS, 0x2        
GOTO 0x147               
MOVF 0x4D, F             
BTFSC STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x147               
INCF 0x4D, F             
GOTO 0x147               
MOVLB 0x0                
BTFSS 0x43, 0x2          
GOTO 0x120               
MOVLB 0x2                
MOVF 0x42, W             
IORWF 0x41, W            
BTFSS STATUS, 0x2        
GOTO 0x120               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
GOTO 0x123               
MOVLB 0x0                
BTFSC 0x40, 0x0          
GOTO 0x126               
MOVLW 0x3                
MOVWF 0x4F               
GOTO 0x141               
MOVF 0x4F, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x138               
BTFSC 0x40, 0x6          
GOTO 0x138               
BTFSC 0x3D, 0x5          
GOTO 0x132               
CLRF 0x4D                
INCF 0x4D, F             
GOTO 0x134               
MOVLW 0xC                
MOVWF 0x4D               
BTFSC 0x3D, 0x5          
GOTO 0x147               
BSF 0x3D, 0x5            
GOTO 0x147               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x147               
BTFSC 0x3D, 0x6          
GOTO 0x147               
CLRF 0x4F                
INCF 0x4F, F             
CLRF 0x4D                
BSF 0x22, 0x0            
BSF 0x51, 0x4            
BSF 0x3E, 0x6            
MOVLW 0x14               
MOVWF 0x55               
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x172               
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x157               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x157               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x172               
BTFSC 0x22, 0x0          
GOTO 0x172               
BTFSS 0x3A, 0x3          
GOTO 0x169               
MOVLB 0x1                
MOVF 0x5F, W             
BTFSC STATUS, 0x2        
GOTO 0x169               
DECFSZ 0x5F, F           
GOTO 0x169               
MOVLW 0x0                
MOVLB 0x0                
SUBWF 0x31, W            
MOVLW 0x3                
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSS STATUS, 0x0        
BCF 0x3D, 0x7            
MOVLW 0x0                
MOVLB 0x0                
SUBWF 0x31, W            
MOVLW 0x2D               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
GOTO 0x175               
GOTO 0x177               
MOVLW 0x14               
MOVLB 0x1                
MOVWF 0x5F               
MOVLB 0x0                
BSF 0x3D, 0x7            
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x1AA               
MOVF 0x4D, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x1AA               
BTFSS 0x3A, 0x3          
GOTO 0x1B2               
MOVLB 0x1                
MOVF 0x61, W             
BTFSC STATUS, 0x2        
GOTO 0x1B2               
DECFSZ 0x61, F           
GOTO 0x1B2               
MOVLB 0x0                
MOVF 0x31, W             
MOVWF 0x62               
MOVF 0x30, W             
MOVWF 0x61               
MOVLB 0x2                
MOVF 0x3D, W             
MOVLB 0x0                
SUBWF 0x61, F            
MOVLB 0x2                
MOVF 0x3E, W             
MOVLB 0x0                
SUBWFB 0x62, F           
MOVLW 0x0                
SUBWF 0x62, W            
MOVLW 0x3                
BTFSC STATUS, 0x2        
SUBWF 0x61, W            
BTFSC STATUS, 0x0        
GOTO 0x19E               
BCF 0x40, 0x0            
GOTO 0x19F               
BSF 0x40, 0x0            
MOVF 0x31, W             
MOVLB 0x2                
MOVWF 0x3E               
MOVLB 0x0                
MOVF 0x30, W             
MOVLB 0x2                
MOVWF 0x3D               
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x61               
GOTO 0x1B2               
MOVLB 0x2                
CLRF 0x3D                
CLRF 0x3E                
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x61               
MOVLB 0x0                
BSF 0x40, 0x0            
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x1E7               
BTFSS 0x3A, 0x3          
GOTO 0x1EF               
MOVLB 0x1                
MOVF 0x60, W             
BTFSC STATUS, 0x2        
GOTO 0x1EF               
DECFSZ 0x60, F           
GOTO 0x1EF               
MOVLB 0x0                
MOVF 0x31, W             
MOVWF 0x64               
MOVF 0x30, W             
MOVWF 0x63               
MOVLB 0x2                
MOVF 0x3B, W             
MOVLB 0x0                
SUBWF 0x63, F            
MOVLB 0x2                
MOVF 0x3C, W             
MOVLB 0x0                
SUBWFB 0x64, F           
MOVLW 0x0                
SUBWF 0x64, W            
MOVLW 0x2                
BTFSC STATUS, 0x2        
SUBWF 0x63, W            
BTFSC STATUS, 0x0        
GOTO 0x1D6               
BCF 0x40, 0x6            
GOTO 0x1D7               
BSF 0x40, 0x6            
MOVF 0x31, W             
MOVLB 0x2                
MOVWF 0x3C               
MOVLB 0x0                
MOVF 0x30, W             
MOVLB 0x2                
MOVWF 0x3B               
MOVLB 0x0                
BTFSS 0x3D, 0x5          
GOTO 0x1E3               
MOVLW 0xA                
GOTO 0x1E4               
MOVLW 0x14               
MOVLB 0x1                
MOVWF 0x60               
GOTO 0x1EF               
MOVLB 0x2                
CLRF 0x3B                
CLRF 0x3C                
MOVLW 0x14               
MOVLB 0x1                
MOVWF 0x60               
MOVLB 0x0                
BSF 0x40, 0x6            
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
BTFSS 0x43, 0x2          
GOTO 0x22A               
BTFSS 0x3A, 0x3          
GOTO 0x232               
MOVLB 0x1                
MOVF 0x62, W             
BTFSC STATUS, 0x2        
GOTO 0x232               
DECFSZ 0x62, F           
GOTO 0x232               
MOVLB 0x0                
MOVF 0x31, W             
MOVWF 0x66               
MOVF 0x30, W             
MOVWF 0x65               
MOVLB 0x2                
MOVF 0x3F, W             
MOVLB 0x0                
SUBWF 0x65, F            
MOVLB 0x2                
MOVF 0x40, W             
MOVLB 0x0                
SUBWFB 0x66, F           
BTFSC 0x41, 0x4          
GOTO 0x215               
MOVLW 0x0                
SUBWF 0x66, W            
MOVLW 0x4                
BTFSC STATUS, 0x2        
SUBWF 0x65, W            
BTFSC STATUS, 0x0        
GOTO 0x215               
BCF 0x3D, 0x6            
GOTO 0x21F               
BTFSS 0x41, 0x4          
GOTO 0x21E               
MOVLW 0x0                
SUBWF 0x66, W            
MOVLW 0x3                
BTFSC STATUS, 0x2        
SUBWF 0x65, W            
BTFSS STATUS, 0x0        
GOTO 0x213               
BSF 0x3D, 0x6            
MOVF 0x31, W             
MOVLB 0x2                
MOVWF 0x40               
MOVLB 0x0                
MOVF 0x30, W             
MOVLB 0x2                
MOVWF 0x3F               
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x62               
GOTO 0x232               
MOVLB 0x2                
CLRF 0x3F                
CLRF 0x40                
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x62               
MOVLB 0x0                
BSF 0x3D, 0x6            
MOVLW 0x0                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0x1F               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x241               
MOVLW 0x3                
SUBWF 0x2B, W            
MOVLW 0xA8               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x243               
BSF 0x36, 0x3            
BSF 0x36, 0x1            
MOVLW 0x0                
SUBWF 0x31, W            
MOVLW 0x19               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
GOTO 0x251               
BTFSS 0x43, 0x2          
GOTO 0x24E               
BTFSS 0x36, 0x2          
GOTO 0x251               
MOVF 0x4F, F             
BTFSS STATUS, 0x2        
GOTO 0x252               
BCF 0x36, 0x5            
MOVF 0x2F, W             
IORWF 0x2E, W            
BTFSS STATUS, 0x2        
GOTO 0x259               
MOVLW 0x4C               
MOVWF 0x2E               
CLRF 0x2F                
BTFSS 0x3D, 0x0          
GOTO 0x289               
MOVF 0x2E, W             
ADDLW 0xB4               
MOVWF 0x5D               
MOVLW 0xFF               
ADDWFC 0x2F, W           
MOVWF 0x5E               
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x266               
MOVF 0x5D, W             
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
BTFSC 0x43, 0x2          
GOTO 0x289               
MOVF 0x4F, W             
BTFSC STATUS, 0x2        
GOTO 0x289               
MOVLB 0x2                
MOVF 0x39, W             
ADDLW 0x2                
MOVLB 0x0                
MOVWF 0x5D               
MOVLW 0x0                
MOVLB 0x2                
ADDWFC 0x3A, W           
MOVLB 0x0                
MOVWF 0x5E               
MOVF 0x2B, W             
SUBWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x27C               
MOVF 0x2A, W             
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
GOTO 0x295               
MOVF 0x2B, W             
MOVLB 0x2                
MOVWF 0x3A               
MOVLB 0x0                
MOVF 0x2A, W             
MOVLB 0x2                
MOVWF 0x39               
MOVLW 0x3C               
MOVLB 0x1                
MOVWF 0x66               
GOTO 0x295               
MOVF 0x4F, F             
BTFSS STATUS, 0x2        
GOTO 0x28F               
MOVLB 0x1                
DECFSZ 0x42, W           
GOTO 0x295               
MOVLW 0x3C               
MOVLB 0x1                
MOVWF 0x66               
MOVLB 0x2                
CLRF 0x39                
CLRF 0x3A                
MOVLB 0x0                
CLRF 0x2E                
CLRF 0x2F                
MOVLB 0x1                
MOVF 0x66, F             
BTFSS STATUS, 0x2        
RETURN                   
MOVLB 0x0                
BSF 0x36, 0x1            
RETURN                   
MOVLW 0x7A               
MOVLB 0x1                
MOVWF T1GCON             
CLRF T1CON               
CLRF INTCON              
CLRF PIR1                
CLRF PIR2                
CLRF PIR3                
MOVLB 0x0                
CLRF PIR1                
CLRF PIR2                
CLRF PIR3                
MOVLW 0x81               
MOVLB 0x1                
MOVWF TMR0               
MOVLB 0x2                
CLRF TMR1H               
MOVLW 0x40               
MOVLB 0xF                
MOVWF PIR1               
MOVLW 0x18               
MOVLB 0x0                
MOVWF PORTA              
MOVLW 0x3                
MOVLB 0x3                
MOVWF PORTA              
MOVLW 0xE3               
MOVLB 0x1                
MOVWF PORTA              
MOVLB 0x0                
CLRF PORTB               
MOVLB 0x3                
CLRF PORTB               
MOVLW 0xFD               
MOVLB 0x1                
MOVWF PORTB              
MOVLW 0x40               
MOVLB 0x0                
MOVWF PORTC              
MOVLW 0x81               
MOVLB 0x1                
MOVWF PORTC              
MOVLB 0x0                
CLRF PORTE               
MOVLW 0xF                
MOVLB 0x1                
MOVWF PORTE              
CLRWDT                   
RETURN                   
MOVLB 0x0                
CLRF 0x42                
MOVLB 0x2                
CLRF 0x5B                
MOVLW 0xE                
MOVLB 0x0                
MOVWF 0x6E               
CLRF 0x4A                
MOVLB 0x3                
CLRF 0x3F                
CLRF 0x40                
MOVLB 0x0                
BCF 0x3D, 0x4            
CLRF 0x55                
RETURN                   
MOVLB 0x0                
BSF 0x3B, 0x6            
MOVLB 0x1                
CLRF 0x4A                
MOVLB 0x0                
CLRF 0x4C                
MOVLB 0x1                
CLRF 0x49                
MOVLW 0xA                
MOVLB 0x0                
MOVWF 0x4F               
MOVLW 0x1E               
MOVWF 0x57               
CLRF 0x43                
MOVLW 0x10               
MOVWF 0x52               
BCF 0x3F, 0x2            
MOVF 0x5C, W             
MOVLB 0x2                
MOVWF 0x55               
MOVLB 0x0                
BCF 0x3F, 0x4            
BCF 0x3D, 0x5            
BCF 0x43, 0x6            
BCF 0x3E, 0x6            
BSF 0x40, 0x0            
BSF 0x40, 0x6            
MOVLB 0x1                
MOVF 0x38, W             
MOVLB 0x3                
MOVWF 0x4A               
MOVLB 0x1                
MOVF 0x37, W             
MOVLB 0x3                
MOVWF 0x49               
MOVLB 0x0                
BCF 0x40, 0x4            
BSF 0x3F, 0x6            
BCF 0x3F, 0x1            
BCF 0x3B, 0x1            
BCF 0x40, 0x7            
BSF 0x3E, 0x5            
BCF 0x41, 0x4            
MOVLB 0x1                
CLRF 0x42                
RETURN                   
MOVLB 0x2                
CLRF 0x50                
MOVLW 0x39               
MOVLB 0x0                
MOVWF TMR0               
BCF INTCON, 0x2          
BSF INTCON, 0x5          
BCF T1CON, 0x0           
MOVLW 0x5                
MOVLB 0x5                
MOVWF TMR2               
MOVLB 0x0                
BCF PIR2, 0x0            
MOVLB 0x1                
BSF PIR2, 0x0            
MOVLW 0x20               
MOVLB 0x0                
MOVWF T1CON              
BSF T1CON, 0x0           
MOVLB 0x2                
BSF 0x1D, 0x0            
MOVLB 0x0                
CLRF TMR2                
MOVLW 0x2                
MOVWF T2CON              
MOVLW 0xF9               
MOVWF PR2                
BSF T2CON, 0x2           
BCF PIR1, 0x1            
MOVLB 0x1                
BSF PIR1, 0x1            
MOVLB 0x8                
CLRF TMR1H               
MOVLB 0x0                
BCF PIR3, 0x1            
MOVLB 0x8                
CLRF CPSCON0             
MOVLB 0x0                
BCF PIR3, 0x3            
MOVLW 0xA                
MOVLB 0x2                
MOVWF 0x66               
MOVLW 0xC                
MOVLB 0x1                
MOVWF 0x45               
MOVLB 0x2                
MOVWF 0x67               
MOVLW 0xA                
MOVWF 0x68               
MOVWF 0x65               
MOVLW 0x3C               
MOVLB 0x1                
MOVWF 0x4F               
MOVLW 0xC8               
MOVWF 0x4C               
MOVLW 0xA                
MOVWF 0x4E               
MOVLW 0x1E               
MOVLB 0x0                
MOVWF 0x57               
MOVLW 0x3C               
MOVLB 0x1                
MOVWF 0x66               
MOVLW 0x86               
MOVLB 0x2                
MOVWF 0x33               
MOVLW 0x1                
MOVWF 0x34               
MOVLB 0x0                
BTFSS PORTB, 0x5         
GOTO 0x359               
BSF 0x3C, 0x0            
MOVLW 0x3                
MOVLB 0x1                
MOVWF 0x65               
RETURN                   
BCF 0x3C, 0x0            
GOTO 0x355               
CLRF 0x79                
CLRF 0x78                
MOVLB 0x2                
CLRF 0x4D                
MOVLB 0x1                
BCF 0x41, 0x1            
RETURN                   
MOVLW 0x8                
MOVLB 0x3                
MOVWF CPSCON1            
MOVLW 0xCF               
MOVWF PR2                
MOVLW 0x65               
MOVWF CPSCON0            
MOVLW 0x90               
MOVWF 0x1D               
MOVF T1GCON, W           
MOVLB 0x1                
BSF PIR1, 0x5            
BSF INTCON, 0x6          
BCF PIR1, 0x4            
RETURN                   
CLRF 0x79                
MOVLB 0x0                
BTFSS 0x3A, 0x2          
GOTO 0x3D5               
RRF 0x5A, W              
MOVWF 0x74               
RRF 0x74, F              
RRF 0x74, W              
ANDLW 0x1                
MOVWF 0x75               
MOVLB 0x1                
LSLF 0x6A, W             
IORWF 0x75, W            
MOVWF 0x6A               
MOVLB 0x0                
SWAPF 0x5A, W            
RRF WREG, F              
ANDLW 0x1                
MOVWF 0x74               
MOVLB 0x1                
LSLF 0x6C, W             
IORWF 0x74, W            
MOVWF 0x6C               
MOVLB 0x0                
MOVF 0x5A, W             
ANDLW 0x1                
MOVWF 0x74               
MOVLB 0x1                
LSLF 0x6B, W             
IORWF 0x74, W            
MOVWF 0x6B               
MOVLB 0x0                
SWAPF 0x5A, W            
RRF WREG, F              
RRF WREG, F              
ANDLW 0x1                
MOVWF 0x74               
MOVLB 0x1                
LSLF 0x6E, W             
IORWF 0x74, W            
MOVWF 0x6E               
MOVLB 0x0                
RRF 0x5A, W              
RRF WREG, F              
ANDLW 0x1                
MOVWF 0x74               
MOVLB 0x1                
LSLF 0x6D, W             
IORWF 0x74, W            
MOVWF 0x6D               
MOVF 0x6A, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x3A9               
BSF 0x78, 0x3            
GOTO 0x3AD               
MOVF 0x6A, F             
BTFSS STATUS, 0x2        
GOTO 0x3AD               
BCF 0x78, 0x3            
MOVF 0x6C, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x3B3               
BSF 0x78, 0x5            
GOTO 0x3B7               
MOVF 0x6C, F             
BTFSS STATUS, 0x2        
GOTO 0x3B7               
BCF 0x78, 0x5            
MOVF 0x6B, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x3BD               
BSF 0x78, 0x0            
GOTO 0x3C1               
MOVF 0x6B, F             
BTFSS STATUS, 0x2        
GOTO 0x3C1               
BCF 0x78, 0x0            
MOVF 0x6E, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x3C7               
BSF 0x78, 0x6            
GOTO 0x3CB               
MOVF 0x6E, F             
BTFSS STATUS, 0x2        
GOTO 0x3CB               
BCF 0x78, 0x6            
MOVF 0x6D, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x3D1               
BSF 0x78, 0x7            
GOTO 0x3D5               
MOVF 0x6D, F             
BTFSS STATUS, 0x2        
GOTO 0x3D5               
BCF 0x78, 0x7            
MOVF 0x78, W             
MOVLB 0x1                
XORWF 0x69, W            
MOVWF 0x79               
MOVF 0x78, W             
ANDWF 0x79, F            
COMF 0x78, W             
MOVWF 0x74               
MOVF 0x78, W             
XORWF 0x69, W            
ANDWF 0x74, W            
MOVLB 0x0                
MOVWF 0x38               
MOVF 0x78, W             
MOVLB 0x1                
MOVWF 0x69               
MOVLB 0x0                
CLRF 0x4B                
BTFSC 0x78, 0x3          
INCF 0x4B, F             
BTFSC 0x78, 0x0          
INCF 0x4B, F             
BTFSC 0x78, 0x5          
INCF 0x4B, F             
BTFSC 0x78, 0x6          
INCF 0x4B, F             
RETURN                   
BCF INTCON, 0x7          
MOVLW 0x10               
MOVLB 0x0                
MOVWF 0x52               
BTFSC 0x43, 0x0          
BSF 0x52, 0x2            
BTFSC 0x43, 0x2          
BCF 0x52, 0x4            
BSF INTCON, 0x7          
RETURN                   
MOVLB 0x2                
CLRF 0x5B                
MOVLB 0x0                
MOVF 0x5B, W             
BTFSC STATUS, 0x2        
GOTO 0x42A               
GOTO 0x41F               
CALL 0x623               
MOVLP 0x8                
GOTO 0x61E               
MOVLB 0x1                
DECFSZ 0x43, W           
GOTO 0x409               
MOVLB 0x2                
BSF 0x5B, 0x3            
MOVLB 0x1                
MOVF 0x43, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x410               
MOVLB 0x2                
BSF 0x5B, 0x2            
MOVLB 0x1                
MOVF 0x43, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x417               
MOVLB 0x2                
BSF 0x5B, 0x5            
MOVLB 0x1                
MOVF 0x43, W             
XORLW 0x4                
BTFSS STATUS, 0x2        
GOTO 0x61E               
MOVLB 0x2                
BSF 0x5B, 0x4            
GOTO 0x61E               
MOVF 0x50, W             
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x404               
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x61E               
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x401               
GOTO 0x61E               
BTFSS 0x36, 0x1          
GOTO 0x437               
MOVLB 0x1                
MOVF 0x42, F             
BTFSS STATUS, 0x2        
GOTO 0x437               
MOVLB 0x0                
BTFSS 0x3D, 0x4          
GOTO 0x61E               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x5            
GOTO 0x567               
MOVLB 0x0                
MOVF 0x58, W             
BTFSC STATUS, 0x2        
GOTO 0x5F9               
CALL 0x645               
MOVLP 0x8                
GOTO 0x61E               
DECFSZ 0x4D, W           
GOTO 0x44A               
MOVLW 0xE                
MOVWF 0x6E               
MOVLB 0x2                
BSF 0x5B, 0x5            
MOVLB 0x0                
CLRF 0x4A                
MOVLB 0x3                
CLRF 0x3F                
INCF 0x3F, F             
CLRF 0x40                
MOVLB 0x0                
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x490               
MOVLW 0xC                
SUBWF 0x6E, W            
BTFSS STATUS, 0x0        
GOTO 0x468               
MOVLW 0xE                
SUBWF 0x6E, W            
BTFSC STATUS, 0x0        
GOTO 0x468               
MOVF 0x4A, F             
BTFSS STATUS, 0x2        
GOTO 0x45D               
MOVLB 0x2                
BSF 0x5B, 0x3            
GOTO 0x468               
DECFSZ 0x4A, W           
GOTO 0x462               
MOVLB 0x2                
BSF 0x5B, 0x2            
GOTO 0x468               
MOVF 0x4A, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x468               
MOVLB 0x2                
BSF 0x5B, 0x5            
MOVLW 0x6                
MOVLB 0x0                
SUBWF 0x6E, W            
BTFSS STATUS, 0x0        
GOTO 0x482               
MOVLW 0x8                
SUBWF 0x6E, W            
BTFSC STATUS, 0x0        
GOTO 0x482               
MOVF 0x4A, F             
BTFSS STATUS, 0x2        
GOTO 0x477               
MOVLB 0x2                
BSF 0x5B, 0x3            
GOTO 0x482               
DECFSZ 0x4A, W           
GOTO 0x47C               
MOVLB 0x2                
BSF 0x5B, 0x2            
GOTO 0x482               
MOVF 0x4A, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x482               
MOVLB 0x2                
BSF 0x5B, 0x5            
MOVLB 0x0                
MOVF 0x6E, F             
BTFSS STATUS, 0x2        
GOTO 0x61E               
MOVLW 0xE                
MOVWF 0x6E               
MOVLW 0x2                
SUBWF 0x4A, W            
BTFSS STATUS, 0x0        
GOTO 0x48E               
CLRF 0x4A                
GOTO 0x61E               
INCF 0x4A, F             
GOTO 0x61E               
MOVF 0x4D, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x61E               
MOVLW 0xC                
SUBWF 0x6E, W            
BTFSS STATUS, 0x0        
GOTO 0x4AB               
MOVLW 0xE                
SUBWF 0x6E, W            
BTFSC STATUS, 0x0        
GOTO 0x4AB               
MOVF 0x4A, F             
BTFSS STATUS, 0x2        
GOTO 0x4A2               
MOVLB 0x2                
BSF 0x5B, 0x3            
GOTO 0x4AB               
DECFSZ 0x4A, W           
GOTO 0x4AB               
BTFSS 0x36, 0x6          
GOTO 0x4A9               
MOVLB 0x2                
BSF 0x5B, 0x4            
GOTO 0x4AB               
MOVLB 0x2                
BSF 0x5B, 0x5            
MOVLW 0x6                
MOVLB 0x0                
SUBWF 0x6E, W            
BTFSS STATUS, 0x0        
GOTO 0x4C3               
MOVLW 0x8                
SUBWF 0x6E, W            
BTFSC STATUS, 0x0        
GOTO 0x4C3               
MOVF 0x4A, F             
BTFSS STATUS, 0x2        
GOTO 0x4BA               
MOVLB 0x2                
BSF 0x5B, 0x3            
GOTO 0x4C3               
DECFSZ 0x4A, W           
GOTO 0x4C3               
BTFSS 0x36, 0x6          
GOTO 0x4C1               
MOVLB 0x2                
BSF 0x5B, 0x4            
GOTO 0x4C3               
MOVLB 0x2                
BSF 0x5B, 0x5            
MOVLB 0x0                
MOVF 0x6E, F             
BTFSS STATUS, 0x2        
GOTO 0x61E               
MOVLW 0xE                
MOVWF 0x6E               
MOVF 0x4A, W             
BTFSC STATUS, 0x2        
GOTO 0x48E               
GOTO 0x48C               
MOVLB 0x3                
DECF 0x3F, W             
IORWF 0x40, W            
BTFSS STATUS, 0x2        
GOTO 0x500               
CLRF 0x3F                
CLRF 0x40                
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xD                
BTFSS STATUS, 0x2        
GOTO 0x4DD               
MOVF 0x23, W             
MOVLB 0x2                
MOVWF 0x31               
CLRF 0x32                
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x8                
BTFSS STATUS, 0x2        
GOTO 0x4E6               
MOVF 0x20, W             
MOVLB 0x2                
MOVWF 0x31               
CLRF 0x32                
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x9                
BTFSS STATUS, 0x2        
GOTO 0x4EF               
MOVF 0x21, W             
MOVLB 0x2                
MOVWF 0x31               
CLRF 0x32                
MOVLB 0x2                
MOVF 0x31, W             
XORLW 0x2                
IORWF 0x32, W            
BTFSS STATUS, 0x2        
GOTO 0x4F7               
MOVLW 0xA                
GOTO 0x4FE               
DECF 0x31, W             
IORWF 0x32, W            
BTFSS STATUS, 0x2        
GOTO 0x4FD               
MOVLW 0x14               
GOTO 0x4FE               
MOVLW 0x1E               
MOVLB 0x0                
MOVWF 0x57               
MOVLB 0x0                
DECFSZ 0x4D, W           
GOTO 0x61E               
MOVLW 0x15               
SUBWF 0x57, W            
BTFSS STATUS, 0x0        
GOTO 0x50A               
MOVLB 0x2                
BSF 0x5B, 0x3            
GOTO 0x51C               
MOVLW 0xB                
SUBWF 0x57, W            
BTFSS STATUS, 0x0        
GOTO 0x512               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x2            
GOTO 0x51C               
MOVF 0x57, W             
BTFSC STATUS, 0x2        
GOTO 0x51A               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x2            
BSF 0x5B, 0x5            
GOTO 0x51C               
BTFSC 0x3B, 0x3          
GOTO 0x507               
MOVLB 0x0                
MOVF 0x57, F             
BTFSS STATUS, 0x2        
GOTO 0x61E               
MOVLW 0x1E               
MOVWF 0x57               
GOTO 0x61E               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x52A               
BTFSS 0x3D, 0x4          
GOTO 0x61E               
MOVLB 0x2                
GOTO 0x5ED               
DECFSZ 0x4D, W           
GOTO 0x52D               
GOTO 0x535               
MOVF 0x4D, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x528               
MOVF 0x4D, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x538               
BTFSC 0x3B, 0x3          
GOTO 0x528               
GOTO 0x61E               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
BTFSS 0x3D, 0x4          
GOTO 0x61E               
MOVLB 0x2                
BSF 0x5B, 0x2            
GOTO 0x543               
BTFSS 0x3B, 0x3          
GOTO 0x61E               
MOVLB 0x2                
BSF 0x5B, 0x3            
GOTO 0x61E               
BTFSS 0x78, 0x6          
GOTO 0x556               
MOVF 0x55, W             
BTFSC STATUS, 0x2        
GOTO 0x54F               
BTFSS 0x3D, 0x4          
GOTO 0x61E               
MOVLB 0x2                
BSF 0x5B, 0x2            
GOTO 0x5EC               
BTFSS 0x3D, 0x4          
GOTO 0x61E               
MOVF 0x4F, W             
XORLW 0xA                
BTFSS STATUS, 0x2        
GOTO 0x53D               
GOTO 0x61E               
MOVLW 0x15               
SUBWF 0x57, W            
BTFSC STATUS, 0x0        
GOTO 0x542               
MOVLW 0xB                
SUBWF 0x57, W            
BTFSS STATUS, 0x0        
GOTO 0x560               
MOVLB 0x2                
GOTO 0x567               
MOVF 0x57, W             
BTFSS STATUS, 0x2        
GOTO 0x528               
BTFSS 0x3B, 0x3          
GOTO 0x61E               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x2            
GOTO 0x61E               
MOVLB 0x2                
DECFSZ 0x51, W           
GOTO 0x573               
MOVLB 0x0                
BTFSS 0x3D, 0x4          
GOTO 0x591               
MOVLB 0x2                
BSF 0x5B, 0x2            
BSF 0x5B, 0x3            
GOTO 0x591               
MOVLB 0x0                
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x591               
BTFSC 0x41, 0x4          
GOTO 0x57B               
BTFSS 0x78, 0x6          
GOTO 0x57E               
MOVF 0x55, F             
BTFSC STATUS, 0x2        
GOTO 0x56D               
MOVF 0x55, W             
BTFSC STATUS, 0x2        
GOTO 0x588               
BTFSS 0x3D, 0x4          
GOTO 0x591               
MOVLB 0x2                
BSF 0x5B, 0x2            
BSF 0x5B, 0x3            
BSF 0x5B, 0x5            
GOTO 0x591               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x2            
MOVLB 0x0                
BTFSC 0x36, 0x6          
BTFSS 0x3B, 0x0          
GOTO 0x591               
MOVLB 0x2                
BSF 0x5B, 0x4            
MOVLB 0x0                
BTFSC 0x41, 0x4          
GOTO 0x61E               
MOVF 0x37, F             
BTFSS STATUS, 0x2        
GOTO 0x5A2               
MOVF 0x4D, W             
BTFSC STATUS, 0x2        
GOTO 0x5A2               
BTFSS 0x3C, 0x7          
GOTO 0x540               
MOVLB 0x2                
BSF 0x5B, 0x3            
MOVLB 0x0                
BTFSC 0x3B, 0x0          
GOTO 0x55E               
GOTO 0x61E               
DECFSZ 0x37, W           
GOTO 0x61E               
MOVF 0x4D, W             
BTFSC STATUS, 0x2        
GOTO 0x61E               
BTFSS 0x3C, 0x7          
GOTO 0x5AF               
MOVLB 0x2                
BSF 0x5B, 0x2            
MOVLB 0x0                
BTFSC 0x3B, 0x0          
GOTO 0x542               
GOTO 0x61E               
BTFSC 0x3B, 0x3          
GOTO 0x55E               
GOTO 0x61E               
MOVF 0x4D, F             
BTFSC STATUS, 0x2        
GOTO 0x5B7               
DECFSZ 0x4D, W           
GOTO 0x5B7               
BTFSC 0x3B, 0x0          
GOTO 0x41C               
GOTO 0x61E               
BTFSS 0x3A, 0x4          
GOTO 0x5BD               
INCF 0x4E, F             
MOVLW 0x4                
SUBWF 0x4E, W            
BTFSC STATUS, 0x0        
CLRF 0x4E                
MOVF 0x4E, F             
BTFSC STATUS, 0x2        
GOTO 0x528               
DECFSZ 0x4E, W           
GOTO 0x5C7               
GOTO 0x542               
MOVF 0x4E, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x542               
MOVF 0x4E, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x528               
GOTO 0x61E               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x5E2               
MOVLB 0x1                
MOVF 0x5D, W             
BTFSC STATUS, 0x2        
GOTO 0x5DB               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x2            
GOTO 0x5ED               
BTFSC 0x78, 0x3          
GOTO 0x542               
BTFSC 0x78, 0x0          
GOTO 0x55E               
BTFSC 0x78, 0x5          
GOTO 0x528               
GOTO 0x5D7               
DECFSZ 0x4D, W           
GOTO 0x61E               
MOVLB 0x1                
MOVF 0x5D, W             
BTFSS STATUS, 0x2        
GOTO 0x5D7               
BTFSC 0x78, 0x3          
BTFSS 0x78, 0x5          
GOTO 0x5EF               
MOVLB 0x2                
BSF 0x5B, 0x3            
BSF 0x5B, 0x5            
GOTO 0x61E               
BTFSC 0x78, 0x3          
GOTO 0x542               
BTFSC 0x78, 0x0          
GOTO 0x55E               
BTFSS 0x78, 0x5          
GOTO 0x61E               
MOVLB 0x0                
BTFSC 0x3B, 0x0          
GOTO 0x41C               
GOTO 0x528               
MOVF 0x4F, W             
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x545               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x5B2               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x569               
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x5BA               
XORLW 0xD                
BTFSC STATUS, 0x2        
GOTO 0x4CD               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4CD               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x545               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x540               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x523               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x4CD               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x43E               
XORLW 0x1E               
BTFSC STATUS, 0x2        
GOTO 0x5D0               
MOVLB 0x2                
MOVF 0x5B, W             
MOVLB 0x0                
MOVWF 0x42               
RETURN                   
MOVLB 0x1                
MOVF 0x49, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
RETURN                   
GOTO 0x635               
MOVLB 0x2                
BSF 0x5B, 0x4            
RETURN                   
MOVLB 0x2                
BSF 0x5B, 0x6            
RETURN                   
MOVLB 0x2                
BSF 0x5B, 0x3            
RETURN                   
MOVLB 0x2                
BSF 0x5B, 0x5            
RETURN                   
MOVLB 0x0                
MOVF 0x47, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x629               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x62C               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x62F               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x632               
XORLW 0x7                
RETURN                   
MOVLB 0x1                
DECFSZ 0x48, W           
RETURN                   
GOTO 0x656               
BSF 0x5B, 0x3            
RETURN                   
BSF 0x5B, 0x2            
RETURN                   
BSF 0x5B, 0x5            
RETURN                   
BSF 0x5B, 0x3            
BSF 0x5B, 0x2            
RETURN                   
BSF 0x5B, 0x3            
BSF 0x5B, 0x5            
BSF 0x5B, 0x2            
RETURN                   
MOVLB 0x2                
MOVF 0x4E, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x649               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x64B               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x652               
XORLW 0xE                
BTFSC STATUS, 0x2        
GOTO 0x64F               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x652               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x64D               
XORLW 0x19               
BTFSS STATUS, 0x2        
RETURN                   
GOTO 0x652               
MOVLB 0x3                
CLRF TMR0                
MOVLB 0x0                
CLRF 0x48                
CLRWDT                   
CALL 0x7FB               
MOVLP 0x8                
CALL 0x7F5               
MOVLP 0x8                
MOVLW 0x6                
MOVWF 0x74               
MOVF 0x48, W             
CALL 0x776               
MOVLP 0x8                
ADDWF 0x64, W            
ADDLW 0x50               
CALL 0x72F               
MOVLP 0x8                
MOVWF INDF1              
MOVLB 0x0                
INCF 0x64, F             
MOVLW 0x6                
SUBWF 0x64, W            
BTFSS STATUS, 0x0        
GOTO 0x675               
MOVLW 0x4                
MOVWF 0x74               
MOVLW 0xD3               
CALL 0x737               
MOVLP 0x8                
MOVLB 0x3                
MOVF 0x57, W             
MOVLB 0x0                
XORWF 0x29, W            
BTFSS STATUS, 0x2        
GOTO 0x698               
MOVLB 0x3                
MOVF 0x58, W             
MOVLB 0x0                
XORWF 0x28, W            
BTFSC STATUS, 0x2        
CLRF 0x63                
INCF 0x48, F             
MOVF 0x63, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x6A1               
MOVLW 0x2                
SUBWF 0x48, W            
BTFSS STATUS, 0x0        
GOTO 0x672               
MOVF 0x63, F             
BTFSS STATUS, 0x2        
GOTO 0x6A7               
CALL 0x782               
MOVLP 0x8                
GOTO 0x6A9               
CALL 0x793               
MOVLP 0x8                
CLRF 0x48                
CLRWDT                   
CALL 0x7FB               
MOVLP 0x8                
CALL 0x7F5               
MOVLP 0x8                
MOVLW 0x19               
MOVWF 0x74               
MOVF 0x48, W             
CALL 0x776               
MOVLP 0x8                
ADDWF 0x64, W            
ADDLW 0x1E               
CALL 0x72F               
MOVLP 0x8                
MOVWF INDF1              
MOVLB 0x0                
INCF 0x64, F             
MOVLW 0x19               
SUBWF 0x64, W            
BTFSS STATUS, 0x0        
GOTO 0x6AD               
MOVLW 0x17               
MOVWF 0x74               
MOVLW 0xD3               
CALL 0x737               
MOVLP 0x8                
MOVLB 0x3                
MOVF 0x6A, W             
MOVLB 0x0                
XORWF 0x29, W            
BTFSS STATUS, 0x2        
GOTO 0x6D0               
MOVLB 0x3                
MOVF 0x6B, W             
MOVLB 0x0                
XORWF 0x28, W            
BTFSC STATUS, 0x2        
CLRF 0x63                
INCF 0x48, F             
MOVF 0x63, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x6D9               
MOVLW 0x2                
SUBWF 0x48, W            
BTFSS STATUS, 0x0        
GOTO 0x6AA               
MOVF 0x63, F             
BTFSS STATUS, 0x2        
GOTO 0x6E0               
MOVLP 0x23               
CALL 0x313               
MOVLP 0x8                
GOTO 0x6E2               
CALL 0x79B               
MOVLP 0x8                
MOVLB 0x0                
CLRF 0x48                
CLRWDT                   
CALL 0x7FB               
MOVLP 0x8                
CALL 0x7F5               
MOVLP 0x8                
MOVLW 0xF                
MOVWF 0x74               
MOVF 0x48, W             
CALL 0x776               
MOVLP 0x8                
ADDWF 0x64, W            
CALL 0x72F               
MOVLP 0x8                
MOVWF INDF1              
MOVLB 0x0                
INCF 0x64, F             
MOVLW 0xF                
SUBWF 0x64, W            
BTFSS STATUS, 0x0        
GOTO 0x6E7               
MOVLW 0xD                
MOVWF 0x74               
MOVLW 0xD3               
CALL 0x737               
MOVLP 0x8                
MOVLB 0x3                
MOVF 0x60, W             
MOVLB 0x0                
XORWF 0x29, W            
BTFSS STATUS, 0x2        
GOTO 0x709               
MOVLB 0x3                
MOVF 0x61, W             
MOVLB 0x0                
XORWF 0x28, W            
BTFSC STATUS, 0x2        
CLRF 0x63                
INCF 0x48, F             
MOVF 0x63, W             
XORLW 0xFF               
BTFSS STATUS, 0x2        
GOTO 0x712               
MOVLW 0x2                
SUBWF 0x48, W            
BTFSS STATUS, 0x0        
GOTO 0x6E4               
MOVF 0x63, F             
BTFSS STATUS, 0x2        
GOTO 0x718               
CALL 0x7B4               
MOVLP 0x8                
GOTO 0x71B               
MOVLP 0x6                
CALL 0x6C5               
MOVLP 0x8                
CLRWDT                   
MOVLB 0x0                
CLRF 0x64                
MOVF 0x64, W             
ADDLW 0x20               
MOVWF FSR1L               
MOVLW 0x2                
MOVWF FSR1H              
MOVF 0x64, W             
ADDLW 0xF6               
CALL 0x72F               
MOVLP 0x8                
MOVWF INDF1              
MOVLB 0x0                
INCF 0x64, F             
MOVLW 0xA                
SUBWF 0x64, W            
BTFSC STATUS, 0x0        
RETURN                   
GOTO 0x71E               
MOVWF 0x74               
MOVLB 0x3                
MOVWF PIR1               
CLRF PIR2                
BSF TMR0, 0x0            
MOVF PIR3, W             
MOVWF 0x75               
RETURN                   
MOVLB 0x0                
MOVWF 0x60               
MOVLW 0xAA               
MOVWF 0x29               
MOVF 0x60, W             
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF INDF1, W            
MOVWF 0x28               
CLRF 0x62                
INCF 0x62, F             
MOVF 0x74, W             
ADDLW 0x2                
MOVWF 0x5D               
MOVLW 0x0                
BTFSC STATUS, 0x0        
MOVLW 0x1                
MOVWF 0x5E               
XORLW 0x80               
SUBLW 0x80               
BTFSS STATUS, 0x2        
GOTO 0x750               
MOVF 0x5D, W             
SUBWF 0x62, W            
BTFSC STATUS, 0x0        
RETURN                   
MOVF 0x74, W             
MOVLB 0x0                
SUBWF 0x62, W            
BTFSC STATUS, 0x0        
GOTO 0x760               
MOVF 0x62, W             
ADDWF 0x60, W            
MOVWF 0x5D               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF INDF1, W            
MOVWF 0x5F               
GOTO 0x761               
CLRF 0x5F                
CLRF 0x61                
BCF 0x3B, 0x2            
BTFSC 0x29, 0x7          
BSF 0x3B, 0x2            
LSLF 0x28, F             
RLF 0x29, F              
BTFSC 0x5F, 0x7          
BSF 0x28, 0x0            
LSLF 0x5F, F             
BTFSS 0x3B, 0x2          
GOTO 0x770               
MOVLW 0x80               
XORWF 0x29, F            
MOVLW 0x5                
XORWF 0x28, F            
INCF 0x61, F             
MOVLW 0x8                
SUBWF 0x61, W            
BTFSC STATUS, 0x0        
GOTO 0x742               
GOTO 0x762               
MOVWF 0x5E               
CLRF 0x5D                
MOVF 0x74, W             
BTFSC 0x5E, 0x0          
ADDWF 0x5D, F            
LSLF 0x74, F             
LSRF 0x5E, F             
MOVF 0x5E, F             
BTFSS STATUS, 0x2        
GOTO 0x778               
MOVF 0x5D, W             
RETURN                   
MOVLB 0x3                
MOVF 0x53, W             
MOVLB 0x0                
MOVWF 0x20               
MOVLB 0x3                
MOVF 0x54, W             
MOVLB 0x0                
MOVWF 0x21               
MOVLB 0x3                
MOVF 0x55, W             
MOVLB 0x0                
MOVWF 0x22               
MOVLB 0x3                
MOVF 0x56, W             
MOVLB 0x0                
MOVWF 0x23               
RETURN                   
MOVLW 0x2                
MOVLB 0x0                
MOVWF 0x20               
CLRF 0x21                
CLRF 0x22                
CLRF 0x23                
INCF 0x23, F             
RETURN                   
MOVLB 0x1                
CLRF 0x2F                
CLRF 0x30                
CLRF 0x31                
CLRF 0x32                
CLRF 0x2B                
CLRF 0x2C                
CLRF 0x2D                
CLRF 0x2E                
CLRF 0x2A                
CLRF 0x20                
CLRF 0x21                
CLRF 0x22                
CLRF 0x23                
CLRF 0x24                
CLRF 0x25                
CLRF 0x26                
CLRF 0x27                
CLRF 0x28                
CLRF 0x29                
CLRF 0x33                
CLRF 0x34                
CLRF 0x35                
CLRF 0x36                
RETURN                   
MOVLB 0x3                
MOVF 0x53, W             
MOVLB 0x2                
MOVWF 0x20               
MOVLB 0x3                
MOVF 0x54, W             
MOVWF 0x77               
MOVF 0x55, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x2                
MOVWF 0x22               
MOVF 0x76, W             
MOVWF 0x21               
MOVLB 0x3                
MOVF 0x56, W             
MOVWF 0x77               
MOVF 0x57, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x2                
MOVWF 0x24               
MOVF 0x76, W             
MOVWF 0x23               
MOVLB 0x3                
MOVF 0x58, W             
MOVWF 0x77               
MOVF 0x59, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x2                
MOVWF 0x26               
MOVF 0x76, W             
MOVWF 0x25               
MOVLB 0x3                
MOVF 0x5A, W             
MOVWF 0x77               
MOVF 0x5B, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x2                
MOVWF 0x28               
MOVF 0x76, W             
MOVWF 0x27               
MOVLB 0x3                
MOVF 0x5C, W             
MOVWF 0x77               
MOVF 0x5D, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x2                
MOVWF 0x2A               
MOVF 0x76, W             
MOVWF 0x29               
MOVLB 0x3                
MOVF 0x5E, W             
MOVWF 0x77               
MOVF 0x5F, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x2                
MOVWF 0x2C               
MOVF 0x76, W             
MOVWF 0x2B               
RETURN                   
MOVF 0x64, W             
ADDLW 0xD3               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
RETURN                   
MOVLW 0xFF               
MOVLB 0x0                
MOVWF 0x63               
CLRF 0x64                
RETURN                   
MOVWI -1[FSR1]           
CLRWDT                   
CLRF INDF0               
ADDFSR 0, 1              
DECFSZ WREG, F           
GOTO 0x2                 
RETLW 0x0                
MOVLB 0x2                
MOVF 0x62, W             
MOVLB 0x1                
SUBWF 0x54, W            
BTFSC STATUS, 0x0        
GOTO 0x18                
MOVF 0x54, W             
ADDLW 0xA0               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF INDF1, W            
MOVLB 0x3                
MOVWF TMR2               
MOVLB 0x1                
INCF 0x54, F             
RETURN                   
BCF PIR1, 0x4            
MOVLW 0x2                
MOVWF 0x51               
RETURN                   
MOVLB 0x3                
BTFSC 0x1D, 0x2          
GOTO 0x21                
BTFSS 0x1D, 0x1          
GOTO 0x28                
BCF 0x1D, 0x4            
MOVF T1GCON, W           
MOVLB 0x1                
CLRF 0x53                
MOVLB 0x3                
BSF 0x1D, 0x4            
RETURN                   
MOVF T1GCON, W           
MOVWF 0x70               
MOVLB 0x0                
BTFSS 0x39, 0x7          
BTFSC 0x39, 0x6          
RETURN                   
MOVLW 0x14               
MOVLB 0x1                
MOVWF 0x50               
MOVF 0x53, F             
BTFSS STATUS, 0x2        
GOTO 0x3E                
MOVF 0x70, W             
XORLW 0xA                
BTFSS STATUS, 0x2        
RETURN                   
MOVF 0x70, W             
MOVLB 0x3                
MOVWF 0x20               
MOVLB 0x1                
INCF 0x53, F             
RETURN                   
DECFSZ 0x53, W           
GOTO 0x4F                
MOVLW 0x19               
SUBWF 0x70, W            
BTFSC STATUS, 0x0        
GOTO 0x4D                
MOVF 0x70, W             
MOVLB 0x3                
MOVWF 0x21               
MOVLB 0x1                
INCF 0x53, F             
MOVF 0x70, W             
MOVLB 0x2                
MOVWF 0x61               
RETURN                   
CLRF 0x53                
RETURN                   
MOVF 0x53, W             
ADDLW 0xA0               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF 0x70, W             
MOVWF INDF1              
INCF 0x53, F             
MOVF 0x53, W             
MOVLB 0x2                
SUBWF 0x61, W            
BTFSC STATUS, 0x0        
RETURN                   
MOVLB 0x0                
BSF 0x39, 0x7            
RETURN                   
BTFSS 0x36, 0x1          
GOTO 0x63                
CLRF 0x4F                
CLRF 0x4D                
BTFSC 0x78, 0x6          
GOTO 0x67                
MOVLB 0x2                
CLRF 0x51                
BTFSS 0x79, 0x6          
GOTO 0x70                
MOVLB 0x0                
BTFSS 0x41, 0x4          
GOTO 0x70                
MOVLW 0xB                
MOVWF 0x4F               
CLRF 0x4D                
GOTO 0x8F                
BTFSS 0x79, 0x6          
GOTO 0x7D                
MOVLB 0x0                
BTFSC 0x41, 0x4          
GOTO 0x7D                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x8F                
MOVF 0x4D, F             
BTFSC STATUS, 0x2        
GOTO 0x6C                
GOTO 0x8F                
MOVLB 0x0                
BTFSC 0x38, 0x6          
GOTO 0x83                
MOVF 0x79, W             
BTFSC STATUS, 0x2        
GOTO 0x8F                
MOVF 0x4F, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0x8F                
MOVF 0x4D, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x8F                
MOVLW 0xB                
MOVWF 0x4F               
MOVLW 0x2                
MOVWF 0x4D               
MOVF 0x4B, F             
BTFSS STATUS, 0x2        
GOTO 0xA2                
MOVF 0x4F, W             
XORLW 0xE                
BTFSC STATUS, 0x2        
GOTO 0xA5                
MOVF 0x4F, W             
XORLW 0x8                
BTFSC STATUS, 0x2        
GOTO 0xA5                
MOVF 0x4F, W             
XORLW 0x9                
BTFSC STATUS, 0x2        
GOTO 0xA5                
MOVF 0x4F, W             
XORLW 0xD                
BTFSC STATUS, 0x2        
GOTO 0xA5                
MOVLW 0x96               
MOVLB 0x1                
MOVWF 0x57               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
BTFSS 0x79, 0x5          
GOTO 0xB4                
BTFSS 0x78, 0x6          
BTFSC 0x41, 0x4          
GOTO 0xB4                
MOVF 0x4D, W             
BTFSC STATUS, 0x2        
GOTO 0xB4                
MOVLB 0x2                
CLRF 0x50                
INCF 0x50, F             
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0xBD                
MOVF 0x4F, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0xC8                
BTFSC 0x38, 0x5          
BTFSS 0x41, 0x4          
GOTO 0xC8                
BTFSC 0x78, 0x6          
GOTO 0xC8                
BCF 0x41, 0x4            
MOVLW 0xC                
MOVWF 0x4F               
CLRF 0x4D                
INCF 0x4D, F             
GOTO 0x159               
MOVF 0x4F, W             
XORLW 0xE                
BTFSC STATUS, 0x2        
GOTO 0xD8                
MOVF 0x4F, W             
XORLW 0x8                
BTFSC STATUS, 0x2        
GOTO 0xD8                
MOVF 0x4F, W             
XORLW 0x9                
BTFSC STATUS, 0x2        
GOTO 0xD8                
MOVF 0x4F, W             
XORLW 0xD                
BTFSS STATUS, 0x2        
GOTO 0xE1                
MOVLB 0x1                
MOVF 0x57, F             
BTFSS STATUS, 0x2        
GOTO 0xE1                
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x4F               
CLRF 0x4D                
GOTO 0x159               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
BTFSS 0x79, 0x5          
GOTO 0xEF                
BTFSS 0x78, 0x6          
BTFSC 0x41, 0x4          
GOTO 0xEF                
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0xEF                
MOVLW 0xE                
GOTO 0xDE                
MOVF 0x4F, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
BTFSS 0x38, 0x5          
GOTO 0x10B               
BTFSC 0x78, 0x6          
GOTO 0x10B               
MOVLB 0x2                
MOVF 0x50, F             
BTFSS STATUS, 0x2        
GOTO 0x10B               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x159               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x159               
BTFSS 0x78, 0x6          
GOTO 0xC3                
MOVLW 0xC                
MOVWF 0x4F               
CLRF 0x4D                
MOVLW 0x1E               
MOVWF 0x34               
CLRF 0x35                
GOTO 0x159               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xE                
BTFSS STATUS, 0x2        
GOTO 0x124               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x124               
DECFSZ 0x4B, W           
GOTO 0x159               
BTFSS 0x79, 0x3          
GOTO 0x11B               
MOVLW 0xD                
MOVWF 0x4F               
CLRF 0x4D                
BTFSS 0x79, 0x0          
GOTO 0x120               
MOVLW 0x8                
MOVWF 0x4F               
CLRF 0x4D                
BTFSS 0x79, 0x5          
GOTO 0x159               
MOVLW 0x9                
GOTO 0xDE                
MOVF 0x4F, W             
XORLW 0xE                
BTFSS STATUS, 0x2        
GOTO 0x13A               
MOVF 0x4D, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x13A               
MOVF 0x4B, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x159               
BTFSS 0x79, 0x3          
GOTO 0x135               
MOVLW 0xF                
MOVWF 0x4F               
CLRF 0x4D                
BTFSS 0x79, 0x5          
GOTO 0x159               
BCF 0x3D, 0x5            
BSF 0x43, 0x7            
GOTO 0x159               
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x14F               
BTFSS 0x79, 0x3          
BTFSC 0x79, 0x0          
GOTO 0x143               
BTFSS 0x38, 0x5          
GOTO 0x14F               
MOVLW 0x2                
SUBWF 0x4D, W            
BTFSS STATUS, 0x0        
GOTO 0x149               
BSF 0x41, 0x4            
GOTO 0x14A               
BCF 0x41, 0x4            
MOVLW 0xC                
MOVWF 0x4F               
MOVLW 0x5                
MOVWF 0x4D               
GOTO 0x159               
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
BTFSS 0x38, 0x6          
GOTO 0x159               
MOVLW 0xC                
MOVWF 0x4F               
CLRF 0x4D                
INCF 0x4D, F             
BCF 0x41, 0x4            
MOVF 0x4F, W             
XORLW 0x8                
BTFSS STATUS, 0x2        
GOTO 0x184               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x165               
MOVF 0x4B, F             
BTFSS STATUS, 0x2        
GOTO 0x184               
INCF 0x4D, F             
GOTO 0x184               
DECFSZ 0x4D, W           
GOTO 0x184               
BTFSS 0x79, 0x3          
GOTO 0x16D               
DECFSZ 0x4B, W           
GOTO 0x16D               
CLRF 0x20                
GOTO 0x17A               
BTFSS 0x79, 0x0          
GOTO 0x174               
DECFSZ 0x4B, W           
GOTO 0x174               
CLRF 0x20                
INCF 0x20, F             
GOTO 0x17A               
BTFSS 0x79, 0x5          
GOTO 0x180               
DECFSZ 0x4B, W           
GOTO 0x180               
MOVLW 0x2                
MOVWF 0x20               
MOVLW 0x11               
MOVLP 0x4                
CALL 0x48E               
MOVLP 0x10               
MOVLB 0x0                
INCF 0x4D, F             
CALL 0x404               
MOVLP 0x10               
MOVLB 0x0                
BSF 0x51, 0x4            
MOVF 0x4F, W             
XORLW 0x9                
BTFSS STATUS, 0x2        
GOTO 0x1AF               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x190               
MOVF 0x4B, F             
BTFSS STATUS, 0x2        
GOTO 0x1AF               
INCF 0x4D, F             
GOTO 0x1AF               
DECFSZ 0x4D, W           
GOTO 0x1AF               
BTFSS 0x79, 0x3          
GOTO 0x198               
DECFSZ 0x4B, W           
GOTO 0x198               
CLRF 0x21                
GOTO 0x1A5               
BTFSS 0x79, 0x0          
GOTO 0x19F               
DECFSZ 0x4B, W           
GOTO 0x19F               
CLRF 0x21                
INCF 0x21, F             
GOTO 0x1A5               
BTFSS 0x79, 0x5          
GOTO 0x1AB               
DECFSZ 0x4B, W           
GOTO 0x1AB               
MOVLW 0x2                
MOVWF 0x21               
MOVLW 0x12               
MOVLP 0x4                
CALL 0x48E               
MOVLP 0x10               
MOVLB 0x0                
INCF 0x4D, F             
CALL 0x404               
MOVLP 0x10               
MOVLB 0x0                
BSF 0x51, 0x4            
MOVF 0x4F, W             
XORLW 0xD                
BTFSS STATUS, 0x2        
GOTO 0x1DA               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x1BB               
MOVF 0x4B, F             
BTFSS STATUS, 0x2        
GOTO 0x1DA               
INCF 0x4D, F             
GOTO 0x1DA               
DECFSZ 0x4D, W           
GOTO 0x1DA               
BTFSS 0x79, 0x3          
GOTO 0x1C3               
DECFSZ 0x4B, W           
GOTO 0x1C3               
CLRF 0x23                
GOTO 0x1D0               
BTFSS 0x79, 0x0          
GOTO 0x1CA               
DECFSZ 0x4B, W           
GOTO 0x1CA               
CLRF 0x23                
INCF 0x23, F             
GOTO 0x1D0               
BTFSS 0x79, 0x5          
GOTO 0x1D6               
DECFSZ 0x4B, W           
GOTO 0x1D6               
MOVLW 0x2                
MOVWF 0x23               
MOVLW 0x10               
MOVLP 0x4                
CALL 0x48E               
MOVLP 0x10               
MOVLB 0x0                
INCF 0x4D, F             
CALL 0x404               
MOVLP 0x10               
MOVLB 0x0                
BSF 0x51, 0x4            
BTFSC 0x78, 0x0          
GOTO 0x1DE               
BTFSS 0x78, 0x3          
GOTO 0x1EC               
DECFSZ 0x4B, W           
GOTO 0x1EC               
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x1EC               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x1F0               
MOVF 0x4D, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x1F0               
MOVLW 0x1E               
MOVLB 0x1                
MOVWF 0x5E               
GOTO 0x1FC               
MOVLB 0x1                
MOVF 0x5E, W             
BTFSC STATUS, 0x2        
GOTO 0x1FC               
MOVLB 0x0                
BTFSS 0x3A, 0x3          
GOTO 0x1FC               
MOVLB 0x1                
DECFSZ 0x5E, F           
GOTO 0x1FC               
MOVLB 0x0                
BSF 0x3C, 0x7            
MOVLB 0x0                
BTFSS 0x41, 0x4          
GOTO 0x20C               
MOVLW 0x2                
SUBWF 0x2B, W            
MOVLW 0xAA               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x20C               
BCF 0x41, 0x4            
MOVLW 0xB                
MOVWF 0x4F               
MOVLW 0x2                
MOVWF 0x4D               
GOTO 0x220               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
GOTO 0x220               
MOVF 0x4D, W             
BTFSS STATUS, 0x2        
BTFSS 0x41, 0x4          
GOTO 0x220               
MOVLW 0x2                
SUBWF 0x2B, W            
MOVLW 0xAB               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
BTFSC 0x78, 0x6          
GOTO 0x220               
BSF 0x41, 0x4            
MOVLW 0x3                
MOVWF 0x4F               
CLRF 0x4D                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x2E1               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x24B               
MOVLB 0x1                
BCF 0x41, 0x0            
MOVLB 0x0                
BTFSS 0x41, 0x4          
BTFSC 0x78, 0x6          
GOTO 0x2E1               
BTFSC 0x79, 0x3          
GOTO 0x231               
BTFSS 0x79, 0x0          
GOTO 0x234               
DECF 0x4B, W             
BTFSC STATUS, 0x2        
GOTO 0x23A               
BTFSC 0x53, 0x2          
GOTO 0x238               
BTFSS 0x53, 0x0          
GOTO 0x2E1               
BTFSS 0x40, 0x2          
GOTO 0x2E1               
BCF 0x3C, 0x7            
BTFSC 0x79, 0x3          
GOTO 0x240               
BTFSC 0x53, 0x2          
BTFSS 0x40, 0x2          
GOTO 0x243               
CLRF 0x37                
INCF 0x4D, F             
GOTO 0x2E1               
BTFSC 0x79, 0x0          
GOTO 0x248               
BTFSC 0x53, 0x0          
BTFSS 0x40, 0x2          
GOTO 0x2E1               
CLRF 0x37                
INCF 0x37, F             
GOTO 0x241               
MOVLW 0x7                
SUBWF 0x4D, W            
BTFSC STATUS, 0x0        
GOTO 0x2C2               
MOVF 0x79, W             
BTFSS STATUS, 0x2        
BTFSC 0x3C, 0x7          
GOTO 0x25D               
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x25D               
MOVF 0x4D, W             
XORLW 0x5                
BTFSC STATUS, 0x2        
GOTO 0x25D               
MOVLW 0x7                
MOVWF 0x4D               
BTFSC 0x78, 0x0          
GOTO 0x261               
BTFSS 0x78, 0x3          
GOTO 0x26B               
MOVF 0x4D, W             
XORLW 0x6                
BTFSS STATUS, 0x2        
GOTO 0x26B               
MOVLB 0x1                
BSF 0x41, 0x0            
MOVLW 0x6                
MOVLB 0x0                
MOVWF 0x4D               
GOTO 0x2E1               
BTFSS 0x78, 0x0          
BTFSC 0x78, 0x3          
GOTO 0x2E1               
BTFSS 0x3C, 0x7          
GOTO 0x2E1               
BCF 0x3C, 0x7            
CALL 0x414               
MOVLP 0x10               
MOVF 0x37, F             
BTFSS STATUS, 0x2        
GOTO 0x29B               
MOVLW 0x0                
SUBWF 0x31, W            
MOVLW 0x41               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
GOTO 0x282               
MOVLW 0x41               
MOVLB 0x2                
MOVWF 0x21               
CLRF 0x22                
GOTO 0x296               
MOVLW 0x2                
SUBWF 0x31, W            
MOVLW 0xBD               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSS STATUS, 0x0        
GOTO 0x28F               
MOVLW 0xBC               
MOVLB 0x2                
MOVWF 0x21               
MOVLW 0x2                
MOVWF 0x22               
GOTO 0x296               
MOVF 0x31, W             
MOVLB 0x2                
MOVWF 0x22               
MOVLB 0x0                
MOVF 0x30, W             
MOVLB 0x2                
MOVWF 0x21               
MOVLW 0x5                
MOVLP 0x4                
CALL 0x48E               
MOVLP 0x10               
GOTO 0x2E1               
DECFSZ 0x37, W           
GOTO 0x2E1               
MOVLW 0x0                
SUBWF 0x31, W            
MOVLW 0x41               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
GOTO 0x2A9               
MOVLW 0x41               
MOVLB 0x2                
MOVWF 0x23               
CLRF 0x24                
GOTO 0x2BD               
MOVLW 0x2                
SUBWF 0x31, W            
MOVLW 0xBD               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSS STATUS, 0x0        
GOTO 0x2B6               
MOVLW 0xBC               
MOVLB 0x2                
MOVWF 0x23               
MOVLW 0x2                
MOVWF 0x24               
GOTO 0x2BD               
MOVF 0x31, W             
MOVLB 0x2                
MOVWF 0x24               
MOVLB 0x0                
MOVF 0x30, W             
MOVLB 0x2                
MOVWF 0x23               
MOVLW 0x6                
MOVLP 0x4                
CALL 0x48E               
MOVLP 0x10               
GOTO 0x2E1               
MOVF 0x4D, W             
XORLW 0x5                
BTFSS STATUS, 0x2        
GOTO 0x2CA               
BTFSS 0x79, 0x3          
GOTO 0x2E1               
BSF 0x3E, 0x3            
GOTO 0x2E1               
MOVF 0x4D, W             
XORLW 0x6                
BTFSS STATUS, 0x2        
GOTO 0x2D1               
BTFSS 0x78, 0x3          
GOTO 0x2C8               
GOTO 0x2E1               
MOVF 0x4D, W             
XORLW 0x9                
BTFSS STATUS, 0x2        
GOTO 0x2E1               
MOVLW 0x0                
SUBWF 0x31, W            
MOVLW 0x41               
BTFSC STATUS, 0x2        
SUBWF 0x30, W            
BTFSC STATUS, 0x0        
GOTO 0x2DF               
MOVLB 0x1                
BTFSS 0x41, 0x0          
GOTO 0x2E1               
MOVLB 0x0                
BSF 0x3B, 0x4            
BTFSC 0x78, 0x5          
BTFSS 0x78, 0x3          
GOTO 0x2EF               
MOVLB 0x0                
MOVF 0x4B, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x2EF               
MOVF 0x4F, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
MOVF 0x4D, W             
BTFSC STATUS, 0x2        
GOTO 0x2F3               
MOVLW 0x32               
MOVLB 0x1                
MOVWF 0x56               
GOTO 0x303               
BTFSS 0x3A, 0x3          
GOTO 0x303               
MOVLB 0x1                
MOVF 0x56, W             
BTFSC STATUS, 0x2        
GOTO 0x303               
DECFSZ 0x56, F           
GOTO 0x303               
MOVLW 0x3C               
MOVLB 0x0                
MOVWF 0x34               
CLRF 0x35                
MOVLW 0x5                
MOVWF 0x4F               
CLRF 0x4D                
CLRF 0x4E                
MOVLB 0x0                
BTFSS 0x43, 0x7          
GOTO 0x317               
BTFSC 0x3D, 0x5          
GOTO 0x30F               
MOVLW 0x23               
MOVLB 0x1                
MOVWF 0x46               
MOVLW 0x4                
MOVLB 0x2                
MOVWF 0x59               
GOTO 0x313               
MOVLB 0x1                
CLRF 0x46                
MOVLB 0x2                
CLRF 0x59                
MOVLW 0x2                
MOVLB 0x0                
MOVWF 0x4F               
CLRF 0x4D                
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x352               
MOVF 0x4D, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x320               
BSF 0x3C, 0x6            
MOVF 0x4D, F             
BTFSC STATUS, 0x2        
BTFSS 0x78, 0x6          
GOTO 0x32A               
DECFSZ 0x4B, W           
GOTO 0x32A               
INCF 0x4D, F             
CLRF 0x30                
CLRF 0x31                
GOTO 0x34A               
MOVF 0x4D, W             
XORLW 0x9                
BTFSS STATUS, 0x2        
GOTO 0x339               
MOVLB 0x1                
MOVF 0x46, W             
BTFSC STATUS, 0x2        
GOTO 0x339               
MOVLB 0x0                
BTFSC 0x3D, 0x5          
GOTO 0x339               
MOVLB 0x1                
DECF 0x46, F             
MOVLW 0x7                
GOTO 0x348               
MOVLB 0x0                
MOVF 0x4D, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0x34A               
MOVLB 0x2                
MOVF 0x59, W             
BTFSC STATUS, 0x2        
GOTO 0x34A               
MOVLB 0x0                
BTFSC 0x3D, 0x5          
GOTO 0x34A               
MOVLB 0x2                
DECF 0x59, F             
MOVLW 0x9                
MOVLB 0x0                
MOVWF 0x4D               
BTFSS 0x79, 0x5          
GOTO 0x352               
MOVLB 0x0                
DECFSZ 0x4D, W           
GOTO 0x352               
INCF 0x4D, F             
CLRF 0x30                
CLRF 0x31                
CLRF 0x75                
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x35C               
CLRF 0x75                
INCF 0x75, F             
MOVLW 0x64               
GOTO 0x390               
MOVF 0x4F, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0x370               
CLRF 0x75                
INCF 0x75, F             
BTFSS 0x41, 0x4          
GOTO 0x36A               
MOVLW 0x50               
MOVLB 0x3                
MOVWF 0x47               
CLRF 0x48                
MOVLW 0x32               
GOTO 0x3B1               
MOVLW 0xA                
MOVLB 0x3                
MOVWF 0x47               
CLRF 0x48                
MOVLW 0x4                
GOTO 0x3B1               
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x3C9               
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x3C9               
MOVF 0x4D, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x3C9               
CLRF 0x75                
INCF 0x75, F             
GOTO 0x3B4               
MOVLB 0x0                
BTFSS 0x3C, 0x4          
GOTO 0x384               
MOVLW 0x1A               
GOTO 0x3A7               
MOVLW 0x21               
GOTO 0x3AD               
MOVLB 0x0                
BTFSS 0x3C, 0x4          
GOTO 0x38F               
MOVLW 0x50               
MOVLB 0x3                
MOVWF 0x47               
CLRF 0x48                
MOVLW 0x6                
GOTO 0x3B1               
MOVLW 0x60               
MOVLB 0x3                
MOVWF 0x47               
CLRF 0x48                
MOVLW 0x8                
GOTO 0x3B1               
MOVLB 0x0                
BTFSS 0x3C, 0x4          
GOTO 0x39A               
MOVLW 0x32               
GOTO 0x3A7               
MOVLW 0x3B               
GOTO 0x3AD               
MOVLB 0x0                
BTFSS 0x3C, 0x4          
GOTO 0x3A1               
MOVLW 0x50               
GOTO 0x3A7               
MOVLW 0x59               
GOTO 0x3AD               
MOVLB 0x0                
BTFSS 0x3C, 0x4          
GOTO 0x3AC               
MOVLW 0x12               
MOVLB 0x3                
MOVWF 0x47               
CLRF 0x48                
MOVLW 0xC                
GOTO 0x3B1               
MOVLW 0x17               
MOVLB 0x3                
MOVWF 0x47               
CLRF 0x48                
MOVLW 0xF                
MOVWF 0x4D               
CLRF 0x4E                
GOTO 0x3C9               
MOVLB 0x2                
MOVF 0x58, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x37F               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x386               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x395               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x39C               
XORLW 0x7                
BTFSC STATUS, 0x2        
GOTO 0x3A3               
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x4F               
CLRF 0x4D                
BCF INTCON, 0x7          
DECFSZ 0x75, W           
GOTO 0x3CF               
MOVLB 0x0                
BSF 0x3B, 0x7            
GOTO 0x3D1               
MOVLB 0x0                
BCF 0x3B, 0x7            
MOVLB 0x3                
MOVF 0x48, W             
MOVLB 0x1                
MOVWF 0x38               
MOVLB 0x3                
MOVF 0x47, W             
MOVLB 0x1                
MOVWF 0x37               
MOVLB 0x3                
MOVF 0x4E, W             
MOVWF 0x4C               
MOVF 0x4D, W             
MOVWF 0x4B               
BSF INTCON, 0x7          
MOVLB 0x0                
BTFSS 0x3A, 0x3          
GOTO 0x3EA               
MOVLB 0x1                
MOVF 0x5C, W             
BTFSC STATUS, 0x2        
GOTO 0x3EA               
DECFSZ 0x5C, F           
GOTO 0x3EA               
MOVLB 0x0                
BSF 0x51, 0x4            
MOVLB 0x0                
MOVF 0x5B, F             
BTFSC STATUS, 0x2        
CLRF 0x50                
MOVF 0x4F, W             
XORLW 0x3                
BTFSC STATUS, 0x2        
MOVF 0x4D, W             
BTFSC STATUS, 0x2        
GOTO 0x3F9               
MOVLW 0xA0               
MOVLB 0x2                
MOVWF 0x43               
MOVLW 0xF                
MOVWF 0x44               
MOVLB 0x0                
MOVF 0x58, W             
BTFSC STATUS, 0x2        
RETURN                   
MOVLW 0xC8               
MOVLB 0x1                
MOVWF 0x4C               
MOVLB 0x0                
BCF 0x3B, 0x3            
BCF 0x3B, 0x0            
RETURN                   
MOVF 0x20, W             
MOVLB 0x3                
MOVWF 0x53               
MOVLB 0x0                
MOVF 0x21, W             
MOVLB 0x3                
MOVWF 0x54               
MOVLB 0x0                
MOVF 0x22, W             
MOVLB 0x3                
MOVWF 0x55               
MOVLB 0x0                
MOVF 0x23, W             
MOVLB 0x3                
MOVWF 0x56               
RETURN                   
MOVLW 0x5                
MOVLB 0x1                
MOVWF 0x58               
MOVLW 0x7                
MOVLB 0x0                
MOVWF 0x4D               
RETURN                   
MOVLW 0xA0               
MOVLB 0x3                
MOVWF 0x20               
MOVLW 0xE                
MOVWF 0x21               
MOVLW 0xF0               
MOVWF 0x22               
MOVLW 0xF                
MOVWF 0x23               
CLRF 0x75                
MOVF 0x75, W             
ADDLW 0xA4               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF 0x75, W             
ADDLW 0x20               
MOVWF FSR0L               
MOVLW 0x2                
MOVWF FSR0H              
MOVF INDF0, W            
MOVWF INDF1              
INCF 0x75, F             
MOVLW 0xA                
SUBWF 0x75, W            
BTFSS STATUS, 0x0        
GOTO 0x425               
MOVLB 0x3                
MOVF 0x21, W             
CALL 0x4E8               
MOVLP 0x14               
MOVWF 0x74               
CALL 0x7F3               
MOVLP 0x14               
MOVF 0x74, W             
MOVWF INDF1              
GOTO 0x7E5               
MOVLB 0x0                
BTFSS 0x39, 0x7          
RETURN                   
MOVLB 0x3                
MOVF 0x21, W             
CALL 0x4E8               
MOVLP 0x14               
MOVWF 0x6B               
CALL 0x7F3               
MOVLP 0x14               
MOVF INDF1, W            
MOVLB 0x0                
XORWF 0x6B, W            
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x3                
MOVF 0x23, W             
MOVLB 0x0                
MOVWF 0x54               
GOTO 0x4CC               
MOVF 0x21, W             
XORLW 0x4                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
CALL 0x4FC               
MOVLP 0x14               
GOTO 0x4E3               
MOVF 0x21, W             
XORLW 0x4                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
CALL 0x55F               
MOVLP 0x14               
GOTO 0x4E3               
MOVF 0x21, W             
XORLW 0x5                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLW 0x2                
MOVLB 0x2                
MOVWF 0x6A               
MOVLB 0x3                
MOVF 0x24, W             
MOVLB 0x0                
MOVWF 0x53               
GOTO 0x45D               
MOVF 0x21, W             
XORLW 0x9                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLW 0x2                
MOVWF 0x5B               
MOVLW 0x3                
MOVWF 0x50               
MOVLB 0x3                
MOVF 0x24, W             
MOVLB 0x0                
MOVWF 0x44               
MOVLB 0x3                
MOVF 0x25, W             
MOVLB 0x1                
MOVWF 0x43               
MOVLB 0x3                
MOVF 0x26, W             
MOVLB 0x2                
MOVWF 0x52               
MOVLB 0x3                
MOVF 0x27, W             
MOVLB 0x2                
MOVWF 0x53               
MOVLB 0x3                
MOVF 0x28, W             
MOVLB 0x2                
MOVWF 0x54               
MOVLW 0x2                
MOVLB 0x0                
XORWF 0x39, F            
BTFSC 0x39, 0x1          
GOTO 0x45D               
GOTO 0x469               
MOVF 0x21, W             
XORLW 0x7                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSC STATUS, 0x2        
GOTO 0x4B1               
MOVF 0x54, W             
XORLW 0xF0               
BTFSS STATUS, 0x2        
GOTO 0x4E3               
CALL 0x5AA               
MOVLP 0x14               
GOTO 0x4E3               
MOVF 0x21, W             
XORLW 0xA                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
CALL 0x714               
MOVLP 0x14               
GOTO 0x4E3               
MOVF 0x21, W             
XORLW 0x4                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
MOVLB 0x0                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x4E3               
CALL 0x41B               
MOVLP 0x14               
GOTO 0x4E3               
MOVLB 0x3                
MOVF 0x22, W             
XORLW 0x60               
BTFSC STATUS, 0x2        
GOTO 0x454               
XORLW 0x10               
BTFSC STATUS, 0x2        
GOTO 0x460               
XORLW 0xF0               
BTFSC STATUS, 0x2        
GOTO 0x47D               
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x46C               
XORLW 0x12               
BTFSC STATUS, 0x2        
GOTO 0x4B4               
XORLW 0x5                
BTFSC STATUS, 0x2        
GOTO 0x4A4               
XORLW 0x65               
BTFSC STATUS, 0x2        
GOTO 0x4C0               
MOVLB 0x1                
CLRF 0x53                
MOVLB 0x0                
BCF 0x39, 0x7            
RETURN                   
MOVLB 0x0                
MOVWF 0x5D               
MOVLW 0x55               
MOVWF 0x5E               
CLRF 0x5F                
MOVF 0x5D, W             
SUBWF 0x5F, W            
BTFSC STATUS, 0x0        
GOTO 0x4FA               
MOVF 0x5F, W             
ADDLW 0xA0               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF INDF1, W            
XORWF 0x5E, F            
INCF 0x5F, F             
GOTO 0x4ED               
MOVF 0x5E, W             
RETURN                   
CLRF 0x74                
MOVLW 0xA0               
MOVLB 0x3                
MOVWF 0x20               
MOVLW 0x13               
MOVWF 0x21               
MOVLW 0x60               
MOVWF 0x22               
MOVLW 0xF                
MOVWF 0x23               
CALL 0x552               
MOVLP 0x14               
MOVF 0x4C, W             
MOVLB 0x3                
MOVWF 0x24               
MOVLB 0x0                
BTFSC 0x3C, 0x7          
BSF 0x74, 0x0            
MOVLB 0x1                
BTFSC 0x41, 0x0          
BSF 0x74, 0x1            
MOVLB 0x0                
BTFSC 0x36, 0x6          
BSF 0x74, 0x2            
BTFSC 0x43, 0x7          
BSF 0x74, 0x3            
BTFSC 0x36, 0x2          
BSF 0x74, 0x4            
MOVF 0x74, W             
MOVLB 0x3                
MOVWF 0x25               
CLRF 0x26                
CLRF 0x27                
CLRF 0x28                
MOVLB 0x0                
MOVF 0x4F, W             
MOVLB 0x3                
MOVWF 0x29               
MOVLB 0x0                
MOVF 0x4D, W             
MOVLB 0x3                
MOVWF 0x2A               
MOVLB 0x1                
MOVF 0x3A, W             
MOVWF 0x77               
MOVF 0x39, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x2B               
MOVF 0x76, W             
MOVWF 0x2C               
MOVLB 0x0                
MOVF 0x31, W             
MOVWF 0x77               
MOVF 0x30, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x2D               
MOVF 0x76, W             
MOVWF 0x2E               
MOVLB 0x0                
MOVF 0x2B, W             
MOVWF 0x77               
MOVF 0x2A, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x2F               
MOVF 0x76, W             
MOVWF 0x30               
MOVF 0x50, W             
MOVWF 0x77               
MOVF 0x4F, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVWF 0x31               
MOVF 0x76, W             
MOVWF 0x32               
MOVF 0x21, W             
CALL 0x4E8               
MOVLP 0x14               
MOVLB 0x3                
MOVWF 0x33               
GOTO 0x7E5               
MOVLB 0x2                
CLRF 0x4C                
BTFSC 0x78, 0x3          
BSF 0x4C, 0x0            
BTFSC 0x78, 0x0          
BSF 0x4C, 0x1            
BTFSC 0x78, 0x5          
BSF 0x4C, 0x4            
BTFSC 0x78, 0x6          
BSF 0x4C, 0x5            
BTFSC 0x78, 0x7          
BSF 0x4C, 0x6            
RETURN                   
MOVLB 0x0                
CLRF 0x60                
CLRF 0x61                
CLRF 0x62                
MOVLW 0xA0               
MOVLB 0x3                
MOVWF 0x20               
MOVLW 0x10               
MOVWF 0x21               
MOVLW 0x70               
MOVWF 0x22               
MOVLW 0xF                
MOVWF 0x23               
MOVLB 0x0                
BTFSC 0x36, 0x7          
BSF 0x62, 0x0            
BTFSC 0x36, 0x6          
BSF 0x62, 0x2            
BTFSC 0x36, 0x2          
BSF 0x62, 0x4            
BTFSC 0x36, 0x1          
BSF 0x62, 0x6            
BTFSC 0x36, 0x3          
BSF 0x62, 0x7            
MOVF 0x62, W             
MOVLB 0x3                
MOVWF 0x24               
CLRF 0x25                
MOVLB 0x0                
BTFSC 0x43, 0x2          
BSF 0x60, 0x2            
BTFSC 0x43, 0x0          
BSF 0x60, 0x0            
BTFSC 0x42, 0x2          
BSF 0x61, 0x2            
BTFSC 0x42, 0x3          
BSF 0x61, 0x3            
BTFSC 0x42, 0x4          
BSF 0x61, 0x4            
BTFSC 0x42, 0x5          
BSF 0x61, 0x5            
MOVF 0x60, W             
MOVLB 0x3                
MOVWF 0x26               
MOVLB 0x0                
MOVF 0x61, W             
MOVLB 0x3                
MOVWF 0x27               
MOVLB 0x0                
MOVF 0x4F, W             
MOVLB 0x3                
MOVWF 0x28               
MOVLB 0x0                
MOVF 0x4D, W             
MOVLB 0x3                
MOVWF 0x29               
MOVLB 0x2                
MOVF 0x56, W             
MOVLB 0x3                
MOVWF 0x2A               
CLRF 0x2B                
MOVLB 0x2                
MOVF 0x5A, W             
MOVLB 0x3                
MOVWF 0x2C               
CLRF 0x2D                
CLRF 0x2E                
MOVLW 0xB                
MOVWF 0x2F               
MOVF 0x21, W             
CALL 0x4E8               
MOVLP 0x14               
MOVLB 0x3                
MOVWF 0x30               
GOTO 0x7E5               
MOVLB 0x3                
MOVF 0x26, W             
MOVLB 0x0                
MOVWF 0x65               
CALL 0x7FA               
MOVLP 0x14               
MOVLW 0xA0               
MOVWF 0x20               
MOVLW 0x6                
MOVWF 0x21               
MOVLW 0x95               
MOVWF 0x22               
MOVLW 0xF                
MOVWF 0x23               
MOVLB 0x0                
CLRF 0x6A                
MOVF 0x65, W             
SUBWF 0x6A, W            
BTFSC STATUS, 0x0        
GOTO 0x5F3               
MOVLW 0x4                
MOVLB 0x3                
ADDWF 0x21, F            
MOVLB 0x0                
MOVF 0x6A, W             
MOVWF 0x5D               
CLRF 0x5E                
MOVF 0x76, W             
ADDWF 0x5D, F            
MOVF 0x77, W             
ADDWFC 0x5E, F           
CALL 0x5FD               
MOVLP 0x14               
MOVF 0x60, W             
MOVWF 0x69               
MOVF 0x5F, W             
MOVWF 0x68               
MOVF 0x5E, W             
MOVWF 0x67               
MOVF 0x5D, W             
MOVWF 0x66               
MOVF 0x6A, W             
ADDWF WREG, W            
ADDWF WREG, W            
ADDLW 0xA6               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF 0x69, W             
MOVWF INDF1              
MOVF 0x6A, W             
ADDWF WREG, W            
ADDWF WREG, W            
ADDLW 0xA7               
MOVWF FSR1L               
MOVF 0x68, W             
MOVWF INDF1              
MOVF 0x6A, W             
ADDWF WREG, W            
ADDWF WREG, W            
ADDLW 0xA8               
MOVWF FSR1L               
MOVF 0x67, W             
MOVWF INDF1              
MOVF 0x6A, W             
ADDWF WREG, W            
ADDWF WREG, W            
ADDLW 0xA9               
MOVWF FSR1L               
MOVF 0x66, W             
MOVWF INDF1              
INCF 0x6A, F             
GOTO 0x5BA               
MOVLB 0x3                
MOVF 0x21, W             
CALL 0x4E8               
MOVLP 0x14               
MOVWF 0x74               
CALL 0x7F3               
MOVLP 0x14               
MOVF 0x74, W             
MOVWF INDF1              
GOTO 0x7E5               
CLRF 0x61                
CLRF 0x62                
CLRF 0x63                
CLRF 0x64                
MOVF 0x54, W             
XORLW 0xF                
BTFSS STATUS, 0x2        
GOTO 0x70B               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0x7                
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
GOTO 0x641               
MOVF 0x5E, W             
IORWF 0x5D, W            
BTFSS STATUS, 0x2        
GOTO 0x613               
MOVLB 0x2                
MOVF 0x20, W             
GOTO 0x6A2               
DECF 0x5D, W             
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x61E               
MOVLB 0x2                
MOVF 0x21, W             
MOVLB 0x0                
MOVWF 0x61               
MOVLB 0x2                
MOVF 0x22, W             
GOTO 0x6C9               
MOVF 0x5D, W             
XORLW 0x2                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x62A               
MOVLB 0x2                
MOVF 0x23, W             
MOVLB 0x0                
MOVWF 0x61               
MOVLB 0x2                
MOVF 0x24, W             
GOTO 0x6C9               
MOVF 0x5D, W             
XORLW 0x3                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x631               
CLRF 0x61                
GOTO 0x708               
MOVF 0x5D, W             
XORLW 0x4                
IORWF 0x5E, W            
BTFSC STATUS, 0x2        
GOTO 0x62F               
MOVF 0x5D, W             
XORLW 0x5                
IORWF 0x5E, W            
BTFSC STATUS, 0x2        
GOTO 0x62F               
MOVF 0x5D, W             
XORLW 0x6                
IORWF 0x5E, W            
BTFSC STATUS, 0x2        
GOTO 0x62F               
GOTO 0x70B               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0x32               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
MOVLW 0x0                
BTFSS STATUS, 0x0        
GOTO 0x66C               
SUBWF 0x5E, W            
MOVLW 0x36               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
GOTO 0x66B               
MOVF 0x5D, W             
XORLW 0x32               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x656               
MOVF 0x20, W             
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0x33               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x65D               
MOVF 0x21, W             
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0x34               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x664               
MOVF 0x22, W             
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0x35               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x70B               
MOVF 0x23, W             
GOTO 0x707               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0x64               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
MOVLW 0x0                
BTFSS STATUS, 0x0        
GOTO 0x6DF               
SUBWF 0x5E, W            
MOVLW 0x6C               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
GOTO 0x6DE               
MOVF 0x5D, W             
XORLW 0x64               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x68F               
MOVLB 0x1                
MOVF 0x23, W             
MOVLB 0x0                
MOVWF 0x64               
MOVLB 0x1                
MOVF 0x22, W             
MOVLB 0x0                
MOVWF 0x63               
MOVLB 0x1                
MOVF 0x21, W             
MOVLB 0x0                
MOVWF 0x62               
MOVLB 0x1                
MOVF 0x20, W             
MOVLB 0x0                
MOVWF 0x61               
GOTO 0x70B               
MOVF 0x5D, W             
XORLW 0x65               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x69B               
MOVLB 0x1                
MOVF 0x28, W             
MOVLB 0x0                
MOVWF 0x61               
MOVLB 0x1                
MOVF 0x29, W             
GOTO 0x6C9               
MOVF 0x5D, W             
XORLW 0x66               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6A4               
MOVLB 0x1                
MOVF 0x2A, W             
MOVLB 0x0                
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0x67               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6AB               
MOVLW 0xB                
GOTO 0x6D2               
MOVF 0x5D, W             
XORLW 0x68               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6B2               
MOVLW 0xF                
GOTO 0x6D2               
MOVF 0x5D, W             
XORLW 0x69               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6BE               
MOVLB 0x1                
MOVF 0x33, W             
MOVLB 0x0                
MOVWF 0x61               
MOVLB 0x1                
MOVF 0x34, W             
GOTO 0x6C9               
MOVF 0x5D, W             
XORLW 0x6A               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6CC               
MOVLB 0x1                
MOVF 0x35, W             
MOVLB 0x0                
MOVWF 0x61               
MOVLB 0x1                
MOVF 0x36, W             
MOVLB 0x0                
MOVWF 0x62               
GOTO 0x709               
MOVF 0x5D, W             
XORLW 0x6B               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x70B               
MOVLW 0x4                
ADDLW 0xA0               
MOVWF FSR1L               
CLRF FSR1H               
MOVIW 0[FSR1]            
MOVWF 0x61               
MOVIW 1[FSR1]            
MOVWF 0x62               
MOVIW 2[FSR1]            
MOVWF 0x63               
MOVIW 3[FSR1]            
MOVWF 0x64               
GOTO 0x70B               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0xC8               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSS STATUS, 0x0        
GOTO 0x70B               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0xCC               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
GOTO 0x70B               
MOVF 0x5D, W             
XORLW 0xC8               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6F3               
MOVLW 0xB                
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0xC9               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x6FA               
MOVLW 0x1E               
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0xCA               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x701               
MOVLW 0x8                
GOTO 0x707               
MOVF 0x5D, W             
XORLW 0xCB               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x70B               
MOVLW 0xD                
MOVWF 0x61               
CLRF 0x62                
CLRF 0x63                
CLRF 0x64                
MOVF 0x64, W             
MOVWF 0x60               
MOVF 0x63, W             
MOVWF 0x5F               
MOVF 0x62, W             
MOVWF 0x5E               
MOVF 0x61, W             
MOVWF 0x5D               
RETURN                   
CALL 0x7FA               
MOVLP 0x14               
MOVF 0x26, W             
MOVLB 0x0                
MOVWF 0x66               
MOVLB 0x3                
MOVF 0x27, W             
MOVLB 0x0                
MOVWF 0x65               
MOVLB 0x3                
MOVF 0x28, W             
MOVLB 0x0                
MOVWF 0x64               
MOVLB 0x3                
MOVF 0x29, W             
MOVLB 0x0                
MOVWF 0x63               
MOVLW 0xA0               
MOVLB 0x3                
MOVWF 0x20               
MOVLW 0x7                
MOVWF 0x21               
MOVLW 0x90               
MOVWF 0x22               
MOVLW 0xF                
MOVWF 0x23               
MOVF 0x77, W             
MOVLB 0x0                
MOVWF 0x5E               
MOVF 0x76, W             
MOVWF 0x5D               
MOVF 0x66, W             
MOVWF 0x62               
MOVF 0x65, W             
MOVWF 0x61               
MOVF 0x64, W             
MOVWF 0x60               
MOVF 0x63, W             
MOVWF 0x5F               
CALL 0x74F               
MOVLP 0x14               
IORLW 0x0                
BTFSS STATUS, 0x2        
GOTO 0x743               
MOVLB 0x3                
CLRF 0x26                
GOTO 0x746               
MOVLW 0xFF               
MOVLB 0x3                
MOVWF 0x26               
MOVF 0x21, W             
CALL 0x4E8               
MOVLP 0x14               
MOVWF 0x75               
CALL 0x7F3               
MOVLP 0x14               
MOVF 0x75, W             
MOVWF INDF1              
GOTO 0x7E5               
MOVLW 0xFF               
MOVWF 0x74               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0x7                
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSS STATUS, 0x0        
GOTO 0x75D               
MOVF 0x5D, W             
XORLW 0x64               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7B1               
CLRF 0x74                
MOVLW 0x5                
MOVLB 0x1                
MOVWF 0x58               
MOVLB 0x0                
MOVF 0x5E, W             
IORWF 0x5D, W            
BTFSS STATUS, 0x2        
GOTO 0x76A               
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x20               
GOTO 0x7E3               
DECF 0x5D, W             
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x773               
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x21               
CLRF 0x22                
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x2                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x780               
MOVF 0x60, W             
MOVLB 0x2                
MOVWF 0x24               
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x23               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x3                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x78D               
MOVF 0x60, W             
MOVLB 0x2                
MOVWF 0x26               
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x25               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x4                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x79A               
MOVF 0x60, W             
MOVLB 0x2                
MOVWF 0x28               
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x27               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x5                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7A7               
MOVF 0x60, W             
MOVLB 0x2                
MOVWF 0x2A               
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x29               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x6                
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7E3               
MOVF 0x5F, W             
MOVLB 0x2                
MOVWF 0x2B               
CLRF 0x2C                
GOTO 0x7E3               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0x32               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSS STATUS, 0x0        
GOTO 0x7E3               
MOVLW 0x0                
SUBWF 0x5E, W            
MOVLW 0x36               
BTFSC STATUS, 0x2        
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
GOTO 0x7E3               
CLRF 0x74                
MOVLW 0x5                
MOVLB 0x1                
MOVWF 0x5C               
MOVLB 0x0                
MOVF 0x5D, W             
XORLW 0x32               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7CC               
MOVF 0x5F, W             
MOVWF 0x20               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x33               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7D4               
MOVF 0x5F, W             
MOVWF 0x21               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x34               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7DC               
MOVF 0x5F, W             
MOVWF 0x22               
GOTO 0x7E3               
MOVF 0x5D, W             
XORLW 0x35               
IORWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x7E3               
MOVF 0x5F, W             
MOVWF 0x23               
MOVF 0x74, W             
RETURN                   
INCF 0x21, W             
MOVLB 0x2                
MOVWF 0x62               
MOVLB 0x0                
BSF 0x39, 0x6            
MOVLB 0x1                
CLRF 0x54                
INCF 0x54, F             
MOVLB 0x3                
MOVF 0x20, W             
MOVWF TMR2               
MOVLB 0x1                
BSF PIR1, 0x4            
RETURN                   
MOVLB 0x3                
MOVF 0x21, W             
ADDLW 0xA0               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
RETURN                   
MOVLB 0x3                
MOVF 0x24, W             
MOVWF 0x77               
MOVF 0x25, W             
MOVWF 0x76               
RETURN                   
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVLB 0x0                
BSF 0x3F, 0x0            
CLRF 0x45                
BCF 0x36, 0x4            
MOVLB 0x2                
CLRF PIR1                
CLRF PIR2                
CLRF PIR3                
CLRF 0x14                
CLRF TMR1H               
CLRF T1CON               
MOVLW 0xD0               
MOVLB 0x1                
MOVWF CPSCON0            
MOVLB 0x0                
MOVF 0x45, W             
ADDLW 0x41               
MOVWF FSR0L               
MOVLW 0xA9               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVF INDF0, W            
MOVLB 0x1                
MOVWF 0x1D               
NOP                      
MOVLB 0x1                
BSF 0x1D, 0x0            
MOVLB 0x0                
BCF PIR1, 0x6            
MOVLB 0x1                
BSF PIR1, 0x6            
MOVLW 0x5                
MOVWF 0x64               
RETURN                   
MOVLB 0x0                
BCF 0x3A, 0x2            
BCF 0x3A, 0x3            
BCF 0x3A, 0x4            
BCF 0x3A, 0x5            
BTFSS 0x3A, 0x0          
GOTO 0x8D                
BCF 0x3A, 0x0            
BSF 0x3A, 0x2            
MOVLB 0x1                
MOVF 0x4F, W             
BTFSC STATUS, 0x2        
GOTO 0x36                
DECFSZ 0x4F, F           
GOTO 0x36                
MOVLB 0x0                
BSF 0x39, 0x2            
MOVLB 0x1                
MOVF 0x51, W             
BTFSC STATUS, 0x2        
GOTO 0x3E                
DECFSZ 0x51, F           
GOTO 0x3E                
MOVLB 0x0                
BCF 0x39, 0x6            
MOVLB 0x1                
MOVF 0x50, W             
BTFSC STATUS, 0x2        
GOTO 0x45                
DECFSZ 0x50, F           
GOTO 0x45                
CLRF 0x53                
MOVLB 0x0                
BTFSS 0x39, 0x2          
GOTO 0x8D                
MOVF 0x56, W             
BTFSC STATUS, 0x2        
GOTO 0x4C                
DECF 0x56, F             
MOVLB 0x1                
MOVF 0x4E, W             
BTFSS STATUS, 0x2        
DECF 0x4E, F             
MOVF 0x3E, W             
IORWF 0x3D, W            
BTFSC STATUS, 0x2        
GOTO 0x58                
MOVLW 0x1                
SUBWF 0x3D, F            
MOVLW 0x0                
SUBWFB 0x3E, F           
MOVLB 0x2                
MOVF 0x5D, W             
BTFSS STATUS, 0x2        
DECF 0x5D, F             
MOVF 0x42, W             
IORWF 0x41, W            
BTFSC STATUS, 0x2        
GOTO 0x64                
MOVLW 0x1                
SUBWF 0x41, F            
MOVLW 0x0                
SUBWFB 0x42, F           
MOVF 0x44, W             
IORWF 0x43, W            
BTFSC STATUS, 0x2        
GOTO 0x6C                
MOVLW 0x1                
SUBWF 0x43, F            
MOVLW 0x0                
SUBWFB 0x44, F           
MOVLB 0x1                
MOVF 0x4D, W             
BTFSS STATUS, 0x2        
DECF 0x4D, F             
DECF 0x4C, F             
MOVLB 0x0                
BCF 0x3B, 0x3            
BCF 0x3B, 0x0            
BCF 0x3D, 0x4            
MOVLW 0x19               
MOVWF 0x74               
MOVLB 0x1                
MOVF 0x4C, W             
CALL 0x10B               
MOVLP 0x18               
MOVWF 0x75               
BTFSC 0x75, 0x1          
BSF 0x3B, 0x3            
BTFSC 0x75, 0x0          
BSF 0x3B, 0x0            
BTFSS 0x75, 0x0          
GOTO 0x87                
MOVLW 0x3                
SUBWF 0x75, W            
BTFSS STATUS, 0x0        
GOTO 0x87                
BSF 0x3D, 0x4            
MOVLB 0x1                
MOVF 0x4C, F             
BTFSS STATUS, 0x2        
GOTO 0x8D                
MOVLW 0xC8               
MOVWF 0x4C               
MOVLB 0x0                
BTFSS 0x3A, 0x1          
RETURN                   
BCF 0x3A, 0x1            
BSF 0x3A, 0x3            
MOVLB 0x1                
MOVF 0x5D, W             
BTFSS STATUS, 0x2        
DECF 0x5D, F             
MOVLB 0x0                
BTFSS 0x39, 0x2          
GOTO 0xE5                
MOVF 0x35, W             
IORWF 0x34, W            
BTFSC STATUS, 0x2        
GOTO 0xA1                
MOVLW 0x1                
SUBWF 0x34, F            
MOVLW 0x0                
SUBWFB 0x35, F           
MOVLB 0x2                
MOVF 0x64, W             
BTFSS STATUS, 0x2        
DECF 0x64, F             
MOVF 0x63, W             
BTFSS STATUS, 0x2        
DECF 0x63, F             
MOVLB 0x1                
MOVF 0x5F, W             
BTFSS STATUS, 0x2        
DECF 0x5F, F             
MOVLB 0x2                
MOVF 0x5C, W             
BTFSS STATUS, 0x2        
DECF 0x5C, F             
MOVLB 0x0                
MOVF 0x57, W             
BTFSS STATUS, 0x2        
DECF 0x57, F             
MOVF 0x55, W             
BTFSS STATUS, 0x2        
DECF 0x55, F             
MOVLB 0x2                
MOVF 0x34, W             
IORWF 0x33, W            
BTFSC STATUS, 0x2        
GOTO 0xC0                
MOVLW 0x1                
SUBWF 0x33, F            
MOVLW 0x0                
SUBWFB 0x34, F           
MOVLB 0x0                
MOVF 0x6E, W             
BTFSS STATUS, 0x2        
DECF 0x6E, F             
MOVLB 0x1                
MOVF 0x57, W             
BTFSS STATUS, 0x2        
DECF 0x57, F             
MOVF 0x59, W             
BTFSC STATUS, 0x2        
GOTO 0xCE                
DECF 0x59, F             
MOVLW 0x4                
GOTO 0xCF                
MOVLW 0x5                
MOVLB 0x0                
MOVWF 0x5C               
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0xE5                
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0xE1                
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0xE1                
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0xE5                
MOVLB 0x1                
MOVF 0x5B, W             
BTFSS STATUS, 0x2        
DECF 0x5B, F             
MOVLB 0x2                
DECFSZ 0x68, F           
RETURN                   
MOVLW 0xA                
MOVWF 0x68               
MOVLB 0x0                
BSF 0x3A, 0x4            
BTFSS 0x39, 0x2          
GOTO 0x100               
MOVLB 0x1                
MOVF 0x55, W             
BTFSC STATUS, 0x2        
GOTO 0xF3                
DECF 0x55, F             
MOVF 0x66, W             
BTFSS STATUS, 0x2        
DECF 0x66, F             
MOVLB 0x0                
BSF 0x40, 0x2            
MOVLB 0x2                
MOVF 0x6A, W             
BTFSC STATUS, 0x2        
GOTO 0xFE                
DECF 0x6A, F             
GOTO 0x100               
MOVLB 0x0                
BCF 0x40, 0x2            
MOVLB 0x2                
DECFSZ 0x65, F           
RETURN                   
MOVLB 0x0                
BSF 0x3F, 0x1            
MOVLW 0x3                
MOVLB 0x2                
MOVWF 0x65               
MOVLB 0x0                
BSF 0x3A, 0x5            
RETURN                   
MOVLB 0x0                
MOVWF 0x5D               
CLRF 0x5F                
MOVF 0x74, W             
BTFSC STATUS, 0x2        
GOTO 0x122               
CLRF 0x5E                
INCF 0x5E, F             
BTFSC 0x74, 0x7          
GOTO 0x117               
LSLF 0x74, F             
GOTO 0x112               
LSLF 0x5F, F             
MOVF 0x74, W             
SUBWF 0x5D, W            
BTFSS STATUS, 0x0        
GOTO 0x11F               
MOVF 0x74, W             
SUBWF 0x5D, F            
BSF 0x5F, 0x0            
LSRF 0x74, F             
DECFSZ 0x5E, F           
GOTO 0x117               
MOVF 0x5F, W             
RETURN                   
MOVLB 0x0                
BTFSC 0x51, 0x4          
BTFSC 0x51, 0x0          
GOTO 0x140               
BTFSS 0x51, 0x1          
BTFSC 0x51, 0x2          
GOTO 0x140               
BSF 0x51, 0x1            
BCF 0x51, 0x4            
CLRF 0x46                
CLRF 0x48                
MOVLP 0x14               
CALL 0x404               
MOVLP 0x19               
MOVLW 0x4                
MOVWF 0x74               
MOVLW 0xD3               
MOVLP 0xF                
CALL 0x737               
MOVLP 0x19               
MOVLB 0x0                
MOVF 0x29, W             
MOVLB 0x3                
MOVWF 0x57               
MOVLB 0x0                
MOVF 0x28, W             
MOVLB 0x3                
MOVWF 0x58               
MOVLB 0x0                
BTFSS 0x51, 0x1          
GOTO 0x162               
MOVF 0x56, F             
BTFSS STATUS, 0x2        
GOTO 0x162               
MOVLW 0x6                
MOVWF 0x74               
MOVF 0x48, W             
MOVLP 0xF                
CALL 0x776               
MOVLP 0x19               
ADDWF 0x46, W            
ADDLW 0x50               
CALL 0x2BF               
MOVLP 0x19               
CALL 0x1E1               
MOVLP 0x19               
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x56               
INCF 0x46, F             
MOVLW 0x6                
SUBWF 0x46, W            
BTFSS STATUS, 0x0        
GOTO 0x162               
INCF 0x48, F             
MOVLW 0x2                
SUBWF 0x48, W            
BTFSC STATUS, 0x0        
GOTO 0x161               
CLRF 0x46                
GOTO 0x162               
BCF 0x51, 0x1            
BTFSC 0x51, 0x3          
BTFSC 0x51, 0x0          
GOTO 0x17B               
BTFSS 0x51, 0x1          
BTFSC 0x51, 0x2          
GOTO 0x17B               
BSF 0x51, 0x0            
BCF 0x51, 0x3            
CLRF 0x46                
CLRF 0x48                
CALL 0x1F6               
MOVLW 0xD                
MOVWF 0x74               
MOVLW 0xD3               
MOVLP 0xF                
CALL 0x737               
MOVLP 0x19               
MOVLB 0x0                
MOVF 0x29, W             
MOVLB 0x3                
MOVWF 0x60               
MOVLB 0x0                
MOVF 0x28, W             
MOVLB 0x3                
MOVWF 0x61               
MOVLB 0x0                
BTFSS 0x51, 0x0          
GOTO 0x19C               
MOVF 0x56, F             
BTFSS STATUS, 0x2        
GOTO 0x19C               
MOVLW 0xF                
MOVWF 0x74               
MOVF 0x48, W             
MOVLP 0xF                
CALL 0x776               
MOVLP 0x19               
ADDWF 0x46, W            
CALL 0x2BF               
MOVLP 0x19               
CALL 0x1E1               
MOVLP 0x19               
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x56               
INCF 0x46, F             
MOVLW 0xF                
SUBWF 0x46, W            
BTFSS STATUS, 0x0        
GOTO 0x19C               
INCF 0x48, F             
MOVLW 0x2                
SUBWF 0x48, W            
BTFSC STATUS, 0x0        
GOTO 0x19B               
CLRF 0x46                
GOTO 0x19C               
BCF 0x51, 0x0            
BTFSC 0x51, 0x5          
BTFSC 0x51, 0x0          
GOTO 0x1B5               
BTFSS 0x51, 0x1          
BTFSC 0x51, 0x2          
GOTO 0x1B5               
BSF 0x51, 0x2            
BCF 0x51, 0x5            
CLRF 0x46                
CLRF 0x48                
CALL 0x237               
MOVLW 0x17               
MOVWF 0x74               
MOVLW 0xD3               
MOVLP 0xF                
CALL 0x737               
MOVLP 0x19               
MOVLB 0x0                
MOVF 0x29, W             
MOVLB 0x3                
MOVWF 0x6A               
MOVLB 0x0                
MOVF 0x28, W             
MOVLB 0x3                
MOVWF 0x6B               
MOVLB 0x0                
BTFSS 0x51, 0x2          
GOTO 0x1D7               
MOVF 0x56, F             
BTFSS STATUS, 0x2        
GOTO 0x1D7               
MOVLW 0x19               
MOVWF 0x74               
MOVF 0x48, W             
MOVLP 0xF                
CALL 0x776               
MOVLP 0x19               
ADDWF 0x46, W            
ADDLW 0x1E               
CALL 0x2BF               
MOVLP 0x19               
CALL 0x1E1               
MOVLP 0x19               
MOVLW 0x3                
MOVLB 0x0                
MOVWF 0x56               
INCF 0x46, F             
MOVLW 0x19               
SUBWF 0x46, W            
BTFSS STATUS, 0x0        
GOTO 0x1D7               
INCF 0x48, F             
MOVLW 0x2                
SUBWF 0x48, W            
BTFSC STATUS, 0x0        
GOTO 0x1D6               
CLRF 0x46                
GOTO 0x1D7               
BCF 0x51, 0x2            
BTFSS 0x51, 0x0          
BTFSC 0x51, 0x1          
RETURN                   
BTFSS 0x51, 0x2          
BTFSS PIR2, 0x4          
RETURN                   
BCF PIR2, 0x4            
MOVLB 0x3                
BCF TMR0, 0x2            
RETURN                   
MOVWF 0x5F               
MOVF 0x75, W             
MOVLB 0x3                
MOVWF PIR1               
CLRF PIR2                
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x3                
MOVWF PIR3               
MOVLB 0x0                
BCF PIR2, 0x4            
BCF INTCON, 0x7          
MOVLB 0x3                
BSF TMR0, 0x2            
MOVLW 0x55               
MOVWF TMR1L               
MOVLW 0xAA               
MOVWF TMR1L               
BSF TMR0, 0x1            
BSF INTCON, 0x7          
RETURN                   
MOVLB 0x2                
MOVF 0x20, W             
MOVLB 0x3                
MOVWF 0x53               
MOVLB 0x2                
MOVF 0x22, W             
MOVWF 0x77               
MOVF 0x21, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x54               
MOVF 0x76, W             
MOVWF 0x55               
MOVLB 0x2                
MOVF 0x24, W             
MOVWF 0x77               
MOVF 0x23, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x56               
MOVF 0x76, W             
MOVWF 0x57               
MOVLB 0x2                
MOVF 0x26, W             
MOVWF 0x77               
MOVF 0x25, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x58               
MOVF 0x76, W             
MOVWF 0x59               
MOVLB 0x2                
MOVF 0x28, W             
MOVWF 0x77               
MOVF 0x27, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x5A               
MOVF 0x76, W             
MOVWF 0x5B               
MOVLB 0x2                
MOVF 0x2A, W             
MOVWF 0x77               
MOVF 0x29, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x5C               
MOVF 0x76, W             
MOVWF 0x5D               
MOVLB 0x2                
MOVF 0x2C, W             
MOVWF 0x77               
MOVF 0x2B, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x5E               
MOVF 0x76, W             
MOVWF 0x5F               
RETURN                   
MOVLB 0x1                
MOVF 0x23, W             
MOVLB 0x0                
MOVWF 0x27               
MOVLB 0x1                
MOVF 0x22, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x1                
MOVF 0x21, W             
MOVLB 0x0                
MOVWF 0x25               
MOVLB 0x1                
MOVF 0x20, W             
MOVLB 0x0                
MOVWF 0x24               
MOVF 0x26, W             
MOVLB 0x3                
MOVWF 0x53               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x3                
MOVWF 0x54               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x3                
MOVWF 0x55               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x3                
MOVWF 0x56               
MOVLW 0x4                
ADDLW 0xA0               
MOVWF FSR1L               
CLRF FSR1H               
CALL 0x2B3               
MOVLP 0x19               
MOVWF 0x57               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x3                
MOVWF 0x58               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x3                
MOVWF 0x59               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x3                
MOVWF 0x5A               
MOVLB 0x1                
MOVF 0x2A, W             
MOVLB 0x3                
MOVWF 0x5D               
MOVLW 0xB                
ADDLW 0xA0               
MOVWF FSR1L               
CALL 0x2B3               
MOVLP 0x19               
MOVWF 0x5E               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x3                
MOVWF 0x5F               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x3                
MOVWF 0x60               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x3                
MOVWF 0x61               
MOVLW 0xF                
ADDLW 0xA0               
MOVWF FSR1L               
CALL 0x2B3               
MOVLP 0x19               
MOVWF 0x62               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x3                
MOVWF 0x63               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x3                
MOVWF 0x64               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x3                
MOVWF 0x65               
MOVLB 0x1                
MOVF 0x34, W             
MOVWF 0x77               
MOVF 0x33, W             
MOVWF 0x76               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x3                
MOVWF 0x66               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x3                
MOVWF 0x67               
MOVLB 0x1                
MOVF 0x29, W             
MOVWF 0x77               
MOVF 0x28, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x5B               
MOVF 0x76, W             
MOVWF 0x5C               
MOVLB 0x1                
MOVF 0x36, W             
MOVWF 0x77               
MOVF 0x35, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x3                
MOVWF 0x68               
MOVF 0x76, W             
MOVWF 0x69               
RETURN                   
MOVIW 0[FSR1]            
MOVLB 0x0                
MOVWF 0x24               
MOVIW 1[FSR1]            
MOVWF 0x25               
MOVIW 2[FSR1]            
MOVWF 0x26               
MOVIW 3[FSR1]            
MOVWF 0x27               
MOVF 0x26, W             
MOVLB 0x3                
RETURN                   
MOVWF 0x75               
MOVF 0x46, W             
ADDLW 0xD3               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVF INDF1, W            
RETURN                   
MOVLB 0x0                
BCF 0x41, 0x2            
MOVLB 0x5                
MOVF T1CON, W            
MOVLB 0x2                
MOVWF 0x45               
MOVLB 0x5                
MOVF T1GCON, W           
MOVLB 0x2                
MOVWF 0x46               
MOVF 0x46, W             
MOVLB 0x0                
MOVWF 0x33               
MOVLB 0x2                
MOVF 0x45, W             
MOVLB 0x0                
MOVWF 0x32               
MOVLB 0x3                
MOVF 0x51, W             
MOVLB 0x0                
SUBWF 0x32, F            
MOVLB 0x3                
MOVF 0x52, W             
MOVLB 0x0                
SUBWFB 0x33, F           
MOVLW 0x1F               
SUBWF 0x33, W            
MOVLW 0x40               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x2E9               
BTFSC 0x3C, 0x4          
GOTO 0x2F4               
MOVLW 0x19               
SUBWF 0x33, W            
MOVLW 0xC8               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x2F2               
BTFSS 0x3C, 0x4          
GOTO 0x2F4               
BTFSC 0x3C, 0x5          
GOTO 0x2FC               
MOVLB 0x2                
MOVF 0x46, W             
MOVLB 0x3                
MOVWF 0x52               
MOVLB 0x2                
MOVF 0x45, W             
MOVLB 0x3                
MOVWF 0x51               
MOVLB 0x5                
MOVF TMR2, W             
XORLW 0x5                
BTFSS STATUS, 0x2        
GOTO 0x306               
MOVLW 0x4                
MOVWF TMR2               
MOVLB 0x0                
BSF 0x41, 0x2            
GOTO 0x308               
MOVLW 0x5                
MOVWF TMR2               
MOVLB 0x0                
BCF PIR2, 0x0            
BTFSC 0x3C, 0x5          
GOTO 0x33D               
MOVLW 0x19               
SUBWF 0x33, W            
MOVLW 0xC8               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x334               
MOVLW 0x2E               
SUBWF 0x33, W            
MOVLW 0xE1               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSC STATUS, 0x0        
GOTO 0x334               
MOVLW 0x23               
SUBWF 0x33, W            
MOVLW 0xD3               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x32B               
MOVLB 0x2                
CLRF 0x5F                
INCF 0x5E, F             
MOVLW 0x1E               
SUBWF 0x5E, W            
BTFSS STATUS, 0x0        
GOTO 0x334               
CALL 0x44A               
MOVLP 0x1A               
GOTO 0x334               
MOVLB 0x2                
CLRF 0x5E                
INCF 0x5F, F             
MOVLW 0x1E               
SUBWF 0x5F, W            
BTFSS STATUS, 0x0        
GOTO 0x334               
CALL 0x454               
MOVLP 0x1A               
MOVLB 0x2                
INCF 0x60, F             
MOVLW 0xC8               
SUBWF 0x60, W            
BTFSS STATUS, 0x0        
GOTO 0x440               
CALL 0x44A               
MOVLP 0x1A               
GOTO 0x440               
MOVLW 0x1F               
SUBWF 0x33, W            
MOVLW 0x40               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x34D               
MOVLW 0x2E               
SUBWF 0x33, W            
MOVLW 0xE1               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSC STATUS, 0x0        
GOTO 0x34D               
BTFSC 0x3C, 0x4          
GOTO 0x35C               
MOVLW 0x19               
SUBWF 0x33, W            
MOVLW 0xC8               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x440               
MOVLW 0x27               
SUBWF 0x33, W            
MOVLW 0x11               
BTFSC STATUS, 0x2        
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
BTFSC 0x3C, 0x4          
GOTO 0x440               
MOVLB 0x2                
MOVF 0x57, W             
MOVLB 0x1                
MOVWF 0x68               
MOVLB 0x0                
BTFSS 0x52, 0x2          
GOTO 0x3D7               
BTFSS 0x3F, 0x4          
GOTO 0x36D               
BCF 0x3F, 0x4            
CALL 0x45E               
MOVLP 0x1A               
GOTO 0x36B               
LSLF 0x47, F             
RLF 0x48, F              
DECFSZ WREG, F           
GOTO 0x369               
MOVLB 0x2                
MOVF 0x55, W             
MOVLB 0x0                
XORWF 0x5C, W            
BTFSC STATUS, 0x2        
GOTO 0x378               
MOVF 0x5C, W             
MOVLB 0x2                
MOVWF 0x55               
CALL 0x466               
MOVLP 0x1A               
MOVLW 0xA                
MOVWF 0x70               
CLRF 0x71                
MOVLB 0x0                
INCF 0x5C, W             
GOTO 0x380               
LSLF 0x70, F             
RLF 0x71, F              
DECFSZ WREG, F           
GOTO 0x37E               
MOVLB 0x2                
MOVF 0x36, W             
XORWF 0x71, W            
BTFSS STATUS, 0x2        
GOTO 0x389               
MOVF 0x35, W             
XORWF 0x70, W            
MOVLW 0xA                
BTFSS STATUS, 0x2        
GOTO 0x397               
MOVWF 0x47               
CLRF 0x48                
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x2                
GOTO 0x394               
LSLF 0x47, F             
RLF 0x48, F              
DECFSZ WREG, F           
GOTO 0x392               
MOVLW 0xA                
MOVWF 0x70               
CLRF 0x71                
MOVLB 0x0                
INCF 0x5C, W             
GOTO 0x39E               
LSLF 0x70, F             
RLF 0x71, F              
DECFSZ WREG, F           
GOTO 0x39C               
MOVF 0x70, W             
ADDLW 0xFF               
MOVWF 0x72               
MOVLW 0xFF               
ADDWFC 0x71, W           
MOVWF 0x73               
MOVLB 0x2                
SUBWF 0x48, W            
BTFSS STATUS, 0x2        
GOTO 0x3AC               
MOVF 0x72, W             
SUBWF 0x47, W            
BTFSS STATUS, 0x0        
GOTO 0x3B2               
CLRF 0x47                
CLRF 0x48                
CALL 0x466               
MOVLP 0x1A               
MOVF 0x37, W             
ADDLW 0xFF               
MOVWF 0x70               
MOVLW 0xFF               
ADDWFC 0x38, W           
MOVWF 0x71               
SUBWF 0x48, W            
BTFSS STATUS, 0x2        
GOTO 0x3BD               
MOVF 0x70, W             
SUBWF 0x47, W            
BTFSS STATUS, 0x0        
GOTO 0x3C4               
MOVLB 0x1                
MOVF 0x52, W             
BTFSC STATUS, 0x2        
GOTO 0x3C4               
DECF 0x52, F             
MOVLB 0x2                
INCF 0x47, F             
BTFSC STATUS, 0x2        
INCF 0x48, F             
MOVF 0x38, W             
SUBWF 0x48, W            
BTFSS STATUS, 0x2        
GOTO 0x3CE               
MOVF 0x37, W             
SUBWF 0x47, W            
BTFSC STATUS, 0x0        
GOTO 0x3D4               
MOVLB 0x1                
MOVF 0x52, F             
BTFSS STATUS, 0x2        
GOTO 0x3E4               
MOVLB 0x0                
BCF 0x52, 0x2            
GOTO 0x3E4               
CALL 0x45E               
MOVLP 0x1A               
GOTO 0x3DC               
LSLF 0x47, F             
RLF 0x48, F              
DECFSZ WREG, F           
GOTO 0x3DA               
MOVLW 0xFF               
ADDWF 0x47, F            
BTFSS STATUS, 0x0        
DECF 0x48, F             
CLRF 0x37                
CLRF 0x38                
MOVLB 0x0                
BTFSC 0x52, 0x4          
GOTO 0x42B               
BTFSS 0x3B, 0x7          
GOTO 0x422               
MOVLB 0x1                
MOVF 0x38, W             
MOVLB 0x3                
XORWF 0x4A, W            
BTFSS STATUS, 0x2        
GOTO 0x3F3               
MOVLB 0x1                
MOVF 0x37, W             
MOVLB 0x3                
XORWF 0x49, W            
BTFSC STATUS, 0x2        
GOTO 0x400               
MOVLB 0x1                
MOVF 0x38, W             
MOVLB 0x3                
MOVWF 0x4A               
MOVLB 0x1                
MOVF 0x37, W             
MOVLB 0x3                
MOVWF 0x49               
MOVLB 0x2                
CLRF 0x49                
CLRF 0x4A                
MOVLB 0x2                
MOVF 0x4A, W             
IORWF 0x49, W            
BTFSS STATUS, 0x2        
GOTO 0x40D               
MOVLB 0x1                
MOVF 0x38, W             
MOVLB 0x2                
MOVWF 0x4A               
MOVLB 0x1                
MOVF 0x37, W             
MOVLB 0x2                
MOVWF 0x49               
MOVLW 0x1                
SUBWF 0x49, F            
MOVLW 0x0                
SUBWFB 0x4A, F           
MOVLB 0x0                
BSF 0x3C, 0x2            
MOVLB 0x3                
MOVF 0x4C, W             
MOVLB 0x2                
SUBWF 0x4A, W            
BTFSS STATUS, 0x2        
GOTO 0x41D               
MOVLB 0x3                
MOVF 0x4B, W             
MOVLB 0x2                
SUBWF 0x49, W            
BTFSS STATUS, 0x0        
GOTO 0x430               
MOVLB 0x0                
BSF 0x52, 0x4            
GOTO 0x42F               
MOVLB 0x3                
CLRF 0x49                
CLRF 0x4A                
MOVLB 0x2                
CLRF 0x49                
CLRF 0x4A                
MOVLB 0x0                
BSF 0x3C, 0x2            
GOTO 0x430               
MOVLB 0x2                
CLRF 0x49                
CLRF 0x4A                
MOVLB 0x0                
BCF 0x3C, 0x2            
MOVLB 0x0                
MOVF PORTA, W            
MOVLB 0x1                
MOVWF 0x4B               
MOVLW 0xEB               
ANDWF 0x4B, F            
MOVLB 0x0                
MOVF 0x52, W             
MOVLB 0x1                
IORWF 0x4B, F            
MOVF 0x4B, W             
MOVLB 0x0                
MOVWF PORTA              
MOVLW 0x2                
MOVLB 0x1                
MOVWF 0x67               
MOVLB 0x2                
DECFSZ 0x67, F           
RETURN                   
MOVLB 0x1                
MOVF 0x45, W             
MOVLB 0x2                
MOVWF 0x67               
MOVLB 0x0                
BSF 0x3A, 0x1            
RETURN                   
MOVLB 0x0                
BSF 0x3C, 0x5            
BSF 0x3C, 0x4            
MOVLW 0xA                
MOVLB 0x1                
MOVWF 0x45               
MOVLW 0x2D               
MOVLB 0x2                
MOVWF 0x57               
RETURN                   
MOVLB 0x0                
BSF 0x3C, 0x5            
BCF 0x3C, 0x4            
MOVLW 0xC                
MOVLB 0x1                
MOVWF 0x45               
MOVLW 0x26               
MOVLB 0x2                
MOVWF 0x57               
RETURN                   
MOVLW 0xA                
MOVLB 0x2                
MOVWF 0x47               
CLRF 0x48                
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x2                
RETURN                   
MOVF 0x36, W             
MOVWF 0x38               
MOVF 0x35, W             
MOVWF 0x37               
RETURN                   
MOVLW 0x2                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0x97               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x47E               
MOVF 0x5B, F             
BTFSS STATUS, 0x2        
GOTO 0x47E               
MOVF 0x4F, W             
XORLW 0x5                
BTFSC STATUS, 0x2        
GOTO 0x47E               
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x480               
BTFSS 0x36, 0x3          
GOTO 0x485               
BCF 0x43, 0x0            
MOVLB 0x3                
CLRF 0x45                
CLRF 0x46                
GOTO 0x790               
BTFSS 0x36, 0x3          
BTFSS 0x3D, 0x0          
GOTO 0x5EB               
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x498               
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x49E               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x49E               
MOVF 0x4D, W             
XORLW 0x2                
BTFSC STATUS, 0x2        
GOTO 0x49E               
MOVF 0x4F, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0x5EB               
DECFSZ 0x4D, W           
GOTO 0x5EB               
MOVLB 0x1                
MOVF 0x47, F             
BTFSS STATUS, 0x2        
GOTO 0x5EB               
MOVLB 0x0                
MOVF 0x2F, W             
IORWF 0x2E, W            
BTFSC STATUS, 0x2        
GOTO 0x5EB               
INCF 0x2E, W             
BTFSC STATUS, 0x2        
INCF 0x2F, W             
BTFSC STATUS, 0x2        
GOTO 0x5EB               
BCF 0x3B, 0x1            
MOVF 0x2E, W             
ADDLW 0x2E               
CALL 0x7CA               
MOVLP 0x1C               
MOVF 0x2E, W             
BTFSS STATUS, 0x0        
GOTO 0x5D5               
ADDLW 0xDA               
CALL 0x7D5               
MOVLP 0x1C               
BTFSS STATUS, 0x0        
GOTO 0x5D4               
BSF 0x43, 0x0            
CALL 0x7E5               
MOVLP 0x1C               
CALL 0x7EE               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x4C2               
MOVLW 0xFD               
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x4CD               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x4CB               
MOVLW 0x4                
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x579               
MOVLB 0x0                
MOVF 0x2E, W             
ADDLW 0xF                
CALL 0x7CA               
MOVLP 0x1C               
BTFSC STATUS, 0x0        
GOTO 0x579               
MOVF 0x2E, W             
ADDLW 0xF1               
CALL 0x7D5               
MOVLP 0x1C               
BTFSC STATUS, 0x0        
GOTO 0x579               
MOVLB 0x1                
CLRF 0x3B                
CLRF 0x3C                
MOVLB 0x0                
MOVF 0x49, W             
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x4E8               
MOVLW 0x1                
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x52C               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x4F1               
MOVLW 0x3                
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x4FB               
MOVLB 0x0                
MOVF 0x49, W             
BTFSC STATUS, 0x2        
GOTO 0x4FB               
MOVF 0x49, W             
ADDLW 0xFF               
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x502               
MOVLW 0x5                
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x511               
MOVLB 0x0                
MOVF 0x49, W             
BTFSC STATUS, 0x2        
GOTO 0x511               
DECFSZ 0x49, W           
GOTO 0x50D               
MOVLB 0x1                
CLRF 0x44                
GOTO 0x511               
MOVF 0x49, W             
ADDLW 0xFE               
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x0                
BTFSS 0x60, 0x7          
GOTO 0x519               
MOVLW 0x2                
MOVLB 0x1                
SUBWF 0x44, W            
BTFSC STATUS, 0x0        
DECF 0x44, F             
MOVLB 0x0                
CALL 0x7DF               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x520               
MOVLW 0x10               
SUBWF 0x5F, W            
BTFSS STATUS, 0x0        
GOTO 0x563               
MOVLW 0x9                
MOVLB 0x1                
SUBWF 0x44, W            
BTFSC STATUS, 0x0        
GOTO 0x563               
MOVF 0x59, F             
BTFSS STATUS, 0x2        
GOTO 0x563               
INCF 0x44, F             
GOTO 0x562               
MOVLB 0x0                
CALL 0x7EE               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x533               
MOVLW 0xFE               
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x53D               
MOVLW 0xA                
MOVLB 0x0                
SUBWF 0x49, W            
BTFSC STATUS, 0x0        
GOTO 0x53D               
INCF 0x49, W             
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x0                
CALL 0x7EE               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x544               
MOVLW 0xFC               
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x555               
MOVLW 0xA                
MOVLB 0x0                
SUBWF 0x49, W            
BTFSC STATUS, 0x0        
GOTO 0x555               
MOVLW 0x8                
SUBWF 0x49, W            
BTFSS STATUS, 0x0        
GOTO 0x551               
MOVLW 0xA                
GOTO 0x553               
MOVF 0x49, W             
ADDLW 0x2                
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x0                
CALL 0x7DF               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x55C               
MOVLW 0x1                
SUBWF 0x5F, W            
BTFSS STATUS, 0x0        
GOTO 0x563               
MOVLW 0xA                
MOVLB 0x1                
SUBWF 0x44, W            
BTFSS STATUS, 0x0        
INCF 0x44, F             
MOVLB 0x0                
LSLF 0x49, W             
ADDLW 0xCC               
MOVWF FSR0L               
MOVLW 0xA8               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVLB 0x3                
MOVWF 0x45               
MOVIW 1[FSR0]            
MOVWF 0x46               
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x3                
GOTO 0x576               
LSLF 0x45, F             
RLF 0x46, F              
DECFSZ WREG, F           
GOTO 0x574               
GOTO 0x790               
MOVLB 0x0                
MOVF 0x49, W             
MOVLB 0x1                
MOVWF 0x44               
MOVF 0x4D, F             
BTFSS STATUS, 0x2        
GOTO 0x5A2               
MOVLW 0xC8               
MOVWF 0x4D               
MOVLB 0x0                
CALL 0x7DF               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x589               
MOVLW 0x7                
SUBWF 0x5F, W            
BTFSC STATUS, 0x0        
GOTO 0x59A               
MOVLB 0x0                
MOVF 0x60, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x7F               
SUBWF 0x7F, W            
BTFSS STATUS, 0x2        
GOTO 0x595               
MOVLW 0xFA               
SUBWF 0x5F, W            
BTFSS STATUS, 0x0        
GOTO 0x59A               
MOVLB 0x1                
CLRF 0x3B                
CLRF 0x3C                
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x1                
ADDWF 0x3B, F            
MOVLB 0x0                
MOVF 0x60, W             
MOVLB 0x1                
ADDWFC 0x3C, F           
CALL 0x7FA               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x5A8               
MOVLW 0x1                
SUBWF 0x3B, W            
BTFSS STATUS, 0x0        
GOTO 0x5BB               
MOVLB 0x1                
CALL 0x7FA               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x5B1               
MOVLW 0xF                
SUBWF 0x3B, W            
BTFSS STATUS, 0x0        
GOTO 0x5BB               
MOVLW 0xA                
MOVLB 0x0                
SUBWF 0x49, W            
BTFSC STATUS, 0x0        
GOTO 0x5BB               
INCF 0x49, W             
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x1                
BTFSS 0x3C, 0x7          
GOTO 0x5D1               
MOVF 0x3C, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x7F               
SUBWF 0x7F, W            
BTFSS STATUS, 0x2        
GOTO 0x5C7               
MOVLW 0xF2               
SUBWF 0x3B, W            
BTFSC STATUS, 0x0        
GOTO 0x5D1               
MOVLB 0x0                
MOVF 0x49, W             
BTFSC STATUS, 0x2        
GOTO 0x5D1               
MOVF 0x49, W             
ADDLW 0xFF               
MOVLB 0x1                
MOVWF 0x44               
MOVLB 0x1                
LSLF 0x44, W             
GOTO 0x565               
MOVF 0x2E, W             
ADDLW 0x2E               
CALL 0x7CA               
MOVLP 0x1C               
BTFSC STATUS, 0x0        
GOTO 0x5DF               
BSF 0x43, 0x0            
BTFSS 0x2D, 0x7          
GOTO 0x481               
MOVLW 0x3                
GOTO 0x5E7               
MOVF 0x2E, W             
ADDLW 0xDA               
CALL 0x7D5               
MOVLP 0x1C               
BTFSC STATUS, 0x0        
GOTO 0x481               
BSF 0x43, 0x0            
MOVLW 0xA                
MOVLB 0x3                
MOVWF 0x45               
CLRF 0x46                
GOTO 0x570               
CALL 0x79D               
MOVLP 0x1C               
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x5F2               
BTFSC 0x3D, 0x0          
GOTO 0x5F6               
MOVLB 0x3                
CLRF 0x45                
CLRF 0x46                
GOTO 0x742               
CALL 0x7E5               
MOVLP 0x1C               
MOVF 0x5B, W             
BTFSC STATUS, 0x2        
GOTO 0x5FF               
MOVF 0x50, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x604               
INCF 0x2E, W             
BTFSC STATUS, 0x2        
INCF 0x2F, W             
BTFSS STATUS, 0x2        
GOTO 0x611               
MOVLW 0xA                
MOVLB 0x3                
MOVWF 0x45               
CLRF 0x46                
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x3                
GOTO 0x60E               
LSLF 0x45, F             
RLF 0x46, F              
DECFSZ WREG, F           
GOTO 0x60C               
GOTO 0x742               
MOVF 0x4F, W             
XORLW 0xC                
BTFSS STATUS, 0x2        
GOTO 0x626               
MOVF 0x4D, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x626               
CLRF 0x61                
LSLF 0x61, W             
ADDLW 0xA                
MOVWF FSR0L               
MOVLW 0xA9               
CALL 0x7B7               
MOVLP 0x1C               
BTFSS STATUS, 0x0        
GOTO 0x624               
INCF 0x61, F             
GOTO 0x61A               
MOVF 0x61, W             
GOTO 0x605               
DECF 0x4F, W             
BTFSC STATUS, 0x2        
GOTO 0x632               
BTFSS 0x3B, 0x1          
GOTO 0x726               
MOVLW 0x2                
SUBWF 0x2B, W            
MOVLW 0x1A               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x725               
MOVLB 0x2                
MOVF 0x4F, W             
MOVLB 0x0                
ADDWF 0x2E, W            
MOVWF 0x5D               
MOVF 0x2F, W             
BTFSC STATUS, 0x0        
INCF 0x2F, W             
MOVWF 0x5E               
MOVLB 0x3                
MOVF 0x44, W             
MOVLB 0x0                
SUBWF 0x5E, W            
BTFSS STATUS, 0x2        
GOTO 0x645               
MOVLB 0x3                
MOVF 0x43, W             
MOVLB 0x0                
SUBWF 0x5D, W            
BTFSC STATUS, 0x0        
BTFSS 0x3F, 0x3          
GOTO 0x657               
BTFSS 0x3F, 0x6          
GOTO 0x657               
MOVLW 0xA                
MOVLB 0x3                
MOVWF 0x45               
CLRF 0x46                
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x3                
GOTO 0x654               
LSLF 0x45, F             
RLF 0x46, F              
DECFSZ WREG, F           
GOTO 0x652               
GOTO 0x6F5               
CALL 0x7DF               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x65D               
MOVLW 0x74               
SUBWF 0x5F, W            
BTFSS STATUS, 0x0        
GOTO 0x6C2               
MOVLB 0x0                
BTFSS 0x3F, 0x6          
GOTO 0x664               
BSF 0x3F, 0x4            
BCF 0x3F, 0x6            
CLRF 0x61                
LSLF 0x61, W             
ADDLW 0xE2               
MOVWF FSR0L               
MOVLW 0xA8               
CALL 0x7B7               
MOVLP 0x1C               
BTFSS STATUS, 0x0        
GOTO 0x66F               
INCF 0x61, F             
GOTO 0x665               
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x675               
MOVLW 0x21               
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x67A               
MOVLB 0x0                
CLRF 0x61                
GOTO 0x6BF               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x681               
MOVLW 0x19               
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x692               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x68A               
MOVLW 0x21               
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x692               
MOVLB 0x0                
MOVF 0x61, W             
BTFSC STATUS, 0x2        
GOTO 0x692               
DECF 0x61, F             
GOTO 0x6BF               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x699               
MOVLW 0x10               
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x6A4               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x6A2               
MOVLW 0x19               
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x6BF               
MOVLB 0x0                
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x6AB               
MOVLW 0x10               
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x6B6               
MOVLB 0x0                
BTFSC 0x2D, 0x7          
GOTO 0x6B6               
MOVLW 0x8                
SUBWF 0x61, W            
BTFSC STATUS, 0x0        
GOTO 0x6B6               
INCF 0x61, F             
GOTO 0x6F3               
MOVLB 0x0                
BTFSS 0x2D, 0x7          
GOTO 0x6BF               
MOVLW 0x7                
SUBWF 0x61, W            
BTFSC STATUS, 0x0        
GOTO 0x6BF               
MOVLW 0x3                
ADDWF 0x61, F            
MOVLB 0x0                
MOVF 0x61, W             
GOTO 0x64B               
MOVLW 0x1                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0xF3               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x6E9               
CLRF 0x61                
LSLF 0x61, W             
ADDLW 0xE4               
MOVWF FSR0L               
MOVLW 0xA8               
CALL 0x7B7               
MOVLP 0x1C               
BTFSS STATUS, 0x0        
GOTO 0x6D5               
INCF 0x61, F             
GOTO 0x6CB               
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x6DB               
MOVLW 0x5                
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x6E3               
MOVLB 0x0                
MOVF 0x61, W             
BTFSC STATUS, 0x2        
GOTO 0x6E3               
MOVLW 0xFF               
ADDWF 0x61, F            
MOVLB 0x0                
CALL 0x7F4               
MOVLP 0x1C               
BTFSC STATUS, 0x2        
INCF 0x46, F             
GOTO 0x64E               
CALL 0x7C4               
MOVLP 0x1C               
BTFSS STATUS, 0x2        
GOTO 0x6EF               
MOVLW 0x3                
SUBWF 0x2C, W            
BTFSC STATUS, 0x0        
GOTO 0x677               
MOVLB 0x0                
CLRF 0x61                
INCF 0x61, F             
GOTO 0x6BF               
MOVLW 0x2                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0x12               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x70A               
MOVF 0x2D, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x80               
SUBWF 0x7F, W            
BTFSS STATUS, 0x2        
GOTO 0x706               
MOVLW 0x1                
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x70A               
MOVLB 0x0                
BSF 0x3B, 0x1            
MOVLB 0x2                
MOVF 0x34, W             
IORWF 0x33, W            
BTFSS STATUS, 0x2        
GOTO 0x742               
MOVLW 0x1                
MOVLB 0x0                
SUBWF 0x2B, W            
MOVLW 0xD1               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x742               
MOVF 0x2D, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x80               
SUBWF 0x7F, W            
BTFSS STATUS, 0x2        
GOTO 0x720               
MOVLW 0x1                
SUBWF 0x2C, W            
BTFSS STATUS, 0x0        
GOTO 0x742               
MOVLB 0x0                
BSF 0x3B, 0x1            
GOTO 0x742               
BCF 0x3B, 0x1            
CLRF 0x61                
LSLF 0x61, W             
ADDLW 0xF8               
MOVWF FSR0L               
MOVLW 0xA8               
CALL 0x7B7               
MOVLP 0x1C               
BTFSS STATUS, 0x0        
GOTO 0x731               
INCF 0x61, F             
GOTO 0x727               
CALL 0x7F4               
MOVLP 0x1C               
BTFSC STATUS, 0x2        
INCF 0x46, F             
MOVLB 0x0                
INCF 0x5C, W             
MOVLB 0x3                
GOTO 0x73B               
LSLF 0x45, F             
RLF 0x46, F              
DECFSZ WREG, F           
GOTO 0x739               
MOVLB 0x0                
BTFSS 0x3F, 0x5          
GOTO 0x742               
BCF 0x3F, 0x5            
BSF 0x3F, 0x4            
MOVLB 0x0                
BTFSS 0x36, 0x3          
GOTO 0x749               
MOVLW 0x3                
MOVLB 0x1                
MOVWF 0x4A               
GOTO 0x782               
MOVF 0x2F, W             
IORWF 0x2E, W            
BTFSS STATUS, 0x2        
BTFSS 0x3D, 0x0          
GOTO 0x750               
BTFSC 0x3D, 0x7          
GOTO 0x782               
MOVLB 0x1                
CLRF 0x4A                
GOTO 0x782               
MOVLB 0x0                
MOVF 0x2F, W             
IORWF 0x2E, W            
BTFSS STATUS, 0x2        
BTFSC 0x36, 0x3          
GOTO 0x790               
BTFSS 0x3D, 0x7          
GOTO 0x790               
MOVF 0x2F, W             
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x761               
MOVF 0x2E, W             
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x768               
INCF 0x2E, W             
BTFSC STATUS, 0x2        
INCF 0x2F, W             
BTFSS STATUS, 0x2        
GOTO 0x76E               
BTFSS 0x3D, 0x0          
GOTO 0x790               
MOVLB 0x1                
CLRF 0x4A                
INCF 0x4A, F             
GOTO 0x790               
MOVLW 0x2                
MOVLB 0x1                
MOVWF 0x4A               
GOTO 0x790               
MOVLB 0x0                
BSF 0x43, 0x0            
MOVF 0x2F, W             
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x77A               
MOVF 0x2E, W             
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x790               
INCF 0x2E, W             
BTFSC STATUS, 0x2        
INCF 0x2F, W             
BTFSS STATUS, 0x2        
GOTO 0x76E               
GOTO 0x790               
MOVLB 0x1                
MOVF 0x4A, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x753               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x772               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x753               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x753               
MOVLB 0x1                
BCF PIR2, 0x0            
MOVLB 0x3                
MOVF 0x46, W             
MOVLB 0x2                
MOVWF 0x36               
MOVLB 0x3                
MOVF 0x45, W             
MOVLB 0x2                
MOVWF 0x35               
MOVLB 0x1                
BSF PIR2, 0x0            
RETURN                   
MOVLB 0x0                
MOVF 0x2F, W             
MOVWF 0x75               
MOVF 0x2E, W             
MOVWF 0x74               
MOVF 0x75, W             
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x7A8               
MOVF 0x74, W             
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x7AF               
INCF 0x2E, W             
BTFSC STATUS, 0x2        
INCF 0x2F, W             
BTFSS STATUS, 0x2        
RETLW 0x0                
MOVF 0x2F, W             
IORWF 0x2E, W            
BTFSS STATUS, 0x2        
BTFSS 0x3D, 0x7          
RETLW 0x0                
BTFSS 0x36, 0x3          
RETLW 0x1                
RETLW 0x0                
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVWF 0x5D               
MOVIW 1[FSR0]            
MOVWF 0x5E               
SUBWF 0x60, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVF 0x5D, W             
SUBWF 0x5F, W            
RETURN                   
MOVF 0x2D, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x80               
SUBWF 0x7F, W            
RETURN                   
MOVWF 0x5D               
MOVLW 0x0                
ADDWFC 0x2F, W           
MOVWF 0x5E               
MOVF 0x2B, W             
SUBWF 0x5E, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVF 0x2A, W             
SUBWF 0x5D, W            
RETURN                   
MOVWF 0x5D               
MOVLW 0xFF               
ADDWFC 0x2F, W           
MOVWF 0x5E               
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVF 0x5D, W             
SUBWF 0x2A, W            
RETURN                   
MOVF 0x60, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x80               
SUBWF 0x7F, W            
RETURN                   
MOVF 0x2F, W             
MOVWF 0x60               
MOVF 0x2E, W             
MOVWF 0x5F               
MOVF 0x2A, W             
SUBWF 0x5F, F            
MOVF 0x2B, W             
SUBWFB 0x60, F           
RETURN                   
MOVF 0x2D, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x7F               
SUBWF 0x7F, W            
RETURN                   
MOVF 0x61, W             
MOVLB 0x3                
MOVWF 0x45               
CLRF 0x46                
INCF 0x45, F             
RETURN                   
MOVF 0x3C, W             
XORLW 0x80               
MOVWF 0x7F               
MOVLW 0x80               
SUBWF 0x7F, W            
RETURN                   
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVWI -1[FSR1]           
MOVLB 0x3                
MOVF 0x53, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x54, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x55, W             
MOVLB 0x0                
MOVWF 0x25               
MOVLB 0x3                
MOVF 0x56, W             
MOVLB 0x0                
MOVWF 0x24               
MOVF 0x27, W             
MOVLB 0x1                
MOVWF 0x23               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x1                
MOVWF 0x22               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x1                
MOVWF 0x21               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x1                
MOVWF 0x20               
MOVLB 0x3                
MOVF 0x57, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x58, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x59, W             
MOVLB 0x0                
MOVWF 0x25               
MOVLB 0x3                
MOVF 0x5A, W             
MOVLB 0x0                
MOVWF 0x24               
MOVF 0x27, W             
MOVLB 0x1                
MOVWF 0x27               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x1                
MOVWF 0x26               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x1                
MOVWF 0x25               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x1                
MOVWF 0x24               
MOVLB 0x3                
MOVF 0x5D, W             
MOVLB 0x1                
MOVWF 0x2A               
MOVLB 0x3                
MOVF 0x5E, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x5F, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x60, W             
MOVLB 0x0                
MOVWF 0x25               
MOVLB 0x3                
MOVF 0x61, W             
MOVLB 0x0                
MOVWF 0x24               
MOVF 0x27, W             
MOVLB 0x1                
MOVWF 0x2E               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x1                
MOVWF 0x2D               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x1                
MOVWF 0x2C               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x1                
MOVWF 0x2B               
MOVLB 0x3                
MOVF 0x62, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x63, W             
MOVLB 0x0                
MOVWF 0x26               
MOVLB 0x3                
MOVF 0x64, W             
MOVLB 0x0                
MOVWF 0x25               
MOVLB 0x3                
MOVF 0x65, W             
MOVLB 0x0                
MOVWF 0x24               
MOVF 0x27, W             
MOVLB 0x1                
MOVWF 0x32               
MOVLB 0x0                
MOVF 0x26, W             
MOVLB 0x1                
MOVWF 0x31               
MOVLB 0x0                
MOVF 0x25, W             
MOVLB 0x1                
MOVWF 0x30               
MOVLB 0x0                
MOVF 0x24, W             
MOVLB 0x1                
MOVWF 0x2F               
MOVLB 0x3                
MOVF 0x66, W             
MOVWF 0x77               
MOVF 0x67, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x1                
MOVWF 0x34               
MOVF 0x76, W             
MOVWF 0x33               
MOVLB 0x3                
MOVF 0x68, W             
MOVWF 0x77               
MOVF 0x69, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x1                
MOVWF 0x36               
MOVF 0x76, W             
MOVWF 0x35               
MOVLB 0x3                
MOVF 0x5B, W             
MOVWF 0x77               
MOVF 0x5C, W             
MOVWF 0x76               
MOVF 0x77, W             
MOVLB 0x1                
MOVWF 0x29               
MOVF 0x76, W             
MOVWF 0x28               
RETURN                   
MOVLB 0x0                
BCF PIR1, 0x1            
MOVLW 0xC                
MOVLB 0x1                
IORWF PORTC, F           
GOTO 0x3FB               
MOVLW 0x9B               
MOVLB 0x0                
ANDWF 0x5A, F            
BTFSC PORTC, 0x0         
BSF 0x5A, 0x5            
BSF PORTC, 0x5           
MOVLB 0x1                
BCF PORTC, 0x5           
BSF PORTC, 0x4           
MOVLB 0x0                
BTFSS 0x42, 0x3          
GOTO 0x3C8               
BCF PORTC, 0x2           
MOVLB 0x1                
BCF PORTC, 0x2           
GOTO 0x3CB               
BSF PORTC, 0x2           
MOVLB 0x1                
BSF PORTC, 0x2           
MOVLB 0x0                
BTFSS 0x42, 0x2          
GOTO 0x3D2               
BCF PORTC, 0x3           
MOVLB 0x1                
BCF PORTC, 0x3           
GOTO 0x3D5               
BSF PORTC, 0x3           
MOVLB 0x1                
BSF PORTC, 0x3           
MOVLB 0x2                
CLRF 0x6B                
INCF 0x6B, F             
GOTO 0x405               
MOVLW 0xB2               
MOVLB 0x0                
ANDWF 0x5A, F            
BTFSC PORTC, 0x0         
BSF 0x5A, 0x0            
BTFSC PORTA, 0x7         
BSF 0x5A, 0x3            
MOVLB 0x1                
BSF PORTC, 0x5           
MOVLB 0x0                
BSF PORTC, 0x4           
MOVLB 0x1                
BCF PORTC, 0x4           
MOVLB 0x0                
BTFSS 0x42, 0x5          
GOTO 0x3ED               
BCF PORTC, 0x2           
MOVLB 0x1                
BCF PORTC, 0x2           
GOTO 0x3F0               
BSF PORTC, 0x2           
MOVLB 0x1                
BSF PORTC, 0x2           
MOVLB 0x0                
BTFSS 0x42, 0x4          
GOTO 0x3F7               
BCF PORTC, 0x3           
MOVLB 0x1                
BCF PORTC, 0x3           
GOTO 0x403               
BSF PORTC, 0x3           
MOVLB 0x1                
BSF PORTC, 0x3           
GOTO 0x403               
MOVLB 0x2                
MOVF 0x6B, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
GOTO 0x3B8               
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x3D9               
MOVLB 0x2                
CLRF 0x6B                
MOVLB 0x0                
BTFSC PORTB, 0x2         
BSF 0x5A, 0x6            
BTFSC PORTB, 0x0         
BSF 0x5A, 0x2            
MOVLB 0x1                
MOVF 0x64, W             
BTFSC STATUS, 0x2        
GOTO 0x411               
DECFSZ 0x64, F           
GOTO 0x411               
BSF 0x1D, 0x1            
MOVLB 0x0                
BTFSS PORTB, 0x5         
GOTO 0x494               
BTFSC 0x3C, 0x0          
GOTO 0x4F8               
MOVLB 0x1                
DECFSZ 0x65, F           
GOTO 0x4FB               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x431               
MOVF 0x4D, W             
XORLW 0x6                
BTFSC STATUS, 0x2        
GOTO 0x42A               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x42A               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x431               
MOVLW 0x33               
MOVLB 0x1                
SUBWF 0x40, W            
BTFSC STATUS, 0x0        
GOTO 0x438               
INCF 0x40, F             
GOTO 0x438               
MOVLW 0x33               
MOVLB 0x1                
SUBWF 0x40, W            
BTFSS STATUS, 0x0        
GOTO 0x438               
MOVLB 0x0                
BCF 0x3F, 0x3            
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
GOTO 0x46B               
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
BTFSC 0x41, 0x4          
GOTO 0x46B               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x46B               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
GOTO 0x46B               
MOVLW 0xA                
SUBWF 0x59, W            
BTFSC STATUS, 0x0        
GOTO 0x465               
INCF 0x59, F             
DECFSZ 0x59, W           
GOTO 0x456               
MOVLW 0xBC               
MOVLB 0x2                
MOVWF 0x41               
MOVLW 0x2                
GOTO 0x45E               
MOVF 0x59, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x460               
MOVLW 0xF4               
MOVLB 0x2                
MOVWF 0x41               
MOVLW 0x1                
MOVWF 0x42               
GOTO 0x490               
BTFSS 0x22, 0x0          
BTFSC 0x3E, 0x6          
GOTO 0x45A               
MOVLW 0x23               
GOTO 0x482               
BTFSS 0x22, 0x0          
GOTO 0x469               
BCF 0x22, 0x0            
BSF 0x51, 0x4            
MOVLW 0x46               
GOTO 0x482               
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x479               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x477               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x479               
MOVLW 0x2D               
GOTO 0x482               
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
GOTO 0x463               
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x486               
MOVLW 0xC8               
MOVLB 0x2                
MOVWF 0x41               
CLRF 0x42                
GOTO 0x490               
MOVF 0x4F, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0x48C               
BTFSC 0x41, 0x4          
GOTO 0x481               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
GOTO 0x45A               
MOVLB 0x0                
BSF 0x3C, 0x0            
BSF 0x39, 0x0            
GOTO 0x4F8               
BTFSS 0x3C, 0x0          
GOTO 0x4F8               
MOVLB 0x1                
DECFSZ 0x65, F           
GOTO 0x4FB               
MOVLB 0x0                
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
GOTO 0x4D1               
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
BTFSC 0x41, 0x4          
GOTO 0x4D1               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x4D1               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
GOTO 0x4D1               
MOVLW 0xA                
SUBWF 0x59, W            
BTFSC STATUS, 0x0        
GOTO 0x4C6               
INCF 0x59, F             
DECFSZ 0x59, W           
GOTO 0x4B7               
MOVLW 0xBC               
MOVLB 0x2                
MOVWF 0x41               
MOVLW 0x2                
GOTO 0x4BF               
MOVF 0x59, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x4C1               
MOVLW 0xF4               
MOVLB 0x2                
MOVWF 0x41               
MOVLW 0x1                
MOVWF 0x42               
GOTO 0x4F6               
BTFSS 0x22, 0x0          
BTFSC 0x3E, 0x6          
GOTO 0x4BB               
MOVLW 0x23               
GOTO 0x4E8               
BCF 0x3E, 0x6            
MOVLW 0x46               
MOVLB 0x2                
MOVWF 0x41               
CLRF 0x42                
MOVLB 0x0                
BTFSS 0x22, 0x0          
GOTO 0x4F6               
BCF 0x22, 0x0            
BSF 0x51, 0x4            
GOTO 0x4F6               
MOVF 0x4F, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x4DF               
MOVF 0x4D, W             
XORLW 0x4                
BTFSC STATUS, 0x2        
GOTO 0x4DD               
MOVF 0x4D, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x4DF               
MOVLW 0x2D               
GOTO 0x4E8               
MOVF 0x4F, W             
XORLW 0xC                
BTFSC STATUS, 0x2        
GOTO 0x4C4               
MOVF 0x4F, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x4EC               
MOVLW 0xC8               
MOVLB 0x2                
MOVWF 0x41               
CLRF 0x42                
GOTO 0x4F6               
MOVF 0x4F, W             
XORLW 0xB                
BTFSS STATUS, 0x2        
GOTO 0x4F2               
BTFSC 0x41, 0x4          
GOTO 0x4E7               
MOVF 0x4F, W             
XORLW 0xB                
BTFSC STATUS, 0x2        
GOTO 0x4BB               
MOVLB 0x0                
BCF 0x3C, 0x0            
MOVLW 0x3                
MOVLB 0x1                
MOVWF 0x65               
MOVLB 0x2                
DECFSZ 0x66, F           
RETURN                   
MOVLW 0xA                
MOVWF 0x66               
MOVLB 0x0                
BSF 0x3A, 0x0            
RETURN                   
MOVLB 0x0                
BTFSS 0x39, 0x3          
GOTO 0x58A               
BCF 0x39, 0x3            
LSLF 0x45, W             
ADDLW 0xB9               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
MOVLB 0x3                
MOVF 0x3D, W             
ADDWF INDF1, F           
ADDFSR 1, 1              
MOVF 0x3E, W             
ADDWFC INDF1, F          
ADDFSR 1, -1             
MOVLB 0x0                
INCF 0x45, F             
MOVLW 0x2                
SUBWF 0x45, W            
BTFSS STATUS, 0x0        
GOTO 0x578               
CLRF 0x45                
MOVLB 0x2                
INCF 0x4B, F             
MOVLW 0x20               
SUBWF 0x4B, W            
BTFSS STATUS, 0x0        
GOTO 0x578               
MOVLB 0x3                
MOVF 0x3A, W             
MOVLB 0x0                
MOVWF 0x2B               
MOVLB 0x3                
MOVF 0x39, W             
MOVLB 0x0                
MOVWF 0x2A               
MOVLW 0x5                
LSRF 0x2B, F             
RRF 0x2A, F              
DECFSZ WREG, F           
GOTO 0x529               
MOVLB 0x2                
INCF 0x6C, F             
MOVLW 0x5                
SUBWF 0x6C, W            
BTFSS STATUS, 0x0        
GOTO 0x567               
CLRF 0x6C                
MOVLB 0x0                
MOVF 0x2B, W             
MOVWF 0x2D               
MOVF 0x2A, W             
MOVWF 0x2C               
MOVLB 0x3                
MOVF 0x41, W             
MOVLB 0x0                
SUBWF 0x2C, F            
MOVLB 0x3                
MOVF 0x42, W             
MOVLB 0x0                
SUBWFB 0x2D, F           
MOVF 0x2B, W             
MOVLB 0x3                
MOVWF 0x42               
MOVLB 0x0                
MOVF 0x2A, W             
MOVLB 0x3                
MOVWF 0x41               
MOVLB 0x0                
BTFSS 0x3F, 0x1          
GOTO 0x564               
MOVF 0x2D, W             
MOVLB 0x3                
MOVWF 0x44               
MOVLB 0x0                
MOVF 0x2C, W             
MOVLB 0x3                
MOVWF 0x43               
SWAPF 0x43, F            
SWAPF 0x44, F            
MOVLW 0xF0               
ANDWF 0x44, F            
MOVF 0x43, W             
ANDLW 0xF                
IORWF 0x44, F            
MOVLW 0xF0               
ANDWF 0x43, F            
MOVLB 0x0                
MOVF 0x2A, W             
MOVLB 0x3                
ADDWF 0x43, F            
MOVLB 0x0                
MOVF 0x2B, W             
MOVLB 0x3                
ADDWFC 0x44, F           
GOTO 0x567               
MOVLB 0x3                
CLRF 0x43                
CLRF 0x44                
MOVLB 0x2                
CLRF 0x4B                
MOVLB 0x0                
CLRF 0x6D                
LSLF 0x6D, W             
ADDLW 0xB9               
MOVWF FSR1L               
MOVLW 0x1                
MOVWF FSR1H              
CLRF INDF1               
ADDFSR 1, 1              
CLRF INDF1               
INCF 0x6D, F             
MOVLW 0x2                
SUBWF 0x6D, W            
BTFSS STATUS, 0x0        
GOTO 0x56B               
MOVLB 0x0                
MOVF 0x45, W             
ADDLW 0x41               
MOVWF FSR0L               
MOVLW 0xA9               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVF INDF0, W            
IORLW 0x1                
MOVLB 0x1                
MOVWF 0x1D               
MOVLB 0x0                
BCF PIR1, 0x6            
MOVLB 0x1                
BSF PIR1, 0x6            
MOVLW 0x5                
MOVWF 0x64               
MOVLB 0x0                
BTFSS 0x3A, 0x3          
RETURN                   
MOVLW 0x3                
SUBWF 0x2B, W            
MOVLW 0xC3               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x596               
MOVLW 0xC8               
GOTO 0x5CB               
MOVLW 0x0                
SUBWF 0x2B, W            
MOVLW 0x1F               
BTFSC STATUS, 0x2        
SUBWF 0x2A, W            
BTFSC STATUS, 0x0        
GOTO 0x5A0               
MOVLB 0x2                
CLRF 0x56                
GOTO 0x5CD               
CLRF 0x6D                
CALL 0x66B               
MOVLP 0x25               
CALL 0x663               
MOVLP 0x25               
SUBWF 0x2B, W            
BTFSS STATUS, 0x2        
GOTO 0x5AA               
MOVF 0x74, W             
SUBWF 0x2A, W            
BTFSS STATUS, 0x0        
GOTO 0x5AE               
INCF 0x6D, F             
GOTO 0x5A1               
CALL 0x645               
MOVLP 0x25               
SUBWF 0x2A, W            
MOVWF 0x5D               
MOVF 0x75, W             
SUBWFB 0x2B, W           
CALL 0x66F               
MOVLP 0x25               
CALL 0x5FE               
MOVLP 0x25               
CALL 0x623               
MOVLP 0x25               
BTFSS STATUS, 0x2        
GOTO 0x5C6               
MOVLW 0x0                
SUBWF 0x6B, W            
BTFSS STATUS, 0x2        
GOTO 0x5C6               
MOVLW 0x1                
SUBWF 0x6A, W            
BTFSS STATUS, 0x2        
GOTO 0x5C6               
MOVLW 0x0                
SUBWF 0x69, W            
BTFSS STATUS, 0x0        
GOTO 0x5CA               
MOVLW 0xFF               
GOTO 0x5CB               
MOVF 0x69, W             
MOVLB 0x2                
MOVWF 0x56               
MOVLB 0x0                
CLRF 0x6D                
CALL 0x66B               
MOVLP 0x25               
CALL 0x663               
MOVLP 0x25               
SUBWF 0x2F, W            
BTFSS STATUS, 0x2        
GOTO 0x5D8               
MOVF 0x74, W             
SUBWF 0x2E, W            
BTFSS STATUS, 0x0        
GOTO 0x5DC               
INCF 0x6D, F             
GOTO 0x5CF               
CALL 0x645               
MOVLP 0x25               
SUBWF 0x2E, W            
MOVWF 0x5D               
MOVF 0x75, W             
SUBWFB 0x2F, W           
CALL 0x66F               
MOVLP 0x25               
CALL 0x5FE               
MOVLP 0x25               
CALL 0x623               
MOVLP 0x25               
BTFSS STATUS, 0x2        
GOTO 0x5F4               
MOVLW 0x0                
SUBWF 0x6B, W            
BTFSS STATUS, 0x2        
GOTO 0x5F4               
MOVLW 0x1                
SUBWF 0x6A, W            
BTFSS STATUS, 0x2        
GOTO 0x5F4               
MOVLW 0x0                
SUBWF 0x69, W            
BTFSS STATUS, 0x0        
GOTO 0x5FA               
MOVLW 0xFF               
MOVLB 0x2                
MOVWF 0x5A               
RETURN                   
MOVF 0x69, W             
MOVLB 0x2                
MOVWF 0x5A               
RETURN                   
CLRF 0x65                
CLRF 0x66                
CLRF 0x67                
CLRF 0x68                
BTFSS 0x5D, 0x0          
GOTO 0x60C               
MOVF 0x61, W             
ADDWF 0x65, F            
MOVF 0x62, W             
ADDWFC 0x66, F           
MOVF 0x63, W             
ADDWFC 0x67, F           
MOVF 0x64, W             
ADDWFC 0x68, F           
LSLF 0x61, F             
RLF 0x62, F              
RLF 0x63, F              
RLF 0x64, F              
LSRF 0x60, F             
RRF 0x5F, F              
RRF 0x5E, F              
RRF 0x5D, F              
MOVF 0x60, W             
IORWF 0x5F, W            
IORWF 0x5E, W            
IORWF 0x5D, W            
BTFSS STATUS, 0x2        
GOTO 0x602               
MOVF 0x68, W             
MOVWF 0x60               
MOVF 0x67, W             
MOVWF 0x5F               
MOVF 0x66, W             
MOVWF 0x5E               
MOVF 0x65, W             
MOVWF 0x5D               
RETURN                   
MOVF 0x60, W             
MOVWF 0x6C               
MOVF 0x5F, W             
MOVWF 0x6B               
MOVF 0x5E, W             
MOVWF 0x6A               
MOVF 0x5D, W             
MOVWF 0x69               
MOVF 0x6A, W             
MOVWF 0x69               
MOVF 0x6B, W             
MOVWF 0x6A               
MOVF 0x6C, W             
MOVWF 0x6B               
CLRF 0x6C                
MOVF 0x6D, W             
ADDLW 0xA3               
MOVWF FSR0L               
MOVLW 0xA8               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVF INDF0, W            
ADDWF 0x69, F            
MOVLW 0x1                
BTFSC STATUS, 0x0        
ADDWF 0x6A, F            
BTFSC STATUS, 0x0        
ADDWF 0x6B, F            
BTFSC STATUS, 0x0        
ADDWF 0x6C, F            
MOVLW 0x0                
SUBWF 0x6C, W            
RETURN                   
LSLF 0x6D, W             
ADDLW 0x53               
MOVWF FSR0L               
MOVLW 0xA8               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVWF 0x74               
MOVIW 1[FSR0]            
MOVWF 0x75               
MOVF 0x74, W             
MOVWF 0x69               
MOVF 0x75, W             
MOVWF 0x6A               
CLRF 0x6B                
CLRF 0x6C                
LSLF 0x6D, W             
ADDLW 0x1                
MOVWF FSR0L               
MOVLW 0xA8               
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVWF 0x74               
MOVIW 1[FSR0]            
MOVWF 0x75               
MOVF 0x74, W             
RETURN                   
BTFSC STATUS, 0x0        
ADDLW 0x1                
MOVWF FSR0H              
MOVIW 0[FSR0]            
MOVWF 0x74               
MOVIW 1[FSR0]            
MOVWF 0x75               
RETURN                   
LSLF 0x6D, W             
ADDLW 0x3                
MOVWF FSR0L               
RETLW 0xA8               
MOVWF 0x5E               
CLRF 0x5F                
CLRF 0x60                
MOVF 0x6C, W             
MOVWF 0x64               
MOVF 0x6B, W             
MOVWF 0x63               
MOVF 0x6A, W             
MOVWF 0x62               
MOVF 0x69, W             
MOVWF 0x61               
RETURN                   
MOVLB 0x0                
MOVF 0x4B, F             
BTFSS STATUS, 0x2        
GOTO 0x684               
MOVLB 0x1                
CLRF 0x49                
CLRF 0x3D                
CLRF 0x3E                
GOTO 0x770               
BTFSS 0x79, 0x3          
GOTO 0x691               
DECFSZ 0x4B, W           
GOTO 0x691               
MOVLB 0x1                
CALL 0x7FA               
MOVLP 0x26               
MOVF 0x28, W             
MOVLB 0x2                
MOVWF 0x2D               
MOVLB 0x1                
MOVF 0x29, W             
GOTO 0x69B               
BTFSS 0x79, 0x6          
GOTO 0x6A0               
MOVLB 0x1                
CALL 0x7FA               
MOVLP 0x26               
MOVF 0x33, W             
MOVLB 0x2                
MOVWF 0x2D               
MOVLB 0x1                
MOVF 0x34, W             
MOVLB 0x2                
MOVWF 0x2E               
CLRF 0x2F                
CLRF 0x30                
GOTO 0x770               
BTFSS 0x79, 0x5          
GOTO 0x6C8               
DECFSZ 0x4B, W           
GOTO 0x6C8               
MOVLB 0x1                
CALL 0x7FA               
MOVLP 0x26               
MOVF 0x35, W             
MOVLB 0x2                
MOVWF 0x2D               
MOVLB 0x1                
MOVF 0x36, W             
MOVLB 0x2                
MOVWF 0x2E               
CLRF 0x2F                
CLRF 0x30                
MOVLW 0x0                
SUBWF 0x30, W            
BTFSS STATUS, 0x2        
GOTO 0x6BE               
MOVLW 0x1                
SUBWF 0x2F, W            
BTFSS STATUS, 0x2        
GOTO 0x6BE               
MOVLW 0x86               
SUBWF 0x2E, W            
BTFSS STATUS, 0x2        
GOTO 0x6BE               
MOVLW 0xA0               
SUBWF 0x2D, W            
BTFSS STATUS, 0x0        
GOTO 0x770               
CLRF 0x30                
MOVLW 0x1                
MOVWF 0x2F               
MOVLW 0x86               
MOVWF 0x2E               
MOVLW 0x9F               
MOVWF 0x2D               
GOTO 0x770               
BTFSS 0x79, 0x0          
GOTO 0x770               
DECFSZ 0x4B, W           
GOTO 0x770               
MOVLB 0x1                
CALL 0x7FA               
MOVLP 0x26               
MOVF 0x2A, W             
MOVLB 0x2                
MOVWF 0x2D               
CLRF 0x2E                
CLRF 0x2F                
CLRF 0x30                
GOTO 0x770               
MOVF 0x3E, W             
IORWF 0x3D, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVLB 0x0                
MOVF 0x47, F             
BTFSS STATUS, 0x2        
GOTO 0x6F0               
MOVLW 0xA                
CALL 0x7F4               
MOVLP 0x26               
MOVLB 0x2                
MOVF 0x30, W             
MOVLB 0x4                
MOVWF 0x35               
MOVLB 0x2                
MOVF 0x2F, W             
MOVLB 0x4                
MOVWF 0x34               
MOVLB 0x2                
MOVF 0x2E, W             
MOVLB 0x4                
MOVWF 0x33               
MOVLB 0x2                
MOVF 0x2D, W             
GOTO 0x731               
DECFSZ 0x47, W           
GOTO 0x6F6               
MOVLW 0xA                
CALL 0x7F4               
MOVLP 0x26               
GOTO 0x6FE               
MOVF 0x47, W             
XORLW 0x2                
BTFSS STATUS, 0x2        
GOTO 0x704               
MOVLW 0xA                
CALL 0x7F4               
MOVLP 0x26               
MOVLW 0x64               
MOVLB 0x0                
MOVWF 0x5D               
CLRF 0x5E                
CLRF 0x5F                
CLRF 0x60                
GOTO 0x712               
MOVF 0x47, W             
XORLW 0x3                
BTFSS STATUS, 0x2        
GOTO 0x738               
MOVLW 0xA                
CALL 0x7F4               
MOVLP 0x26               
MOVLB 0x0                
CLRF 0x60                
CLRF 0x5F                
MOVLW 0x3                
MOVWF 0x5E               
MOVLW 0xE8               
MOVWF 0x5D               
MOVLB 0x2                
MOVF 0x30, W             
MOVLB 0x0                
MOVWF 0x64               
MOVLB 0x2                
MOVF 0x2F, W             
MOVLB 0x0                
MOVWF 0x63               
MOVLB 0x2                
MOVF 0x2E, W             
MOVLB 0x0                
MOVWF 0x62               
MOVLB 0x2                
MOVF 0x2D, W             
MOVLB 0x0                
MOVWF 0x61               
CALL 0x7B5               
MOVLP 0x26               
MOVF 0x60, W             
MOVLB 0x4                
MOVWF 0x35               
MOVLB 0x0                
MOVF 0x5F, W             
MOVLB 0x4                
MOVWF 0x34               
MOVLB 0x0                
MOVF 0x5E, W             
MOVLB 0x4                
MOVWF 0x33               
MOVLB 0x0                
MOVF 0x5D, W             
MOVLB 0x4                
MOVWF 0x32               
CALL 0x77F               
MOVLP 0x26               
MOVF 0x2E, W             
MOVLB 0x0                
MOVWF 0x58               
MOVF 0x58, W             
BTFSC STATUS, 0x2        
GOTO 0x741               
MOVLB 0x1                
INCF 0x49, F             
MOVLW 0x46               
MOVWF 0x3D               
CLRF 0x3E                
RETURN                   
MOVLW 0x3                
SUBWF 0x47, W            
BTFSC STATUS, 0x0        
GOTO 0x747               
INCF 0x47, F             
RETURN                   
CLRF 0x47                
MOVLW 0x90               
MOVLB 0x1                
MOVWF 0x3D               
MOVLW 0x1                
MOVWF 0x3E               
RETURN                   
MOVF 0x3E, W             
IORWF 0x3D, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVLW 0x1E               
MOVWF 0x3D               
CLRF 0x3E                
INCF 0x49, F             
RETURN                   
MOVF 0x3E, W             
IORWF 0x3D, W            
BTFSS STATUS, 0x2        
RETURN                   
MOVLB 0x0                
DECF 0x58, F             
BTFSC STATUS, 0x2        
GOTO 0x762               
MOVLB 0x1                
DECF 0x49, F             
GOTO 0x73D               
MOVLB 0x1                
CLRF 0x49                
INCF 0x49, F             
MOVLW 0x3                
MOVLB 0x0                
SUBWF 0x47, W            
BTFSC STATUS, 0x0        
GOTO 0x747               
INCF 0x47, F             
MOVLW 0xC8               
MOVLB 0x1                
MOVWF 0x3D               
CLRF 0x3E                
RETURN                   
MOVLB 0x1                
MOVF 0x49, W             
XORLW 0x0                
BTFSC STATUS, 0x2        
RETURN                   
XORLW 0x1                
BTFSC STATUS, 0x2        
GOTO 0x6D6               
XORLW 0x3                
BTFSC STATUS, 0x2        
GOTO 0x74E               
XORLW 0x1                
BTFSS STATUS, 0x2        
RETURN                   
GOTO 0x757               
MOVF 0x31, W             
IORWF 0x30, W            
IORWF 0x2F, W            
IORWF 0x2E, W            
BTFSC STATUS, 0x2        
GOTO 0x7AC               
CLRF 0x74                
INCF 0x74, F             
BTFSC 0x31, 0x7          
GOTO 0x78E               
LSLF 0x2E, F             
RLF 0x2F, F              
RLF 0x30, F              
RLF 0x31, F              
GOTO 0x786               
MOVF 0x31, W             
SUBWF 0x35, W            
BTFSS STATUS, 0x2        
GOTO 0x79C               
MOVF 0x30, W             
SUBWF 0x34, W            
BTFSS STATUS, 0x2        
GOTO 0x79C               
MOVF 0x2F, W             
SUBWF 0x33, W            
BTFSS STATUS, 0x2        
GOTO 0x79C               
MOVF 0x2E, W             
SUBWF 0x32, W            
BTFSS STATUS, 0x0        
GOTO 0x7A6               
MOVF 0x2E, W             
SUBWF 0x32, F            
MOVF 0x2F, W             
SUBWFB 0x33, F           
MOVF 0x30, W             
SUBWFB 0x34, F           
MOVF 0x31, W             
SUBWFB 0x35, F           
LSRF 0x31, F             
RRF 0x30, F              
RRF 0x2F, F              
RRF 0x2E, F              
DECFSZ 0x74, F           
GOTO 0x78E               
MOVF 0x35, W             
MOVWF 0x31               
MOVF 0x34, W             
MOVWF 0x30               
MOVF 0x33, W             
MOVWF 0x2F               
MOVF 0x32, W             
MOVWF 0x2E               
RETURN                   
CLRF 0x65                
CLRF 0x66                
CLRF 0x67                
CLRF 0x68                
MOVF 0x60, W             
IORWF 0x5F, W            
IORWF 0x5E, W            
IORWF 0x5D, W            
BTFSC STATUS, 0x2        
GOTO 0x7EB               
CLRF 0x69                
INCF 0x69, F             
BTFSC 0x60, 0x7          
GOTO 0x7C8               
LSLF 0x5D, F             
RLF 0x5E, F              
RLF 0x5F, F              
RLF 0x60, F              
GOTO 0x7C0               
LSLF 0x65, F             
RLF 0x66, F              
RLF 0x67, F              
RLF 0x68, F              
MOVF 0x60, W             
SUBWF 0x64, W            
BTFSS STATUS, 0x2        
GOTO 0x7DA               
MOVF 0x5F, W             
SUBWF 0x63, W            
BTFSS STATUS, 0x2        
GOTO 0x7DA               
MOVF 0x5E, W             
SUBWF 0x62, W            
BTFSS STATUS, 0x2        
GOTO 0x7DA               
MOVF 0x5D, W             
SUBWF 0x61, W            
BTFSS STATUS, 0x0        
GOTO 0x7E5               
MOVF 0x5D, W             
SUBWF 0x61, F            
MOVF 0x5E, W             
SUBWFB 0x62, F           
MOVF 0x5F, W             
SUBWFB 0x63, F           
MOVF 0x60, W             
SUBWFB 0x64, F           
BSF 0x65, 0x0            
LSRF 0x60, F             
RRF 0x5F, F              
RRF 0x5E, F              
RRF 0x5D, F              
DECFSZ 0x69, F           
GOTO 0x7C8               
MOVF 0x68, W             
MOVWF 0x60               
MOVF 0x67, W             
MOVWF 0x5F               
MOVF 0x66, W             
MOVWF 0x5E               
MOVF 0x65, W             
MOVWF 0x5D               
RETURN                   
MOVLB 0x4                
MOVWF 0x2E               
CLRF 0x2F                
CLRF 0x30                
CLRF 0x31                
RETURN                   
CLRF 0x49                
INCF 0x49, F             
MOVLB 0x0                
CLRF 0x47                
MOVLB 0x1                
RETURN                   
RETLW 0x0                
RETLW 0x1E               
RETLW 0x0                
RETLW 0x27               
RETLW 0x0                
RETLW 0x31               
RETLW 0x0                
RETLW 0x3D               
RETLW 0x0                
RETLW 0x4C               
RETLW 0x0                
RETLW 0x5D               
RETLW 0x0                
RETLW 0x72               
RETLW 0x0                
RETLW 0x89               
RETLW 0x0                
RETLW 0xA3               
RETLW 0x0                
RETLW 0xC0               
RETLW 0x0                
RETLW 0xE0               
RETLW 0x0                
RETLW 0x3                
RETLW 0x1                
RETLW 0x28               
RETLW 0x1                
RETLW 0x4F               
RETLW 0x1                
RETLW 0x77               
RETLW 0x1                
RETLW 0xA0               
RETLW 0x1                
RETLW 0xC9               
RETLW 0x1                
RETLW 0xF2               
RETLW 0x1                
RETLW 0x1A               
RETLW 0x2                
RETLW 0x40               
RETLW 0x2                
RETLW 0x66               
RETLW 0x2                
RETLW 0x89               
RETLW 0x2                
RETLW 0xAA               
RETLW 0x2                
RETLW 0xC8               
RETLW 0x2                
RETLW 0xE5               
RETLW 0x2                
RETLW 0xFF               
RETLW 0x2                
RETLW 0x17               
RETLW 0x3                
RETLW 0x2D               
RETLW 0x3                
RETLW 0x41               
RETLW 0x3                
RETLW 0x53               
RETLW 0x3                
RETLW 0x63               
RETLW 0x3                
RETLW 0x72               
RETLW 0x3                
RETLW 0x7F               
RETLW 0x3                
RETLW 0x8B               
RETLW 0x3                
RETLW 0x96               
RETLW 0x3                
RETLW 0xA0               
RETLW 0x3                
RETLW 0xA8               
RETLW 0x3                
RETLW 0xB0               
RETLW 0x3                
RETLW 0xB7               
RETLW 0x3                
RETLW 0xBD               
RETLW 0x3                
RETLW 0xC3               
RETLW 0x3                
RETLW 0x8E               
RETLW 0x0                
RETLW 0x80               
RETLW 0x0                
RETLW 0x6A               
RETLW 0x0                
RETLW 0x55               
RETLW 0x0                
RETLW 0x4B               
RETLW 0x0                
RETLW 0x3C               
RETLW 0x0                
RETLW 0x37               
RETLW 0x0                
RETLW 0x31               
RETLW 0x0                
RETLW 0x2C               
RETLW 0x0                
RETLW 0x28               
RETLW 0x0                
RETLW 0x24               
RETLW 0x0                
RETLW 0x22               
RETLW 0x0                
RETLW 0x20               
RETLW 0x0                
RETLW 0x20               
RETLW 0x0                
RETLW 0x1F               
RETLW 0x0                
RETLW 0x1F               
RETLW 0x0                
RETLW 0x1F               
RETLW 0x0                
RETLW 0x20               
RETLW 0x0                
RETLW 0x21               
RETLW 0x0                
RETLW 0x21               
RETLW 0x0                
RETLW 0x24               
RETLW 0x0                
RETLW 0x26               
RETLW 0x0                
RETLW 0x2A               
RETLW 0x0                
RETLW 0x2C               
RETLW 0x0                
RETLW 0x31               
RETLW 0x0                
RETLW 0x35               
RETLW 0x0                
RETLW 0x3A               
RETLW 0x0                
RETLW 0x40               
RETLW 0x0                
RETLW 0x47               
RETLW 0x0                
RETLW 0x50               
RETLW 0x0                
RETLW 0x55               
RETLW 0x0                
RETLW 0x62               
RETLW 0x0                
RETLW 0x6A               
RETLW 0x0                
RETLW 0x74               
RETLW 0x0                
RETLW 0x80               
RETLW 0x0                
RETLW 0xA0               
RETLW 0x0                
RETLW 0xA0               
RETLW 0x0                
RETLW 0xB6               
RETLW 0x0                
RETLW 0xD5               
RETLW 0x0                
RETLW 0xD5               
RETLW 0x0                
RETLW 0x0                
RETLW 0x5                
RETLW 0xA                
RETLW 0xF                
RETLW 0x14               
RETLW 0x19               
RETLW 0x1E               
RETLW 0x23               
RETLW 0x28               
RETLW 0x2D               
RETLW 0x32               
RETLW 0x37               
RETLW 0x3C               
RETLW 0x41               
RETLW 0x46               
RETLW 0x4B               
RETLW 0x50               
RETLW 0x55               
RETLW 0x5A               
RETLW 0x5F               
RETLW 0x64               
RETLW 0x69               
RETLW 0x6E               
RETLW 0x73               
RETLW 0x78               
RETLW 0x7D               
RETLW 0x82               
RETLW 0x87               
RETLW 0x8C               
RETLW 0x91               
RETLW 0x96               
RETLW 0x9B               
RETLW 0xA0               
RETLW 0xA5               
RETLW 0xAA               
RETLW 0xAF               
RETLW 0xB4               
RETLW 0xB9               
RETLW 0xBE               
RETLW 0xC3               
RETLW 0xC8               
RETLW 0x0                
RETLW 0x0                
RETLW 0x1                
RETLW 0x0                
RETLW 0x2                
RETLW 0x0                
RETLW 0x3                
RETLW 0x0                
RETLW 0x4                
RETLW 0x0                
RETLW 0x5                
RETLW 0x0                
RETLW 0x6                
RETLW 0x0                
RETLW 0x7                
RETLW 0x0                
RETLW 0x8                
RETLW 0x0                
RETLW 0x9                
RETLW 0x0                
RETLW 0xA                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x61               
RETLW 0x0                
RETLW 0xAB               
RETLW 0x0                
RETLW 0xC3               
RETLW 0x0                
RETLW 0xEB               
RETLW 0x0                
RETLW 0x1F               
RETLW 0x1                
RETLW 0x34               
RETLW 0x1                
RETLW 0x42               
RETLW 0x1                
RETLW 0x55               
RETLW 0x1                
RETLW 0x62               
RETLW 0x1                
RETLW 0x0                
RETLW 0x0                
RETLW 0xF                
RETLW 0x0                
RETLW 0x1F               
RETLW 0x0                
RETLW 0x50               
RETLW 0x0                
RETLW 0x60               
RETLW 0x0                
RETLW 0x68               
RETLW 0x0                
RETLW 0x91               
RETLW 0x0                
RETLW 0x91               
RETLW 0x0                
RETLW 0xA2               
RETLW 0x0                
RETLW 0xBA               
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x9                
RETLW 0x0                
RETLW 0x10               
RETLW 0x0                
RETLW 0x22               
RETLW 0x0                
RETLW 0x36               
RETLW 0x0                
RETLW 0x4C               
RETLW 0x0                
RETLW 0x20               
RETLW 0xA1               
RETLW 0x7                
RETLW 0x0                
RETLW 0x40               
RETLW 0xD                
RETLW 0x3                
RETLW 0x0                
RETLW 0x80               
RETLW 0x38               
RETLW 0x1                
RETLW 0x0                
RETLW 0x0                
RETLW 0x1                
RETLW 0x2                
RETLW 0x3                
RETLW 0x4                
RETLW 0x5                
RETLW 0x6                
RETLW 0x7                
RETLW 0x8                
RETLW 0x9                
RETLW 0xA                
RETLW 0x1C               
RETLW 0x2                
RETLW 0x8                
RETLW 0x7                
RETLW 0x30               
RETLW 0x2A               
RETLW 0x8                
RETLW 0x0                
RETLW 0x0                
RETLW 0x0                
RETLW 0x8                
RETLW 0x0                
RETLW 0x0                
RETLW 0x4                
