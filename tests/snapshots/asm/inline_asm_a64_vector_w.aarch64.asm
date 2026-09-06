
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

<load16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x30
               	str	x1, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<xor16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x70
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<dup16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x30
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	str	x1, [sp, #0x10]
               	str	x0, [sp, #0x18]
               	ldr	x0, [sp, #0x18]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x10]
               	str	q0, [x16]
               	sub	x0, x29, #0x30
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<tbl16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x70
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<pmul16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	sub	x2, x29, #0x70
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	str	x2, [sp, #0x40]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	pmul	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<eor3_16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	sub	x16, x29, #0x90
               	str	q1, [x16]
               	sub	x16, x29, #0x80
               	str	q2, [x16]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x90
               	sub	x3, x29, #0x80
               	str	x0, [sp, #0x40]
               	str	x1, [sp, #0x48]
               	str	x2, [sp, #0x50]
               	str	x3, [sp, #0x58]
               	ldr	x16, [sp, #0x48]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x50]
               	ldr	q2, [x16]
               	ldr	x16, [sp, #0x58]
               	ldr	q3, [x16]
               	eor3	v0.16b, v1.16b, v2.16b, v3.16b
               	ldr	x16, [sp, #0x40]
               	str	q0, [x16]
               	sub	x0, x29, #0x70
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret

<gf2x8_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	sub	x16, x29, #0xe0
               	str	q0, [x16]
               	mov	x0, #0x1d               // =29
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0xe0
               	str	x0, [sp, #0x50]
               	str	x1, [sp, #0x58]
               	ldr	x16, [sp, #0x58]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x50]
               	str	q0, [x16]
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xe0
               	str	x0, [sp, #0x50]
               	str	x1, [sp, #0x58]
               	ldr	x16, [sp, #0x58]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x50]
               	str	q0, [x16]
               	sub	x0, x29, #0xb0
               	sub	x1, x29, #0xd0
               	sub	x2, x29, #0xa0
               	str	x0, [sp, #0x50]
               	str	x1, [sp, #0x58]
               	str	x2, [sp, #0x60]
               	ldr	x16, [sp, #0x58]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x60]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x50]
               	str	q0, [x16]
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0xb0
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x110]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x100]
               	add	x29, sp, #0x100
               	sub	x0, x29, #0x60
               	add	x1, x0, #0x0
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	sub	x1, x29, #0x50
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
               	sub	x0, x29, #0x50
               	mov	x1, #0xe6               // =230
               	strb	w1, [x0, #0xa]
               	sub	x20, x29, #0x60
               	mov	x1, #0xbe               // =190
               	strb	w1, [x20, #0xb]
               	mov	x1, #0xe5               // =229
               	strb	w1, [x0, #0xb]
               	mov	x1, #0xcf               // =207
               	strb	w1, [x20, #0xc]
               	mov	x1, #0xe4               // =228
               	strb	w1, [x0, #0xc]
               	mov	x1, #0xe0               // =224
               	strb	w1, [x20, #0xd]
               	mov	x1, #0xe3               // =227
               	strb	w1, [x0, #0xd]
               	mov	x1, #0xf1               // =241
               	strb	w1, [x20, #0xe]
               	mov	x1, #0xe2               // =226
               	strb	w1, [x0, #0xe]
               	mov	x1, #0x2                // =2
               	strb	w1, [x20, #0xf]
               	mov	x1, #0xe1               // =225
               	strb	w1, [x0, #0xf]
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x21, x29, #0x50
               	mov	x0, x21
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x0, x29, #0x70
               	sub	x1, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x22, x29, #0x40
               	sub	x0, x29, #0xe0
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x22, [sp, #0x50]
               	str	x0, [sp, #0x58]
               	ldr	x0, [sp, #0x50]
               	ldr	x16, [sp, #0x58]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x22, x1
               	ldrb	w3, [x3]
               	add	x4, x20, x1
               	ldrb	w4, [x4]
               	add	x5, x21, x1
               	ldrb	w5, [x5]
               	eor	x4, x4, x5
               	and	x4, x4, x2
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x40
               	sub	x21, x29, #0xe0
               	sub	x22, x29, #0xd0
               	mov	x0, #0xa5               // =165
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x2, x29, #0x80
               	ldr	q0, [x21]
               	ldr	q1, [x22]
               	ldr	q2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x20, [sp, #0x50]
               	str	x0, [sp, #0x58]
               	ldr	x0, [sp, #0x50]
               	ldr	x16, [sp, #0x58]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, #0xa5               // =165
               	mov	x3, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x20, x1
               	ldrb	w4, [x4]
               	sub	x5, x29, #0x60
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	sub	x6, x29, #0x50
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
               	sub	x20, x29, #0x40
               	add	x0, x20, #0x0
               	mov	x1, #0xf                // =15
               	strb	w1, [x0]
               	mov	x0, #0xe                // =14
               	strb	w0, [x20, #0x1]
               	mov	x0, #0xd                // =13
               	strb	w0, [x20, #0x2]
               	mov	x0, #0xc                // =12
               	strb	w0, [x20, #0x3]
               	mov	x0, #0xb                // =11
               	strb	w0, [x20, #0x4]
               	mov	x0, #0xa                // =10
               	strb	w0, [x20, #0x5]
               	mov	x0, #0x9                // =9
               	strb	w0, [x20, #0x6]
               	mov	x0, #0x8                // =8
               	strb	w0, [x20, #0x7]
               	mov	x0, #0x7                // =7
               	strb	w0, [x20, #0x8]
               	mov	x0, #0x6                // =6
               	strb	w0, [x20, #0x9]
               	mov	x0, #0x5                // =5
               	strb	w0, [x20, #0xa]
               	mov	x0, #0x4                // =4
               	strb	w0, [x20, #0xb]
               	mov	x0, #0x3                // =3
               	strb	w0, [x20, #0xc]
               	mov	x0, #0x2                // =2
               	strb	w0, [x20, #0xd]
               	mov	x0, #0x1                // =1
               	strb	w0, [x20, #0xe]
               	mov	x0, #0x0                // =0
               	strb	w0, [x20, #0xf]
               	sub	x21, x29, #0xe0
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x1, x29, #0x80
               	ldr	q0, [x21]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x20, [sp, #0x50]
               	str	x0, [sp, #0x58]
               	ldr	x0, [sp, #0x50]
               	ldr	x16, [sp, #0x58]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w3, [x2]
               	sub	x4, x29, #0x60
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
               	sub	x20, x29, #0x40
               	mov	x0, #0x13               // =19
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	sub	x21, x29, #0x90
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x1, x29, #0x80
               	ldr	q0, [x21]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x20, [sp, #0x50]
               	str	x0, [sp, #0x58]
               	ldr	x0, [sp, #0x50]
               	ldr	x16, [sp, #0x58]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	sub	x20, x29, #0x40
               	ldrb	w0, [x20]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	sub	x0, x29, #0xe0
               	ldr	q0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x1, x29, #0x70
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x20, [sp, #0x50]
               	str	x0, [sp, #0x58]
               	ldr	x0, [sp, #0x50]
               	ldr	x16, [sp, #0x58]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x3, #0x0                // =0
               	mov	x8, #0x80               // =128
               	mov	x4, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sub	x5, x29, #0x60
               	sxtw	x1, w0
               	add	x6, x5, x1
               	ldrb	w7, [x6]
               	lsl	x2, x7, #1
               	and	x5, x7, x8
               	cbz	x5, <addr>
               	mov	x5, #0x1d               // =29
               	eor	x2, x2, x5
               	and	x2, x2, x4
               	add	x5, x20, x1
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
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x100]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x110
               	ret
