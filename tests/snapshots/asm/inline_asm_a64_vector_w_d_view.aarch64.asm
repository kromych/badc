
inline_asm_a64_vector_w_d_view.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	ldr	d1, [x1, #0x8]
               	sub	x1, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x10]
               	fmov	d16, x0
               	fadd	v0.2s, v16.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x10]
               	str	d1, [sp, #0x30]
               	fmov	d16, x0
               	str	d16, [sp, #0x38]
               	ldr	d1, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	fmul	v0.2s, v0.2s, v1.2s
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	stur	x1, [x29, #-0x18]
               	ldur	s1, [x29, #-0x20]
               	fmov	s0, #2.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x1c]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x18]
               	fmov	s1, #0.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x14]
               	fmov	s1, #-8.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x18]
               	sub	x1, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x10]
               	fmov	d16, x0
               	eor	v0.8b, v16.8b, v0.8b
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	stur	x1, [x29, #-0x18]
               	ldurb	w1, [x29, #-0x18]
               	eor	x1, x1, #0xfe
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x16]
               	mov	x17, #0xf3              // =243
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x15]
               	mov	x17, #0xb               // =11
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldurb	w1, [x29, #-0x11]
               	mov	x17, #0x88              // =136
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	adrp	x1, <page>
               	ldr	d1, [x1, #0x28]
               	sub	x1, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x10]
               	fmov	d16, x0
               	add	d0, d16, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	stur	d1, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	fmov	d16, x0
               	add	d0, d16, d1
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x10
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x10]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x26
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x60
               	stp	xzr, xzr, [x1]
               	mov	x1, #0xf0               // =240
               	sturb	w1, [x29, #-0x51]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	q1, [x29, #-0x60]
               	str	q1, [sp, #0x30]
               	sub	x16, x29, #0x50
               	str	x16, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	x16, [sp, #0x40]
               	ldr	q0, [x16]
               	eor	v0.16b, v0.16b, v1.16b
               	stur	q0, [x29, #-0x50]
               	ldurb	w0, [x29, #-0x50]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x42]
               	eor	x0, x0, #0xf
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x41]
               	eor	x0, x0, #0xe0
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
