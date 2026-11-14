
arm_neon_magnitude_compares_high_narrowing_and_mixed_accumulates_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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

<f4>:
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
               	fmov	s0, w1
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
               	mov	v0.s[3], w0
               	ret
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

<f2>:
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x2, #0x10]
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
               	ldr	w1, [x1, x0, lsl #2]
               	ldr	x0, [x2, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x2, #0x10]
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
               	mov	w1, w1
               	orr	x0, x1, x0, lsl #32
               	fmov	d0, x0
               	ret
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
               	cmp	w1, #0x1
               	b.ne	<addr>
               	lsr	x0, x0, #32
               	and	w1, w0, #0x80ffffff
               	b	<addr>
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ubfx	x0, x0, #20, #25
               	mov	x17, #0x3f000000        // =1056964608
               	add	x1, x0, x17
               	b	<addr>
               	lsr	x1, x0, #16
               	b	<addr>

<i64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	b	<addr>
               	str	x0, [x4, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.ge	<addr>
               	ldr	x0, [x2, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x2, #0x10]
               	sub	x4, x29, #0x10
               	and	x3, x0, #0x7
               	cbnz	w3, <addr>
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	cmp	w3, #0x1
               	b.ne	<addr>
               	mov	x0, #0x7fffffffffffffff // =9223372036854775807
               	b	<addr>
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x2, #0x10]
               	b	<addr>
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x280
               	stp	d8, d9, [sp]
               	stp	d10, d11, [sp, #0x10]
               	str	x20, [sp, #0x20]
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	str	q0, [sp, #0x190]
               	bl	<addr>
               	str	q0, [sp, #0x180]
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fmov	d10, d0
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x170]
               	bl	<addr>
               	ldr	q16, [sp, #0x170]
               	mov	v16.d[1], x0
               	str	q16, [sp, #0x170]
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x160]
               	bl	<addr>
               	ldr	q16, [sp, #0x160]
               	mov	v16.d[1], x0
               	str	q16, [sp, #0x160]
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	fmov	d9, x0
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	fmov	d11, x0
               	ldr	q1, [sp, #0x190]
               	ldr	q2, [sp, #0x180]
               	facge	v0.4s, v1.4s, v2.4s
               	sub	x2, x29, #0x250
               	str	q0, [sp, #0x30]
               	facgt	v0.4s, v2.4s, v1.4s
               	str	q0, [sp, #0x40]
               	facgt	v0.2s, v8.2s, v10.2s
               	stur	d0, [x29, #-0xd8]
               	facge	v0.2s, v10.2s, v8.2s
               	stur	d0, [x29, #-0xd0]
               	ldr	q3, [sp, #0x170]
               	ldr	q4, [sp, #0x160]
               	facgt	v0.2d, v3.2d, v4.2d
               	str	q0, [sp, #0x50]
               	facge	v0.2d, v4.2d, v3.2d
               	str	q0, [sp, #0x60]
               	facge	d0, d9, d11
               	stur	d0, [x29, #-0xc8]
               	facgt	d0, d11, d9
               	stur	d0, [x29, #-0xc0]
               	mov	s0, v1.s[0]
               	mov	s1, v2.s[0]
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	fmov	s1, s1
               	facge	v0.2s, v0.2s, v1.2s
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0xb8]
               	mov	d0, v3.d[1]
               	mov	d1, v4.d[1]
               	facgt	d0, d1, d0
               	mov	x1, v0.d[0]
               	stur	x1, [x29, #-0xb0]
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
               	sub	x2, x29, #0x230
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
               	sub	x3, x29, #0x180
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	mov	x1, #-0x8000            // =-32768
               	b	<addr>
               	mov	x4, #0x7fff             // =32767
               	lsr	x1, x1, #8
               	sxth	x1, w1
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	b	<addr>
               	sub	x3, x29, #0x180
               	ldr	q1, [sp, #0x100]
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
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	mov	x1, #-0x8000            // =-32768
               	b	<addr>
               	mov	x4, #0x7fff             // =32767
               	lsr	x1, x1, #8
               	sxth	x1, w1
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	b	<addr>
               	ldr	q2, [sp, #0x100]
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
               	sub	x3, x29, #0x170
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	mov	x1, #-0x80000000        // =-2147483648
               	b	<addr>
               	mov	x4, #0x7fffffff         // =2147483647
               	lsr	x1, x1, #16
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	b	<addr>
               	sub	x3, x29, #0x170
               	ldr	q16, [sp, #0x110]
               	str	q16, [sp, #0x170]
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
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	mov	x1, #-0x80000000        // =-2147483648
               	b	<addr>
               	mov	x4, #0x7fffffff         // =2147483647
               	lsr	x1, x1, #16
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	b	<addr>
               	ldr	q16, [sp, #0x110]
               	str	q16, [sp, #0x160]
               	str	q1, [sp, #0x150]
               	str	q2, [sp, #0x140]
               	bl	<addr>
               	ldr	q1, [sp, #0x150]
               	ldr	q2, [sp, #0x140]
               	mov	v3.16b, v0.16b
               	str	q1, [sp, #0x150]
               	str	q2, [sp, #0x140]
               	str	q3, [sp, #0x130]
               	bl	<addr>
               	ldr	q1, [sp, #0x150]
               	ldr	q2, [sp, #0x140]
               	ldr	q3, [sp, #0x130]
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
               	sub	x3, x29, #0x160
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	mov	x1, #-0x80              // =-128
               	b	<addr>
               	mov	x4, #0x7f               // =127
               	lsr	x1, x1, #8
               	sxtb	x1, w1
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	b	<addr>
               	sub	x3, x29, #0x160
               	ldr	q4, [sp, #0x120]
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
               	and	x2, x1, #0x7
               	cbnz	w2, <addr>
               	mov	x1, #-0x80              // =-128
               	b	<addr>
               	mov	x4, #0x7f               // =127
               	lsr	x1, x1, #8
               	sxtb	x1, w1
               	cmp	w2, #0x1
               	csel	x1, x4, x1, eq
               	b	<addr>
               	ldr	q5, [sp, #0x120]
               	addhn	v6.8b, v1.8h, v2.8h
               	sub	x2, x29, #0xa8
               	stur	d6, [x29, #-0xa8]
               	rsubhn	v7.8b, v1.8h, v2.8h
               	stur	d7, [x29, #-0xa0]
               	ldr	q16, [sp, #0x170]
               	ldr	q17, [sp, #0x160]
               	raddhn	v7.4h, v16.4s, v17.4s
               	stur	d7, [x29, #-0x98]
               	subhn	v7.2s, v3.2d, v0.2d
               	stur	d7, [x29, #-0x90]
               	raddhn	v19.8b, v1.8h, v2.8h
               	mov	v6.d[1], v19.d[0]
               	str	q6, [sp, #0x70]
               	fmov	x0, d7
               	fmov	d6, x0
               	rsubhn	v7.2s, v3.2d, v0.2d
               	mov	v6.d[1], v7.d[0]
               	str	q6, [sp, #0x80]
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
               	mov	v6.16b, v4.16b
               	suqadd	v6.16b, v5.16b
               	sub	x2, x29, #0x1f0
               	str	q6, [sp, #0x90]
               	mov	d6, v1.d[0]
               	mov	d7, v2.d[0]
               	usqadd	v6.4h, v7.4h
               	stur	d6, [x29, #-0x48]
               	ldr	q16, [sp, #0x170]
               	ldr	q17, [sp, #0x160]
               	mov	v6.16b, v16.16b
               	suqadd	v6.4s, v17.4s
               	str	q6, [sp, #0xa0]
               	mov	v6.16b, v3.16b
               	usqadd	v6.2d, v0.2d
               	str	q6, [sp, #0xb0]
               	mov	x0, v3.d[0]
               	mov	x1, v0.d[1]
               	fmov	d6, x0
               	fmov	d7, x1
               	suqadd	d6, d7
               	mov	x0, v6.d[0]
               	stur	x0, [x29, #-0x88]
               	smov	x0, v4.b[3]
               	and	x1, x0, #0xff
               	smov	x0, v5.b[4]
               	sxtb	x3, w0
               	mov	x0, #0x0                // =0
               	fmov	d6, x0
               	mov	v6.b[0], w1
               	fmov	d7, x0
               	mov	v7.b[0], w3
               	usqadd	v6.8b, v7.8b
               	umov	w1, v6.b[0]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x50]
               	smov	x1, v1.h[2]
               	smov	x3, v2.h[5]
               	and	x3, x3, #0xffff
               	sxth	x1, w1
               	fmov	d6, x0
               	mov	v6.h[0], w1
               	fmov	d7, x0
               	mov	v7.h[0], w3
               	suqadd	v6.4h, v7.4h
               	smov	x1, v6.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x58]
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
               	sub	x2, x29, #0x1d0
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
               	sub	x2, x29, #0x50
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w0, [x2, x0]
               	eor	x0, x3, x0
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x0, x0, x17
               	str	x0, [x1, #0x18]
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x1
               	b.lo	<addr>
               	sub	x2, x29, #0x58
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
               	cmp	w0, #0x2
               	b.lo	<addr>
               	rbit	v4.16b, v4.16b
               	sub	x2, x29, #0x1c0
               	str	q4, [sp, #0xc0]
               	mov	d4, v5.d[0]
               	rbit	v4.8b, v4.8b
               	stur	d4, [x29, #-0x80]
               	ldr	q4, [sp, #0x190]
               	ldr	q16, [sp, #0x180]
               	fmul	v5.4s, v16.4s, v4.4s
               	fadd	v5.4s, v4.4s, v5.4s
               	str	q5, [sp, #0xd0]
               	fmul	d5, d11, d9
               	fsub	d5, d9, d5
               	mov	x0, v5.d[0]
               	stur	x0, [x29, #-0x78]
               	fmul	v5.2s, v10.2s, v8.2s
               	fsub	v5.2s, v8.2s, v5.2s
               	mov	x0, v5.d[0]
               	stur	x0, [x29, #-0x70]
               	smov	x0, v2.h[6]
               	mov	v1.h[3], w0
               	str	q1, [sp, #0xe0]
               	mov	s1, v4.s[2]
               	mov	v16.16b, v8.16b
               	mov	v16.s[1], v1.s[0]
               	fmov	d1, d16
               	stur	d1, [x29, #-0x68]
               	mov	d0, v0.d[1]
               	mov	x0, v0.d[0]
               	mov	v0.16b, v3.16b
               	mov	v0.d[0], x0
               	str	q0, [sp, #0xf0]
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
               	sub	x2, x29, #0x1b0
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
               	sub	x2, x29, #0x190
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
               	add	x20, x20, #0x1
               	cmp	w20, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x7372            // =29554
               	movk	x17, #0xcf96, lsl #16
               	movk	x17, #0xbdd1, lsl #32
               	movk	x17, #0x2fe, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldr	x20, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp]
               	add	sp, sp, #0x280
               	ldp	x29, x30, [sp], #0x10
               	ret
