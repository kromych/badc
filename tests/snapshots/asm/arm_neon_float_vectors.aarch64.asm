
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
               	sub	sp, sp, #0x70
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q2, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q3, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d19, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d20, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q7, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q4, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d5, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d6, [x16]
               	fadd	v1.4s, v2.4s, v3.4s
               	fmov	s0, #2.00000000
               	fmov	s21, #2.25000000
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
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s22
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v0.4s, v2.4s, v3.4s
               	fmov	s1, #1.00000000
               	fmov	s21, #6.00000000
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
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v0.4s, v2.4s, v3.4s
               	fmov	s1, #0.75000000
               	fmov	s21, #-8.00000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #16.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v0.4s, v2.4s, v3.4s
               	fmov	s1, #3.00000000
               	fmov	s21, #-0.50000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v0.4s, v2.4s, v3.4s
               	fmov	s1, #1.50000000
               	fmov	s21, #4.00000000
               	fmov	s22, #3.25000000
               	fmov	s23, #8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmin	v0.4s, v2.4s, v3.4s
               	fmov	s1, #0.50000000
               	fmov	s21, #2.00000000
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
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fabs	v0.4s, v2.4s
               	fmov	s1, #1.50000000
               	fmov	s21, #2.00000000
               	fmov	s22, #3.25000000
               	fmov	s23, #8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	v0.4s, v2.4s
               	fmov	s1, #-1.50000000
               	fmov	s21, #2.00000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #-8.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v0.4s, v3.4s, v3.4s
               	fsqrt	v0.4s, v0.4s
               	fmov	s1, #0.50000000
               	fmov	s21, #4.00000000
               	fmov	s22, #1.00000000
               	fmov	s23, #2.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v0.16b, v2.16b
               	fmla	v0.4s, v3.4s, v3.4s
               	fmov	s1, #1.75000000
               	fmov	s21, #14.00000000
               	fmov	s22, #4.25000000
               	fmov	s23, #12.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v0.16b, v2.16b
               	fmls	v0.4s, v3.4s, v3.4s
               	fmov	s1, #1.25000000
               	fmov	s21, #-18.00000000
               	fmov	s22, #2.25000000
               	fmov	s23, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s21
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s22
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s23
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fadd	v1.2s, v19.2s, v20.2s
               	mov	s21, v1.s[0]
               	fmov	s0, #2.00000000
               	fcmp	s21, s0
               	b.ne	<addr>
               	mov	s1, v1.s[1]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v1.16b, v19.16b
               	fmla	v1.2s, v20.2s, v20.2s
               	mov	s21, v1.s[0]
               	fmov	s22, #1.75000000
               	fcmp	s21, s22
               	b.ne	<addr>
               	mov	s1, v1.s[1]
               	fmov	s21, #14.00000000
               	fcmp	s1, s21
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v1.2s, v19.2s, v20.2s
               	mov	s1, v1.s[1]
               	fmov	s21, #-8.00000000
               	fcmp	s1, s21
               	b.ne	<addr>
               	fabs	v1.2s, v19.2s
               	mov	s1, v1.s[1]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v0.16b, v7.16b
               	fmla	v0.2d, v4.2d, v4.2d
               	mov	d21, v0.d[0]
               	fmov	d1, #14.50000000
               	fcmp	d21, d1
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	adrp	x16, <addr>
               	ldr	d21, [x16, #0x90]
               	fcmp	d0, d21
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v0.2d, v7.2d, v4.2d
               	mov	d0, v0.d[0]
               	fmov	d21, #5.25000000
               	fcmp	d0, d21
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v0.2d, v7.2d, v4.2d
               	mov	d0, v0.d[1]
               	fmov	d21, #-4.25000000
               	fcmp	d0, d21
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fadd	d0, d5, d6
               	fmov	d21, #12.50000000
               	fcmp	d0, d21
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmadd	d0, d6, d6, d5
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	d0, d6
               	fmadd	d0, d0, d6, d5
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	d0, d6, d6
               	fsqrt	d0, d0
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	d0, d5, d6
               	fneg	d0, d0
               	fmov	d1, #-10.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	stur	s0, [x29, #-0x20]
               	ldur	s1, [x29, #-0x20]
               	str	q2, [sp]
               	str	d1, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	d1, [sp, #0x10]
               	mov	v0.s[2], v1.s[0]
               	fcmeq	v1.4s, v2.4s, v0.4s
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v1.4s, v2.4s, v3.4s
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v2.4s, v3.4s
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v1.4s, v3.4s, v2.4s
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v3.4s, v2.4s
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v0.4s, v0.4s, v3.4s
               	mov	s1, v0.s[2]
               	mov	s21, v0.s[2]
               	fcmp	s1, s21
               	b.eq	<addr>
               	mov	s1, v0.s[0]
               	fmov	s0, #1.50000000
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.2d, v4.2d, v7.2d
               	mov	x0, v1.d[0]
               	cbnz	x0, <addr>
               	mov	x0, v1.d[1]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d5, d5
               	cset	x0, eq
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	fcmpe	d5, d6
               	cset	x0, gt
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	fcmpe	d5, d6
               	cset	x0, ls
               	neg	x0, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmeq	v1.2s, v19.2s, v20.2s
               	mov	w0, v1.s[0]
               	cbnz	x0, <addr>
               	fcmge	v1.2s, v19.2s, v19.2s
               	mov	w0, v1.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v1.4s, v2.4s, v3.4s
               	bsl	v1.16b, v2.16b, v3.16b
               	fmov	s6, #4.00000000
               	fmov	s20, #3.25000000
               	fmov	s21, #8.00000000
               	sub	x16, x29, #0x30
               	str	q1, [x16]
               	ldur	s1, [x29, #-0x30]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s20
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v0.2d, v4.2d, v7.2d
               	bsl	v0.16b, v7.16b, v4.16b
               	mov	d1, v0.d[0]
               	fmov	d6, #2.00000000
               	fcmp	d1, d6
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #-0.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	scvtf	v0.4s, v0.4s
               	fmov	s1, #-3.00000000
               	movi	d6, #0000000000000000
               	fmov	s20, #7.00000000
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s21, w16
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s20
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ucvtf	v0.4s, v0.4s
               	mov	x16, #0x4f800000        // =1333788672
               	fmov	s1, w16
               	fmov	s6, #1.00000000
               	fmov	s20, #2.00000000
               	fmov	s21, #3.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s20
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s21
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	v0.2s, v19.2s
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x14]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d0, [x29, #-0x18]
               	scvtf	v0.2s, v0.2s
               	mov	s0, v0.s[1]
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	v0.2d, v7.2d
               	mov	x0, v0.d[0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ucvtf	v0.2d, v0.2d
               	mov	d1, v0.d[0]
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d6, x16
               	fcmp	d1, d6
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	x0, d5
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	d0, v2.d[1]
               	fcvtl	v0.2d, v0.2s
               	mov	d1, v0.d[0]
               	fmov	d6, #3.25000000
               	fcmp	d1, d6
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtl2	v0.2d, v2.4s
               	mov	d0, v0.d[1]
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtn	v0.2s, v7.2d
               	mov	s1, v0.s[0]
               	fmov	s6, #10.50000000
               	fcmp	s1, s6
               	b.ne	<addr>
               	mov	s0, v0.s[1]
               	fmov	s1, #-0.25000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v2.d[0]
               	mov	x0, #0x0                // =0
               	mov	s1, v0.s[0]
               	fmov	s16, s1
               	mov	v1.16b, v16.16b
               	mov	s0, v0.s[1]
               	mov	v16.16b, v1.16b
               	mov	v16.s[1], v0.s[0]
               	mov	v0.16b, v16.16b
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	mov	v0.s[2], v17.s[0]
               	fmov	d17, x0
               	mov	v0.s[3], v17.s[0]
               	str	q0, [sp]
               	str	q4, [sp, #0x10]
               	ldr	q0, [sp]
               	ldr	q1, [sp, #0x10]
               	fcvtn2	v0.4s, v1.2d
               	fmov	s1, #1.50000000
               	fmov	s6, #2.00000000
               	fmov	s19, #-2.00000000
               	fmov	s20, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s19
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s20
               	b.eq	<addr>
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v2.d[1]
               	mov	d1, v3.d[0]
               	zip1	v0.2d, v0.2d, v1.2d
               	fmov	s1, #3.25000000
               	fmov	s2, #8.00000000
               	fmov	s3, #0.50000000
               	fmov	s6, #4.00000000
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
               	fcmp	s0, s6
               	b.eq	<addr>
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v7.d[1]
               	mov	d1, v4.d[0]
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
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
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
               	fmov	d1, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x32               // =50
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x41100000        // =1091567616
               	str	x16, [sp]
               	ldr	d1, [sp]
               	dup	v0.2s, v1.s[0]
               	sub	x16, x29, #0x48
               	str	d0, [x16]
               	sub	x16, x29, #0x40
               	str	q4, [x16]
               	sub	x16, x29, #0x40
               	str	d5, [x16]
               	ldur	s1, [x29, #-0x48]
               	fmov	s0, #9.00000000
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x44]
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
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
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
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
