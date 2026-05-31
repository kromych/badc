
static_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	add	x13, x15, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	str	x15, [x13]
               	mov	x14, #0x2               // =2
               	str	w14, [x15]
               	add	x13, x15, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x15, x19
               	str	x15, [x13]
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	add	x13, x15, #0x8
               	mov	x15, #0x0               // =0
               	str	x15, [x13]
               	stur	w15, [x29, #-0x8]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x14, x19
               	ldr	x15, [x14]
               	stur	x15, [x29, #-0x10]
               	b	0x4002cc <.text+0x9c>
               	ldur	x15, [x29, #-0x10]
               	cmp	x15, #0x0
               	b.eq	0x400300 <.text+0xd0>
               	ldursw	x15, [x29, #-0x8]
               	ldur	x14, [x29, #-0x10]
               	ldrsw	x13, [x14]
               	add	x12, x15, x13
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x8]
               	add	x13, x14, #0x8
               	ldr	x14, [x13]
               	stur	x14, [x29, #-0x10]
               	b	0x4002cc <.text+0x9c>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x6
               	b.eq	0x400320 <.text+0xf0>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec45d
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406990 <exit+0x6518>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a20
               	tbz	w21, #0x6, 0x3fe9e4
               	<unknown>
               	cbnz	w16, 0x46e98c
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fff98
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
               	bl	0x400478 <exit>
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
               	adr	x10, 0x4ec521
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a54 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ae4
               	tbz	w21, #0x6, 0x3feaa8
               	<unknown>
               	cbnz	w16, 0x46ea50
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40005c
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
               	ldr	x16, [x16, #0xd0]
               	br	x16
