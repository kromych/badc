
arm_neon_aes_pmull.aarch64:	file format elf64-littleaarch64

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

<sbox>:
               	and	x7, x0, #0xff
               	cbnz	w7, <addr>
               	mov	x6, #0x0                // =0
               	and	x0, x6, #0x1
               	ubfx	x5, x6, #4, #1
               	eor	x1, x0, x5
               	ubfx	x2, x6, #5, #1
               	eor	x1, x1, x2
               	ubfx	x3, x6, #6, #1
               	eor	x4, x1, x3
               	lsr	x1, x6, #7
               	eor	x4, x4, x1
               	eor	x7, x4, #0x1
               	ubfx	x4, x6, #1, #1
               	eor	x2, x4, x2
               	eor	x2, x2, x3
               	eor	x2, x2, x1
               	eor	x2, x2, x0
               	eor	x2, x2, #0x1
               	orr	x7, x7, x2, lsl #1
               	ubfx	x2, x6, #2, #1
               	eor	x3, x2, x3
               	eor	x3, x3, x1
               	eor	x3, x3, x0
               	eor	x3, x3, x4
               	orr	x7, x7, x3, lsl #2
               	ubfx	x3, x6, #3, #1
               	eor	x1, x3, x1
               	eor	x1, x1, x0
               	eor	x1, x1, x4
               	eor	x1, x1, x2
               	orr	x4, x7, x1, lsl #3
               	eor	x0, x5, x0
               	ubfx	x1, x6, #1, #1
               	eor	x0, x0, x1
               	eor	x0, x0, x2
               	eor	x0, x0, x3
               	orr	x4, x4, x0, lsl #4
               	ubfx	x0, x6, #5, #1
               	eor	x1, x0, x1
               	eor	x1, x1, x2
               	eor	x2, x1, x3
               	ubfx	x1, x6, #4, #1
               	eor	x2, x2, x1
               	eor	x2, x2, #0x1
               	orr	x4, x4, x2, lsl #5
               	ubfx	x2, x6, #6, #1
               	ubfx	x5, x6, #2, #1
               	eor	x5, x2, x5
               	eor	x3, x5, x3
               	eor	x3, x3, x1
               	eor	x3, x3, x0
               	eor	x3, x3, #0x1
               	orr	x3, x4, x3, lsl #6
               	ubfx	x4, x6, #3, #1
               	eor	x4, x4, x6, lsr #7
               	eor	x1, x4, x1
               	eor	x0, x1, x0
               	eor	x0, x0, x2
               	orr	x0, x3, x0, lsl #7
               	ret
               	mov	x6, #0x1                // =1
               	mov	x2, #0x0                // =0
               	mov	x3, x2
               	mov	x4, x6
               	mov	x1, x7
               	mov	x0, x2
               	tbz	w4, #0x0, <addr>
               	eor	x0, x0, x1
               	lsr	x4, x4, #1
               	tbz	w1, #0x7, <addr>
               	mov	x5, #0x1b               // =27
               	b	<addr>
               	mov	x5, x2
               	eor	x1, x5, x1, lsl #1
               	and	x1, x1, #0xff
               	add	x3, x3, #0x1
               	cmp	w3, #0x8
               	b.lt	<addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	add	x6, x6, #0x1
               	cmp	w6, #0x100
               	b.lt	<addr>
               	mov	x6, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0xf0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xe0]
               	add	x29, sp, #0xe0
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x90]
               	mov	x0, #0xa5               // =165
               	mov	x1, #0x0                // =0
               	fmov	d0, x1
               	mov	v0.b[0], w0
               	mov	x0, #0x2a               // =42
               	sturb	w0, [x29, #-0x8f]
               	mov	x0, #0xae               // =174
               	mov	v0.b[1], w0
               	mov	x0, #0x4f               // =79
               	sturb	w0, [x29, #-0x8e]
               	mov	x0, #0xb3               // =179
               	mov	v0.b[2], w0
               	mov	x0, #0x74               // =116
               	sturb	w0, [x29, #-0x8d]
               	mov	x0, #0x84               // =132
               	mov	v0.b[3], w0
               	mov	x0, #0x99               // =153
               	sturb	w0, [x29, #-0x8c]
               	mov	x0, #0x89               // =137
               	mov	v0.b[4], w0
               	mov	x0, #0xbe               // =190
               	sturb	w0, [x29, #-0x8b]
               	mov	x0, #0x92               // =146
               	mov	v0.b[5], w0
               	mov	x0, #0xe3               // =227
               	sturb	w0, [x29, #-0x8a]
               	mov	x0, #0xe7               // =231
               	mov	v0.b[6], w0
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x89]
               	mov	x0, #0xe8               // =232
               	mov	v0.b[7], w0
               	mov	x0, #0x2d               // =45
               	sturb	w0, [x29, #-0x88]
               	mov	x0, #0xfd               // =253
               	mov	v0.b[8], w0
               	mov	x0, #0x52               // =82
               	sturb	w0, [x29, #-0x87]
               	mov	x0, #0xc6               // =198
               	mov	v0.b[9], w0
               	mov	x0, #0x77               // =119
               	sturb	w0, [x29, #-0x86]
               	mov	x0, #0xcb               // =203
               	mov	v0.b[10], w0
               	mov	x0, #0x9c               // =156
               	sturb	w0, [x29, #-0x85]
               	mov	x0, #0xdc               // =220
               	mov	v0.b[11], w0
               	mov	x0, #0xc1               // =193
               	sturb	w0, [x29, #-0x84]
               	mov	x0, #0x21               // =33
               	mov	v0.b[12], w0
               	mov	x0, #0xe6               // =230
               	sturb	w0, [x29, #-0x83]
               	mov	x0, #0x2a               // =42
               	mov	v0.b[13], w0
               	mov	x0, #0xb                // =11
               	sturb	w0, [x29, #-0x82]
               	mov	x0, #0x3f               // =63
               	mov	v0.b[14], w0
               	mov	x0, #0x30               // =48
               	sturb	w0, [x29, #-0x81]
               	mov	x0, #0x0                // =0
               	mov	v16.16b, v0.16b
               	mov	v16.b[15], w0
               	str	q16, [sp, #0xd0]
               	ldurb	w0, [x29, #-0x90]
               	mov	x17, #0xa5              // =165
               	eor	x0, x0, x17
               	ldurb	w1, [x29, #-0x8f]
               	mov	x17, #0xae              // =174
               	eor	x20, x1, x17
               	ldurb	w1, [x29, #-0x8e]
               	mov	x17, #0xb3              // =179
               	eor	x21, x1, x17
               	ldurb	w1, [x29, #-0x8d]
               	mov	x17, #0x84              // =132
               	eor	x22, x1, x17
               	ldurb	w1, [x29, #-0x8c]
               	mov	x17, #0x89              // =137
               	eor	x23, x1, x17
               	ldurb	w1, [x29, #-0x8b]
               	mov	x17, #0x92              // =146
               	eor	x24, x1, x17
               	ldurb	w1, [x29, #-0x8a]
               	mov	x17, #0xe7              // =231
               	eor	x25, x1, x17
               	ldurb	w1, [x29, #-0x89]
               	mov	x17, #0xe8              // =232
               	eor	x26, x1, x17
               	ldurb	w1, [x29, #-0x88]
               	mov	x17, #0xfd              // =253
               	eor	x27, x1, x17
               	ldurb	w1, [x29, #-0x87]
               	mov	x17, #0xc6              // =198
               	eor	x28, x1, x17
               	ldurb	w1, [x29, #-0x86]
               	mov	x17, #0xcb              // =203
               	eor	x16, x1, x17
               	str	x16, [sp, #0xc8]
               	ldurb	w1, [x29, #-0x85]
               	mov	x17, #0xdc              // =220
               	eor	x16, x1, x17
               	str	x16, [sp, #0xc0]
               	ldurb	w1, [x29, #-0x84]
               	mov	x17, #0x21              // =33
               	eor	x16, x1, x17
               	str	x16, [sp, #0xb8]
               	ldurb	w1, [x29, #-0x83]
               	mov	x17, #0x2a              // =42
               	eor	x16, x1, x17
               	str	x16, [sp, #0xb0]
               	ldurb	w1, [x29, #-0x82]
               	eor	x16, x1, #0x3f
               	str	x16, [sp, #0xa8]
               	ldurb	w17, [x29, #-0x81]
               	str	x17, [sp, #0xa0]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x70]
               	mov	x0, x24
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x6f]
               	ldr	x0, [sp, #0xc8]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x6e]
               	ldr	x0, [sp, #0xa0]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x6d]
               	mov	x0, x23
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x6c]
               	mov	x0, x28
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x6b]
               	ldr	x0, [sp, #0xa8]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x6a]
               	mov	x0, x22
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x69]
               	mov	x0, x27
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x68]
               	ldr	x0, [sp, #0xb0]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x67]
               	mov	x0, x21
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x66]
               	mov	x0, x26
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x65]
               	ldr	x0, [sp, #0xb8]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x64]
               	mov	x0, x20
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x63]
               	mov	x0, x25
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x62]
               	ldr	x0, [sp, #0xc0]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x61]
               	ldur	q0, [x29, #-0x90]
               	str	q0, [sp, #0x80]
               	ldr	q16, [sp, #0xd0]
               	str	q16, [sp, #0x90]
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
               	aese	v0.16b, v1.16b
               	stur	q0, [x29, #-0x80]
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x70
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x16, #0x0               // =0
               	dup	v2.16b, w16
               	ldur	q0, [x29, #-0x90]
               	str	q0, [sp, #0x80]
               	str	q2, [sp, #0x90]
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
               	aese	v0.16b, v1.16b
               	str	q0, [sp, #0x80]
               	str	q2, [sp, #0x90]
               	ldr	q0, [sp, #0x80]
               	ldr	q1, [sp, #0x90]
               	aesd	v0.16b, v1.16b
               	stur	q0, [x29, #-0x80]
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	ldur	q0, [x29, #-0x90]
               	aesmc	v0.16b, v0.16b
               	aesimc	v0.16b, v0.16b
               	stur	q0, [x29, #-0x80]
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x90
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	ldur	q0, [x29, #-0x90]
               	aesmc	v0.16b, v0.16b
               	stur	q0, [x29, #-0x80]
               	ldurb	w0, [x29, #-0x90]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	tbz	w0, #0x7, <addr>
               	mov	x5, #0x1b               // =27
               	b	<addr>
               	mov	x5, x3
               	eor	x0, x5, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x8f]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	tbz	w0, #0x7, <addr>
               	mov	x6, #0x1b               // =27
               	b	<addr>
               	mov	x6, x4
               	eor	x0, x6, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x8e]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x8d]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x80]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	ldurb	w0, [x29, #-0x8f]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	tbz	w0, #0x7, <addr>
               	mov	x5, #0x1b               // =27
               	b	<addr>
               	mov	x5, x3
               	eor	x0, x5, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x8e]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	tbz	w0, #0x7, <addr>
               	mov	x6, #0x1b               // =27
               	b	<addr>
               	mov	x6, x4
               	eor	x0, x6, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x8d]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x90]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x7f]
               	cmp	w1, w0
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x8e]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	tbz	w0, #0x7, <addr>
               	mov	x5, #0x1b               // =27
               	b	<addr>
               	mov	x5, x3
               	eor	x0, x5, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x8d]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	tbz	w0, #0x7, <addr>
               	mov	x6, #0x1b               // =27
               	b	<addr>
               	mov	x6, x4
               	eor	x0, x6, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x90]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x8f]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x7e]
               	cmp	w1, w0
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x8d]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	tbz	w0, #0x7, <addr>
               	mov	x5, #0x1b               // =27
               	b	<addr>
               	mov	x5, x3
               	eor	x0, x5, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x90]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	tbz	w0, #0x7, <addr>
               	mov	x6, #0x1b               // =27
               	b	<addr>
               	mov	x6, x4
               	eor	x0, x6, x0, lsl #1
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x8f]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x8e]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x7d]
               	cmp	w1, w0
               	b.ne	<addr>
               	mov	x3, #0xbeef             // =48879
               	movk	x3, #0xdead, lsl #16
               	movk	x3, #0xface, lsl #32
               	movk	x3, #0xf00d, lsl #48
               	mov	x4, #0xdef1             // =57073
               	movk	x4, #0x9abc, lsl #16
               	movk	x4, #0x5678, lsl #32
               	movk	x4, #0x1234, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x2, x0
               	lsr	x5, x4, x0
               	tbz	w5, #0x0, <addr>
               	lsl	x5, x3, x0
               	eor	x2, x2, x5
               	cbz	x0, <addr>
               	mov	x5, #0x40               // =64
               	sub	x5, x5, x0
               	lsr	x5, x3, x5
               	eor	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x16, #0xbeef            // =48879
               	movk	x16, #0xdead, lsl #16
               	movk	x16, #0xface, lsl #32
               	movk	x16, #0xf00d, lsl #48
               	str	x16, [sp, #0x80]
               	mov	x16, #0xdef1            // =57073
               	movk	x16, #0x9abc, lsl #16
               	movk	x16, #0x5678, lsl #32
               	movk	x16, #0x1234, lsl #48
               	str	x16, [sp, #0x88]
               	ldr	d1, [sp, #0x80]
               	ldr	d2, [sp, #0x88]
               	pmull	v0.1q, v1.1d, v2.1d
               	mov	x0, v0.d[0]
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x16, #0x13              // =19
               	str	x16, [sp, #0x80]
               	mov	x16, #0x11              // =17
               	str	x16, [sp, #0x88]
               	ldr	d1, [sp, #0x80]
               	ldr	d2, [sp, #0x88]
               	pmull	v0.1q, v1.1d, v2.1d
               	mov	x0, v0.d[0]
               	cmp	x0, #0x123
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xe0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xf0
               	ret
