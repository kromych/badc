
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x310
               	sub	x0, x29, #0x150
               	add	x1, x0, #0x0
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	sub	x1, x29, #0x140
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
               	sub	x0, x29, #0x140
               	mov	x1, #0xe6               // =230
               	strb	w1, [x0, #0xa]
               	sub	x2, x29, #0x150
               	mov	x1, #0xbe               // =190
               	strb	w1, [x2, #0xb]
               	mov	x1, #0xe5               // =229
               	strb	w1, [x0, #0xb]
               	mov	x1, #0xcf               // =207
               	strb	w1, [x2, #0xc]
               	mov	x1, #0xe4               // =228
               	strb	w1, [x0, #0xc]
               	mov	x1, #0xe0               // =224
               	strb	w1, [x2, #0xd]
               	mov	x1, #0xe3               // =227
               	strb	w1, [x0, #0xd]
               	mov	x1, #0xf1               // =241
               	strb	w1, [x2, #0xe]
               	mov	x1, #0xe2               // =226
               	strb	w1, [x0, #0xe]
               	mov	x1, #0x2                // =2
               	strb	w1, [x2, #0xf]
               	mov	x1, #0xe1               // =225
               	strb	w1, [x0, #0xf]
               	sub	x16, x29, #0x2f0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x150
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2f0
               	sub	x0, x29, #0x160
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x140
               	sub	x16, x29, #0x2f0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x140
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2f0
               	sub	x0, x29, #0x160
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x300
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x130
               	sub	x16, x29, #0x2c0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x310
               	str	x16, [sp, #0x178]
               	sub	x16, x29, #0x300
               	str	x16, [sp, #0x180]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x180]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2c0
               	sub	x0, x29, #0x160
               	ldr	x5, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x5, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x2b0
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x170]
               	ldr	x16, [sp, #0x178]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x7, x2, x1
               	ldrb	w7, [x7]
               	add	x8, x3, x1
               	ldrb	w8, [x8]
               	eor	x7, x7, x8
               	and	x7, x7, x5
               	cmp	w6, w7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x130
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x170]
               	mov	x16, #0xa5              // =165
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2a0
               	sub	x0, x29, #0x100
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x16, x29, #0x260
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x310
               	str	x16, [sp, #0x178]
               	sub	x16, x29, #0x300
               	str	x16, [sp, #0x180]
               	sub	x16, x29, #0x100
               	str	x16, [sp, #0x188]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x180]
               	ldr	q2, [x16]
               	ldr	x16, [sp, #0x188]
               	ldr	q3, [x16]
               	eor3	v0.16b, v1.16b, v2.16b, v3.16b
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x260
               	sub	x0, x29, #0x160
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x2b0
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x170]
               	ldr	x16, [sp, #0x178]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0xa5               // =165
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x6, x3, x1
               	ldrb	w6, [x6]
               	add	x7, x2, x1
               	ldrb	w7, [x7]
               	sub	x8, x29, #0x140
               	add	x8, x8, x1
               	ldrb	w8, [x8]
               	eor	x7, x7, x8
               	eor	x7, x7, x4
               	and	x7, x7, x5
               	cmp	w6, w7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x130
               	add	x0, x1, #0x0
               	mov	x4, #0xf                // =15
               	strb	w4, [x0]
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
               	sub	x16, x29, #0x2f0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x2, x29, #0x2f0
               	sub	x0, x29, #0xf0
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x16, x29, #0x230
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x310
               	str	x16, [sp, #0x178]
               	sub	x16, x29, #0xf0
               	str	x16, [sp, #0x180]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x180]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x2, x29, #0x230
               	sub	x0, x29, #0x160
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x2b0
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x170]
               	ldr	x16, [sp, #0x178]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	add	x3, x1, x2
               	ldrb	w5, [x3]
               	sub	x6, x29, #0x150
               	sub	x3, x4, x0
               	sxtw	x3, w3
               	add	x3, x6, x3
               	ldrb	w3, [x3]
               	cmp	w5, w3
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x170]
               	mov	x16, #0x13              // =19
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2a0
               	sub	x0, x29, #0xe0
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x170]
               	mov	x16, #0x11              // =17
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2a0
               	sub	x0, x29, #0xd0
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x16, x29, #0x200
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0xe0
               	str	x16, [sp, #0x178]
               	sub	x16, x29, #0xd0
               	str	x16, [sp, #0x180]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x180]
               	ldr	q2, [x16]
               	pmul	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x200
               	sub	x0, x29, #0x160
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x2b0
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x170]
               	ldr	x16, [sp, #0x178]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	sub	x8, x29, #0x130
               	ldrb	w0, [x8]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x310
               	sub	x1, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x170]
               	mov	x16, #0x1d              // =29
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x178]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x1, x29, #0x2a0
               	sub	x0, x29, #0x160
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x1b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x1e0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x1f0
               	str	x16, [sp, #0x178]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x16, x29, #0x1d0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x1f0
               	str	x16, [sp, #0x178]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x16, x29, #0x1c0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x1e0
               	str	x16, [sp, #0x178]
               	sub	x16, x29, #0x1b0
               	str	x16, [sp, #0x180]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x180]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x16, x29, #0x2c0
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x1d0
               	str	x16, [sp, #0x178]
               	sub	x16, x29, #0x1c0
               	str	x16, [sp, #0x180]
               	ldr	x16, [sp, #0x178]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x180]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x170]
               	str	q0, [x16]
               	sub	x0, x29, #0x2c0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x170
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0x2b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x170]
               	sub	x16, x29, #0x2b0
               	str	x16, [sp, #0x178]
               	ldr	x0, [sp, #0x170]
               	ldr	x16, [sp, #0x178]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x3, #0x0                // =0
               	mov	x9, #0x80               // =128
               	mov	x4, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sub	x5, x29, #0x150
               	sxtw	x1, w0
               	add	x6, x5, x1
               	ldrb	w7, [x6]
               	lsl	x2, x7, #1
               	and	x5, x7, x9
               	cbz	x5, <addr>
               	mov	x5, #0x1d               // =29
               	eor	x2, x2, x5
               	and	x2, x2, x4
               	add	x5, x8, x1
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
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x310
               	ldp	x29, x30, [sp], #0x10
               	ret
