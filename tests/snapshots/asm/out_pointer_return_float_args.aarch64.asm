
out_pointer_return_float_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<mkf4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	str	s0, [x0]
               	sub	x0, x29, #0x18
               	str	s1, [x0, #0x4]
               	sub	x0, x29, #0x18
               	str	s2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	str	s3, [x0, #0xc]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	s0, [x16]
               	ldr	s1, [x16, #0x4]
               	ldr	s2, [x16, #0x8]
               	ldr	s3, [x16, #0xc]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkd3>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	str	d0, [x0]
               	sub	x0, x29, #0x18
               	str	d1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	str	d2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	d0, [x16]
               	ldr	d1, [x16, #0x8]
               	ldr	d2, [x16, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	mov	x20, #0x3f800000        // =1065353216
               	mov	x1, #0x40000000         // =1073741824
               	mov	x2, #0x40400000         // =1077936128
               	mov	x3, #0x40800000         // =1082130432
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	fmov	d3, x3
               	bl	<addr>
               	sub	x16, x29, #0x40
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	str	s2, [x16, #0x8]
               	str	s3, [x16, #0xc]
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x50
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x50
               	ldr	s0, [x0]
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldr	s0, [x0, #0x4]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x50
               	ldr	s0, [x0, #0x8]
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x2, #0x40200000         // =1075838976
               	mov	x3, #0x40600000         // =1080033280
               	mov	x4, #0x40900000         // =1083179008
               	mov	x5, #0x40b00000         // =1085276160
               	sub	x1, x29, #0x30
               	fmov	s16, w0
               	str	s16, [x1]
               	sub	x1, x29, #0x30
               	fmov	s16, w2
               	str	s16, [x1, #0x4]
               	sub	x1, x29, #0x30
               	fmov	s16, w3
               	str	s16, [x1, #0x8]
               	sub	x1, x29, #0x30
               	fmov	s16, w4
               	str	s16, [x1, #0xc]
               	sub	x1, x29, #0x30
               	fmov	s16, w5
               	str	s16, [x1, #0x10]
               	sub	x1, x29, #0x30
               	sub	x2, x29, #0x78
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x2, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x2, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x2, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x2, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x78
               	ldr	s0, [x1]
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x78
               	ldr	s0, [x0, #0x4]
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x78
               	ldr	s0, [x0, #0x8]
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x78
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40900000         // =1083179008
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x78
               	ldr	s0, [x0, #0x10]
               	mov	x0, #0x40b00000         // =1085276160
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x20, #0x4024000000000000 // =4621819117588971520
               	mov	x1, #0x4034000000000000 // =4626322717216342016
               	mov	x2, #0x403e000000000000 // =4629137466983448576
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	bl	<addr>
               	sub	x16, x29, #0x18
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xa8
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xa8
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4034000000000000 // =4626322717216342016
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x403e000000000000 // =4629137466983448576
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
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
