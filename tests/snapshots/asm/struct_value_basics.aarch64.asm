
struct_value_basics.aarch64:	file format elf64-littleaarch64

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
               	sub	x15, x29, #0x8
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x14, x13, #0x4
               	mov	x13, #0x4               // =4
               	str	w13, [x14]
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	cmp	x13, #0x3
               	b.eq	0x400280 <.text+0x60>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x4
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x3
               	b.eq	0x4002cc <.text+0xac>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x14, x0, #0x4
               	ldrsw	x15, [x14]
               	cmp	x15, #0x4
               	b.eq	0x4002f0 <.text+0xd0>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x1e              // =30
               	str	w14, [x0]
               	add	x15, x0, #0x4
               	mov	x0, #0x28               // =40
               	str	w0, [x15]
               	sub	x14, x29, #0x8
               	ldrsw	x0, [x14]
               	cmp	x0, #0x1e
               	b.eq	0x400324 <.text+0x104>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	add	x0, x14, #0x4
               	ldrsw	x14, [x0]
               	cmp	x14, #0x28
               	b.eq	0x40034c <.text+0x12c>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x14, #0x64              // =100
               	str	w14, [x0]
               	sub	x15, x29, #0x10
               	add	x14, x15, #0x4
               	mov	x15, #0xc8              // =200
               	str	w15, [x14]
               	sub	x0, x29, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x1e
               	b.eq	0x40038c <.text+0x16c>
               	mov	x15, #0x7               // =7
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x15, [x0]
               	cmp	x15, #0x64
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x15, [x0]
               	sub	x0, x29, #0x8
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	add	x14, x15, x0
               	sxtw	x14, w14
               	sub	x0, x29, #0x10
               	ldrsw	x15, [x0]
               	add	x0, x14, x15
               	sxtw	x0, w0
               	sub	x15, x29, #0x10
               	add	x14, x15, #0x4
               	ldrsw	x15, [x14]
               	add	x14, x0, x15
               	sxtw	x14, w14
               	sxtw	x15, w14
               	cmp	x15, #0x172
               	b.eq	0x40040c <.text+0x1ec>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec545
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a78 <exit+0x6510>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b08
               	tbz	w21, #0x6, 0x3feacc
               	<unknown>
               	cbnz	w16, 0x46ea74
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400080
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
               	bl	0x400568 <exit>
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
               	adr	x10, 0x4ec611
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b44 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8bd4
               	tbz	w21, #0x6, 0x3feb98
               	<unknown>
               	cbnz	w16, 0x46eb40
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40014c
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
