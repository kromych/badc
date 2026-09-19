
float_single_precision.aarch64:	file format elf64-littleaarch64

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
               	fmov	s2, #1.00000000
               	fmov	s0, #3.00000000
               	fdiv	s0, s2, s0
               	adrp	x16, <page>
               	ldr	s1, [x16]
               	fsub	s0, s0, s1
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.pl	<addr>
               	fneg	s0, s0
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x4]
               	fcmp	s0, s3
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x8]
               	fadd	s3, s1, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	fadd	s3, s3, s0
               	adrp	x16, <page>
               	ldr	s0, [x16, #0xc]
               	fsub	s0, s3, s0
               	fcmp	s0, s1
               	b.pl	<addr>
               	fneg	s0, s0
               	adrp	x16, <page>
               	ldr	s4, [x16, #0x10]
               	fcmp	s0, s4
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x14]
               	fmul	s2, s0, s0
               	fmul	s2, s2, s0
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x18]
               	fnmsub	s0, s2, s0, s3
               	fcmp	s0, s1
               	b.pl	<addr>
               	fneg	s0, s0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x1c]
               	fcmp	s0, s1
               	b.le	<addr>
               	mov	x0, #0x4                // =4
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	fcmp	s3, s2
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
