
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

<vaeseq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	sub	x16, x29, #0x50
               	str	x16, [sp, #0x20]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x28]
               	ldr	x16, [sp, #0x20]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	aese	v0.16b, v1.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	sub	x0, x29, #0x50
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<vaesdq_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	stur	q0, [x29, #-0x50]
               	stur	q1, [x29, #-0x40]
               	sub	x16, x29, #0x50
               	str	x16, [sp, #0x20]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x28]
               	ldr	x16, [sp, #0x20]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	aesd	v0.16b, v1.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	sub	x0, x29, #0x50
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

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
               	and	x1, x0, #0xff
               	and	x2, x1, #0x1
               	lsr	x3, x1, #4
               	and	x3, x3, #0x1
               	eor	x3, x2, x3
               	lsr	x4, x1, #5
               	and	x6, x4, #0x1
               	eor	x3, x3, x6
               	lsr	x4, x1, #6
               	and	x4, x4, #0x1
               	eor	x5, x3, x4
               	lsr	x3, x1, #7
               	eor	x5, x5, x3
               	eor	x7, x5, #0x1
               	lsr	x5, x1, #1
               	and	x5, x5, #0x1
               	eor	x6, x5, x6
               	eor	x6, x6, x4
               	eor	x6, x6, x3
               	eor	x6, x6, x2
               	eor	x6, x6, #0x1
               	lsl	x6, x6, #1
               	orr	x7, x7, x6
               	lsr	x6, x1, #2
               	and	x6, x6, #0x1
               	eor	x4, x6, x4
               	eor	x4, x4, x3
               	eor	x4, x4, x2
               	eor	x4, x4, x5
               	lsl	x4, x4, #2
               	orr	x4, x7, x4
               	lsr	x1, x1, #3
               	and	x1, x1, #0x1
               	eor	x1, x1, x3
               	eor	x1, x1, x2
               	eor	x1, x1, x5
               	eor	x1, x1, x6
               	lsl	x1, x1, #3
               	orr	x5, x4, x1
               	and	x0, x0, #0xff
               	lsr	x1, x0, #4
               	and	x1, x1, #0x1
               	and	x2, x0, #0x1
               	eor	x2, x1, x2
               	lsr	x3, x0, #1
               	and	x4, x3, #0x1
               	eor	x3, x2, x4
               	lsr	x2, x0, #2
               	and	x2, x2, #0x1
               	eor	x6, x3, x2
               	lsr	x3, x0, #3
               	and	x3, x3, #0x1
               	eor	x6, x6, x3
               	lsl	x6, x6, #4
               	orr	x6, x5, x6
               	lsr	x5, x0, #5
               	and	x5, x5, #0x1
               	eor	x4, x5, x4
               	eor	x4, x4, x2
               	eor	x4, x4, x3
               	eor	x4, x4, x1
               	eor	x4, x4, #0x1
               	lsl	x4, x4, #5
               	orr	x6, x6, x4
               	lsr	x4, x0, #6
               	and	x4, x4, #0x1
               	eor	x2, x4, x2
               	eor	x2, x2, x3
               	eor	x1, x2, x1
               	eor	x1, x1, x5
               	eor	x1, x1, #0x1
               	lsl	x1, x1, #6
               	orr	x1, x6, x1
               	lsr	x2, x0, #7
               	lsr	x3, x0, #3
               	and	x3, x3, #0x1
               	eor	x2, x2, x3
               	lsr	x3, x0, #4
               	and	x3, x3, #0x1
               	eor	x2, x2, x3
               	lsr	x0, x0, #5
               	and	x0, x0, #0x1
               	eor	x0, x2, x0
               	eor	x0, x0, x4
               	lsl	x0, x0, #7
               	orr	x0, x1, x0
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
               	sub	sp, sp, #0x180
               	str	x20, [sp]
               	sub	x0, x29, #0x170
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	sub	x1, x29, #0x160
               	mov	x2, #0xa5               // =165
               	strb	w2, [x1]
               	mov	x2, #0x2a               // =42
               	strb	w2, [x0, #0x1]
               	mov	x2, #0xae               // =174
               	strb	w2, [x1, #0x1]
               	mov	x2, #0x4f               // =79
               	strb	w2, [x0, #0x2]
               	mov	x2, #0xb3               // =179
               	strb	w2, [x1, #0x2]
               	mov	x2, #0x74               // =116
               	strb	w2, [x0, #0x3]
               	mov	x2, #0x84               // =132
               	strb	w2, [x1, #0x3]
               	mov	x2, #0x99               // =153
               	strb	w2, [x0, #0x4]
               	mov	x2, #0x89               // =137
               	strb	w2, [x1, #0x4]
               	mov	x2, #0xbe               // =190
               	strb	w2, [x0, #0x5]
               	mov	x2, #0x92               // =146
               	strb	w2, [x1, #0x5]
               	mov	x2, #0xe3               // =227
               	strb	w2, [x0, #0x6]
               	mov	x2, #0xe7               // =231
               	strb	w2, [x1, #0x6]
               	mov	x2, #0x8                // =8
               	strb	w2, [x0, #0x7]
               	mov	x2, #0xe8               // =232
               	strb	w2, [x1, #0x7]
               	mov	x2, #0x2d               // =45
               	strb	w2, [x0, #0x8]
               	mov	x2, #0xfd               // =253
               	strb	w2, [x1, #0x8]
               	mov	x2, #0x52               // =82
               	strb	w2, [x0, #0x9]
               	mov	x2, #0xc6               // =198
               	strb	w2, [x1, #0x9]
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x160
               	mov	x1, #0xcb               // =203
               	strb	w1, [x0, #0xa]
               	sub	x1, x29, #0x170
               	mov	x2, #0x9c               // =156
               	strb	w2, [x1, #0xb]
               	mov	x2, #0xdc               // =220
               	strb	w2, [x0, #0xb]
               	mov	x2, #0xc1               // =193
               	strb	w2, [x1, #0xc]
               	mov	x2, #0x21               // =33
               	strb	w2, [x0, #0xc]
               	mov	x2, #0xe6               // =230
               	strb	w2, [x1, #0xd]
               	mov	x2, #0x2a               // =42
               	strb	w2, [x0, #0xd]
               	mov	x2, #0xb                // =11
               	strb	w2, [x1, #0xe]
               	mov	x2, #0x3f               // =63
               	strb	w2, [x0, #0xe]
               	mov	x2, #0x30               // =48
               	strb	w2, [x1, #0xf]
               	strb	wzr, [x0, #0xf]
               	sub	x2, x29, #0x40
               	ldrb	w3, [x1]
               	ldrb	w4, [x0]
               	eor	x3, x3, x4
               	strb	w3, [x2]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x0, #0x1]
               	eor	x3, x3, x4
               	strb	w3, [x2, #0x1]
               	ldrb	w3, [x1, #0x2]
               	ldrb	w4, [x0, #0x2]
               	eor	x3, x3, x4
               	strb	w3, [x2, #0x2]
               	ldrb	w3, [x1, #0x3]
               	ldrb	w4, [x0, #0x3]
               	eor	x3, x3, x4
               	strb	w3, [x2, #0x3]
               	ldrb	w1, [x1, #0x4]
               	ldrb	w0, [x0, #0x4]
               	eor	x0, x1, x0
               	strb	w0, [x2, #0x4]
               	sub	x1, x29, #0x170
               	ldrb	w0, [x1, #0x5]
               	sub	x3, x29, #0x160
               	ldrb	w4, [x3, #0x5]
               	eor	x0, x0, x4
               	strb	w0, [x2, #0x5]
               	ldrb	w0, [x1, #0x6]
               	ldrb	w4, [x3, #0x6]
               	eor	x0, x0, x4
               	strb	w0, [x2, #0x6]
               	ldrb	w0, [x1, #0x7]
               	ldrb	w4, [x3, #0x7]
               	eor	x0, x0, x4
               	strb	w0, [x2, #0x7]
               	ldrb	w0, [x1, #0x8]
               	ldrb	w4, [x3, #0x8]
               	eor	x0, x0, x4
               	strb	w0, [x2, #0x8]
               	ldrb	w0, [x1, #0x9]
               	ldrb	w4, [x3, #0x9]
               	eor	x0, x0, x4
               	strb	w0, [x2, #0x9]
               	sub	x0, x29, #0x40
               	ldrb	w2, [x1, #0xa]
               	ldrb	w4, [x3, #0xa]
               	eor	x2, x2, x4
               	strb	w2, [x0, #0xa]
               	ldrb	w2, [x1, #0xb]
               	ldrb	w4, [x3, #0xb]
               	eor	x2, x2, x4
               	strb	w2, [x0, #0xb]
               	ldrb	w1, [x1, #0xc]
               	ldrb	w2, [x3, #0xc]
               	eor	x1, x1, x2
               	strb	w1, [x0, #0xc]
               	sub	x1, x29, #0x170
               	ldrb	w3, [x1, #0xd]
               	sub	x2, x29, #0x160
               	ldrb	w4, [x2, #0xd]
               	eor	x3, x3, x4
               	strb	w3, [x0, #0xd]
               	ldrb	w3, [x1, #0xe]
               	ldrb	w2, [x2, #0xe]
               	eor	x2, x3, x2
               	strb	w2, [x0, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w1, [x0, #0xf]
               	sub	x1, x29, #0x30
               	bl	<addr>
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0]
               	bl	<addr>
               	strb	w0, [x20]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x1]
               	bl	<addr>
               	strb	w0, [x20, #0x1]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x2]
               	bl	<addr>
               	strb	w0, [x20, #0x2]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x3]
               	bl	<addr>
               	strb	w0, [x20, #0x3]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x4]
               	bl	<addr>
               	strb	w0, [x20, #0x4]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x5]
               	bl	<addr>
               	strb	w0, [x20, #0x5]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x6]
               	bl	<addr>
               	strb	w0, [x20, #0x6]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x7]
               	bl	<addr>
               	strb	w0, [x20, #0x7]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x8]
               	bl	<addr>
               	strb	w0, [x20, #0x8]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x9]
               	bl	<addr>
               	strb	w0, [x20, #0x9]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xa]
               	bl	<addr>
               	strb	w0, [x20, #0xa]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xb]
               	bl	<addr>
               	strb	w0, [x20, #0xb]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xc]
               	bl	<addr>
               	strb	w0, [x20, #0xc]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xd]
               	bl	<addr>
               	strb	w0, [x20, #0xd]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xe]
               	bl	<addr>
               	strb	w0, [x20, #0xe]
               	sub	x20, x29, #0x140
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xf]
               	bl	<addr>
               	strb	w0, [x20, #0xf]
               	sub	x20, x29, #0x150
               	sub	x7, x29, #0x170
               	sub	x0, x29, #0x160
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x90]
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x140
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xd0]
               	ldr	x0, [sp, #0xd0]
               	dup	v0.16b, w0
               	sub	x7, x29, #0x130
               	str	q0, [x7]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x170
               	ldr	q0, [x0]
               	ldr	q1, [x7]
               	bl	<addr>
               	stur	q0, [x29, #-0xa0]
               	sub	x7, x29, #0xa0
               	sub	x0, x29, #0x130
               	ldr	q0, [x7]
               	ldr	q1, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x90]
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x170
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x170
               	str	x16, [sp, #0xd0]
               	ldr	x16, [sp, #0xd0]
               	ldr	q1, [x16]
               	aesmc	v0.16b, v1.16b
               	str	q0, [sp, #0xd0]
               	ldr	q1, [sp, #0xd0]
               	aesimc	v0.16b, v1.16b
               	sub	x17, x29, #0x150
               	str	q0, [x17]
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x170
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x16, x29, #0x170
               	str	x16, [sp, #0xd0]
               	ldr	x16, [sp, #0xd0]
               	ldr	q1, [x16]
               	aesmc	v0.16b, v1.16b
               	sub	x17, x29, #0x150
               	str	q0, [x17]
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0]
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
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0, #0x1]
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
               	eor	x1, x1, x2
               	sub	x0, x29, #0x170
               	ldrb	w2, [x0, #0x2]
               	eor	x1, x1, x2
               	ldrb	w0, [x0, #0x3]
               	eor	x0, x1, x0
               	sub	x1, x29, #0x150
               	ldrb	w1, [x1]
               	cmp	w1, w0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0, #0x1]
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
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0, #0x2]
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
               	eor	x1, x1, x2
               	sub	x0, x29, #0x170
               	ldrb	w2, [x0, #0x3]
               	eor	x1, x1, x2
               	ldrb	w0, [x0]
               	eor	x0, x1, x0
               	sub	x1, x29, #0x150
               	ldrb	w1, [x1, #0x1]
               	cmp	w1, w0
               	b.ne	<addr>
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0, #0x2]
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
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0, #0x3]
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
               	eor	x1, x1, x2
               	sub	x0, x29, #0x170
               	ldrb	w2, [x0]
               	eor	x1, x1, x2
               	ldrb	w0, [x0, #0x1]
               	eor	x0, x1, x0
               	sub	x1, x29, #0x150
               	ldrb	w1, [x1, #0x2]
               	cmp	w1, w0
               	b.ne	<addr>
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0, #0x3]
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
               	sub	x0, x29, #0x170
               	ldrb	w0, [x0]
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
               	eor	x1, x1, x2
               	sub	x0, x29, #0x170
               	ldrb	w2, [x0, #0x1]
               	eor	x1, x1, x2
               	ldrb	w0, [x0, #0x2]
               	eor	x0, x1, x0
               	sub	x1, x29, #0x150
               	ldrb	w1, [x1, #0x3]
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
               	str	x16, [sp, #0xd0]
               	mov	x16, #0xdef1            // =57073
               	movk	x16, #0x9abc, lsl #16
               	movk	x16, #0x5678, lsl #32
               	movk	x16, #0x1234, lsl #48
               	str	x16, [sp, #0xd8]
               	ldr	d1, [sp, #0xd0]
               	ldr	d2, [sp, #0xd8]
               	pmull	v0.1q, v1.1d, v2.1d
               	sub	x17, x29, #0x120
               	str	q0, [x17]
               	sub	x0, x29, #0x120
               	ldr	x3, [x0]
               	cmp	x3, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	cmp	x2, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x13              // =19
               	str	x16, [sp, #0xd0]
               	mov	x16, #0x11              // =17
               	str	x16, [sp, #0xd8]
               	ldr	d1, [sp, #0xd0]
               	ldr	d2, [sp, #0xd8]
               	pmull	v0.1q, v1.1d, v2.1d
               	str	q0, [x0]
               	sub	x0, x29, #0x120
               	ldr	x1, [x0]
               	cmp	x1, #0x123
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
