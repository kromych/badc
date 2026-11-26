
inline_asm_x64_x_scalar.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x20
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	fadd	v1.4s, v0.4s, v1.4s
               	fmov	d0, #8.00000000
               	stur	d0, [x29, #-0x10]
               	ldur	d2, [x29, #-0x10]
               	fcmp	d2, d0
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x8]
               	fmov	d2, #2.00000000
               	fcmp	d0, d2
               	cset	x1, ne
               	fmov	s0, #8.00000000
               	stur	s0, [x29, #-0x18]
               	ldur	s2, [x29, #-0x18]
               	fcmp	s2, s0
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x14]
               	fmov	s2, #2.00000000
               	fcmp	s0, s2
               	cset	x2, ne
               	add	x1, x1, x2
               	mov	s0, v1.s[0]
               	fmov	s2, #11.00000000
               	fcmp	s0, s2
               	b.ne	<addr>
               	mov	s0, v1.s[3]
               	mov	x16, #0x42300000        // =1110441984
               	fmov	s1, w16
               	fcmp	s0, s1
               	cset	x0, ne
               	add	x0, x1, x0
               	cmp	w0, #0x0
               	mov	x17, #0x2a              // =42
               	csel	x0, x0, x17, ne
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
