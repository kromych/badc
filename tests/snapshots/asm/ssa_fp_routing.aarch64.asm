
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400558 <.text+0x2d8>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400e48 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
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
               	bl	0x4003d0 <.text+0x150>
               	mov	x13, x0
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x13
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x4005c8 <.text+0x348>
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
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4003ec <.text+0x16c>
               	mov	x13, x0
               	mov	x20, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x13
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x22, ne
               	cbz	x22, 0x40061c <.text+0x39c>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	mov	x22, #0x4010000000000000 // =4616189618054758400
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400408 <.text+0x188>
               	mov	x13, x0
               	mov	x22, #0x4024000000000000 // =4621819117588971520
               	fmov	d0, x13
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400670 <.text+0x3f0>
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x402e000000000000 // =4624633867356078080
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400424 <.text+0x1a4>
               	mov	x13, x0
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x13
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x4006c4 <.text+0x444>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x22
               	bl	0x400440 <.text+0x1c0>
               	mov	x21, x0
               	fmov	d0, x22
               	fneg	d7, d0
               	fmov	d0, x21
               	fcmp	d0, d7
               	cset	x22, ne
               	cbz	x22, 0x400710 <.text+0x490>
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x60]
               	ldur	x22, [x29, #-0x60]
               	mov	x0, x22
               	bl	0x400440 <.text+0x1c0>
               	mov	x13, x0
               	fmov	d0, x13
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x22, ne
               	cbz	x22, 0x40076c <.text+0x4ec>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x21
               	mov	x1, x21
               	bl	0x400454 <.text+0x1d4>
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.ne	0x4007ac <.text+0x52c>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400454 <.text+0x1d4>
               	mov	x20, x0
               	cbz	x20, 0x4007ec <.text+0x56c>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
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
               	bl	0x400470 <.text+0x1f0>
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.ne	0x400830 <.text+0x5b0>
               	mov	x22, #0x9               // =9
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x21
               	mov	x1, x21
               	bl	0x400470 <.text+0x1f0>
               	mov	x22, x0
               	cbz	x22, 0x40086c <.text+0x5ec>
               	mov	x21, #0xa               // =10
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x40048c <.text+0x20c>
               	mov	x23, x0
               	cmp	x23, #0x0
               	b.ne	0x4008b0 <.text+0x630>
               	mov	x23, #0xb               // =11
               	mov	x0, x23
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
               	bl	0x40048c <.text+0x20c>
               	mov	x20, x0
               	cbz	x20, 0x4008f0 <.text+0x670>
               	mov	x22, #0xc               // =12
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x4004a8 <.text+0x228>
               	mov	x21, x0
               	cmp	x21, #0x0
               	b.ne	0x400934 <.text+0x6b4>
               	mov	x21, #0xd               // =13
               	mov	x0, x21
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
               	bl	0x4004a8 <.text+0x228>
               	mov	x23, x0
               	cbz	x23, 0x400974 <.text+0x6f4>
               	mov	x20, #0xe               // =14
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x21
               	mov	x1, x21
               	bl	0x4004c4 <.text+0x244>
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	0x4009b4 <.text+0x734>
               	mov	x20, #0xf               // =15
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x4004c4 <.text+0x244>
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.ne	0x4009f8 <.text+0x778>
               	mov	x22, #0x10              // =16
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4004c4 <.text+0x244>
               	mov	x23, x0
               	cbz	x23, 0x400a38 <.text+0x7b8>
               	mov	x21, #0x11              // =17
               	mov	x0, x21
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
               	bl	0x4004e0 <.text+0x260>
               	mov	x21, x0
               	cmp	x21, #0x0
               	b.ne	0x400a78 <.text+0x7f8>
               	mov	x21, #0x12              // =18
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x4004e0 <.text+0x260>
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	0x400abc <.text+0x83c>
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
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4004e0 <.text+0x260>
               	mov	x23, x0
               	cbz	x23, 0x400afc <.text+0x87c>
               	mov	x22, #0x14              // =20
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x2a              // =42
               	mov	x0, x20
               	bl	0x4004fc <.text+0x27c>
               	mov	x22, x0
               	mov	x20, #0x4045000000000000 // =4631107791820423168
               	fmov	d0, x22
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400b48 <.text+0x8c8>
               	mov	x20, #0x15              // =21
               	mov	x0, x20
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
               	bl	0x4004fc <.text+0x27c>
               	mov	x20, x0
               	mov	x23, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x23
               	fneg	d7, d0
               	fmov	d0, x20
               	fcmp	d0, d7
               	cset	x23, ne
               	cbz	x23, 0x400ba4 <.text+0x924>
               	mov	x20, #0x16              // =22
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	mov	x0, x21
               	bl	0x40050c <.text+0x28c>
               	mov	x20, x0
               	cmp	x20, #0x3
               	b.eq	0x400be0 <.text+0x960>
               	mov	x20, #0x17              // =23
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x21
               	fneg	d7, d0
               	fmov	x16, d7
               	sub	x17, x29, #0x150
               	str	x16, [x17]
               	sub	x16, x29, #0x150
               	ldr	x23, [x16]
               	mov	x0, x23
               	bl	0x40050c <.text+0x28c>
               	mov	x20, x0
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	b.eq	0x400c48 <.text+0x9c8>
               	mov	x20, #0x18              // =24
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x999a            // =39322
               	movk	x21, #0x9999, lsl #16
               	movk	x21, #0x9999, lsl #32
               	movk	x21, #0x3fb9, lsl #48
               	mov	x0, x21
               	bl	0x40051c <.text+0x29c>
               	mov	x20, x0
               	fmov	d0, x20
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x22, eq
               	cbz	x22, 0x400c9c <.text+0xa1c>
               	mov	x20, #0x19              // =25
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x23
               	bl	0x40051c <.text+0x29c>
               	mov	x20, x0
               	fmov	d0, x20
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400ce4 <.text+0xa64>
               	mov	x20, #0x1a              // =26
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
