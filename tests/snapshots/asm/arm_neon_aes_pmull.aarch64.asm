
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
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x16, x29, #0x40
               	str	q1, [x16]
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
               	sub	x16, x29, #0x50
               	str	q0, [x16]
               	sub	x16, x29, #0x40
               	str	q1, [x16]
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x10, x0
               	mov	x17, #0xff              // =255
               	and	x0, x10, x17
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x8, #0x1                // =1
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	b	<addr>
               	and	x0, x10, x3
               	sxtw	x9, w8
               	and	x1, x9, x3
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0x8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0x10]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0x8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0x8]
               	ldurb	w4, [x29, #-0x10]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0x10]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	and	x0, x0, x3
               	eor	x0, x0, x6
               	mov	w0, w0
               	cbz	x0, <addr>
               	add	x8, x9, #0x1
               	cmp	w8, #0x100
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x9, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sbox>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	bl	<addr>
               	mov	x1, x0
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	lsr	x2, x0, #0
               	mov	x17, #0x1               // =1
               	and	x3, x2, x17
               	lsr	x4, x0, #4
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x4, x3, x4
               	lsr	x8, x0, #5
               	mov	x17, #0x1               // =1
               	and	x9, x8, x17
               	eor	x6, x4, x9
               	lsr	x4, x0, #6
               	mov	x17, #0x1               // =1
               	and	x5, x4, x17
               	eor	x10, x6, x5
               	lsr	x6, x0, #7
               	mov	x17, #0x1               // =1
               	and	x7, x6, x17
               	eor	x10, x10, x7
               	mov	x17, #0x1               // =1
               	eor	x10, x10, x17
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	mov	x17, #0xff              // =255
               	and	x10, x10, x17
               	lsr	x10, x10, #0
               	sxtw	x10, w10
               	mov	x17, #0x0               // =0
               	orr	x10, x10, x17
               	mov	x17, #0xff              // =255
               	and	x12, x10, x17
               	lsr	x10, x0, #1
               	mov	x17, #0x1               // =1
               	and	x11, x10, x17
               	eor	x8, x11, x9
               	eor	x8, x8, x5
               	eor	x8, x8, x7
               	eor	x8, x8, x3
               	mov	x17, #0x1               // =1
               	eor	x8, x8, x17
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	mov	x17, #0xff              // =255
               	and	x9, x12, x17
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	lsl	x8, x8, #1
               	sxtw	x8, w8
               	orr	x8, x9, x8
               	mov	x17, #0xff              // =255
               	and	x12, x8, x17
               	lsr	x8, x0, #2
               	mov	x17, #0x1               // =1
               	and	x9, x8, x17
               	eor	x4, x9, x5
               	eor	x4, x4, x7
               	eor	x2, x4, x3
               	eor	x2, x2, x11
               	mov	x17, #0x0               // =0
               	eor	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x3, x12, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #2
               	sxtw	x2, w2
               	orr	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsr	x3, x0, #3
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x0, #7
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x0, #0
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x0, #1
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	eor	x0, x3, x9
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsl	x0, x0, #3
               	sxtw	x0, w0
               	orr	x0, x2, x0
               	mov	x17, #0xff              // =255
               	and	x10, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	lsr	x2, x0, #4
               	mov	x17, #0x1               // =1
               	and	x3, x2, x17
               	lsr	x4, x0, #0
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x4, x3, x4
               	lsr	x8, x0, #1
               	mov	x17, #0x1               // =1
               	and	x9, x8, x17
               	eor	x6, x4, x9
               	lsr	x4, x0, #2
               	mov	x17, #0x1               // =1
               	and	x5, x4, x17
               	eor	x11, x6, x5
               	lsr	x6, x0, #3
               	mov	x17, #0x1               // =1
               	and	x7, x6, x17
               	eor	x11, x11, x7
               	mov	x17, #0x0               // =0
               	eor	x11, x11, x17
               	mov	x17, #0xff              // =255
               	and	x11, x11, x17
               	mov	x17, #0xff              // =255
               	and	x12, x10, x17
               	mov	x17, #0xff              // =255
               	and	x10, x11, x17
               	lsl	x10, x10, #4
               	sxtw	x10, w10
               	orr	x10, x12, x10
               	mov	x17, #0xff              // =255
               	and	x12, x10, x17
               	lsr	x10, x0, #5
               	mov	x17, #0x1               // =1
               	and	x11, x10, x17
               	eor	x8, x11, x9
               	eor	x8, x8, x5
               	eor	x8, x8, x7
               	eor	x8, x8, x3
               	mov	x17, #0x1               // =1
               	eor	x8, x8, x17
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	mov	x17, #0xff              // =255
               	and	x9, x12, x17
               	mov	x17, #0xff              // =255
               	and	x8, x8, x17
               	lsl	x8, x8, #5
               	sxtw	x8, w8
               	orr	x8, x9, x8
               	mov	x17, #0xff              // =255
               	and	x12, x8, x17
               	lsr	x8, x0, #6
               	mov	x17, #0x1               // =1
               	and	x9, x8, x17
               	eor	x4, x9, x5
               	eor	x4, x4, x7
               	eor	x2, x4, x3
               	eor	x2, x2, x11
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x3, x12, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #6
               	sxtw	x2, w2
               	orr	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsr	x1, x0, #7
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	lsr	x3, x0, #3
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x1, x1, x3
               	lsr	x3, x0, #4
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x1, x1, x3
               	lsr	x3, x0, #5
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x1, x1, x3
               	eor	x0, x1, x9
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x1, x2, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsl	x0, x0, #7
               	sxtw	x0, w0
               	orr	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ldp	x29, x30, [sp], #0x10
               	ret

<shift_rows>:
               	mov	x2, x0
               	mov	x3, x1
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3                // =3
               	b	<addr>
               	lsl	x1, x0, #2
               	add	x5, x1, #0x0
               	sxtw	x5, w5
               	add	x6, x3, x5
               	add	x5, x0, #0x0
               	and	x5, x5, x4
               	lsl	x5, x5, #2
               	add	x5, x5, #0x0
               	sxtw	x5, w5
               	add	x5, x2, x5
               	ldrb	w5, [x5]
               	strb	w5, [x6]
               	add	x5, x1, #0x1
               	sxtw	x5, w5
               	add	x6, x3, x5
               	add	x5, x0, #0x1
               	and	x5, x5, x4
               	lsl	x5, x5, #2
               	add	x5, x5, #0x1
               	sxtw	x5, w5
               	add	x5, x2, x5
               	ldrb	w5, [x5]
               	strb	w5, [x6]
               	add	x5, x1, #0x2
               	sxtw	x5, w5
               	add	x6, x3, x5
               	add	x5, x0, #0x2
               	and	x5, x5, x4
               	lsl	x5, x5, #2
               	add	x5, x5, #0x2
               	sxtw	x5, w5
               	add	x5, x2, x5
               	ldrb	w5, [x5]
               	strb	w5, [x6]
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	add	x5, x3, x1
               	add	x1, x0, #0x3
               	and	x1, x1, x4
               	lsl	x1, x1, #2
               	add	x1, x1, #0x3
               	sxtw	x1, w1
               	add	x1, x2, x1
               	ldrb	w1, [x1]
               	strb	w1, [x5]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1a0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x180
               	add	x1, x0, #0x0
               	mov	x2, #0x5                // =5
               	strb	w2, [x1]
               	sub	x1, x29, #0x170
               	add	x2, x1, #0x0
               	mov	x3, #0xa5               // =165
               	strb	w3, [x2]
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
               	mov	x0, #0xc6               // =198
               	strb	w0, [x1, #0x9]
               	sub	x0, x29, #0x180
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0xa]
               	sub	x2, x29, #0x170
               	mov	x1, #0xcb               // =203
               	strb	w1, [x2, #0xa]
               	mov	x1, #0x9c               // =156
               	strb	w1, [x0, #0xb]
               	mov	x1, #0xdc               // =220
               	strb	w1, [x2, #0xb]
               	mov	x1, #0xc1               // =193
               	strb	w1, [x0, #0xc]
               	mov	x1, #0x21               // =33
               	strb	w1, [x2, #0xc]
               	mov	x1, #0xe6               // =230
               	strb	w1, [x0, #0xd]
               	mov	x1, #0x2a               // =42
               	strb	w1, [x2, #0xd]
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0xe]
               	mov	x1, #0x3f               // =63
               	strb	w1, [x2, #0xe]
               	mov	x1, #0x30               // =48
               	strb	w1, [x0, #0xf]
               	mov	x1, #0x0                // =0
               	strb	w1, [x2, #0xf]
               	sub	x1, x29, #0x40
               	add	x3, x1, #0x0
               	add	x4, x0, #0x0
               	ldrb	w4, [x4]
               	add	x5, x2, #0x0
               	ldrb	w5, [x5]
               	eor	x4, x4, x5
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x2, #0x1]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x2, #0x2]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x2]
               	ldrb	w3, [x0, #0x3]
               	ldrb	w2, [x2, #0x3]
               	eor	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x1, #0x3]
               	ldrb	w2, [x0, #0x4]
               	sub	x0, x29, #0x170
               	ldrb	w3, [x0, #0x4]
               	eor	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x1, #0x4]
               	sub	x2, x29, #0x180
               	ldrb	w3, [x2, #0x5]
               	ldrb	w4, [x0, #0x5]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x5]
               	ldrb	w3, [x2, #0x6]
               	ldrb	w4, [x0, #0x6]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x6]
               	ldrb	w3, [x2, #0x7]
               	ldrb	w4, [x0, #0x7]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x7]
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x8]
               	ldrb	w3, [x2, #0x9]
               	ldrb	w4, [x0, #0x9]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0x9]
               	ldrb	w3, [x2, #0xa]
               	ldrb	w4, [x0, #0xa]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0xa]
               	sub	x1, x29, #0x40
               	ldrb	w2, [x2, #0xb]
               	ldrb	w0, [x0, #0xb]
               	eor	x0, x2, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x1, #0xb]
               	sub	x0, x29, #0x180
               	ldrb	w3, [x0, #0xc]
               	sub	x2, x29, #0x170
               	ldrb	w4, [x2, #0xc]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0xc]
               	ldrb	w3, [x0, #0xd]
               	ldrb	w4, [x2, #0xd]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1, #0xd]
               	ldrb	w3, [x0, #0xe]
               	ldrb	w2, [x2, #0xe]
               	eor	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x1, #0xe]
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x1, #0xf]
               	sub	x0, x29, #0x30
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sub	x0, x29, #0x150
               	add	x20, x0, #0x0
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	bl	<addr>
               	strb	w0, [x20]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x1]
               	bl	<addr>
               	strb	w0, [x20, #0x1]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x2]
               	bl	<addr>
               	strb	w0, [x20, #0x2]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x3]
               	bl	<addr>
               	strb	w0, [x20, #0x3]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x4]
               	bl	<addr>
               	strb	w0, [x20, #0x4]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x5]
               	bl	<addr>
               	strb	w0, [x20, #0x5]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x6]
               	bl	<addr>
               	strb	w0, [x20, #0x6]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x7]
               	bl	<addr>
               	strb	w0, [x20, #0x7]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x8]
               	bl	<addr>
               	strb	w0, [x20, #0x8]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0x9]
               	bl	<addr>
               	strb	w0, [x20, #0x9]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xa]
               	bl	<addr>
               	strb	w0, [x20, #0xa]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xb]
               	bl	<addr>
               	strb	w0, [x20, #0xb]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xc]
               	bl	<addr>
               	strb	w0, [x20, #0xc]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xd]
               	bl	<addr>
               	strb	w0, [x20, #0xd]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xe]
               	bl	<addr>
               	strb	w0, [x20, #0xe]
               	sub	x20, x29, #0x150
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xf]
               	bl	<addr>
               	strb	w0, [x20, #0xf]
               	sub	x20, x29, #0x160
               	sub	x0, x29, #0x180
               	sub	x1, x29, #0x170
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x160
               	sub	x1, x29, #0x150
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0xe0]
               	ldr	x0, [sp, #0xe0]
               	dup	v0.16b, w0
               	sub	x1, x29, #0x140
               	str	q0, [x1]
               	sub	x20, x29, #0x160
               	sub	x0, x29, #0x180
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0xa0
               	str	q0, [x16]
               	sub	x0, x29, #0xa0
               	sub	x1, x29, #0x140
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	sub	x0, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x160
               	sub	x1, x29, #0x180
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x160
               	sub	x16, x29, #0x180
               	str	x16, [sp, #0xe0]
               	ldr	x16, [sp, #0xe0]
               	ldr	q1, [x16]
               	aesmc	v0.16b, v1.16b
               	str	q0, [sp, #0xe0]
               	ldr	q1, [sp, #0xe0]
               	aesimc	v0.16b, v1.16b
               	str	q0, [x0]
               	sub	x0, x29, #0x160
               	sub	x1, x29, #0x180
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x160
               	sub	x16, x29, #0x180
               	str	x16, [sp, #0xe0]
               	ldr	x16, [sp, #0xe0]
               	ldr	q1, [x16]
               	aesmc	v0.16b, v1.16b
               	str	q0, [x0]
               	sub	x0, x29, #0x180
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	mov	x1, #0x2                // =2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x8, x0, x17
               	sub	x0, x29, #0x180
               	ldrb	w0, [x0, #0x1]
               	mov	x1, #0x3                // =3
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x1, x8, x0
               	sub	x0, x29, #0x180
               	ldrb	w2, [x0, #0x2]
               	eor	x1, x1, x2
               	ldrb	w2, [x0, #0x3]
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	sub	x2, x29, #0x160
               	add	x2, x2, #0x0
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	w2, w1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0, #0x1]
               	mov	x1, #0x2                // =2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x8, x0, x17
               	sub	x0, x29, #0x180
               	ldrb	w0, [x0, #0x2]
               	mov	x1, #0x3                // =3
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x1, x8, x0
               	sub	x0, x29, #0x180
               	ldrb	w2, [x0, #0x3]
               	eor	x1, x1, x2
               	add	x2, x0, #0x0
               	ldrb	w2, [x2]
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	sub	x1, x29, #0x160
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	w1, w2
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x2]
               	mov	x1, #0x2                // =2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x8, x0, x17
               	sub	x0, x29, #0x180
               	ldrb	w0, [x0, #0x3]
               	mov	x1, #0x3                // =3
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x1, x8, x0
               	sub	x0, x29, #0x180
               	add	x2, x0, #0x0
               	ldrb	w2, [x2]
               	eor	x1, x1, x2
               	ldrb	w2, [x0, #0x1]
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	sub	x1, x29, #0x160
               	ldrb	w1, [x1, #0x2]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	w1, w2
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x3]
               	mov	x1, #0x2                // =2
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x8, x0, x17
               	sub	x0, x29, #0x180
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	mov	x1, #0x3                // =3
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	mov	x6, #0x1                // =1
               	mov	x7, #0x80               // =128
               	mov	x3, #0xff               // =255
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	ldurb	w4, [x29, #-0xa8]
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	and	x0, x0, x3
               	ldurb	w4, [x29, #-0xb0]
               	eor	x0, x0, x4
               	ldurb	w4, [x29, #-0xa8]
               	lsr	x4, x4, #1
               	sturb	w4, [x29, #-0xa8]
               	ldurb	w4, [x29, #-0xb0]
               	lsl	x5, x4, #1
               	and	x4, x4, x7
               	cbz	x4, <addr>
               	mov	x4, #0x1b               // =27
               	eor	x4, x5, x4
               	and	x4, x4, x3
               	sturb	w4, [x29, #-0xb0]
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	b	<addr>
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x1, x8, x0
               	sub	x0, x29, #0x180
               	ldrb	w2, [x0, #0x1]
               	eor	x1, x1, x2
               	ldrb	w0, [x0, #0x2]
               	eor	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	sub	x0, x29, #0x160
               	ldrb	w0, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x4, #0xbeef             // =48879
               	movk	x4, #0xdead, lsl #16
               	movk	x4, #0xface, lsl #32
               	movk	x4, #0xf00d, lsl #48
               	mov	x6, #0xdef1             // =57073
               	movk	x6, #0x9abc, lsl #16
               	movk	x6, #0x5678, lsl #32
               	movk	x6, #0x1234, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x7, #0x1                // =1
               	mov	x1, x0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x3, w0
               	lsr	x5, x6, x3
               	and	x5, x5, x7
               	cbz	x5, <addr>
               	lsl	x5, x4, x3
               	eor	x2, x2, x5
               	cbz	x3, <addr>
               	mov	x5, #0x40               // =64
               	sub	x5, x5, x0
               	sxtw	x5, w5
               	lsr	x5, x4, x5
               	eor	x1, x1, x5
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x130
               	mov	x16, #0xbeef            // =48879
               	movk	x16, #0xdead, lsl #16
               	movk	x16, #0xface, lsl #32
               	movk	x16, #0xf00d, lsl #48
               	str	x16, [sp, #0xe0]
               	mov	x16, #0xdef1            // =57073
               	movk	x16, #0x9abc, lsl #16
               	movk	x16, #0x5678, lsl #32
               	movk	x16, #0x1234, lsl #48
               	str	x16, [sp, #0xe8]
               	ldr	d1, [sp, #0xe0]
               	ldr	d2, [sp, #0xe8]
               	pmull	v0.1q, v1.1d, v2.1d
               	str	q0, [x0]
               	sub	x0, x29, #0x130
               	ldr	x3, [x0]
               	cmp	x3, x2
               	b.ne	<addr>
               	ldr	x2, [x0, #0x8]
               	cmp	x2, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x13              // =19
               	str	x16, [sp, #0xe0]
               	mov	x16, #0x11              // =17
               	str	x16, [sp, #0xe8]
               	ldr	d1, [sp, #0xe0]
               	ldr	d2, [sp, #0xe8]
               	pmull	v0.1q, v1.1d, v2.1d
               	str	q0, [x0]
               	sub	x0, x29, #0x130
               	ldr	x1, [x0]
               	cmp	x1, #0x123
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
