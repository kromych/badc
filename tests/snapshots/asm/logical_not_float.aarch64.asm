
logical_not_float.aarch64:	file format elf64-littleaarch64

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
               	fcmp	d16, d17
               	cset	x1, eq
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, eq
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0xf359             // =62297
               	movk	x1, #0xc2f8, lsl #16
               	movk	x1, #0x6e1f, lsl #32
               	movk	x1, #0x1a5, lsl #48
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x1, #0x0                // =0
               	fmov	s16, w1
               	fcvt	d0, s16
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, eq
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x1, #0x40600000         // =1080033280
               	fmov	s16, w1
               	fcvt	d0, s16
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, eq
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.ne	<addr>
               	ret
               	mov	x0, #0x8                // =8
               	ret
