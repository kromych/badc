
float_variadic_promotion.aarch64:	file format elf64-littleaarch64

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

<vsum>:
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
               	sub	x1, x29, #0x20
               	add	x0, x29, #0x10
               	mov	x16, x1
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
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x1
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
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x20]
               	mov	x0, #0x1                // =1
               	fcvt	d0, s0
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	fmov	d0, #2.50000000
               	fcvt	s0, d0
               	fcvt	d0, s0
               	bl	<addr>
               	fmov	d1, #2.50000000
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x20]
               	fcvt	d0, s0
               	fmov	s1, #1.50000000
               	fcvt	d1, s1
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fsub	d0, d0, d1
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	fmov	d0, #10.00000000
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x20]
               	fcvt	d1, s1
               	fmov	s2, #1.50000000
               	fcvt	d2, s2
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x18]
               	fsub	d0, d0, d1
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d0, d1
               	b.mi	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldp	x29, x30, [sp], #0x10
               	ret
