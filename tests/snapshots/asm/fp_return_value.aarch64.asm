
fp_return_value.aarch64:	file format elf64-littleaarch64

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
               	fmov	d1, #7.00000000
               	fmov	d0, #0.50000000
               	fadd	d1, d1, d0
               	fmov	d2, #2.00000000
               	fadd	d3, d2, d0
               	fadd	d1, d1, d3
               	fmov	d3, #10.00000000
               	fcmp	d1, d3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s3, #3.00000000
               	fmov	s1, #4.00000000
               	fdiv	s3, s3, s1
               	fmov	s4, #5.00000000
               	fdiv	s4, s4, s1
               	fadd	s3, s3, s4
               	fmov	s4, #2.00000000
               	fcmp	s3, s4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d3, #1.00000000
               	fadd	d0, d3, d0
               	fmov	s3, #6.00000000
               	fdiv	s1, s3, s1
               	fcvt	d1, s1
               	fmadd	d0, d0, d2, d1
               	fmov	d1, #4.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
