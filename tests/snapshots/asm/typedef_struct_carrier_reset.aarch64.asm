
typedef_struct_carrier_reset.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400300 <.text+0xe0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	stur	w14, [x29, #-0x8]
               	b	0x400258 <.text+0x38>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0xa
               	b.ge	0x4002e0 <.text+0xc0>
               	b	0x40027c <.text+0x5c>
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	add	x12, x13, #0x1
               	str	w12, [x14]
               	b	0x400258 <.text+0x38>
               	ldursw	x12, [x29, #-0x8]
               	lsl	x13, x12, #2
               	add	x14, x15, x13
               	str	w12, [x14]
               	add	x13, x15, #0x28
               	ldursw	x14, [x29, #-0x8]
               	lsl	x12, x14, #2
               	add	x11, x13, x12
               	add	x12, x14, #0x1
               	sxtw	x12, w12
               	str	w12, [x11]
               	sub	x14, x29, #0x10
               	ldrsw	x12, [x14]
               	ldursw	x11, [x29, #-0x8]
               	lsl	x13, x11, #2
               	add	x11, x15, x13
               	ldrsw	x10, [x11]
               	add	x11, x15, #0x28
               	add	x9, x11, x13
               	ldrsw	x11, [x9]
               	add	x9, x10, x11
               	sxtw	x9, w9
               	add	x11, x12, x9
               	str	w11, [x14]
               	b	0x400268 <.text+0x48>
               	add	x11, x15, #0xa0
               	ldursw	x9, [x29, #-0x10]
               	str	w9, [x11]
               	add	x14, x15, #0xa0
               	ldrsw	x0, [x14]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	x20, [sp]
               	sub	x20, x29, #0xa8
               	mov	x0, x20
               	bl	0x400238 <.text+0x18>
               	mov	x14, x0
               	sxtw	x20, w14
               	cmp	x20, #0x64
               	b.eq	0x400344 <.text+0x124>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0xa8
               	add	x20, x14, #0x14
               	ldrsw	x14, [x20]
               	cmp	x14, #0x5
               	b.eq	0x400370 <.text+0x150>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0xa8
               	add	x14, x20, #0x3c
               	ldrsw	x20, [x14]
               	cmp	x20, #0x6
               	b.eq	0x40039c <.text+0x17c>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0xa8
               	add	x20, x14, #0xa0
               	ldrsw	x14, [x20]
               	cmp	x14, #0x64
               	b.eq	0x4003c8 <.text+0x1a8>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec505
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a38 <exit+0x6510>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ac8
               	tbz	w21, #0x6, 0x3fea8c
               	<unknown>
               	cbnz	w16, 0x46ea34
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400040
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
               	bl	0x400528 <exit>
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
               	adr	x10, 0x4ec5d1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b04 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b94
               	tbz	w21, #0x6, 0x3feb58
               	<unknown>
               	cbnz	w16, 0x46eb00
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40010c
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
