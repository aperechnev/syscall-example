.global __RESET

__RESET:
	B RESET_HANDLER /* Reset */
	B . /* Undefined */
	B SWI_HANDLER	/* SWI */
	B . /* Prefetch Abort */
	B . /* Data Abort */
	B . /* reserved */
	B . /* IRQ */
	B . /* FIQ */

RESET_HANDLER:
    MSR CPSR_c, 0x13 /* Supervisor mode */
    LDR SP, =stack_top
    MSR CPSR_c, 0x10 /* User mode */
    LDR SP, =usr_stack_top
    BL  usermode_function
    B   .

SWI_HANDLER:
	PUSH	{LR}
	BL		syscall
	POP		{LR}
	MOVS	PC, LR
