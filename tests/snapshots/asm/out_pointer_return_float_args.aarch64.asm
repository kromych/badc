
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x2, #0x3f800000         // =1065353216
               	mov	x3, #0x40000000         // =1073741824
               	mov	x4, #0x40400000         // =1077936128
               	mov	x5, #0x40800000         // =1082130432
               	sub	x0, x29, #0x10
               	fmov	s16, w2
               	str	s16, [x0]
               	fmov	s16, w3
               	str	s16, [x0, #0x4]
               	fmov	s16, w4
               	str	s16, [x0, #0x8]
               	fmov	s16, w5
               	str	s16, [x0, #0xc]
               	sub	x1, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	s0, [x1]
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.ne	<addr>
               	ldr	s0, [x1, #0x4]
               	fmov	s17, w3
               	fcmp	s0, s17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	s0, [x1, #0x8]
               	fmov	s17, w4
               	fcmp	s0, s17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	s0, [x1, #0xc]
               	fmov	s17, w5
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x3fc00000         // =1069547520
               	mov	x3, #0x40200000         // =1075838976
               	mov	x4, #0x40600000         // =1080033280
               	mov	x5, #0x40900000         // =1083179008
               	mov	x6, #0x40b00000         // =1085276160
               	sub	x0, x29, #0x18
               	fmov	s16, w2
               	str	s16, [x0]
               	fmov	s16, w3
               	str	s16, [x0, #0x4]
               	fmov	s16, w4
               	str	s16, [x0, #0x8]
               	fmov	s16, w5
               	str	s16, [x0, #0xc]
               	fmov	s16, w6
               	str	s16, [x0, #0x10]
               	sub	x1, x29, #0x30
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
               	ldr	s0, [x1]
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.ne	<addr>
               	ldr	s0, [x1, #0x4]
               	fmov	s17, w3
               	fcmp	s0, s17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	s0, [x1, #0x8]
               	fmov	s17, w4
               	fcmp	s0, s17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	s0, [x1, #0xc]
               	fmov	s17, w5
               	fcmp	s0, s17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	s0, [x1, #0x10]
               	fmov	s17, w6
               	fcmp	s0, s17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x4024000000000000 // =4621819117588971520
               	mov	x3, #0x4034000000000000 // =4626322717216342016
               	mov	x4, #0x403e000000000000 // =4629137466983448576
               	fmov	d16, x2
               	str	d16, [x0]
               	fmov	d16, x3
               	str	d16, [x0, #0x8]
               	fmov	d16, x4
               	str	d16, [x0, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	ldr	d0, [x1]
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x1, #0x8]
               	fmov	d17, x3
               	fcmp	d0, d17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	d0, [x1, #0x10]
               	fmov	d17, x4
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
