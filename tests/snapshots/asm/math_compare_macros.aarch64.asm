
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
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	fmov	d2, #1.00000000
               	fcmp	d0, d2
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	d0, d1
               	b.pl	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d0, d1
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcmp	d0, d1
               	cset	x1, mi
               	csinc	x1, x1, xzr, le
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	fcmp	d0, d2
               	b.vc	<addr>
               	fcmp	d2, d0
               	b.vc	<addr>
               	ret
               	mov	x0, #0x6                // =6
               	ret
