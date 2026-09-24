
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
               	stur	q0, [x29, #-0x80]
               	stur	q1, [x29, #-0x70]
               	stur	q2, [x29, #-0x60]
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
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x3]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x5]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x6]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x7]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0x9]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0xa]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0xb]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0xc]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0xd]
               	add	x1, x1, x2
               	ldrb	w2, [x0, #0xe]
               	add	x1, x1, x2
               	ldrb	w0, [x0, #0xf]
               	add	x0, x1, x0
               	ret

<syndrome>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x21, x2
               	mov	x24, x4
               	mov	x23, x3
               	mov	x16, #0x1d              // =29
               	str	x16, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	dup	v0.16b, w0
               	str	q0, [sp, #0x50]
               	mov	x20, #0x0               // =0
               	mov	x22, x20
               	ldr	x0, [x21, #0x18]
               	add	x0, x0, x20
               	str	x0, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	ldr	q0, [x0]
               	str	q0, [sp, #0x70]
               	mov	x1, #0x2                // =2
               	ldr	q16, [sp, #0x70]
               	str	q16, [sp, #0x60]
               	ldr	x0, [x21, x1, lsl #3]
               	add	x0, x0, x20
               	str	x0, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	ldr	q0, [x0]
               	mov	v3.16b, v0.16b
               	ldr	q16, [sp, #0x60]
               	str	q16, [sp, #0x30]
               	str	q3, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	q2, [sp, #0x40]
               	eor	v0.16b, v1.16b, v2.16b
               	str	q0, [sp, #0x60]
               	ldr	q16, [sp, #0x70]
               	str	q16, [sp, #0x30]
               	ldr	q1, [sp, #0x30]
               	sshr	v0.16b, v1.16b, #0x7
               	mov	v2.16b, v0.16b
               	ldr	q16, [sp, #0x70]
               	str	q16, [sp, #0x30]
               	ldr	q1, [sp, #0x30]
               	shl	v0.16b, v1.16b, #0x1
               	mov	v4.16b, v0.16b
               	str	q2, [sp, #0x30]
               	ldr	q16, [sp, #0x50]
               	str	q16, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	q2, [sp, #0x40]
               	and	v0.16b, v1.16b, v2.16b
               	str	q4, [sp, #0x30]
               	str	q0, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	q2, [sp, #0x40]
               	eor	v0.16b, v1.16b, v2.16b
               	str	q0, [sp, #0x30]
               	str	q3, [sp, #0x40]
               	ldr	q1, [sp, #0x30]
               	ldr	q2, [sp, #0x40]
               	eor	v0.16b, v1.16b, v2.16b
               	str	q0, [sp, #0x70]
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	ldr	x0, [x21, #0x18]
               	add	x0, x0, x20
               	bl	<addr>
               	add	x1, x22, x0
               	add	x0, x23, x20
               	str	x0, [sp, #0x30]
               	ldr	q16, [sp, #0x60]
               	stur	q16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldur	q0, [sp, #0x38]
               	str	q0, [x0]
               	add	x0, x24, x20
               	str	x0, [sp, #0x30]
               	ldr	q16, [sp, #0x70]
               	stur	q16, [sp, #0x38]
               	ldr	x0, [sp, #0x30]
               	ldur	q0, [sp, #0x38]
               	str	q0, [x0]
               	ldr	q16, [sp, #0x70]
               	str	q16, [sp, #0x30]
               	ldr	q0, [sp, #0x30]
               	mov	x0, v0.d[0]
               	and	x0, x0, #0xff
               	add	x22, x1, x0
               	add	x20, x20, #0x10
               	cmp	w20, #0x30
               	b.lt	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x130]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x120]
               	add	x29, sp, #0x120
               	mov	x1, #0x0                // =0
               	mov	x3, #0xb                // =11
               	mov	x4, #0x25               // =37
               	mov	x7, #0x30               // =48
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	sub	x0, x29, #0x20
               	mul	x2, x1, x7
               	add	x2, x8, x2
               	str	x2, [x0, x1, lsl #3]
               	mov	x0, #0x0                // =0
               	add	x5, x1, #0x3
               	mul	x5, x0, x5
               	mul	x5, x5, x4
               	mul	x6, x1, x3
               	add	x5, x5, x6
               	add	x5, x5, #0x5
               	and	x5, x5, #0xff
               	strb	w5, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x2, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x2
               	add	x3, x1, #0x90
               	ldrb	w3, [x3, x0]
               	add	x4, x1, #0x60
               	ldrb	w5, [x4, x0]
               	eor	x5, x3, x5
               	lsl	x6, x3, #1
               	tbz	w3, #0x7, <addr>
               	mov	x3, #0x1d               // =29
               	eor	x3, x6, x3
               	and	x3, x3, #0xff
               	ldrb	w4, [x4, x0]
               	eor	x3, x3, x4
               	add	x4, x1, #0x30
               	ldrb	w6, [x4, x0]
               	eor	x5, x5, x6
               	lsl	x6, x3, #1
               	tbz	w3, #0x7, <addr>
               	mov	x3, #0x1d               // =29
               	eor	x3, x6, x3
               	and	x3, x3, #0xff
               	ldrb	w4, [x4, x0]
               	eor	x3, x3, x4
               	ldrb	w4, [x1, x0]
               	eor	x4, x5, x4
               	lsl	x5, x3, #1
               	tbz	w3, #0x7, <addr>
               	mov	x3, #0x1d               // =29
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	eor	x3, x5, x3
               	and	x3, x3, #0xff
               	ldrb	w5, [x1, x0]
               	eor	x3, x3, x5
               	sub	x5, x29, #0x80
               	strb	w4, [x5, x0]
               	sub	x4, x29, #0x50
               	strb	w3, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	bl	<addr>
               	sub	x1, x29, #0x50
               	ldrb	w1, [x1]
               	add	x20, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x10
               	bl	<addr>
               	sub	x1, x29, #0x50
               	ldrb	w1, [x1, #0x10]
               	add	x0, x0, x1
               	add	x21, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x20
               	bl	<addr>
               	sub	x20, x29, #0x50
               	ldrb	w1, [x20, #0x20]
               	add	x0, x0, x1
               	add	x23, x21, x0
               	mov	x0, #0x4                // =4
               	mov	x1, #0x30               // =48
               	sub	x2, x29, #0x20
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x3, x21
               	mov	x4, x22
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	ldrb	w2, [x21, x1]
               	sub	x3, x29, #0x80
               	ldrb	w3, [x3, x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrb	w2, [x22, x1]
               	ldrb	w3, [x20, x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x30
               	b.lt	<addr>
               	cmp	w0, w23
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x3, #0x7                // =7
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	sub	x1, x29, #0xe0
               	mul	x5, x0, x3
               	add	x5, x5, #0x1
               	and	x5, x5, #0xff
               	strb	w5, [x1, x0]
               	sub	x5, x29, #0xd0
               	mul	x1, x0, x4
               	lsr	x1, x1, #32
               	mul	x1, x1, x2
               	sub	x1, x0, x1
               	cbnz	w1, <addr>
               	mov	x1, #0xc8               // =200
               	b	<addr>
               	mov	x1, #0xf                // =15
               	sub	x1, x1, x0
               	strb	w1, [x5, x0]
               	sub	x1, x29, #0xc0
               	add	x5, x0, #0xa0
               	strb	w5, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0xb0
               	sub	x16, x29, #0xc0
               	str	x16, [sp, #0x20]
               	ldr	x0, [sp, #0x20]
               	ldr	q0, [x0]
               	sub	x7, x29, #0xa0
               	str	q0, [x7]
               	sub	x16, x29, #0xe0
               	str	x16, [sp, #0x20]
               	ldr	x0, [sp, #0x20]
               	ldr	q0, [x0]
               	sub	x1, x29, #0x90
               	str	q0, [x1]
               	sub	x21, x29, #0xd0
               	sub	x16, x29, #0xd0
               	str	x16, [sp, #0x20]
               	ldr	x0, [sp, #0x20]
               	ldr	q0, [x0]
               	sub	x0, x29, #0x60
               	str	q0, [x0]
               	ldr	q0, [x7]
               	ldr	q1, [x1]
               	ldr	q2, [x0]
               	bl	<addr>
               	stur	q0, [x29, #-0x30]
               	ldur	q0, [x29, #-0x30]
               	sub	x16, x29, #0xb0
               	str	x16, [sp, #0x20]
               	stur	q0, [sp, #0x28]
               	ldr	x0, [sp, #0x20]
               	ldur	q0, [sp, #0x28]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x20, x0]
               	ldrb	w1, [x21, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	sub	x1, x29, #0xe0
               	sub	x3, x29, #0xd0
               	ldrb	w3, [x3, x0]
               	ldrb	w1, [x1, x3]
               	cmp	w2, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0xc0
               	ldrb	w1, [x1, x0]
               	cmp	w2, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
