
mem2reg_cross_block.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0xe               // =14
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	stur	w14, [x29, #-0x18]
               	b	0x400258 <.text+0x38>
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, #0x3
               	b.ge	0x40028c <.text+0x6c>
               	ldursw	x14, [x29, #-0x10]
               	sxtw	x13, w15
               	add	x12, x14, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	ldursw	x13, [x29, #-0x18]
               	add	x12, x13, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x18]
               	b	0x400258 <.text+0x38>
               	ldursw	x0, [x29, #-0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec3c1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4068f4 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8984
               	tbz	w21, #0x6, 0x3fe948
               	<unknown>
               	cbnz	w16, 0x46e8f0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3ffefc
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
               	bl	0x4003d8 <exit>
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
               	adr	x10, 0x4ec481
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069b4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a44
               	tbz	w21, #0x6, 0x3fea08
               	<unknown>
               	cbnz	w16, 0x46e9b0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fffbc
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
