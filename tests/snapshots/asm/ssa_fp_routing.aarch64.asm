
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fadd	d0, d0, d1
               	fmov	x0, d0
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fsub	d0, d0, d1
               	fmov	x0, d0
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fmul	d0, d0, d1
               	fmov	x0, d0
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fdiv	d0, d0, d1
               	fmov	x0, d0
               	ret
               	mov	x15, x0
               	fmov	d0, x15
               	fneg	d0, d0
               	fmov	x0, d0
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, eq
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, mi
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, gt
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ls
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ge
               	ret
               	sxtw	x15, w0
               	scvtf	d0, x15
               	fmov	x0, d0
               	ret
               	mov	x15, x0
               	fmov	d0, x15
               	fcvtzs	x0, d0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sub	x14, x29, #0x8
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x14]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fmov	x0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	mov	x21, #0x4002000000000000 // =4612248968380809216
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4014000000000000 // =4617315517961601024
               	mov	x23, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x23, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4004000000000000 // =4612811918334230528
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x21, #0x4024000000000000 // =4621819117588971520
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x402e000000000000 // =4624633867356078080
               	mov	x23, #0x4010000000000000 // =4616189618054758400
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x23, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x4               // =4
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x20
               	bl	<addr>
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x23
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x60]
               	ldur	x21, [x29, #-0x60]
               	mov	x0, x21
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x6               // =6
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x22
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x22, #0x7               // =7
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x22, #0x9               // =9
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x23
               	mov	x1, x23
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x23, #0xa               // =10
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x20, #0xb               // =11
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x23, #0xc               // =12
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x20, #0xd               // =13
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x23, #0xe               // =14
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x22
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x22, #0xf               // =15
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x22, #0x11              // =17
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x23
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x23, #0x12              // =18
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x20, #0x13              // =19
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x21
               	mov	x1, x23
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x23, #0x14              // =20
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x2a              // =42
               	mov	x0, x22
               	bl	<addr>
               	mov	x22, #0x4045000000000000 // =4631107791820423168
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x22, #0x15              // =21
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0xfffd            // =65533
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x0, x23
               	bl	<addr>
               	mov	x23, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x23
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x16              // =22
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x400e000000000000 // =4615626668101337088
               	mov	x0, x22
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x22, #0x17              // =23
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	x16, d7
               	sub	x17, x29, #0x150
               	str	x16, [x17]
               	sub	x16, x29, #0x150
               	ldr	x23, [x16]
               	mov	x0, x23
               	bl	<addr>
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x23, #0x18              // =24
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x999a            // =39322
               	movk	x22, #0x9999, lsl #16
               	movk	x22, #0x9999, lsl #32
               	movk	x22, #0x3fb9, lsl #48
               	mov	x0, x22
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x22, #0x19              // =25
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x23
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x1a              // =26
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
