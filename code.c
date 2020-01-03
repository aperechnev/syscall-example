void usermode_function() {
	__asm__("SVC #0x00");
}

void syscall() {
	__asm__("PUSH {r0-r7}");
	__asm__("POP {r0-r7}");
}
