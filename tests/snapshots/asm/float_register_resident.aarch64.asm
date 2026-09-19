
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
               	mov	x0, #0x0                // =0
               	scvtf	s1, x0
               	fmov	s0, #0.50000000
               	fmul	s3, s1, s0
               	fmov	s1, #2.00000000
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x1                // =1
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x2                // =2
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x3                // =3
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x4                // =4
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x5                // =5
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x6                // =6
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x7                // =7
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x8                // =8
               	scvtf	s3, x0
               	fmul	s3, s3, s0
               	fmadd	s2, s3, s1, s2
               	mov	x0, #0x9                // =9
               	scvtf	s3, x0
               	fmul	s0, s3, s0
               	fmadd	s0, s0, s1, s2
               	fcvtzs	x0, s0
               	sxtw	x0, w0
               	ret
