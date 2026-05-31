
mcpy_temp_aliases_src.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	str	x19, [sp]
               	mov	x15, #0x1               // =1
               	mov	x14, #0x2               // =2
               	mov	x13, #0x3               // =3
               	mov	x12, #0x4               // =4
               	mov	x11, #0x5               // =5
               	mov	x10, #0x6               // =6
               	mov	x9, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x7, #0x9                // =9
               	mov	x6, #0xa                // =10
               	sxtw	x5, w15
               	sxtw	x15, w14
               	add	x14, x5, x15
               	sxtw	x14, w14
               	sxtw	x15, w13
               	add	x13, x14, x15
               	sxtw	x13, w13
               	sxtw	x15, w12
               	add	x12, x13, x15
               	sxtw	x12, w12
               	sxtw	x15, w11
               	add	x11, x12, x15
               	sxtw	x11, w11
               	sxtw	x15, w10
               	add	x10, x11, x15
               	sxtw	x10, w10
               	sxtw	x15, w9
               	add	x9, x10, x15
               	sxtw	x9, w9
               	sxtw	x15, w8
               	add	x8, x9, x15
               	sxtw	x8, w8
               	sxtw	x15, w7
               	add	x7, x8, x15
               	sxtw	x7, w7
               	sxtw	x15, w6
               	add	x6, x7, x15
               	sxtw	x6, w6
               	sub	x15, x29, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x7, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x7]
               	str	x10, [x15]
               	ldr	x10, [x7, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [x7, #0x10]
               	str	x10, [x15, #0x10]
               	ldr	x10, [x7, #0x18]
               	str	x10, [x15, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x8, x15
               	sxtw	x8, w6
               	cmp	x8, #0x37
               	b.eq	0x40033c <.text+0x11c>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x6, x29, #0x20
               	ldr	x0, [x6]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	b.eq	0x400364 <.text+0x144>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x6, x29, #0x20
               	add	x0, x6, #0x8
               	ldr	x6, [x0]
               	mov	x17, #0x2222            // =8738
               	cmp	x6, x17
               	b.eq	0x400394 <.text+0x174>
               	mov	x6, #0x3                // =3
               	mov	x0, x6
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x6, x0, #0x10
               	ldr	x0, [x6]
               	mov	x17, #0x3333            // =13107
               	cmp	x0, x17
               	b.eq	0x4003c0 <.text+0x1a0>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x6, x29, #0x20
               	add	x0, x6, #0x18
               	ldr	x6, [x0]
               	mov	x17, #0x4444            // =17476
               	cmp	x6, x17
               	b.eq	0x4003f0 <.text+0x1d0>
               	mov	x6, #0x5                // =5
               	mov	x0, x6
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec529
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a5c <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8aec
               	tbz	w21, #0x6, 0x3feab0
               	<unknown>
               	cbnz	w16, 0x46ea58
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400064
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
               	bl	0x400548 <exit>
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
               	adr	x10, 0x4ec5f1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b24 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8bb4
               	tbz	w21, #0x6, 0x3feb78
               	<unknown>
               	cbnz	w16, 0x46eb20
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40012c
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
