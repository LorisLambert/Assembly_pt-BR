#INCLUDE <P16F84A.INC>
ORG 0X0000
        BSF STATUS, 0x05        ; VAI PARA O BANCO 1
        BSF TRISB, 0x00         ; RB0 COMO ENTRADA
        BCF TRISA, 0x02         ; RA2 COMO SAÍDA
        BCF STATUS, 0x05        ; VAI PARA O BANCO 0
        BCF PORTA, 0x02         ; APAGA LED
        BTFSC PORTB, 0x00       ; BOTOEIRA LIGADA?
        GOTO 0X0004             ; NÃO... ENTÃO VOLTE AO INICIO DA ROTINA
        BSF PORTA, 0x02         ; SIM... ENTÃO ACENDA LED
        GOTO 0X0005             ; TESTE A BOTOEIRA
END

  
