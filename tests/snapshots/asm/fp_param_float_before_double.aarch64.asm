
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
               	fmov	d0, #10.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x16, #0x404c000000000000 // =4633078116657397760
               	fmov	d0, x16
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
