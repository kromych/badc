
float_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x3ff8000000000000 // =4609434218613702656
               	stur	x15, [x29, #-0x8]
               	mov	x14, #0x4004000000000000 // =4612811918334230528
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x15
               	fmov	d1, x14
               	fadd	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x13, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x15
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x12, ne
               	cbz	x12, 0x400294 <.text+0x74>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x14
               	fmov	d1, x12
               	fsub	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x12, [x29, #-0x18]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x12
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, 0x4002d8 <.text+0xb8>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x15
               	fmov	d1, x14
               	fmul	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, ne
               	cbz	x12, 0x40031c <.text+0xfc>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x14
               	fmov	d1, x12
               	fdiv	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x12, [x29, #-0x18]
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3ff9, lsl #48
               	fmov	d0, x12
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, ls
               	cbz	x15, 0x40036c <.text+0x14c>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3ffb, lsl #48
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, ge
               	cbz	x12, 0x4003a4 <.text+0x184>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x12, [x29, #-0x18]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	d0, x12
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, 0x4003ec <.text+0x1cc>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x18]
               	fmov	d0, x0
               	fneg	d7, d0
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x0
               	fcmp	d7, d1
               	cset	x12, ne
               	cbz	x12, 0x40041c <.text+0x1fc>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, mi
               	cmp	x0, #0x1
               	b.eq	0x400448 <.text+0x228>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.eq	0x400474 <.text+0x254>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x0, eq
               	cmp	x0, #0x1
               	b.eq	0x4004a0 <.text+0x280>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x1
               	b.eq	0x4004cc <.text+0x2ac>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x0, ls
               	cmp	x0, #0x1
               	b.eq	0x4004f8 <.text+0x2d8>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x8]
               	fmov	d0, x12
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ge
               	cmp	x0, #0x0
               	b.eq	0x400524 <.text+0x304>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x7               // =7
               	sxtw	x0, w12
               	scvtf	d7, x0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x12, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x0
               	fmov	d1, x12
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, 0x400564 <.text+0x344>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fcvtzs	x14, d0
               	sxtw	x0, w14
               	cmp	x0, #0x7
               	b.eq	0x4005a8 <.text+0x388>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	fcvtzs	x0, d7
               	sxtw	x14, w0
               	cmp	x14, #0x8
               	b.eq	0x4005e0 <.text+0x3c0>
               	mov	x14, #0x10              // =16
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3ffb, lsl #48
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fcvtzs	x14, d0
               	sxtw	x0, w14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	0x400638 <.text+0x418>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec771
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ca4 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8d34
               	tbz	w21, #0x6, 0x3fecf8
               	<unknown>
               	cbnz	w16, 0x46eca0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4002ac <.text+0x8c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400788 <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec831
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406d64 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8df4
               	tbz	w21, #0x6, 0x3fedb8
               	<unknown>
               	cbnz	w16, 0x46ed60
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40036c <.text+0x14c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16
