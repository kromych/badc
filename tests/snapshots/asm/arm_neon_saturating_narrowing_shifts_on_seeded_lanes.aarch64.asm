
arm_neon_saturating_narrowing_shifts_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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

<mix>:
               	mov	x2, #0x0                // =0
               	mov	x4, #0x1b3              // =435
               	movk	x4, #0x100, lsl #32
               	adrp	x3, <page>
               	cmp	x2, x1
               	b.hs	<addr>
               	ldr	x5, [x3, #0x18]
               	ldrb	w6, [x0, x2]
               	eor	x5, x5, x6
               	mul	x5, x5, x4
               	str	x5, [x3, #0x18]
               	add	x2, x2, #0x1
               	cmp	x2, x1
               	b.lo	<addr>
               	ret

<i16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	b	<addr>
               	strh	w2, [x3, x1, lsl #1]
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.ge	<addr>
               	sub	x3, x29, #0x10
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	and	x4, x2, #0x3
               	cbz	x4, <addr>
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	sxth	x2, w2
               	b	<addr>
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	sxtb	x2, w2
               	add	x2, x2, x2, lsl #1
               	sxth	x2, w2
               	b	<addr>
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<i32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	b	<addr>
               	str	w2, [x3, x1, lsl #2]
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x3, x29, #0x10
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	and	x4, x2, #0x3
               	cbz	x4, <addr>
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	b	<addr>
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	sxth	x2, w2
               	add	x2, x2, x2, lsl #2
               	b	<addr>
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<i64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	mov	x3, #0x7                // =7
               	adrp	x0, <page>
               	b	<addr>
               	str	x2, [x4, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.ge	<addr>
               	sub	x4, x29, #0x10
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	and	x5, x2, #0x3
               	cbz	x5, <addr>
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	b	<addr>
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	sxtw	x2, w2
               	mul	x2, x2, x3
               	b	<addr>
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x650
               	stp	x20, x21, [sp]
               	mov	x21, #0x0               // =0
               	bl	<addr>
               	str	q0, [sp, #0x2a0]
               	bl	<addr>
               	str	q0, [sp, #0x290]
               	bl	<addr>
               	str	q0, [sp, #0x280]
               	bl	<addr>
               	str	q0, [sp, #0x270]
               	bl	<addr>
               	str	q0, [sp, #0x260]
               	bl	<addr>
               	str	q0, [sp, #0x250]
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x1
               	str	d1, [sp, #0x2b0]
               	sqrshrn	v1.8b, v0.8h, #0x1
               	str	d1, [sp, #0x2b8]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x1
               	str	d2, [sp, #0x2c0]
               	uqrshrn	v1.8b, v1.8h, #0x1
               	str	d1, [sp, #0x2c8]
               	sqshrun	v1.8b, v0.8h, #0x1
               	str	d1, [sp, #0x2d0]
               	sqrshrun	v1.8b, v0.8h, #0x1
               	str	d1, [sp, #0x2d8]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0x1
               	str	d2, [sp, #0x2e0]
               	sqrshrn	v2.4h, v1.4s, #0x1
               	str	d2, [sp, #0x2e8]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0x1
               	str	d2, [sp, #0x2f0]
               	uqrshrn	v2.4h, v3.4s, #0x1
               	str	d2, [sp, #0x2f8]
               	sqshrun	v2.4h, v1.4s, #0x1
               	str	d2, [sp, #0x300]
               	sqrshrun	v2.4h, v1.4s, #0x1
               	str	d2, [sp, #0x308]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x1
               	str	d4, [sp, #0x310]
               	sqrshrn	v4.2s, v2.2d, #0x1
               	str	d4, [sp, #0x318]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x1
               	str	d5, [sp, #0x320]
               	uqrshrn	v5.2s, v4.2d, #0x1
               	str	d5, [sp, #0x328]
               	sqshrun	v5.2s, v2.2d, #0x1
               	str	d5, [sp, #0x330]
               	sqrshrun	v5.2s, v2.2d, #0x1
               	str	d5, [sp, #0x338]
               	sqshrn	v5.8b, v0.8h, #0x1
               	ldr	d6, [sp, #0x2b0]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x10]
               	sqrshrun	v0.8b, v0.8h, #0x1
               	ldr	d5, [sp, #0x2d0]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x20]
               	rshrn	v0.4h, v3.4s, #0x1
               	ldr	d3, [sp, #0x2f0]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x30]
               	shrn	v0.2s, v2.2d, #0x1
               	ldr	d2, [sp, #0x310]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x40]
               	uqrshrn	v0.2s, v4.2d, #0x1
               	ldr	d2, [sp, #0x320]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x50]
               	sqrshrn	v0.4h, v1.4s, #0x1
               	ldr	d1, [sp, #0x2e0]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x60]
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x398
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x388
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x378
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x368
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x358
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x348
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x338
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x328
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x318
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
               	sub	x2, x29, #0x640
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
               	sub	x2, x29, #0x630
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
               	sub	x2, x29, #0x620
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
               	sub	x2, x29, #0x610
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
               	sub	x2, x29, #0x600
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
               	sub	x2, x29, #0x5f0
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
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x3
               	str	d1, [sp, #0x340]
               	sqrshrn	v1.8b, v0.8h, #0x3
               	str	d1, [sp, #0x348]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x3
               	str	d2, [sp, #0x350]
               	uqrshrn	v1.8b, v1.8h, #0x3
               	str	d1, [sp, #0x358]
               	sqshrun	v1.8b, v0.8h, #0x3
               	str	d1, [sp, #0x360]
               	sqrshrun	v1.8b, v0.8h, #0x3
               	str	d1, [sp, #0x368]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0x3
               	str	d2, [sp, #0x370]
               	sqrshrn	v2.4h, v1.4s, #0x3
               	str	d2, [sp, #0x378]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0x3
               	str	d2, [sp, #0x380]
               	uqrshrn	v2.4h, v3.4s, #0x3
               	str	d2, [sp, #0x388]
               	sqshrun	v2.4h, v1.4s, #0x3
               	str	d2, [sp, #0x390]
               	sqrshrun	v2.4h, v1.4s, #0x3
               	str	d2, [sp, #0x398]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x3
               	str	d4, [sp, #0x3a0]
               	sqrshrn	v4.2s, v2.2d, #0x3
               	str	d4, [sp, #0x3a8]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x3
               	str	d5, [sp, #0x3b0]
               	uqrshrn	v5.2s, v4.2d, #0x3
               	str	d5, [sp, #0x3b8]
               	sqshrun	v5.2s, v2.2d, #0x3
               	str	d5, [sp, #0x3c0]
               	sqrshrun	v5.2s, v2.2d, #0x3
               	str	d5, [sp, #0x3c8]
               	sqshrn	v5.8b, v0.8h, #0x3
               	ldr	d6, [sp, #0x340]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x70]
               	sqrshrun	v0.8b, v0.8h, #0x3
               	ldr	d5, [sp, #0x360]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x80]
               	rshrn	v0.4h, v3.4s, #0x3
               	ldr	d3, [sp, #0x380]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x90]
               	shrn	v0.2s, v2.2d, #0x3
               	ldr	d2, [sp, #0x3a0]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0xa0]
               	uqrshrn	v0.2s, v4.2d, #0x3
               	ldr	d2, [sp, #0x3b0]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0xb0]
               	sqrshrn	v0.4h, v1.4s, #0x3
               	ldr	d1, [sp, #0x370]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0xc0]
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x308
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2f8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2e8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2d8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2c8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2b8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x2a8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x298
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x288
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
               	sub	x2, x29, #0x5e0
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
               	sub	x2, x29, #0x5d0
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
               	sub	x2, x29, #0x5c0
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
               	sub	x2, x29, #0x5b0
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
               	sub	x2, x29, #0x5a0
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
               	sub	x2, x29, #0x590
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
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x3d0]
               	sqrshrn	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x3d8]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x7
               	str	d2, [sp, #0x3e0]
               	uqrshrn	v1.8b, v1.8h, #0x7
               	str	d1, [sp, #0x3e8]
               	sqshrun	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x3f0]
               	sqrshrun	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x3f8]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0x7
               	str	d2, [sp, #0x400]
               	sqrshrn	v2.4h, v1.4s, #0x7
               	str	d2, [sp, #0x408]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0x7
               	str	d2, [sp, #0x410]
               	uqrshrn	v2.4h, v3.4s, #0x7
               	str	d2, [sp, #0x418]
               	sqshrun	v2.4h, v1.4s, #0x7
               	str	d2, [sp, #0x420]
               	sqrshrun	v2.4h, v1.4s, #0x7
               	str	d2, [sp, #0x428]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x7
               	str	d4, [sp, #0x430]
               	sqrshrn	v4.2s, v2.2d, #0x7
               	str	d4, [sp, #0x438]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x7
               	str	d5, [sp, #0x440]
               	uqrshrn	v5.2s, v4.2d, #0x7
               	str	d5, [sp, #0x448]
               	sqshrun	v5.2s, v2.2d, #0x7
               	str	d5, [sp, #0x450]
               	sqrshrun	v5.2s, v2.2d, #0x7
               	str	d5, [sp, #0x458]
               	sqshrn	v5.8b, v0.8h, #0x7
               	ldr	d6, [sp, #0x3d0]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0xd0]
               	sqrshrun	v0.8b, v0.8h, #0x7
               	ldr	d5, [sp, #0x3f0]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0xe0]
               	rshrn	v0.4h, v3.4s, #0x7
               	ldr	d3, [sp, #0x410]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0xf0]
               	shrn	v0.2s, v2.2d, #0x7
               	ldr	d2, [sp, #0x430]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x100]
               	uqrshrn	v0.2s, v4.2d, #0x7
               	ldr	d2, [sp, #0x440]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x110]
               	sqrshrn	v0.4h, v1.4s, #0x7
               	ldr	d1, [sp, #0x400]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x120]
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x278
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x268
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x258
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x248
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x238
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x228
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x218
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x208
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1f8
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
               	sub	x2, x29, #0x580
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
               	sub	x2, x29, #0x570
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
               	sub	x2, x29, #0x560
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
               	sub	x2, x29, #0x550
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
               	sub	x2, x29, #0x540
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
               	sub	x2, x29, #0x530
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
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x8
               	str	d1, [sp, #0x460]
               	sqrshrn	v1.8b, v0.8h, #0x8
               	str	d1, [sp, #0x468]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x8
               	str	d2, [sp, #0x470]
               	uqrshrn	v1.8b, v1.8h, #0x8
               	str	d1, [sp, #0x478]
               	sqshrun	v1.8b, v0.8h, #0x8
               	str	d1, [sp, #0x480]
               	sqrshrun	v1.8b, v0.8h, #0x8
               	str	d1, [sp, #0x488]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0x8
               	str	d2, [sp, #0x490]
               	sqrshrn	v2.4h, v1.4s, #0x8
               	str	d2, [sp, #0x498]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0x8
               	str	d2, [sp, #0x4a0]
               	uqrshrn	v2.4h, v3.4s, #0x8
               	str	d2, [sp, #0x4a8]
               	sqshrun	v2.4h, v1.4s, #0x8
               	str	d2, [sp, #0x4b0]
               	sqrshrun	v2.4h, v1.4s, #0x8
               	str	d2, [sp, #0x4b8]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x8
               	str	d4, [sp, #0x4c0]
               	sqrshrn	v4.2s, v2.2d, #0x8
               	str	d4, [sp, #0x4c8]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x8
               	str	d5, [sp, #0x4d0]
               	uqrshrn	v5.2s, v4.2d, #0x8
               	str	d5, [sp, #0x4d8]
               	sqshrun	v5.2s, v2.2d, #0x8
               	str	d5, [sp, #0x4e0]
               	sqrshrun	v5.2s, v2.2d, #0x8
               	str	d5, [sp, #0x4e8]
               	sqshrn	v5.8b, v0.8h, #0x8
               	ldr	d6, [sp, #0x460]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x130]
               	sqrshrun	v0.8b, v0.8h, #0x8
               	ldr	d5, [sp, #0x480]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x140]
               	rshrn	v0.4h, v3.4s, #0x8
               	ldr	d3, [sp, #0x4a0]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x150]
               	shrn	v0.2s, v2.2d, #0x8
               	ldr	d2, [sp, #0x4c0]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x160]
               	uqrshrn	v0.2s, v4.2d, #0x8
               	ldr	d2, [sp, #0x4d0]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x170]
               	sqrshrn	v0.4h, v1.4s, #0x8
               	ldr	d1, [sp, #0x490]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x180]
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1e8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1d8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1c8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1b8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x1a8
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x198
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x188
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
               	cmp	w0, #0x8
               	b.lo	<addr>
               	sub	x2, x29, #0x178
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
               	sub	x2, x29, #0x170
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
               	sub	x2, x29, #0x520
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
               	sub	x2, x29, #0x510
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
               	sub	x2, x29, #0x500
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
               	sub	x2, x29, #0x4f0
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
               	sub	x2, x29, #0x4e0
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
               	sub	x2, x29, #0x4d0
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
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x4f0]
               	sqrshrn	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x4f8]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x7
               	str	d2, [sp, #0x500]
               	uqrshrn	v1.8b, v1.8h, #0x7
               	str	d1, [sp, #0x508]
               	sqshrun	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x510]
               	sqrshrun	v1.8b, v0.8h, #0x7
               	str	d1, [sp, #0x518]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0xf
               	str	d2, [sp, #0x520]
               	sqrshrn	v2.4h, v1.4s, #0xf
               	str	d2, [sp, #0x528]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0xf
               	str	d2, [sp, #0x530]
               	uqrshrn	v2.4h, v3.4s, #0xf
               	str	d2, [sp, #0x538]
               	sqshrun	v2.4h, v1.4s, #0xf
               	str	d2, [sp, #0x540]
               	sqrshrun	v2.4h, v1.4s, #0xf
               	str	d2, [sp, #0x548]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0xf
               	stur	d4, [x29, #-0x100]
               	sqrshrn	v4.2s, v2.2d, #0xf
               	stur	d4, [x29, #-0xf8]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0xf
               	stur	d5, [x29, #-0xf0]
               	uqrshrn	v5.2s, v4.2d, #0xf
               	stur	d5, [x29, #-0xe8]
               	sqshrun	v5.2s, v2.2d, #0xf
               	stur	d5, [x29, #-0xe0]
               	sqrshrun	v5.2s, v2.2d, #0xf
               	stur	d5, [x29, #-0xd8]
               	sqshrn	v5.8b, v0.8h, #0x7
               	ldr	d6, [sp, #0x4f0]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x190]
               	sqrshrun	v0.8b, v0.8h, #0x7
               	ldr	d5, [sp, #0x510]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x1a0]
               	rshrn	v0.4h, v3.4s, #0xf
               	ldr	d3, [sp, #0x530]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x1b0]
               	shrn	v0.2s, v2.2d, #0xf
               	ldur	d2, [x29, #-0x100]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x1c0]
               	uqrshrn	v0.2s, v4.2d, #0xf
               	ldur	d2, [x29, #-0xf0]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x1d0]
               	sqrshrn	v0.4h, v1.4s, #0xf
               	ldr	d1, [sp, #0x520]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x1e0]
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
               	sub	x2, x29, #0x140
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
               	sub	x2, x29, #0x110
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
               	sub	x2, x29, #0x4c0
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
               	sub	x2, x29, #0x4b0
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
               	sub	x2, x29, #0x4a0
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
               	sub	x2, x29, #0x490
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
               	sub	x2, x29, #0x480
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
               	sub	x2, x29, #0x470
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
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0xd0]
               	sqrshrn	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0xc8]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x8
               	stur	d2, [x29, #-0xc0]
               	uqrshrn	v1.8b, v1.8h, #0x8
               	stur	d1, [x29, #-0xb8]
               	sqshrun	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0xb0]
               	sqrshrun	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0xa8]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0xa0]
               	sqrshrn	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x98]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0x10
               	stur	d2, [x29, #-0x50]
               	uqrshrn	v2.4h, v3.4s, #0x10
               	stur	d2, [x29, #-0x48]
               	sqshrun	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x40]
               	sqrshrun	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x38]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x10
               	stur	d4, [x29, #-0x30]
               	sqrshrn	v4.2s, v2.2d, #0x10
               	stur	d4, [x29, #-0x28]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x10
               	stur	d5, [x29, #-0x20]
               	uqrshrn	v5.2s, v4.2d, #0x10
               	stur	d5, [x29, #-0x18]
               	sqshrun	v5.2s, v2.2d, #0x10
               	stur	d5, [x29, #-0x10]
               	sqrshrun	v5.2s, v2.2d, #0x10
               	stur	d5, [x29, #-0x8]
               	sqshrn	v5.8b, v0.8h, #0x8
               	ldur	d6, [x29, #-0xd0]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x1f0]
               	sqrshrun	v0.8b, v0.8h, #0x8
               	ldur	d5, [x29, #-0xb0]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x200]
               	rshrn	v0.4h, v3.4s, #0x10
               	ldur	d3, [x29, #-0x50]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x210]
               	shrn	v0.2s, v2.2d, #0x10
               	ldur	d2, [x29, #-0x30]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x220]
               	uqrshrn	v0.2s, v4.2d, #0x10
               	ldur	d2, [x29, #-0x20]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x230]
               	sqrshrn	v0.4h, v1.4s, #0x10
               	ldur	d1, [x29, #-0xa0]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x240]
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
               	cmp	w0, #0x8
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
               	sub	x0, x29, #0x50
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x48
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x30
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x28
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x460
               	mov	x20, #0x10              // =16
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x450
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x440
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x430
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x410
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x7
               	stur	d1, [x29, #-0x90]
               	sqrshrn	v1.8b, v0.8h, #0x7
               	stur	d1, [x29, #-0x88]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x7
               	stur	d2, [x29, #-0x80]
               	uqrshrn	v1.8b, v1.8h, #0x7
               	stur	d1, [x29, #-0x78]
               	sqshrun	v1.8b, v0.8h, #0x7
               	stur	d1, [x29, #-0x70]
               	sqrshrun	v1.8b, v0.8h, #0x7
               	stur	d1, [x29, #-0x68]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0xf
               	stur	d2, [x29, #-0x60]
               	sqrshrn	v2.4h, v1.4s, #0xf
               	stur	d2, [x29, #-0x58]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0xf
               	stur	d2, [x29, #-0x50]
               	uqrshrn	v2.4h, v3.4s, #0xf
               	stur	d2, [x29, #-0x48]
               	sqshrun	v2.4h, v1.4s, #0xf
               	stur	d2, [x29, #-0x40]
               	sqrshrun	v2.4h, v1.4s, #0xf
               	stur	d2, [x29, #-0x38]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x1f
               	stur	d4, [x29, #-0x30]
               	sqrshrn	v4.2s, v2.2d, #0x1f
               	stur	d4, [x29, #-0x28]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x1f
               	stur	d5, [x29, #-0x20]
               	uqrshrn	v5.2s, v4.2d, #0x1f
               	stur	d5, [x29, #-0x18]
               	sqshrun	v5.2s, v2.2d, #0x1f
               	stur	d5, [x29, #-0x10]
               	sqrshrun	v5.2s, v2.2d, #0x1f
               	stur	d5, [x29, #-0x8]
               	sqshrn	v5.8b, v0.8h, #0x7
               	ldur	d6, [x29, #-0x90]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x1f0]
               	sqrshrun	v0.8b, v0.8h, #0x7
               	ldur	d5, [x29, #-0x70]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x200]
               	rshrn	v0.4h, v3.4s, #0xf
               	ldur	d3, [x29, #-0x50]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x210]
               	shrn	v0.2s, v2.2d, #0x1f
               	ldur	d2, [x29, #-0x30]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x220]
               	uqrshrn	v0.2s, v4.2d, #0x1f
               	ldur	d2, [x29, #-0x20]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x230]
               	sqrshrn	v0.4h, v1.4s, #0xf
               	ldur	d1, [x29, #-0x60]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x240]
               	sub	x0, x29, #0x90
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x88
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x70
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x68
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x60
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x58
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x50
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x48
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x30
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x460
               	mov	x20, #0x10              // =16
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x450
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x440
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x430
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x410
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	ldr	q0, [sp, #0x2a0]
               	sqshrn	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0x90]
               	sqrshrn	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0x88]
               	ldr	q1, [sp, #0x270]
               	uqshrn	v2.8b, v1.8h, #0x8
               	stur	d2, [x29, #-0x80]
               	uqrshrn	v1.8b, v1.8h, #0x8
               	stur	d1, [x29, #-0x78]
               	sqshrun	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0x70]
               	sqrshrun	v1.8b, v0.8h, #0x8
               	stur	d1, [x29, #-0x68]
               	ldr	q1, [sp, #0x290]
               	sqshrn	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x60]
               	sqrshrn	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x58]
               	ldr	q3, [sp, #0x260]
               	uqshrn	v2.4h, v3.4s, #0x10
               	stur	d2, [x29, #-0x50]
               	uqrshrn	v2.4h, v3.4s, #0x10
               	stur	d2, [x29, #-0x48]
               	sqshrun	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x40]
               	sqrshrun	v2.4h, v1.4s, #0x10
               	stur	d2, [x29, #-0x38]
               	ldr	q2, [sp, #0x280]
               	sqshrn	v4.2s, v2.2d, #0x20
               	stur	d4, [x29, #-0x30]
               	sqrshrn	v4.2s, v2.2d, #0x20
               	stur	d4, [x29, #-0x28]
               	ldr	q4, [sp, #0x250]
               	uqshrn	v5.2s, v4.2d, #0x20
               	stur	d5, [x29, #-0x20]
               	uqrshrn	v5.2s, v4.2d, #0x20
               	stur	d5, [x29, #-0x18]
               	sqshrun	v5.2s, v2.2d, #0x20
               	stur	d5, [x29, #-0x10]
               	sqrshrun	v5.2s, v2.2d, #0x20
               	stur	d5, [x29, #-0x8]
               	sqshrn	v5.8b, v0.8h, #0x8
               	ldur	d6, [x29, #-0x90]
               	zip1	v5.2d, v6.2d, v5.2d
               	str	q5, [sp, #0x1f0]
               	sqrshrun	v0.8b, v0.8h, #0x8
               	ldur	d5, [x29, #-0x70]
               	zip1	v0.2d, v5.2d, v0.2d
               	str	q0, [sp, #0x200]
               	rshrn	v0.4h, v3.4s, #0x10
               	ldur	d3, [x29, #-0x50]
               	zip1	v0.2d, v3.2d, v0.2d
               	str	q0, [sp, #0x210]
               	shrn	v0.2s, v2.2d, #0x20
               	ldur	d2, [x29, #-0x30]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x220]
               	uqrshrn	v0.2s, v4.2d, #0x20
               	ldur	d2, [x29, #-0x20]
               	zip1	v0.2d, v2.2d, v0.2d
               	str	q0, [sp, #0x230]
               	sqrshrn	v0.4h, v1.4s, #0x10
               	ldur	d1, [x29, #-0x60]
               	zip1	v0.2d, v1.2d, v0.2d
               	str	q0, [sp, #0x240]
               	sub	x0, x29, #0x90
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x88
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x78
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x70
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x68
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x60
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x58
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x50
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x48
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x30
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x28
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x18
               	mov	x20, #0x8               // =8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x8
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x460
               	mov	x20, #0x10              // =16
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x450
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x440
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x430
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x420
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x410
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x12c
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x4dca            // =19914
               	movk	x17, #0x47c0, lsl #16
               	movk	x17, #0x84e4, lsl #32
               	movk	x17, #0x87a6, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x650
               	ldp	x29, x30, [sp], #0x10
               	ret
