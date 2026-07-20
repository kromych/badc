
inline_asm_a64_fp_vector.aarch64:	file format elf64-littleaarch64

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
               	sxtw	x0, w0
               	sub	x1, x29, #0x8
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	str	d0, [sp, #0x20]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x8]
               	dup	v0.4s, w1
               	fadd	v0.4s, v0.4s, v0.4s
               	fmov	w0, s0
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	d0, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	sub	x20, x29, #0x10
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	bl	<addr>
               	str	w0, [x20]
               	sub	x0, x29, #0x10
               	ldr	s0, [x0]
               	mov	x0, #0x42280000         // =1109917696
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
