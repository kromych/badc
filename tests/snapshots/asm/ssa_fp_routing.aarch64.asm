
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400554 <.text+0x2d4>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400dd8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
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
               	bl	0x4003cc <.text+0x14c>
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x4005c0 <.text+0x340>
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
               	bl	0x4003e8 <.text+0x168>
               	mov	x23, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400610 <.text+0x390>
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
               	bl	0x400404 <.text+0x184>
               	mov	x21, #0x4024000000000000 // =4621819117588971520
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400660 <.text+0x3e0>
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
               	bl	0x400420 <.text+0x1a0>
               	mov	x23, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x4006b0 <.text+0x430>
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
               	bl	0x40043c <.text+0x1bc>
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, 0x4006f8 <.text+0x478>
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
               	bl	0x40043c <.text+0x1bc>
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400750 <.text+0x4d0>
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
               	bl	0x400450 <.text+0x1d0>
               	cmp	x0, #0x0
               	b.ne	0x40078c <.text+0x50c>
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
               	bl	0x400450 <.text+0x1d0>
               	cbz	x0, 0x4007c8 <.text+0x548>
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
               	bl	0x40046c <.text+0x1ec>
               	cmp	x0, #0x0
               	b.ne	0x400808 <.text+0x588>
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
               	bl	0x40046c <.text+0x1ec>
               	cbz	x0, 0x400840 <.text+0x5c0>
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
               	bl	0x400488 <.text+0x208>
               	cmp	x0, #0x0
               	b.ne	0x400880 <.text+0x600>
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
               	bl	0x400488 <.text+0x208>
               	cbz	x0, 0x4008bc <.text+0x63c>
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
               	bl	0x4004a4 <.text+0x224>
               	cmp	x0, #0x0
               	b.ne	0x4008fc <.text+0x67c>
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
               	bl	0x4004a4 <.text+0x224>
               	cbz	x0, 0x400938 <.text+0x6b8>
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
               	bl	0x4004c0 <.text+0x240>
               	cmp	x0, #0x0
               	b.ne	0x400974 <.text+0x6f4>
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
               	bl	0x4004c0 <.text+0x240>
               	cmp	x0, #0x0
               	b.ne	0x4009b4 <.text+0x734>
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
               	bl	0x4004c0 <.text+0x240>
               	cbz	x0, 0x4009f0 <.text+0x770>
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
               	bl	0x4004dc <.text+0x25c>
               	cmp	x0, #0x0
               	b.ne	0x400a2c <.text+0x7ac>
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
               	bl	0x4004dc <.text+0x25c>
               	cmp	x0, #0x0
               	b.ne	0x400a6c <.text+0x7ec>
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
               	bl	0x4004dc <.text+0x25c>
               	cbz	x0, 0x400aa8 <.text+0x828>
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
               	bl	0x4004f8 <.text+0x278>
               	mov	x22, #0x4045000000000000 // =4631107791820423168
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400af0 <.text+0x870>
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
               	bl	0x4004f8 <.text+0x278>
               	mov	x23, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x23
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, 0x400b48 <.text+0x8c8>
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
               	bl	0x400508 <.text+0x288>
               	cmp	x0, #0x3
               	b.eq	0x400b80 <.text+0x900>
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
               	bl	0x400508 <.text+0x288>
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400be4 <.text+0x964>
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
               	bl	0x400518 <.text+0x298>
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, 0x400c34 <.text+0x9b4>
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
               	bl	0x400518 <.text+0x298>
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400c78 <.text+0x9f8>
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
