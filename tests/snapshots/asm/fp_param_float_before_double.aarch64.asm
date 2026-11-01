
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
               	fmov	d0, #6.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d0, #2.00000000
               	fmov	d1, #4.00000000
               	fmov	d2, #1.00000000
               	fadd	d0, d2, d0
               	fmov	d2, #3.00000000
               	fadd	d0, d0, d2
               	fadd	d1, d0, d1
               	fmov	d0, #10.00000000
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d1, #5.00000000
               	fmov	d2, #6.00000000
               	fmadd	d0, d1, d0, d2
               	mov	x16, #0x404c000000000000 // =4633078116657397760
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
