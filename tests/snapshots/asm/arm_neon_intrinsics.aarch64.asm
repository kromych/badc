
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
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5                // =5
               	mov	x5, #0x1f               // =31
               	mov	x6, #0xc3               // =195
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x50
               	sxtw	x1, w0
               	add	x7, x3, x1
               	mul	x3, x1, x5
               	add	x3, x3, #0x7
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x40
               	add	x7, x3, x1
               	mul	x3, x1, x4
               	eor	x3, x3, x6
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x30
               	add	x7, x3, x1
               	mul	x3, x1, x1
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	strb	w3, [x7]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x16, #0x1d              // =29
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	mov	v5.16b, v0.16b
               	sub	x3, x29, #0x50
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	sub	x4, x29, #0x40
               	sub	x16, x29, #0x40
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v4.16b, v0.16b
               	str	q3, [sp]
               	str	q4, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	mov	v6.16b, v0.16b
               	str	q3, [sp]
               	ldr	q1, [sp]
               	sshr	v0.16b, v1.16b, #0x7
               	mov	v2.16b, v0.16b
               	str	q3, [sp]
               	ldr	q1, [sp]
               	shl	v0.16b, v1.16b, #0x1
               	mov	v3.16b, v0.16b
               	str	q2, [sp]
               	str	q5, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	and	v0.16b, v1.16b, v2.16b
               	str	q3, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	str	q0, [sp]
               	str	q4, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	mov	v1.16b, v0.16b
               	sub	x5, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	add	x16, sp, #0x8
               	str	q6, [x16]
               	ldr	x0, [sp]
               	add	x16, sp, #0x8
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x5, x1
               	ldrb	w6, [x2]
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x4, x1
               	ldrb	w7, [x7]
               	eor	x2, x2, x7
               	cmp	w6, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x4, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	add	x16, sp, #0x8
               	str	q1, [x16]
               	ldr	x0, [sp]
               	add	x16, sp, #0x8
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x3, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x6, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x4, x1
               	ldrb	w7, [x2]
               	sub	x2, x29, #0x50
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	lsl	x8, x2, #1
               	sxtw	x8, w8
               	and	x2, x2, x5
               	cbz	x2, <addr>
               	mov	x2, #0x1d               // =29
               	eor	x2, x8, x2
               	and	x8, x2, x6
               	sub	x2, x29, #0x40
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	eor	x2, x8, x2
               	cmp	w7, w2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x10
               	add	x0, x1, #0x0
               	mov	x2, #0x2                // =2
               	strb	w2, [x0]
               	mov	x0, #0xb                // =11
               	strb	w0, [x1, #0x1]
               	mov	x0, #0x14               // =20
               	strb	w0, [x1, #0x2]
               	mov	x0, #0x1d               // =29
               	strb	w0, [x1, #0x3]
               	mov	x0, #0x26               // =38
               	strb	w0, [x1, #0x4]
               	mov	x0, #0x2f               // =47
               	strb	w0, [x1, #0x5]
               	mov	x0, #0x38               // =56
               	strb	w0, [x1, #0x6]
               	mov	x0, #0x41               // =65
               	strb	w0, [x1, #0x7]
               	mov	x0, #0x4a               // =74
               	strb	w0, [x1, #0x8]
               	mov	x0, #0x53               // =83
               	strb	w0, [x1, #0x9]
               	mov	x0, #0x5c               // =92
               	strb	w0, [x1, #0xa]
               	mov	x0, #0x65               // =101
               	strb	w0, [x1, #0xb]
               	mov	x0, #0x6e               // =110
               	strb	w0, [x1, #0xc]
               	mov	x0, #0x77               // =119
               	strb	w0, [x1, #0xd]
               	mov	x0, #0x80               // =128
               	strb	w0, [x1, #0xe]
               	mov	x0, #0x89               // =137
               	strb	w0, [x1, #0xf]
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	sub	x3, x29, #0x30
               	sub	x16, x29, #0x30
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v1.16b, v0.16b
               	mov	x16, #0xf               // =15
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	str	q1, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	and	v0.16b, v1.16b, v2.16b
               	str	q3, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	sub	x4, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	add	x16, sp, #0x8
               	str	q0, [x16]
               	ldr	x0, [sp]
               	add	x16, sp, #0x8
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xf                // =15
               	b	<addr>
               	sxtw	x2, w0
               	add	x6, x4, x2
               	ldrb	w6, [x6]
               	add	x7, x3, x2
               	ldrb	w7, [x7]
               	and	x7, x7, x5
               	add	x7, x1, x7
               	ldrb	w7, [x7]
               	cmp	w6, w7
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v1.16b, v0.16b
               	sub	x7, x29, #0x40
               	sub	x16, x29, #0x40
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	str	q1, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	pmul	v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	add	x16, sp, #0x8
               	str	q0, [x16]
               	ldr	x0, [sp]
               	add	x16, sp, #0x8
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x5, #0x0                // =0
               	mov	x8, #0xff               // =255
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x50
               	sxtw	x6, w5
               	add	x1, x1, x6
               	ldrb	w3, [x1]
               	mov	x1, x0
               	b	<addr>
               	add	x2, x7, x6
               	ldrb	w9, [x2]
               	mov	x4, #0x1                // =1
               	sxtw	x2, w0
               	lsl	x4, x4, x2
               	sxtw	x4, w4
               	and	x4, x9, x4
               	cbz	x4, <addr>
               	lsl	x4, x3, x2
               	sxtw	x4, w4
               	and	x4, x4, x8
               	eor	x1, x1, x4
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x5, x6, #0x1
               	cmp	w5, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x50
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v1.16b, v0.16b
               	sub	x4, x29, #0x40
               	sub	x16, x29, #0x40
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	str	q1, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	sub	x5, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	add	x16, sp, #0x8
               	str	q0, [x16]
               	ldr	x0, [sp]
               	add	x16, sp, #0x8
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x5, x1
               	ldrb	w6, [x2]
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	add	x7, x4, x1
               	ldrb	w7, [x7]
               	eor	x2, x2, x7
               	cmp	w6, w2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
