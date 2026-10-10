
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
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x30]
               	mov	x0, #0xf0               // =240
               	sturb	w0, [x29, #-0x20]
               	mov	x0, #0x14               // =20
               	sturb	w0, [x29, #-0x2f]
               	mov	x0, #0xef               // =239
               	sturb	w0, [x29, #-0x1f]
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x2e]
               	mov	x0, #0xee               // =238
               	sturb	w0, [x29, #-0x1e]
               	mov	x0, #0x36               // =54
               	sturb	w0, [x29, #-0x2d]
               	mov	x0, #0xed               // =237
               	sturb	w0, [x29, #-0x1d]
               	mov	x0, #0x47               // =71
               	sturb	w0, [x29, #-0x2c]
               	mov	x0, #0xec               // =236
               	sturb	w0, [x29, #-0x1c]
               	mov	x0, #0x58               // =88
               	sturb	w0, [x29, #-0x2b]
               	mov	x0, #0xeb               // =235
               	sturb	w0, [x29, #-0x1b]
               	mov	x0, #0x69               // =105
               	sturb	w0, [x29, #-0x2a]
               	mov	x0, #0xea               // =234
               	sturb	w0, [x29, #-0x1a]
               	mov	x0, #0x7a               // =122
               	sturb	w0, [x29, #-0x29]
               	mov	x0, #0xe9               // =233
               	sturb	w0, [x29, #-0x19]
               	mov	x0, #0x8b               // =139
               	sturb	w0, [x29, #-0x28]
               	mov	x0, #0xe8               // =232
               	sturb	w0, [x29, #-0x18]
               	mov	x0, #0x9c               // =156
               	sturb	w0, [x29, #-0x27]
               	mov	x0, #0xe7               // =231
               	sturb	w0, [x29, #-0x17]
               	mov	x0, #0xad               // =173
               	sturb	w0, [x29, #-0x26]
               	mov	x0, #0xe6               // =230
               	sturb	w0, [x29, #-0x16]
               	sub	x1, x29, #0x30
               	mov	x0, #0xbe               // =190
               	sturb	w0, [x29, #-0x25]
               	mov	x0, #0xe5               // =229
               	sturb	w0, [x29, #-0x15]
               	mov	x0, #0xcf               // =207
               	sturb	w0, [x29, #-0x24]
               	mov	x0, #0xe4               // =228
               	sturb	w0, [x29, #-0x14]
               	mov	x0, #0xe0               // =224
               	sturb	w0, [x29, #-0x23]
               	mov	x0, #0xe3               // =227
               	sturb	w0, [x29, #-0x13]
               	mov	x0, #0xf1               // =241
               	sturb	w0, [x29, #-0x22]
               	mov	x0, #0xe2               // =226
               	sturb	w0, [x29, #-0x12]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x21]
               	mov	x0, #0xe1               // =225
               	sturb	w0, [x29, #-0x11]
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
               	sub	x2, x29, #0x10
               	mov	x1, #0xf                // =15
               	sturb	w1, [x29, #-0x10]
               	mov	x0, #0xe                // =14
               	sturb	w0, [x29, #-0xf]
               	mov	x0, #0xd                // =13
               	sturb	w0, [x29, #-0xe]
               	mov	x0, #0xc                // =12
               	sturb	w0, [x29, #-0xd]
               	mov	x0, #0xb                // =11
               	sturb	w0, [x29, #-0xc]
               	mov	x0, #0xa                // =10
               	sturb	w0, [x29, #-0xb]
               	mov	x0, #0x9                // =9
               	sturb	w0, [x29, #-0xa]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x9]
               	mov	x0, #0x7                // =7
               	sturb	w0, [x29, #-0x8]
               	mov	x0, #0x6                // =6
               	sturb	w0, [x29, #-0x7]
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x6]
               	mov	x0, #0x4                // =4
               	sturb	w0, [x29, #-0x5]
               	mov	x0, #0x3                // =3
               	sturb	w0, [x29, #-0x4]
               	mov	x0, #0x2                // =2
               	sturb	w0, [x29, #-0x3]
               	mov	x0, #0x1                // =1
               	sturb	w0, [x29, #-0x2]
               	sturb	wzr, [x29, #-0x1]
               	sub	x16, x29, #0x10
               	ldr	q1, [x16]
               	tbl	v1.16b, { v0.16b }, v1.16b
               	sub	x16, x29, #0x10
               	str	q1, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	sub	x4, x29, #0x30
               	sub	x5, x1, x0
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
               	ldurb	w0, [x29, #-0x10]
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
