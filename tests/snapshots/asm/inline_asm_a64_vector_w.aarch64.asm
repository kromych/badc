
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
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x30
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	sub	x1, x29, #0x20
               	mov	x2, #0xf0               // =240
               	strb	w2, [x1]
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
               	sub	x0, x29, #0x20
               	mov	x1, #0xe6               // =230
               	strb	w1, [x0, #0xa]
               	sub	x1, x29, #0x30
               	mov	x2, #0xbe               // =190
               	strb	w2, [x1, #0xb]
               	mov	x2, #0xe5               // =229
               	strb	w2, [x0, #0xb]
               	mov	x2, #0xcf               // =207
               	strb	w2, [x1, #0xc]
               	mov	x2, #0xe4               // =228
               	strb	w2, [x0, #0xc]
               	mov	x2, #0xe0               // =224
               	strb	w2, [x1, #0xd]
               	mov	x2, #0xe3               // =227
               	strb	w2, [x0, #0xd]
               	mov	x2, #0xf1               // =241
               	strb	w2, [x1, #0xe]
               	mov	x2, #0xe2               // =226
               	strb	w2, [x0, #0xe]
               	mov	x2, #0x2                // =2
               	strb	w2, [x1, #0xf]
               	mov	x2, #0xe1               // =225
               	strb	w2, [x0, #0xf]
               	sub	x16, x29, #0x30
               	ldr	q0, [x16]
               	sub	x2, x29, #0x20
               	sub	x16, x29, #0x20
               	ldr	q1, [x16]
               	sub	x3, x29, #0x10
               	eor	v2.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x10
               	str	q2, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x1, x0]
               	ldrb	w6, [x2, x0]
               	eor	x5, x5, x6
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x10
               	mov	x16, #0xa5              // =165
               	dup	v2.16b, w16
               	eor3	v1.16b, v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa5               // =165
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x1, x0]
               	sub	x6, x29, #0x20
               	ldrb	w6, [x6, x0]
               	eor	x5, x5, x6
               	eor	x5, x5, x3
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	mov	x2, #0xf                // =15
               	strb	w2, [x1]
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
               	strb	wzr, [x1, #0xf]
               	sub	x16, x29, #0x10
               	ldr	q1, [x16]
               	tbl	v1.16b, { v0.16b }, v1.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	sub	x4, x29, #0x30
               	sub	x5, x2, x0
               	ldrb	w4, [x4, x5]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x16, #0x13              // =19
               	dup	v1.16b, w16
               	mov	x16, #0x11              // =17
               	dup	v2.16b, w16
               	pmul	v1.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	sub	x3, x29, #0x10
               	ldrb	w0, [x3]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x1d               // =29
               	mov	x16, #0x1d              // =29
               	dup	v1.16b, w16
               	sshr	v2.16b, v0.16b, #0x7
               	shl	v0.16b, v0.16b, #0x1
               	and	v1.16b, v2.16b, v1.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	sub	x2, x29, #0x30
               	ldrb	w2, [x2, x0]
               	lsl	x5, x2, #1
               	tbz	w2, #0x7, <addr>
               	mov	x2, x4
               	eor	x2, x5, x2
               	and	x2, x2, #0xff
               	ldrb	w5, [x3, x0]
               	cmp	w5, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, x1
               	eor	x2, x5, x2
               	and	x2, x2, #0xff
               	ldrb	w5, [x3, x0]
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
