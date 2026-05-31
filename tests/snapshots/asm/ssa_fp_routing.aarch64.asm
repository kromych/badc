
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400550 <.text+0x2d0>
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
               	bl	0x400d98 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
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
               	bl	0x4003c8 <.text+0x148>
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x4005bc <.text+0x33c>
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
               	bl	0x4003e4 <.text+0x164>
               	mov	x20, #0x400c000000000000 // =4615063718147915776
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x22, ne
               	cbz	x22, 0x40060c <.text+0x38c>
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
               	bl	0x400400 <.text+0x180>
               	mov	x22, #0x4024000000000000 // =4621819117588971520
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x40065c <.text+0x3dc>
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
               	bl	0x40041c <.text+0x19c>
               	mov	x21, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x4006ac <.text+0x42c>
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
               	bl	0x400438 <.text+0x1b8>
               	fmov	d0, x22
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x22, ne
               	cbz	x22, 0x4006f0 <.text+0x470>
               	mov	x0, #0x5                // =5
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
               	bl	0x400438 <.text+0x1b8>
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x22, ne
               	cbz	x22, 0x400744 <.text+0x4c4>
               	mov	x0, #0x6                // =6
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
               	bl	0x40044c <.text+0x1cc>
               	cmp	x0, #0x0
               	b.ne	0x40077c <.text+0x4fc>
               	mov	x0, #0x7                // =7
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
               	bl	0x40044c <.text+0x1cc>
               	cbz	x0, 0x4007b8 <.text+0x538>
               	mov	x21, #0x8               // =8
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400468 <.text+0x1e8>
               	cmp	x0, #0x0
               	b.ne	0x4007f4 <.text+0x574>
               	mov	x0, #0x9                // =9
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
               	bl	0x400468 <.text+0x1e8>
               	cbz	x0, 0x40082c <.text+0x5ac>
               	mov	x22, #0xa               // =10
               	mov	x0, x22
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
               	bl	0x400484 <.text+0x204>
               	cmp	x0, #0x0
               	b.ne	0x400868 <.text+0x5e8>
               	mov	x0, #0xb                // =11
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
               	bl	0x400484 <.text+0x204>
               	cbz	x0, 0x4008a4 <.text+0x624>
               	mov	x21, #0xc               // =12
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
               	bl	0x4004a0 <.text+0x220>
               	cmp	x0, #0x0
               	b.ne	0x4008e0 <.text+0x660>
               	mov	x0, #0xd                // =13
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
               	bl	0x4004a0 <.text+0x220>
               	cbz	x0, 0x40091c <.text+0x69c>
               	mov	x22, #0xe               // =14
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
               	bl	0x4004bc <.text+0x23c>
               	cmp	x0, #0x0
               	b.ne	0x400954 <.text+0x6d4>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x3ff0000000000000 // =4607182418800017408
               	mov	x23, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4004bc <.text+0x23c>
               	cmp	x0, #0x0
               	b.ne	0x400990 <.text+0x710>
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x23, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x4004bc <.text+0x23c>
               	cbz	x0, 0x4009cc <.text+0x74c>
               	mov	x23, #0x11              // =17
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
               	bl	0x4004d8 <.text+0x258>
               	cmp	x0, #0x0
               	b.ne	0x400a04 <.text+0x784>
               	mov	x0, #0x12               // =18
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
               	bl	0x4004d8 <.text+0x258>
               	cmp	x0, #0x0
               	b.ne	0x400a40 <.text+0x7c0>
               	mov	x0, #0x13               // =19
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
               	bl	0x4004d8 <.text+0x258>
               	cbz	x0, 0x400a7c <.text+0x7fc>
               	mov	x22, #0x14              // =20
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x2a              // =42
               	mov	x0, x23
               	bl	0x4004f4 <.text+0x274>
               	mov	x23, #0x4045000000000000 // =4631107791820423168
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x400ac4 <.text+0x844>
               	mov	x23, #0x15              // =21
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0xfffd            // =65533
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x0, x22
               	bl	0x4004f4 <.text+0x274>
               	mov	x22, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x22
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x22, ne
               	cbz	x22, 0x400b18 <.text+0x898>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x400e000000000000 // =4615626668101337088
               	mov	x0, x20
               	bl	0x400504 <.text+0x284>
               	cmp	x0, #0x3
               	b.eq	0x400b4c <.text+0x8cc>
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	x16, d7
               	sub	x17, x29, #0x150
               	str	x16, [x17]
               	sub	x16, x29, #0x150
               	ldr	x22, [x16]
               	mov	x0, x22
               	bl	0x400504 <.text+0x284>
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400bac <.text+0x92c>
               	mov	x0, #0x18               // =24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x999a            // =39322
               	movk	x20, #0x9999, lsl #16
               	movk	x20, #0x9999, lsl #32
               	movk	x20, #0x3fb9, lsl #48
               	mov	x0, x20
               	bl	0x400514 <.text+0x294>
               	fmov	d0, x0
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x23, eq
               	cbz	x23, 0x400bf8 <.text+0x978>
               	mov	x0, #0x19               // =25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x4000000000000000 // =4611686018427387904
               	mov	x0, x22
               	bl	0x400514 <.text+0x294>
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x20, ne
               	cbz	x20, 0x400c38 <.text+0x9b8>
               	mov	x0, #0x1a               // =26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
