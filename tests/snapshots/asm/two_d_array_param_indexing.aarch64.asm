
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40047c <.text+0x1fc>
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
               	bl	0x4008d8 <dlsym>
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
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x13, x14, #2
               	add	x14, x15, x13
               	ldrh	w13, [x14]
               	add	x15, x14, #0x2
               	ldrh	w14, [x15]
               	add	x15, x13, x14
               	sxtw	x0, w15
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x17, #0xc               // =12
               	mul	x13, x14, x17
               	add	x14, x15, x13
               	ldrsw	x13, [x14]
               	add	x15, x14, #0x4
               	ldrsw	x12, [x15]
               	add	x15, x13, x12
               	sxtw	x15, w15
               	add	x12, x14, #0x8
               	ldrsw	x14, [x12]
               	add	x12, x15, x14
               	sxtw	x0, w12
               	ret
               	mov	x15, x0
               	sxtw	x14, w1
               	lsl	x13, x14, #2
               	add	x14, x15, x13
               	ldrb	w13, [x14]
               	add	x15, x14, #0x1
               	ldrb	w12, [x15]
               	add	x15, x13, x12
               	sxtw	x15, w15
               	add	x12, x14, #0x2
               	ldrb	w13, [x12]
               	add	x12, x15, x13
               	sxtw	x12, w12
               	add	x13, x14, #0x3
               	ldrb	w14, [x13]
               	add	x13, x12, x14
               	sxtw	x0, w13
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4e0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w15, [x17]
               	b	0x4004a8 <.text+0x228>
               	sub	x16, x29, #0x408
               	ldrsw	x15, [x16]
               	cmp	x15, #0x100
               	b.ge	0x40050c <.text+0x28c>
               	b	0x4004d0 <.text+0x250>
               	sub	x15, x29, #0x408
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x4004a8 <.text+0x228>
               	sub	x13, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x14, [x16]
               	lsl	x15, x14, #2
               	add	x14, x13, x15
               	mov	x15, #0x0               // =0
               	strh	w15, [x14]
               	sub	x13, x29, #0x400
               	sub	x16, x29, #0x408
               	ldrsw	x14, [x16]
               	lsl	x12, x14, #2
               	add	x14, x13, x12
               	add	x12, x14, #0x2
               	strh	w15, [x12]
               	b	0x4004bc <.text+0x23c>
               	sub	x12, x29, #0x400
               	add	x14, x12, #0x14
               	mov	x12, #0x1234            // =4660
               	strh	w12, [x14]
               	sub	x15, x29, #0x400
               	add	x12, x15, #0x16
               	mov	x15, #0x10              // =16
               	strh	w15, [x12]
               	sub	x20, x29, #0x400
               	mov	x21, #0x5               // =5
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4003d0 <.text+0x150>
               	mov	x12, x0
               	mov	x21, #0x1244            // =4676
               	sxtw	x21, w21
               	cmp	x12, x21
               	b.eq	0x400578 <.text+0x2f8>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w20, [x17]
               	b	0x400588 <.text+0x308>
               	sub	x16, x29, #0x408
               	ldrsw	x20, [x16]
               	cmp	x20, #0xa
               	b.ge	0x4005c0 <.text+0x340>
               	b	0x4005b0 <.text+0x330>
               	sub	x20, x29, #0x408
               	ldrsw	x21, [x20]
               	add	x12, x21, #0x1
               	str	w12, [x20]
               	b	0x400588 <.text+0x308>
               	mov	x12, #0x0               // =0
               	sub	x17, x29, #0x488
               	str	w12, [x17]
               	b	0x4005e4 <.text+0x364>
               	sub	x22, x29, #0x480
               	mov	x21, #0x7               // =7
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x4003f8 <.text+0x178>
               	mov	x11, x0
               	cmp	x11, #0x837
               	b.eq	0x400678 <.text+0x3f8>
               	b	0x400654 <.text+0x3d4>
               	sub	x16, x29, #0x488
               	ldrsw	x12, [x16]
               	cmp	x12, #0x3
               	b.ge	0x400650 <.text+0x3d0>
               	b	0x40060c <.text+0x38c>
               	sub	x12, x29, #0x488
               	ldrsw	x21, [x12]
               	add	x20, x21, #0x1
               	str	w20, [x12]
               	b	0x4005e4 <.text+0x364>
               	sub	x20, x29, #0x480
               	sub	x16, x29, #0x408
               	ldrsw	x21, [x16]
               	mov	x17, #0xc               // =12
               	mul	x12, x21, x17
               	add	x13, x20, x12
               	sub	x16, x29, #0x488
               	ldrsw	x12, [x16]
               	lsl	x20, x12, #2
               	add	x11, x13, x20
               	mov	x17, #0x64              // =100
               	mul	x20, x21, x17
               	sxtw	x20, w20
               	add	x21, x20, x12
               	sxtw	x21, w21
               	str	w21, [x11]
               	b	0x4005f8 <.text+0x378>
               	b	0x40059c <.text+0x31c>
               	mov	x11, #0x2               // =2
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	sub	x17, x29, #0x408
               	str	w21, [x17]
               	b	0x400688 <.text+0x408>
               	sub	x16, x29, #0x408
               	ldrsw	x21, [x16]
               	cmp	x21, #0x8
               	b.ge	0x4006c0 <.text+0x440>
               	b	0x4006b0 <.text+0x430>
               	sub	x21, x29, #0x408
               	ldrsw	x11, [x21]
               	add	x22, x11, #0x1
               	str	w22, [x21]
               	b	0x400688 <.text+0x408>
               	mov	x22, #0x0               // =0
               	sub	x17, x29, #0x488
               	str	w22, [x17]
               	b	0x4006e4 <.text+0x464>
               	sub	x20, x29, #0x4a8
               	mov	x23, #0x3               // =3
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400434 <.text+0x1b4>
               	mov	x21, x0
               	cmp	x21, #0x116
               	b.eq	0x400774 <.text+0x4f4>
               	b	0x400750 <.text+0x4d0>
               	sub	x16, x29, #0x488
               	ldrsw	x22, [x16]
               	cmp	x22, #0x4
               	b.ge	0x40074c <.text+0x4cc>
               	b	0x40070c <.text+0x48c>
               	sub	x22, x29, #0x488
               	ldrsw	x11, [x22]
               	add	x21, x11, #0x1
               	str	w21, [x22]
               	b	0x4006e4 <.text+0x464>
               	sub	x21, x29, #0x4a8
               	sub	x16, x29, #0x408
               	ldrsw	x11, [x16]
               	lsl	x22, x11, #2
               	add	x12, x21, x22
               	sub	x16, x29, #0x488
               	ldrsw	x22, [x16]
               	add	x21, x12, x22
               	add	x12, x11, #0x41
               	sxtw	x12, w12
               	add	x11, x12, x22
               	sxtw	x11, w11
               	mov	x17, #0xff              // =255
               	and	x12, x11, x17
               	strb	w12, [x21]
               	b	0x4006f8 <.text+0x478>
               	b	0x40069c <.text+0x41c>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x4e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec8bd
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406df0 <exit+0x650c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8e80
               	tbz	w21, #0x6, 0x3fee44
               	<unknown>
               	cbnz	w16, 0x46edec
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4003f8 <.text+0x178>
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
               	bl	0x4008e4 <exit>
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
               	adr	x10, 0x4ec981
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406eb4 <exit+0x65d0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8f44
               	tbz	w21, #0x6, 0x3fef08
               	<unknown>
               	cbnz	w16, 0x46eeb0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4004bc <.text+0x23c>
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
