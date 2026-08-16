
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
               	sub	sp, sp, #0x3b0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x328
               	add	x3, x2, x0
               	mov	x17, #0x1f              // =31
               	mul	x2, x0, x17
               	add	x2, x2, #0x7
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x3]
               	sub	x2, x29, #0x338
               	add	x3, x2, x0
               	mov	x17, #0x5               // =5
               	mul	x2, x0, x17
               	mov	x17, #0xc3              // =195
               	eor	x2, x2, x17
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x3]
               	sub	x2, x29, #0x348
               	add	x3, x2, x0
               	mul	x2, x0, x0
               	add	x2, x2, #0x1
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x3]
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x148
               	mov	x1, #0x1d               // =29
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
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0x28
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
               	sub	x0, x29, #0x28
               	sub	x1, x29, #0x1a8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x1d8
               	sub	x2, x29, #0x1c8
               	sub	x0, x29, #0x328
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0x38
               	ldrb	w4, [x1]
               	ldrb	w5, [x1, #0x1]
               	ldrb	w6, [x1, #0x2]
               	ldrb	w7, [x1, #0x3]
               	ldrb	w8, [x1, #0x4]
               	ldrb	w9, [x1, #0x5]
               	ldrb	w10, [x1, #0x6]
               	ldrb	w11, [x1, #0x7]
               	ldrb	w12, [x1, #0x8]
               	ldrb	w13, [x1, #0x9]
               	ldrb	w14, [x1, #0xa]
               	ldrb	w15, [x1, #0xb]
               	ldrb	w20, [x1, #0xc]
               	ldrb	w21, [x1, #0xd]
               	ldrb	w22, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w4, [x0]
               	strb	w5, [x0, #0x1]
               	strb	w6, [x0, #0x2]
               	strb	w7, [x0, #0x3]
               	strb	w8, [x0, #0x4]
               	strb	w9, [x0, #0x5]
               	strb	w10, [x0, #0x6]
               	strb	w11, [x0, #0x7]
               	strb	w12, [x0, #0x8]
               	strb	w13, [x0, #0x9]
               	strb	w14, [x0, #0xa]
               	strb	w15, [x0, #0xb]
               	strb	w20, [x0, #0xc]
               	strb	w21, [x0, #0xd]
               	strb	w22, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0x38
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x1e8
               	sub	x0, x29, #0x338
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0x48
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
               	sub	x0, x29, #0x48
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x2, x29, #0x1c8
               	sub	x0, x29, #0x1c8
               	sub	x1, x29, #0x1e8
               	sub	x3, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	str	x1, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0x58
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
               	sub	x0, x29, #0x58
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x208
               	sub	x1, x29, #0x1d8
               	sub	x2, x29, #0x248
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x258
               	sub	x2, x29, #0x248
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x1, x29, #0x258
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x1f8
               	sub	x1, x29, #0x1d8
               	sub	x2, x29, #0x268
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x278
               	sub	x2, x29, #0x268
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x1, x29, #0x278
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x208
               	sub	x0, x29, #0x208
               	sub	x1, x29, #0x1a8
               	sub	x3, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	str	x1, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0x68
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
               	sub	x0, x29, #0x68
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x2, x29, #0x1f8
               	sub	x0, x29, #0x1f8
               	sub	x1, x29, #0x208
               	sub	x3, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	str	x1, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0x78
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
               	sub	x0, x29, #0x78
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x2, x29, #0x1d8
               	sub	x0, x29, #0x1f8
               	sub	x1, x29, #0x1e8
               	sub	x3, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	str	x1, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x358
               	sub	x1, x29, #0x1c8
               	sub	x2, x29, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x358
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x328
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	sub	x4, x29, #0x338
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x358
               	sub	x1, x29, #0x1d8
               	sub	x2, x29, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x358
               	add	x2, x2, x1
               	ldrb	w4, [x2]
               	sub	x2, x29, #0x328
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x3, x2, #1
               	sxtw	x3, w3
               	mov	x17, #0x80              // =128
               	and	x2, x2, x17
               	cbz	x2, <addr>
               	mov	x2, #0x1d               // =29
               	eor	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x3, x2, x17
               	sub	x2, x29, #0x338
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	eor	x2, x3, x2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	cmp	x4, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x2b8
               	add	x0, x0, #0x0
               	mov	x1, #0x2                // =2
               	strb	w1, [x0]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0xb                // =11
               	strb	w1, [x0, #0x1]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x14               // =20
               	strb	w1, [x0, #0x2]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x1d               // =29
               	strb	w1, [x0, #0x3]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x26               // =38
               	strb	w1, [x0, #0x4]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x2f               // =47
               	strb	w1, [x0, #0x5]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x38               // =56
               	strb	w1, [x0, #0x6]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x41               // =65
               	strb	w1, [x0, #0x7]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x4a               // =74
               	strb	w1, [x0, #0x8]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x53               // =83
               	strb	w1, [x0, #0x9]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x5c               // =92
               	strb	w1, [x0, #0xa]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x65               // =101
               	strb	w1, [x0, #0xb]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x6e               // =110
               	strb	w1, [x0, #0xc]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x77               // =119
               	strb	w1, [x0, #0xd]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x80               // =128
               	strb	w1, [x0, #0xe]
               	sub	x0, x29, #0x2b8
               	mov	x1, #0x89               // =137
               	strb	w1, [x0, #0xf]
               	sub	x2, x29, #0x2c8
               	sub	x0, x29, #0x2b8
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
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
               	sub	x2, x29, #0x2d8
               	sub	x3, x29, #0x2c8
               	sub	x0, x29, #0x348
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0xa8
               	ldrb	w4, [x1]
               	ldrb	w5, [x1, #0x1]
               	ldrb	w6, [x1, #0x2]
               	ldrb	w7, [x1, #0x3]
               	ldrb	w8, [x1, #0x4]
               	ldrb	w9, [x1, #0x5]
               	ldrb	w10, [x1, #0x6]
               	ldrb	w11, [x1, #0x7]
               	ldrb	w12, [x1, #0x8]
               	ldrb	w13, [x1, #0x9]
               	ldrb	w14, [x1, #0xa]
               	ldrb	w15, [x1, #0xb]
               	ldrb	w20, [x1, #0xc]
               	ldrb	w21, [x1, #0xd]
               	ldrb	w22, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w4, [x0]
               	strb	w5, [x0, #0x1]
               	strb	w6, [x0, #0x2]
               	strb	w7, [x0, #0x3]
               	strb	w8, [x0, #0x4]
               	strb	w9, [x0, #0x5]
               	strb	w10, [x0, #0x6]
               	strb	w11, [x0, #0x7]
               	strb	w12, [x0, #0x8]
               	strb	w13, [x0, #0x9]
               	strb	w14, [x0, #0xa]
               	strb	w15, [x0, #0xb]
               	strb	w20, [x0, #0xc]
               	strb	w21, [x0, #0xd]
               	strb	w22, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x4, x29, #0xa8
               	sub	x0, x29, #0x148
               	mov	x1, #0xf                // =15
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
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0xb8
               	ldrb	w5, [x1]
               	ldrb	w6, [x1, #0x1]
               	ldrb	w7, [x1, #0x2]
               	ldrb	w8, [x1, #0x3]
               	ldrb	w9, [x1, #0x4]
               	ldrb	w10, [x1, #0x5]
               	ldrb	w11, [x1, #0x6]
               	ldrb	w12, [x1, #0x7]
               	ldrb	w13, [x1, #0x8]
               	ldrb	w14, [x1, #0x9]
               	ldrb	w15, [x1, #0xa]
               	ldrb	w20, [x1, #0xb]
               	ldrb	w21, [x1, #0xc]
               	ldrb	w22, [x1, #0xd]
               	ldrb	w23, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w5, [x0]
               	strb	w6, [x0, #0x1]
               	strb	w7, [x0, #0x2]
               	strb	w8, [x0, #0x3]
               	strb	w9, [x0, #0x4]
               	strb	w10, [x0, #0x5]
               	strb	w11, [x0, #0x6]
               	strb	w12, [x0, #0x7]
               	strb	w13, [x0, #0x8]
               	strb	w14, [x0, #0x9]
               	strb	w15, [x0, #0xa]
               	strb	w20, [x0, #0xb]
               	strb	w21, [x0, #0xc]
               	strb	w22, [x0, #0xd]
               	strb	w23, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xb8
               	sub	x1, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x1, [sp, #0x20]
               	str	x4, [sp, #0x28]
               	str	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0xc8
               	ldrb	w4, [x1]
               	ldrb	w5, [x1, #0x1]
               	ldrb	w6, [x1, #0x2]
               	ldrb	w7, [x1, #0x3]
               	ldrb	w8, [x1, #0x4]
               	ldrb	w9, [x1, #0x5]
               	ldrb	w10, [x1, #0x6]
               	ldrb	w11, [x1, #0x7]
               	ldrb	w12, [x1, #0x8]
               	ldrb	w13, [x1, #0x9]
               	ldrb	w14, [x1, #0xa]
               	ldrb	w15, [x1, #0xb]
               	ldrb	w20, [x1, #0xc]
               	ldrb	w21, [x1, #0xd]
               	ldrb	w22, [x1, #0xe]
               	ldrb	w1, [x1, #0xf]
               	strb	w4, [x0]
               	strb	w5, [x0, #0x1]
               	strb	w6, [x0, #0x2]
               	strb	w7, [x0, #0x3]
               	strb	w8, [x0, #0x4]
               	strb	w9, [x0, #0x5]
               	strb	w10, [x0, #0x6]
               	strb	w11, [x0, #0x7]
               	strb	w12, [x0, #0x8]
               	strb	w13, [x0, #0x9]
               	strb	w14, [x0, #0xa]
               	strb	w15, [x0, #0xb]
               	strb	w20, [x0, #0xc]
               	strb	w21, [x0, #0xd]
               	strb	w22, [x0, #0xe]
               	strb	w1, [x0, #0xf]
               	sub	x0, x29, #0xc8
               	sub	x1, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x1, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	str	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0xd8
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
               	sub	x0, x29, #0xd8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x0, x29, #0x358
               	sub	x1, x29, #0x2d8
               	sub	x2, x29, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x358
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x2b8
               	sub	x4, x29, #0x348
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	mov	x17, #0xf               // =15
               	and	x4, x4, x17
               	add	x3, x3, x4
               	ldrb	w3, [x3]
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x328
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0xe8
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
               	sub	x2, x29, #0xe8
               	sub	x0, x29, #0x338
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0xf8
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
               	sub	x0, x29, #0xf8
               	sub	x1, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	pmul	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0x108
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
               	sub	x0, x29, #0x108
               	sub	x1, x29, #0x308
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x358
               	sub	x1, x29, #0x308
               	sub	x2, x29, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x4, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x328
               	add	x1, x1, x5
               	ldrb	w6, [x1]
               	mov	x1, x0
               	b	<addr>
               	sub	x3, x29, #0x338
               	add	x3, x3, x5
               	ldrb	w7, [x3]
               	mov	x3, #0x1                // =1
               	lsl	x3, x3, x2
               	sxtw	x3, w3
               	and	x3, x7, x3
               	cbz	x3, <addr>
               	mov	x17, #0xff              // =255
               	and	x3, x1, x17
               	mov	x17, #0xff              // =255
               	and	x1, x6, x17
               	lsl	x1, x1, x2
               	sxtw	x1, w1
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	eor	x1, x3, x1
               	b	<addr>
               	b	<addr>
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x8
               	b.lt	<addr>
               	sub	x0, x29, #0x358
               	add	x0, x0, x5
               	ldrb	w0, [x0]
               	mov	x17, #0xff              // =255
               	and	x1, x1, x17
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x4, x5, #0x1
               	sxtw	x5, w4
               	cmp	x5, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x328
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0x118
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x2, x29, #0x118
               	sub	x0, x29, #0x338
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x148
               	sub	x0, x29, #0x128
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x128
               	sub	x1, x29, #0x168
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	str	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x30]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x168
               	sub	x0, x29, #0x138
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x188
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x358
               	sub	x1, x29, #0x188
               	sub	x2, x29, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x2
               	sub	x1, x29, #0x148
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x1, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x2, x29, #0x358
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	sub	x3, x29, #0x328
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	sub	x4, x29, #0x338
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	eor	x3, x3, x4
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x2, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
