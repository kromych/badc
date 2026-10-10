
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

<gf_inv>:
               	mov	x7, x0
               	and	x0, x7, #0xff
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x5, #0x1                // =1
               	and	x1, x7, #0xff
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x0, x5
               	mov	x2, x3
               	tbz	w0, #0x0, <addr>
               	eor	x2, x2, x1
               	lsr	x0, x0, #1
               	lsl	x6, x1, #1
               	tbz	w1, #0x7, <addr>
               	mov	x1, #0x1b               // =27
               	b	<addr>
               	mov	x1, x3
               	eor	x1, x6, x1
               	and	x1, x1, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	eor	x0, x2, #0x1
               	cbz	w0, <addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x100
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, x5
               	ret

<sbox>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	and	x0, x0, #0xff
               	bl	<addr>
               	and	x0, x0, #0xff
               	and	x1, x0, #0x1
               	lsr	x2, x0, #4
               	and	x6, x2, #0x1
               	eor	x2, x1, x6
               	lsr	x3, x0, #5
               	and	x3, x3, #0x1
               	eor	x2, x2, x3
               	lsr	x4, x0, #6
               	and	x4, x4, #0x1
               	eor	x5, x2, x4
               	lsr	x2, x0, #7
               	eor	x5, x5, x2
               	eor	x7, x5, #0x1
               	lsr	x5, x0, #1
               	and	x5, x5, #0x1
               	eor	x3, x5, x3
               	eor	x3, x3, x4
               	eor	x3, x3, x2
               	eor	x3, x3, x1
               	eor	x3, x3, #0x1
               	lsl	x3, x3, #1
               	orr	x7, x7, x3
               	lsr	x3, x0, #2
               	and	x3, x3, #0x1
               	eor	x4, x3, x4
               	eor	x4, x4, x2
               	eor	x4, x4, x1
               	eor	x4, x4, x5
               	lsl	x4, x4, #2
               	orr	x7, x7, x4
               	lsr	x4, x0, #3
               	and	x4, x4, #0x1
               	eor	x2, x4, x2
               	eor	x2, x2, x1
               	eor	x2, x2, x5
               	eor	x2, x2, x3
               	lsl	x2, x2, #3
               	orr	x5, x7, x2
               	eor	x1, x6, x1
               	lsr	x2, x0, #1
               	and	x2, x2, #0x1
               	eor	x1, x1, x2
               	eor	x1, x1, x3
               	eor	x1, x1, x4
               	lsl	x1, x1, #4
               	orr	x5, x5, x1
               	lsr	x1, x0, #5
               	and	x1, x1, #0x1
               	eor	x2, x1, x2
               	eor	x2, x2, x3
               	eor	x3, x2, x4
               	lsr	x2, x0, #4
               	and	x2, x2, #0x1
               	eor	x3, x3, x2
               	eor	x3, x3, #0x1
               	lsl	x3, x3, #5
               	orr	x5, x5, x3
               	lsr	x3, x0, #6
               	and	x3, x3, #0x1
               	lsr	x6, x0, #2
               	and	x6, x6, #0x1
               	eor	x6, x3, x6
               	eor	x4, x6, x4
               	eor	x4, x4, x2
               	eor	x4, x4, x1
               	eor	x4, x4, #0x1
               	lsl	x4, x4, #6
               	orr	x4, x5, x4
               	lsr	x5, x0, #7
               	lsr	x0, x0, #3
               	and	x0, x0, #0x1
               	eor	x0, x5, x0
               	eor	x0, x0, x2
               	eor	x0, x0, x1
               	eor	x0, x0, x3
               	lsl	x0, x0, #7
               	orr	x0, x4, x0
               	ldp	x29, x30, [sp], #0x10
               	ret

<shift_rows>:
               	ldrb	w2, [x0]
               	strb	w2, [x1]
               	ldrb	w2, [x0, #0x5]
               	strb	w2, [x1, #0x1]
               	ldrb	w2, [x0, #0xa]
               	strb	w2, [x1, #0x2]
               	ldrb	w2, [x0, #0xf]
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	strb	w2, [x1, #0x4]
               	ldrb	w2, [x0, #0x9]
               	strb	w2, [x1, #0x5]
               	ldrb	w2, [x0, #0xe]
               	strb	w2, [x1, #0x6]
               	ldrb	w2, [x0, #0x3]
               	strb	w2, [x1, #0x7]
               	ldrb	w2, [x0, #0x8]
               	strb	w2, [x1, #0x8]
               	ldrb	w2, [x0, #0xd]
               	strb	w2, [x1, #0x9]
               	ldrb	w2, [x0, #0x2]
               	strb	w2, [x1, #0xa]
               	ldrb	w2, [x0, #0x7]
               	strb	w2, [x1, #0xb]
               	ldrb	w2, [x0, #0xc]
               	strb	w2, [x1, #0xc]
               	ldrb	w2, [x0, #0x1]
               	strb	w2, [x1, #0xd]
               	ldrb	w2, [x0, #0x6]
               	strb	w2, [x1, #0xe]
               	ldrb	w0, [x0, #0xb]
               	strb	w0, [x1, #0xf]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x80]
               	mov	x0, #0xa5               // =165
               	sturb	w0, [x29, #-0x70]
               	mov	x0, #0x2a               // =42
               	sturb	w0, [x29, #-0x7f]
               	mov	x0, #0xae               // =174
               	sturb	w0, [x29, #-0x6f]
               	mov	x0, #0x4f               // =79
               	sturb	w0, [x29, #-0x7e]
               	mov	x0, #0xb3               // =179
               	sturb	w0, [x29, #-0x6e]
               	mov	x0, #0x74               // =116
               	sturb	w0, [x29, #-0x7d]
               	mov	x0, #0x84               // =132
               	sturb	w0, [x29, #-0x6d]
               	mov	x0, #0x99               // =153
               	sturb	w0, [x29, #-0x7c]
               	mov	x0, #0x89               // =137
               	sturb	w0, [x29, #-0x6c]
               	mov	x0, #0xbe               // =190
               	sturb	w0, [x29, #-0x7b]
               	mov	x0, #0x92               // =146
               	sturb	w0, [x29, #-0x6b]
               	mov	x0, #0xe3               // =227
               	sturb	w0, [x29, #-0x7a]
               	mov	x0, #0xe7               // =231
               	sturb	w0, [x29, #-0x6a]
               	mov	x0, #0x8                // =8
               	sturb	w0, [x29, #-0x79]
               	mov	x0, #0xe8               // =232
               	sturb	w0, [x29, #-0x69]
               	mov	x0, #0x2d               // =45
               	sturb	w0, [x29, #-0x78]
               	mov	x0, #0xfd               // =253
               	sturb	w0, [x29, #-0x68]
               	mov	x0, #0x52               // =82
               	sturb	w0, [x29, #-0x77]
               	mov	x0, #0xc6               // =198
               	sturb	w0, [x29, #-0x67]
               	mov	x0, #0x77               // =119
               	sturb	w0, [x29, #-0x76]
               	mov	x0, #0xcb               // =203
               	sturb	w0, [x29, #-0x66]
               	mov	x0, #0x9c               // =156
               	sturb	w0, [x29, #-0x75]
               	mov	x0, #0xdc               // =220
               	sturb	w0, [x29, #-0x65]
               	mov	x0, #0xc1               // =193
               	sturb	w0, [x29, #-0x74]
               	mov	x0, #0x21               // =33
               	sturb	w0, [x29, #-0x64]
               	mov	x0, #0xe6               // =230
               	sturb	w0, [x29, #-0x73]
               	mov	x0, #0x2a               // =42
               	sturb	w0, [x29, #-0x63]
               	mov	x0, #0xb                // =11
               	sturb	w0, [x29, #-0x72]
               	mov	x0, #0x3f               // =63
               	sturb	w0, [x29, #-0x62]
               	mov	x0, #0x30               // =48
               	sturb	w0, [x29, #-0x71]
               	sturb	wzr, [x29, #-0x61]
               	ldurb	w0, [x29, #-0x80]
               	mov	x17, #0xa5              // =165
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x20]
               	ldurb	w0, [x29, #-0x7f]
               	mov	x17, #0xae              // =174
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x1f]
               	ldurb	w0, [x29, #-0x7e]
               	mov	x17, #0xb3              // =179
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x1e]
               	ldurb	w0, [x29, #-0x7d]
               	mov	x17, #0x84              // =132
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x1d]
               	ldurb	w0, [x29, #-0x7c]
               	mov	x17, #0x89              // =137
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x1c]
               	ldurb	w0, [x29, #-0x7b]
               	mov	x17, #0x92              // =146
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x1b]
               	ldurb	w0, [x29, #-0x7a]
               	mov	x17, #0xe7              // =231
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x1a]
               	ldurb	w0, [x29, #-0x79]
               	mov	x17, #0xe8              // =232
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x19]
               	ldurb	w0, [x29, #-0x78]
               	mov	x17, #0xfd              // =253
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x18]
               	ldurb	w0, [x29, #-0x77]
               	mov	x17, #0xc6              // =198
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x17]
               	ldurb	w0, [x29, #-0x76]
               	mov	x17, #0xcb              // =203
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x16]
               	ldurb	w0, [x29, #-0x75]
               	mov	x17, #0xdc              // =220
               	eor	x0, x0, x17
               	sturb	w0, [x29, #-0x15]
               	sub	x0, x29, #0x20
               	ldurb	w1, [x29, #-0x74]
               	mov	x17, #0x21              // =33
               	eor	x1, x1, x17
               	sturb	w1, [x29, #-0x14]
               	ldurb	w1, [x29, #-0x73]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	sturb	w1, [x29, #-0x13]
               	ldurb	w1, [x29, #-0x72]
               	eor	x1, x1, #0x3f
               	sturb	w1, [x29, #-0x12]
               	ldurb	w1, [x29, #-0x71]
               	sturb	w1, [x29, #-0x11]
               	sub	x1, x29, #0x10
               	bl	<addr>
               	ldurb	w0, [x29, #-0x10]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x50]
               	ldurb	w0, [x29, #-0xf]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4f]
               	ldurb	w0, [x29, #-0xe]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4e]
               	ldurb	w0, [x29, #-0xd]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4d]
               	ldurb	w0, [x29, #-0xc]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4c]
               	ldurb	w0, [x29, #-0xb]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4b]
               	ldurb	w0, [x29, #-0xa]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x4a]
               	ldurb	w0, [x29, #-0x9]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x49]
               	ldurb	w0, [x29, #-0x8]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x48]
               	ldurb	w0, [x29, #-0x7]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x47]
               	ldurb	w0, [x29, #-0x6]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x46]
               	ldurb	w0, [x29, #-0x5]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x45]
               	ldurb	w0, [x29, #-0x4]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x44]
               	ldurb	w0, [x29, #-0x3]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x43]
               	ldurb	w0, [x29, #-0x2]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x42]
               	ldurb	w0, [x29, #-0x1]
               	bl	<addr>
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x41]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x70]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	aese	v0.16b, v1.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x50
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	dup	v2.16b, w16
               	ldur	q0, [x29, #-0x80]
               	str	q0, [sp, #0x40]
               	str	q2, [sp, #0x50]
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	aese	v0.16b, v1.16b
               	str	q0, [sp, #0x40]
               	str	q2, [sp, #0x50]
               	ldr	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x50]
               	aesd	v0.16b, v1.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x80]
               	aesmc	v0.16b, v0.16b
               	aesimc	v0.16b, v0.16b
               	stur	q0, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x80]
               	aesmc	v0.16b, v0.16b
               	stur	q0, [x29, #-0x60]
               	ldurb	w0, [x29, #-0x80]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	lsl	x5, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x3
               	eor	x0, x5, x0
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x7f]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	lsl	x6, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x4
               	eor	x0, x6, x0
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x7e]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x7d]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x60]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x7f]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	lsl	x5, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x3
               	eor	x0, x5, x0
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x7e]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	lsl	x6, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x4
               	eor	x0, x6, x0
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x7d]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x80]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x5f]
               	cmp	w1, w0
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x7e]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	lsl	x5, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x3
               	eor	x0, x5, x0
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x7d]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	lsl	x6, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x4
               	eor	x0, x6, x0
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x80]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x7f]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x5e]
               	cmp	w1, w0
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x7d]
               	mov	x2, #0x2                // =2
               	mov	x3, #0x0                // =0
               	mov	x4, x3
               	mov	x1, x3
               	tbz	w2, #0x0, <addr>
               	eor	x1, x1, x0
               	lsr	x2, x2, #1
               	lsl	x5, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x3
               	eor	x0, x5, x0
               	and	x0, x0, #0xff
               	add	x4, x4, #0x1
               	cmp	w4, #0x8
               	b.lt	<addr>
               	ldurb	w0, [x29, #-0x80]
               	mov	x3, #0x3                // =3
               	mov	x4, #0x0                // =0
               	mov	x5, x4
               	mov	x2, x4
               	tbz	w3, #0x0, <addr>
               	eor	x2, x2, x0
               	lsr	x3, x3, #1
               	lsl	x6, x0, #1
               	tbz	w0, #0x7, <addr>
               	mov	x0, #0x1b               // =27
               	b	<addr>
               	mov	x0, x4
               	eor	x0, x6, x0
               	and	x0, x0, #0xff
               	add	x5, x5, #0x1
               	cmp	w5, #0x8
               	b.lt	<addr>
               	eor	x0, x1, x2
               	ldurb	w1, [x29, #-0x7f]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x7e]
               	eor	x0, x0, x1
               	ldurb	w1, [x29, #-0x5d]
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
               	str	x16, [sp, #0x40]
               	mov	x16, #0xdef1            // =57073
               	movk	x16, #0x9abc, lsl #16
               	movk	x16, #0x5678, lsl #32
               	movk	x16, #0x1234, lsl #48
               	str	x16, [sp, #0x48]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	pmull	v0.1q, v1.1d, v2.1d
               	stur	q0, [x29, #-0x70]
               	ldur	x0, [x29, #-0x70]
               	cmp	x0, x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x68]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x13              // =19
               	str	x16, [sp, #0x40]
               	mov	x16, #0x11              // =17
               	str	x16, [sp, #0x48]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	pmull	v0.1q, v1.1d, v2.1d
               	stur	q0, [x29, #-0x70]
               	ldur	x0, [x29, #-0x70]
               	cmp	x0, #0x123
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x68]
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
