
float_register_resident.aarch64:	file format elf64-littleaarch64

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
               	movi	d2, #0000000000000000
               	fmov	s1, #0.50000000
               	fmul	s3, s2, s1
               	fmov	s0, #2.00000000
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #1.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmul	s3, s0, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #3.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #4.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #5.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #6.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #7.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #8.00000000
               	fmul	s3, s3, s1
               	fmadd	s2, s3, s0, s2
               	fmov	s3, #9.00000000
               	fmul	s1, s3, s1
               	fmadd	s0, s1, s0, s2
               	fcvtzs	x0, s0
               	ret
