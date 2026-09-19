
fp_param_float_before_double.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #2.50000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s0, #6.50000000
               	fcvt	d0, s0
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	d3, #4.00000000
               	fcvt	d0, s0
               	fadd	d0, d0, d1
               	fcvt	d1, s2
               	fadd	d0, d0, d1
               	fadd	d1, d0, d3
               	fmov	d0, #10.00000000
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d1, #5.00000000
               	fmov	s2, #6.00000000
               	fcvt	d2, s2
               	fmadd	d0, d1, d0, d2
               	mov	x16, #0x404c000000000000 // =4633078116657397760
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
