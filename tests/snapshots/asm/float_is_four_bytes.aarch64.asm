
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x108
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x120
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x126
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x12d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	ldur	x0, [x29, #0x10]
               	sub	x1, x29, #0x8
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
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
               	ldur	x0, [x29, #0x10]
               	sub	x1, x29, #0x8
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	ldur	x0, [x29, #0x20]
               	sub	x1, x29, #0x10
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	ldur	x0, [x29, #0x30]
               	sub	x1, x29, #0x18
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	fadd	d0, d0, d1
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	fadd	d0, d0, d1
               	fmov	x0, d0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x168
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x1               // =1
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x180
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x10
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x199
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x3               // =3
               	b	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x1
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x4
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	add	x1, x0, #0x4
               	ldrsw	x1, [x1]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1ae
               	mov	x20, #0x4               // =4
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x5               // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x1, x0, #0x4
               	sub	x1, x1, x0
               	cmp	x1, #0x4
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1ed
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	add	x2, x2, #0x4
               	sub	x0, x2, x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x6               // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x204
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x7               // =7
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x0, x0, #0x4
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x218
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	add	x1, x1, #0x4
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x8               // =8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x0, x0, #0x8
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x22c
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	add	x1, x1, #0x8
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x9               // =9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	add	x0, x0, #0xc
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x240
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	add	x1, x1, #0xc
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xa               // =10
               	b	<addr>
               	mov	x21, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, x21
               	bl	<addr>
               	fmov	d16, x0
               	fmov	d17, x21
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x254
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xb               // =11
               	b	<addr>
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x21
               	bl	<addr>
               	fmov	d16, x0
               	fmov	d17, x21
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x26b
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xc               // =12
               	b	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	bl	<addr>
               	fmov	d16, x21
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x282
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xd               // =13
               	b	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x400c000000000000 // =4615063718147915776
               	bl	<addr>
               	mov	x1, #0x401a000000000000 // =4619004367821864960
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x2ac
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x400c000000000000 // =4615063718147915776
               	bl	<addr>
               	mov	x1, x0
               	fmov	d0, x1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xe               // =14
               	b	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	sub	x1, x29, #0x30
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	sub	x1, x29, #0x38
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	sub	x16, x29, #0x30
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	sub	x16, x29, #0x38
               	ldr	s1, [x16]
               	fcvt	d1, s1
               	fmul	d0, d0, d1
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	sub	x0, x29, #0x40
               	fcvt	s0, d0
               	str	s0, [x0]
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2bc
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xf               // =15
               	b	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	sub	x1, x29, #0x48
               	fmov	d0, x0
               	fcvt	s0, d0
               	str	s0, [x1]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x48
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	ldur	w0, [x29, #-0x50]
               	mov	x17, #0x3f800000        // =1065353216
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2d1
               	ldur	w1, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x10              // =16
               	b	<addr>
               	sxtw	x0, w20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
