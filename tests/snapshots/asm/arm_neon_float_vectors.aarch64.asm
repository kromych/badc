
arm_neon_float_vectors.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1c0
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q3, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q4, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x88]
               	ldur	x0, [x29, #-0x88]
               	stur	x0, [x29, #-0xe0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x88]
               	ldur	x0, [x29, #-0x88]
               	stur	x0, [x29, #-0xd8]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	str	q0, [sp]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	str	q0, [sp, #0x10]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x88]
               	ldur	x0, [x29, #-0x88]
               	stur	x0, [x29, #-0xd0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x88]
               	ldur	x0, [x29, #-0x88]
               	stur	x0, [x29, #-0xc8]
               	fadd	v1.4s, v3.4s, v4.4s
               	fmov	s0, #2.00000000
               	fmov	s2, #2.25000000
               	fmov	s5, #10.00000000
               	sub	x16, x29, #0x90
               	str	q1, [x16]
               	ldur	s1, [x29, #-0x90]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x8c]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v0.4s, v3.4s, v4.4s
               	fmov	s1, #1.00000000
               	fmov	s2, #6.00000000
               	fmov	s5, #-6.00000000
               	fmov	s6, #4.25000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v0.4s, v3.4s, v4.4s
               	fmov	s1, #0.75000000
               	fmov	s2, #-8.00000000
               	fmov	s5, #-3.25000000
               	fmov	s6, #16.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v0.4s, v3.4s, v4.4s
               	fmov	s1, #3.00000000
               	fmov	s2, #-0.50000000
               	fmov	s5, #-3.25000000
               	fmov	s6, #4.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v0.4s, v3.4s, v4.4s
               	fmov	s1, #1.50000000
               	fmov	s2, #4.00000000
               	fmov	s5, #3.25000000
               	fmov	s6, #8.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmin	v0.4s, v3.4s, v4.4s
               	fmov	s1, #0.50000000
               	fmov	s2, #2.00000000
               	fmov	s5, #-2.00000000
               	fmov	s6, #-1.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fabs	v0.4s, v3.4s
               	fmov	s1, #1.50000000
               	fmov	s2, #2.00000000
               	fmov	s5, #3.25000000
               	fmov	s6, #8.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	v0.4s, v3.4s
               	fmov	s1, #-1.50000000
               	fmov	s2, #2.00000000
               	fmov	s5, #-3.25000000
               	fmov	s6, #-8.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v0.4s, v4.4s, v4.4s
               	fsqrt	v0.4s, v0.4s
               	fmov	s1, #0.50000000
               	fmov	s2, #4.00000000
               	fmov	s5, #1.00000000
               	fmov	s6, #2.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp, #0xb0]
               	str	q4, [sp, #0xc0]
               	str	q4, [sp, #0xd0]
               	ldr	q0, [sp, #0xb0]
               	ldr	q1, [sp, #0xc0]
               	ldr	q2, [sp, #0xd0]
               	fmla	v0.4s, v1.4s, v2.4s
               	fmov	s1, #1.75000000
               	fmov	s2, #14.00000000
               	fmov	s5, #4.25000000
               	fmov	s6, #12.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp, #0xb0]
               	str	q4, [sp, #0xc0]
               	str	q4, [sp, #0xd0]
               	ldr	q0, [sp, #0xb0]
               	ldr	q1, [sp, #0xc0]
               	ldr	q2, [sp, #0xd0]
               	fmls	v0.4s, v1.4s, v2.4s
               	fmov	s1, #1.25000000
               	fmov	s2, #-18.00000000
               	fmov	s5, #2.25000000
               	fmov	s6, #4.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xd8
               	sub	x2, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0xb8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0xa8]
               	sub	x1, x29, #0xa8
               	ldur	x2, [x29, #-0xa8]
               	sub	x0, x29, #0xb0
               	stur	x2, [x29, #-0xb0]
               	sub	x2, x29, #0xa0
               	ldr	x16, [x0]
               	str	x16, [x2]
               	ldur	s1, [x29, #-0xa0]
               	fmov	s0, #2.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	sub	x2, x29, #0x98
               	ldr	x16, [x0]
               	str	x16, [x2]
               	ldur	s1, [x29, #-0x94]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xe0
               	sub	x0, x29, #0xd8
               	sub	x3, x29, #0xc0
               	ldr	x16, [x2]
               	str	x16, [x3]
               	sub	x2, x29, #0xb8
               	ldr	x16, [x0]
               	str	x16, [x2]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0xb8]
               	ldur	x2, [x29, #-0xa8]
               	ldur	d0, [x29, #-0xc0]
               	str	d0, [sp, #0xb0]
               	fmov	d16, x1
               	str	d16, [sp, #0xb8]
               	fmov	d16, x2
               	str	d16, [sp, #0xc0]
               	ldr	d0, [sp, #0xb0]
               	ldr	d1, [sp, #0xb8]
               	ldr	d2, [sp, #0xc0]
               	fmla	v0.2s, v1.2s, v2.2s
               	stur	d0, [x29, #-0xc0]
               	sub	x2, x29, #0xc0
               	ldur	x1, [x29, #-0xc0]
               	sub	x0, x29, #0x98
               	stur	x1, [x29, #-0x98]
               	sub	x1, x29, #0xb0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0xb0]
               	fmov	s1, #1.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0xac]
               	fmov	s1, #14.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xd8
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0xb8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0x98]
               	ldur	s0, [x29, #-0x94]
               	fmov	s1, #-8.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	fabs	v0.2s, v16.2s
               	stur	d0, [x29, #-0xb8]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0x98]
               	ldur	s0, [x29, #-0x94]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	str	q0, [sp, #0xb0]
               	str	q1, [sp, #0xc0]
               	str	q1, [sp, #0xd0]
               	ldr	q0, [sp, #0xb0]
               	ldr	q1, [sp, #0xc0]
               	ldr	q2, [sp, #0xd0]
               	fmla	v0.2d, v1.2d, v2.2d
               	str	q0, [sp, #0x20]
               	ldr	d1, [sp, #0x20]
               	fmov	d2, #14.50000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	adrp	x16, <addr>
               	ldr	d1, [x16, #0x90]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	fdiv	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x20]
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	fsub	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	fmov	d1, #-4.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0xc8
               	sub	x2, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0xb8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	stur	d0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0x98]
               	ldur	d0, [x29, #-0x98]
               	fmov	d1, #12.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc8
               	ldur	d0, [x29, #-0xc8]
               	ldur	d1, [x29, #-0xd0]
               	fmadd	d0, d0, d0, d1
               	fmov	d1, #14.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xc8]
               	fneg	d1, d0
               	ldur	d2, [x29, #-0xd0]
               	fmadd	d0, d1, d0, d2
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x1, x29, #0xb8
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	stur	d0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	fsqrt	d0, d16
               	stur	d0, [x29, #-0xb8]
               	sub	x0, x29, #0xb8
               	ldur	x1, [x29, #-0xb8]
               	stur	x1, [x29, #-0x98]
               	ldur	d0, [x29, #-0x98]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xd0
               	sub	x2, x29, #0xc8
               	sub	x3, x29, #0xc0
               	ldr	x16, [x1]
               	str	x16, [x3]
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmax	d0, d16, d17
               	stur	d0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	fneg	d0, d16
               	stur	d0, [x29, #-0xb8]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0x98]
               	ldur	d0, [x29, #-0x98]
               	fmov	d1, #-10.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	stur	s0, [x29, #-0x80]
               	str	q3, [sp, #0x20]
               	ldur	s0, [x29, #-0x80]
               	str	s0, [sp, #0x28]
               	ldr	q0, [sp, #0x20]
               	fcmeq	v1.4s, v3.4s, v0.4s
               	str	q1, [sp, #0x20]
               	ldr	w0, [sp, #0x20]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x24]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x28]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x2c]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v1.4s, v3.4s, v4.4s
               	str	q1, [sp, #0x20]
               	ldr	w0, [sp, #0x20]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x24]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x28]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x2c]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v3.4s, v4.4s
               	str	q1, [sp, #0x20]
               	ldr	w0, [sp, #0x20]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x24]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x28]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x2c]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v1.4s, v4.4s, v3.4s
               	str	q1, [sp, #0x20]
               	ldr	w0, [sp, #0x20]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x24]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x28]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x2c]
               	cbz	w0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v4.4s, v3.4s
               	str	q1, [sp, #0x20]
               	ldr	w0, [sp, #0x20]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x24]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x28]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x2c]
               	cbz	w0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v0.4s, v0.4s, v4.4s
               	str	q0, [sp, #0x20]
               	ldr	s1, [sp, #0x28]
               	str	q0, [sp, #0x20]
               	ldr	s2, [sp, #0x28]
               	fcmp	s1, s2
               	b.eq	<addr>
               	str	q0, [sp, #0x20]
               	ldr	s0, [sp, #0x20]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	fcmgt	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x20]
               	ldr	x0, [sp, #0x20]
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x28]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xd0]
               	fcmp	d0, d0
               	cset	x0, eq
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xd0]
               	ldur	d1, [x29, #-0xc8]
               	fcmp	d0, d1
               	cset	x0, gt
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xd0]
               	ldur	d1, [x29, #-0xc8]
               	fcmp	d0, d1
               	cset	x0, ls
               	neg	x0, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xd8
               	sub	x2, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0xb8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmeq	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0x98]
               	ldur	w0, [x29, #-0x98]
               	cbnz	w0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x1, x29, #0xb8
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xb8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmge	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0x98]
               	ldur	w0, [x29, #-0x94]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v0.4s, v3.4s, v4.4s
               	str	q0, [sp, #0xb0]
               	str	q3, [sp, #0xc0]
               	str	q4, [sp, #0xd0]
               	ldr	q0, [sp, #0xb0]
               	ldr	q1, [sp, #0xc0]
               	ldr	q2, [sp, #0xd0]
               	bsl	v0.16b, v1.16b, v2.16b
               	fmov	s1, #1.50000000
               	fmov	s2, #4.00000000
               	fmov	s5, #3.25000000
               	fmov	s6, #8.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	fcmgt	v0.2d, v1.2d, v0.2d
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	str	q0, [sp, #0xb0]
               	str	q1, [sp, #0xc0]
               	str	q2, [sp, #0xd0]
               	ldr	q0, [sp, #0xb0]
               	ldr	q1, [sp, #0xc0]
               	ldr	q2, [sp, #0xd0]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [sp, #0x30]
               	ldr	d1, [sp, #0x30]
               	fmov	d2, #2.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x40]
               	ldr	d0, [sp, #0x48]
               	fmov	d1, #-0.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	fcvtzs	v1.4s, v0.4s
               	str	q1, [sp, #0x20]
               	ldrsw	x0, [sp, #0x20]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x24]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x28]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x2c]
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzu	v0.4s, v0.4s
               	str	q0, [sp, #0x20]
               	ldr	w0, [sp, #0x20]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x24]
               	eor	x0, x0, #0x2
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x28]
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x2c]
               	cbz	w0, <addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1a0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x20]
               	scvtf	v0.4s, v0.4s
               	fmov	s1, #-3.00000000
               	movi	d2, #0000000000000000
               	fmov	s5, #7.00000000
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s6, w16
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x170
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x50]
               	ucvtf	v0.4s, v0.4s
               	mov	x16, #0x4f800000        // =1333788672
               	fmov	s1, w16
               	fmov	s2, #1.00000000
               	fmov	s5, #2.00000000
               	fmov	s6, #3.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe0
               	sub	x1, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	fcvtzs	v0.2s, v16.2s
               	stur	d0, [x29, #-0xb8]
               	ldur	x0, [x29, #-0xb8]
               	sub	x1, x29, #0x58
               	stur	x0, [x29, #-0x58]
               	ldursw	x0, [x29, #-0x58]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x54]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	scvtf	v0.2s, v16.2s
               	stur	d0, [x29, #-0xb8]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xa0]
               	ldur	s0, [x29, #-0x9c]
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	fcvtzs	v0.2d, v0.2d
               	str	q0, [sp, #0x20]
               	ldr	x0, [sp, #0x20]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	ldr	x0, [sp, #0x28]
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1a0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x20]
               	ucvtf	v0.2d, v0.2d
               	str	q0, [sp, #0x20]
               	ldr	d1, [sp, #0x20]
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d2, x16
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xd0]
               	fcvtzs	x0, d0
               	cmp	x0, #0xa
               	b.ne	<addr>
               	fmov	d0, #-7.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp, #0x90]
               	sub	x0, x29, #0xb0
               	str	xzr, [x0]
               	ldr	s0, [sp, #0x98]
               	stur	s0, [x29, #-0xb0]
               	ldr	s0, [sp, #0x9c]
               	stur	s0, [x29, #-0xac]
               	ldur	x0, [x29, #-0xb0]
               	fmov	d16, x0
               	fcvtl	v0.2d, v16.2s
               	str	q0, [sp, #0x20]
               	ldr	d1, [sp, #0x20]
               	fmov	d2, #3.25000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtl2	v0.2d, v3.4s
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp]
               	fcvtn	v0.2s, v0.2d
               	stur	d0, [x29, #-0x98]
               	sub	x1, x29, #0x98
               	ldur	x2, [x29, #-0x98]
               	sub	x0, x29, #0xa8
               	stur	x2, [x29, #-0xa8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x98]
               	fmov	s1, #10.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x94]
               	fmov	s1, #-0.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp, #0xa0]
               	str	xzr, [x0]
               	ldr	s0, [sp, #0xa0]
               	stur	s0, [x29, #-0xa8]
               	ldr	s0, [sp, #0xa4]
               	stur	s0, [x29, #-0xa4]
               	ldur	x0, [x29, #-0xa8]
               	stur	x0, [x29, #-0x98]
               	ldr	q1, [sp, #0x10]
               	sub	x0, x29, #0x1a0
               	stp	xzr, xzr, [x0]
               	ldur	s0, [x29, #-0x98]
               	str	s0, [sp, #0x20]
               	ldur	s0, [x29, #-0x94]
               	str	s0, [sp, #0x24]
               	str	wzr, [sp, #0x28]
               	str	wzr, [sp, #0x2c]
               	ldr	q0, [sp, #0x20]
               	str	q0, [sp, #0xb0]
               	str	q1, [sp, #0xc0]
               	ldr	q0, [sp, #0xb0]
               	ldr	q1, [sp, #0xc0]
               	fcvtn2	v0.4s, v1.2d
               	str	q0, [sp, #0x20]
               	ldr	q0, [sp, #0x20]
               	fmov	s1, #1.50000000
               	fmov	s2, #2.00000000
               	fmov	s5, #-2.00000000
               	fmov	s6, #4.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s5
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp, #0x90]
               	sub	x0, x29, #0xb0
               	str	xzr, [x0]
               	ldr	s0, [sp, #0x98]
               	stur	s0, [x29, #-0xb0]
               	ldr	s0, [sp, #0x9c]
               	stur	s0, [x29, #-0xac]
               	ldur	x0, [x29, #-0xb0]
               	str	q4, [sp, #0xa0]
               	sub	x1, x29, #0xa8
               	str	xzr, [x1]
               	ldr	s0, [sp, #0xa0]
               	stur	s0, [x29, #-0xa8]
               	ldr	s0, [sp, #0xa4]
               	stur	s0, [x29, #-0xa4]
               	ldur	x1, [x29, #-0xa8]
               	stur	x0, [x29, #-0xa8]
               	stur	x1, [x29, #-0x98]
               	sub	x0, x29, #0x1a0
               	stp	xzr, xzr, [x0]
               	ldur	s0, [x29, #-0xa8]
               	str	s0, [sp, #0x20]
               	ldur	s0, [x29, #-0xa4]
               	str	s0, [sp, #0x24]
               	ldur	s0, [x29, #-0x98]
               	str	s0, [sp, #0x28]
               	ldur	s0, [x29, #-0x94]
               	str	s0, [sp, #0x2c]
               	ldr	q0, [sp, #0x20]
               	fmov	s1, #3.25000000
               	fmov	s2, #8.00000000
               	fmov	s3, #0.50000000
               	fmov	s4, #4.00000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [sp, #0x8]
               	ldr	d1, [sp, #0x10]
               	sub	x0, x29, #0x1a0
               	stp	xzr, xzr, [x0]
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	ldr	q0, [sp, #0x20]
               	str	q0, [sp, #0x20]
               	ldr	d1, [sp, #0x20]
               	fmov	d2, #-0.25000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xbf000000        // =3204448256
               	str	x16, [sp, #0xb0]
               	ldr	d1, [sp, #0xb0]
               	dup	v0.4s, v1.s[0]
               	fmov	s1, #-0.50000000
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x90]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8c]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x88]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x84]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x401a000000000000 // =4619004367821864960
               	str	x16, [sp, #0xb0]
               	ldr	d1, [sp, #0xb0]
               	dup	v0.2d, v1.d[0]
               	str	q0, [sp, #0x60]
               	ldr	d0, [sp, #0x68]
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x41100000        // =1091567616
               	str	x16, [sp, #0xb0]
               	ldr	d1, [sp, #0xb0]
               	dup	v0.2s, v1.s[0]
               	stur	d0, [x29, #-0xb8]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	sub	x16, x29, #0xa8
               	str	d16, [x16]
               	ldr	q0, [sp, #0x10]
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0xc0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	sub	x16, x29, #0xa0
               	str	d16, [x16]
               	ldur	s1, [x29, #-0xa8]
               	fmov	s0, #9.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0xa4]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xa0]
               	fmov	d1, #10.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x98]
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3f800000        // =1065353216
               	str	x16, [sp, #0xb0]
               	ldr	d1, [sp, #0xb0]
               	dup	v0.4s, v1.s[0]
               	str	q0, [sp, #0x20]
               	ldr	w0, [sp, #0x2c]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x150
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x70]
               	str	q0, [sp, #0x80]
               	ldr	d0, [sp, #0x80]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1c0
               	ldp	x29, x30, [sp], #0x10
               	ret
