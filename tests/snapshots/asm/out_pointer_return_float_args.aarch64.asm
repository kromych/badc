
out_pointer_return_float_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<mkf4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	str	s1, [x0, #0x4]
               	str	s2, [x0, #0x8]
               	str	s3, [x0, #0xc]
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
               	str	d1, [x0, #0x8]
               	str	d2, [x0, #0x10]
               	mov	x16, x0
               	ldr	d0, [x16]
               	ldr	d1, [x16, #0x8]
               	ldr	d2, [x16, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x20, #0x3f800000        // =1065353216
               	mov	x21, #0x40000000        // =1073741824
               	mov	x22, #0x40400000        // =1077936128
               	mov	x23, #0x40800000        // =1082130432
               	fmov	d0, x20
               	fmov	d1, x21
               	fmov	d2, x22
               	fmov	d3, x23
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	s0, [x16]
               	str	s1, [x16, #0x4]
               	str	s2, [x16, #0x8]
               	str	s3, [x16, #0xc]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	ldr	s0, [x1]
               	fmov	s17, w20
               	fcmp	s0, s17
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	s0, [x1, #0x4]
               	fmov	s17, w21
               	fcmp	s0, s17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	s0, [x1, #0x8]
               	fmov	s17, w22
               	fcmp	s0, s17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	s0, [x1, #0xc]
               	fmov	s17, w23
               	fcmp	s0, s17
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x1, #0x3fc00000         // =1069547520
               	mov	x2, #0x40200000         // =1075838976
               	mov	x3, #0x40600000         // =1080033280
               	mov	x4, #0x40900000         // =1083179008
               	mov	x5, #0x40b00000         // =1085276160
               	sub	x21, x29, #0x18
               	fmov	s16, w1
               	str	s16, [x21]
               	fmov	s16, w2
               	str	s16, [x21, #0x4]
               	fmov	s16, w3
               	str	s16, [x21, #0x8]
               	fmov	s16, w4
               	str	s16, [x21, #0xc]
               	fmov	s16, w5
               	str	s16, [x21, #0x10]
               	sub	x20, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x20, #0x8]
               	ldrb	w10, [x21, #0x10]
               	strb	w10, [x20, #0x10]
               	ldrb	w10, [x21, #0x11]
               	strb	w10, [x20, #0x11]
               	ldrb	w10, [x21, #0x12]
               	strb	w10, [x20, #0x12]
               	ldrb	w10, [x21, #0x13]
               	strb	w10, [x20, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x6, x20
               	ldr	s0, [x20]
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.ne	<addr>
               	ldr	s0, [x20, #0x4]
               	fmov	s17, w2
               	fcmp	s0, s17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	s0, [x20, #0x8]
               	fmov	s17, w3
               	fcmp	s0, s17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	s0, [x20, #0xc]
               	fmov	s17, w4
               	fcmp	s0, s17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	s0, [x20, #0x10]
               	fmov	s17, w5
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x22, #0x4024000000000000 // =4621819117588971520
               	mov	x1, #0x4034000000000000 // =4626322717216342016
               	mov	x2, #0x403e000000000000 // =4629137466983448576
               	fmov	d0, x22
               	fmov	d1, x1
               	fmov	d2, x2
               	bl	<addr>
               	sub	x16, x29, #0x18
               	str	d0, [x16]
               	str	d1, [x16, #0x8]
               	str	d2, [x16, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x20]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x21, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	ldr	d0, [x20]
               	fmov	d17, x22
               	fcmp	d0, d17
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	d0, [x20, #0x8]
               	mov	x0, #0x4034000000000000 // =4626322717216342016
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x403e000000000000 // =4629137466983448576
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
