
arm_neon_scalar_forms_on_seeded_values.aarch64:	file format elf64-littleaarch64

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

<rnd>:
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	ret

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

<ri>:
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	and	x2, x0, #0x7
               	cmp	w2, #0x1
               	b.lo	<addr>
               	cmp	w2, #0x2
               	b.lo	<addr>
               	cmp	w2, #0x2
               	b.eq	<addr>
               	ldr	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsl #13
               	eor	x0, x0, x0, lsr #7
               	eor	x0, x0, x0, lsl #17
               	str	x0, [x1, #0x10]
               	ret
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ret
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	ret
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	ret

<rf>:
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

<rd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	fmov	d0, x0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0x70]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	stp	x24, x25, [sp, #0x30]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x21, #0x0               // =0
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	ldr	x2, [x1, #0x10]
               	eor	x2, x2, x2, lsl #13
               	eor	x2, x2, x2, lsr #7
               	eor	x2, x2, x2, lsl #17
               	str	x2, [x1, #0x10]
               	and	x1, x2, #0xff
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	q0, [x0]
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w1
               	sqabs	v0.8b, v0.8b
               	smov	x1, v0.b[0]
               	sxtb	x1, w1
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w1
               	sqneg	v0.8b, v0.8b
               	smov	x1, v0.b[0]
               	sxtb	x1, w1
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x20, w0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	sqadd	v0.8b, v0.8b, v1.8b
               	smov	x1, v0.b[0]
               	sxtb	x1, w1
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xff
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x1, x0, #0xff
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	uqadd	v0.8b, v0.8b, v1.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x20, w0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	sqsub	v0.8b, v0.8b, v1.8b
               	smov	x1, v0.b[0]
               	sxtb	x1, w1
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xff
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x1, x0, #0xff
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	uqsub	v0.8b, v0.8b, v1.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x20, w0
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x8ba3             // =35747
               	movk	x2, #0xba2e, lsl #16
               	movk	x2, #0xa2e8, lsl #32
               	movk	x2, #0x2e8b, lsl #48
               	umulh	x1, x1, x2
               	lsr	x1, x1, #1
               	mov	x17, #0x16              // =22
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x8
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	sqshl	v0.8b, v0.8b, v1.8b
               	smov	x1, v0.b[0]
               	sxtb	x1, w1
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xff
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x8ba3             // =35747
               	movk	x2, #0xba2e, lsl #16
               	movk	x2, #0xa2e8, lsl #32
               	movk	x2, #0x2e8b, lsl #48
               	umulh	x1, x1, x2
               	lsr	x1, x1, #1
               	mov	x17, #0x16              // =22
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x8
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	uqshl	v0.8b, v0.8b, v1.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x20, w0
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x8ba3             // =35747
               	movk	x2, #0xba2e, lsl #16
               	movk	x2, #0xa2e8, lsl #32
               	movk	x2, #0x2e8b, lsl #48
               	umulh	x1, x1, x2
               	lsr	x1, x1, #1
               	mov	x17, #0x16              // =22
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x8
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	sqrshl	v0.8b, v0.8b, v1.8b
               	smov	x1, v0.b[0]
               	sxtb	x1, w1
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xff
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x8ba3             // =35747
               	movk	x2, #0xba2e, lsl #16
               	movk	x2, #0xa2e8, lsl #32
               	movk	x2, #0x2e8b, lsl #48
               	umulh	x1, x1, x2
               	lsr	x1, x1, #1
               	mov	x17, #0x16              // =22
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x8
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.b[0], w20
               	fmov	d1, x0
               	mov	v1.b[0], w1
               	uqrshl	v0.8b, v0.8b, v1.8b
               	umov	w1, v0.b[0]
               	and	x1, x1, #0xff
               	sturb	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x0, w0
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	sqshl	v0.8b, v0.8b, #0x0
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x0, w0
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	sqshl	v0.8b, v0.8b, #0x4
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x0, w0
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	sqshl	v0.8b, v0.8b, #0x7
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x0, x0, #0xff
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	uqshl	v0.8b, v0.8b, #0x0
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x0, x0, #0xff
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	uqshl	v0.8b, v0.8b, #0x4
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x0, x0, #0xff
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	uqshl	v0.8b, v0.8b, #0x7
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x0, w0
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	sqshlu	v0.8b, v0.8b, #0x0
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxtb	x0, w0
               	fmov	d0, x20
               	mov	v0.b[0], w0
               	sqshlu	v0.8b, v0.8b, #0x7
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x18]
               	ldrb	w3, [x1, x20]
               	eor	x2, x2, x3
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x2, x2, x17
               	str	x2, [x0, #0x18]
               	mov	x20, #0x1               // =1
               	cmp	w20, #0x1
               	b.lo	<addr>
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w1
               	sqabs	v0.4h, v0.4h
               	smov	x1, v0.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w1
               	sqneg	v0.4h, v0.4h
               	smov	x1, v0.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x20, w0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	sqadd	v0.4h, v0.4h, v1.4h
               	smov	x1, v0.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xffff
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x1, x0, #0xffff
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	uqadd	v0.4h, v0.4h, v1.4h
               	umov	w1, v0.h[0]
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x20, w0
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x1, w0
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	sqsub	v0.4h, v0.4h, v1.4h
               	smov	x1, v0.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xffff
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x1, x0, #0xffff
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	uqsub	v0.4h, v0.4h, v1.4h
               	umov	w1, v0.h[0]
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x20, w0
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x9436             // =37942
               	movk	x2, #0x50d7, lsl #16
               	movk	x2, #0x435e, lsl #32
               	movk	x2, #0xd79, lsl #48
               	umulh	x1, x1, x2
               	mov	x17, #0x26              // =38
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x10
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	sqshl	v0.4h, v0.4h, v1.4h
               	smov	x1, v0.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xffff
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x9436             // =37942
               	movk	x2, #0x50d7, lsl #16
               	movk	x2, #0x435e, lsl #32
               	movk	x2, #0xd79, lsl #48
               	umulh	x1, x1, x2
               	mov	x17, #0x26              // =38
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x10
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	uqshl	v0.4h, v0.4h, v1.4h
               	umov	w1, v0.h[0]
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	sxth	x20, w0
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x9436             // =37942
               	movk	x2, #0x50d7, lsl #16
               	movk	x2, #0x435e, lsl #32
               	movk	x2, #0xd79, lsl #48
               	umulh	x1, x1, x2
               	mov	x17, #0x26              // =38
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x10
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	sqrshl	v0.4h, v0.4h, v1.4h
               	smov	x1, v0.h[0]
               	sxth	x1, w1
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	bl	<addr>
               	and	x1, x0, #0x7
               	cmp	w1, #0x1
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.lo	<addr>
               	cmp	w1, #0x2
               	b.eq	<addr>
               	bl	<addr>
               	and	x20, x0, #0xffff
               	bl	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x9436             // =37942
               	movk	x2, #0x50d7, lsl #16
               	movk	x2, #0x435e, lsl #32
               	movk	x2, #0xd79, lsl #48
               	umulh	x1, x1, x2
               	mov	x17, #0x26              // =38
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x10
               	sub	x1, x0, #0x3
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	mov	v0.h[0], w20
               	fmov	d1, x0
               	mov	v1.h[0], w1
               	uqrshl	v0.4h, v0.4h, v1.4h
               	umov	w1, v0.h[0]
               	and	x1, x1, #0xffff
               	sturh	w1, [x29, #-0x8]
               	sub	x2, x29, #0x8
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
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	lsr	x0, x0, #8
               	mov	x1, #0x2493             // =9363
               	movk	x1, #0x9249, lsl #16
               	movk	x1, #0x4924, lsl #32
               	movk	x1, #0x2492, lsl #48
               	umulh	x1, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x1, #-0x8000000000000000 // =-9223372036854775808
               	ubfx	x0, x0, #8, #6
               	lsr	x0, x1, x0
               	b	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	sqshl	v0.4h, v0.4h, #0x0
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	sqshl	v0.4h, v0.4h, #0x8
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	sqshl	v0.4h, v0.4h, #0xf
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	uqshl	v0.4h, v0.4h, #0x0
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	uqshl	v0.4h, v0.4h, #0x8
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	uqshl	v0.4h, v0.4h, #0xf
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	sqshlu	v0.4h, v0.4h, #0x0
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	sqshlu	v0.4h, v0.4h, #0xf
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqabs	v0.2s, v0.2s
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqneg	v0.2s, v0.2s
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	s0, w22
               	fmov	s1, w0
               	sqadd	v0.2s, v0.2s, v1.2s
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	s0, w22
               	fmov	s1, w0
               	uqadd	v0.2s, v0.2s, v1.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x24, x0
               	bl	<addr>
               	fmov	s0, w24
               	fmov	s1, w0
               	sqsub	v0.2s, v0.2s, v1.2s
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	s0, w22
               	fmov	s1, w0
               	uqsub	v0.2s, v0.2s, v1.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x25, x0
               	bl	<addr>
               	mov	x24, #0x46              // =70
               	lsr	x1, x0, #1
               	mov	x20, #0xea1             // =3745
               	movk	x20, #0xa0ea, lsl #16
               	movk	x20, #0xea0e, lsl #32
               	movk	x20, #0xea0, lsl #48
               	umulh	x1, x1, x20
               	lsr	x1, x1, #1
               	msub	x0, x1, x24, x0
               	sub	x0, x0, #0x20
               	sub	x1, x0, #0x3
               	fmov	s0, w25
               	fmov	s1, w1
               	sqshl	v0.2s, v0.2s, v1.2s
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #1
               	msub	x0, x1, x24, x0
               	sub	x0, x0, #0x20
               	sub	x0, x0, #0x3
               	fmov	s0, w23
               	fmov	s1, w0
               	uqshl	v0.2s, v0.2s, v1.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	bl	<addr>
               	mov	x24, x0
               	bl	<addr>
               	mov	x23, #0x46              // =70
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #1
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x20
               	sub	x0, x0, #0x3
               	fmov	s0, w24
               	fmov	s1, w0
               	sqrshl	v0.2s, v0.2s, v1.2s
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #1
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x20
               	sub	x0, x0, #0x3
               	fmov	s0, w22
               	fmov	s1, w0
               	uqrshl	v0.2s, v0.2s, v1.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshl	v0.2s, v0.2s, #0x0
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshl	v0.2s, v0.2s, #0x10
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshl	v0.2s, v0.2s, #0x1f
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqshl	v0.2s, v0.2s, #0x0
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqshl	v0.2s, v0.2s, #0x10
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqshl	v0.2s, v0.2s, #0x1f
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshlu	v0.2s, v0.2s, #0x0
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshlu	v0.2s, v0.2s, #0x1f
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x1, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqabs	d0, d0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqneg	d0, d0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	sqadd	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	fmov	d0, x20
               	fmov	d1, x0
               	uqadd	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	sqsub	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	fmov	d0, x20
               	fmov	d1, x0
               	uqsub	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x25, x0
               	bl	<addr>
               	mov	x24, #0x86              // =134
               	lsr	x1, x0, #1
               	mov	x20, #0x9ca9            // =40105
               	movk	x20, #0xc2dd, lsl #16
               	movk	x20, #0xc6af, lsl #32
               	movk	x20, #0x7a44, lsl #48
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x24, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x25
               	fmov	d1, x0
               	sqshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x24, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x22
               	fmov	d1, x0
               	uqshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x24, x0
               	bl	<addr>
               	mov	x23, #0x86              // =134
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x24
               	fmov	d1, x0
               	sqrshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x22
               	fmov	d1, x0
               	uqrshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshl	d0, d0, #0x0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshl	d0, d0, #0x20
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshl	d0, d0, #0x3f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqshl	d0, d0, #0x0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqshl	d0, d0, #0x20
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqshl	d0, d0, #0x3f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshlu	d0, d0, #0x0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshlu	d0, d0, #0x3f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	mov	x23, #0x0               // =0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	sqxtn	v0.8b, v0.8h
               	smov	x0, v0.b[0]
               	sxtb	x0, w0
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	sqshrn	v0.8b, v0.8h, #0x1
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	sqshrn	v0.8b, v0.8h, #0x8
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x23, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	sqrshrn	v0.8b, v0.8h, #0x1
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	sqrshrn	v0.8b, v0.8h, #0x8
               	smov	x0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	and	x0, x0, #0xffff
               	mov	x23, #0x0               // =0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	uqxtn	v0.8b, v0.8h
               	umov	w0, v0.b[0]
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	uqshrn	v0.8b, v0.8h, #0x1
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	uqshrn	v0.8b, v0.8h, #0x8
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x23, #0x0               // =0
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	uqrshrn	v0.8b, v0.8h, #0x1
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	and	x0, x0, #0xffff
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	uqrshrn	v0.8b, v0.8h, #0x8
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	mov	x23, #0x0               // =0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	sqxtun	v0.8b, v0.8h
               	umov	w0, v0.b[0]
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	sqshrun	v0.8b, v0.8h, #0x1
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	sqshrun	v0.8b, v0.8h, #0x8
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x23, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x23
               	mov	v0.h[0], w0
               	sqrshrun	v0.8b, v0.8h, #0x1
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	sqrshrun	v0.8b, v0.8h, #0x8
               	umov	w0, v0.b[0]
               	sturb	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqxtn	v0.4h, v0.4s
               	smov	x0, v0.h[0]
               	sxth	x0, w0
               	sturh	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshrn	v0.4h, v0.4s, #0x1
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshrn	v0.4h, v0.4s, #0x10
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqrshrn	v0.4h, v0.4s, #0x1
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqrshrn	v0.4h, v0.4s, #0x10
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqxtn	v0.4h, v0.4s
               	umov	w0, v0.h[0]
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqshrn	v0.4h, v0.4s, #0x1
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqshrn	v0.4h, v0.4s, #0x10
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqrshrn	v0.4h, v0.4s, #0x1
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	uqrshrn	v0.4h, v0.4s, #0x10
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqxtun	v0.4h, v0.4s
               	umov	w0, v0.h[0]
               	and	x0, x0, #0xffff
               	sturh	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshrun	v0.4h, v0.4s, #0x1
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqshrun	v0.4h, v0.4s, #0x10
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqrshrun	v0.4h, v0.4s, #0x1
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	sqrshrun	v0.4h, v0.4s, #0x10
               	umov	w0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqxtn	v0.2s, v0.2d
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshrn	v0.2s, v0.2d, #0x1
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshrn	v0.2s, v0.2d, #0x20
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqrshrn	v0.2s, v0.2d, #0x1
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqrshrn	v0.2s, v0.2d, #0x20
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqxtn	v0.2s, v0.2d
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqshrn	v0.2s, v0.2d, #0x1
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqshrn	v0.2s, v0.2d, #0x20
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqrshrn	v0.2s, v0.2d, #0x1
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	uqrshrn	v0.2s, v0.2d, #0x20
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqxtun	v0.2s, v0.2d
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshrun	v0.2s, v0.2d, #0x1
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqshrun	v0.2s, v0.2d, #0x20
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqrshrun	v0.2s, v0.2d, #0x1
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sqrshrun	v0.2s, v0.2d, #0x20
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	abs	d0, d0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	neg	d0, d0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	add	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	sub	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	cmeq	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	cmge	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	cmgt	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x23
               	cmge	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x22
               	cmgt	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	cmtst	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	ldr	q0, [sp, #0x40]
               	mov	v0.d[1], x0
               	addp	v0.2d, v0.2d, v0.2d
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x24, x0
               	bl	<addr>
               	mov	x23, #0x86              // =134
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x24
               	fmov	d1, x0
               	srshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x22
               	fmov	d1, x0
               	sshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	shl	d0, d0, #0x0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	shl	d0, d0, #0x1f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	shl	d0, d0, #0x3f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sshr	d0, d0, #0x1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sshr	d0, d0, #0x21
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	sshr	d0, d0, #0x40
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	srshr	d0, d0, #0x1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	srshr	d0, d0, #0x21
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	srshr	d0, d0, #0x40
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	ssra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	ssra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	srsra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	srsra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sri	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sri	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sli	d16, d0, #0x0
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sli	d16, d0, #0x3f
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	add	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	sub	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	cmeq	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	cmhs	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x22
               	fmov	d1, x0
               	cmhi	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x23
               	cmhs	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x22
               	cmhi	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x23, x0
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x0
               	cmtst	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	ldr	q0, [sp, #0x40]
               	mov	v0.d[1], x0
               	addp	v0.2d, v0.2d, v0.2d
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	mov	x24, x0
               	bl	<addr>
               	mov	x23, #0x86              // =134
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x24
               	fmov	d1, x0
               	urshl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	mov	x0, x22
               	bl	<addr>
               	bl	<addr>
               	mov	x22, x0
               	bl	<addr>
               	lsr	x1, x0, #1
               	umulh	x1, x1, x20
               	lsr	x1, x1, #5
               	msub	x0, x1, x23, x0
               	sub	x0, x0, #0x40
               	sub	x0, x0, #0x3
               	fmov	d0, x22
               	fmov	d1, x0
               	ushl	d0, d0, d1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	shl	d0, d0, #0x0
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	shl	d0, d0, #0x1f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	shl	d0, d0, #0x3f
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	ushr	d0, d0, #0x1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	ushr	d0, d0, #0x21
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	ushr	d0, d0, #0x40
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	urshr	d0, d0, #0x1
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	urshr	d0, d0, #0x21
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d0, x0
               	urshr	d0, d0, #0x40
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	usra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	usra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	ursra	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	ursra	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sri	d16, d0, #0x1
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sri	d16, d0, #0x40
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sli	d16, d0, #0x0
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, x0
               	bl	<addr>
               	fmov	d0, x0
               	mov	v16.16b, v8.16b
               	sli	d16, d0, #0x3f
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fcmp	d8, d0
               	cset	x0, eq
               	neg	x0, x0
               	stur	x0, [x29, #-0x8]
               	sub	x23, x29, #0x8
               	mov	x0, x23
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fmov	s1, s8
               	fmov	s0, s0
               	fcmeq	v0.2s, v1.2s, v0.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	mov	x0, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fcmpe	d8, d0
               	cset	x0, ge
               	neg	x0, x0
               	stur	x0, [x29, #-0x8]
               	mov	x0, x23
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fmov	s1, s8
               	fmov	s0, s0
               	fcmge	v0.2s, v1.2s, v0.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fcmpe	d8, d0
               	cset	x0, gt
               	neg	x0, x0
               	stur	x0, [x29, #-0x8]
               	mov	x24, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fmov	s1, s8
               	fmov	s0, s0
               	fcmgt	v0.2s, v1.2s, v0.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fcmpe	d8, d0
               	cset	x0, ls
               	neg	x0, x0
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fmov	s1, s8
               	fmov	s0, s0
               	fcmge	v0.2s, v0.2s, v1.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x22, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fcmpe	d8, d0
               	cset	x0, mi
               	neg	x0, x0
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	fmov	s1, s8
               	fmov	s0, s0
               	fcmgt	v0.2s, v0.2s, v1.2s
               	mov	w0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrsb	x0, [x22, #0x7]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrsb	x0, [x22, #0xf]
               	sturb	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrb	w0, [x22, #0x7]
               	sturb	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrb	w0, [x22, #0xf]
               	sturb	w0, [x29, #-0x8]
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrb	w0, [x22, #0x7]
               	sturb	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrb	w0, [x22, #0xf]
               	sturb	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrsh	x0, [x22, #0x6]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrsh	x0, [x22, #0xe]
               	sturh	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrh	w0, [x22, #0x6]
               	sturh	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrh	w0, [x22, #0xe]
               	sturh	w0, [x29, #-0x8]
               	mov	x23, #0x2               // =2
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrh	w0, [x22, #0x6]
               	sturh	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrh	w0, [x22, #0xe]
               	sturh	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x23, #0x4               // =4
               	ldrsw	x0, [x22, #0x4]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldrsw	x0, [x22, #0xc]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	w0, [x22, #0x4]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	w0, [x22, #0xc]
               	stur	w0, [x29, #-0x8]
               	mov	x23, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	s0, [x22, #0x4]
               	stur	s0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	s0, [x22, #0xc]
               	stur	s0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	x0, [x22]
               	stur	x0, [x29, #-0x8]
               	mov	x23, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	x0, [x22, #0x8]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	x0, [x22]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x23, #0x8               // =8
               	ldr	x0, [x22, #0x8]
               	stur	x0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	d0, [x22]
               	stur	d0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	ldr	d0, [x22, #0x8]
               	stur	d0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s8, s0
               	bl	<addr>
               	fmov	s0, s0
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	d1, [x23]
               	mov	v16.16b, v8.16b
               	fmla	v16.2s, v0.2s, v1.s[0]
               	mov	v0.16b, v16.16b
               	stur	s0, [x29, #-0x8]
               	mov	x24, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s8, s0
               	bl	<addr>
               	fmov	s0, s0
               	ldr	q1, [x23]
               	mov	v16.16b, v8.16b
               	fmla	v16.2s, v0.2s, v1.s[1]
               	mov	v0.16b, v16.16b
               	stur	s0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x0, x22
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s8, s0
               	bl	<addr>
               	fmov	s0, s0
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	d1, [x23]
               	mov	v16.16b, v8.16b
               	fmls	v16.2s, v0.2s, v1.s[0]
               	mov	v0.16b, v16.16b
               	stur	s0, [x29, #-0x8]
               	mov	x24, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s8, s0
               	bl	<addr>
               	fmov	s0, s0
               	ldr	q1, [x23]
               	mov	v16.16b, v8.16b
               	fmls	v16.2s, v0.2s, v1.s[1]
               	mov	v0.16b, v16.16b
               	stur	s0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, s0
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	d1, [x23]
               	fmul	v0.2s, v0.2s, v1.s[0]
               	stur	s0, [x29, #-0x8]
               	mov	x24, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, s0
               	ldr	q1, [x23]
               	fmul	v0.2s, v0.2s, v1.s[1]
               	stur	s0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, s0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	fmulx	v0.2s, v0.2s, v1.s[0]
               	stur	s0, [x29, #-0x8]
               	sub	x23, x29, #0x8
               	mov	x24, #0x4               // =4
               	mov	x0, x23
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, s0
               	ldr	q1, [x22]
               	fmulx	v0.2s, v0.2s, v1.s[1]
               	stur	s0, [x29, #-0x8]
               	mov	x0, x23
               	mov	x1, x24
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	d1, [x20]
               	mov	v16.16b, v8.16b
               	fmla	d16, d0, v1.d[0]
               	mov	v0.16b, v16.16b
               	stur	d0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x8               // =8
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	ldr	q1, [x20]
               	mov	v16.16b, v8.16b
               	fmla	d16, d0, v1.d[1]
               	mov	v0.16b, v16.16b
               	stur	d0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	ldr	d1, [x20]
               	mov	v16.16b, v8.16b
               	fmls	d16, d0, v1.d[0]
               	mov	v0.16b, v16.16b
               	stur	d0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	bl	<addr>
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	q1, [x23]
               	mov	v16.16b, v8.16b
               	fmls	d16, d0, v1.d[1]
               	mov	v0.16b, v16.16b
               	stur	d0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	ldr	d1, [x23]
               	fmul	d0, d0, v1.d[0]
               	stur	d0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	ldr	q1, [x23]
               	fmul	d0, d0, v1.d[1]
               	stur	d0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	d1, [x23]
               	fmulx	d0, d0, v1.d[0]
               	stur	d0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	ldr	q1, [x23]
               	fmulx	d0, d0, v1.d[1]
               	stur	d0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	sqdmulh	v0.4h, v0.4h, v1.h[1]
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x23, x29, #0x8
               	mov	x1, #0x2                // =2
               	mov	x0, x23
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	ldr	q1, [x22]
               	sqdmulh	v0.4h, v0.4h, v1.h[2]
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x20, #0x2               // =2
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	d1, [x23]
               	sqrdmulh	v0.4h, v0.4h, v1.h[1]
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	sub	x24, x29, #0x8
               	mov	x0, x24
               	mov	x1, x20
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	ldr	q1, [x23]
               	sqrdmulh	v0.4h, v0.4h, v1.h[2]
               	smov	x0, v0.h[0]
               	sturh	w0, [x29, #-0x8]
               	mov	x1, #0x2                // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	sqdmull	v0.4s, v0.4h, v1.h[1]
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x23, x29, #0x8
               	mov	x1, #0x4                // =4
               	mov	x0, x23
               	bl	<addr>
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	ldr	q1, [x22]
               	sqdmull	v0.4s, v0.4h, v1.h[2]
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x20, #0x4               // =4
               	mov	x0, x23
               	mov	x1, x20
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	fmov	s16, w0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	ldr	q16, [sp, #0x40]
               	sqdmlal	v16.4s, v0.4h, v1.h[1]
               	mov	v0.16b, v16.16b
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, x20
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	fmov	s16, w0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	ldr	q1, [x22]
               	ldr	q16, [sp, #0x40]
               	sqdmlal	v16.4s, v0.4h, v1.h[2]
               	mov	v0.16b, v16.16b
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x1, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	mov	x22, #0x0               // =0
               	bl	<addr>
               	fmov	s16, w0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x22
               	mov	v0.h[0], w0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	ldr	q16, [sp, #0x40]
               	sqdmlsl	v16.4s, v0.4h, v1.h[1]
               	mov	v0.16b, v16.16b
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	bl	<addr>
               	fmov	s16, w0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	sxth	x0, w0
               	fmov	d0, x20
               	mov	v0.h[0], w0
               	ldr	q1, [x22]
               	ldr	q16, [sp, #0x40]
               	sqdmlsl	v16.4s, v0.4h, v1.h[2]
               	mov	v0.16b, v16.16b
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x22, #0x4               // =4
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	ldr	d1, [x23]
               	sqdmulh	v0.2s, v0.2s, v1.s[1]
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	ldr	q1, [x23]
               	sqdmulh	v0.2s, v0.2s, v1.s[2]
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x22, x29, #0x8
               	mov	x23, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	d1, [x20]
               	sqrdmulh	v0.2s, v0.2s, v1.s[1]
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	ldr	q1, [x20]
               	sqrdmulh	v0.2s, v0.2s, v1.s[2]
               	smov	x0, v0.s[0]
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x1, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	sqdmull	v0.2d, v0.2s, v1.s[1]
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	s0, w0
               	ldr	q1, [x22]
               	sqdmull	v0.2d, v0.2s, v1.s[2]
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x22, #0x8               // =8
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	fmov	s0, w0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	d1, [x20]
               	ldr	q16, [sp, #0x40]
               	sqdmlal	v16.2d, v0.2s, v1.s[1]
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, x22
               	bl	<addr>
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	fmov	s0, w0
               	ldr	q1, [x20]
               	ldr	q16, [sp, #0x40]
               	sqdmlal	v16.2d, v0.2s, v1.s[2]
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	mov	x1, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	fmov	s0, w0
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldr	d1, [x22]
               	ldr	q16, [sp, #0x40]
               	sqdmlsl	v16.2d, v0.2s, v1.s[1]
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	mov	x1, #0x8                // =8
               	mov	x0, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d16, x0
               	str	q16, [sp, #0x40]
               	bl	<addr>
               	fmov	s0, w0
               	ldr	q1, [x22]
               	ldr	q16, [sp, #0x40]
               	sqdmlsl	v16.2d, v0.2s, v1.s[2]
               	mov	v0.16b, v16.16b
               	mov	x0, v0.d[0]
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x12c
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x3d83            // =15747
               	movk	x17, #0x3f45, lsl #16
               	movk	x17, #0x9592, lsl #32
               	movk	x17, #0x92d4, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x24, x25, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x70
               	ret
