
arm_neon_intrinsics.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x40
               	mov	x1, #0x7                // =7
               	strb	w1, [x0]
               	sub	x1, x29, #0x30
               	mov	x2, #0xc3               // =195
               	strb	w2, [x1]
               	sub	x2, x29, #0x20
               	mov	x3, #0x1                // =1
               	strb	w3, [x2]
               	mov	x3, #0x26               // =38
               	strb	w3, [x0, #0x1]
               	mov	x3, #0xc6               // =198
               	strb	w3, [x1, #0x1]
               	mov	x3, #0x2                // =2
               	strb	w3, [x2, #0x1]
               	mov	x3, #0x45               // =69
               	strb	w3, [x0, #0x2]
               	mov	x3, #0xc9               // =201
               	strb	w3, [x1, #0x2]
               	mov	x3, #0x5                // =5
               	strb	w3, [x2, #0x2]
               	mov	x3, #0x64               // =100
               	strb	w3, [x0, #0x3]
               	mov	x3, #0xcc               // =204
               	strb	w3, [x1, #0x3]
               	mov	x3, #0xa                // =10
               	strb	w3, [x2, #0x3]
               	mov	x3, #0x83               // =131
               	strb	w3, [x0, #0x4]
               	mov	x3, #0xd7               // =215
               	strb	w3, [x1, #0x4]
               	mov	x3, #0x11               // =17
               	strb	w3, [x2, #0x4]
               	mov	x3, #0xa2               // =162
               	strb	w3, [x0, #0x5]
               	mov	x3, #0xda               // =218
               	strb	w3, [x1, #0x5]
               	mov	x3, #0x1a               // =26
               	strb	w3, [x2, #0x5]
               	mov	x3, #0xc1               // =193
               	strb	w3, [x0, #0x6]
               	mov	x3, #0xdd               // =221
               	strb	w3, [x1, #0x6]
               	mov	x1, #0x25               // =37
               	strb	w1, [x2, #0x6]
               	mov	x1, #0xe0               // =224
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x30
               	strb	w1, [x0, #0x7]
               	sub	x1, x29, #0x20
               	mov	x2, #0x32               // =50
               	strb	w2, [x1, #0x7]
               	sub	x2, x29, #0x40
               	mov	x3, #0xff               // =255
               	strb	w3, [x2, #0x8]
               	mov	x4, #0xeb               // =235
               	strb	w4, [x0, #0x8]
               	mov	x4, #0x41               // =65
               	strb	w4, [x1, #0x8]
               	mov	x4, #0x1e               // =30
               	strb	w4, [x2, #0x9]
               	mov	x4, #0xee               // =238
               	strb	w4, [x0, #0x9]
               	mov	x4, #0x52               // =82
               	strb	w4, [x1, #0x9]
               	mov	x4, #0x3d               // =61
               	strb	w4, [x2, #0xa]
               	mov	x4, #0xf1               // =241
               	strb	w4, [x0, #0xa]
               	mov	x4, #0x65               // =101
               	strb	w4, [x1, #0xa]
               	mov	x4, #0x5c               // =92
               	strb	w4, [x2, #0xb]
               	mov	x4, #0xf4               // =244
               	strb	w4, [x0, #0xb]
               	mov	x4, #0x7a               // =122
               	strb	w4, [x1, #0xb]
               	mov	x4, #0x7b               // =123
               	strb	w4, [x2, #0xc]
               	strb	w3, [x0, #0xc]
               	mov	x3, #0x91               // =145
               	strb	w3, [x1, #0xc]
               	mov	x3, #0x9a               // =154
               	strb	w3, [x2, #0xd]
               	mov	x3, #0x82               // =130
               	strb	w3, [x0, #0xd]
               	mov	x0, #0xaa               // =170
               	strb	w0, [x1, #0xd]
               	mov	x0, #0xb9               // =185
               	strb	w0, [x2, #0xe]
               	sub	x0, x29, #0x30
               	mov	x1, #0x85               // =133
               	strb	w1, [x0, #0xe]
               	sub	x1, x29, #0x20
               	mov	x2, #0xc5               // =197
               	strb	w2, [x1, #0xe]
               	sub	x2, x29, #0x40
               	mov	x3, #0xd8               // =216
               	strb	w3, [x2, #0xf]
               	mov	x2, #0x88               // =136
               	strb	w2, [x0, #0xf]
               	mov	x0, #0xe2               // =226
               	strb	w0, [x1, #0xf]
               	mov	x4, #0x1d               // =29
               	mov	x16, #0x1d              // =29
               	dup	v2.16b, w16
               	sub	x1, x29, #0x40
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x2, x29, #0x30
               	sub	x16, x29, #0x30
               	ldr	q1, [x16]
               	eor	v3.16b, v0.16b, v1.16b
               	sshr	v4.16b, v0.16b, #0x7
               	shl	v0.16b, v0.16b, #0x1
               	and	v2.16b, v4.16b, v2.16b
               	eor	v0.16b, v0.16b, v2.16b
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x3, x29, #0x10
               	sub	x16, x29, #0x10
               	str	q3, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x3, x0]
               	ldrb	w6, [x1, x0]
               	ldrb	w7, [x2, x0]
               	eor	x6, x6, x7
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x10
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldrb	w6, [x5, x0]
               	ldrb	w3, [x1, x0]
               	lsl	x7, x3, #1
               	tbz	w3, #0x7, <addr>
               	mov	x3, x4
               	eor	x3, x7, x3
               	and	x3, x3, #0xff
               	sub	x7, x29, #0x30
               	ldrb	w7, [x7, x0]
               	eor	x3, x3, x7
               	cmp	w6, w3
               	b.eq	<addr>
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x50
               	mov	x1, #0x2                // =2
               	strb	w1, [x0]
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x14               // =20
               	strb	w1, [x0, #0x2]
               	mov	x1, #0x1d               // =29
               	strb	w1, [x0, #0x3]
               	mov	x1, #0x26               // =38
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x2f               // =47
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x38               // =56
               	strb	w1, [x0, #0x6]
               	mov	x1, #0x41               // =65
               	strb	w1, [x0, #0x7]
               	mov	x1, #0x4a               // =74
               	strb	w1, [x0, #0x8]
               	mov	x1, #0x53               // =83
               	strb	w1, [x0, #0x9]
               	mov	x1, #0x5c               // =92
               	strb	w1, [x0, #0xa]
               	mov	x1, #0x65               // =101
               	strb	w1, [x0, #0xb]
               	mov	x1, #0x6e               // =110
               	strb	w1, [x0, #0xc]
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0xd]
               	mov	x1, #0x80               // =128
               	strb	w1, [x0, #0xe]
               	mov	x1, #0x89               // =137
               	strb	w1, [x0, #0xf]
               	sub	x16, x29, #0x50
               	ldr	q0, [x16]
               	sub	x1, x29, #0x20
               	sub	x16, x29, #0x20
               	ldr	q1, [x16]
               	mov	x16, #0xf               // =15
               	dup	v2.16b, w16
               	and	v1.16b, v1.16b, v2.16b
               	tbl	v0.16b, { v0.16b }, v1.16b
               	sub	x2, x29, #0x10
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x2, x0]
               	sub	x4, x29, #0x50
               	ldrb	w5, [x1, x0]
               	and	x5, x5, #0xf
               	ldrb	w4, [x4, x5]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x3, x29, #0x30
               	sub	x16, x29, #0x30
               	ldr	q1, [x16]
               	pmul	v0.16b, v0.16b, v1.16b
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x40
               	ldrb	w4, [x1, x2]
               	mov	x1, x0
               	ldrb	w5, [x3, x2]
               	mov	x6, #0x1                // =1
               	lsl	x6, x6, x0
               	sxtw	x6, w6
               	and	x5, x5, x6
               	cbz	x5, <addr>
               	lsl	x5, x4, x0
               	and	x5, x5, #0xff
               	eor	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x10
               	ldrb	w0, [x0, x2]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x40
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x2, x29, #0x30
               	sub	x16, x29, #0x30
               	ldr	q1, [x16]
               	eor	v0.16b, v0.16b, v1.16b
               	sub	x3, x29, #0x10
               	sub	x16, x29, #0x10
               	str	q0, [x16]
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
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
