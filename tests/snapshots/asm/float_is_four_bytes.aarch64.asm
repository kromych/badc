
float_is_four_bytes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2f0              // =752
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x110
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x116
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x11d
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<passthrough>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<add3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	str	s0, [x0]
               	sub	x0, x29, #0x10
               	fmov	d0, d1
               	str	s0, [x0]
               	sub	x0, x29, #0x18
               	fmov	d0, d2
               	str	s0, [x0]
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	sub	x16, x29, #0x10
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
               	sub	x16, x29, #0x18
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x138
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x1               // =1
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x1, x29, #0x10
               	str	s0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x169
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x3               // =3
               	b	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x1
               	fcvt	s0, d16
               	str	s0, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x17e
               	mov	x20, #0x4               // =4
               	ldrsw	x0, [x0, #0x4]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldr	s0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x5               // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x128
               	add	x1, x0, #0x4
               	sub	x1, x1, x0
               	cmp	x1, #0x4
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1bd
               	adrp	x2, <page>
               	add	x2, x2, #0x128
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
               	add	x0, x0, #0x128
               	ldr	s0, [x0]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d4
               	adrp	x1, <page>
               	add	x1, x1, #0x128
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x7               // =7
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x128
               	add	x0, x0, #0x4
               	ldr	s0, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e8
               	adrp	x1, <page>
               	add	x1, x1, #0x128
               	add	x1, x1, #0x4
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x8               // =8
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x128
               	add	x0, x0, #0x8
               	ldr	s0, [x0]
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1fc
               	adrp	x1, <page>
               	add	x1, x1, #0x128
               	add	x1, x1, #0x8
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x9               // =9
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x128
               	add	x0, x0, #0xc
               	ldr	s0, [x0]
               	mov	x0, #0x4012000000000000 // =4616752568008179712
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x210
               	adrp	x1, <page>
               	add	x1, x1, #0x128
               	add	x1, x1, #0xc
               	ldr	s0, [x1]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xa               // =10
               	b	<addr>
               	mov	x21, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x21
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x224
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xb               // =11
               	b	<addr>
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x21
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x23b
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xc               // =12
               	b	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fcvt	s0, d16
               	bl	<addr>
               	fmov	d8, d0
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fcvt	s0, d16
               	bl	<addr>
               	fcmp	s8, s0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x252
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xd               // =13
               	b	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x27c
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s1, d16
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fcvt	s2, d16
               	bl	<addr>
               	fcvt	d0, s0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xe               // =14
               	b	<addr>
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x30
               	str	s0, [x0]
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x38
               	str	s0, [x0]
               	sub	x16, x29, #0x30
               	ldr	s0, [x16]
               	sub	x16, x29, #0x38
               	ldr	s1, [x16]
               	fmul	s0, s0, s1
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fcvt	d0, s0
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	sub	x0, x29, #0x40
               	str	s0, [x0]
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	mov	x0, #0x400a000000000000 // =4614500768194494464
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x28c
               	sub	x16, x29, #0x40
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0xf               // =15
               	b	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fcvt	s0, d16
               	sub	x0, x29, #0x48
               	str	s0, [x0]
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
               	add	x0, x0, #0x2a1
               	ldur	w1, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x10              // =16
               	b	<addr>
               	sxtw	x0, w20
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	d8, [sp]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0xa0
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
