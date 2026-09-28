
homogeneous_vector_aggregates.aarch64:	file format elf64-littleaarch64

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

<take_v1>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	q0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	ldr	s0, [x0]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s2, w16
               	ldr	s3, [x0, #0xc]
               	fmov	s4, #10.00000000
               	fmul	s3, s3, s4
               	fmadd	s0, s0, s2, s3
               	fcvt	d0, s0
               	fadd	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_s2>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	q0, [x29, #-0x20]
               	stur	q1, [x29, #-0x10]
               	sub	x0, x29, #0x20
               	ldr	s0, [x0, #0xc]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s1, w16
               	ldrsw	x0, [x0, #0x18]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	scvtf	s3, x0
               	fmadd	s0, s0, s1, s3
               	fcvt	d0, s0
               	fadd	d0, d0, d2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<take_d3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	d0, [x29, #-0x18]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	ldr	s0, [x0]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s1, w16
               	ldr	s2, [x0, #0x8]
               	fmov	s4, #10.00000000
               	fmul	s2, s2, s4
               	fmadd	s0, s0, s1, s2
               	ldr	s1, [x0, #0x14]
               	fadd	s0, s0, s1
               	fcvt	d0, s0
               	fadd	d0, d0, d3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<after_v1>:
               	fmov	d0, d1
               	ret

<after_s2>:
               	fmov	d0, d2
               	ret

<after_d3>:
               	fmov	d0, d3
               	ret

<after_x2>:
               	ret

<ret_v1>:
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	mov	v0.s[3], v1.s[0]
               	fmov	s1, #-1.00000000
               	ret

<ret_s2>:
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	mov	v0.s[3], v1.s[0]
               	movi	v1.4s, #0x3
               	fmov	s2, #-1.00000000
               	ret

<ret_d3>:
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	s3, #-1.00000000
               	ret

<via_v1>:
               	mov	x16, x0
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	mov	v0.s[3], v1.s[0]
               	fmov	d1, #0.50000000
               	br	x16

<via_s2>:
               	mov	x16, x0
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	mov	v0.s[3], v1.s[0]
               	movi	v1.4s, #0x5
               	fmov	d2, #0.50000000
               	br	x16

<via_d3>:
               	mov	x16, x0
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	movi	v2.2s, #0x0
               	fmov	s3, #5.00000000
               	mov	v2.s[1], v3.s[0]
               	fmov	d3, #0.50000000
               	br	x16

<sum_v1>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x40
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x1]
               	ldr	x17, [x9, #0x8]
               	str	x17, [x1, #0x8]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	ldr	s2, [x1]
               	fmov	s3, #10.00000000
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fmadd	d0, d0, d1, d2
               	ldr	s1, [x1, #0xc]
               	fcvt	d1, s1
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<sum_s2>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x3, #0xa                // =10
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x50]
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x60
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x20
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x1]
               	ldr	x17, [x9, #0x8]
               	str	x17, [x1, #0x8]
               	ldr	x17, [x9, #0x10]
               	str	x17, [x1, #0x10]
               	ldr	x17, [x9, #0x18]
               	str	x17, [x1, #0x18]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x20
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x4, x16
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x4, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	s2, [x1, #0xc]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s3, w16
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fmadd	d0, d0, d1, d2
               	ldrsw	x4, [x1, #0x14]
               	mul	x4, x4, x3
               	sxtw	x4, w4
               	scvtf	d2, x4
               	fadd	d0, d0, d2
               	ldr	s2, [x1]
               	fcvt	d2, s2
               	fadd	d0, d0, d2
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<sum_d3>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x38
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x50]
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	sub	x1, x29, #0x18
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x30
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x1]
               	ldr	x17, [x9, #0x10]
               	str	x17, [x1, #0x8]
               	ldr	x17, [x9, #0x20]
               	str	x17, [x1, #0x10]
               	mov	x16, x1
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x18
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x1, #0x10]
               	ldr	s2, [x1]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s3, w16
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fmadd	d0, d0, d1, d2
               	ldr	s2, [x1, #0xc]
               	fmov	s3, #10.00000000
               	fmul	s2, s2, s3
               	fcvt	d2, s2
               	fadd	d0, d0, d2
               	ldr	s2, [x1, #0x10]
               	fcvt	d2, s2
               	fadd	d0, d0, d2
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x38
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	sub	x7, x29, #0xb0
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x80
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x1, x0, #0x10
               	sub	x0, x29, #0x80
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x1, x29, #0x30
               	sub	x0, x29, #0x8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x2, x1, #0x8
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	ldr	x16, [x0]
               	str	x16, [x2]
               	add	x1, x1, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	fmov	d0, #3.00000000
               	str	d0, [x1, #0x8]
               	fmov	d0, #0.50000000
               	fmov	d1, d0
               	ldr	q0, [x7]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0xa0
               	fmov	d2, d1
               	ldr	q0, [x7]
               	ldr	q1, [x7, #0x10]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x30
               	fmov	d3, d1
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x7, #0x10]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	fmov	d0, d1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	s0, [x0]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0xc]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	q0, [x29, #-0x80]
               	stur	q1, [x29, #-0x70]
               	sub	x1, x29, #0x80
               	sub	x0, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	s0, [x0]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0xc]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	d0, [x29, #-0x18]
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	ldr	s0, [x0]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0x8]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldr	s0, [x0, #0x10]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x58]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x60]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x68]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	fmov	d0, #0.50000000
               	ldr	s1, [x0, #0x4]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s2, w16
               	fmul	s1, s1, s2
               	ldr	d2, [x0, #0x8]
               	fmov	d3, #10.00000000
               	fcvt	d1, s1
               	fmadd	d1, d2, d3, d1
               	fadd	d0, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x70]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x7, x29, #0xb0
               	ldr	q0, [x7]
               	ldr	q1, [x7]
               	ldr	q2, [x7]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x78]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x7, x29, #0xa0
               	ldr	q0, [x7]
               	ldr	q1, [x7, #0x10]
               	ldr	q2, [x7]
               	ldr	q3, [x7, #0x10]
               	ldr	q4, [x7]
               	ldr	q5, [x7, #0x10]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x80]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sub	x7, x29, #0x30
               	sub	sp, sp, #0x50
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	ldr	x17, [x16, #0x10]
               	str	x17, [sp, #0x10]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp, #0x18]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x20]
               	ldr	x17, [x16, #0x10]
               	str	x17, [sp, #0x28]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp, #0x30]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x38]
               	ldr	x17, [x16, #0x10]
               	str	x17, [sp, #0x40]
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	ldr	d2, [x7, #0x10]
               	ldr	d3, [x7]
               	ldr	d4, [x7, #0x8]
               	ldr	d5, [x7, #0x10]
               	bl	<addr>
               	add	sp, sp, #0x50
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x88]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
