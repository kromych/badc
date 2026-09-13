
compound_assign_float_register_resident.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x42c80000         // =1120403456
               	mov	x2, #0x3f800000         // =1065353216
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s16, w1
               	fmov	s17, w0
               	fsub	s0, s16, s17
               	fmov	s17, w2
               	fadd	s1, s0, s17
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	s16, w2
               	fcvt	d0, s16
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fsub	s1, s1, s17
               	fadd	s1, s1, s0
               	fcvt	d0, s0
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	mov	x1, #0x42f00000         // =1123024896
               	fmov	s17, w1
               	fcmp	s1, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x41100000         // =1091567616
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x3f000000         // =1056964608
               	mov	x2, #-0x4010000000000000 // =-4616189618054758400
               	fmov	s16, w1
               	fcvt	d0, s16
               	fmov	d17, x2
               	fadd	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s16, w1
               	fneg	s1, s16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0x40400000         // =1077936128
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	s16, w1
               	fcvt	d0, s16
               	fmov	d17, x2
               	fmul	d0, d0, d17
               	fcvt	s0, d0
               	fmov	s17, w0
               	fdiv	s0, s0, s17
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
