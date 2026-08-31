
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
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x4, #0x5                // =5
               	mov	x5, #0x1f               // =31
               	mov	x6, #0xc3               // =195
               	mov	x2, #0xff               // =255
               	b	<addr>
               	sub	x3, x29, #0x180
               	sxtw	x1, w0
               	add	x7, x3, x1
               	mul	x3, x1, x5
               	add	x3, x3, #0x7
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x170
               	add	x7, x3, x1
               	mul	x3, x1, x4
               	eor	x3, x3, x6
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x160
               	add	x7, x3, x1
               	mul	x3, x1, x1
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	strb	w3, [x7]
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x20
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
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x190
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
               	ldrb	w21, [x1, #0xf]
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
               	strb	w21, [x0, #0xf]
               	sub	x2, x29, #0x140
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x1b0
               	sub	x2, x29, #0x130
               	sub	x0, x29, #0x180
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
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x190
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
               	ldrb	w23, [x1, #0xf]
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
               	strb	w23, [x0, #0xf]
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
               	sub	x3, x29, #0x120
               	sub	x2, x29, #0x170
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x190
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x3, x29, #0x130
               	sub	x0, x29, #0x120
               	sub	x1, x29, #0x10
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
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x1, x29, #0x100
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0xf0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x0
               	sub	x3, x29, #0xe0
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x0, x29, #0xe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x1, x29, #0x110
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0xd0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x0
               	sub	x3, x29, #0xc0
               	str	d0, [sp, #0x30]
               	str	d1, [sp, #0x38]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x16, [sp, #0x28]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x30]
               	ldr	d1, [sp, #0x38]
               	sub	x0, x29, #0xc0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x3, x29, #0x100
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0x10
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
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
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
               	ldrb	w23, [x1, #0xf]
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
               	strb	w23, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x3, x29, #0x110
               	sub	x0, x29, #0x100
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
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
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
               	ldrb	w23, [x1, #0xf]
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
               	strb	w23, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x3, x29, #0x1b0
               	sub	x0, x29, #0x110
               	sub	x4, x29, #0x120
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x1, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	str	x4, [sp, #0x30]
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
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x3, x29, #0x150
               	sub	x1, x29, #0x130
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x3, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	mov	x4, #0xff               // =255
               	b	<addr>
               	sxtw	x1, w0
               	add	x5, x3, x1
               	ldrb	w5, [x5]
               	sub	x6, x29, #0x180
               	add	x6, x6, x1
               	ldrb	w6, [x6]
               	add	x7, x2, x1
               	ldrb	w7, [x7]
               	eor	x6, x6, x7
               	and	x6, x6, x4
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x5, x29, #0x150
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x5, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x3, #0x0                // =0
               	mov	x6, #0x80               // =128
               	mov	x2, #0xff               // =255
               	mov	x0, x3
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x5, x1
               	ldrb	w7, [x4]
               	sub	x4, x29, #0x180
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
               	sub	x4, x29, #0x170
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
               	sub	x0, x29, #0xb0
               	add	x1, x0, #0x0
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
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
               	sub	x2, x29, #0xa0
               	sub	x1, x29, #0x20
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
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x190
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
               	ldrb	w22, [x1, #0xf]
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
               	strb	w22, [x0, #0xf]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	sub	x3, x29, #0x1b0
               	sub	x4, x29, #0xa0
               	sub	x0, x29, #0x160
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
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x90
               	ldrb	w2, [x1]
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
               	ldrb	w23, [x1, #0xf]
               	strb	w2, [x0]
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
               	strb	w23, [x0, #0xf]
               	mov	x2, #0xf                // =15
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x2, x29, #0x20
               	sub	x1, x29, #0x80
               	ldrb	w5, [x2]
               	ldrb	w6, [x2, #0x1]
               	ldrb	w7, [x2, #0x2]
               	ldrb	w8, [x2, #0x3]
               	ldrb	w9, [x2, #0x4]
               	ldrb	w10, [x2, #0x5]
               	ldrb	w11, [x2, #0x6]
               	ldrb	w12, [x2, #0x7]
               	ldrb	w13, [x2, #0x8]
               	ldrb	w14, [x2, #0x9]
               	ldrb	w15, [x2, #0xa]
               	ldrb	w20, [x2, #0xb]
               	ldrb	w21, [x2, #0xc]
               	ldrb	w22, [x2, #0xd]
               	ldrb	w23, [x2, #0xe]
               	ldrb	w2, [x2, #0xf]
               	strb	w5, [x1]
               	strb	w6, [x1, #0x1]
               	strb	w7, [x1, #0x2]
               	strb	w8, [x1, #0x3]
               	strb	w9, [x1, #0x4]
               	strb	w10, [x1, #0x5]
               	strb	w11, [x1, #0x6]
               	strb	w12, [x1, #0x7]
               	strb	w13, [x1, #0x8]
               	strb	w14, [x1, #0x9]
               	strb	w15, [x1, #0xa]
               	strb	w20, [x1, #0xb]
               	strb	w21, [x1, #0xc]
               	strb	w22, [x1, #0xd]
               	strb	w23, [x1, #0xe]
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0x10
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x2, [sp, #0x20]
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
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x70
               	ldrb	w2, [x1]
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
               	ldrb	w23, [x1, #0xf]
               	strb	w2, [x0]
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
               	strb	w23, [x0, #0xf]
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
               	tbl	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	d0, [sp, #0x38]
               	ldr	d1, [sp, #0x40]
               	ldr	d2, [sp, #0x48]
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
               	ldrb	w2, [x1]
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
               	strb	w2, [x0]
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x3
               	sub	x2, x29, #0x150
               	sub	x1, x29, #0x1b0
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x2, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x0, #0x0                // =0
               	mov	x3, #0xf                // =15
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	sub	x5, x29, #0xb0
               	sub	x6, x29, #0x160
               	add	x6, x6, x1
               	ldrb	w6, [x6]
               	and	x6, x6, x3
               	add	x5, x5, x6
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x180
               	sub	x1, x29, #0x20
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
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x60
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
               	ldrb	w21, [x1, #0xf]
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
               	strb	w21, [x0, #0xf]
               	sub	x7, x29, #0x170
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x7, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x2, x29, #0x20
               	sub	x1, x29, #0x50
               	ldrb	w3, [x2]
               	ldrb	w4, [x2, #0x1]
               	ldrb	w5, [x2, #0x2]
               	ldrb	w6, [x2, #0x3]
               	ldrb	w8, [x2, #0x4]
               	ldrb	w9, [x2, #0x5]
               	ldrb	w10, [x2, #0x6]
               	ldrb	w11, [x2, #0x7]
               	ldrb	w12, [x2, #0x8]
               	ldrb	w13, [x2, #0x9]
               	ldrb	w14, [x2, #0xa]
               	ldrb	w15, [x2, #0xb]
               	ldrb	w20, [x2, #0xc]
               	ldrb	w21, [x2, #0xd]
               	ldrb	w22, [x2, #0xe]
               	ldrb	w2, [x2, #0xf]
               	strb	w3, [x1]
               	strb	w4, [x1, #0x1]
               	strb	w5, [x1, #0x2]
               	strb	w6, [x1, #0x3]
               	strb	w8, [x1, #0x4]
               	strb	w9, [x1, #0x5]
               	strb	w10, [x1, #0x6]
               	strb	w11, [x1, #0x7]
               	strb	w12, [x1, #0x8]
               	strb	w13, [x1, #0x9]
               	strb	w14, [x1, #0xa]
               	strb	w15, [x1, #0xb]
               	strb	w20, [x1, #0xc]
               	strb	w21, [x1, #0xd]
               	strb	w22, [x1, #0xe]
               	strb	w2, [x1, #0xf]
               	sub	x2, x29, #0x10
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x2, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	str	x1, [sp, #0x30]
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
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x190
               	ldrb	w2, [x1]
               	ldrb	w3, [x1, #0x1]
               	ldrb	w4, [x1, #0x2]
               	ldrb	w5, [x1, #0x3]
               	ldrb	w6, [x1, #0x4]
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
               	strb	w2, [x0]
               	strb	w3, [x0, #0x1]
               	strb	w4, [x0, #0x2]
               	strb	w5, [x0, #0x3]
               	strb	w6, [x0, #0x4]
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
               	sub	x1, x29, #0x1b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x150
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x2, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	mov	x5, #0x0                // =0
               	mov	x2, #0xff               // =255
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x180
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
               	sub	x0, x29, #0x150
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	and	x1, x1, x2
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x5, x6, #0x1
               	cmp	w5, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x180
               	sub	x0, x29, #0x20
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x0, [sp, #0x20]
               	str	x2, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x1, x29, #0x20
               	sub	x0, x29, #0x40
               	ldr	x3, [x1]
               	ldr	x4, [x1, #0x8]
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	sub	x3, x29, #0x170
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x1, [sp, #0x20]
               	str	x3, [sp, #0x28]
               	ldr	x0, [sp, #0x28]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x20]
               	str	q0, [x16]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
               	sub	x4, x29, #0x20
               	sub	x1, x29, #0x30
               	ldr	x5, [x4]
               	ldr	x4, [x4, #0x8]
               	str	x5, [x1]
               	str	x4, [x1, #0x8]
               	sub	x4, x29, #0x10
               	str	d0, [sp, #0x38]
               	str	d1, [sp, #0x40]
               	str	d2, [sp, #0x48]
               	str	x4, [sp, #0x20]
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
               	sub	x1, x29, #0x10
               	sub	x0, x29, #0x1b0
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x8]
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	sub	x1, x29, #0x190
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x4, x29, #0x150
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	str	x0, [sp, #0x30]
               	str	d0, [sp, #0x38]
               	str	x4, [sp, #0x20]
               	str	x0, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldr	x16, [sp, #0x28]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	ldr	x0, [sp, #0x30]
               	ldr	d0, [sp, #0x38]
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
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
