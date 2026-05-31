
struct_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	bl	0x400448 <malloc>
               	mov	x14, x0
               	mov	x20, #0x3               // =3
               	str	w20, [x14]
               	add	x13, x14, #0x4
               	mov	x20, #0x4               // =4
               	str	w20, [x13]
               	ldrsw	x12, [x14]
               	ldrsw	x20, [x14]
               	mul	x13, x12, x20
               	sxtw	x13, w13
               	add	x20, x14, #0x4
               	ldrsw	x14, [x20]
               	ldrsw	x12, [x20]
               	mul	x20, x14, x12
               	sxtw	x20, w20
               	add	x12, x13, x20
               	sxtw	x12, w12
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec429
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x40695c <exit+0x6508>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f89ec
               	tbz	w21, #0x6, 0x3fe9b0
               	<unknown>
               	cbnz	w16, 0x46e958
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fff64
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
               	bl	0x400454 <exit>
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
               	adr	x10, 0x4ec4f1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a24 <exit+0x65d0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ab4
               	tbz	w21, #0x6, 0x3fea78
               	<unknown>
               	cbnz	w16, 0x46ea20
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40002c
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<malloc>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	br	x16
