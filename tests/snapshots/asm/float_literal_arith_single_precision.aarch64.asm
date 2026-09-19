
float_literal_arith_single_precision.aarch64:	file format elf64-littleaarch64

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
               	fmov	s1, #1.00000000
               	fsub	s0, s0, s1
               	fmov	s2, #1.50000000
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s0, #3.00000000
               	fmov	s2, #8.00000000
               	fmov	s3, #0.50000000
               	fmov	s4, #0.25000000
               	fmul	s2, s2, s4
               	fmadd	s0, s0, s3, s2
               	fmov	s2, #3.50000000
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	movi	d2, #0000000000000000
               	adrp	x16, <page>
               	ldr	s0, [x16]
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s2, s2, s0
               	fadd	s0, s2, s0
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x4]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
