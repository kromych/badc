
arm_neon_qrshl_cvtx_recpx_and_poly_forms_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x2b0
               	str	d8, [sp]
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	mov	x22, #0x0               // =0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	strb	w1, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sub	x2, x29, #0x1e0
               	and	x3, x1, #0x3
               	cbnz	w3, <addr>
               	lsr	x1, x1, #8
               	mov	x3, #0xcccd             // =52429
               	movk	x3, #0xcccc, lsl #16
               	movk	x3, #0xcccc, lsl #32
               	movk	x3, #0xccc, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x14              // =20
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	sub	x1, x1, #0xa
               	b	<addr>
               	lsr	x1, x1, #8
               	sxtb	x1, w1
               	b	<addr>
               	sub	x3, x29, #0x1e0
               	ldr	q16, [sp, #0xd0]
               	str	q16, [sp, #0x190]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x2, x1, #0x3
               	cbnz	w2, <addr>
               	lsr	x1, x1, #8
               	mov	x2, #0xcccd             // =52429
               	movk	x2, #0xcccc, lsl #16
               	movk	x2, #0xcccc, lsl #32
               	movk	x2, #0xccc, lsl #48
               	umulh	x2, x1, x2
               	mov	x17, #0x14              // =20
               	mul	x2, x2, x17
               	sub	x1, x1, x2
               	sub	x1, x1, #0xa
               	b	<addr>
               	lsr	x1, x1, #8
               	sxtb	x1, w1
               	b	<addr>
               	ldr	q16, [sp, #0xd0]
               	str	q16, [sp, #0x180]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sub	x2, x29, #0x1d0
               	and	x3, x1, #0x3
               	cbnz	w3, <addr>
               	lsr	x1, x1, #8
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x666, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x28              // =40
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	sub	x1, x1, #0x14
               	b	<addr>
               	lsr	x1, x1, #8
               	sxth	x1, w1
               	b	<addr>
               	sub	x3, x29, #0x1d0
               	ldr	q16, [sp, #0xe0]
               	str	q16, [sp, #0x170]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	strh	w1, [x3, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x2, x1, #0x3
               	cbnz	w2, <addr>
               	lsr	x1, x1, #8
               	mov	x2, #0x6667             // =26215
               	movk	x2, #0x6666, lsl #16
               	movk	x2, #0x6666, lsl #32
               	movk	x2, #0x666, lsl #48
               	umulh	x2, x1, x2
               	mov	x17, #0x28              // =40
               	mul	x2, x2, x17
               	sub	x1, x1, x2
               	sub	x1, x1, #0x14
               	b	<addr>
               	lsr	x1, x1, #8
               	sxth	x1, w1
               	b	<addr>
               	ldr	q16, [sp, #0xe0]
               	str	q16, [sp, #0x160]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w1, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sub	x2, x29, #0x1c0
               	and	x3, x1, #0x3
               	cbnz	w3, <addr>
               	lsr	x1, x1, #8
               	mov	x3, #0x3334             // =13108
               	movk	x3, #0x3333, lsl #16
               	movk	x3, #0x3333, lsl #32
               	movk	x3, #0x333, lsl #48
               	umulh	x3, x1, x3
               	mov	x17, #0x50              // =80
               	mul	x3, x3, x17
               	sub	x1, x1, x3
               	sub	x1, x1, #0x28
               	b	<addr>
               	lsr	x1, x1, #16
               	b	<addr>
               	sub	x3, x29, #0x1c0
               	ldr	q16, [sp, #0xf0]
               	str	q16, [sp, #0x150]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w1, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x2, x1, #0x3
               	cbnz	w2, <addr>
               	lsr	x1, x1, #8
               	mov	x2, #0x3334             // =13108
               	movk	x2, #0x3333, lsl #16
               	movk	x2, #0x3333, lsl #32
               	movk	x2, #0x333, lsl #48
               	umulh	x2, x1, x2
               	mov	x17, #0x50              // =80
               	mul	x2, x2, x17
               	sub	x1, x1, x2
               	sub	x1, x1, #0x28
               	b	<addr>
               	lsr	x1, x1, #16
               	b	<addr>
               	ldr	q0, [sp, #0xf0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	x1, [x3, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sub	x3, x29, #0x1b0
               	and	x4, x1, #0x3
               	cbnz	w4, <addr>
               	lsr	x1, x1, #8
               	mov	x2, #0x999a             // =39322
               	movk	x2, #0x9999, lsl #16
               	movk	x2, #0x9999, lsl #32
               	movk	x2, #0x199, lsl #48
               	umulh	x2, x1, x2
               	mov	x17, #0xa0              // =160
               	mul	x2, x2, x17
               	sub	x1, x1, x2
               	sub	x1, x1, #0x50
               	b	<addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	sub	x3, x29, #0x1b0
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0x140]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	x2, [x3, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x4, x2, #0x3
               	cbnz	w4, <addr>
               	lsr	x1, x2, #8
               	mov	x2, #0x999a             // =39322
               	movk	x2, #0x9999, lsl #16
               	movk	x2, #0x9999, lsl #32
               	movk	x2, #0x199, lsl #48
               	umulh	x2, x1, x2
               	mov	x17, #0xa0              // =160
               	mul	x2, x2, x17
               	sub	x1, x1, x2
               	sub	x2, x1, #0x50
               	b	<addr>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	b	<addr>
               	ldr	q16, [sp, #0x100]
               	str	q16, [sp, #0x130]
               	ldr	q1, [sp, #0x190]
               	ldr	q2, [sp, #0x180]
               	sqrshl	v3.16b, v1.16b, v2.16b
               	sub	x4, x29, #0x280
               	str	q3, [sp, #0x30]
               	mov	d2, v2.d[1]
               	uqrshl	v1.8b, v1.8b, v2.8b
               	stur	d1, [x29, #-0xf8]
               	ldr	q1, [sp, #0x170]
               	mov	d3, v1.d[0]
               	ldr	q2, [sp, #0x160]
               	mov	d4, v2.d[0]
               	sqrshl	v3.4h, v3.4h, v4.4h
               	stur	d3, [x29, #-0xf0]
               	uqrshl	v1.8h, v1.8h, v2.8h
               	str	q1, [sp, #0x40]
               	ldr	q1, [sp, #0x150]
               	sqrshl	v2.4s, v1.4s, v0.4s
               	str	q2, [sp, #0x50]
               	uqrshl	v0.2s, v1.2s, v0.2s
               	stur	d0, [x29, #-0xe8]
               	ldr	q0, [sp, #0x140]
               	mov	d2, v0.d[0]
               	ldr	q1, [sp, #0x130]
               	mov	d3, v1.d[0]
               	sqrshl	d2, d2, d3
               	stur	d2, [x29, #-0xe0]
               	uqrshl	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x60]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x18]
               	ldrb	w3, [x4, x0]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x1, #0x18]
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
               	sub	x2, x29, #0x270
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
               	sub	x2, x29, #0x250
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
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x120]
               	bl	<addr>
               	ldr	q0, [sp, #0x120]
               	mov	v0.d[1], x0
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
               	ldr	q1, [sp, #0x1a0]
               	mov	v1.s[0], w1
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
               	mov	v16.16b, v1.16b
               	mov	v16.s[1], w1
               	str	q16, [sp, #0x120]
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
               	ldr	q1, [sp, #0x120]
               	mov	v1.s[2], w1
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
               	mov	v16.16b, v1.16b
               	mov	v16.s[3], w0
               	str	q16, [sp, #0x1a0]
               	str	q0, [sp, #0x110]
               	bl	<addr>
               	ldr	q0, [sp, #0x110]
               	stur	x0, [x29, #-0xa0]
               	fmov	d8, x0
               	tbz	w22, #0x0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q1, [x0]
               	fmul	v0.2d, v0.2d, v1.2d
               	mov	x0, #0x1f               // =31
               	str	q0, [sp, #0x110]
               	bl	<addr>
               	ldr	q0, [sp, #0x110]
               	fcvtxn	v1.2s, v0.2d
               	sub	x21, x29, #0xd8
               	stur	d1, [x29, #-0xd8]
               	ldr	q16, [sp, #0x120]
               	mov	d1, v16.d[0]
               	fcvtxn	v2.2s, v0.2d
               	mov	v1.d[1], v2.d[0]
               	str	q1, [sp, #0x70]
               	mov	x20, #0x0               // =0
               	fmov	d1, d8
               	fcvtxn	v1.2s, v1.2d
               	stur	s1, [x29, #-0xd0]
               	ldr	q16, [sp, #0x1a0]
               	mov	s1, v16.s[1]
               	fmov	s1, s1
               	frecpx	s1, s1
               	stur	s1, [x29, #-0xc8]
               	frecpx	d0, d0
               	stur	d0, [x29, #-0xc0]
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x23, eq
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x23, x23, x0, lsl #1
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x23, x23, x0, lsl #2
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x23, x23, x0, lsl #3
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x0, x23, x0, lsl #4
               	stur	w0, [x29, #-0xb8]
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x18]
               	ldrb	w2, [x21, x20]
               	eor	x1, x1, x2
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x1, x1, x17
               	str	x1, [x0, #0x18]
               	add	x20, x20, #0x1
               	cmp	w20, #0x8
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
               	cmp	w0, #0x4
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
               	cmp	w0, #0x4
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
               	cmp	w0, #0x4
               	b.lo	<addr>
               	ldr	q0, [sp, #0x190]
               	cls	v1.16b, v0.16b
               	sub	x2, x29, #0x230
               	str	q1, [sp, #0x80]
               	ldr	q1, [sp, #0x170]
               	mov	d2, v1.d[0]
               	cls	v2.4h, v2.4h
               	stur	d2, [x29, #-0xb0]
               	ldr	q16, [sp, #0x150]
               	cls	v2.4s, v16.4s
               	str	q2, [sp, #0x90]
               	ldr	q17, [sp, #0x180]
               	eor	v0.16b, v0.16b, v17.16b
               	str	q0, [sp, #0xa0]
               	ldr	q0, [sp, #0x140]
               	mov	d3, v0.d[0]
               	ldr	q2, [sp, #0x130]
               	mov	d4, v2.d[1]
               	eor	v3.8b, v3.8b, v4.8b
               	stur	d3, [x29, #-0xa8]
               	mov	d4, v1.d[0]
               	ldr	q3, [sp, #0x160]
               	mov	d5, v3.d[1]
               	eor	v4.8b, v4.8b, v5.8b
               	stur	d4, [x29, #-0x98]
               	cmtst	v1.8h, v1.8h, v3.8h
               	str	q1, [sp, #0xb0]
               	cmtst	v1.2d, v0.2d, v2.2d
               	str	q1, [sp, #0xc0]
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x68]
               	mov	x0, v2.d[1]
               	stur	x0, [x29, #-0x78]
               	mov	x0, v0.d[1]
               	stur	x0, [x29, #-0x80]
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
               	sub	x2, x29, #0x210
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
               	sub	x2, x29, #0x1f0
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
               	add	x22, x22, #0x1
               	cmp	w22, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0xc6af            // =50863
               	movk	x17, #0xd1ed, lsl #16
               	movk	x17, #0xc97e, lsl #32
               	movk	x17, #0x4d14, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
