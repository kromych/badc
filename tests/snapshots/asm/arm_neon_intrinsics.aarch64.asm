
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
               	mov	x1, #0x5                // =5
               	mov	x2, #0x1f               // =31
               	mov	x3, #0xc3               // =195
               	sub	x4, x29, #0x50
               	mul	x5, x0, x2
               	add	x5, x5, #0x7
               	and	x5, x5, #0xff
               	strb	w5, [x4, x0]
               	sub	x4, x29, #0x40
               	mul	x5, x0, x1
               	eor	x5, x5, x3
               	and	x5, x5, #0xff
               	strb	w5, [x4, x0]
               	sub	x4, x29, #0x30
               	mul	x5, x0, x0
               	add	x5, x5, #0x1
               	and	x5, x5, #0xff
               	strb	w5, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x4, #0x1d               // =29
               	mov	x16, #0x1d              // =29
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	mov	v5.16b, v0.16b
               	sub	x1, x29, #0x50
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	sub	x2, x29, #0x40
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
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q6, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
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
               	sub	x5, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldrb	w6, [x5, x0]
               	ldrb	w3, [x1, x0]
               	lsl	x7, x3, #1
               	tbz	w3, #0x7, <addr>
               	mov	x3, x4
               	eor	x3, x7, x3
               	and	x3, x3, #0xff
               	sub	x7, x29, #0x40
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
               	sub	x0, x29, #0x10
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
               	sub	x1, x29, #0x10
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	sub	x2, x29, #0x30
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
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	ldrb	w4, [x3, x0]
               	ldrb	w5, [x2, x0]
               	and	x5, x5, #0xf
               	ldrb	w5, [x1, x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v1.16b, v0.16b
               	sub	x3, x29, #0x40
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
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x2, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x50
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
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, x2]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x50
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v1.16b, v0.16b
               	sub	x2, x29, #0x40
               	sub	x16, x29, #0x40
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	str	q1, [sp]
               	str	q0, [sp, #0x10]
               	ldr	q1, [sp]
               	ldr	q2, [sp, #0x10]
               	eor	v0.16b, v1.16b, v2.16b
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
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
