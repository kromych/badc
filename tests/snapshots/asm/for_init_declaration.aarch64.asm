
for_init_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4006c8 <.text+0x408>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
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
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400a38 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x40042c <.text+0x16c>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0xa
               	b.ge	0x400468 <.text+0x1a8>
               	b	0x400450 <.text+0x190>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x40042c <.text+0x16c>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	ldursw	x15, [x29, #-0x10]
               	add	x12, x14, x15
               	str	w12, [x13]
               	b	0x40043c <.text+0x17c>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0xa               // =10
               	stur	w14, [x29, #-0x18]
               	b	0x400498 <.text+0x1d8>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #-0x18]
               	cmp	x14, x15
               	b.ge	0x400504 <.text+0x244>
               	b	0x4004e0 <.text+0x220>
               	sub	x15, x29, #0x10
               	ldrsw	x13, [x15]
               	add	x14, x13, #0x1
               	str	w14, [x15]
               	sub	x13, x29, #0x18
               	ldrsw	x14, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x15, x14, x17
               	str	w15, [x13]
               	b	0x400498 <.text+0x1d8>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x12, [x29, #-0x18]
               	add	x11, x13, x12
               	sxtw	x11, w11
               	add	x12, x14, x11
               	str	w12, [x15]
               	b	0x4004ac <.text+0x1ec>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, #0x2a              // =42
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	b	0x400530 <.text+0x270>
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x3
               	b.ge	0x400558 <.text+0x298>
               	b	0x400554 <.text+0x294>
               	sub	x14, x29, #0x10
               	ldrsw	x13, [x14]
               	add	x12, x13, #0x1
               	str	w12, [x14]
               	b	0x400530 <.text+0x270>
               	b	0x400540 <.text+0x280>
               	sxtw	x0, w15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	0x400584 <.text+0x2c4>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x5
               	b.ge	0x4005c0 <.text+0x300>
               	b	0x4005a8 <.text+0x2e8>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x400584 <.text+0x2c4>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	ldursw	x15, [x29, #-0x10]
               	add	x12, x14, x15
               	str	w12, [x13]
               	b	0x400594 <.text+0x2d4>
               	mov	x12, #0xa               // =10
               	stur	w12, [x29, #-0x18]
               	b	0x4005cc <.text+0x30c>
               	ldursw	x12, [x29, #-0x18]
               	cmp	x12, #0xd
               	b.ge	0x400608 <.text+0x348>
               	b	0x4005f0 <.text+0x330>
               	sub	x12, x29, #0x18
               	ldrsw	x15, [x12]
               	add	x13, x15, #0x1
               	str	w13, [x12]
               	b	0x4005cc <.text+0x30c>
               	sub	x13, x29, #0x8
               	ldrsw	x15, [x13]
               	ldursw	x12, [x29, #-0x18]
               	add	x14, x15, x12
               	str	w14, [x13]
               	b	0x4005dc <.text+0x31c>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x15, x19
               	mov	x14, #0x0               // =0
               	mov	x13, #0x1               // =1
               	str	w13, [x15]
               	mov	x12, #0x4               // =4
               	add	x13, x15, #0x4
               	mov	x11, #0x2               // =2
               	str	w11, [x13]
               	add	x10, x15, #0x8
               	str	w12, [x10]
               	stur	w14, [x29, #-0x8]
               	stur	x15, [x29, #-0x10]
               	b	0x400664 <.text+0x3a4>
               	ldur	x15, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x11, x19
               	add	x14, x11, #0xc
               	cmp	x15, x14
               	b.ge	0x4006b4 <.text+0x3f4>
               	b	0x400698 <.text+0x3d8>
               	sub	x14, x29, #0x10
               	ldr	x11, [x14]
               	add	x15, x11, #0x4
               	str	x15, [x14]
               	b	0x400664 <.text+0x3a4>
               	sub	x15, x29, #0x8
               	ldrsw	x11, [x15]
               	ldur	x14, [x29, #-0x10]
               	ldrsw	x10, [x14]
               	add	x14, x11, x10
               	str	w14, [x15]
               	b	0x400684 <.text+0x3c4>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	bl	0x400410 <.text+0x150>
               	mov	x15, x0
               	cmp	x15, #0x2d
               	b.eq	0x400748 <.text+0x488>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	bl	0x400410 <.text+0x150>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400a44 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400478 <.text+0x1b8>
               	mov	x21, x0
               	cmp	x21, #0x32
               	b.eq	0x4007a8 <.text+0x4e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x175
               	mov	x23, x19
               	bl	0x400478 <.text+0x1b8>
               	mov	x21, x0
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x400a44 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400514 <.text+0x254>
               	mov	x21, x0
               	cmp	x21, #0x2a
               	b.eq	0x400808 <.text+0x548>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18a
               	mov	x20, x19
               	bl	0x400514 <.text+0x254>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400a44 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x22, #0x3               // =3
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400568 <.text+0x2a8>
               	mov	x21, x0
               	cmp	x21, #0x2b
               	b.eq	0x400868 <.text+0x5a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x19e
               	mov	x23, x19
               	bl	0x400568 <.text+0x2a8>
               	mov	x21, x0
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x400a44 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400618 <.text+0x358>
               	mov	x21, x0
               	cmp	x21, #0x7
               	b.eq	0x4008c8 <.text+0x608>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b6
               	mov	x20, x19
               	bl	0x400618 <.text+0x358>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400a44 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x5               // =5
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4eca15
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406f48 <exit+0x64f8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8fd8
               	tbz	w21, #0x6, 0x3fef9c
               	<unknown>
               	cbnz	w16, 0x46ef44
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400550 <.text+0x290>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400a50 <exit>
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
               	adr	x10, 0x4ecae1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407014 <exit+0x65c4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f90a4
               	tbz	w21, #0x6, 0x3ff068
               	<unknown>
               	cbnz	w16, 0x46f010
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40061c <.text+0x35c>
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

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16
