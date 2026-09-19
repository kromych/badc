
float_arithmetic.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #1.50000000
               	fmov	d1, #2.50000000
               	fadd	d2, d0, d1
               	fmov	d3, #4.00000000
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fsub	d2, d1, d0
               	fmov	d3, #1.00000000
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmul	d2, d0, d1
               	fmov	d3, #3.75000000
               	fcmp	d2, d3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fdiv	d2, d1, d0
               	adrp	x16, <page>
               	ldr	d3, [x16]
               	fcmp	d2, d3
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x16, <page>
               	ldr	d3, [x16, #0x8]
               	fcmp	d2, d3
               	b.lt	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d2, #-1.50000000
               	fcmp	d2, d2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fcmp	d0, d1
               	cset	x0, mi
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fcmp	d0, d0
               	cset	x0, eq
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d0, d0
               	cset	x0, ls
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fcmp	d0, d1
               	b.lt	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	fmov	d1, #7.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	fmov	d1, #0.50000000
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x10]
               	fcvtzs	x0, d0
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret
