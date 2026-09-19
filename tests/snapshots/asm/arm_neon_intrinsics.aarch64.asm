
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
               	mov	x1, #0x0                // =0
               	mov	x4, #0x5                // =5
               	mov	x5, #0x1f               // =31
               	mov	x6, #0xc3               // =195
               	b	<addr>
               	sub	x3, x29, #0x50
               	sxtw	x0, w1
               	mul	x2, x0, x5
               	add	x2, x2, #0x7
               	and	x2, x2, #0xff
               	strb	w2, [x3, x0]
               	sub	x3, x29, #0x40
               	mul	x2, x0, x4
               	eor	x2, x2, x6
               	and	x2, x2, #0xff
               	strb	w2, [x3, x0]
               	sub	x3, x29, #0x30
               	mul	x2, x0, x0
               	add	x2, x2, #0x1
               	and	x2, x2, #0xff
               	strb	w2, [x3, x0]
               	add	x1, x1, #0x1
               	cmp	w1, #0x10
               	b.lt	<addr>
               	mov	x16, #0x1d              // =29
               	str	x16, [sp]
               	ldr	x0, [sp]
               	dup	v0.16b, w0
               	mov	v5.16b, v0.16b
               	sub	x2, x29, #0x50
               	sub	x16, x29, #0x50
               	str	x16, [sp]
               	ldr	x0, [sp]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	sub	x3, x29, #0x40
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
               	sub	x4, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q6, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	ldrb	w5, [x4, x1]
               	ldrb	w6, [x2, x1]
               	ldrb	w1, [x3, x1]
               	eor	x1, x6, x1
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q1, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x4, #0x0                // =0
               	mov	x0, x4
               	b	<addr>
               	sxtw	x1, w0
               	ldrb	w6, [x3, x1]
               	sub	x2, x29, #0x50
               	ldrb	w2, [x2, x1]
               	lsl	x5, x2, #1
               	and	x2, x2, #0x80
               	cbz	x2, <addr>
               	mov	x2, #0x1d               // =29
               	eor	x2, x5, x2
               	and	x5, x2, #0xff
               	sub	x2, x29, #0x40
               	ldrb	w1, [x2, x1]
               	eor	x1, x5, x1
               	cmp	w6, w1
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, x4
               	b	<addr>
               	add	x0, x0, #0x1
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
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w0
               	ldrb	w5, [x4, x2]
               	ldrb	w2, [x3, x2]
               	and	x2, x2, #0xf
               	ldrb	w2, [x1, x2]
               	cmp	w5, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
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
               	pmul	v0.16b, v1.16b, v2.16b
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x7, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x50
               	sxtw	x3, w7
               	ldrb	w5, [x1, x3]
               	mov	x1, x0
               	b	<addr>
               	ldrb	w8, [x4, x3]
               	mov	x6, #0x1                // =1
               	sxtw	x2, w0
               	lsl	x6, x6, x2
               	sxtw	x6, w6
               	and	x6, x8, x6
               	cbz	x6, <addr>
               	lsl	x2, x5, x2
               	and	x2, x2, #0xff
               	eor	x1, x1, x2
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0, x3]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x7, x7, #0x1
               	cmp	w7, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x50
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
               	eor	v0.16b, v1.16b, v2.16b
               	sub	x4, x29, #0x20
               	sub	x16, x29, #0x20
               	str	x16, [sp]
               	stur	q0, [sp, #0x8]
               	ldr	x0, [sp]
               	ldur	q0, [sp, #0x8]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	ldrb	w5, [x4, x1]
               	ldrb	w6, [x2, x1]
               	ldrb	w1, [x3, x1]
               	eor	x1, x6, x1
               	cmp	w5, w1
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
