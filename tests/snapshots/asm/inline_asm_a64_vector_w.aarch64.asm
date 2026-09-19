
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
               	sub	sp, sp, #0x60
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
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v4.16b, v0.16b
               	sub	x2, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	sub	x3, x29, #0x10
               	str	q4, [sp]
               	str	q3, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x10
               	b.ge	<addr>
               	ldrb	w5, [x3, x0]
               	ldrb	w4, [x1, x0]
               	ldrb	w6, [x2, x0]
               	eor	x4, x4, x6
               	cmp	w5, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x10
               	mov	x16, #0xa5              // =165
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	str	q4, [sp]
               	str	q3, [sp, #0x10]
               	str	q0, [sp, #0x20]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	ldr	q3, [sp, #0x20]
               	eor3	v0.16b, v1.16b, v2.16b, v3.16b
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x4, #0xa5               // =165
               	cmp	w0, #0x10
               	b.ge	<addr>
               	ldrb	w5, [x2, x0]
               	ldrb	w6, [x1, x0]
               	sub	x3, x29, #0x20
               	ldrb	w3, [x3, x0]
               	eor	x3, x6, x3
               	eor	x3, x3, x4
               	cmp	w5, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	mov	x4, #0xf                // =15
               	strb	w4, [x1]
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
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	str	q4, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x10
               	b.ge	<addr>
               	ldrb	w5, [x1, x0]
               	sub	x3, x29, #0x30
               	sub	x2, x4, x0
               	ldrb	w2, [x3, x2]
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x16, #0x13              // =19
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	mov	v1.16b, v0.16b
               	mov	x16, #0x11              // =17
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	str	q1, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	pmul	v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	sub	x3, x29, #0x10
               	ldrb	w0, [x3]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x6, #0x1d               // =29
               	mov	x16, #0x1d              // =29
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	mov	v2.16b, v0.16b
               	str	q4, [sp]
               	ldr	q1, [sp]
               	sshr	v0.16b, v1.16b, #0x7
               	mov	v3.16b, v0.16b
               	str	q4, [sp]
               	ldr	q1, [sp]
               	shl	v0.16b, v1.16b, #0x1
               	mov	v4.16b, v0.16b
               	str	q3, [sp]
               	str	q2, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	and	v0.16b, v1.16b, v2.16b
               	str	q4, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0x30
               	ldrb	w5, [x1, x0]
               	lsl	x2, x5, #1
               	and	x1, x5, #0x80
               	cbz	x1, <addr>
               	mov	x1, x6
               	eor	x1, x2, x1
               	and	x1, x1, #0xff
               	ldrb	w2, [x3, x0]
               	cmp	w2, w1
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, x4
               	eor	x1, x2, x1
               	and	x1, x1, #0xff
               	ldrb	w2, [x3, x0]
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
