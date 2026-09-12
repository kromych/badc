
vector_register_chain.aarch64:	file format elf64-littleaarch64

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

<vqtbx1q_u8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x16, x29, #0x80
               	str	q0, [x16]
               	sub	x16, x29, #0x70
               	str	q1, [x16]
               	sub	x16, x29, #0x60
               	str	q2, [x16]
               	sub	x16, x29, #0x80
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x70
               	str	x16, [sp, #0x38]
               	sub	x16, x29, #0x60
               	str	x16, [sp, #0x40]
               	ldr	x16, [sp, #0x30]
               	ldr	q0, [x16]
               	ldr	x16, [sp, #0x38]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x40]
               	ldr	q2, [x16]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x80
               	mov	x16, x0
               	ldr	q0, [x16]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<block_sum>:
               	add	x1, x0, #0x0
               	ldrb	w1, [x1]
               	add	x1, x1, #0x0
               	mov	w1, w1
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x3]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x4]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x5]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x6]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x7]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x8]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0x9]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0xa]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0xb]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0xc]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0xd]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w2, [x0, #0xe]
               	add	x1, x1, x2
               	mov	w1, w1
               	ldrb	w0, [x0, #0xf]
               	add	x0, x1, x0
               	mov	w0, w0
               	ret

<syndrome>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x420
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	mov	x20, x2
               	mov	x24, x4
               	mov	x23, x3
               	sub	x16, x29, #0x250
               	str	x16, [sp, #0x1f0]
               	mov	x16, #0x1d              // =29
               	str	x16, [sp, #0x1f8]
               	ldr	x0, [sp, #0x1f8]
               	dup	v0.16b, w0
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x250
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	sub	x0, x29, #0x178
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0x3f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x21, #0x0               // =0
               	mov	x5, x21
               	b	<addr>
               	sub	x2, x29, #0x3d0
               	sub	x1, x29, #0x3e0
               	ldr	x0, [x20, #0x18]
               	sxtw	x3, w21
               	add	x0, x0, x3
               	sub	x16, x29, #0x240
               	str	x16, [sp, #0x1f0]
               	str	x0, [sp, #0x1f8]
               	ldr	x0, [sp, #0x1f8]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x240
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x208
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x2                // =2
               	b	<addr>
               	sub	x2, x29, #0x3c0
               	sxtw	x0, w1
               	ldr	x0, [x20, x0, lsl #3]
               	sxtw	x3, w21
               	add	x0, x0, x3
               	sub	x16, x29, #0x240
               	str	x16, [sp, #0x1f0]
               	str	x0, [sp, #0x1f8]
               	ldr	x0, [sp, #0x1f8]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x240
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x1f8
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x3e0
               	sub	x0, x29, #0x3c0
               	sub	x3, x29, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x380
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x390
               	str	x16, [sp, #0x1f8]
               	sub	x16, x29, #0x380
               	str	x16, [sp, #0x200]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x200]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x2a0
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x1e8
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x3a0
               	sub	x0, x29, #0x3d0
               	sub	x2, x29, #0x360
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x350
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x360
               	str	x16, [sp, #0x1f8]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q1, [x16]
               	sshr	v0.16b, v1.16b, #0x7
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x2, x29, #0x350
               	sub	x0, x29, #0x1d8
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x3b0
               	sub	x0, x29, #0x3d0
               	sub	x2, x29, #0x330
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x320
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x330
               	str	x16, [sp, #0x1f8]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q1, [x16]
               	shl	v0.16b, v1.16b, #0x1
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x2, x29, #0x320
               	sub	x0, x29, #0x1c8
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	str	x4, [x0]
               	str	x2, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x3a0
               	sub	x0, x29, #0x3f0
               	sub	x3, x29, #0x310
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x300
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x270
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x310
               	str	x16, [sp, #0x1f8]
               	sub	x16, x29, #0x300
               	str	x16, [sp, #0x200]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x200]
               	ldr	q2, [x16]
               	and	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x270
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x1b8
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x3b0
               	sub	x0, x29, #0x3a0
               	sub	x3, x29, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x3]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x380
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x390
               	str	x16, [sp, #0x1f8]
               	sub	x16, x29, #0x380
               	str	x16, [sp, #0x200]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x200]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x2a0
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x1a8
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x3d0
               	sub	x0, x29, #0x3b0
               	sub	x3, x29, #0x3c0
               	sub	x4, x29, #0x390
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x4]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x380
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x390
               	str	x16, [sp, #0x1f8]
               	sub	x16, x29, #0x380
               	str	x16, [sp, #0x200]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q1, [x16]
               	ldr	x16, [sp, #0x200]
               	ldr	q2, [x16]
               	eor	v0.16b, v1.16b, v2.16b
               	ldr	x16, [sp, #0x1f0]
               	str	q0, [x16]
               	sub	x0, x29, #0x2a0
               	ldr	x3, [x0]
               	ldr	x4, [x0, #0x8]
               	sub	x0, x29, #0x198
               	str	x3, [x0]
               	str	x4, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sxtw	x0, w1
               	sub	x1, x0, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	w25, w5
               	ldr	x0, [x20, #0x18]
               	sxtw	x22, w21
               	add	x0, x0, x22
               	bl	<addr>
               	add	x1, x25, x0
               	add	x2, x23, x22
               	sub	x3, x29, #0x3e0
               	sub	x0, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x260
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x2, [sp, #0x1f0]
               	sub	x16, x29, #0x260
               	str	x16, [sp, #0x1f8]
               	ldr	x0, [sp, #0x1f0]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	sxtw	x0, w21
               	add	x2, x24, x0
               	sub	x3, x29, #0x3d0
               	sub	x0, x29, #0x2f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x260
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x3]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x2, [sp, #0x1f0]
               	sub	x16, x29, #0x260
               	str	x16, [sp, #0x1f8]
               	ldr	x0, [sp, #0x1f0]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	w1, w1
               	sub	x0, x29, #0x3d0
               	sub	x2, x29, #0x2d0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x58
               	str	x16, [sp, #0x1f0]
               	sub	x16, x29, #0x2d0
               	str	x16, [sp, #0x1f8]
               	ldr	x16, [sp, #0x1f8]
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x1f0]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x58]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	add	x5, x1, x0
               	add	x21, x21, #0x10
               	cmp	w21, #0x30
               	b.lt	<addr>
               	mov	w0, w5
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x420
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x160]!
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	mov	x5, #0x0                // =0
               	mov	x8, #0xb                // =11
               	mov	x9, #0x25               // =37
               	mov	x12, #0x30              // =48
               	mov	x10, #0xff              // =255
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	sub	x0, x29, #0x80
               	sxtw	x1, w5
               	mul	x7, x1, x12
               	add	x2, x6, x7
               	str	x2, [x0, x1, lsl #3]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x6, x7
               	sxtw	x2, w0
               	add	x11, x3, x2
               	add	x3, x1, #0x3
               	mul	x3, x2, x3
               	mul	x3, x3, x9
               	mul	x4, x1, x8
               	add	x3, x3, x4
               	add	x3, x3, #0x5
               	and	x3, x3, x10
               	strb	w3, [x11]
               	add	x0, x2, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	add	x5, x1, #0x1
               	cmp	w5, #0x4
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	mov	x5, #0x80               // =128
               	mov	x0, #0xff               // =255
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, x4
               	b	<addr>
               	add	x6, x3, #0x90
               	sxtw	x2, w1
               	add	x6, x6, x2
               	ldrb	w6, [x6]
               	and	x7, x6, x0
               	add	x6, x3, #0x60
               	add	x8, x6, x2
               	ldrb	w9, [x8]
               	eor	x9, x7, x9
               	and	x7, x7, x0
               	and	x7, x7, x0
               	lsl	x10, x7, #1
               	sxtw	x10, w10
               	and	x7, x7, x5
               	cbz	x7, <addr>
               	mov	x7, #0x1d               // =29
               	eor	x7, x10, x7
               	and	x7, x7, x0
               	ldrb	w6, [x8]
               	eor	x6, x7, x6
               	and	x10, x6, x0
               	and	x8, x9, x0
               	add	x6, x3, #0x30
               	add	x7, x6, x2
               	ldrb	w9, [x7]
               	eor	x8, x8, x9
               	and	x9, x10, x0
               	and	x9, x9, x0
               	lsl	x10, x9, #1
               	sxtw	x10, w10
               	and	x9, x9, x5
               	cbz	x9, <addr>
               	mov	x9, #0x1d               // =29
               	eor	x9, x10, x9
               	and	x9, x9, x0
               	ldrb	w6, [x7]
               	eor	x6, x9, x6
               	and	x9, x6, x0
               	and	x8, x8, x0
               	add	x6, x3, #0x0
               	add	x7, x6, x2
               	ldrb	w10, [x7]
               	eor	x8, x8, x10
               	and	x9, x9, x0
               	and	x9, x9, x0
               	lsl	x10, x9, #1
               	sxtw	x10, w10
               	and	x9, x9, x5
               	cbz	x9, <addr>
               	mov	x9, #0x1d               // =29
               	eor	x9, x10, x9
               	and	x9, x9, x0
               	ldrb	w6, [x7]
               	eor	x6, x9, x6
               	and	x6, x6, x0
               	sub	x7, x29, #0xe0
               	add	x7, x7, x2
               	and	x8, x8, x0
               	strb	w8, [x7]
               	sub	x7, x29, #0xb0
               	add	x7, x7, x2
               	and	x6, x6, x0
               	strb	w6, [x7]
               	b	<addr>
               	mov	x9, x4
               	b	<addr>
               	mov	x9, x4
               	b	<addr>
               	mov	x7, x4
               	b	<addr>
               	add	x1, x2, #0x1
               	cmp	w1, #0x30
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x0
               	bl	<addr>
               	sub	x1, x29, #0xb0
               	add	x1, x1, #0x0
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mov	w0, w0
               	add	x0, x0, #0x0
               	mov	w20, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x10
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0xb0
               	ldrb	w0, [x0, #0x10]
               	add	x0, x1, x0
               	mov	w0, w0
               	add	x0, x20, x0
               	mov	w21, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x20
               	bl	<addr>
               	sub	x20, x29, #0xb0
               	ldrb	w1, [x20, #0x20]
               	add	x0, x0, x1
               	mov	w0, w0
               	add	x21, x21, x0
               	mov	x0, #0x4                // =4
               	mov	x1, #0x30               // =48
               	sub	x2, x29, #0x80
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	bl	<addr>
               	mov	x6, x0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	sub	x5, x29, #0xe0
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x4, x3, x1
               	ldrb	w4, [x4]
               	add	x5, x20, x1
               	ldrb	w5, [x5]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	mov	w0, w6
               	mov	w1, w21
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x5, #0x7                // =7
               	mov	x2, #0xff               // =255
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	b	<addr>
               	sub	x3, x29, #0x60
               	sxtw	x1, w0
               	add	x7, x3, x1
               	mul	x3, x1, x5
               	add	x3, x3, #0x1
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x50
               	add	x7, x3, x1
               	mul	x3, x1, x6
               	asr	x3, x3, #32
               	lsr	x8, x3, #63
               	add	x3, x3, x8
               	mul	x3, x3, x4
               	sub	x3, x1, x3
               	cbnz	x3, <addr>
               	mov	x3, #0xc8               // =200
               	and	x3, x3, x2
               	strb	w3, [x7]
               	sub	x3, x29, #0x40
               	add	x7, x3, x1
               	add	x3, x1, #0xa0
               	and	x3, x3, x2
               	strb	w3, [x7]
               	b	<addr>
               	mov	x3, #0xf                // =15
               	sub	x3, x3, x0
               	sxtw	x3, w3
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x30
               	sub	x16, x29, #0x140
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x140
               	sub	x1, x29, #0x100
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	sub	x16, x29, #0x140
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x60
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x0, x29, #0x140
               	sub	x2, x29, #0xf0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	str	x3, [x2]
               	str	x0, [x2, #0x8]
               	sub	x16, x29, #0x140
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x50
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x38]
               	ldr	q0, [x0]
               	ldr	x16, [sp, #0x30]
               	str	q0, [x16]
               	sub	x3, x29, #0x140
               	sub	x0, x29, #0xc0
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x90
               	str	q0, [x16]
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x130
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x130
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldr	x16, [sp, #0x38]
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w4, [x2]
               	sub	x2, x29, #0x50
               	add	x3, x2, x1
               	ldrb	w5, [x3]
               	cmp	w5, #0x10
               	b.ge	<addr>
               	sub	x5, x29, #0x60
               	ldrb	w2, [x3]
               	add	x2, x5, x2
               	ldrb	w2, [x2]
               	cmp	x4, x2
               	b.eq	<addr>
               	b	<addr>
               	sub	x2, x29, #0x40
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x150]
               	ldp	x20, x21, [sp], #0x160
               	ret
