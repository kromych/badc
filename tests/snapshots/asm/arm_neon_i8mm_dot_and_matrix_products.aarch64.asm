
arm_neon_i8mm_dot_and_matrix_products.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	mov	x8, #0x0                // =0
               	mov	x1, #0x1b3              // =435
               	movk	x1, #0x100, lsl #32
               	adrp	x3, <page>
               	adrp	x0, <page>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	strb	w4, [x6, x2]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.ge	<addr>
               	ldr	x4, [x3, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x3, #0x10]
               	sub	x6, x29, #0x30
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #0x80               // =128
               	b	<addr>
               	mov	x7, #0xff               // =255
               	ubfx	x4, x4, #8, #8
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	sub	x6, x29, #0x30
               	ldur	q0, [x29, #-0x30]
               	mov	x2, #0x0                // =0
               	b	<addr>
               	strb	w4, [x6, x2]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.ge	<addr>
               	ldr	x4, [x3, #0x10]
               	eor	x4, x4, x4, lsl #13
               	eor	x4, x4, x4, lsr #7
               	eor	x4, x4, x4, lsl #17
               	str	x4, [x3, #0x10]
               	and	x5, x4, #0x7
               	cbnz	w5, <addr>
               	mov	x4, #0x80               // =128
               	b	<addr>
               	mov	x7, #0xff               // =255
               	ubfx	x4, x4, #8, #8
               	cmp	w5, #0x1
               	csel	x4, x7, x4, eq
               	b	<addr>
               	ldur	q1, [x29, #-0x30]
               	ldr	x2, [x3, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	fmov	s2, w2
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	mov	v3.16b, v2.16b
               	mov	v3.s[1], w2
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	mov	v2.16b, v3.16b
               	mov	v2.s[2], w2
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x3, #0x10]
               	mov	v2.s[3], w2
               	mov	v4.16b, v2.16b
               	usdot	v4.4s, v0.16b, v1.16b
               	sub	x4, x29, #0x90
               	stur	q4, [x29, #-0x90]
               	mov	d4, v3.d[0]
               	mov	d5, v0.d[1]
               	mov	d6, v1.d[0]
               	usdot	v4.2s, v5.8b, v6.8b
               	stur	d4, [x29, #-0x18]
               	mov	v4.16b, v2.16b
               	usdot	v4.4s, v0.16b, v1.4b[2]
               	stur	q4, [x29, #-0x80]
               	mov	d4, v0.d[0]
               	mov	d5, v1.d[1]
               	usdot	v3.2s, v4.8b, v5.4b[1]
               	stur	d3, [x29, #-0x10]
               	mov	v3.16b, v2.16b
               	sudot	v3.4s, v0.16b, v1.4b[3]
               	stur	q3, [x29, #-0x70]
               	mov	d3, v2.d[1]
               	mov	d4, v0.d[0]
               	mov	d5, v1.d[0]
               	sudot	v3.2s, v4.8b, v5.4b[0]
               	stur	d3, [x29, #-0x8]
               	mov	v3.16b, v2.16b
               	smmla	v3.4s, v0.16b, v1.16b
               	stur	q3, [x29, #-0x60]
               	mov	v3.16b, v2.16b
               	ummla	v3.4s, v0.16b, v1.16b
               	stur	q3, [x29, #-0x50]
               	mov	v16.16b, v2.16b
               	usmmla	v16.4s, v0.16b, v1.16b
               	mov	v0.16b, v16.16b
               	stur	q0, [x29, #-0x40]
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x18
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x80
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x10
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x70
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x8
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x8
               	b.lo	<addr>
               	sub	x4, x29, #0x60
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x50
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lo	<addr>
               	sub	x4, x29, #0x40
               	mov	x2, #0x0                // =0
               	ldr	x5, [x0, #0x18]
               	ldrb	w6, [x4, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x1
               	str	x5, [x0, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, #0x10
               	b.lo	<addr>
               	add	x8, x8, #0x1
               	cmp	w8, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x5861            // =22625
               	movk	x17, #0x72db, lsl #16
               	movk	x17, #0x126f, lsl #32
               	movk	x17, #0xd4b0, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
