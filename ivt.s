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
    # Setup user stack (shared with system)
	LDR		SP, =stack_top

	# Switch to user mode
	MOV		r1, 0x10
	MSR		SPSR, r1
	MOVS	PC, r0
	BL		usermode_function
	B		.

SWI_HANDLER:
	PUSH	{LR}
	BL		syscall
	POP		{LR}
	MOVS	PC, LR
