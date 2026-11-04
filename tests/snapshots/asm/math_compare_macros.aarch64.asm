
math_compare_macros.aarch64:	file format elf64-littleaarch64

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
               	fdiv	d1, d0, d0
               	fmov	d0, #2.00000000
               	fmov	d2, #1.00000000
               	fcmp	d0, d2
               	b.le	<addr>
               	fcmp	d2, d0
               	b.gt	<addr>
               	fcmp	d1, d2
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcmp	d0, d0
               	b.lt	<addr>
               	fmov	d3, #3.00000000
               	fcmp	d3, d0
               	b.lt	<addr>
               	fcmp	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	d2, d0
               	b.pl	<addr>
               	fcmp	d0, d2
               	b.mi	<addr>
               	fcmp	d1, d0
               	b.pl	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d0, d0
               	b.hi	<addr>
               	fcmp	d2, d0
               	b.hi	<addr>
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcmp	d2, d0
               	cset	x0, mi
               	csinc	x0, x0, xzr, le
               	cbz	x0, <addr>
               	fcmp	d0, d0
               	cset	x0, mi
               	csinc	x0, x0, xzr, le
               	cbnz	x0, <addr>
               	fcmp	d1, d0
               	cset	x0, mi
               	csinc	x0, x0, xzr, le
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d0, #1.00000000
               	fcmp	d1, d0
               	b.vc	<addr>
               	fcmp	d0, d1
               	b.vc	<addr>
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.vc	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
