
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
               	fmov	d0, #5.00000000
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, eq
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	movi	d0, #0000000000000000
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x1, eq
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	s0, #3.50000000
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d0, #2.00000000
               	fmov	d17, x0
               	fcmp	d0, d17
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
