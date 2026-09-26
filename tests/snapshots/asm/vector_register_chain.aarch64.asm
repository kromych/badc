
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
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x21, x2
               	mov	x24, x4
               	mov	x23, x3
               	mov	x16, #0x1d              // =29
               	dup	v16.16b, w16
               	str	q16, [sp, #0x30]
               	mov	x20, #0x0               // =0
               	mov	x22, x20
               	ldr	x0, [x21, #0x18]
               	add	x0, x0, x20
               	ldr	q16, [x0]
               	str	q16, [sp, #0x50]
               	mov	x0, #0x2                // =2
               	ldr	q16, [sp, #0x50]
               	str	q16, [sp, #0x40]
               	ldr	x1, [x21, x0, lsl #3]
               	add	x1, x1, x20
               	ldr	q0, [x1]
               	ldr	q16, [sp, #0x40]
               	eor	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x40]
               	ldr	q16, [sp, #0x50]
               	sshr	v1.16b, v16.16b, #0x7
               	ldr	q16, [sp, #0x50]
               	shl	v2.16b, v16.16b, #0x1
               	ldr	q16, [sp, #0x30]
               	and	v1.16b, v1.16b, v16.16b
               	eor	v1.16b, v2.16b, v1.16b
               	eor	v16.16b, v1.16b, v0.16b
               	str	q16, [sp, #0x50]
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	ldr	x0, [x21, #0x18]
               	add	x0, x0, x20
               	bl	<addr>
               	add	x0, x22, x0
               	add	x1, x23, x20
               	ldr	q16, [sp, #0x40]
               	str	q16, [x1]
               	add	x1, x24, x20
               	ldr	q16, [sp, #0x50]
               	str	q16, [x1]
               	ldr	q16, [sp, #0x50]
               	mov	x1, v16.d[0]
               	and	x1, x1, #0xff
               	add	x22, x0, x1
               	add	x20, x20, #0x10
               	cmp	w20, #0x30
               	b.lt	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x100]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	mov	x1, #0x0                // =0
               	mov	x3, #0xb                // =11
               	mov	x4, #0x25               // =37
               	mov	x7, #0x30               // =48
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	sub	x0, x29, #0x80
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
               	sub	x5, x29, #0x60
               	strb	w4, [x5, x0]
               	sub	x4, x29, #0x30
               	strb	w3, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	bl	<addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1]
               	add	x20, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x10
               	bl	<addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1, #0x10]
               	add	x0, x0, x1
               	add	x21, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x20
               	bl	<addr>
               	sub	x20, x29, #0x30
               	ldrb	w1, [x20, #0x20]
               	add	x0, x0, x1
               	add	x23, x21, x0
               	mov	x0, #0x4                // =4
               	mov	x1, #0x30               // =48
               	sub	x2, x29, #0x80
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x3, x21
               	mov	x4, x22
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	ldrb	w2, [x21, x1]
               	sub	x3, x29, #0x60
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
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x3, #0x7                // =7
               	mov	x4, #0x5556             // =21846
               	movk	x4, #0x5555, lsl #16
               	sub	x1, x29, #0xa0
               	mul	x5, x0, x3
               	add	x5, x5, #0x1
               	and	x5, x5, #0xff
               	strb	w5, [x1, x0]
               	sub	x5, x29, #0x90
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
               	sub	x1, x29, #0x40
               	add	x5, x0, #0xa0
               	strb	w5, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x3, x29, #0x10
               	sub	x16, x29, #0x40
               	ldr	q0, [x16]
               	sub	x4, x29, #0xa0
               	sub	x16, x29, #0xa0
               	ldr	q1, [x16]
               	sub	x2, x29, #0x90
               	sub	x16, x29, #0x90
               	ldr	q2, [x16]
               	str	q0, [sp, #0x20]
               	str	q1, [sp, #0x30]
               	str	q2, [sp, #0x40]
               	ldr	q0, [sp, #0x20]
               	ldr	q1, [sp, #0x30]
               	ldr	q2, [sp, #0x40]
               	tbx	v0.16b, { v1.16b }, v2.16b
               	sub	x16, x29, #0x10
               	str	q0, [x16]
               	mov	x0, #0x0                // =0
               	ldrb	w5, [x3, x0]
               	ldrb	w1, [x2, x0]
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w1, [x2, x0]
               	ldrb	w1, [x4, x1]
               	cmp	w5, w1
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x40
               	ldrb	w1, [x1, x0]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x100
               	ret
