
arm_neon_compares_against_zero_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x430
               	str	x20, [sp]
               	mov	x20, #0x0               // =0
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x4, x29, #0x210
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x220]
               	str	q16, [sp, #0x2b0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strh	w1, [x4, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x4, x29, #0x1e0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxth	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x250]
               	str	q16, [sp, #0x260]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w1, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x200
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x4, x1, #0x3
               	cbz	x4, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldr	q16, [sp, #0x230]
               	str	q16, [sp, #0x2a0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x2, [x4, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x1f0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x2, x2, #0x3
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldr	q16, [sp, #0x240]
               	str	q16, [sp, #0x290]
               	bl	<addr>
               	str	q0, [sp, #0x280]
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x270]
               	bl	<addr>
               	ldr	q1, [sp, #0x270]
               	mov	v1.d[1], x0
               	ldr	q2, [sp, #0x2b0]
               	mov	d0, v2.d[0]
               	cmeq	v0.8b, v0.8b, #0
               	sub	x2, x29, #0x170
               	str	d0, [sp, #0x2c0]
               	cmeq	v0.16b, v2.16b, #0
               	str	q0, [sp, #0x10]
               	ldr	q2, [sp, #0x260]
               	mov	d0, v2.d[0]
               	cmeq	v0.4h, v0.4h, #0
               	str	d0, [sp, #0x2c8]
               	cmeq	v0.8h, v2.8h, #0
               	str	q0, [sp, #0x20]
               	ldr	q2, [sp, #0x2a0]
               	mov	d0, v2.d[0]
               	cmeq	v0.2s, v0.2s, #0
               	str	d0, [sp, #0x2d0]
               	cmeq	v0.4s, v2.4s, #0
               	str	q0, [sp, #0x30]
               	ldr	q2, [sp, #0x290]
               	mov	d0, v2.d[0]
               	cmeq	d0, d0, #0
               	str	d0, [sp, #0x2d8]
               	cmeq	v0.2d, v2.2d, #0
               	str	q0, [sp, #0x40]
               	ldr	q0, [sp, #0x280]
               	mov	d3, v0.d[0]
               	fcmeq	v3.2s, v3.2s, #0.0
               	str	d3, [sp, #0x2e0]
               	fcmeq	v3.4s, v0.4s, #0.0
               	str	q3, [sp, #0x50]
               	mov	d3, v1.d[0]
               	fcmeq	d3, d3, #0.0
               	str	d3, [sp, #0x2e8]
               	fcmeq	v3.2d, v1.2d, #0.0
               	str	q3, [sp, #0x60]
               	mov	x0, v2.d[1]
               	fmov	d2, x0
               	cmeq	d2, d2, #0
               	mov	x0, v2.d[0]
               	stur	x0, [x29, #-0x80]
               	mov	s0, v0.s[2]
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	fcmeq	v0.2s, v0.2s, #0.0
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0x78]
               	mov	d0, v1.d[1]
               	fcmeq	d0, d0, #0.0
               	mov	x1, v0.d[0]
               	stur	x1, [x29, #-0x70]
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
               	sub	x2, x29, #0x420
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
               	sub	x2, x29, #0x168
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
               	sub	x2, x29, #0x410
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x400
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
               	sub	x2, x29, #0x158
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
               	sub	x2, x29, #0x3f0
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
               	sub	x2, x29, #0x150
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
               	sub	x2, x29, #0x3e0
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
               	sub	x2, x29, #0x148
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
               	sub	x2, x29, #0x3d0
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
               	cmp	w0, #0x4
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
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x4, x29, #0x210
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x220]
               	str	q16, [sp, #0x2b0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strh	w1, [x4, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x4, x29, #0x1e0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxth	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x250]
               	str	q16, [sp, #0x260]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w1, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x200
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x4, x1, #0x3
               	cbz	x4, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldr	q16, [sp, #0x230]
               	str	q16, [sp, #0x2a0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x2, [x4, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x1f0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x2, x2, #0x3
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldr	q16, [sp, #0x240]
               	str	q16, [sp, #0x290]
               	bl	<addr>
               	str	q0, [sp, #0x280]
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x270]
               	bl	<addr>
               	ldr	q1, [sp, #0x270]
               	mov	v1.d[1], x0
               	ldr	q2, [sp, #0x2b0]
               	mov	d0, v2.d[0]
               	cmge	v0.8b, v0.8b, #0
               	sub	x2, x29, #0x140
               	str	d0, [sp, #0x2f0]
               	cmge	v0.16b, v2.16b, #0
               	str	q0, [sp, #0x70]
               	ldr	q2, [sp, #0x260]
               	mov	d0, v2.d[0]
               	cmge	v0.4h, v0.4h, #0
               	str	d0, [sp, #0x2f8]
               	cmge	v0.8h, v2.8h, #0
               	str	q0, [sp, #0x80]
               	ldr	q2, [sp, #0x2a0]
               	mov	d0, v2.d[0]
               	cmge	v0.2s, v0.2s, #0
               	str	d0, [sp, #0x300]
               	cmge	v0.4s, v2.4s, #0
               	str	q0, [sp, #0x90]
               	ldr	q2, [sp, #0x290]
               	mov	d0, v2.d[0]
               	cmge	d0, d0, #0
               	str	d0, [sp, #0x308]
               	cmge	v0.2d, v2.2d, #0
               	str	q0, [sp, #0xa0]
               	ldr	q0, [sp, #0x280]
               	mov	d3, v0.d[0]
               	fcmge	v3.2s, v3.2s, #0.0
               	str	d3, [sp, #0x310]
               	fcmge	v3.4s, v0.4s, #0.0
               	str	q3, [sp, #0xb0]
               	mov	d3, v1.d[0]
               	fcmge	d3, d3, #0.0
               	str	d3, [sp, #0x318]
               	fcmge	v3.2d, v1.2d, #0.0
               	str	q3, [sp, #0xc0]
               	mov	x0, v2.d[1]
               	fmov	d2, x0
               	cmge	d2, d2, #0
               	mov	x0, v2.d[0]
               	stur	x0, [x29, #-0x80]
               	mov	s0, v0.s[2]
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	fcmge	v0.2s, v0.2s, #0.0
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0x78]
               	mov	d0, v1.d[1]
               	fcmge	d0, d0, #0.0
               	mov	x1, v0.d[0]
               	stur	x1, [x29, #-0x70]
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
               	sub	x2, x29, #0x3c0
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
               	sub	x2, x29, #0x138
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
               	sub	x2, x29, #0x3b0
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
               	sub	x2, x29, #0x130
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
               	sub	x2, x29, #0x3a0
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
               	sub	x2, x29, #0x128
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
               	sub	x2, x29, #0x390
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
               	sub	x2, x29, #0x120
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
               	sub	x2, x29, #0x380
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
               	sub	x2, x29, #0x118
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
               	sub	x2, x29, #0x370
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
               	cmp	w0, #0x4
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
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x4, x29, #0x210
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x220]
               	str	q16, [sp, #0x2b0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strh	w1, [x4, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x4, x29, #0x1e0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxth	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x250]
               	str	q16, [sp, #0x260]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w1, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x200
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x4, x1, #0x3
               	cbz	x4, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldr	q16, [sp, #0x230]
               	str	q16, [sp, #0x2a0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x2, [x4, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x1f0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x2, x2, #0x3
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldr	q16, [sp, #0x240]
               	str	q16, [sp, #0x290]
               	bl	<addr>
               	str	q0, [sp, #0x280]
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x270]
               	bl	<addr>
               	ldr	q1, [sp, #0x270]
               	mov	v1.d[1], x0
               	ldr	q2, [sp, #0x2b0]
               	mov	d0, v2.d[0]
               	cmgt	v0.8b, v0.8b, #0
               	sub	x2, x29, #0x110
               	str	d0, [sp, #0x320]
               	cmgt	v0.16b, v2.16b, #0
               	str	q0, [sp, #0xd0]
               	ldr	q2, [sp, #0x260]
               	mov	d0, v2.d[0]
               	cmgt	v0.4h, v0.4h, #0
               	str	d0, [sp, #0x328]
               	cmgt	v0.8h, v2.8h, #0
               	str	q0, [sp, #0xe0]
               	ldr	q2, [sp, #0x2a0]
               	mov	d0, v2.d[0]
               	cmgt	v0.2s, v0.2s, #0
               	stur	d0, [x29, #-0x100]
               	cmgt	v0.4s, v2.4s, #0
               	str	q0, [sp, #0xf0]
               	ldr	q2, [sp, #0x290]
               	mov	d0, v2.d[0]
               	cmgt	d0, d0, #0
               	stur	d0, [x29, #-0xf8]
               	cmgt	v0.2d, v2.2d, #0
               	str	q0, [sp, #0x100]
               	ldr	q0, [sp, #0x280]
               	mov	d3, v0.d[0]
               	fcmgt	v3.2s, v3.2s, #0.0
               	stur	d3, [x29, #-0xf0]
               	fcmgt	v3.4s, v0.4s, #0.0
               	str	q3, [sp, #0x110]
               	mov	d3, v1.d[0]
               	fcmgt	d3, d3, #0.0
               	stur	d3, [x29, #-0xe8]
               	fcmgt	v3.2d, v1.2d, #0.0
               	str	q3, [sp, #0x120]
               	mov	x0, v2.d[1]
               	fmov	d2, x0
               	cmgt	d2, d2, #0
               	mov	x0, v2.d[0]
               	stur	x0, [x29, #-0x80]
               	mov	s0, v0.s[2]
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	fcmgt	v0.2s, v0.2s, #0.0
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0x78]
               	mov	d0, v1.d[1]
               	fcmgt	d0, d0, #0.0
               	mov	x1, v0.d[0]
               	stur	x1, [x29, #-0x70]
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
               	sub	x2, x29, #0x360
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
               	sub	x2, x29, #0x350
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
               	sub	x2, x29, #0x340
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
               	sub	x2, x29, #0x330
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
               	sub	x2, x29, #0x310
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
               	cmp	w0, #0x4
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
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x4, x29, #0x210
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x220]
               	str	q16, [sp, #0x2b0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strh	w1, [x4, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x4, x29, #0x1e0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxth	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x250]
               	str	q16, [sp, #0x260]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	str	w1, [x3, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x200
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x4, x1, #0x3
               	cbz	x4, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldr	q16, [sp, #0x230]
               	str	q16, [sp, #0x2a0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x2, [x4, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x1f0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x2, x2, #0x3
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldr	q16, [sp, #0x240]
               	str	q16, [sp, #0x290]
               	bl	<addr>
               	str	q0, [sp, #0x280]
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x270]
               	bl	<addr>
               	ldr	q1, [sp, #0x270]
               	mov	v1.d[1], x0
               	ldr	q2, [sp, #0x2b0]
               	mov	d0, v2.d[0]
               	cmle	v0.8b, v0.8b, #0
               	sub	x2, x29, #0xe0
               	stur	d0, [x29, #-0xe0]
               	cmle	v0.16b, v2.16b, #0
               	str	q0, [sp, #0x130]
               	ldr	q2, [sp, #0x260]
               	mov	d0, v2.d[0]
               	cmle	v0.4h, v0.4h, #0
               	stur	d0, [x29, #-0xd8]
               	cmle	v0.8h, v2.8h, #0
               	str	q0, [sp, #0x140]
               	ldr	q2, [sp, #0x2a0]
               	mov	d0, v2.d[0]
               	cmle	v0.2s, v0.2s, #0
               	stur	d0, [x29, #-0xd0]
               	cmle	v0.4s, v2.4s, #0
               	str	q0, [sp, #0x150]
               	ldr	q2, [sp, #0x290]
               	mov	d0, v2.d[0]
               	cmle	d0, d0, #0
               	stur	d0, [x29, #-0xc8]
               	cmle	v0.2d, v2.2d, #0
               	str	q0, [sp, #0x160]
               	ldr	q0, [sp, #0x280]
               	mov	d3, v0.d[0]
               	fcmle	v3.2s, v3.2s, #0.0
               	stur	d3, [x29, #-0xc0]
               	fcmle	v3.4s, v0.4s, #0.0
               	str	q3, [sp, #0x170]
               	mov	d3, v1.d[0]
               	fcmle	d3, d3, #0.0
               	stur	d3, [x29, #-0xb8]
               	fcmle	v3.2d, v1.2d, #0.0
               	str	q3, [sp, #0x180]
               	mov	x0, v2.d[1]
               	fmov	d2, x0
               	cmle	d2, d2, #0
               	mov	x0, v2.d[0]
               	stur	x0, [x29, #-0x80]
               	mov	s0, v0.s[2]
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	fcmle	v0.2s, v0.2s, #0.0
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0x78]
               	mov	d0, v1.d[1]
               	fcmle	d0, d0, #0.0
               	mov	x1, v0.d[0]
               	stur	x1, [x29, #-0x70]
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
               	sub	x2, x29, #0x2f0
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
               	sub	x2, x29, #0x2d0
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
               	sub	x2, x29, #0x2b0
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
               	cmp	w0, #0x4
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
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x4, x29, #0x210
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x220]
               	str	q16, [sp, #0x2b0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strh	w1, [x4, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x4, x29, #0x1e0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxth	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x250]
               	str	q16, [sp, #0x2a0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	w1, [x4, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x4, x29, #0x200
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q16, [sp, #0x230]
               	str	q16, [sp, #0x290]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x2, [x4, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x1f0
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x2, x2, #0x3
               	cbz	x2, <addr>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldr	q16, [sp, #0x240]
               	str	q16, [sp, #0x280]
               	bl	<addr>
               	str	q0, [sp, #0x270]
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x260]
               	bl	<addr>
               	ldr	q1, [sp, #0x260]
               	mov	v1.d[1], x0
               	ldr	q2, [sp, #0x2b0]
               	mov	d0, v2.d[0]
               	cmlt	v0.8b, v0.8b, #0
               	sub	x2, x29, #0xb0
               	stur	d0, [x29, #-0xb0]
               	cmlt	v0.16b, v2.16b, #0
               	str	q0, [sp, #0x190]
               	ldr	q2, [sp, #0x2a0]
               	mov	d0, v2.d[0]
               	cmlt	v0.4h, v0.4h, #0
               	stur	d0, [x29, #-0xa8]
               	cmlt	v0.8h, v2.8h, #0
               	str	q0, [sp, #0x1a0]
               	ldr	q2, [sp, #0x290]
               	mov	d0, v2.d[0]
               	cmlt	v0.2s, v0.2s, #0
               	stur	d0, [x29, #-0xa0]
               	cmlt	v0.4s, v2.4s, #0
               	str	q0, [sp, #0x1b0]
               	ldr	q2, [sp, #0x280]
               	mov	d0, v2.d[0]
               	cmlt	d0, d0, #0
               	stur	d0, [x29, #-0x98]
               	cmlt	v0.2d, v2.2d, #0
               	str	q0, [sp, #0x1c0]
               	ldr	q0, [sp, #0x270]
               	mov	d3, v0.d[0]
               	fcmlt	v3.2s, v3.2s, #0.0
               	stur	d3, [x29, #-0x90]
               	fcmlt	v3.4s, v0.4s, #0.0
               	str	q3, [sp, #0x1d0]
               	mov	d3, v1.d[0]
               	fcmlt	d3, d3, #0.0
               	stur	d3, [x29, #-0x88]
               	fcmlt	v3.2d, v1.2d, #0.0
               	str	q3, [sp, #0x1e0]
               	mov	x0, v2.d[1]
               	fmov	d2, x0
               	cmlt	d2, d2, #0
               	mov	x0, v2.d[0]
               	stur	x0, [x29, #-0x80]
               	mov	s0, v0.s[2]
               	mov	x0, #0x0                // =0
               	fmov	s0, s0
               	fcmlt	v0.2s, v0.2s, #0.0
               	mov	w1, v0.s[0]
               	stur	w1, [x29, #-0x78]
               	mov	d0, v1.d[1]
               	fcmlt	d0, d0, #0.0
               	mov	x1, v0.d[0]
               	stur	x1, [x29, #-0x70]
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
               	sub	x2, x29, #0x290
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
               	cmp	w0, #0x4
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
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x4, x29, #0x210
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	sub	x4, x29, #0x210
               	ldr	q0, [sp, #0x220]
               	cmeq	v0.16b, v0.16b, #0
               	str	q0, [sp, #0x1f0]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strh	w1, [x5, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x5, x29, #0x1e0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x6, x1, #0x3
               	cbz	x6, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxth	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q0, [sp, #0x250]
               	cmeq	v0.4h, v0.4h, #0
               	stur	d0, [x29, #-0x68]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	w1, [x5, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x200
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x6, x1, #0x3
               	cbz	x6, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q0, [sp, #0x230]
               	cmeq	v0.4s, v0.4s, #0
               	str	q0, [sp, #0x200]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x1, [x5, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	sub	x5, x29, #0x1f0
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x6, x1, #0x3
               	cbz	x6, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	sub	x5, x29, #0x1f0
               	ldr	q0, [sp, #0x240]
               	cmeq	v0.2d, v0.2d, #0
               	str	q0, [sp, #0x210]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	strb	w1, [x4, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x6, x1, #0x3
               	cbz	x6, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	sxtb	x1, w1
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q0, [sp, #0x220]
               	cmeq	v0.8b, v0.8b, #0
               	stur	d0, [x29, #-0x50]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x1, [x5, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x4, x1, #0x3
               	cbz	x4, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	sub	x4, x29, #0x1f0
               	ldr	q0, [sp, #0x240]
               	cmeq	d0, d0, #0
               	stur	d0, [x29, #-0x60]
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	b	<addr>
               	str	x1, [x4, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	and	x5, x1, #0x3
               	cbz	x5, <addr>
               	eor	x1, x1, x1, lsl #13
               	eor	x1, x1, x1, lsr #7
               	eor	x1, x1, x1, lsl #17
               	str	x1, [x2, #0x10]
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	ldr	q0, [sp, #0x240]
               	mov	x0, v0.d[0]
               	fmov	d0, x0
               	cmeq	d0, d0, #0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
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
               	cmp	w0, #0x8
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
               	sub	x2, x29, #0x8
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
               	add	x20, x20, #0x1
               	cmp	w20, #0x3e8
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x20e2            // =8418
               	movk	x17, #0xb242, lsl #16
               	movk	x17, #0x142c, lsl #32
               	movk	x17, #0x3789, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldr	x20, [sp]
               	add	sp, sp, #0x430
               	ldp	x29, x30, [sp], #0x10
               	ret
