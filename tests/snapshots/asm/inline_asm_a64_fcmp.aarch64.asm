
inline_asm_a64_fcmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x16, #0x4008000000000000 // =4613937818241073152
               	str	x16, [sp]
               	ldr	d0, [sp]
               	fcmp	d0, #0.0
               	cset	w0, ge
               	cbz	w0, <addr>
               	mov	x16, #-0x3ff8000000000000 // =-4609434218613702656
               	str	x16, [sp]
               	ldr	d0, [sp]
               	fcmp	d0, #0.0
               	cset	w0, ge
               	cbnz	w0, <addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
