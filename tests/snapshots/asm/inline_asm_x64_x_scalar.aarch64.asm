
inline_asm_x64_x_scalar.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldur	s0, [x29, #-0x30]
               	ldur	s1, [x29, #-0x50]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x40]
               	ldur	s0, [x29, #-0x2c]
               	ldur	s1, [x29, #-0x4c]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x3c]
               	ldur	s0, [x29, #-0x28]
               	ldur	s1, [x29, #-0x48]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x38]
               	ldur	s0, [x29, #-0x24]
               	ldur	s1, [x29, #-0x44]
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x34]
               	ldur	q0, [x29, #-0x40]
               	stur	q0, [x29, #-0x40]
               	fmov	d0, #3.00000000
               	fcmp	d0, d0
               	cset	x0, ne
               	fmov	s0, #5.00000000
               	fcmp	s0, s0
               	cset	x1, ne
               	add	x0, x0, x1
               	fmov	d0, #7.50000000
               	fcmp	d0, d0
               	cset	x1, ne
               	add	x0, x0, x1
               	fmov	d0, #6.25000000
               	fcmp	d0, d0
               	b.ne	<addr>
               	fmov	d0, #2.50000000
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	cset	x1, ne
               	add	x1, x0, x1
               	fmov	d0, #8.00000000
               	stur	d0, [x29, #-0x10]
               	ldur	d1, [x29, #-0x10]
               	fcmp	d1, d0
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x8]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	cset	x0, ne
               	add	x2, x1, x0
               	fmov	s0, #8.00000000
               	stur	s0, [x29, #-0x18]
               	ldur	s1, [x29, #-0x18]
               	fcmp	s1, s0
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x14]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	cset	x1, ne
               	add	x1, x2, x1
               	fmov	d0, #1.50000000
               	fcmp	d0, d0
               	cset	x2, ne
               	add	x1, x1, x2
               	ldur	s0, [x29, #-0x40]
               	fmov	s1, #11.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x34]
               	mov	x16, #0x42300000        // =1110441984
               	fmov	s1, w16
               	fcmp	s0, s1
               	cset	x0, ne
               	add	x0, x1, x0
               	cbz	w0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
