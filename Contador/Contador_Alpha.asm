#INCLUDE <P16F873A.INC>                   
         CBLOCK 0X20                    ; DECLARAÇÃO DAS VARIÁVEIS
         MEMORIA
         TEMPO
         ENDC
        
ORG 0X00                                  
         BSF STATUS, 0X05               ; VÁ PARA O BANCO 1
         MOVLW 0X01                     
         MOVWF TRISB                    ; RB0 COMO ENTRADA E RB1, ..., RB7 COMO SAÍDA
         BCF STATUS, 0X05               ; VÁ PARA O BANCO 0
         CLRF MEMORIA                   ; LIMPAR O CONTEÚDO DA VARIÁVEL MEMORIA (INDICE)
         GOTO PROGRAMA                  ; VÁ PARA O PROGRAMA PRINCIPAL

BOUNCE   MOVLW 0XFF                     
         MOVWF TEMPO
         BTFSS PORTB, 0X00              ; BOTOEIRA TREPIDOU?
         GOTO $-1                       ; NÃO, NADA A FAZER
         DECFSZ TEMPO, 0X01             ; SIM, CONTAR DELAY ENQUANTO TREPIDA
         GOTO $-3
         RETURN

DISPLAY  INCF MEMORIA                   ; INCREMENTA A VARIÁVEL MEMORIA (INDICE) EM UMA UNIDADE
         MOVLW 0X0A
         SUBWF MEMORIA, W                
         BTFSC STATUS, 0X02             ; VERIFICAR SE O INDICE É MAIOR OU IGUAL A 10
         GOTO CORRE�AO                  ; SE FOR VÁ PARA A CORREÇÃO (PREPARAÇÃO PARA REINICIAR A CONTAGEM)
         MOVF MEMORIA, W                
         ADDWF PCL                      ; SE NÃO FOR ATUALIZE O DISPLAY  
         RETLW 0x7F                     ; PREPARAR 0 PARA O DISPALY
         RETLW 0x0D                     ; PREPARAR 1 PARA O DISPLAY
         RETLW 0XB7                     ; PREPARAR 2 PARA O DISPLAY  
         RETLW 0X9F                     ; PREPARAR 3 PARA O DISPLAY 
         RETLW 0XCD                     ; PREPARAR 4 PARA O DISPLAY
         RETLW 0XDB                     ; PREPARAR 5 PARA O DISPLAY
         RETLW 0XFB                     ; PREPARAR 6 PARA O DISPLAY
         RETLW 0X0F                     ; PREPARAR 7 PARA O DISPLAY
         RETLW 0XFF                     ; PREPARAR 8 PARA O DISPLAY
         RETLW 0XDF                     ; PREPARAR 9 PARA O DISPLAY
         
PROGRAMA MOVLW 0X7F
         MOVWF PORTB                    ; COLOCAR ZERO NO DISPLAY
BT_TEST  BTFSC PORTB, 0X00              ; BOTOEIRA PRESSIONADA?
         GOTO $-1                       ; NÃO, NADA A FAZER
         CALL BOUNCE                    ; SIM, RESOLVER PROBLEMA DA TREPIDAÇÃO 
         CALL DISPLAY
         MOVWF PORTB                    ; ATUALIZAR DISPLAY         
BT_TEST2 BTFSS PORTB, 0X00              ; BOTOEIRA SOLTA?
         GOTO $-1                       ; NAO, NADA A FAZER 
         CALL BOUNCE                    ; SIM, RESOLVER PROBLEMA DA TREPIDAÇÃO 
         GOTO BT_TEST                   ; VOLTAR AO TESTE DA BOTOEIRA
CORRE�AO MOVLW 0X7F
         MOVWF PORTB                    ; ZERAR DISPLAY
         CLRF MEMORIA                   ; ZERAR MEMORIA (INDICE)
         GOTO BT_TEST2                  ; REINICIAR CONTAGEM
         
END

         
         
         
         
         

         
 