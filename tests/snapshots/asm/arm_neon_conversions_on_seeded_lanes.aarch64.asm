
arm_neon_conversions_on_seeded_lanes.aarch64:	file format elf64-littleaarch64

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

<i32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x0                // =0
               	mov	x3, #0x3e8              // =1000
               	mov	x4, #0xf7cf             // =63439
               	movk	x4, #0xe353, lsl #16
               	movk	x4, #0x9ba5, lsl #32
               	movk	x4, #0x20c4, lsl #48
               	adrp	x0, <page>
               	b	<addr>
               	str	w2, [x5, x1, lsl #2]
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.ge	<addr>
               	sub	x5, x29, #0x10
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	tbz	w2, #0x0, <addr>
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
               	lsr	x6, x2, #3
               	umulh	x6, x6, x4
               	lsr	x6, x6, #4
               	mul	x6, x6, x3
               	sub	x2, x2, x6
               	sub	x2, x2, #0x1f4
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
               	mov	x3, #0xc350             // =50000
               	mov	x4, #0x86a0             // =34464
               	movk	x4, #0x1, lsl #16
               	mov	x5, #0x7843             // =30787
               	movk	x5, #0x71b4, lsl #16
               	movk	x5, #0x5ac4, lsl #32
               	movk	x5, #0xa7c, lsl #48
               	adrp	x0, <page>
               	b	<addr>
               	str	x2, [x6, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.ge	<addr>
               	sub	x6, x29, #0x10
               	ldr	x2, [x0, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x0, #0x10]
               	tbz	w2, #0x0, <addr>
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
               	lsr	x7, x2, #5
               	umulh	x7, x7, x5
               	lsr	x7, x7, #7
               	mul	x7, x7, x4
               	sub	x2, x2, x7
               	sub	x2, x2, x3
               	b	<addr>
               	ldur	q0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x480
               	stp	d8, d9, [sp]
               	stp	x20, x21, [sp, #0x10]
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	mov	v2.16b, v0.16b
               	str	q2, [sp, #0x2b0]
               	bl	<addr>
               	ldr	q2, [sp, #0x2b0]
               	fmov	d9, d0
               	str	q2, [sp, #0x2b0]
               	bl	<addr>
               	ldr	q2, [sp, #0x2b0]
               	fmov	d16, x0
               	str	q16, [sp, #0x2f0]
               	str	q2, [sp, #0x2b0]
               	bl	<addr>
               	ldr	q2, [sp, #0x2b0]
               	ldr	q1, [sp, #0x2f0]
               	mov	v1.d[1], x0
               	str	q2, [sp, #0x2b0]
               	str	q1, [sp, #0x2c0]
               	bl	<addr>
               	ldr	q2, [sp, #0x2b0]
               	ldr	q1, [sp, #0x2c0]
               	stur	x0, [x29, #-0x8]
               	fmov	d8, x0
               	str	q2, [sp, #0x2b0]
               	str	q1, [sp, #0x2c0]
               	bl	<addr>
               	ldr	q2, [sp, #0x2b0]
               	ldr	q1, [sp, #0x2c0]
               	mov	v3.16b, v0.16b
               	str	q2, [sp, #0x2b0]
               	str	q1, [sp, #0x2c0]
               	str	q3, [sp, #0x2e0]
               	bl	<addr>
               	ldr	q2, [sp, #0x2b0]
               	ldr	q1, [sp, #0x2c0]
               	ldr	q3, [sp, #0x2e0]
               	tbz	w20, #0x0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q4, [x0]
               	fmul	v2.4s, v2.4s, v4.4s
               	adrp	x0, <addr>
               	ldr	d4, [x0, #0x118]
               	fmul	v9.2s, v9.2s, v4.2s
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	q4, [x0]
               	fmul	v1.2d, v1.2d, v4.2d
               	adrp	x0, <addr>
               	ldr	d4, [x0, #0x130]
               	fmul	d8, d8, d4
               	mov	x0, #0x1f               // =31
               	str	q3, [sp, #0x2e0]
               	str	q0, [sp, #0x2d0]
               	str	q1, [sp, #0x2c0]
               	str	q2, [sp, #0x2b0]
               	bl	<addr>
               	ldr	q3, [sp, #0x2e0]
               	ldr	q0, [sp, #0x2d0]
               	ldr	q1, [sp, #0x2c0]
               	ldr	q2, [sp, #0x2b0]
               	fcvtzs	v4.2s, v9.2s
               	sub	x2, x29, #0x178
               	str	d4, [sp, #0x308]
               	fcvtzs	v4.4s, v2.4s
               	str	q4, [sp, #0x20]
               	fcvtzu	v4.2s, v9.2s
               	str	d4, [sp, #0x310]
               	fcvtzu	v4.4s, v2.4s
               	str	q4, [sp, #0x30]
               	fcvtzs	v4.2d, v1.2d
               	str	q4, [sp, #0x40]
               	fcvtzu	v4.2d, v1.2d
               	str	q4, [sp, #0x50]
               	fcvtzs	x0, d8
               	str	x0, [sp, #0x318]
               	fcvtzu	x0, d8
               	str	x0, [sp, #0x320]
               	mov	s4, v2.s[1]
               	mov	x0, #0x0                // =0
               	fmov	s4, s4
               	fcvtzs	v4.2s, v4.2s
               	smov	x1, v4.s[0]
               	stur	w1, [x29, #-0xd8]
               	mov	s4, v2.s[2]
               	fmov	s4, s4
               	fcvtzu	v4.2s, v4.2s
               	mov	w1, v4.s[0]
               	stur	w1, [x29, #-0xd0]
               	mov	d4, v1.d[1]
               	fcvtzs	x1, d4
               	stur	x1, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtzu	x1, d4
               	stur	x1, [x29, #-0x10]
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
               	sub	x2, x29, #0x460
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x450
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x440
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x430
               	mov	x0, #0x0                // =0
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
               	cmp	w0, #0x4
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
               	fcvtns	v4.2s, v9.2s
               	sub	x2, x29, #0x158
               	str	d4, [sp, #0x328]
               	fcvtns	v4.4s, v2.4s
               	str	q4, [sp, #0x60]
               	fcvtnu	v4.2s, v9.2s
               	str	d4, [sp, #0x330]
               	fcvtnu	v4.4s, v2.4s
               	str	q4, [sp, #0x70]
               	fcvtns	v4.2d, v1.2d
               	str	q4, [sp, #0x80]
               	fcvtnu	v4.2d, v1.2d
               	str	q4, [sp, #0x90]
               	fcvtns	d4, d8
               	str	d4, [sp, #0x338]
               	fcvtnu	d4, d8
               	str	d4, [sp, #0x340]
               	mov	s4, v2.s[1]
               	mov	x0, #0x0                // =0
               	fmov	s4, s4
               	fcvtns	v4.2s, v4.2s
               	smov	x1, v4.s[0]
               	stur	w1, [x29, #-0xd8]
               	mov	s4, v2.s[2]
               	fmov	s4, s4
               	fcvtnu	v4.2s, v4.2s
               	mov	w1, v4.s[0]
               	stur	w1, [x29, #-0xd0]
               	mov	d4, v1.d[1]
               	fcvtns	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtnu	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	fcvtms	v4.2s, v9.2s
               	sub	x2, x29, #0x138
               	str	d4, [sp, #0x348]
               	fcvtms	v4.4s, v2.4s
               	str	q4, [sp, #0xa0]
               	fcvtmu	v4.2s, v9.2s
               	str	d4, [sp, #0x350]
               	fcvtmu	v4.4s, v2.4s
               	str	q4, [sp, #0xb0]
               	fcvtms	v4.2d, v1.2d
               	str	q4, [sp, #0xc0]
               	fcvtmu	v4.2d, v1.2d
               	str	q4, [sp, #0xd0]
               	fcvtms	d4, d8
               	str	d4, [sp, #0x358]
               	fcvtmu	d4, d8
               	str	d4, [sp, #0x360]
               	mov	s4, v2.s[1]
               	mov	x0, #0x0                // =0
               	fmov	s4, s4
               	fcvtms	v4.2s, v4.2s
               	smov	x1, v4.s[0]
               	stur	w1, [x29, #-0xd8]
               	mov	s4, v2.s[2]
               	fmov	s4, s4
               	fcvtmu	v4.2s, v4.2s
               	mov	w1, v4.s[0]
               	stur	w1, [x29, #-0xd0]
               	mov	d4, v1.d[1]
               	fcvtms	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtmu	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	fcvtps	v4.2s, v9.2s
               	sub	x2, x29, #0x118
               	str	d4, [sp, #0x368]
               	fcvtps	v4.4s, v2.4s
               	str	q4, [sp, #0xe0]
               	fcvtpu	v4.2s, v9.2s
               	str	d4, [sp, #0x370]
               	fcvtpu	v4.4s, v2.4s
               	str	q4, [sp, #0xf0]
               	fcvtps	v4.2d, v1.2d
               	str	q4, [sp, #0x100]
               	fcvtpu	v4.2d, v1.2d
               	str	q4, [sp, #0x110]
               	fcvtps	d4, d8
               	str	d4, [sp, #0x378]
               	fcvtpu	d4, d8
               	stur	d4, [x29, #-0x100]
               	mov	s4, v2.s[1]
               	mov	x0, #0x0                // =0
               	fmov	s4, s4
               	fcvtps	v4.2s, v4.2s
               	smov	x1, v4.s[0]
               	stur	w1, [x29, #-0xd8]
               	mov	s4, v2.s[2]
               	fmov	s4, s4
               	fcvtpu	v4.2s, v4.2s
               	mov	w1, v4.s[0]
               	stur	w1, [x29, #-0xd0]
               	mov	d4, v1.d[1]
               	fcvtps	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtpu	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	fcvtas	v4.2s, v9.2s
               	sub	x2, x29, #0xf8
               	stur	d4, [x29, #-0xf8]
               	fcvtas	v4.4s, v2.4s
               	str	q4, [sp, #0x120]
               	fcvtau	v4.2s, v9.2s
               	stur	d4, [x29, #-0xf0]
               	fcvtau	v4.4s, v2.4s
               	str	q4, [sp, #0x130]
               	fcvtas	v4.2d, v1.2d
               	str	q4, [sp, #0x140]
               	fcvtau	v4.2d, v1.2d
               	str	q4, [sp, #0x150]
               	fcvtas	d4, d8
               	stur	d4, [x29, #-0xe8]
               	fcvtau	d4, d8
               	stur	d4, [x29, #-0xe0]
               	mov	s4, v2.s[1]
               	mov	x0, #0x0                // =0
               	fmov	s4, s4
               	fcvtas	v4.2s, v4.2s
               	smov	x1, v4.s[0]
               	stur	w1, [x29, #-0xd8]
               	mov	s4, v2.s[2]
               	fmov	s4, s4
               	fcvtau	v4.2s, v4.2s
               	mov	w1, v4.s[0]
               	stur	w1, [x29, #-0xd0]
               	mov	d4, v1.d[1]
               	fcvtas	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtau	d4, d4
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	scvtf	v4.4s, v3.4s, #0x1
               	sub	x2, x29, #0x320
               	str	q4, [sp, #0x160]
               	mov	d4, v3.d[0]
               	ucvtf	v4.2s, v4.2s, #0x1
               	stur	d4, [x29, #-0xc8]
               	scvtf	v4.2d, v0.2d, #0x1
               	str	q4, [sp, #0x170]
               	mov	d4, v0.d[1]
               	ucvtf	d4, d4, #0x1
               	stur	d4, [x29, #-0xc0]
               	fcvtzs	v4.4s, v2.4s, #0x1
               	str	q4, [sp, #0x180]
               	fcvtzu	v4.2s, v9.2s, #0x1
               	stur	d4, [x29, #-0xb8]
               	fcvtzs	v4.2d, v1.2d, #0x1
               	str	q4, [sp, #0x190]
               	fcvtzu	d4, d8, #0x1
               	stur	d4, [x29, #-0xb0]
               	mov	x0, #0x0                // =0
               	smov	x1, v3.s[0]
               	fmov	s4, w1
               	scvtf	v4.2s, v4.2s, #0x1
               	stur	s4, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtzs	d4, d4, #0x1
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	scvtf	v4.4s, v3.4s, #0x8
               	sub	x2, x29, #0x2e0
               	str	q4, [sp, #0x1a0]
               	mov	d4, v3.d[0]
               	ucvtf	v4.2s, v4.2s, #0x8
               	stur	d4, [x29, #-0xa8]
               	scvtf	v4.2d, v0.2d, #0x8
               	str	q4, [sp, #0x1b0]
               	mov	d4, v0.d[1]
               	ucvtf	d4, d4, #0x8
               	stur	d4, [x29, #-0xa0]
               	fcvtzs	v4.4s, v2.4s, #0x8
               	str	q4, [sp, #0x1c0]
               	fcvtzu	v4.2s, v9.2s, #0x8
               	stur	d4, [x29, #-0x98]
               	fcvtzs	v4.2d, v1.2d, #0x8
               	str	q4, [sp, #0x1d0]
               	fcvtzu	d4, d8, #0x8
               	stur	d4, [x29, #-0x90]
               	mov	x0, #0x0                // =0
               	smov	x1, v3.s[0]
               	fmov	s4, w1
               	scvtf	v4.2s, v4.2s, #0x8
               	stur	s4, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtzs	d4, d4, #0x8
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	scvtf	v4.4s, v3.4s, #0x10
               	sub	x2, x29, #0x2a0
               	str	q4, [sp, #0x1e0]
               	mov	d4, v3.d[0]
               	ucvtf	v4.2s, v4.2s, #0x10
               	stur	d4, [x29, #-0x88]
               	scvtf	v4.2d, v0.2d, #0x10
               	str	q4, [sp, #0x1f0]
               	mov	d4, v0.d[1]
               	ucvtf	d4, d4, #0x10
               	stur	d4, [x29, #-0x80]
               	fcvtzs	v4.4s, v2.4s, #0x10
               	str	q4, [sp, #0x200]
               	fcvtzu	v4.2s, v9.2s, #0x10
               	stur	d4, [x29, #-0x78]
               	fcvtzs	v4.2d, v1.2d, #0x10
               	str	q4, [sp, #0x210]
               	fcvtzu	d4, d8, #0x10
               	stur	d4, [x29, #-0x70]
               	mov	x0, #0x0                // =0
               	smov	x1, v3.s[0]
               	fmov	s4, w1
               	scvtf	v4.2s, v4.2s, #0x10
               	stur	s4, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtzs	d4, d4, #0x10
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	scvtf	v4.4s, v3.4s, #0x20
               	sub	x2, x29, #0x260
               	str	q4, [sp, #0x220]
               	mov	d4, v3.d[0]
               	ucvtf	v4.2s, v4.2s, #0x20
               	stur	d4, [x29, #-0x68]
               	scvtf	v4.2d, v0.2d, #0x20
               	str	q4, [sp, #0x230]
               	mov	d4, v0.d[1]
               	ucvtf	d4, d4, #0x20
               	stur	d4, [x29, #-0x60]
               	fcvtzs	v4.4s, v2.4s, #0x20
               	str	q4, [sp, #0x240]
               	fcvtzu	v4.2s, v9.2s, #0x20
               	stur	d4, [x29, #-0x58]
               	fcvtzs	v4.2d, v1.2d, #0x20
               	str	q4, [sp, #0x250]
               	fcvtzu	d4, d8, #0x20
               	stur	d4, [x29, #-0x50]
               	mov	x0, #0x0                // =0
               	smov	x1, v3.s[0]
               	fmov	s4, w1
               	scvtf	v4.2s, v4.2s, #0x20
               	stur	s4, [x29, #-0x20]
               	mov	d4, v1.d[0]
               	fcvtzs	d4, d4, #0x20
               	mov	x1, v4.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	scvtf	v4.4s, v3.4s, #0x20
               	sub	x2, x29, #0x220
               	str	q4, [sp, #0x260]
               	mov	d4, v3.d[0]
               	ucvtf	v4.2s, v4.2s, #0x20
               	stur	d4, [x29, #-0x48]
               	scvtf	v4.2d, v0.2d, #0x40
               	str	q4, [sp, #0x270]
               	mov	d4, v0.d[1]
               	ucvtf	d4, d4, #0x40
               	stur	d4, [x29, #-0x40]
               	fcvtzs	v2.4s, v2.4s, #0x20
               	str	q2, [sp, #0x280]
               	fcvtzu	v2.2s, v9.2s, #0x20
               	stur	d2, [x29, #-0x38]
               	fcvtzs	v2.2d, v1.2d, #0x40
               	str	q2, [sp, #0x290]
               	fcvtzu	d2, d8, #0x40
               	stur	d2, [x29, #-0x30]
               	mov	x0, #0x0                // =0
               	smov	x1, v3.s[0]
               	fmov	s2, w1
               	scvtf	v2.2s, v2.2s, #0x20
               	stur	s2, [x29, #-0x20]
               	fcvtzs	d1, d1, #0x40
               	mov	x1, v1.d[0]
               	stur	x1, [x29, #-0x10]
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
               	cmp	w0, #0x4
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
               	scvtf	v1.4s, v3.4s
               	sub	x2, x29, #0x1e0
               	str	q1, [sp, #0x2a0]
               	mov	d1, v0.d[0]
               	mov	x0, v1.d[0]
               	scvtf	d1, x0
               	stur	d1, [x29, #-0x28]
               	smov	x0, v3.s[1]
               	mov	w0, w0
               	scvtf	s1, x0
               	stur	s1, [x29, #-0x20]
               	mov	x0, v0.d[1]
               	ucvtf	d0, x0
               	stur	d0, [x29, #-0x18]
               	mov	x0, #0x0                // =0
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
               	cmp	w0, #0x4
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
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x21, eq
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x21, x21, x0, lsl #1
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x21, x21, x0, lsl #2
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x21, x21, x0, lsl #3
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	w0, #0x0
               	cset	x0, eq
               	orr	x0, x21, x0, lsl #4
               	stur	w0, [x29, #-0x10]
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
               	cmp	w0, #0x4
               	b.lo	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x1f4
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0xdf7             // =3575
               	movk	x17, #0x5164, lsl #16
               	movk	x17, #0xcaee, lsl #32
               	movk	x17, #0xba11, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp]
               	add	sp, sp, #0x480
               	ldp	x29, x30, [sp], #0x10
               	ret
