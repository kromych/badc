
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
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s1, w16
               	fmov	s2, #1.00000000
               	fmov	s0, #2.00000000
               	fsub	s1, s1, s0
               	fadd	s3, s1, s2
               	fmov	d1, #1.00000000
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d2, d2, d1
               	fcvt	s2, d2
               	fsub	s3, s3, s0
               	fadd	s3, s3, s2
               	fcvt	d2, s2
               	fadd	d1, d2, d1
               	fcvt	s1, d1
               	mov	x16, #0x42f00000        // =1123024896
               	fmov	s2, w16
               	fcmp	s3, s2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s2, #9.00000000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s1, #0.50000000
               	fmov	d2, #-1.00000000
               	fcvt	d1, s1
               	fadd	d1, d1, d2
               	fcvt	s1, d1
               	fmov	s2, #-0.50000000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s1, #3.00000000
               	fmov	d2, #4.00000000
               	fcvt	d1, s1
               	fmul	d1, d1, d2
               	fcvt	s1, d1
               	fdiv	s0, s1, s0
               	fmov	s1, #6.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
