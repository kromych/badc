
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
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmpe	d16, d17
               	b.pl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x17
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmpe	d0, d1
               	b.le	<addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, x1
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmpe	d16, d17
               	b.pl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x17
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmpe	d0, d1
               	b.le	<addr>
               	mov	x1, #0x2                // =2
               	cbz	w1, <addr>
               	mov	x0, x1
               	ret
               	movi	d0, #0000000000000000
               	fcmpe	s0, s0
               	b.pl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	fmov	s1, w17
               	adrp	x16, <page>
               	ldr	s2, [x16, #0x28]
               	fcmpe	s1, s2
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	cbz	w0, <addr>
               	ret
               	fcmpe	s0, s0
               	b.pl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	fmov	s0, w17
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x2c]
               	fcmpe	s0, s1
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fmov	d17, x0
               	fcmpe	d1, d17
               	b.pl	<addr>
               	adrp	x17, <page>
               	ldr	d1, [x17, #0x18]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x20]
               	fcmpe	d1, d2
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	adrp	x17, <page>
               	ldr	d1, [x17, #0x10]
               	b	<addr>
               	movi	d1, #0000000000000000
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
