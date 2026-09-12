
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
               	sub	sp, sp, #0x4a0
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5                // =5
               	mov	x5, #0x1f               // =31
               	mov	x6, #0xc3               // =195
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x250
               	sxtw	x1, w0
               	add	x7, x3, x1
               	mul	x3, x1, x5
               	add	x3, x3, #0x7
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x240
               	add	x7, x3, x1
               	mul	x3, x1, x4
               	eor	x3, x3, x6
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x230
               	add	x7, x3, x1
               	mul	x3, x1, x1
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	strb	w3, [x7]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x3c0
               	mov	x1, #0x1d               // =29
               	str	x0, [sp, #0x220]
               	str	x1, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x3c0
               	sub	x0, x29, #0x260
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x4a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x480
               	sub	x3, x29, #0x490
               	sub	x2, x29, #0x250
               	sub	x0, x29, #0x3b0
               	str	x0, [sp, #0x220]
               	str	x2, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x3b0
               	sub	x0, x29, #0x260
               	ldr	x5, [x1]
               	ldr	x6, [x1, #0x8]
               	str	x5, [x0]
               	str	x6, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x4]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x470
               	sub	x3, x29, #0x240
               	str	x1, [sp, #0x220]
               	str	x3, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x3b0
               	sub	x0, x29, #0x260
               	ldr	x5, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x5, [x0]
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x490
               	sub	x0, x29, #0x470
               	sub	x4, x29, #0x380
               	str	x4, [sp, #0x220]
               	str	x1, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x4, x29, #0x380
               	sub	x0, x29, #0x260
               	ldr	x5, [x4]
               	ldr	x4, [x4, #0x8]
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x450
               	sub	x4, x29, #0x480
               	sub	x0, x29, #0x440
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x430
               	str	x4, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x0, x29, #0x430
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x460
               	sub	x4, x29, #0x480
               	sub	x0, x29, #0x420
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x410
               	str	x4, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x0, x29, #0x410
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x450
               	sub	x0, x29, #0x4a0
               	sub	x4, x29, #0x350
               	str	x4, [sp, #0x220]
               	str	x1, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x4, x29, #0x350
               	sub	x0, x29, #0x260
               	ldr	x5, [x4]
               	ldr	x4, [x4, #0x8]
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x460
               	sub	x0, x29, #0x450
               	sub	x1, x29, #0x380
               	str	x1, [sp, #0x220]
               	str	x4, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x380
               	sub	x0, x29, #0x260
               	ldr	x5, [x1]
               	ldr	x6, [x1, #0x8]
               	str	x5, [x0]
               	str	x6, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x480
               	sub	x0, x29, #0x460
               	sub	x5, x29, #0x470
               	str	x1, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	str	x5, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x380
               	sub	x0, x29, #0x260
               	ldr	x5, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x5, [x0]
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x220
               	sub	x1, x29, #0x490
               	sub	x0, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x4, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x0, [sp, #0x220]
               	ldr	x16, [sp, #0x228]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x7, x2, x1
               	ldrb	w7, [x7]
               	add	x8, x3, x1
               	ldrb	w8, [x8]
               	eor	x7, x7, x8
               	and	x7, x7, x5
               	cmp	w6, w7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x220
               	sub	x1, x29, #0x480
               	sub	x0, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x5, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x0, [sp, #0x220]
               	ldr	x16, [sp, #0x228]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x3, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x2, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x5, x1
               	ldrb	w7, [x4]
               	sub	x4, x29, #0x250
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	and	x4, x4, x2
               	lsl	x8, x4, #1
               	sxtw	x8, w8
               	and	x4, x4, x6
               	cbz	x4, <addr>
               	mov	x4, #0x1d               // =29
               	eor	x4, x8, x4
               	and	x8, x4, x2
               	sub	x4, x29, #0x240
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	eor	x4, x8, x4
               	and	x4, x4, x2
               	cmp	w7, w4
               	b.eq	<addr>
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x1, x29, #0x170
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
               	sub	x3, x29, #0x400
               	sub	x0, x29, #0x3b0
               	str	x0, [sp, #0x220]
               	str	x1, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x2, x29, #0x3b0
               	sub	x0, x29, #0x260
               	ldr	x4, [x2]
               	ldr	x5, [x2, #0x8]
               	str	x4, [x0]
               	str	x5, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x5, x29, #0x3f0
               	sub	x6, x29, #0x400
               	sub	x3, x29, #0x230
               	str	x2, [sp, #0x220]
               	str	x3, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x0, x29, #0x3b0
               	sub	x2, x29, #0x110
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	str	x4, [x2]
               	str	x0, [x2, #0x8]
               	sub	x0, x29, #0x3c0
               	mov	x4, #0xf                // =15
               	str	x0, [sp, #0x220]
               	str	x4, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x4, x29, #0x3c0
               	sub	x0, x29, #0x100
               	ldr	x7, [x4]
               	ldr	x4, [x4, #0x8]
               	str	x7, [x0]
               	str	x4, [x0, #0x8]
               	sub	x4, x29, #0x350
               	str	x4, [sp, #0x220]
               	str	x2, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x2, x29, #0x350
               	sub	x0, x29, #0xf0
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x310
               	str	x2, [sp, #0x220]
               	str	x6, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x2, x29, #0x310
               	sub	x0, x29, #0x260
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x5]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x5, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x220
               	sub	x2, x29, #0x3f0
               	sub	x0, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x4, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x0, [sp, #0x220]
               	ldr	x16, [sp, #0x228]
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
               	sub	x0, x29, #0x250
               	sub	x1, x29, #0x3b0
               	str	x1, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x0, x29, #0x3b0
               	sub	x1, x29, #0xe0
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	str	x2, [x1]
               	str	x3, [x1, #0x8]
               	sub	x7, x29, #0x240
               	str	x0, [sp, #0x220]
               	str	x7, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x2, x29, #0x3b0
               	sub	x0, x29, #0xd0
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x3, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x2e0
               	str	x2, [sp, #0x220]
               	str	x1, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	pmul	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x2e0
               	sub	x0, x29, #0x260
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x3e0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x220
               	sub	x0, x29, #0x340
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x2, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x0, [sp, #0x220]
               	ldr	x16, [sp, #0x228]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x5, #0x0                // =0
               	mov	x2, #0xff               // =255
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x250
               	sxtw	x6, w5
               	add	x1, x1, x6
               	ldrb	w8, [x1]
               	mov	x1, x0
               	b	<addr>
               	add	x3, x7, x6
               	ldrb	w9, [x3]
               	mov	x4, #0x1                // =1
               	sxtw	x3, w0
               	lsl	x4, x4, x3
               	sxtw	x4, w4
               	and	x4, x9, x4
               	cbz	x4, <addr>
               	and	x4, x1, x2
               	and	x1, x8, x2
               	lsl	x1, x1, x3
               	sxtw	x1, w1
               	and	x1, x1, x2
               	eor	x1, x4, x1
               	b	<addr>
               	b	<addr>
               	add	x0, x3, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x220
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	and	x1, x1, x2
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x5, x6, #0x1
               	cmp	w5, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x250
               	sub	x0, x29, #0x2d0
               	str	x0, [sp, #0x220]
               	str	x2, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x0, x29, #0x2d0
               	sub	x1, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	str	x3, [x1]
               	str	x4, [x1, #0x8]
               	sub	x3, x29, #0x240
               	str	x0, [sp, #0x220]
               	str	x3, [sp, #0x228]
               	ldr	x0, [sp, #0x228]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x4, x29, #0x2d0
               	sub	x0, x29, #0xb0
               	ldr	x5, [x4]
               	ldr	x4, [x4, #0x8]
               	str	x5, [x0]
               	str	x4, [x0, #0x8]
               	sub	x4, x29, #0x2a0
               	str	x4, [sp, #0x220]
               	str	x1, [sp, #0x228]
               	str	x0, [sp, #0x230]
               	ldr	x16, [sp, #0x228]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x230]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x220]
               	str	q0, [x16]
               	sub	x1, x29, #0x2a0
               	sub	x0, x29, #0x260
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x3d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x4, x29, #0x220
               	sub	x0, x29, #0x290
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x4, [sp, #0x220]
               	str	x0, [sp, #0x228]
               	ldr	x0, [sp, #0x220]
               	ldr	x16, [sp, #0x228]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x5, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x6, x4, x1
               	ldrb	w6, [x6]
               	add	x7, x2, x1
               	ldrb	w7, [x7]
               	add	x8, x3, x1
               	ldrb	w8, [x8]
               	eor	x7, x7, x8
               	and	x7, x7, x5
               	cmp	w6, w7
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x4a0
               	ldp	x29, x30, [sp], #0x10
               	ret
