
out_pointer_return_float_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x30
               	str	s0, [x0]
               	sub	x0, x29, #0x30
               	str	s1, [x0, #0x4]
               	sub	x0, x29, #0x30
               	str	s2, [x0, #0x8]
               	sub	x0, x29, #0x30
               	str	s3, [x0, #0xc]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	s0, [x16]
               	ldr	s1, [x16, #0x4]
               	ldr	s2, [x16, #0x8]
               	ldr	s3, [x16, #0xc]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<mkf5>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x48
               	str	x8, [x16]
               	sub	x0, x29, #0x40
               	str	s0, [x0]
               	sub	x0, x29, #0x40
               	str	s1, [x0, #0x4]
               	sub	x0, x29, #0x40
               	str	s2, [x0, #0x8]
               	sub	x0, x29, #0x40
               	str	s3, [x0, #0xc]
               	sub	x0, x29, #0x40
               	str	s4, [x0, #0x10]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	sub	x17, x29, #0x48
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldrb	w0, [x16, #0x10]
               	strb	w0, [x17, #0x10]
               	ldrb	w0, [x16, #0x11]
               	strb	w0, [x17, #0x11]
               	ldrb	w0, [x16, #0x12]
               	strb	w0, [x17, #0x12]
               	ldrb	w0, [x16, #0x13]
               	strb	w0, [x17, #0x13]
               	mov	x0, x17
               	add	sp, sp, #0x50
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	mov	x20, #0x3f800000        // =1065353216
               	mov	x1, #0x40000000         // =1073741824
               	mov	x2, #0x40400000         // =1077936128
               	mov	x3, #0x40800000         // =1082130432
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	fmov	d3, x3
               	bl	<addr>
               	sub	x16, x29, #0xa8
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	str	s2, [x16, #0x8]
               	str	s3, [x16, #0xc]
               	sub	x0, x29, #0xa8
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x10
               	ldr	s0, [x0]
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	s0, [x0, #0x4]
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldr	s0, [x0, #0x8]
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3fc00000        // =1069547520
               	mov	x1, #0x40200000         // =1075838976
               	mov	x2, #0x40600000         // =1080033280
               	mov	x3, #0x40900000         // =1083179008
               	mov	x4, #0x40b00000         // =1085276160
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	fmov	d3, x3
               	fmov	d4, x4
               	sub	x8, x29, #0xd8
               	bl	<addr>
               	sub	x0, x29, #0xd8
               	sub	x1, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x1, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x1, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x1, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x1, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x38
               	ldr	s0, [x0]
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x38
               	ldr	s0, [x0, #0x4]
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	ldr	s0, [x0, #0x8]
               	mov	x0, #0x40600000         // =1080033280
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x38
               	ldr	s0, [x0, #0xc]
               	mov	x0, #0x40900000         // =1083179008
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x38
               	ldr	s0, [x0, #0x10]
               	mov	x0, #0x40b00000         // =1085276160
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x4024000000000000 // =4621819117588971520
               	mov	x1, #0x4034000000000000 // =4626322717216342016
               	mov	x2, #0x403e000000000000 // =4629137466983448576
               	fmov	d0, x20
               	fmov	d1, x1
               	fmov	d2, x2
               	bl	<addr>
               	sub	x16, x29, #0x110
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x68
               	ldr	d0, [x0]
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x68
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4034000000000000 // =4626322717216342016
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x68
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x403e000000000000 // =4629137466983448576
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x130
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
