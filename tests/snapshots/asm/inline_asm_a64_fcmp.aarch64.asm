
inline_asm_a64_fcmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	d0, [sp, #0x8]
               	ldr	d0, [sp, #0x8]
               	fcmp	d0, #0.0
               	cset	w0, ge
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fneg	d0, d16
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
