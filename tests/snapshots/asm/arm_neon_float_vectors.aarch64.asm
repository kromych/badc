
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
               	sub	sp, sp, #0x90
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q3, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q4, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d20, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d21, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q19, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q5, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d6, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d7, [x16]
               	fadd	v1.4s, v3.4s, v4.4s
               	fmov	s0, #2.00000000
               	fmov	s2, #2.25000000
               	fmov	s22, #10.00000000
               	sub	x16, x29, #0x30
               	str	q1, [x16]
               	ldur	s1, [x29, #-0x30]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x2c]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s22
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v0.4s, v3.4s, v4.4s
               	fmov	s1, #1.00000000
               	fmov	s2, #6.00000000
               	fmov	s22, #-6.00000000
               	fmov	s23, #4.25000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s23
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v0.4s, v3.4s, v4.4s
               	fmov	s1, #0.75000000
               	fmov	s2, #-8.00000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #16.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v0.4s, v3.4s, v4.4s
               	fmov	s1, #3.00000000
               	fmov	s2, #-0.50000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v0.4s, v3.4s, v4.4s
               	fmov	s1, #1.50000000
               	fmov	s2, #4.00000000
               	fmov	s22, #3.25000000
               	fmov	s23, #8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmin	v0.4s, v3.4s, v4.4s
               	fmov	s1, #0.50000000
               	fmov	s2, #2.00000000
               	fmov	s22, #-2.00000000
               	fmov	s23, #-1.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s23
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fabs	v0.4s, v3.4s
               	fmov	s1, #1.50000000
               	fmov	s2, #2.00000000
               	fmov	s22, #3.25000000
               	fmov	s23, #8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	v0.4s, v3.4s
               	fmov	s1, #-1.50000000
               	fmov	s2, #2.00000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #-8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v0.4s, v4.4s, v4.4s
               	fsqrt	v0.4s, v0.4s
               	fmov	s1, #0.50000000
               	fmov	s2, #4.00000000
               	fmov	s22, #1.00000000
               	fmov	s23, #2.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp]
               	str	q4, [sp, #0x10]
               	str	q4, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	fmla	v0.4s, v1.4s, v2.4s
               	fmov	s1, #1.75000000
               	fmov	s2, #14.00000000
               	fmov	s22, #4.25000000
               	fmov	s23, #12.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q3, [sp]
               	str	q4, [sp, #0x10]
               	str	q4, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	fmls	v0.4s, v1.4s, v2.4s
               	fmov	s1, #1.25000000
               	fmov	s2, #-18.00000000
               	fmov	s22, #2.25000000
               	fmov	s23, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d20, [x29, #-0x50]
               	stur	d21, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	fmov	d16, x0
               	mov	s0, v16.s[0]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	fmov	d16, x0
               	mov	s0, v16.s[1]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d20, [x29, #-0x50]
               	stur	d21, [x29, #-0x48]
               	stur	d21, [x29, #-0x28]
               	ldur	x1, [x29, #-0x48]
               	ldur	x2, [x29, #-0x28]
               	ldur	d0, [x29, #-0x50]
               	str	d0, [sp]
               	fmov	d16, x1
               	str	d16, [sp, #0x8]
               	fmov	d16, x2
               	str	d16, [sp, #0x10]
               	ldr	d0, [sp]
               	ldr	d1, [sp, #0x8]
               	ldr	d2, [sp, #0x10]
               	fmla	v0.2s, v1.2s, v2.2s
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x38]
               	mov	s1, v0.s[0]
               	fmov	s2, #1.75000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[1]
               	fmov	s1, #14.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d20, [x29, #-0x50]
               	stur	d21, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x38]
               	mov	s0, v0.s[1]
               	fmov	s1, #-8.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	stur	d20, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	fabs	v0.2s, v16.2s
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x38]
               	mov	s0, v0.s[1]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	q19, [sp]
               	str	q5, [sp, #0x10]
               	str	q5, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	fmla	v0.2d, v1.2d, v2.2d
               	mov	d1, v0.d[0]
               	fmov	d2, #14.50000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	adrp	x16, <addr>
               	ldr	d1, [x16, #0x90]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v0.2d, v19.2d, v5.2d
               	mov	d0, v0.d[0]
               	fmov	d1, #5.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v0.2d, v19.2d, v5.2d
               	mov	d0, v0.d[1]
               	fmov	d1, #-4.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d6, [x29, #-0x50]
               	stur	d7, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x38]
               	mov	d0, v0.d[0]
               	fmov	d1, #12.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmadd	d0, d7, d7, d6
               	mov	d0, v0.d[0]
               	fmov	d1, #14.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	d0, d7
               	fmadd	d0, d0, d7, d6
               	mov	d0, v0.d[0]
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d7, [x29, #-0x50]
               	stur	d7, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	fsqrt	d0, d16
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x38]
               	mov	d0, v0.d[0]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d6, [x29, #-0x50]
               	stur	d7, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fmax	d0, d16, d17
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	fneg	d0, d16
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x38]
               	mov	d0, v0.d[0]
               	fmov	d1, #-10.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	stur	s0, [x29, #-0x20]
               	ldur	s1, [x29, #-0x20]
               	str	q3, [sp]
               	str	d1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	mov	v0.s[2], v1.s[0]
               	fcmeq	v1.4s, v3.4s, v0.4s
               	mov	w0, v1.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[3]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v1.4s, v3.4s, v4.4s
               	mov	w0, v1.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[1]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[2]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[3]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v3.4s, v4.4s
               	mov	w0, v1.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[1]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[2]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[3]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v1.4s, v4.4s, v3.4s
               	mov	w0, v1.s[0]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[3]
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v4.4s, v3.4s
               	mov	w0, v1.s[0]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v1.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v1.s[3]
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v0.4s, v0.4s, v4.4s
               	mov	s1, v0.s[2]
               	mov	s2, v0.s[2]
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	s0, v0.s[0]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v0.2d, v5.2d, v19.2d
               	mov	x0, v0.d[0]
               	cbnz	x0, <addr>
               	mov	x0, v0.d[1]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d6, d6
               	cset	x0, eq
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	fcmpe	d6, d7
               	cset	x0, gt
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	fcmpe	d6, d7
               	cset	x0, ls
               	neg	x0, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d20, [x29, #-0x50]
               	stur	d21, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmeq	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x38]
               	ldur	w0, [x29, #-0x38]
               	cbnz	w0, <addr>
               	stur	d20, [x29, #-0x50]
               	stur	d20, [x29, #-0x48]
               	ldur	x0, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmge	v0.2s, v16.2s, v17.2s
               	stur	d0, [x29, #-0x28]
               	ldur	x0, [x29, #-0x28]
               	stur	x0, [x29, #-0x38]
               	ldur	w0, [x29, #-0x34]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v0.4s, v3.4s, v4.4s
               	str	q0, [sp]
               	str	q3, [sp, #0x10]
               	str	q4, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	fmov	s1, #1.50000000
               	fmov	s2, #4.00000000
               	fmov	s7, #3.25000000
               	fmov	s21, #8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s7
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v0.2d, v5.2d, v19.2d
               	str	q0, [sp]
               	str	q19, [sp, #0x10]
               	str	q5, [sp, #0x20]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	ldr	q2, [sp, #0x20]
               	bsl	v0.16b, v1.16b, v2.16b
               	mov	d1, v0.d[0]
               	fmov	d2, #2.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #-0.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q1, [x16]
               	fcvtzs	v0.4s, v1.4s
               	smov	x0, v0.s[0]
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzu	v0.4s, v1.4s
               	mov	w0, v0.s[0]
               	cbnz	x0, <addr>
               	mov	w0, v0.s[1]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	w0, v0.s[2]
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v0.s[3]
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	scvtf	v0.4s, v0.4s
               	fmov	s1, #-3.00000000
               	movi	d2, #0000000000000000
               	fmov	s7, #7.00000000
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s21, w16
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s7
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ucvtf	v0.4s, v0.4s
               	mov	x16, #0x4f800000        // =1333788672
               	fmov	s1, w16
               	fmov	s2, #1.00000000
               	fmov	s7, #2.00000000
               	fmov	s21, #3.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s7
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d20, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	fcvtzs	v0.2s, v16.2s
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	sub	x1, x29, #0x18
               	stur	x0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x14]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	scvtf	v0.2s, v16.2s
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	fmov	d16, x0
               	mov	s0, v16.s[1]
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	v0.2d, v19.2d
               	mov	x0, v0.d[0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ucvtf	v0.2d, v0.2d
               	mov	d1, v0.d[0]
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d2, x16
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	x0, d6
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x16, #-0x3fe4000000000000 // =-4603804719079489536
               	str	x16, [sp]
               	ldr	d1, [sp]
               	mov	d0, v1.d[0]
               	fmov	d1, #-7.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v3.d[1]
               	fcvtl	v0.2d, v0.2s
               	mov	d1, v0.d[0]
               	fmov	d2, #3.25000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtl2	v0.2d, v3.4s
               	mov	d0, v0.d[1]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtn	v0.2s, v19.2d
               	mov	s1, v0.s[0]
               	fmov	s2, #10.50000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	s0, v0.s[1]
               	fmov	s1, #-0.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v3.d[0]
               	stur	d0, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0x0                // =0
               	ldur	s0, [x29, #-0x28]
               	fmov	s16, s0
               	mov	v0.16b, v16.16b
               	ldur	s1, [x29, #-0x24]
               	mov	v0.s[1], v1.s[0]
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	mov	v0.s[2], v17.s[0]
               	fmov	d17, x0
               	mov	v0.s[3], v17.s[0]
               	str	q0, [sp]
               	str	q5, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	fcvtn2	v0.4s, v1.2d
               	fmov	s1, #1.50000000
               	fmov	s2, #2.00000000
               	fmov	s7, #-2.00000000
               	fmov	s20, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s7
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s20
               	b.eq	<addr>
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v3.d[1]
               	mov	d1, v4.d[0]
               	stur	d1, [x29, #-0x38]
               	ldur	x0, [x29, #-0x38]
               	fmov	d16, x0
               	zip1	v0.2d, v0.2d, v16.2d
               	fmov	s1, #3.25000000
               	fmov	s2, #8.00000000
               	fmov	s3, #0.50000000
               	fmov	s4, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v19.d[1]
               	mov	d1, v5.d[0]
               	zip1	v0.2d, v0.2d, v1.2d
               	mov	d1, v0.d[0]
               	fmov	d2, #-0.25000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0xbf000000        // =3204448256
               	str	x16, [sp]
               	ldr	d1, [sp]
               	dup	v0.4s, v1.s[0]
               	fmov	s1, #-0.50000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x31               // =49
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x401a000000000000 // =4619004367821864960
               	str	x16, [sp]
               	ldr	d1, [sp]
               	dup	v0.2d, v1.d[0]
               	mov	d0, v0.d[1]
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x16, #0x3ff0000000000000 // =4607182418800017408
               	str	x16, [sp]
               	ldr	d1, [sp]
               	fmov	d0, d1
               	stur	d0, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x28]
               	ldur	d0, [x29, #-0x28]
               	mov	d0, v0.d[0]
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x41100000        // =1091567616
               	str	x16, [sp]
               	ldr	d1, [sp]
               	dup	v0.2s, v1.s[0]
               	stur	d0, [x29, #-0x48]
               	ldur	x0, [x29, #-0x48]
               	stur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	sub	x16, x29, #0x58
               	str	d16, [x16]
               	sub	x16, x29, #0x40
               	str	q5, [x16]
               	stur	d6, [x29, #-0x50]
               	ldur	x0, [x29, #-0x50]
               	fmov	d16, x0
               	sub	x16, x29, #0x40
               	str	d16, [x16]
               	ldur	s1, [x29, #-0x58]
               	fmov	s0, #9.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x54]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x40]
               	fmov	d1, #10.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x38]
               	fmov	d1, #4.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x33               // =51
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x3f800000        // =1065353216
               	str	x16, [sp]
               	ldr	d1, [sp]
               	dup	v0.4s, v1.s[0]
               	mov	w0, v0.s[3]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	mov	d0, v0.d[0]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
