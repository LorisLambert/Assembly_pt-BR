#INCLUDE <P16F873A.INC>
ORG 0X00
GOTO INICIO                        ; Vá para o início
           
ATUALIZA   BTFSC PORTB, 0X01       ; Caixa d'água totalmente cheia?
           RETLW 0X00              ; Sim, desligue o motor
           BTFSS PORTB, 0X00       ; Não, mas caixa d'água totalmente vazia?
           RETLW 0X04              ; Não, ligue o motor
           BTFSS PORTB, 0X02       ; Sim, mas o motor está ligado?
           RETLW 0X00              ; Não, permaneça desligado
           RETLW 0X04              ; Sim, permaneça ligado
        
INICIO     BSF STATUS, 0X05        ; Vá para o banco 1     
           MOVLW B'11111011'       
           MOVWF TRISB             ; Rb0 e Rb1 como entrada e Rb3 como saída
           BCF STATUS, 0X05        ; Vá para o banco 0
           
PROGRAMA   CALL ATUALIZA           ; Vá para a sub-rotina
           MOVWF PORTB             ; Atualize o estado do motor
           GOTO PROGRAMA           ; Volte ao início

END

        


