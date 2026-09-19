
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
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x40000000         // =1073741824
               	mov	x2, #0x40400000         // =1077936128
               	mov	x3, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w1
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w2
               	fmov	s17, w2
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w3
               	fmov	s17, w3
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x1, #0x40200000         // =1075838976
               	mov	x2, #0x40600000         // =1080033280
               	mov	x3, #0x40900000         // =1083179008
               	mov	x4, #0x40b00000         // =1085276160
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w1
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w2
               	fmov	s17, w2
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w3
               	fmov	s17, w3
               	fcmp	s16, s17
               	b.ne	<addr>
               	fmov	s16, w4
               	fmov	s17, w4
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	mov	x1, #0x4034000000000000 // =4626322717216342016
               	mov	x2, #0x403e000000000000 // =4629137466983448576
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.ne	<addr>
               	fmov	d16, x2
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
