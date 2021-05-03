        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(1)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table
        
        THUMB
        
__iar_program_start
        
        ;; main program begins here
main    MOV R0,  #-4          ;valor de entrada par os testes
        MOV R1, #2
        MOVS R9, R0
        ITE PL
          ADDPL R4,#1 ;positivo
          ADDMI R4, #0;negativo      
        
     
        BL checkParImpar
        ITE EQ
          ADDEQ R3, #0;par
          ADDNE R3, #1 ;impar
        
        
        B . ;  

checkParImpar
loopd   CBZ R0, resto   ; compara R0 e desvia se for 0
        
        CMP R0, R1      ; compara R0 e R1 e afeta FLAG
        BLO resto       ; se R0 < R1 desvia
        ADDS R11, R11, #1       ; add no R11 o valor da divisão
        SUB R0, R0, R1
        B       loopd   ; go to loop
resto   
        MOVS R12, R0 ; coloca o resto no R12
        BX LR
        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
FIM
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler        
        END