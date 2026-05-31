
setjmp_longjmp_roundtrip.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400364 <.text+0xc4>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x15, w0
               	sxtw	x20, w1
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x13, x19
               	ldrsw	x12, [x13]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	str	w11, [x13]
               	cmp	x15, #0x0
               	b.le	0x400340 <.text+0xa0>
               	sub	x11, x15, #0x1
               	sxtw	x21, w11
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4002b8 <.text+0x18>
               	mov	x15, x0
               	b	0x40031c <.text+0x7c>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x22, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x400818 <longjmp>
               	uxtb	w0, w0
               	mov	x15, x0
               	b	0x40031c <.text+0x7c>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x15, x19
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400824 <setjmp>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.ne	0x400410 <.text+0x170>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x14, x19
               	mov	x20, #0x0               // =0
               	str	w20, [x14]
               	mov	x21, #0x5               // =5
               	mov	x22, #0x2a              // =42
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4002b8 <.text+0x18>
               	mov	x14, x0
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e0
               	mov	x22, x19
               	ldrsw	x14, [x22]
               	cmp	x14, #0x6
               	b.eq	0x400450 <.text+0x1b0>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x22, x19
               	mov	x14, #0x2               // =2
               	str	w14, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400824 <setjmp>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.ne	0x4004d4 <.text+0x234>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x23, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x400818 <longjmp>
               	uxtb	w0, w0
               	mov	x22, x0
               	mov	x22, #0x15              // =21
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x23, x19
               	mov	x22, #0x0               // =0
               	str	w22, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400824 <setjmp>
               	sxtw	x0, w0
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.eq	0x400578 <.text+0x2d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	ldrsw	x20, [x22]
               	cmp	x20, #0x1
               	b.eq	0x400600 <.text+0x360>
               	b	0x4005d8 <.text+0x338>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f0
               	mov	x23, x19
               	mov	x22, #0x3               // =3
               	str	w22, [x23]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x21, x19
               	mov	x22, #0x0               // =0
               	str	w22, [x21]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400824 <setjmp>
               	sxtw	x0, w0
               	mov	x22, x0
               	cmp	x22, #0x0
               	b.eq	0x400648 <.text+0x3a8>
               	b	0x400604 <.text+0x364>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	mov	x20, #0x1               // =1
               	str	w20, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x21, x19
               	mov	x23, #0x0               // =0
               	mov	x0, x21
               	mov	x1, x23
               	bl	0x400818 <longjmp>
               	uxtb	w0, w0
               	mov	x22, x0
               	mov	x22, #0x17              // =23
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x16              // =22
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400528 <.text+0x288>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	ldrsw	x20, [x22]
               	cmp	x20, #0x7
               	b.eq	0x4006cc <.text+0x42c>
               	b	0x4006a4 <.text+0x404>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x22, x19
               	mov	x23, #0x7               // =7
               	str	w23, [x22]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x20, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400818 <longjmp>
               	uxtb	w0, w0
               	mov	x22, x0
               	mov	x22, #0x1f              // =31
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x20              // =32
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400620 <.text+0x380>
               	<unknown>
               	adr	x10, 0x4ec7f5
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406d28 <exit+0x64f8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8db8
               	tbz	w21, #0x6, 0x3fed7c
               	<unknown>
               	cbnz	w16, 0x46ed24
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400330 <.text+0x90>
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
               	bl	0x400830 <exit>
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
               	adr	x10, 0x4ec8c1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406df4 <exit+0x65c4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8e84
               	tbz	w21, #0x6, 0x3fee48
               	<unknown>
               	cbnz	w16, 0x46edf0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4003fc <.text+0x15c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<longjmp>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16

<setjmp>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	br	x16
