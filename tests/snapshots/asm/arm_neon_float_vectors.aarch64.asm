
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

<vfma_f32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	d0, [x29, #-0x8]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x18]
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x18]
               	sub	x16, x29, #0x8
               	str	x16, [sp]
               	fmov	d16, x1
               	str	d16, [sp, #0x8]
               	fmov	d16, x2
               	str	d16, [sp, #0x10]
               	ldr	x16, [sp]
               	ldr	d0, [x16]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	fmla	v0.2s, v1.2s, v2.2s
               	ldr	x16, [sp]
               	str	d0, [x16]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	d0, [x16]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q16, [x16]
               	str	q16, [sp, #0x100]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q16, [x16]
               	str	q16, [sp, #0xf0]
               	sub	x16, x29, #0x98
               	str	x16, [sp, #0xc0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0xc8]
               	ldr	x0, [sp, #0xc8]
               	ldr	d0, [x0]
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x98]
               	stur	x0, [x29, #-0xe8]
               	sub	x16, x29, #0x98
               	str	x16, [sp, #0xc0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0xc8]
               	ldr	x0, [sp, #0xc8]
               	ldr	d0, [x0]
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0x98]
               	stur	x0, [x29, #-0xe0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	str	q0, [sp, #0x10]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	str	q0, [sp, #0x20]
               	sub	x16, x29, #0x98
               	str	x16, [sp, #0xc0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0xc8]
               	ldr	x0, [sp, #0xc8]
               	ldr	d0, [x0]
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x21, [x29, #-0x98]
               	stur	x21, [x29, #-0xd8]
               	sub	x16, x29, #0x98
               	str	x16, [sp, #0xc0]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0xc8]
               	ldr	x0, [sp, #0xc8]
               	ldr	d0, [x0]
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x20, [x29, #-0x98]
               	stur	x20, [x29, #-0xd0]
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fadd	v1.4s, v16.4s, v17.4s
               	fmov	s0, #2.00000000
               	fmov	s2, #2.25000000
               	fmov	s3, #10.00000000
               	sub	x16, x29, #0xa0
               	str	q1, [x16]
               	ldur	s1, [x29, #-0xa0]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x9c]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fsub	v0.4s, v16.4s, v17.4s
               	fmov	s1, #1.00000000
               	fmov	s2, #6.00000000
               	fmov	s3, #-6.00000000
               	fmov	s4, #4.25000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s4
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fmul	v0.4s, v16.4s, v17.4s
               	fmov	s1, #0.75000000
               	fmov	s2, #-8.00000000
               	fmov	s3, #-3.25000000
               	fmov	s4, #16.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fdiv	v0.4s, v16.4s, v17.4s
               	fmov	s1, #3.00000000
               	fmov	s2, #-0.50000000
               	fmov	s3, #-3.25000000
               	fmov	s4, #4.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fmax	v0.4s, v16.4s, v17.4s
               	fmov	s1, #1.50000000
               	fmov	s2, #4.00000000
               	fmov	s3, #3.25000000
               	fmov	s4, #8.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fmin	v0.4s, v16.4s, v17.4s
               	fmov	s1, #0.50000000
               	fmov	s2, #2.00000000
               	fmov	s3, #-2.00000000
               	fmov	s4, #-1.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s4
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	fabs	v0.4s, v16.4s
               	fmov	s1, #1.50000000
               	fmov	s2, #2.00000000
               	fmov	s3, #3.25000000
               	fmov	s4, #8.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	fneg	v0.4s, v16.4s
               	fmov	s1, #-1.50000000
               	fmov	s2, #2.00000000
               	fmov	s3, #-3.25000000
               	fmov	s4, #-8.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0xf0]
               	ldr	q17, [sp, #0xf0]
               	fmul	v0.4s, v16.4s, v17.4s
               	fsqrt	v0.4s, v0.4s
               	fmov	s1, #0.50000000
               	fmov	s2, #4.00000000
               	fmov	s3, #1.00000000
               	fmov	s4, #2.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0xc0]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0xd0]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0xe0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	ldr	q2, [sp, #0xe0]
               	fmla	v0.4s, v1.4s, v2.4s
               	fmov	s1, #1.75000000
               	fmov	s2, #14.00000000
               	fmov	s3, #4.25000000
               	fmov	s4, #12.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0xc0]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0xd0]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0xe0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	ldr	q2, [sp, #0xe0]
               	fmls	v0.4s, v1.4s, v2.4s
               	fmov	s1, #1.25000000
               	fmov	s2, #-18.00000000
               	fmov	s3, #2.25000000
               	fmov	s4, #4.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0xe8]
               	ldur	x2, [x29, #-0xe0]
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	fmov	d16, x2
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fadd	v0.2s, v1.2s, v2.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x1, [x29, #-0xb8]
               	sub	x0, x29, #0xc0
               	stur	x1, [x29, #-0xc0]
               	sub	x1, x29, #0xb0
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s1, [x29, #-0xb0]
               	fmov	s0, #2.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	sub	x1, x29, #0xa8
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s1, [x29, #-0xa4]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xe8
               	sub	x7, x29, #0xe0
               	ldr	d0, [x0]
               	ldr	d1, [x7]
               	ldr	d2, [x7]
               	bl	<addr>
               	stur	d0, [x29, #-0x80]
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0xa8
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0xa8]
               	fmov	s1, #1.75000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0xa4]
               	fmov	s1, #14.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0xe8]
               	ldur	x2, [x29, #-0xe0]
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	fmov	d16, x2
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fmul	v0.2s, v1.2s, v2.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xa8]
               	ldur	s0, [x29, #-0xa4]
               	fmov	s1, #-8.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x1, [x29, #-0xe8]
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc8]
               	fabs	v0.2s, v1.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xa8]
               	ldur	s0, [x29, #-0xa4]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp, #0x20]
               	str	q0, [sp, #0xc0]
               	str	q1, [sp, #0xd0]
               	str	q1, [sp, #0xe0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	ldr	q2, [sp, #0xe0]
               	fmla	v0.2d, v1.2d, v2.2d
               	str	q0, [sp, #0x30]
               	ldr	d1, [sp, #0x30]
               	fmov	d2, #14.50000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	adrp	x16, <addr>
               	ldr	d1, [x16, #0x90]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp, #0x20]
               	fdiv	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x30]
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp, #0x20]
               	fsub	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	fmov	d1, #-4.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x21
               	str	d16, [sp, #0xc8]
               	fmov	d16, x20
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fadd	d0, d1, d2
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xa8]
               	ldur	d0, [x29, #-0xa8]
               	fmov	d1, #12.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xd0]
               	ldur	d1, [x29, #-0xd8]
               	fmadd	d0, d0, d0, d1
               	fmov	d1, #14.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xd0]
               	fneg	d1, d0
               	ldur	d2, [x29, #-0xd8]
               	fmadd	d0, d1, d0, d2
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x20
               	str	d16, [sp, #0xc8]
               	fmov	d16, x20
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fmul	d0, d1, d2
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x1, [x29, #-0xb8]
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc8]
               	fsqrt	d0, d1
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xa8]
               	ldur	d0, [x29, #-0xa8]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x21
               	str	d16, [sp, #0xc8]
               	fmov	d16, x20
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fmax	d0, d1, d2
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x1, [x29, #-0xb8]
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc8]
               	fneg	d0, d1
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xa8]
               	ldur	d0, [x29, #-0xa8]
               	fmov	d1, #-10.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	stur	s0, [x29, #-0x90]
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0x30]
               	ldur	s0, [x29, #-0x90]
               	str	s0, [sp, #0x38]
               	ldr	q0, [sp, #0x30]
               	ldr	q16, [sp, #0x100]
               	fcmeq	v1.4s, v16.4s, v0.4s
               	str	q1, [sp, #0x30]
               	ldr	w0, [sp, #0x30]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x34]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x38]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x3c]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fcmge	v1.4s, v16.4s, v17.4s
               	str	q1, [sp, #0x30]
               	ldr	w0, [sp, #0x30]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x34]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x38]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x3c]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fcmgt	v1.4s, v16.4s, v17.4s
               	str	q1, [sp, #0x30]
               	ldr	w0, [sp, #0x30]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x34]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x38]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x3c]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0xf0]
               	ldr	q17, [sp, #0x100]
               	fcmge	v1.4s, v16.4s, v17.4s
               	str	q1, [sp, #0x30]
               	ldr	w0, [sp, #0x30]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x34]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x38]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x3c]
               	cbz	w0, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0xf0]
               	ldr	q17, [sp, #0x100]
               	fcmgt	v1.4s, v16.4s, v17.4s
               	str	q1, [sp, #0x30]
               	ldr	w0, [sp, #0x30]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x34]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x38]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x3c]
               	cbz	w0, <addr>
               	mov	x0, #0x1b               // =27
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0xf0]
               	fmax	v0.4s, v0.4s, v16.4s
               	str	q0, [sp, #0x30]
               	ldr	s1, [sp, #0x38]
               	str	q0, [sp, #0x30]
               	ldr	s2, [sp, #0x38]
               	fcmp	s1, s2
               	b.eq	<addr>
               	str	q0, [sp, #0x30]
               	ldr	s0, [sp, #0x30]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp, #0x20]
               	fcmgt	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x38]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xd8]
               	fcmp	d0, d0
               	cset	x0, eq
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xd8]
               	ldur	d1, [x29, #-0xd0]
               	fcmp	d0, d1
               	cset	x0, gt
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xd8]
               	ldur	d1, [x29, #-0xd0]
               	fcmp	d0, d1
               	cset	x0, ls
               	neg	x0, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0xe8]
               	ldur	x2, [x29, #-0xe0]
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	fmov	d16, x2
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fcmeq	v0.2s, v1.2s, v2.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xa8]
               	ldur	w0, [x29, #-0xa8]
               	cbnz	w0, <addr>
               	ldur	x1, [x29, #-0xe8]
               	sub	x16, x29, #0xb8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	fmov	d16, x1
               	str	d16, [sp, #0xd0]
               	ldr	d1, [sp, #0xc8]
               	ldr	d2, [sp, #0xd0]
               	fcmge	v0.2s, v1.2s, v2.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xa8]
               	ldur	w0, [x29, #-0xa4]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	ldr	q17, [sp, #0xf0]
               	fcmgt	v0.4s, v16.4s, v17.4s
               	str	q0, [sp, #0xc0]
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0xd0]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0xe0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	ldr	q2, [sp, #0xe0]
               	bsl	v0.16b, v1.16b, v2.16b
               	fmov	s1, #1.50000000
               	fmov	s2, #4.00000000
               	fmov	s3, #3.25000000
               	fmov	s4, #8.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x10]
               	ldr	q1, [sp, #0x20]
               	fcmgt	v0.2d, v1.2d, v0.2d
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	str	q0, [sp, #0xc0]
               	str	q1, [sp, #0xd0]
               	str	q2, [sp, #0xe0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	ldr	q2, [sp, #0xe0]
               	bsl	v0.16b, v1.16b, v2.16b
               	str	q0, [sp, #0x40]
               	ldr	d1, [sp, #0x40]
               	fmov	d2, #2.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x50]
               	ldr	d0, [sp, #0x58]
               	fmov	d1, #-0.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	fcvtzs	v1.4s, v0.4s
               	str	q1, [sp, #0x30]
               	ldrsw	x0, [sp, #0x30]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x34]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x38]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	w0, w17
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x3c]
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzu	v0.4s, v0.4s
               	str	q0, [sp, #0x30]
               	ldr	w0, [sp, #0x30]
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x34]
               	eor	x0, x0, #0x2
               	cbnz	w0, <addr>
               	ldr	w0, [sp, #0x38]
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldr	w0, [sp, #0x3c]
               	cbz	w0, <addr>
               	mov	x0, #0x23               // =35
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1d0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x30]
               	scvtf	v0.4s, v0.4s
               	fmov	s1, #-3.00000000
               	movi	d2, #0000000000000000
               	fmov	s3, #7.00000000
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s4, w16
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1a0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x60]
               	ucvtf	v0.4s, v0.4s
               	mov	x16, #0x4f800000        // =1333788672
               	fmov	s1, w16
               	fmov	s2, #1.00000000
               	fmov	s3, #2.00000000
               	fmov	s4, #3.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0xe8]
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc8]
               	fcvtzs	v0.2s, v1.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x1, [x29, #-0xc8]
               	stur	x1, [x29, #-0x58]
               	ldursw	x0, [x29, #-0x58]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x54]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0xc0]
               	fmov	d16, x1
               	str	d16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc8]
               	scvtf	v0.2s, v1.2s
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xb0]
               	ldur	s0, [x29, #-0xac]
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x27               // =39
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q0, [sp, #0x10]
               	fcvtzs	v0.2d, v0.2d
               	str	q0, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	ldr	x0, [sp, #0x38]
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1d0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x30]
               	ucvtf	v0.2d, v0.2d
               	str	q0, [sp, #0x30]
               	ldr	d1, [sp, #0x30]
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d2, x16
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0xd8]
               	fcvtzs	x0, d0
               	cmp	x0, #0xa
               	b.ne	<addr>
               	fmov	d0, #-7.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0xa0]
               	sub	x0, x29, #0xc0
               	str	xzr, [x0]
               	ldr	s0, [sp, #0xa8]
               	stur	s0, [x29, #-0xc0]
               	ldr	s0, [sp, #0xac]
               	stur	s0, [x29, #-0xbc]
               	ldur	x0, [x29, #-0xc0]
               	fmov	d16, x0
               	fcvtl	v0.2d, v16.2s
               	str	q0, [sp, #0x30]
               	ldr	d1, [sp, #0x30]
               	fmov	d2, #3.25000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	fcvtl2	v0.2d, v16.4s
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xa8
               	str	x16, [sp, #0xc0]
               	sub	x16, x29, #0x1f0
               	str	x16, [sp, #0xc8]
               	ldr	x16, [sp, #0xc8]
               	ldr	q1, [x16]
               	fcvtn	v0.2s, v1.2d
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	sub	x1, x29, #0xa8
               	ldur	x2, [x29, #-0xa8]
               	sub	x0, x29, #0xb8
               	stur	x2, [x29, #-0xb8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0xa8]
               	fmov	s1, #10.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0xa4]
               	fmov	s1, #-0.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0xb0]
               	str	xzr, [x0]
               	ldr	s0, [sp, #0xb0]
               	stur	s0, [x29, #-0xb8]
               	ldr	s0, [sp, #0xb4]
               	stur	s0, [x29, #-0xb4]
               	ldur	x0, [x29, #-0xb8]
               	stur	x0, [x29, #-0xa8]
               	ldr	q1, [sp, #0x20]
               	sub	x0, x29, #0x1d0
               	stp	xzr, xzr, [x0]
               	ldur	s0, [x29, #-0xa8]
               	str	s0, [sp, #0x30]
               	ldur	s0, [x29, #-0xa4]
               	str	s0, [sp, #0x34]
               	str	wzr, [sp, #0x38]
               	str	wzr, [sp, #0x3c]
               	ldr	q0, [sp, #0x30]
               	str	q0, [sp, #0xc0]
               	str	q1, [sp, #0xd0]
               	ldr	q0, [sp, #0xc0]
               	ldr	q1, [sp, #0xd0]
               	fcvtn2	v0.4s, v1.2d
               	str	q0, [sp, #0x30]
               	ldr	q0, [sp, #0x30]
               	fmov	s1, #1.50000000
               	fmov	s2, #2.00000000
               	fmov	s3, #-2.00000000
               	fmov	s4, #4.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x2e               // =46
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0xa0]
               	sub	x0, x29, #0xc0
               	str	xzr, [x0]
               	ldr	s0, [sp, #0xa8]
               	stur	s0, [x29, #-0xc0]
               	ldr	s0, [sp, #0xac]
               	stur	s0, [x29, #-0xbc]
               	ldur	x0, [x29, #-0xc0]
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0xb0]
               	sub	x1, x29, #0xb8
               	str	xzr, [x1]
               	ldr	s0, [sp, #0xb0]
               	stur	s0, [x29, #-0xb8]
               	ldr	s0, [sp, #0xb4]
               	stur	s0, [x29, #-0xb4]
               	ldur	x1, [x29, #-0xb8]
               	stur	x0, [x29, #-0xb8]
               	stur	x1, [x29, #-0xa8]
               	sub	x0, x29, #0x1d0
               	stp	xzr, xzr, [x0]
               	ldur	s0, [x29, #-0xb8]
               	str	s0, [sp, #0x30]
               	ldur	s0, [x29, #-0xb4]
               	str	s0, [sp, #0x34]
               	ldur	s0, [x29, #-0xa8]
               	str	s0, [sp, #0x38]
               	ldur	s0, [x29, #-0xa4]
               	str	s0, [sp, #0x3c]
               	ldr	q0, [sp, #0x30]
               	fmov	s1, #3.25000000
               	fmov	s2, #8.00000000
               	fmov	s3, #0.50000000
               	fmov	s4, #4.00000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x2f               // =47
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	sub	x0, x29, #0x1d0
               	stp	xzr, xzr, [x0]
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	ldr	q0, [sp, #0x30]
               	str	q0, [sp, #0x30]
               	ldr	d1, [sp, #0x30]
               	fmov	d2, #-0.25000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	str	q0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xbf000000        // =3204448256
               	str	x16, [sp, #0xc0]
               	ldr	d1, [sp, #0xc0]
               	dup	v0.4s, v1.s[0]
               	fmov	s1, #-0.50000000
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	ldur	s0, [x29, #-0xa0]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x9c]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x98]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x94]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x31               // =49
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x401a000000000000 // =4619004367821864960
               	str	x16, [sp, #0xc0]
               	ldr	d1, [sp, #0xc0]
               	dup	v0.2d, v1.d[0]
               	str	q0, [sp, #0x70]
               	ldr	d0, [sp, #0x78]
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0xc8
               	str	x16, [sp, #0xc0]
               	mov	x16, #0x41100000        // =1091567616
               	str	x16, [sp, #0xc8]
               	ldr	d1, [sp, #0xc8]
               	dup	v0.2s, v1.s[0]
               	ldr	x16, [sp, #0xc0]
               	str	d0, [x16]
               	ldur	x0, [x29, #-0xc8]
               	fmov	d16, x0
               	sub	x16, x29, #0xb8
               	str	d16, [x16]
               	ldr	q0, [sp, #0x20]
               	sub	x16, x29, #0xb0
               	str	q0, [x16]
               	fmov	d16, x21
               	sub	x16, x29, #0xb0
               	str	d16, [x16]
               	ldur	s1, [x29, #-0xb8]
               	fmov	s0, #9.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0xb4]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xb0]
               	fmov	d1, #10.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0xa8]
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3f800000        // =1065353216
               	str	x16, [sp, #0xc0]
               	ldr	d1, [sp, #0xc0]
               	dup	v0.4s, v1.s[0]
               	str	q0, [sp, #0x30]
               	ldr	w0, [sp, #0x3c]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x180
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	q0, [sp, #0x80]
               	str	q0, [sp, #0x90]
               	ldr	d0, [sp, #0x90]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
