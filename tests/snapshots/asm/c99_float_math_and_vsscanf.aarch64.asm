
c99_float_math_and_vsscanf.aarch64:	file format elf64-littleaarch64

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

<scan>:
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
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x18
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x30             // =-48
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x29, #0x18]
               	sub	x2, x29, #0x20
               	bl	<addr>
               	sub	x1, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	wzr, [x29, #-0x18]
               	fmov	s0, #8.00000000
               	stur	s0, [x29, #-0x10]
               	fmov	s0, #3.00000000
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x18]
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x18]
               	bl	<addr>
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x18]
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x10]
               	bl	<addr>
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8]
               	bl	<addr>
               	fmov	s1, #8.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x38]
               	ldur	s0, [x29, #-0x10]
               	sub	x0, x29, #0x38
               	bl	<addr>
               	fmov	s1, #0.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x38]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #0.75000000
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x30]
               	fmov	s0, #2.50000000
               	sub	x0, x29, #0x30
               	bl	<addr>
               	fmov	s1, #0.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x30]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #2.50000000
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	fmov	s0, #-2.50000000
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8]
               	fneg	s0, s0
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	wzr, [x29, #-0x28]
               	stur	wzr, [x29, #-0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x28
               	sub	x3, x29, #0x20
               	bl	<addr>
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x28]
               	cmp	w0, #0xc
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x20]
               	cmp	w0, #0x22
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
