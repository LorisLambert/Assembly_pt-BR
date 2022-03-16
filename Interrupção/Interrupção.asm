#INCLUDE <P16F873A.INC>				
          CBLOCK 0X20			
          W_AUX
          S_AUX
          CONT
          ENDC                ; Declaração das variáveis

ORG 0X00                      ; Vetor de reset
		  GOTO INICIO         ; Vá para o início

ORG 0X04                      ; Vetor de interrupção
          MOVWF W_AUX         ; Salva o valor de W
          SWAPF STATUS, W		
          MOVWF S_AUX         ; Salva o valor de STATUS
          DECFSZ CONT         ; Cont-1 = 0?
          GOTO SAI            ; Não, sai da interrupção
          MOVLW B'00000010'          
          XORWF PORTB, F      ; Sim inverte LED
          MOVLW .125
          MOVWF CONT          ; Colocar 125 em CONT
SAI       BCF INTCON, 0X02    ; Limpar flag TOIF
          MOVLW .131
          MOVWF TMR0          ; Colocar 131 em TIMER0 
          SWAPF S_AUX, W
          MOVWF STATUS        ; Recupera STATUS
          SWAPF W_AUX, F      
          SWAPF W_AUX, W      ; Recupera W
          RETFIE              ; Retorna da interrupção

INICIO    BSF STATUS, 0X05    ; Vá para o banco 1
          MOVLW B'11111001'
          MOVWF TRISB         ; Rb0 como entrada e Rb1 e Rb2 como saída
          MOVLW B'10000100'    
          MOVWF OPTION_REG    ; Prescaler em 1:32     
          BCF STATUS, 0X05    ; Vá para o banco 0
          MOVLW .125
          MOVWF CONT          ; Colocar 125 em CONT
          MOVLW .131
          MOVWF TMR0          ; Colocar 125 em TIMER0         
          MOVLW B'10100000' 
          MOVWF INTCON        ; Habilitar interrupções

PROGRAMA  BCF PORTB, 0X02     ; Apagar LED 2
          BTFSC PORTB, 0X00   ; Botoeira apertada?
          GOTO PROGRAMA       ; Não, nada a fazer
LED_ON    BSF PORTB, 0X02     ; Sim, acender LED
          BTFSS PORTB, 0X00   ; Botoeira solta?
          GOTO LED_ON         ; Não, LED aceso
          GOTO PROGRAMA       ; Sim, voltar ao começo

END

          