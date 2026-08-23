
inline_asm_a64_vector_w.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<gf2x8_double>:
               	sub	sp, sp, #0x10
               	str	x20, [sp, #-0xe0]!
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x20
               	mov	x0, #0x1d               // =29
               	str	x0, [sp, #0x20]
               	str	d0, [sp, #0x28]
               	str	x1, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x20]
               	ldr	d0, [sp, #0x28]
               	sub	x0, x29, #0x90
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
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x70
               	sub	x2, x29, #0x80
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	x0, [sp, #0x10]
               	str	x2, [sp, #0x18]
               	ldr	x16, [sp, #0x18]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	sub	x3, x29, #0x60
               	str	d0, [sp, #0x20]
               	str	d1, [sp, #0x28]
               	str	x3, [sp, #0x10]
               	str	x2, [sp, #0x18]
               	ldr	x16, [sp, #0x18]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x20]
               	ldr	d1, [sp, #0x28]
               	sub	x2, x29, #0x50
               	str	d0, [sp, #0x28]
               	str	d1, [sp, #0x30]
               	str	d2, [sp, #0x38]
               	str	x2, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	str	x1, [sp, #0x20]
               	ldr	x16, [sp, #0x18]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x20]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x28]
               	ldr	d1, [sp, #0x30]
               	ldr	d2, [sp, #0x38]
               	sub	x1, x29, #0x10
               	str	d0, [sp, #0x28]
               	str	d1, [sp, #0x30]
               	str	d2, [sp, #0x38]
               	str	x1, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x2, [sp, #0x20]
               	ldr	x16, [sp, #0x18]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x20]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x28]
               	ldr	d1, [sp, #0x30]
               	ldr	d2, [sp, #0x38]
               	sub	x0, x29, #0x30
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
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	ldp	x29, x30, [sp, #0xd0]
               	ldr	x20, [sp], #0xe0
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	sub	x0, x29, #0xc0
               	add	x1, x0, #0x0
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	sub	x1, x29, #0xb0
               	add	x2, x1, #0x0
               	mov	x3, #0xf0               // =240
               	strb	w3, [x2]
               	mov	x2, #0x14               // =20
               	strb	w2, [x0, #0x1]
               	mov	x2, #0xef               // =239
               	strb	w2, [x1, #0x1]
               	mov	x2, #0x25               // =37
               	strb	w2, [x0, #0x2]
               	mov	x2, #0xee               // =238
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x36               // =54
               	strb	w2, [x0, #0x3]
               	mov	x2, #0xed               // =237
               	strb	w2, [x1, #0x3]
               	mov	x2, #0x47               // =71
               	strb	w2, [x0, #0x4]
               	mov	x2, #0xec               // =236
               	strb	w2, [x1, #0x4]
               	mov	x2, #0x58               // =88
               	strb	w2, [x0, #0x5]
               	mov	x2, #0xeb               // =235
               	strb	w2, [x1, #0x5]
               	mov	x2, #0x69               // =105
               	strb	w2, [x0, #0x6]
               	mov	x2, #0xea               // =234
               	strb	w2, [x1, #0x6]
               	mov	x2, #0x7a               // =122
               	strb	w2, [x0, #0x7]
               	mov	x2, #0xe9               // =233
               	strb	w2, [x1, #0x7]
               	mov	x2, #0x8b               // =139
               	strb	w2, [x0, #0x8]
               	mov	x2, #0xe8               // =232
               	strb	w2, [x1, #0x8]
               	mov	x2, #0x9c               // =156
               	strb	w2, [x0, #0x9]
               	mov	x2, #0xe7               // =231
               	strb	w2, [x1, #0x9]
               	mov	x1, #0xad               // =173
               	strb	w1, [x0, #0xa]
               	sub	x2, x29, #0xb0
               	mov	x0, #0xe6               // =230
               	strb	w0, [x2, #0xa]
               	sub	x0, x29, #0xc0
               	mov	x1, #0xbe               // =190
               	strb	w1, [x0, #0xb]
               	mov	x1, #0xe5               // =229
               	strb	w1, [x2, #0xb]
               	mov	x1, #0xcf               // =207
               	strb	w1, [x0, #0xc]
               	mov	x1, #0xe4               // =228
               	strb	w1, [x2, #0xc]
               	mov	x1, #0xe0               // =224
               	strb	w1, [x0, #0xd]
               	mov	x1, #0xe3               // =227
               	strb	w1, [x2, #0xd]
               	mov	x1, #0xf1               // =241
               	strb	w1, [x0, #0xe]
               	mov	x1, #0xe2               // =226
               	strb	w1, [x2, #0xe]
               	mov	x1, #0x2                // =2
               	strb	w1, [x0, #0xf]
               	mov	x1, #0xe1               // =225
               	strb	w1, [x2, #0xf]
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
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
               	ldrb	w22, [x1, #0xf]
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
               	strb	w22, [x0, #0xf]
               	sub	x3, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x0, x29, #0xd0
               	ldrb	w2, [x1]
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
               	strb	w2, [x0]
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
               	sub	x4, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x4
               	sub	x2, x29, #0xa0
               	sub	x1, x29, #0x20
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x1, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x4, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
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
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x2, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	sub	x5, x29, #0xc0
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	sub	x6, x29, #0xb0
               	add	x6, x6, x1
               	ldrb	w6, [x6]
               	eor	x5, x5, x6
               	and	x5, x5, x3
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0xa0
               	sub	x3, x29, #0x90
               	sub	x4, x29, #0x80
               	sub	x1, x29, #0x30
               	mov	x0, #0xa5               // =165
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
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
               	sub	x1, x29, #0x10
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x48]
               	str	d2, [sp, #0x50]
               	str	d3, [sp, #0x58]
               	str	x1, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x4, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	ldr	x16, [sp, #0x38]
               	ldr	q3, [x16]
               	eor3	v0.16b, v1.16b, v2.16b, v3.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x40]
               	ldr	d1, [sp, #0x48]
               	ldr	d2, [sp, #0x50]
               	ldr	d3, [sp, #0x58]
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
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x2, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xa5               // =165
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sub	x4, x29, #0xa0
               	sxtw	x1, w0
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	sub	x5, x29, #0xc0
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	sub	x6, x29, #0xb0
               	add	x6, x6, x1
               	ldrb	w6, [x6]
               	eor	x5, x5, x6
               	eor	x5, x5, x2
               	and	x5, x5, x3
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0xa0
               	add	x0, x1, #0x0
               	mov	x2, #0xf                // =15
               	strb	w2, [x0]
               	mov	x0, #0xe                // =14
               	strb	w0, [x1, #0x1]
               	mov	x0, #0xd                // =13
               	strb	w0, [x1, #0x2]
               	mov	x0, #0xc                // =12
               	strb	w0, [x1, #0x3]
               	mov	x0, #0xb                // =11
               	strb	w0, [x1, #0x4]
               	mov	x0, #0xa                // =10
               	strb	w0, [x1, #0x5]
               	mov	x0, #0x9                // =9
               	strb	w0, [x1, #0x6]
               	mov	x0, #0x8                // =8
               	strb	w0, [x1, #0x7]
               	mov	x0, #0x7                // =7
               	strb	w0, [x1, #0x8]
               	mov	x0, #0x6                // =6
               	strb	w0, [x1, #0x9]
               	mov	x0, #0x5                // =5
               	strb	w0, [x1, #0xa]
               	mov	x0, #0x4                // =4
               	strb	w0, [x1, #0xb]
               	mov	x0, #0x3                // =3
               	strb	w0, [x1, #0xc]
               	mov	x0, #0x2                // =2
               	strb	w0, [x1, #0xd]
               	mov	x0, #0x1                // =1
               	strb	w0, [x1, #0xe]
               	mov	x0, #0x0                // =0
               	strb	w0, [x1, #0xf]
               	sub	x4, x29, #0x90
               	sub	x3, x29, #0x30
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x3, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x2, x29, #0x60
               	ldrb	w5, [x3]
               	ldrb	w6, [x3, #0x1]
               	ldrb	w7, [x3, #0x2]
               	ldrb	w8, [x3, #0x3]
               	ldrb	w9, [x3, #0x4]
               	ldrb	w10, [x3, #0x5]
               	ldrb	w11, [x3, #0x6]
               	ldrb	w12, [x3, #0x7]
               	ldrb	w13, [x3, #0x8]
               	ldrb	w14, [x3, #0x9]
               	ldrb	w15, [x3, #0xa]
               	ldrb	w20, [x3, #0xb]
               	ldrb	w21, [x3, #0xc]
               	ldrb	w22, [x3, #0xd]
               	ldrb	w23, [x3, #0xe]
               	ldrb	w3, [x3, #0xf]
               	strb	w5, [x2]
               	strb	w6, [x2, #0x1]
               	strb	w7, [x2, #0x2]
               	strb	w8, [x2, #0x3]
               	strb	w9, [x2, #0x4]
               	strb	w10, [x2, #0x5]
               	strb	w11, [x2, #0x6]
               	strb	w12, [x2, #0x7]
               	strb	w13, [x2, #0x8]
               	strb	w14, [x2, #0x9]
               	strb	w15, [x2, #0xa]
               	strb	w20, [x2, #0xb]
               	strb	w21, [x2, #0xc]
               	strb	w22, [x2, #0xd]
               	strb	w23, [x2, #0xe]
               	strb	w3, [x2, #0xf]
               	sub	x3, x29, #0x20
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x3, [sp, #0x20]
               	str	x4, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x2, x29, #0xd0
               	ldrb	w4, [x3]
               	ldrb	w5, [x3, #0x1]
               	ldrb	w6, [x3, #0x2]
               	ldrb	w7, [x3, #0x3]
               	ldrb	w8, [x3, #0x4]
               	ldrb	w9, [x3, #0x5]
               	ldrb	w10, [x3, #0x6]
               	ldrb	w11, [x3, #0x7]
               	ldrb	w12, [x3, #0x8]
               	ldrb	w13, [x3, #0x9]
               	ldrb	w14, [x3, #0xa]
               	ldrb	w15, [x3, #0xb]
               	ldrb	w20, [x3, #0xc]
               	ldrb	w21, [x3, #0xd]
               	ldrb	w22, [x3, #0xe]
               	ldrb	w3, [x3, #0xf]
               	strb	w4, [x2]
               	strb	w5, [x2, #0x1]
               	strb	w6, [x2, #0x2]
               	strb	w7, [x2, #0x3]
               	strb	w8, [x2, #0x4]
               	strb	w9, [x2, #0x5]
               	strb	w10, [x2, #0x6]
               	strb	w11, [x2, #0x7]
               	strb	w12, [x2, #0x8]
               	strb	w13, [x2, #0x9]
               	strb	w14, [x2, #0xa]
               	strb	w15, [x2, #0xb]
               	strb	w20, [x2, #0xc]
               	strb	w21, [x2, #0xd]
               	strb	w22, [x2, #0xe]
               	strb	w3, [x2, #0xf]
               	sub	x3, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x3
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	b	<addr>
               	sub	x2, x29, #0xa0
               	sxtw	x1, w0
               	add	x2, x2, x1
               	ldrb	w3, [x2]
               	sub	x4, x29, #0xc0
               	mov	x2, #0xf                // =15
               	sub	x2, x2, x0
               	sxtw	x2, w2
               	add	x2, x4, x2
               	ldrb	w2, [x2]
               	cmp	w3, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0xa0
               	sub	x0, x29, #0x30
               	mov	x1, #0x13               // =19
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x50
               	ldrb	w2, [x0]
               	ldrb	w4, [x0, #0x1]
               	ldrb	w5, [x0, #0x2]
               	ldrb	w6, [x0, #0x3]
               	ldrb	w7, [x0, #0x4]
               	ldrb	w8, [x0, #0x5]
               	ldrb	w9, [x0, #0x6]
               	ldrb	w10, [x0, #0x7]
               	ldrb	w11, [x0, #0x8]
               	ldrb	w12, [x0, #0x9]
               	ldrb	w13, [x0, #0xa]
               	ldrb	w14, [x0, #0xb]
               	ldrb	w15, [x0, #0xc]
               	ldrb	w20, [x0, #0xd]
               	ldrb	w21, [x0, #0xe]
               	ldrb	w22, [x0, #0xf]
               	strb	w2, [x1]
               	strb	w4, [x1, #0x1]
               	strb	w5, [x1, #0x2]
               	strb	w6, [x1, #0x3]
               	strb	w7, [x1, #0x4]
               	strb	w8, [x1, #0x5]
               	strb	w9, [x1, #0x6]
               	strb	w10, [x1, #0x7]
               	strb	w11, [x1, #0x8]
               	strb	w12, [x1, #0x9]
               	strb	w13, [x1, #0xa]
               	strb	w14, [x1, #0xb]
               	strb	w15, [x1, #0xc]
               	strb	w20, [x1, #0xd]
               	strb	w21, [x1, #0xe]
               	strb	w22, [x1, #0xf]
               	mov	x2, #0x11               // =17
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x2, x29, #0x40
               	ldrb	w4, [x0]
               	ldrb	w5, [x0, #0x1]
               	ldrb	w6, [x0, #0x2]
               	ldrb	w7, [x0, #0x3]
               	ldrb	w8, [x0, #0x4]
               	ldrb	w9, [x0, #0x5]
               	ldrb	w10, [x0, #0x6]
               	ldrb	w11, [x0, #0x7]
               	ldrb	w12, [x0, #0x8]
               	ldrb	w13, [x0, #0x9]
               	ldrb	w14, [x0, #0xa]
               	ldrb	w15, [x0, #0xb]
               	ldrb	w20, [x0, #0xc]
               	ldrb	w21, [x0, #0xd]
               	ldrb	w22, [x0, #0xe]
               	ldrb	w0, [x0, #0xf]
               	strb	w4, [x2]
               	strb	w5, [x2, #0x1]
               	strb	w6, [x2, #0x2]
               	strb	w7, [x2, #0x3]
               	strb	w8, [x2, #0x4]
               	strb	w9, [x2, #0x5]
               	strb	w10, [x2, #0x6]
               	strb	w11, [x2, #0x7]
               	strb	w12, [x2, #0x8]
               	strb	w13, [x2, #0x9]
               	strb	w14, [x2, #0xa]
               	strb	w15, [x2, #0xb]
               	strb	w20, [x2, #0xc]
               	strb	w21, [x2, #0xd]
               	strb	w22, [x2, #0xe]
               	strb	w0, [x2, #0xf]
               	sub	x0, x29, #0x20
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	str	x2, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	pmul	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x20, x29, #0xd0
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x0, #0x3]
               	ldrb	w6, [x0, #0x4]
               	ldrb	w7, [x0, #0x5]
               	ldrb	w8, [x0, #0x6]
               	ldrb	w9, [x0, #0x7]
               	ldrb	w10, [x0, #0x8]
               	ldrb	w11, [x0, #0x9]
               	ldrb	w12, [x0, #0xa]
               	ldrb	w13, [x0, #0xb]
               	ldrb	w14, [x0, #0xc]
               	ldrb	w15, [x0, #0xd]
               	ldrb	w21, [x0, #0xe]
               	ldrb	w0, [x0, #0xf]
               	strb	w1, [x20]
               	strb	w2, [x20, #0x1]
               	strb	w4, [x20, #0x2]
               	strb	w5, [x20, #0x3]
               	strb	w6, [x20, #0x4]
               	strb	w7, [x20, #0x5]
               	strb	w8, [x20, #0x6]
               	strb	w9, [x20, #0x7]
               	strb	w10, [x20, #0x8]
               	strb	w11, [x20, #0x9]
               	strb	w12, [x20, #0xa]
               	strb	w13, [x20, #0xb]
               	strb	w14, [x20, #0xc]
               	strb	w15, [x20, #0xd]
               	strb	w21, [x20, #0xe]
               	strb	w0, [x20, #0xf]
               	sub	x21, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x21]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x3, [sp, #0x20]
               	str	x21, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x22, x29, #0xa0
               	ldrb	w0, [x22]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	sub	x0, x29, #0x90
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0xd0
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x21]
               	ldr	x10, [x20, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x22, [sp, #0x20]
               	str	x21, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x3, #0x0                // =0
               	mov	x8, #0x80               // =128
               	mov	x4, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sub	x5, x29, #0xc0
               	sxtw	x1, w0
               	add	x6, x5, x1
               	ldrb	w7, [x6]
               	lsl	x2, x7, #1
               	and	x5, x7, x8
               	cbz	x5, <addr>
               	mov	x5, #0x1d               // =29
               	eor	x2, x2, x5
               	and	x2, x2, x4
               	sub	x5, x29, #0xa0
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	and	x2, x2, x4
               	cmp	w5, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x5, x3
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
