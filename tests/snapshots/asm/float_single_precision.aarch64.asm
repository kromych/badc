
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
               	movi	d0, #0000000000000000
               	fcmpe	s0, s0
               	b.pl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	fmov	s1, w17
               	adrp	x16, <page>
               	ldr	s2, [x16]
               	fcmpe	s1, s2
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ret
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x4]
               	fcmpe	s0, s0
               	b.pl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	fmov	s2, w17
               	adrp	x16, <page>
               	ldr	s3, [x16, #0x8]
               	fcmpe	s2, s3
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	ret
               	fcmpe	s0, s0
               	b.pl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	fmov	s0, w17
               	adrp	x16, <page>
               	ldr	s1, [x16, #0xc]
               	fcmpe	s0, s1
               	b.le	<addr>
               	mov	x0, #0x4                // =4
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	movi	d0, #0000000000000000
               	b	<addr>
               	fmov	s2, #1.00000000
               	fcmp	s1, s2
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	movi	d2, #0000000000000000
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	movi	d1, #0000000000000000
               	b	<addr>
