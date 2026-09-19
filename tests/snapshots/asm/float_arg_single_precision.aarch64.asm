
float_arg_single_precision.aarch64:	file format elf64-littleaarch64

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
               	fmov	s1, #1.50000000
               	fmov	s0, #0.25000000
               	fmul	s1, s1, s0
               	fmov	s2, #0.37500000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s1, #-2.50000000
               	fmov	s2, #4.00000000
               	fmul	s1, s1, s2
               	fmov	s2, #-10.00000000
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s1, #0.50000000
               	fmov	s2, #0.12500000
               	fadd	s0, s1, s0
               	fadd	s0, s0, s2
               	fmov	s1, #0.87500000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s0, #1.00000000
               	fmov	s1, #8.00000000
               	fdiv	s0, s0, s1
               	fmov	s1, #16.00000000
               	fmul	s0, s0, s1
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
