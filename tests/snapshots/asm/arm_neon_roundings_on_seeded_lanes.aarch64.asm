
arm_neon_roundings_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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

<r64>:
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x2, x0, #0x7
               	cbnz	w2, <addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	lsr	x0, x0, #8
               	mov	x2, #0xc31              // =3121
               	movk	x2, #0x30c3, lsl #16
               	movk	x2, #0xc30c, lsl #32
               	movk	x2, #0xc30, lsl #48
               	umulh	x2, x0, x2
               	mov	x17, #0x15              // =21
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	ldr	x0, [x1, x0, lsl #3]
               	ret
               	cmp	w2, #0x1
               	b.ne	<addr>
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x0, x0, #0x800fffffffffffff
               	ret
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	add	x0, x1, x0, lsr #11
               	ret
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x360
               	stp	d8, d9, [sp]
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x3e8
               	b.ge	<addr>
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x0, #0x10]
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	lsr	x1, x1, #8
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaa, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x18              // =24
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	ldr	w1, [x2, x1, lsl #2]
               	ldr	q0, [sp, #0x240]
               	mov	v0.s[0], w1
               	ldr	x1, [x0, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x0, #0x10]
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	lsr	x1, x1, #8
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaa, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x18              // =24
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	ldr	w1, [x2, x1, lsl #2]
               	mov	v0.s[1], w1
               	ldr	x1, [x0, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x0, #0x10]
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	lsr	x1, x1, #8
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaa, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x18              // =24
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	ldr	w1, [x2, x1, lsl #2]
               	mov	v0.s[2], w1
               	ldr	x1, [x0, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x0, #0x10]
               	and	x0, x1, #0x7
               	cbnz	w0, <addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	lsr	x0, x1, #8
               	mov	x1, #0xaaab             // =43691
               	movk	x1, #0xaaaa, lsl #16
               	movk	x1, #0xaaaa, lsl #32
               	movk	x1, #0xaaa, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x18              // =24
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	w0, [x2, x0, lsl #2]
               	mov	v16.16b, v0.16b
               	mov	v16.s[3], w0
               	str	q16, [sp, #0x240]
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x2, x0, #0x7
               	cbnz	w2, <addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	lsr	x0, x0, #8
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaa, lsl #48
               	umulh	x3, x0, x3
               	mov	x17, #0x18              // =24
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	ldr	w0, [x2, x0, lsl #2]
               	and	x2, x21, #0xffffffff00000000
               	orr	x2, x2, x0
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x1, x0, #0x7
               	cbnz	w1, <addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	lsr	x0, x0, #8
               	mov	x3, #0xaaab             // =43691
               	movk	x3, #0xaaaa, lsl #16
               	movk	x3, #0xaaaa, lsl #32
               	movk	x3, #0xaaa, lsl #48
               	umulh	x3, x0, x3
               	mov	x17, #0x18              // =24
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	ldr	w0, [x1, x0, lsl #2]
               	mov	w1, w2
               	orr	x21, x1, x0, lsl #32
               	fmov	d8, x21
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x230]
               	bl	<addr>
               	ldr	q0, [sp, #0x230]
               	mov	v0.d[1], x0
               	str	q0, [sp, #0x220]
               	bl	<addr>
               	ldr	q0, [sp, #0x220]
               	stur	x0, [x29, #-0x8]
               	fmov	d9, x0
               	tbz	w20, #0x0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	ldr	q16, [sp, #0x240]
               	fmul	v1.4s, v16.4s, v1.4s
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q2, [x0]
               	fmul	v0.2d, v0.2d, v2.2d
               	mov	x0, #0x1f               // =31
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	frintz	v2.4s, v1.4s
               	sub	x2, x29, #0x330
               	str	q2, [sp, #0x30]
               	frintz	v2.2s, v8.2s
               	str	d2, [sp, #0x258]
               	frintz	v2.2d, v0.2d
               	str	q2, [sp, #0x40]
               	frintz	d2, d9
               	stur	d2, [x29, #-0x100]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x108
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x320
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x100
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frintn	v2.4s, v1.4s
               	sub	x2, x29, #0x310
               	str	q2, [sp, #0x50]
               	frintn	v2.2s, v8.2s
               	stur	d2, [x29, #-0xf8]
               	frintn	v2.2d, v0.2d
               	str	q2, [sp, #0x60]
               	frintn	d2, d9
               	stur	d2, [x29, #-0xf0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xf8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x300
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xf0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frintm	v2.4s, v1.4s
               	sub	x2, x29, #0x2f0
               	str	q2, [sp, #0x70]
               	frintm	v2.2s, v8.2s
               	stur	d2, [x29, #-0xe8]
               	frintm	v2.2d, v0.2d
               	str	q2, [sp, #0x80]
               	frintm	d2, d9
               	stur	d2, [x29, #-0xe0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xe8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2e0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xe0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frintp	v2.4s, v1.4s
               	sub	x2, x29, #0x2d0
               	str	q2, [sp, #0x90]
               	frintp	v2.2s, v8.2s
               	stur	d2, [x29, #-0xd8]
               	frintp	v2.2d, v0.2d
               	str	q2, [sp, #0xa0]
               	frintp	d2, d9
               	stur	d2, [x29, #-0xd0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xd8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2c0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xd0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frinta	v2.4s, v1.4s
               	sub	x2, x29, #0x2b0
               	str	q2, [sp, #0xb0]
               	frinta	v2.2s, v8.2s
               	stur	d2, [x29, #-0xc8]
               	frinta	v2.2d, v0.2d
               	str	q2, [sp, #0xc0]
               	frinta	d2, d9
               	stur	d2, [x29, #-0xc0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xc8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2a0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xc0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frinti	v2.4s, v1.4s
               	sub	x2, x29, #0x290
               	str	q2, [sp, #0xd0]
               	frinti	v2.2s, v8.2s
               	stur	d2, [x29, #-0xb8]
               	frinti	v2.2d, v0.2d
               	str	q2, [sp, #0xe0]
               	frinti	d2, d9
               	stur	d2, [x29, #-0xb0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xb8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x280
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xb0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frintx	v2.4s, v1.4s
               	sub	x2, x29, #0x270
               	str	q2, [sp, #0xf0]
               	frintx	v2.2s, v8.2s
               	stur	d2, [x29, #-0xa8]
               	frintx	v2.2d, v0.2d
               	str	q2, [sp, #0x100]
               	frintx	d2, d9
               	stur	d2, [x29, #-0xa0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xa8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x260
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0xa0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frint32x	v2.4s, v1.4s
               	sub	x2, x29, #0x250
               	str	q2, [sp, #0x110]
               	frint32x	v2.2s, v8.2s
               	stur	d2, [x29, #-0x98]
               	frint32x	v2.2d, v0.2d
               	str	q2, [sp, #0x120]
               	frint32x	d2, d9
               	stur	d2, [x29, #-0x90]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x98
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x240
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x90
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frint32z	v2.4s, v1.4s
               	sub	x2, x29, #0x230
               	str	q2, [sp, #0x130]
               	frint32z	v2.2s, v8.2s
               	stur	d2, [x29, #-0x88]
               	frint32z	v2.2d, v0.2d
               	str	q2, [sp, #0x140]
               	frint32z	d2, d9
               	stur	d2, [x29, #-0x80]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x88
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x220
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x80
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frint64x	v2.4s, v1.4s
               	sub	x2, x29, #0x210
               	str	q2, [sp, #0x150]
               	frint64x	v2.2s, v8.2s
               	stur	d2, [x29, #-0x78]
               	frint64x	v2.2d, v0.2d
               	str	q2, [sp, #0x160]
               	frint64x	d2, d9
               	stur	d2, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x78
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x200
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x70
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frint64z	v2.4s, v1.4s
               	sub	x2, x29, #0x1f0
               	str	q2, [sp, #0x170]
               	frint64z	v2.2s, v8.2s
               	stur	d2, [x29, #-0x68]
               	frint64z	v2.2d, v0.2d
               	str	q2, [sp, #0x180]
               	frint64z	d2, d9
               	stur	d2, [x29, #-0x60]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x68
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1e0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x60
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	mov	s2, v1.s[0]
               	mov	x0, #0x0                // =0
               	fmov	s2, s2
               	frintn	v2.2s, v2.2s
               	stur	s2, [x29, #-0x58]
               	sub	x2, x29, #0x58
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x22, eq
               	mov	x0, #0x2                // =2
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x22, x22, x0, lsl #1
               	mov	x0, #0x4                // =4
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x22, x22, x0, lsl #2
               	mov	x0, #0x8                // =8
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x22, x22, x0, lsl #3
               	mov	x0, #0x10               // =16
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x0, x22, x0, lsl #4
               	stur	w0, [x29, #-0x50]
               	sub	x2, x29, #0x50
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	and	x0, x20, #0x3
               	cmp	w0, #0x2
               	b.ne	<addr>
               	and	x0, x20, #0x7
               	mov	x1, #0x400000           // =4194304
               	mov	x2, #0xc00000           // =12582912
               	cmp	w0, #0x2
               	csel	x0, x1, x2, eq
               	str	q0, [sp, #0x220]
               	str	q1, [sp, #0x210]
               	bl	<addr>
               	ldr	q0, [sp, #0x220]
               	ldr	q1, [sp, #0x210]
               	frinti	v2.4s, v1.4s
               	sub	x2, x29, #0x1d0
               	str	q2, [sp, #0x190]
               	frinti	v2.2s, v8.2s
               	stur	d2, [x29, #-0x48]
               	frinti	v2.2d, v0.2d
               	str	q2, [sp, #0x1a0]
               	frinti	d2, d9
               	stur	d2, [x29, #-0x40]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x48
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1c0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x40
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frintx	v2.4s, v1.4s
               	sub	x2, x29, #0x1b0
               	str	q2, [sp, #0x1b0]
               	frintx	v2.2s, v8.2s
               	stur	d2, [x29, #-0x38]
               	frintx	v2.2d, v0.2d
               	str	q2, [sp, #0x1c0]
               	frintx	d2, d9
               	stur	d2, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x38
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1a0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x30
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frint32x	v2.4s, v1.4s
               	sub	x2, x29, #0x190
               	str	q2, [sp, #0x1d0]
               	frint32x	v2.2s, v8.2s
               	stur	d2, [x29, #-0x28]
               	frint32x	v2.2d, v0.2d
               	str	q2, [sp, #0x1e0]
               	frint32x	d2, d9
               	stur	d2, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x28
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x180
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x20
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	frint64x	v1.4s, v1.4s
               	sub	x2, x29, #0x170
               	str	q1, [sp, #0x1f0]
               	frint64x	v1.2s, v8.2s
               	stur	d1, [x29, #-0x18]
               	frint64x	v0.2d, v0.2d
               	str	q0, [sp, #0x200]
               	frint64x	d0, d9
               	stur	d0, [x29, #-0x10]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x160
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lo	<addr>
               	sub	x2, x29, #0x10
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	b	<addr>
               	ldr	q1, [sp, #0x240]
               	b	<addr>
               	cmp	w1, #0x1
               	b.ne	<addr>
               	lsr	x0, x0, #32
               	and	w0, w0, #0x80ffffff
               	b	<addr>
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ubfx	x0, x0, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x0, x0, x17
               	b	<addr>
               	lsr	x0, x0, #16
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	lsr	x0, x0, #32
               	and	w0, w0, #0x80ffffff
               	b	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ubfx	x0, x0, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x0, x0, x17
               	b	<addr>
               	lsr	x0, x0, #16
               	b	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	lsr	x0, x1, #32
               	and	w0, w0, #0x80ffffff
               	b	<addr>
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ubfx	x0, x1, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x0, x0, x17
               	b	<addr>
               	lsr	x0, x1, #16
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	lsr	x1, x1, #32
               	and	w1, w1, #0x80ffffff
               	b	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ubfx	x1, x1, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x1, x1, x17
               	b	<addr>
               	lsr	x1, x1, #16
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	lsr	x1, x1, #32
               	and	w1, w1, #0x80ffffff
               	b	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ubfx	x1, x1, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x1, x1, x17
               	b	<addr>
               	lsr	x1, x1, #16
               	b	<addr>
               	cmp	w2, #0x1
               	b.ne	<addr>
               	lsr	x1, x1, #32
               	and	w1, w1, #0x80ffffff
               	b	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ubfx	x1, x1, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x1, x1, x17
               	b	<addr>
               	lsr	x1, x1, #16
               	b	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x8f04            // =36612
               	movk	x17, #0x8a03, lsl #16
               	movk	x17, #0xa214, lsl #32
               	movk	x17, #0x110c, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp]
               	add	sp, sp, #0x360
               	ldp	x29, x30, [sp], #0x10
               	ret
