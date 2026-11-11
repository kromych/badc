
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
               	mov	x0, #0x0                // =0
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmpe	d16, d17
               	fmov	d17, x0
               	fcsel	d0, d0, d17, mi
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	mov	x1, #0x1                // =1
               	fcmpe	d0, d1
               	csel	x1, x1, x0, gt
               	cbz	x1, <addr>
               	mov	x0, x1
               	ret
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmpe	d16, d17
               	fmov	d17, x0
               	fcsel	d0, d0, d17, mi
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	mov	x1, #0x2                // =2
               	fcmpe	d0, d1
               	csel	x1, x1, x0, gt
               	cbz	w1, <addr>
               	mov	x0, x1
               	ret
               	movi	d0, #0000000000000000
               	mov	x16, #0x80000000        // =2147483648
               	fmov	s1, w16
               	fcmpe	s0, s0
               	fcsel	s1, s1, s0, mi
               	adrp	x16, <page>
               	ldr	s2, [x16, #0x28]
               	fcmpe	s1, s2
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	cbz	w0, <addr>
               	ret
               	mov	x16, #0x80000000        // =2147483648
               	fmov	s1, w16
               	fcmpe	s0, s0
               	fcsel	s0, s1, s0, mi
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x2c]
               	mov	x0, #0x5                // =5
               	mov	x1, #0x0                // =0
               	fcmpe	s0, s1
               	csel	x0, x0, x1, gt
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x18]
               	fmov	d17, x0
               	fcmpe	d1, d17
               	fcsel	d1, d2, d1, mi
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x20]
               	fcmpe	d1, d2
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
