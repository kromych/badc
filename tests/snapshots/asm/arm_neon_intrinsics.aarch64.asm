
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

<vld1q_u8>:
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

<vld1q_u64>:
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

<vst1q_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<vst1q_u64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x30
               	str	q0, [x16]
               	sub	x1, x29, #0x30
               	str	x0, [sp, #0x10]
               	str	x1, [sp, #0x18]
               	ldr	x0, [sp, #0x10]
               	ldr	x16, [sp, #0x18]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<veorq_u8>:
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

<veorq_u64>:
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

<vandq_u8>:
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
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x60
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<vdupq_n_u8>:
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

<vmulq_p8>:
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

<vqtbl1q_u8>:
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x290
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5                // =5
               	mov	x5, #0x1f               // =31
               	mov	x6, #0xc3               // =195
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x140
               	sxtw	x1, w0
               	add	x7, x3, x1
               	mul	x3, x1, x5
               	add	x3, x3, #0x7
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x130
               	add	x7, x3, x1
               	mul	x3, x1, x4
               	eor	x3, x3, x6
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x120
               	add	x7, x3, x1
               	mul	x3, x1, x1
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	strb	w3, [x7]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x21, #0x1d              // =29
               	mov	x0, x21
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x260
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x23, x29, #0x240
               	sub	x22, x29, #0x250
               	sub	x20, x29, #0x140
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x22, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x23]
               	ldr	x10, [x22, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x23, x29, #0x230
               	sub	x22, x29, #0x130
               	mov	x0, x22
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x23, x29, #0x250
               	sub	x1, x29, #0x230
               	ldr	q0, [x23]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x1, x29, #0x210
               	sub	x2, x29, #0x240
               	sub	x0, x29, #0x200
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	sub	x2, x29, #0x1f0
               	str	x2, [sp, #0x110]
               	str	x0, [sp, #0x118]
               	ldr	x16, [sp, #0x118]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x110]
               	str	q0, [x16]
               	sub	x0, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x220
               	sub	x2, x29, #0x240
               	sub	x0, x29, #0x1e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	sub	x2, x29, #0x1d0
               	str	x2, [sp, #0x110]
               	str	x0, [sp, #0x118]
               	ldr	x16, [sp, #0x118]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x110]
               	str	q0, [x16]
               	sub	x0, x29, #0x1d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x23, x29, #0x210
               	sub	x1, x29, #0x260
               	ldr	q0, [x23]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x23, x29, #0x220
               	sub	x1, x29, #0x210
               	ldr	q0, [x23]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x23, x29, #0x240
               	sub	x0, x29, #0x220
               	sub	x1, x29, #0x230
               	ldr	q0, [x0]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	sub	x23, x29, #0x110
               	sub	x1, x29, #0x250
               	ldr	q0, [x1]
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x23, x1
               	ldrb	w3, [x3]
               	add	x4, x20, x1
               	ldrb	w4, [x4]
               	add	x5, x22, x1
               	ldrb	w5, [x5]
               	eor	x4, x4, x5
               	and	x4, x4, x2
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x22, x29, #0x110
               	sub	x1, x29, #0x240
               	ldr	q0, [x1]
               	mov	x0, x22
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x2, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x22, x1
               	ldrb	w6, [x4]
               	add	x4, x20, x1
               	ldrb	w4, [x4]
               	and	x4, x4, x2
               	lsl	x7, x4, #1
               	sxtw	x7, w7
               	and	x4, x4, x5
               	cbz	x4, <addr>
               	mov	x4, x21
               	eor	x4, x7, x4
               	and	x7, x4, x2
               	sub	x4, x29, #0x130
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	eor	x4, x7, x4
               	and	x4, x4, x2
               	cmp	w6, w4
               	b.eq	<addr>
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x60
               	add	x0, x20, #0x0
               	mov	x1, #0x2                // =2
               	strb	w1, [x0]
               	mov	x0, #0xb                // =11
               	strb	w0, [x20, #0x1]
               	mov	x0, #0x14               // =20
               	strb	w0, [x20, #0x2]
               	mov	x0, #0x1d               // =29
               	strb	w0, [x20, #0x3]
               	mov	x0, #0x26               // =38
               	strb	w0, [x20, #0x4]
               	mov	x0, #0x2f               // =47
               	strb	w0, [x20, #0x5]
               	mov	x0, #0x38               // =56
               	strb	w0, [x20, #0x6]
               	mov	x0, #0x41               // =65
               	strb	w0, [x20, #0x7]
               	mov	x0, #0x4a               // =74
               	strb	w0, [x20, #0x8]
               	mov	x0, #0x53               // =83
               	strb	w0, [x20, #0x9]
               	mov	x0, #0x5c               // =92
               	strb	w0, [x20, #0xa]
               	mov	x0, #0x65               // =101
               	strb	w0, [x20, #0xb]
               	mov	x0, #0x6e               // =110
               	strb	w0, [x20, #0xc]
               	mov	x0, #0x77               // =119
               	strb	w0, [x20, #0xd]
               	mov	x0, #0x80               // =128
               	strb	w0, [x20, #0xe]
               	mov	x0, #0x89               // =137
               	strb	w0, [x20, #0xf]
               	sub	x21, x29, #0x1c0
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	sub	x22, x29, #0x1b0
               	sub	x23, x29, #0x1c0
               	sub	x21, x29, #0x120
               	mov	x0, x21
               	bl	<addr>
               	sub	x16, x29, #0x170
               	str	q0, [x16]
               	sub	x24, x29, #0x170
               	mov	x0, #0xf                // =15
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x1, x29, #0x150
               	ldr	q0, [x24]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x160
               	str	q0, [x16]
               	sub	x1, x29, #0x160
               	ldr	q0, [x23]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x22, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x22
               	sub	x22, x29, #0x110
               	sub	x1, x29, #0x1b0
               	ldr	q0, [x1]
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0xf                // =15
               	b	<addr>
               	sxtw	x1, w0
               	add	x3, x22, x1
               	ldrb	w3, [x3]
               	add	x4, x21, x1
               	ldrb	w4, [x4]
               	and	x4, x4, x2
               	add	x4, x20, x4
               	ldrb	w4, [x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x140
               	bl	<addr>
               	sub	x16, x29, #0x170
               	str	q0, [x16]
               	sub	x21, x29, #0x170
               	sub	x20, x29, #0x130
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x160
               	str	q0, [x16]
               	sub	x1, x29, #0x160
               	ldr	q0, [x21]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x110
               	ldr	q0, [x1]
               	bl	<addr>
               	mov	x5, #0x0                // =0
               	mov	x2, #0xff               // =255
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x140
               	sxtw	x6, w5
               	add	x1, x1, x6
               	ldrb	w7, [x1]
               	mov	x1, x0
               	b	<addr>
               	add	x3, x20, x6
               	ldrb	w8, [x3]
               	mov	x4, #0x1                // =1
               	sxtw	x3, w0
               	lsl	x4, x4, x3
               	sxtw	x4, w4
               	and	x4, x8, x4
               	cbz	x4, <addr>
               	and	x4, x1, x2
               	and	x1, x7, x2
               	lsl	x1, x1, x3
               	sxtw	x1, w1
               	and	x1, x1, x2
               	eor	x1, x4, x1
               	b	<addr>
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x110
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	and	x1, x1, x2
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x5, x6, #0x1
               	cmp	w5, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x140
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x170
               	str	q0, [x16]
               	sub	x22, x29, #0x170
               	sub	x21, x29, #0x130
               	mov	x0, x21
               	bl	<addr>
               	sub	x16, x29, #0x160
               	str	q0, [x16]
               	sub	x1, x29, #0x160
               	ldr	q0, [x22]
               	ldr	q1, [x1]
               	bl	<addr>
               	sub	x16, x29, #0x150
               	str	q0, [x16]
               	sub	x0, x29, #0x150
               	sub	x1, x29, #0x190
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x22, x29, #0x110
               	ldr	q0, [x1]
               	mov	x0, x22
               	bl	<addr>
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
               	mov	x0, #0x2a               // =42
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
