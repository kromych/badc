
float_is_four_bytes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x108
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x108
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x120
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x126
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x12d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x108
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x108
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
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
               	fadd	d7, d7, d6
               	sub	x16, x29, #0x18
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fadd	d0, d7, d6
               	fmov	x0, d0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x168
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x180
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x2               // =2
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	sub	x1, x29, #0x10
               	fmov	d0, x13
               	fcvt	s0, d0
               	str	s0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x199
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x3               // =3
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	sub	x13, x29, #0x18
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x1
               	fcvt	s0, d0
               	str	s0, [x13]
               	sub	x1, x29, #0x18
               	add	x1, x1, #0x4
               	mov	x13, #0x5678            // =22136
               	movk	x13, #0x1234, lsl #16
               	str	w13, [x1]
               	sub	x0, x29, #0x18
               	add	x13, x0, #0x4
               	ldrsw	x13, [x13]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1ae
               	mov	x20, #0x4               // =4
               	add	x0, x0, #0x4
               	ldrsw	x12, [x0]
               	mov	x0, x1
               	mov	x1, x12
               	bl	<addr>
               	sxtw	x0, w0
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	sub	x20, x29, #0x18
               	ldr	s7, [x20]
               	fcvt	d7, s7
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x20
               	fcmp	d7, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x1d3
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x20, x0, #0x4
               	sub	x20, x20, x0
               	cmp	x20, #0x4
               	b.eq	<addr>
               	adrp	x12, <page>
               	add	x12, x12, #0x1ed
               	adrp	x20, <page>
               	add	x20, x20, #0x158
               	add	x20, x20, #0x4
               	sub	x1, x20, x0
               	mov	x0, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	ldr	s7, [x0]
               	fcvt	d7, s7
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x204
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	ldr	s7, [x1]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	add	x1, x1, #0x4
               	ldr	s7, [x1]
               	fcvt	d7, s7
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d1, x1
               	fcmp	d7, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x218
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x0, x0, #0x4
               	ldr	s7, [x0]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x8                // =8
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x0, x0, #0x8
               	ldr	s7, [x0]
               	fcvt	d7, s7
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x22c
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	add	x1, x1, #0x8
               	ldr	s7, [x1]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x9                // =9
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	add	x1, x1, #0xc
               	ldr	s7, [x1]
               	fcvt	d7, s7
               	mov	x1, #0x4012000000000000 // =4616752568008179712
               	fmov	d1, x1
               	fcmp	d7, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x240
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x0, x0, #0xc
               	ldr	s7, [x0]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	mov	x0, x1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x21, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, x21
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x21, <page>
               	add	x21, x21, #0x254
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xb                // =11
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x22, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x22
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x22
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x26b
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xc                // =12
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	bl	<addr>
               	mov	x12, x0
               	fmov	d0, x21
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x21, eq
               	cbz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x282
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xd               // =13
               	stur	w21, [x29, #-0x8]
               	b	<addr>
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x400c000000000000 // =4615063718147915776
               	mov	x0, x21
               	bl	<addr>
               	mov	x2, #0x401a000000000000 // =4619004367821864960
               	fmov	d0, x0
               	fmov	d1, x2
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x2ac
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x21, #0x400c000000000000 // =4615063718147915776
               	stur	x0, [x29, #-0xa8]
               	ldur	x0, [x29, #-0xa8]
               	stur	x1, [x29, #-0xb0]
               	ldur	x1, [x29, #-0xb0]
               	stur	x21, [x29, #-0xb8]
               	ldur	x2, [x29, #-0xb8]
               	bl	<addr>
               	mov	x21, x0
               	fmov	d0, x21
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xe                // =14
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	sub	x21, x29, #0x30
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x21]
               	mov	x21, #0x4000000000000000 // =4611686018427387904
               	sub	x0, x29, #0x38
               	fmov	d0, x21
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x16, x29, #0x30
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	sub	x16, x29, #0x38
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmul	d7, d7, d6
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d1, x0
               	fadd	d7, d7, d1
               	sub	x0, x29, #0x40
               	fcvt	s0, d7
               	str	s0, [x0]
               	sub	x16, x29, #0x40
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fmov	d1, x0
               	fcmp	d6, d1
               	cset	x21, ne
               	cbz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2bc
               	sub	x16, x29, #0x40
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fmov	x16, d6
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0xf               // =15
               	stur	w21, [x29, #-0x8]
               	b	<addr>
               	mov	x21, #0x3ff0000000000000 // =4607182418800017408
               	sub	x0, x29, #0x48
               	fmov	d0, x21
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	mov	x21, x0
               	ldur	w21, [x29, #-0x50]
               	mov	x17, #0x3f800000        // =1065353216
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2d1
               	ldur	w1, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x10              // =16
               	stur	w21, [x29, #-0x8]
               	b	<addr>
               	ldursw	x21, [x29, #-0x8]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
