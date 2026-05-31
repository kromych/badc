
fp_nan_unordered_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003d0 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400988 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	fmov	d0, x15
               	fmov	d1, x15
               	fdiv	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x10]
               	mov	x14, #0x4014000000000000 // =4617315517961601024
               	mov	x13, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x13
               	fmov	d1, x15
               	fdiv	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x20]
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x15, ne
               	cmp	x15, #0x0
               	b.ne	0x40043c <.text+0x1bc>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	0x400468 <.text+0x1e8>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	0x400494 <.text+0x214>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	fmov	d0, x13
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, ne
               	cmp	x12, #0x0
               	b.ne	0x4004c8 <.text+0x248>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, eq
               	cbz	x12, 0x4004f0 <.text+0x270>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x10]
               	fmov	d0, x12
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, eq
               	cbz	x0, 0x40051c <.text+0x29c>
               	mov	x12, #0xb               // =11
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x12, eq
               	cbz	x12, 0x400544 <.text+0x2c4>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x12, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	fmov	d0, x12
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cbz	x13, 0x400570 <.text+0x2f0>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x40059c <.text+0x31c>
               	mov	x13, #0x14              // =20
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, gt
               	cbz	x13, 0x4005c4 <.text+0x344>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, 0x4005f0 <.text+0x370>
               	mov	x13, #0x16              // =22
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, 0x400618 <.text+0x398>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x400644 <.text+0x3c4>
               	mov	x13, #0x18              // =24
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, gt
               	cbz	x13, 0x40066c <.text+0x3ec>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ls
               	cbz	x0, 0x400698 <.text+0x418>
               	mov	x13, #0x1a              // =26
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, ge
               	cbz	x13, 0x4006c0 <.text+0x440>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x4006ec <.text+0x46c>
               	mov	x13, #0x1c              // =28
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x10]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, ls
               	cbz	x13, 0x400714 <.text+0x494>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ge
               	cbz	x0, 0x400740 <.text+0x4c0>
               	mov	x13, #0x1e              // =30
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, mi
               	cmp	x13, #0x0
               	b.ne	0x400770 <.text+0x4f0>
               	mov	x13, #0x28              // =40
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	0x4007a0 <.text+0x520>
               	mov	x13, #0x29              // =41
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x13, gt
               	cmp	x13, #0x0
               	b.ne	0x4007d0 <.text+0x550>
               	mov	x13, #0x2a              // =42
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	mov	x13, #0x759c            // =30108
               	movk	x13, #0x8800, lsl #16
               	movk	x13, #0xe43c, lsl #32
               	movk	x13, #0x7e37, lsl #48
               	fmov	d0, x0
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x14, gt
               	cmp	x14, #0x0
               	b.ne	0x40080c <.text+0x58c>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x20]
               	fmov	d0, x13
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, 0x400838 <.text+0x5b8>
               	mov	x13, #0x2c              // =44
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec96d
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ea0 <exit+0x650c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8f30
               	tbz	w21, #0x6, 0x3feef4
               	<unknown>
               	cbnz	w16, 0x46ee9c
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4004a8 <.text+0x228>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
               	udf	#0x0
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400994 <exit>
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
               	adr	x10, 0x4eca31
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406f64 <exit+0x65d0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ff4
               	tbz	w21, #0x6, 0x3fefb8
               	<unknown>
               	cbnz	w16, 0x46ef60
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40056c <.text+0x2ec>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<dlsym>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16
