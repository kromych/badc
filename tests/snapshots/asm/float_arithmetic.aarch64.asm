
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
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fsub	d0, d16, d17
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	mov	x2, #0x400e000000000000 // =4615626668101337088
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	mov	x2, #0x999a             // =39322
               	movk	x2, #0x9999, lsl #16
               	movk	x2, #0x9999, lsl #32
               	movk	x2, #0x3ff9, lsl #48
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x2, #0x3333             // =13107
               	movk	x2, #0x3333, lsl #16
               	movk	x2, #0x3333, lsl #32
               	movk	x2, #0x3ffb, lsl #48
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.lt	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d16, x0
               	fneg	d0, d16
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fneg	d0, d0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x3, mi
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.le	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x3, eq
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x3, ne
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x3, ls
               	cmp	x3, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.lt	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvtzs	x1, d0
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	fmov	d16, x2
               	fneg	d0, d16
               	fcvtzs	x0, d0
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret
