
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
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x20, x2
               	mov	x24, x4
               	mov	x23, x3
               	mov	x16, #0x1d              // =29
               	str	x16, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	dup	v0.16b, w0
               	str	q0, [sp, #0x50]
               	mov	x21, #0x0               // =0
               	mov	x3, x21
               	b	<addr>
               	ldr	x0, [x20, #0x18]
               	sxtw	x1, w21
               	add	x0, x0, x1
               	str	x0, [sp, #0x30]
               	ldr	x0, [sp, #0x30]
               	ldr	q0, [x0]
               	str	q0, [sp, #0x70]
               	mov	x1, #0x2                // =2
               	ldr	q16, [sp, #0x70]
               	str	q16, [sp, #0x60]
               	b	<addr>
               	sxtw	x0, w1
               	ldr	x0, [x20, x0, lsl #3]
               	sxtw	x2, w21
               	add	x0, x0, x2
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
               	sxtw	x0, w1
               	sub	x1, x0, #0x1
               	cmp	w1, #0x0
               	b.ge	<addr>
               	mov	w25, w3
               	ldr	x0, [x20, #0x18]
               	sxtw	x22, w21
               	add	x0, x0, x22
               	bl	<addr>
               	add	x1, x25, x0
               	add	x0, x23, x22
               	str	x0, [sp, #0x30]
               	ldr	q16, [sp, #0x60]
               	add	x16, sp, #0x38
               	str	q16, [x16]
               	ldr	x0, [sp, #0x30]
               	add	x16, sp, #0x38
               	ldr	q0, [x16]
               	str	q0, [x0]
               	sxtw	x0, w21
               	add	x0, x24, x0
               	str	x0, [sp, #0x30]
               	ldr	q16, [sp, #0x70]
               	add	x16, sp, #0x38
               	str	q16, [x16]
               	ldr	x0, [sp, #0x30]
               	add	x16, sp, #0x38
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	w1, w1
               	sub	x16, x29, #0x8
               	str	x16, [sp, #0x30]
               	ldr	q16, [sp, #0x70]
               	add	x16, sp, #0x38
               	str	q16, [x16]
               	add	x16, sp, #0x38
               	ldr	q0, [x16]
               	mov	x0, v0.d[0]
               	ldr	x16, [sp, #0x30]
               	str	x0, [x16]
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0xff
               	add	x3, x1, x0
               	add	x21, x21, #0x10
               	cmp	w21, #0x30
               	b.lt	<addr>
               	mov	w0, w3
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x120]!
               	stp	x29, x30, [sp, #0x110]
               	add	x29, sp, #0x110
               	mov	x5, #0x0                // =0
               	mov	x8, #0xb                // =11
               	mov	x9, #0x25               // =37
               	mov	x11, #0x30              // =48
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	sub	x0, x29, #0x60
               	sxtw	x1, w5
               	mul	x7, x1, x11
               	add	x2, x6, x7
               	str	x2, [x0, x1, lsl #3]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x6, x7
               	sxtw	x2, w0
               	add	x10, x3, x2
               	add	x3, x1, #0x3
               	mul	x3, x2, x3
               	mul	x3, x3, x9
               	mul	x4, x1, x8
               	add	x3, x3, x4
               	add	x3, x3, #0x5
               	and	x3, x3, #0xff
               	strb	w3, [x10]
               	add	x0, x2, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	add	x5, x1, #0x1
               	cmp	w5, #0x4
               	b.lt	<addr>
               	mov	x4, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x4
               	b	<addr>
               	add	x3, x2, #0x90
               	sxtw	x1, w0
               	add	x3, x3, x1
               	ldrb	w3, [x3]
               	add	x6, x2, #0x60
               	add	x7, x6, x1
               	ldrb	w5, [x7]
               	eor	x5, x3, x5
               	lsl	x8, x3, #1
               	and	x3, x3, #0x80
               	cbz	x3, <addr>
               	mov	x3, #0x1d               // =29
               	eor	x3, x8, x3
               	and	x8, x3, #0xff
               	ldrb	w3, [x7]
               	eor	x3, x8, x3
               	add	x6, x2, #0x30
               	add	x7, x6, x1
               	ldrb	w9, [x7]
               	eor	x5, x5, x9
               	lsl	x8, x3, #1
               	and	x3, x3, #0x80
               	cbz	x3, <addr>
               	mov	x3, #0x1d               // =29
               	eor	x3, x8, x3
               	and	x8, x3, #0xff
               	ldrb	w3, [x7]
               	eor	x3, x8, x3
               	add	x6, x2, #0x0
               	add	x7, x6, x1
               	ldrb	w9, [x7]
               	eor	x5, x5, x9
               	lsl	x8, x3, #1
               	and	x3, x3, #0x80
               	cbz	x3, <addr>
               	mov	x3, #0x1d               // =29
               	eor	x3, x8, x3
               	and	x8, x3, #0xff
               	ldrb	w3, [x7]
               	eor	x3, x8, x3
               	sub	x7, x29, #0xc0
               	add	x7, x7, x1
               	strb	w5, [x7]
               	sub	x5, x29, #0x90
               	add	x5, x5, x1
               	strb	w3, [x5]
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x30
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x0
               	bl	<addr>
               	sub	x1, x29, #0x90
               	add	x1, x1, #0x0
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	mov	w0, w0
               	add	x20, x0, #0x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x90
               	add	x0, x0, #0x10
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x90
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
               	sub	x20, x29, #0x90
               	ldrb	w1, [x20, #0x20]
               	add	x0, x0, x1
               	mov	w0, w0
               	add	x21, x21, x0
               	mov	x0, #0x4                // =4
               	mov	x1, #0x30               // =48
               	sub	x2, x29, #0x60
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
               	sub	x5, x29, #0xc0
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
               	ldp	x29, x30, [sp, #0x110]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x4, #0x7                // =7
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	b	<addr>
               	sub	x2, x29, #0x40
               	sxtw	x1, w0
               	add	x6, x2, x1
               	mul	x2, x1, x4
               	add	x2, x2, #0x1
               	and	x2, x2, #0xff
               	strb	w2, [x6]
               	sub	x2, x29, #0x30
               	add	x6, x2, x1
               	mul	x2, x1, x5
               	asr	x2, x2, #32
               	lsr	x7, x2, #63
               	add	x2, x2, x7
               	mul	x2, x2, x3
               	sub	x2, x1, x2
               	cbnz	x2, <addr>
               	mov	x2, #0xc8               // =200
               	and	x2, x2, #0xff
               	strb	w2, [x6]
               	sub	x2, x29, #0x20
               	add	x6, x2, x1
               	add	x2, x1, #0xa0
               	and	x2, x2, #0xff
               	strb	w2, [x6]
               	b	<addr>
               	mov	x2, #0xf                // =15
               	sub	x2, x2, x0
               	sxtw	x2, w2
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x20, x29, #0x10
               	sub	x16, x29, #0x20
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	ldr	q0, [x0]
               	sub	x1, x29, #0xe0
               	str	q0, [x1]
               	sub	x16, x29, #0x40
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	ldr	q0, [x0]
               	sub	x2, x29, #0xd0
               	str	q0, [x2]
               	sub	x21, x29, #0x30
               	sub	x16, x29, #0x30
               	str	x16, [sp, #0x10]
               	ldr	x0, [sp, #0x10]
               	ldr	q0, [x0]
               	sub	x0, x29, #0xa0
               	str	q0, [x0]
               	ldr	q0, [x1]
               	ldr	q1, [x2]
               	ldr	q2, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x70
               	str	q0, [x16]
               	sub	x0, x29, #0x70
               	ldr	q0, [x0]
               	sub	x16, x29, #0x10
               	str	x16, [sp, #0x10]
               	add	x16, sp, #0x18
               	str	q0, [x16]
               	ldr	x0, [sp, #0x10]
               	add	x16, sp, #0x18
               	ldr	q0, [x16]
               	str	q0, [x0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x20, x1
               	ldrb	w3, [x2]
               	add	x2, x21, x1
               	ldrb	w2, [x2]
               	cmp	w2, #0x10
               	b.ge	<addr>
               	sub	x2, x29, #0x40
               	sub	x4, x29, #0x30
               	add	x4, x4, x1
               	ldrb	w4, [x4]
               	add	x2, x2, x4
               	ldrb	w2, [x2]
               	cmp	x3, x2
               	b.eq	<addr>
               	b	<addr>
               	sub	x2, x29, #0x20
               	add	x2, x2, x1
               	ldrb	w2, [x2]
               	b	<addr>
               	add	x0, x1, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x110]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x110]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x110]
               	ldp	x20, x21, [sp], #0x120
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x110]
               	ldp	x20, x21, [sp], #0x120
               	ret
