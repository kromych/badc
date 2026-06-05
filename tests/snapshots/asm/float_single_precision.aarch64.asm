
float_single_precision.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	fcvt	s0, d0
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	mov	x0, #0x7c87             // =31879
               	movk	x0, #0x5fb6, lsl #16
               	movk	x0, #0x5555, lsl #32
               	movk	x0, #0x3fd5, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fsub	s0, s0, s1
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fcmp	s0, s1
               	cset	x0, mi
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fneg	s0, s0
               	str	s0, [x0]
               	b	<addr>
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0xaf48             // =44872
               	movk	x0, #0x9abc, lsl #16
               	movk	x0, #0xd7f2, lsl #32
               	movk	x0, #0x3e7a, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x1, x29, #0x8
               	str	s0, [x1]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	s0, [x0]
               	mov	x1, #0x999a             // =39322
               	movk	x1, #0x9999, lsl #16
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x3fb9, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	str	s0, [x0]
               	b	<addr>
               	mov	x0, #0xf29b             // =62107
               	movk	x0, #0x1ad7, lsl #16
               	movk	x0, #0x3ff0, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	fsub	s0, s0, s1
               	sub	x0, x29, #0x20
               	str	s0, [x0]
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fcmp	s0, s1
               	cset	x0, mi
               	cbz	x0, <addr>
               	sub	x0, x29, #0x20
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	fneg	s0, s0
               	str	s0, [x0]
               	b	<addr>
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	mov	x0, #0xed8d             // =60813
               	movk	x0, #0xa0b5, lsl #16
               	movk	x0, #0xc6f7, lsl #32
               	movk	x0, #0x3eb0, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3ff1, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fmul	s1, s0, s0
               	fmul	s1, s1, s0
               	fmul	s0, s1, s0
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	mov	x0, #0x2012             // =8210
               	movk	x0, #0x39f9, lsl #16
               	movk	x0, #0x6cf4, lsl #32
               	movk	x0, #0x3ff7, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fcvt	s0, d0
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0x0                // =0
               	scvtf	d1, x0
               	fcvt	s1, d1
               	fcmp	s0, s1
               	cset	x0, mi
               	cbz	x0, <addr>
               	sub	x0, x29, #0x18
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fneg	s0, s0
               	str	s0, [x0]
               	b	<addr>
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	mov	x0, #0x68f1             // =26865
               	movk	x0, #0x88e3, lsl #16
               	movk	x0, #0xf8b5, lsl #32
               	movk	x0, #0x3ee4, lsl #48
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
