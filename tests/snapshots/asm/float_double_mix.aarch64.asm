
float_double_mix.aarch64:	file format elf64-littleaarch64

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
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fadd	d0, d1, d0
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x10]
               	fsub	d0, d0, d2
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x18]
               	fcmpe	d0, d2
               	b.le	<addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, x1
               	ret
               	fsub	d0, d1, d1
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x20]
               	fcmpe	d0, d1
               	b.le	<addr>
               	mov	x1, #0x2                // =2
               	cbz	w1, <addr>
               	mov	x0, x1
               	ret
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x28]
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x40]
               	fsub	s0, s0, s0
               	movi	d1, #0000000000000000
               	fcmpe	s0, s1
               	b.pl	<addr>
               	fneg	s0, s0
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x44]
               	fcmpe	s0, s3
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	cbz	w0, <addr>
               	ret
               	fmov	d0, #1.00000000
               	fmov	d2, #3.00000000
               	fdiv	d0, d0, d2
               	fcvt	s0, d0
               	adrp	x16, <page>
               	ldr	s2, [x16, #0x48]
               	fsub	s0, s0, s2
               	fcmpe	s0, s1
               	b.pl	<addr>
               	fneg	s0, s0
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x4c]
               	fcmpe	s0, s1
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x30]
               	fsub	d0, d0, d2
               	fmov	d17, x0
               	fcmpe	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x38]
               	fcmpe	d0, d2
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
