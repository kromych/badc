
float_ternary_promote.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #1.50000000
               	fmov	s1, #1.50000000
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s0, #2.50000000
               	fneg	s0, s0
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s0, #3.25000000
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.le	<addr>
               	fmov	s2, #3.25000000
               	fcmp	s0, s1
               	b.pl	<addr>
               	fneg	s0, s0
               	fadd	s0, s2, s0
               	fmov	s1, #6.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	s0, #20.00000000
               	fmov	s1, #20.00000000
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	fmov	s0, #3.25000000
               	b	<addr>
               	fneg	s2, s0
               	b	<addr>
