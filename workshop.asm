
_main:

;workshop.c,24 :: 		void main() {
;workshop.c,27 :: 		TRISC = 0 ;    // portc sortie
	CLRF       TRISC+0
;workshop.c,28 :: 		TRISD = 0  ;  // portd sortie
	CLRF       TRISD+0
;workshop.c,30 :: 		TRISA.RA0=0; // PTONTIOMETRE entree
	BCF        TRISA+0, 0
;workshop.c,31 :: 		TRISA.RA1=0; // PTONTIOMETRE entree
	BCF        TRISA+0, 1
;workshop.c,32 :: 		TRISA.RA2=0; // PTONTIOMETRE entree
	BCF        TRISA+0, 2
;workshop.c,33 :: 		TRISA.RA3=0; // PTONTIOMETRE entree
	BCF        TRISA+0, 3
;workshop.c,34 :: 		adcon1=0x80;
	MOVLW      128
	MOVWF      ADCON1+0
;workshop.c,35 :: 		trisb.rb2=0;
	BCF        TRISB+0, 2
;workshop.c,36 :: 		trisb.rb3=0;
	BCF        TRISB+0, 3
;workshop.c,37 :: 		trisb.rb4=1;trisb.rb5=1;trisb.rb6=1;trisb.rb7=1;
	BSF        TRISB+0, 4
	BSF        TRISB+0, 5
	BSF        TRISB+0, 6
	BSF        TRISB+0, 7
;workshop.c,39 :: 		TRISB.RB1=0; ////////////TEST////////////
	BCF        TRISB+0, 1
;workshop.c,40 :: 		TRISB.RB0=1;
	BSF        TRISB+0, 0
;workshop.c,41 :: 		INTCON.GIE=1;         //global interruption
	BSF        INTCON+0, 7
;workshop.c,42 :: 		INTCON.INTE=1;        //INTE=RB0  enable
	BSF        INTCON+0, 4
;workshop.c,43 :: 		OPTION_REG.INTEDG = 1; ///// front montant
	BSF        OPTION_REG+0, 6
;workshop.c,44 :: 		INTCON.RBIE = 1;        //INT RB  enable
	BSF        INTCON+0, 3
;workshop.c,46 :: 		INTCON.T0IE = 1;
	BSF        INTCON+0, 5
;workshop.c,47 :: 		OPTION_REG = 0b01000111;
	MOVLW      71
	MOVWF      OPTION_REG+0
;workshop.c,48 :: 		TMR0=0;
	CLRF       TMR0+0
;workshop.c,52 :: 		PORTB.RB1=0; ////////////TEST////////////
	BCF        PORTB+0, 1
;workshop.c,53 :: 		PortC = 0 ;
	CLRF       PORTC+0
;workshop.c,54 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;workshop.c,55 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;workshop.c,57 :: 		while(1)
L_main0:
;workshop.c,60 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;workshop.c,61 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;workshop.c,62 :: 		Lcd_Out(1, 1, "Appuyer Bouton");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_workshop+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;workshop.c,64 :: 		result=adc_read(7);
	MOVLW      7
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _result+0
	MOVF       R0+1, 0
	MOVWF      _result+1
;workshop.c,65 :: 		periode=(result*0.00489)+5;
	CALL       _int2double+0
	MOVLW      75
	MOVWF      R4+0
	MOVLW      60
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      119
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      _periode+0
	MOVF       R0+1, 0
	MOVWF      _periode+1
;workshop.c,66 :: 		lcd_out(2,1,"Temps Alloue ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_workshop+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;workshop.c,67 :: 		floattostr(periode,display);
	MOVF       _periode+0, 0
	MOVWF      R0+0
	MOVF       _periode+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _display+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;workshop.c,68 :: 		lcd_out_cp(display);
	MOVLW      _display+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;workshop.c,69 :: 		lcd_out_cp("S");
	MOVLW      ?lstr3_workshop+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;workshop.c,73 :: 		PortC = 0b00100001 ;      // R S // V P
	MOVLW      33
	MOVWF      PORTC+0
;workshop.c,74 :: 		delay_ms(50)      ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	NOP
	NOP
;workshop.c,75 :: 		PortC = 0b00010010 ;      // O // O
	MOVLW      18
	MOVWF      PORTC+0
;workshop.c,76 :: 		delay_ms(50)       ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	NOP
	NOP
;workshop.c,77 :: 		PortC = 0b000001100 ;     // V S // R P
	MOVLW      12
	MOVWF      PORTC+0
;workshop.c,78 :: 		delay_ms(50)   ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	NOP
	NOP
;workshop.c,79 :: 		PortC = 0b00010010 ;      // O // O
	MOVLW      18
	MOVWF      PORTC+0
;workshop.c,80 :: 		delay_ms(50)  ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	NOP
	NOP
;workshop.c,82 :: 		}
	GOTO       L_main0
;workshop.c,83 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;workshop.c,87 :: 		void interrupt()
;workshop.c,89 :: 		if ( INTCON.INTF==1 )
	BTFSS      INTCON+0, 1
	GOTO       L_interrupt6
;workshop.c,91 :: 		for( i=periode;i>=0;i-- )
	MOVF       _periode+0, 0
	MOVWF      _i+0
	MOVF       _periode+1, 0
	MOVWF      _i+1
L_interrupt7:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt28
	MOVLW      0
	SUBWF      _i+0, 0
L__interrupt28:
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt8
;workshop.c,93 :: 		porta=i;
	MOVF       _i+0, 0
	MOVWF      PORTA+0
;workshop.c,94 :: 		PortC = 0b00010100 ;
	MOVLW      20
	MOVWF      PORTC+0
;workshop.c,95 :: 		delay_ms(50)  ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt10:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt10
	DECFSZ     R12+0, 1
	GOTO       L_interrupt10
	NOP
	NOP
;workshop.c,96 :: 		PortC = 0b00001100 ;
	MOVLW      12
	MOVWF      PORTC+0
;workshop.c,97 :: 		delay_ms(50)  ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt11:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt11
	DECFSZ     R12+0, 1
	GOTO       L_interrupt11
	NOP
	NOP
;workshop.c,98 :: 		PortC = 0b00100100 ;
	MOVLW      36
	MOVWF      PORTC+0
;workshop.c,99 :: 		delay_ms(50)  ;
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt12:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt12
	DECFSZ     R12+0, 1
	GOTO       L_interrupt12
	NOP
	NOP
;workshop.c,91 :: 		for( i=periode;i>=0;i-- )
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;workshop.c,100 :: 		}
	GOTO       L_interrupt7
L_interrupt8:
;workshop.c,101 :: 		INTCON.INTF=0;
	BCF        INTCON+0, 1
;workshop.c,102 :: 		}
L_interrupt6:
;workshop.c,103 :: 		if ( INTCON.RBIF==1 )
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt13
;workshop.c,105 :: 		if ( portb.rb4==1 || portb.rb5==1  )
	BTFSC      PORTB+0, 4
	GOTO       L__interrupt24
	BTFSC      PORTB+0, 5
	GOTO       L__interrupt24
	GOTO       L_interrupt16
L__interrupt24:
;workshop.c,107 :: 		PortC = 0b00100001 ;
	MOVLW      33
	MOVWF      PORTC+0
;workshop.c,108 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_interrupt17:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt17
	DECFSZ     R12+0, 1
	GOTO       L_interrupt17
	DECFSZ     R11+0, 1
	GOTO       L_interrupt17
	NOP
	NOP
;workshop.c,109 :: 		}
L_interrupt16:
;workshop.c,110 :: 		if ( portb.rb6==1 || portb.rb7==1  )
	BTFSC      PORTB+0, 6
	GOTO       L__interrupt23
	BTFSC      PORTB+0, 7
	GOTO       L__interrupt23
	GOTO       L_interrupt20
L__interrupt23:
;workshop.c,112 :: 		PortC = 0b00001100 ;
	MOVLW      12
	MOVWF      PORTC+0
;workshop.c,113 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_interrupt21:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt21
	DECFSZ     R12+0, 1
	GOTO       L_interrupt21
	DECFSZ     R11+0, 1
	GOTO       L_interrupt21
	NOP
	NOP
;workshop.c,115 :: 		}
L_interrupt20:
;workshop.c,116 :: 		INTCON.RBIF=0;   ;
	BCF        INTCON+0, 0
;workshop.c,117 :: 		}
L_interrupt13:
;workshop.c,118 :: 		if(INTCON.T0IF == 1)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt22
;workshop.c,120 :: 		INTCON.T0IF = 0 ;
	BCF        INTCON+0, 2
;workshop.c,121 :: 		}
L_interrupt22:
;workshop.c,124 :: 		}
L_end_interrupt:
L__interrupt27:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt
