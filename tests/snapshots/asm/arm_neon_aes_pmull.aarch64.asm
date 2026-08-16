
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
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	aese	v0.16b, v1.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<vaesdq_u8>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x20
               	str	d0, [sp, #0x10]
               	str	d1, [sp, #0x18]
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	ldr	x16, [sp]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x8]
               	ldr	q1, [x16]
               	aesd	v0.16b, v1.16b
               	ldr	x16, [sp]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x10]
               	ldr	d1, [sp, #0x18]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<sbox>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x17, #0xff              // =255
               	and	x7, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x7, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x2, x1, #0
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	lsr	x3, x1, #4
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x2, x2, x3
               	lsr	x3, x1, #5
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x2, x2, x3
               	lsr	x3, x1, #6
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x2, x2, x3
               	lsr	x1, x1, #7
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x2, x1
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsr	x1, x1, #0
               	sxtw	x1, w1
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x3, x1, #1
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x1, #5
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #6
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #7
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x1, x1, #0
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	orr	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x3, x1, #2
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x1, #6
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #7
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #0
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x1, x1, #1
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #2
               	sxtw	x1, w1
               	orr	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x3, x1, #3
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x1, #7
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #0
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #1
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x1, x1, #2
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #3
               	sxtw	x1, w1
               	orr	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x3, x1, #4
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x1, #0
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #1
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #2
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x1, x1, #3
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #4
               	sxtw	x1, w1
               	orr	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x3, x1, #5
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x1, #1
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #2
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #3
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x1, x1, #4
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #5
               	sxtw	x1, w1
               	orr	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x2, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsr	x3, x1, #6
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	lsr	x4, x1, #2
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #3
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x4, x1, #4
               	mov	x17, #0x1               // =1
               	and	x4, x4, x17
               	eor	x3, x3, x4
               	lsr	x1, x1, #5
               	mov	x17, #0x1               // =1
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	lsl	x1, x1, #6
               	sxtw	x1, w1
               	orr	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsr	x2, x0, #7
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	lsr	x3, x0, #3
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x2, x2, x3
               	lsr	x3, x0, #4
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x2, x2, x3
               	lsr	x3, x0, #5
               	mov	x17, #0x1               // =1
               	and	x3, x3, x17
               	eor	x2, x2, x3
               	lsr	x0, x0, #6
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	eor	x0, x2, x0
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	lsl	x0, x0, #7
               	sxtw	x0, w0
               	orr	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0x1                // =1
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x7, x17
               	mov	x17, #0xff              // =255
               	and	x1, x6, x17
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	ldurb	w2, [x29, #-0x8]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ldurb	w2, [x29, #-0x10]
               	eor	x0, x0, x2
               	ldurb	w2, [x29, #-0x8]
               	lsr	x2, x2, #1
               	sturb	w2, [x29, #-0x8]
               	ldurb	w3, [x29, #-0x10]
               	lsl	x2, x3, #1
               	mov	x17, #0x80              // =128
               	and	x3, x3, x17
               	cbz	x3, <addr>
               	mov	x3, #0x1b               // =27
               	eor	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	sturb	w2, [x29, #-0x10]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	add	x1, x4, #0x1
               	sxtw	x4, w1
               	cmp	x4, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	add	x5, x6, #0x1
               	sxtw	x6, w5
               	cmp	x6, #0x100
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x6, x17
               	b	<addr>

<shift_rows>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	lsl	x3, x0, #2
               	add	x3, x3, #0x0
               	sxtw	x3, w3
               	add	x5, x1, x3
               	add	x3, x0, #0x0
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	lsl	x3, x3, #2
               	add	x3, x3, #0x0
               	sxtw	x3, w3
               	add	x3, x2, x3
               	ldrb	w3, [x3]
               	strb	w3, [x5]
               	lsl	x3, x0, #2
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	add	x5, x1, x3
               	add	x3, x0, #0x1
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	lsl	x3, x3, #2
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	add	x3, x2, x3
               	ldrb	w3, [x3]
               	strb	w3, [x5]
               	lsl	x3, x0, #2
               	add	x3, x3, #0x2
               	sxtw	x3, w3
               	add	x5, x1, x3
               	add	x3, x0, #0x2
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	lsl	x3, x3, #2
               	add	x3, x3, #0x2
               	sxtw	x3, w3
               	add	x3, x2, x3
               	ldrb	w3, [x3]
               	strb	w3, [x5]
               	lsl	x3, x0, #2
               	add	x3, x3, #0x3
               	sxtw	x3, w3
               	add	x5, x1, x3
               	add	x3, x0, #0x3
               	mov	x17, #0x3               // =3
               	and	x3, x3, x17
               	lsl	x3, x3, #2
               	add	x3, x3, #0x3
               	sxtw	x3, w3
               	add	x3, x2, x3
               	ldrb	w3, [x3]
               	strb	w3, [x5]
               	add	x0, x4, #0x1
               	sxtw	x4, w0
               	cmp	x4, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0xc8
               	add	x0, x0, #0x0
               	mov	x1, #0x5                // =5
               	strb	w1, [x0]
               	sub	x0, x29, #0xd8
               	add	x0, x0, #0x0
               	mov	x1, #0xa5               // =165
               	strb	w1, [x0]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x2a               // =42
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xae               // =174
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x4f               // =79
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xb3               // =179
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x74               // =116
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x84               // =132
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x99               // =153
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x89               // =137
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xbe               // =190
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x92               // =146
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xe3               // =227
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xe7               // =231
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xe8               // =232
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x2d               // =45
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xfd               // =253
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x52               // =82
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xc6               // =198
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xcb               // =203
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x9c               // =156
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0xd8
               	mov	x1, #0xdc               // =220
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xc1               // =193
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x21               // =33
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xe6               // =230
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x2a               // =42
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0xc8
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x3f               // =63
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0xc8
               	mov	x1, #0x30               // =48
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xd8
               	mov	x1, #0x0                // =0
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x110
               	add	x0, x0, #0x0
               	sub	x1, x29, #0xc8
               	add	x1, x1, #0x0
               	ldrb	w1, [x1]
               	sub	x2, x29, #0xd8
               	add	x2, x2, #0x0
               	ldrb	w2, [x2]
               	eor	x1, x1, x2
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x1]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x1]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x2]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x2]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x3]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x3]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x4]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x4]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x5]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x5]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x6]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x6]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x7]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x7]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x8]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x8]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0x9]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0x9]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0xa]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0xa]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0xb]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0xb]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0xc]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0xc]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0xd]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0xd]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w2, [x1, #0xe]
               	sub	x1, x29, #0xd8
               	ldrb	w1, [x1, #0xe]
               	eor	x1, x2, x1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0xc8
               	ldrb	w1, [x1, #0xf]
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x110
               	sub	x1, x29, #0x120
               	bl	<addr>
               	sub	x0, x29, #0xf8
               	add	x20, x0, #0x0
               	sub	x0, x29, #0x120
               	add	x0, x0, #0x0
               	ldrb	w0, [x0]
               	bl	<addr>
               	strb	w0, [x20]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x1]
               	bl	<addr>
               	strb	w0, [x20, #0x1]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x2]
               	bl	<addr>
               	strb	w0, [x20, #0x2]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x3]
               	bl	<addr>
               	strb	w0, [x20, #0x3]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x4]
               	bl	<addr>
               	strb	w0, [x20, #0x4]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x5]
               	bl	<addr>
               	strb	w0, [x20, #0x5]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x6]
               	bl	<addr>
               	strb	w0, [x20, #0x6]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x7]
               	bl	<addr>
               	strb	w0, [x20, #0x7]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x8]
               	bl	<addr>
               	strb	w0, [x20, #0x8]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0x9]
               	bl	<addr>
               	strb	w0, [x20, #0x9]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0xa]
               	bl	<addr>
               	strb	w0, [x20, #0xa]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0xb]
               	bl	<addr>
               	strb	w0, [x20, #0xb]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0xc]
               	bl	<addr>
               	strb	w0, [x20, #0xc]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0xd]
               	bl	<addr>
               	strb	w0, [x20, #0xd]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0xe]
               	bl	<addr>
               	strb	w0, [x20, #0xe]
               	sub	x20, x29, #0xf8
               	sub	x0, x29, #0x120
               	ldrb	w0, [x0, #0xf]
               	bl	<addr>
               	strb	w0, [x20, #0xf]
               	sub	x20, x29, #0xe8
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0xd8
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x48
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0xe8
               	sub	x1, x29, #0xf8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x28
               	sub	x0, x29, #0x58
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
               	ldrb	w7, [x1, #0x5]
               	ldrb	w8, [x1, #0x6]
               	ldrb	w9, [x1, #0x7]
               	ldrb	w10, [x1, #0x8]
               	ldrb	w11, [x1, #0x9]
               	ldrb	w12, [x1, #0xa]
               	ldrb	w13, [x1, #0xb]
               	ldrb	w14, [x1, #0xc]
               	ldrb	w15, [x1, #0xd]
               	ldrb	w20, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
               	strb	w7, [x0, #0x5]
               	strb	w8, [x0, #0x6]
               	strb	w9, [x0, #0x7]
               	strb	w10, [x0, #0x8]
               	strb	w11, [x0, #0x9]
               	strb	w12, [x0, #0xa]
               	strb	w13, [x0, #0xb]
               	strb	w14, [x0, #0xc]
               	strb	w15, [x0, #0xd]
               	strb	w20, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x58
               	sub	x1, x29, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x20, x29, #0xe8
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0x140
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x68
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x68
               	sub	x1, x29, #0x140
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	sub	x16, x29, #0x78
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x78
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	sub	x0, x29, #0xe8
               	sub	x1, x29, #0xc8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xe8
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0x38
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	aesmc	v0.16b, v1.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x1, x29, #0x38
               	sub	x0, x29, #0x88
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x88
               	sub	x1, x29, #0x38
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	aesimc	v0.16b, v1.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x1, x29, #0x38
               	sub	x0, x29, #0x98
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x98
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0xe8
               	sub	x1, x29, #0xc8
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0xe8
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0x38
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	aesmc	v0.16b, v1.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x1, x29, #0x38
               	sub	x0, x29, #0xa8
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x1]
               	ldrb	w5, [x1, #0x2]
               	ldrb	w6, [x1, #0x3]
               	ldrb	w7, [x1, #0x4]
               	ldrb	w8, [x1, #0x5]
               	ldrb	w9, [x1, #0x6]
               	ldrb	w10, [x1, #0x7]
               	ldrb	w11, [x1, #0x8]
               	ldrb	w12, [x1, #0x9]
               	ldrb	w13, [x1, #0xa]
               	ldrb	w14, [x1, #0xb]
               	ldrb	w15, [x1, #0xc]
               	ldrb	w20, [x1, #0xd]
               	ldrb	w21, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w3, [x0]
               	strb	w4, [x0, #0x1]
               	strb	w5, [x0, #0x2]
               	strb	w6, [x0, #0x3]
               	strb	w7, [x0, #0x4]
               	strb	w8, [x0, #0x5]
               	strb	w9, [x0, #0x6]
               	strb	w10, [x0, #0x7]
               	strb	w11, [x0, #0x8]
               	strb	w12, [x0, #0x9]
               	strb	w13, [x0, #0xa]
               	strb	w14, [x0, #0xb]
               	strb	w15, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	strb	w21, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xa8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	mov	x5, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0xc8
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	mov	x1, #0x2                // =2
               	stur	x0, [x29, #-0x38]
               	sub	x17, x29, #0x1a0
               	str	x1, [x17]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sub	x16, x29, #0x1a0
               	ldrb	w2, [x16]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ldurb	w2, [x29, #-0x38]
               	eor	x0, x0, x2
               	sub	x16, x29, #0x1a0
               	ldrb	w2, [x16]
               	lsr	x2, x2, #1
               	sub	x17, x29, #0x1a0
               	strb	w2, [x17]
               	ldurb	w3, [x29, #-0x38]
               	lsl	x2, x3, #1
               	mov	x17, #0x80              // =128
               	and	x3, x3, x17
               	cbz	x3, <addr>
               	mov	x3, #0x1b               // =27
               	eor	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	sturb	w2, [x29, #-0x38]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	add	x1, x4, #0x1
               	sxtw	x4, w1
               	cmp	x4, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x7, x0, x17
               	sub	x1, x29, #0xc8
               	add	x0, x5, #0x1
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	add	x0, x1, x0
               	ldrb	w0, [x0]
               	mov	x1, #0x3                // =3
               	stur	x0, [x29, #-0x38]
               	sub	x17, x29, #0x1a0
               	str	x1, [x17]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	sub	x16, x29, #0x1a0
               	ldrb	w2, [x16]
               	mov	x17, #0x1               // =1
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	ldurb	w2, [x29, #-0x38]
               	eor	x0, x0, x2
               	sub	x16, x29, #0x1a0
               	ldrb	w2, [x16]
               	lsr	x2, x2, #1
               	sub	x17, x29, #0x1a0
               	strb	w2, [x17]
               	ldurb	w3, [x29, #-0x38]
               	lsl	x2, x3, #1
               	mov	x17, #0x80              // =128
               	and	x3, x3, x17
               	cbz	x3, <addr>
               	mov	x3, #0x1b               // =27
               	eor	x2, x2, x3
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	sturb	w2, [x29, #-0x38]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	add	x1, x4, #0x1
               	sxtw	x4, w1
               	cmp	x4, #0x8
               	b.lt	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	eor	x1, x7, x0
               	sub	x2, x29, #0xc8
               	add	x0, x5, #0x2
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	add	x0, x2, x0
               	ldrb	w0, [x0]
               	eor	x1, x1, x0
               	sub	x2, x29, #0xc8
               	add	x0, x5, #0x3
               	sxtw	x0, w0
               	mov	x17, #0x3               // =3
               	and	x0, x0, x17
               	add	x0, x2, x0
               	ldrb	w0, [x0]
               	eor	x0, x1, x0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	sub	x1, x29, #0xe8
               	add	x1, x1, x6
               	ldrb	w1, [x1]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x1, x0
               	b.ne	<addr>
               	add	x5, x6, #0x1
               	sxtw	x6, w5
               	cmp	x6, #0x4
               	b.lt	<addr>
               	mov	x4, #0xbeef             // =48879
               	movk	x4, #0xdead, lsl #16
               	movk	x4, #0xface, lsl #32
               	movk	x4, #0xf00d, lsl #48
               	mov	x6, #0xdef1             // =57073
               	movk	x6, #0x9abc, lsl #16
               	movk	x6, #0x5678, lsl #32
               	movk	x6, #0x1234, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x3, x0
               	b	<addr>
               	lsr	x5, x6, x2
               	mov	x17, #0x1               // =1
               	and	x5, x5, x17
               	cbz	x5, <addr>
               	lsl	x5, x4, x2
               	eor	x3, x3, x5
               	cbz	x2, <addr>
               	mov	x5, #0x40               // =64
               	sub	x5, x5, x0
               	sxtw	x5, w5
               	lsr	x5, x4, x5
               	eor	x1, x1, x5
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x28
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x0, [sp, #0x20]
               	fmov	d16, x4
               	str	d16, [sp, #0x28]
               	fmov	d16, x6
               	str	d16, [sp, #0x30]
               	ldr	d1, [sp, #0x28]
               	ldr	d2, [sp, #0x30]
               	pmull	v0.1q, v1.1d, v2.1d
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x0, x29, #0x28
               	ldr	x2, [x0]
               	ldr	x4, [x0, #0x8]
               	cmp	x2, x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x4, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	mov	x1, #0x11               // =17
               	sub	x2, x29, #0x28
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x2, [sp, #0x20]
               	fmov	d16, x0
               	str	d16, [sp, #0x28]
               	fmov	d16, x1
               	str	d16, [sp, #0x30]
               	ldr	d1, [sp, #0x28]
               	ldr	d2, [sp, #0x30]
               	pmull	v0.1q, v1.1d, v2.1d
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x0, x29, #0x28
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	cmp	x1, #0x123
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
