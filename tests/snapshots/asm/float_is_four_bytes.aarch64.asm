
float_is_four_bytes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400528 <.text+0x228>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
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
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x126
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400d38 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldur	x15, [x29, #0x10]
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
               	add	sp, sp, #0x10
               	ret
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	ldur	x15, [x29, #0x10]
               	sub	x14, x29, #0x8
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x14]
               	ldur	x14, [x29, #0x20]
               	sub	x15, x29, #0x10
               	fmov	d0, x14
               	fcvt	s0, d0
               	str	s0, [x15]
               	ldur	x15, [x29, #0x30]
               	sub	x14, x29, #0x18
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x14]
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fadd	d5, d7, d6
               	sub	x16, x29, #0x18
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fadd	d0, d5, d6
               	fmov	x0, d0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x22, [sp, #0x20]
               	str	x23, [sp, #0x28]
               	str	x24, [sp, #0x30]
               	str	x25, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	cbz	x15, 0x400594 <.text+0x294>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x168
               	mov	x20, x19
               	mov	x21, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x8]
               	b	0x400594 <.text+0x294>
               	mov	x13, #0x0               // =0
               	cbz	x13, 0x4005cc <.text+0x2cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x180
               	mov	x22, x19
               	mov	x21, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x2               // =2
               	stur	w20, [x29, #-0x8]
               	b	0x4005cc <.text+0x2cc>
               	mov	x20, #0x0               // =0
               	sub	x21, x29, #0x10
               	fmov	d0, x20
               	fcvt	s0, d0
               	str	s0, [x21]
               	cbz	x20, 0x400614 <.text+0x314>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x199
               	mov	x23, x19
               	mov	x21, #0x4               // =4
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x3               // =3
               	stur	w22, [x29, #-0x8]
               	b	0x400614 <.text+0x314>
               	sub	x22, x29, #0x18
               	mov	x21, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x21
               	fcvt	s0, d0
               	str	s0, [x22]
               	sub	x21, x29, #0x18
               	add	x22, x21, #0x4
               	mov	x21, #0x5678            // =22136
               	movk	x21, #0x1234, lsl #16
               	str	w21, [x22]
               	sub	x23, x29, #0x18
               	add	x21, x23, #0x4
               	ldrsw	x22, [x21]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x22, x17
               	b.eq	0x40068c <.text+0x38c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ae
               	mov	x20, x19
               	mov	x22, #0x4               // =4
               	add	x12, x23, #0x4
               	ldrsw	x21, [x12]
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	stur	w22, [x29, #-0x8]
               	b	0x40068c <.text+0x38c>
               	sub	x22, x29, #0x18
               	ldr	s7, [x22]
               	fcvt	d7, s7
               	mov	x22, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x22
               	fcmp	d7, d1
               	cset	x12, ne
               	cbz	x12, 0x4006d4 <.text+0x3d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d3
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x5               // =5
               	stur	w12, [x29, #-0x8]
               	b	0x4006d4 <.text+0x3d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x12, x19
               	add	x23, x12, #0x4
               	sub	x21, x23, x12
               	cmp	x21, #0x4
               	b.eq	0x400730 <.text+0x430>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ed
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	add	x20, x23, #0x4
               	sub	x21, x20, x12
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x6               // =6
               	stur	w20, [x29, #-0x8]
               	b	0x400730 <.text+0x430>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	ldr	s7, [x20]
               	fcvt	d7, s7
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x20
               	fcmp	d7, d1
               	cset	x21, ne
               	cbz	x21, 0x40079c <.text+0x49c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x204
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	ldr	s8, [x21]
               	fcvt	d8, s8
               	fmov	x16, d8
               	fmov	d0, x16
               	mov	x0, x23
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x7               // =7
               	stur	w21, [x29, #-0x8]
               	b	0x40079c <.text+0x49c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	add	x23, x21, #0x4
               	ldr	s8, [x23]
               	fcvt	d8, s8
               	mov	x23, #0x4004000000000000 // =4612811918334230528
               	fmov	d1, x23
               	fcmp	d8, d1
               	cset	x21, ne
               	cbz	x21, 0x400810 <.text+0x510>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x218
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	add	x22, x21, #0x4
               	ldr	s9, [x22]
               	fcvt	d9, s9
               	fmov	x16, d9
               	fmov	d0, x16
               	mov	x0, x20
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x8               // =8
               	stur	w22, [x29, #-0x8]
               	b	0x400810 <.text+0x510>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	add	x20, x22, #0x8
               	ldr	s9, [x20]
               	fcvt	d9, s9
               	mov	x20, #0x400c000000000000 // =4615063718147915776
               	fmov	d1, x20
               	fcmp	d9, d1
               	cset	x22, ne
               	cbz	x22, 0x400884 <.text+0x584>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22c
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	add	x21, x22, #0x8
               	ldr	s8, [x21]
               	fcvt	d8, s8
               	fmov	x16, d8
               	fmov	d0, x16
               	mov	x0, x23
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x9               // =9
               	stur	w21, [x29, #-0x8]
               	b	0x400884 <.text+0x584>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	add	x23, x21, #0xc
               	ldr	s8, [x23]
               	fcvt	d8, s8
               	mov	x23, #0x4012000000000000 // =4616752568008179712
               	fmov	d1, x23
               	fcmp	d8, d1
               	cset	x21, ne
               	cbz	x21, 0x4008f8 <.text+0x5f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x240
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	add	x22, x21, #0xc
               	ldr	s9, [x22]
               	fcvt	d9, s9
               	fmov	x16, d9
               	fmov	d0, x16
               	mov	x0, x20
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0xa               // =10
               	stur	w22, [x29, #-0x8]
               	b	0x4008f8 <.text+0x5f8>
               	mov	x23, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, x23
               	bl	0x400450 <.text+0x150>
               	mov	x20, x0
               	fmov	d0, x20
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400944 <.text+0x644>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x254
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xb               // =11
               	stur	w21, [x29, #-0x8]
               	b	0x400944 <.text+0x644>
               	mov	x20, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x20
               	bl	0x400450 <.text+0x150>
               	mov	x22, x0
               	fmov	d0, x22
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x23, ne
               	cbz	x23, 0x400990 <.text+0x690>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26b
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0xc               // =12
               	stur	w23, [x29, #-0x8]
               	b	0x400990 <.text+0x690>
               	mov	x22, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, x22
               	bl	0x400450 <.text+0x150>
               	mov	x23, x0
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x21
               	bl	0x400450 <.text+0x150>
               	mov	x20, x0
               	fmov	d0, x23
               	fmov	d1, x20
               	fcmp	d0, d1
               	cset	x21, eq
               	cbz	x21, 0x4009ec <.text+0x6ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x282
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xd               // =13
               	stur	w21, [x29, #-0x8]
               	b	0x4009ec <.text+0x6ec>
               	mov	x20, #0x3ff0000000000000 // =4607182418800017408
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	mov	x22, #0x400c000000000000 // =4615063718147915776
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400494 <.text+0x194>
               	mov	x12, x0
               	mov	x22, #0x401a000000000000 // =4619004367821864960
               	fmov	d0, x12
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x21, ne
               	cbz	x21, 0x400a88 <.text+0x788>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2ac
               	mov	x23, x19
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x12, #0x4000000000000000 // =4611686018427387904
               	mov	x20, #0x400c000000000000 // =4615063718147915776
               	stur	x21, [x29, #-0xa8]
               	ldur	x22, [x29, #-0xa8]
               	stur	x12, [x29, #-0xb0]
               	ldur	x24, [x29, #-0xb0]
               	stur	x20, [x29, #-0xb8]
               	ldur	x21, [x29, #-0xb8]
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x400494 <.text+0x194>
               	mov	x25, x0
               	fmov	d0, x25
               	mov	x0, x23
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xe               // =14
               	stur	w21, [x29, #-0x8]
               	b	0x400a88 <.text+0x788>
               	mov	x21, #0x3ff8000000000000 // =4609434218613702656
               	sub	x25, x29, #0x30
               	fmov	d0, x21
               	fcvt	s0, d0
               	str	s0, [x25]
               	mov	x25, #0x4000000000000000 // =4611686018427387904
               	sub	x21, x29, #0x38
               	fmov	d0, x25
               	fcvt	s0, d0
               	str	s0, [x21]
               	sub	x16, x29, #0x30
               	ldr	s9, [x16]
               	fcvt	d9, s9
               	sub	x16, x29, #0x38
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmul	d5, d9, d6
               	mov	x21, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d1, x21
               	fadd	d6, d5, d1
               	sub	x21, x29, #0x40
               	fcvt	s0, d6
               	str	s0, [x21]
               	sub	x16, x29, #0x40
               	ldr	s5, [x16]
               	fcvt	d5, s5
               	mov	x21, #0x400a000000000000 // =4614500768194494464
               	fmov	d1, x21
               	fcmp	d5, d1
               	cset	x25, ne
               	cbz	x25, 0x400b40 <.text+0x840>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bc
               	mov	x20, x19
               	sub	x16, x29, #0x40
               	ldr	s8, [x16]
               	fcvt	d8, s8
               	fmov	x16, d8
               	fmov	d0, x16
               	mov	x0, x20
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0xf               // =15
               	stur	w25, [x29, #-0x8]
               	b	0x400b40 <.text+0x840>
               	mov	x25, #0x3ff0000000000000 // =4607182418800017408
               	sub	x20, x29, #0x48
               	fmov	d0, x25
               	fcvt	s0, d0
               	str	s0, [x20]
               	sub	x21, x29, #0x50
               	sub	x20, x29, #0x48
               	mov	x25, #0x4               // =4
               	mov	x0, x21
               	mov	x2, x25
               	mov	x1, x20
               	bl	0x400d50 <memcpy>
               	mov	x24, x0
               	ldur	w24, [x29, #-0x50]
               	mov	x17, #0x3f800000        // =1065353216
               	eor	x25, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	cmp	x24, #0x0
               	b.eq	0x400bc4 <.text+0x8c4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d1
               	mov	x23, x19
               	ldur	w24, [x29, #-0x50]
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x400d44 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x10              // =16
               	stur	w20, [x29, #-0x8]
               	b	0x400bc4 <.text+0x8c4>
               	ldursw	x20, [x29, #-0x8]
               	mov	x0, x20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	x23, [sp, #0x28]
               	ldr	x24, [sp, #0x30]
               	ldr	x25, [sp, #0x38]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
