
// LCD module connections
sbit LCD_RS at RD4_bit;
sbit LCD_EN at RD5_bit;
sbit LCD_D4 at RD0_bit;
sbit LCD_D5 at RD1_bit;
sbit LCD_D6 at RD2_bit;
sbit LCD_D7 at RD3_bit;


sbit LCD_RS_Direction at TRISD4_bit;
sbit LCD_EN_Direction at TRISD5_bit;
sbit LCD_D4_Direction at TRISD0_bit;
sbit LCD_D5_Direction at TRISD1_bit;
sbit LCD_D6_Direction at TRISD2_bit;
sbit LCD_D7_Direction at TRISD3_bit;
// End LCD module connections

/////////Declaration des variables///////////
int pin1,pin2,pin3,pin4,nb,periode,temp,result,i,NBTmr;
char c1,c2,c3,c4,display[16]="";


void main() {

/////config
TRISC = 0 ;    // portc sortie
TRISD = 0  ;  // portd sortie
//TRISA.RA2=1; // PTONTIOMETRE entree
TRISA.RA0=0; // PTONTIOMETRE entree
TRISA.RA1=0; // PTONTIOMETRE entree
TRISA.RA2=0; // PTONTIOMETRE entree
TRISA.RA3=0; // PTONTIOMETRE entree
adcon1=0x80;
trisb.rb2=0;
trisb.rb3=0;
trisb.rb4=1;trisb.rb5=1;trisb.rb6=1;trisb.rb7=1;
//conf interrupt
  TRISB.RB1=0; ////////////TEST////////////
  TRISB.RB0=1;
  INTCON.GIE=1;         //global interruption
  INTCON.INTE=1;        //INTE=RB0  enable
  OPTION_REG.INTEDG = 1; ///// front montant
  INTCON.RBIE = 1;        //INT RB  enable
//Config Interrupt Timer
 INTCON.T0IE = 1;
 OPTION_REG = 0b01000111;
 TMR0=0;


/////INIT
PORTB.RB1=0; ////////////TEST////////////
PortC = 0 ;
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);

while(1)
{

  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Out(1, 1, "Appuyer Bouton");

result=adc_read(7);
periode=(result*0.00489)+5;
lcd_out(2,1,"Temps Alloue ");
floattostr(periode,display);
lcd_out_cp(display);
lcd_out_cp("S");



  PortC = 0b00100001 ;      // R S // V P
  delay_ms(50)      ;
  PortC = 0b00010010 ;      // O // O
  delay_ms(50)       ;
  PortC = 0b000001100 ;     // V S // R P
  delay_ms(50)   ;
  PortC = 0b00010010 ;      // O // O
  delay_ms(50)  ;

}
}


///////////////INTERRUPTION/////////////////////
void interrupt()
{
if ( INTCON.INTF==1 )
{
    for( i=periode;i>=0;i-- )
    {
     porta=i;
     PortC = 0b00010100 ;
     delay_ms(50)  ;
     PortC = 0b00001100 ;
     delay_ms(50)  ;
     PortC = 0b00100100 ;
     delay_ms(50)  ;
    }
INTCON.INTF=0;
}
if ( INTCON.RBIF==1 )
{
    if ( portb.rb4==1 || portb.rb5==1  )
    {    
         PortC = 0b00100001 ;
         delay_ms(500);
    }
    if ( portb.rb6==1 || portb.rb7==1  )
    {
        PortC = 0b00001100 ;
        delay_ms(500);

    }
     INTCON.RBIF=0;   ;
    }
if(INTCON.T0IF == 1)
{
    INTCON.T0IF = 0 ;
}


}