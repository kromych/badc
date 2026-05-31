
commutative_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x7               // =7
               	sxtw	x14, w15
               	lsl	x13, x14, #2
               	sxtw	x13, w13
               	cmp	x13, #0x1c
               	b.eq	0x400258 <.text+0x38>
               	mov	x0, #0x1                // =1
               	ret
               	sxtw	x14, w15
               	add	x0, x14, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0xa
               	b.eq	0x400274 <.text+0x54>
               	mov	x0, #0x2                // =2
               	ret
               	sxtw	x14, w15
               	mov	x17, #0xf0              // =240
               	and	x0, x14, x17
               	cmp	x0, #0x0
               	b.eq	0x400290 <.text+0x70>
               	mov	x0, #0x3                // =3
               	ret
               	sxtw	x14, w15
               	mov	x17, #0x10              // =16
               	orr	x0, x14, x17
               	cmp	x0, #0x17
               	b.eq	0x4002ac <.text+0x8c>
               	mov	x0, #0x4                // =4
               	ret
               	sxtw	x14, w15
               	mov	x17, #0xff              // =255
               	eor	x0, x14, x17
               	cmp	x0, #0xf8
               	b.eq	0x4002c8 <.text+0xa8>
               	mov	x0, #0x5                // =5
               	ret
               	sxtw	x14, w15
               	cmp	x14, #0x1
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.eq	0x4002e4 <.text+0xc4>
               	mov	x0, #0x6                // =6
               	ret
               	sxtw	x14, w15
               	cmp	x14, #0x1
               	cset	x0, ne
               	cmp	x0, #0x1
               	b.eq	0x400300 <.text+0xe0>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x14, #0xa               // =10
               	sxtw	x0, w15
               	sub	x12, x14, x0
               	sxtw	x12, w12
               	cmp	x12, #0x3
               	b.eq	0x400324 <.text+0x104>
               	mov	x12, #0x8               // =8
               	mov	x0, x12
               	ret
               	sxtw	x0, w15
               	cmp	x0, #0x8
               	cset	x15, lt
               	cmp	x15, #0x0
               	b.ne	0x400344 <.text+0x124>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	<unknown>
               	adr	x10, 0x4ec471
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069a4 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a34
               	tbz	w21, #0x6, 0x3fe9f8
               	<unknown>
               	cbnz	w16, 0x46e9a0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fffac
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
               	bl	0x400488 <exit>
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
               	adr	x10, 0x4ec531
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a64 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8af4
               	tbz	w21, #0x6, 0x3feab8
               	<unknown>
               	cbnz	w16, 0x46ea60
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40006c
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
