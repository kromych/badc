
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
               	sub	sp, sp, #0x60
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q1, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d6, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d7, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q5, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q2, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d3, [x16]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	d4, [x16]
               	fadd	v20.4s, v0.4s, v1.4s
               	fmov	s19, #2.00000000
               	fmov	s21, #2.25000000
               	fmov	s22, #10.00000000
               	sub	x16, x29, #0x30
               	str	q20, [x16]
               	ldur	s20, [x29, #-0x30]
               	fcmp	s20, s19
               	b.ne	<addr>
               	ldur	s20, [x29, #-0x2c]
               	fcmp	s20, s19
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s22
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v19.4s, v0.4s, v1.4s
               	fmov	s20, #1.00000000
               	fmov	s21, #6.00000000
               	fmov	s22, #-6.00000000
               	fmov	s23, #4.25000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s23
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s21
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v19.4s, v0.4s, v1.4s
               	fmov	s20, #0.75000000
               	fmov	s21, #-8.00000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #16.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v19.4s, v0.4s, v1.4s
               	fmov	s20, #3.00000000
               	fmov	s21, #-0.50000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #4.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v19.4s, v0.4s, v1.4s
               	fmov	s20, #1.50000000
               	fmov	s21, #4.00000000
               	fmov	s22, #3.25000000
               	fmov	s23, #8.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmin	v19.4s, v0.4s, v1.4s
               	fmov	s20, #0.50000000
               	fmov	s21, #2.00000000
               	fmov	s22, #-2.00000000
               	fmov	s23, #-1.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s23
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s21
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fabs	v19.4s, v0.4s
               	fmov	s20, #1.50000000
               	fmov	s21, #2.00000000
               	fmov	s22, #3.25000000
               	fmov	s23, #8.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	v19.4s, v0.4s
               	fmov	s20, #-1.50000000
               	fmov	s21, #2.00000000
               	fmov	s22, #-3.25000000
               	fmov	s23, #-8.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v19.4s, v1.4s, v1.4s
               	fsqrt	v19.4s, v19.4s
               	fmov	s20, #0.50000000
               	fmov	s21, #4.00000000
               	fmov	s22, #1.00000000
               	fmov	s23, #2.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v19.16b, v0.16b
               	fmla	v19.4s, v1.4s, v1.4s
               	fmov	s20, #1.75000000
               	fmov	s21, #14.00000000
               	fmov	s22, #4.25000000
               	fmov	s23, #12.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v19.16b, v0.16b
               	fmls	v19.4s, v1.4s, v1.4s
               	fmov	s20, #1.25000000
               	fmov	s21, #-18.00000000
               	fmov	s22, #2.25000000
               	fmov	s23, #4.00000000
               	sub	x16, x29, #0x30
               	str	q19, [x16]
               	ldur	s19, [x29, #-0x30]
               	fcmp	s19, s20
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x2c]
               	fcmp	s19, s21
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x28]
               	fcmp	s19, s22
               	b.ne	<addr>
               	ldur	s19, [x29, #-0x24]
               	fcmp	s19, s23
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fadd	v20.2s, v6.2s, v7.2s
               	mov	s21, v20.s[0]
               	fmov	s19, #2.00000000
               	fcmp	s21, s19
               	b.ne	<addr>
               	mov	s20, v20.s[1]
               	fcmp	s20, s19
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v20.16b, v6.16b
               	fmla	v20.2s, v7.2s, v7.2s
               	mov	s21, v20.s[0]
               	fmov	s22, #1.75000000
               	fcmp	s21, s22
               	b.ne	<addr>
               	mov	s20, v20.s[1]
               	fmov	s21, #14.00000000
               	fcmp	s20, s21
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	v20.2s, v6.2s, v7.2s
               	mov	s20, v20.s[1]
               	fmov	s21, #-8.00000000
               	fcmp	s20, s21
               	b.ne	<addr>
               	fabs	v20.2s, v6.2s
               	mov	s20, v20.s[1]
               	fcmp	s20, s19
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	v19.16b, v5.16b
               	fmla	v19.2d, v2.2d, v2.2d
               	mov	d21, v19.d[0]
               	fmov	d20, #14.50000000
               	fcmp	d21, d20
               	b.ne	<addr>
               	mov	d19, v19.d[1]
               	adrp	x16, <addr>
               	ldr	d21, [x16, #0x90]
               	fcmp	d19, d21
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fdiv	v19.2d, v5.2d, v2.2d
               	mov	d19, v19.d[0]
               	fmov	d21, #5.25000000
               	fcmp	d19, d21
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fsub	v19.2d, v5.2d, v2.2d
               	mov	d19, v19.d[1]
               	fmov	d21, #-4.25000000
               	fcmp	d19, d21
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fadd	d19, d3, d4
               	fmov	d21, #12.50000000
               	fcmp	d19, d21
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmadd	d19, d4, d4, d3
               	fcmp	d19, d20
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	d19, d4
               	fmadd	d19, d19, d4, d3
               	fmov	d20, #6.50000000
               	fcmp	d19, d20
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmul	d19, d4, d4
               	fsqrt	d19, d19
               	fmov	d20, #2.00000000
               	fcmp	d19, d20
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	d19, d3, d4
               	fneg	d19, d19
               	fmov	d20, #-10.50000000
               	fcmp	d19, d20
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s19, w16
               	stur	s19, [x29, #-0x20]
               	ldur	s19, [x29, #-0x20]
               	mov	v20.16b, v0.16b
               	mov	v20.s[2], v19.s[0]
               	fcmeq	v19.4s, v0.4s, v20.4s
               	mov	w0, v19.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[3]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v19.4s, v0.4s, v1.4s
               	mov	w0, v19.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[1]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[2]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[3]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v19.4s, v0.4s, v1.4s
               	mov	w0, v19.s[0]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[1]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[2]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[3]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmge	v19.4s, v1.4s, v0.4s
               	mov	w0, v19.s[0]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[3]
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v19.4s, v1.4s, v0.4s
               	mov	w0, v19.s[0]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v19.s[2]
               	cbnz	x0, <addr>
               	mov	w0, v19.s[3]
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmax	v19.4s, v20.4s, v1.4s
               	mov	s20, v19.s[2]
               	mov	s21, v19.s[2]
               	fcmp	s20, s21
               	b.eq	<addr>
               	mov	s20, v19.s[0]
               	fmov	s19, #1.50000000
               	fcmp	s20, s19
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v20.2d, v2.2d, v5.2d
               	mov	x0, v20.d[0]
               	cbnz	x0, <addr>
               	mov	x0, v20.d[1]
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d3, d3
               	cset	x0, eq
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	fcmpe	d3, d4
               	cset	x0, gt
               	neg	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	fcmpe	d3, d4
               	cset	x0, ls
               	neg	x0, x0
               	cbz	x0, <addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmeq	v4.2s, v6.2s, v7.2s
               	mov	w0, v4.s[0]
               	cbnz	x0, <addr>
               	fcmge	v4.2s, v6.2s, v6.2s
               	mov	w0, v4.s[1]
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v4.4s, v0.4s, v1.4s
               	bsl	v4.16b, v0.16b, v1.16b
               	fmov	s7, #4.00000000
               	fmov	s20, #3.25000000
               	fmov	s21, #8.00000000
               	sub	x16, x29, #0x30
               	str	q4, [x16]
               	ldur	s4, [x29, #-0x30]
               	fcmp	s4, s19
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x2c]
               	fcmp	s4, s7
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x28]
               	fcmp	s4, s20
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x24]
               	fcmp	s4, s21
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmgt	v4.2d, v2.2d, v5.2d
               	bsl	v4.16b, v5.16b, v2.16b
               	mov	d7, v4.d[0]
               	fmov	d19, #2.00000000
               	fcmp	d7, d19
               	b.ne	<addr>
               	mov	d4, v4.d[1]
               	fmov	d7, #-0.25000000
               	fcmp	d4, d7
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q7, [x16]
               	fcvtzs	v4.4s, v7.4s
               	smov	x0, v4.s[0]
               	mov	x17, #-0x2              // =-2
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v4.s[1]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	smov	x0, v4.s[2]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	x0, x17
               	b.ne	<addr>
               	smov	x0, v4.s[3]
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzu	v4.4s, v7.4s
               	mov	w0, v4.s[0]
               	cbnz	x0, <addr>
               	mov	w0, v4.s[1]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	mov	w0, v4.s[2]
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	w0, v4.s[3]
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q4, [x0]
               	scvtf	v4.4s, v4.4s
               	fmov	s7, #-3.00000000
               	movi	d19, #0000000000000000
               	fmov	s20, #7.00000000
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s21, w16
               	sub	x16, x29, #0x30
               	str	q4, [x16]
               	ldur	s4, [x29, #-0x30]
               	fcmp	s4, s7
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x2c]
               	fcmp	s4, s19
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x28]
               	fcmp	s4, s20
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x24]
               	fcmp	s4, s21
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q4, [x0]
               	ucvtf	v4.4s, v4.4s
               	mov	x16, #0x4f800000        // =1333788672
               	fmov	s7, w16
               	fmov	s19, #1.00000000
               	fmov	s20, #2.00000000
               	fmov	s21, #3.00000000
               	sub	x16, x29, #0x30
               	str	q4, [x16]
               	ldur	s4, [x29, #-0x30]
               	fcmp	s4, s7
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x2c]
               	fcmp	s4, s19
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x28]
               	fcmp	s4, s20
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x24]
               	fcmp	s4, s21
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	v4.2s, v6.2s
               	mov	x0, v4.d[0]
               	stur	x0, [x29, #-0x18]
               	ldursw	x0, [x29, #-0x18]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x14]
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x26               // =38
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	d4, [x29, #-0x18]
               	scvtf	v4.2s, v4.2s
               	mov	s4, v4.s[1]
               	fmov	s6, #-2.00000000
               	fcmp	s4, s6
               	b.eq	<addr>
               	mov	x0, #0x27               // =39
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	v4.2d, v5.2d
               	mov	x0, v4.d[0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	x0, v4.d[1]
               	cbz	x0, <addr>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q4, [x0]
               	ucvtf	v4.2d, v4.2d
               	mov	d6, v4.d[0]
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d7, x16
               	fcmp	d6, d7
               	b.ne	<addr>
               	mov	d4, v4.d[1]
               	fmov	d6, #5.00000000
               	fcmp	d4, d6
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtzs	x0, d3
               	cmp	x0, #0xa
               	b.ne	<addr>
               	mov	d4, v0.d[1]
               	fcvtl	v4.2d, v4.2s
               	mov	d6, v4.d[0]
               	fmov	d7, #3.25000000
               	fcmp	d6, d7
               	b.ne	<addr>
               	mov	d4, v4.d[1]
               	fmov	d6, #8.00000000
               	fcmp	d4, d6
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtl2	v4.2d, v0.4s
               	mov	d4, v4.d[1]
               	fmov	d6, #8.00000000
               	fcmp	d4, d6
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcvtn	v4.2s, v5.2d
               	mov	s6, v4.s[0]
               	fmov	s7, #10.50000000
               	fcmp	s6, s7
               	b.ne	<addr>
               	mov	s4, v4.s[1]
               	fmov	s6, #-0.25000000
               	fcmp	s4, s6
               	b.eq	<addr>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d4, v0.d[0]
               	mov	x0, #0x0                // =0
               	mov	s6, v4.s[0]
               	fmov	s16, s6
               	mov	v6.16b, v16.16b
               	mov	s4, v4.s[1]
               	mov	v16.16b, v6.16b
               	mov	v16.s[1], v4.s[0]
               	mov	v4.16b, v16.16b
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	mov	v4.s[2], v17.s[0]
               	fmov	d17, x0
               	mov	v4.s[3], v17.s[0]
               	fcvtn2	v4.4s, v2.2d
               	fmov	s6, #1.50000000
               	fmov	s7, #2.00000000
               	fmov	s19, #-2.00000000
               	fmov	s20, #4.00000000
               	sub	x16, x29, #0x30
               	str	q4, [x16]
               	ldur	s4, [x29, #-0x30]
               	fcmp	s4, s6
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x2c]
               	fcmp	s4, s19
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x28]
               	fcmp	s4, s7
               	b.ne	<addr>
               	ldur	s4, [x29, #-0x24]
               	fcmp	s4, s20
               	b.eq	<addr>
               	mov	x0, #0x2e               // =46
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v0.d[1]
               	mov	d1, v1.d[0]
               	zip1	v0.2d, v0.2d, v1.2d
               	fmov	s1, #3.25000000
               	fmov	s4, #8.00000000
               	fmov	s6, #0.50000000
               	fmov	s7, #4.00000000
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	ldur	s0, [x29, #-0x30]
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x2c]
               	fcmp	s0, s4
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x28]
               	fcmp	s0, s6
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x24]
               	fcmp	s0, s7
               	b.eq	<addr>
               	mov	x0, #0x2f               // =47
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	d0, v5.d[1]
               	mov	d1, v2.d[0]
               	zip1	v0.2d, v0.2d, v1.2d
               	mov	d1, v0.d[0]
               	fmov	d4, #-0.25000000
               	fcmp	d1, d4
               	b.ne	<addr>
               	mov	d0, v0.d[1]
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x30               // =48
               	add	sp, sp, #0x60
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
               	add	sp, sp, #0x60
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
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x41100000        // =1091567616
               	str	x16, [sp]
               	ldr	d1, [sp]
               	dup	v0.2s, v1.s[0]
               	sub	x16, x29, #0x48
               	str	d0, [x16]
               	sub	x16, x29, #0x40
               	str	q2, [x16]
               	sub	x16, x29, #0x40
               	str	d3, [x16]
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
               	add	sp, sp, #0x60
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
               	add	sp, sp, #0x60
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
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
