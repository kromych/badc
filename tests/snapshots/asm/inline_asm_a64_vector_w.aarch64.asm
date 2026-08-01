
inline_asm_a64_vector_w.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<gf2x8_double>:
               	sub	sp, sp, #0x10
               	str	x20, [sp, #-0xf0]!
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x38
               	mov	x1, #0x1d               // =29
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	dup	v0.16b, w0
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0x38
               	sub	x0, x29, #0x18
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x78
               	sub	x1, x29, #0x68
               	sub	sp, sp, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x68
               	sub	sp, sp, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x0, x29, #0x98
               	sub	x1, x29, #0x78
               	sub	x2, x29, #0xa8
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x98
               	sub	x2, x29, #0x58
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x1, x29, #0x58
               	sub	x0, x29, #0x28
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x28
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x20, [sp], #0xf0
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x1d0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x1c0]
               	add	x29, sp, #0x1c0
               	sub	x0, x29, #0x178
               	add	x0, x0, #0x0
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	sub	x0, x29, #0x188
               	add	x0, x0, #0x0
               	mov	x1, #0xf0               // =240
               	strb	w1, [x0]
               	sub	x0, x29, #0x178
               	mov	x1, #0x14               // =20
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x188
               	mov	x1, #0xef               // =239
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x178
               	mov	x1, #0x25               // =37
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x188
               	mov	x1, #0xee               // =238
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x178
               	mov	x1, #0x36               // =54
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x188
               	mov	x1, #0xed               // =237
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x178
               	mov	x1, #0x47               // =71
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x188
               	mov	x1, #0xec               // =236
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x178
               	mov	x1, #0x58               // =88
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x188
               	mov	x1, #0xeb               // =235
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x178
               	mov	x1, #0x69               // =105
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x188
               	mov	x1, #0xea               // =234
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x178
               	mov	x1, #0x7a               // =122
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe9               // =233
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x178
               	mov	x1, #0x8b               // =139
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe8               // =232
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x178
               	mov	x1, #0x9c               // =156
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe7               // =231
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x178
               	mov	x1, #0xad               // =173
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe6               // =230
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x178
               	mov	x1, #0xbe               // =190
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe5               // =229
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x178
               	mov	x1, #0xcf               // =207
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe4               // =228
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x178
               	mov	x1, #0xe0               // =224
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe3               // =227
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x178
               	mov	x1, #0xf1               // =241
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe2               // =226
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x178
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x188
               	mov	x1, #0xe1               // =225
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x178
               	sub	x1, x29, #0xf8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	ldr	q0, [x0]
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0xf8
               	sub	x0, x29, #0x40
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0x138
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x188
               	sub	x1, x29, #0xf8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	ldr	q0, [x0]
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0xf8
               	sub	x0, x29, #0x50
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x158
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x198
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x158
               	sub	x3, x29, #0x118
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x3, [sp]
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x1, x29, #0x118
               	sub	x0, x29, #0x60
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x60
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x198
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x178
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	sub	x4, x29, #0x188
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x198
               	sub	x3, x29, #0x138
               	sub	x4, x29, #0x158
               	sub	x0, x29, #0xf8
               	mov	x1, #0xa5               // =165
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	dup	v0.16b, w0
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0xf8
               	sub	x0, x29, #0x70
               	ldrb	w5, [x1]
               	ldrb	w6, [x1, #0x1]
               	ldrb	w7, [x1, #0x2]
               	ldrb	w8, [x1, #0x3]
               	ldrb	w9, [x1, #0x4]
               	ldrb	w10, [x1, #0x5]
               	ldrb	w11, [x1, #0x6]
               	ldrb	w12, [x1, #0x7]
               	ldrb	w13, [x1, #0x8]
               	ldrb	w14, [x1, #0x9]
               	ldrb	w15, [x1, #0xa]
               	ldrb	w20, [x1, #0xb]
               	ldrb	w21, [x1, #0xc]
               	ldrb	w22, [x1, #0xd]
               	ldrb	w23, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w5, [x0]
               	strb	w6, [x0, #0x1]
               	strb	w7, [x0, #0x2]
               	strb	w8, [x0, #0x3]
               	strb	w9, [x0, #0x4]
               	strb	w10, [x0, #0x5]
               	strb	w11, [x0, #0x6]
               	strb	w12, [x0, #0x7]
               	strb	w13, [x0, #0x8]
               	strb	w14, [x0, #0x9]
               	strb	w15, [x0, #0xa]
               	strb	w20, [x0, #0xb]
               	strb	w21, [x0, #0xc]
               	strb	w22, [x0, #0xd]
               	strb	w23, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0x128
               	sub	sp, sp, #0x40
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	d2, [sp, #0x30]
               	str	d3, [sp, #0x38]
               	str	x1, [sp]
               	str	x3, [sp, #0x8]
               	str	x4, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	ldr	x16, [sp, #0x18]
               	ldr	q3, [x16]
               	eor3	v0.16b, v1.16b, v2.16b, v3.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	ldr	d2, [sp, #0x30]
               	ldr	d3, [sp, #0x38]
               	add	sp, sp, #0x40
               	sub	x1, x29, #0x128
               	sub	x0, x29, #0x80
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x80
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x198
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x178
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	sub	x4, x29, #0x188
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	eor	x3, x3, x4
               	mov	x17, #0xa5              // =165
               	eor	x3, x3, x17
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x198
               	add	x0, x0, #0x0
               	mov	x1, #0xf                // =15
               	strb	w1, [x0]
               	sub	x0, x29, #0x198
               	mov	x1, #0xe                // =14
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x198
               	mov	x1, #0xd                // =13
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x198
               	mov	x1, #0xc                // =12
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x198
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x198
               	mov	x1, #0xa                // =10
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x198
               	mov	x1, #0x9                // =9
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x198
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x198
               	mov	x1, #0x7                // =7
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x198
               	mov	x1, #0x6                // =6
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x198
               	mov	x1, #0x5                // =5
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x198
               	mov	x1, #0x4                // =4
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x198
               	mov	x1, #0x3                // =3
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x198
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x198
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x198
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xf]
               	sub	x2, x29, #0x198
               	sub	x3, x29, #0x138
               	sub	x0, x29, #0x198
               	sub	x1, x29, #0xf8
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x1, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	ldr	q0, [x0]
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0xf8
               	sub	x0, x29, #0x90
               	ldrb	w4, [x1]
               	ldrb	w5, [x1, #0x1]
               	ldrb	w6, [x1, #0x2]
               	ldrb	w7, [x1, #0x3]
               	ldrb	w8, [x1, #0x4]
               	ldrb	w9, [x1, #0x5]
               	ldrb	w10, [x1, #0x6]
               	ldrb	w11, [x1, #0x7]
               	ldrb	w12, [x1, #0x8]
               	ldrb	w13, [x1, #0x9]
               	ldrb	w14, [x1, #0xa]
               	ldrb	w15, [x1, #0xb]
               	ldrb	w20, [x1, #0xc]
               	ldrb	w21, [x1, #0xd]
               	ldrb	w22, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w4, [x0]
               	strb	w5, [x0, #0x1]
               	strb	w6, [x0, #0x2]
               	strb	w7, [x0, #0x3]
               	strb	w8, [x0, #0x4]
               	strb	w9, [x0, #0x5]
               	strb	w10, [x0, #0x6]
               	strb	w11, [x0, #0x7]
               	strb	w12, [x0, #0x8]
               	strb	w13, [x0, #0x9]
               	strb	w14, [x0, #0xa]
               	strb	w15, [x0, #0xb]
               	strb	w20, [x0, #0xc]
               	strb	w21, [x0, #0xd]
               	strb	w22, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x118
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x1, [sp]
               	str	x3, [sp, #0x8]
               	str	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x1, x29, #0x118
               	sub	x0, x29, #0xa0
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xa0
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x198
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	sub	x4, x29, #0x178
               	mov	x2, #0xf                // =15
               	sub	x2, x2, x0
               	sxtw	x2, w2
               	add	x2, x4, x2
               	ldrb	w2, [x2]
               	cmp	x3, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x198
               	sub	x0, x29, #0xf8
               	mov	x1, #0x13               // =19
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	dup	v0.16b, w0
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0xf8
               	sub	x0, x29, #0xb0
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x3, x29, #0xb0
               	sub	x0, x29, #0xf8
               	mov	x1, #0x11               // =17
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x0, [sp, #0x8]
               	dup	v0.16b, w0
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x1, x29, #0xf8
               	sub	x0, x29, #0xc0
               	ldrb	w4, [x1]
               	ldrb	w5, [x1, #0x1]
               	ldrb	w6, [x1, #0x2]
               	ldrb	w7, [x1, #0x3]
               	ldrb	w8, [x1, #0x4]
               	ldrb	w9, [x1, #0x5]
               	ldrb	w10, [x1, #0x6]
               	ldrb	w11, [x1, #0x7]
               	ldrb	w12, [x1, #0x8]
               	ldrb	w13, [x1, #0x9]
               	ldrb	w14, [x1, #0xa]
               	ldrb	w15, [x1, #0xb]
               	ldrb	w20, [x1, #0xc]
               	ldrb	w21, [x1, #0xd]
               	ldrb	w22, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w4, [x0]
               	strb	w5, [x0, #0x1]
               	strb	w6, [x0, #0x2]
               	strb	w7, [x0, #0x3]
               	strb	w8, [x0, #0x4]
               	strb	w9, [x0, #0x5]
               	strb	w10, [x0, #0x6]
               	strb	w11, [x0, #0x7]
               	strb	w12, [x0, #0x8]
               	strb	w13, [x0, #0x9]
               	strb	w14, [x0, #0xa]
               	strb	w15, [x0, #0xb]
               	strb	w20, [x0, #0xc]
               	strb	w21, [x0, #0xd]
               	strb	w22, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x118
               	sub	sp, sp, #0x30
               	str	d0, [sp, #0x18]
               	str	d1, [sp, #0x20]
               	str	d2, [sp, #0x28]
               	str	x1, [sp]
               	str	x3, [sp, #0x8]
               	str	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x10]
               	ldr	q2, [x16]
               	pmul	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x18]
               	ldr	d1, [sp, #0x20]
               	ldr	d2, [sp, #0x28]
               	add	sp, sp, #0x30
               	sub	x1, x29, #0x118
               	sub	x0, x29, #0xd0
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xd0
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x2, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	sub	x0, x29, #0x198
               	ldrb	w0, [x0]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x1c0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret
               	sub	x20, x29, #0x198
               	sub	x0, x29, #0x138
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0xe0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0xe0
               	sub	sp, sp, #0x20
               	str	x0, [sp, #0x10]
               	str	d0, [sp, #0x18]
               	str	x20, [sp]
               	str	x0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x16, [sp, #0x8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x10]
               	ldr	d0, [sp, #0x18]
               	add	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x178
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	lsl	x2, x2, #1
               	sxtw	x3, w2
               	sub	x2, x29, #0x178
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0x80              // =128
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x2, #0x1d               // =29
               	eor	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	sub	x3, x29, #0x198
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x3, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x1c0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x1c0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x1c0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x1c0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x1c0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x1d0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
