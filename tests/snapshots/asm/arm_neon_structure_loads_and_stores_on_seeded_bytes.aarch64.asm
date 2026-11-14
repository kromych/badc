
arm_neon_structure_loads_and_stores_on_seeded_bytes.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x5               // =5
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x16, x16, #0x1
               	b.ne	<addr>
               	sub	sp, sp, #0x510
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
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
               	cmp	w0, #0x200
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	str	d2, [sp, #0x40c0]
               	str	d0, [sp, #0x40c8]
               	add	x2, x0, #0x1
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x440
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x60]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x5f]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x5e]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x5d]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x5c]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x5b]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x5a]
               	ldrsb	x1, [x0, #0x3]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x59]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x58]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x57]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x56]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x55]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x54]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x53]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x52]
               	ldrsb	x1, [x0, #0x4]
               	sub	x17, x29, #0x1, lsl #12 // =0x1000
               	sturb	w1, [x17, #-0x51]
               	ldr	x1, [sp, #0x44b0]
               	ldr	x2, [sp, #0x44b8]
               	str	x1, [sp, #0x40e0]
               	str	x2, [sp, #0x40e8]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x450
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x410
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x5
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsb	x4, [x2, x0]
               	strb	w4, [x3, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x410
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x420
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x40f0]
               	ldr	d1, [sp, #0x40f8]
               	zip1	v0.8b, v0.8b, v1.8b
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x44c0]
               	ldr	d1, [sp, #0x44c8]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x430
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x60
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x440
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x400
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #3
               	ldrsb	x3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x450
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x440
               	mov	x0, #0x0                // =0
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x9d8
               	add	x4, x0, x0, lsl #1
               	ldrsb	x5, [x1, w4, sxtw]
               	strb	w5, [x3, x0]
               	add	x5, x3, #0x8
               	add	x6, x4, #0x1
               	ldrsb	x6, [x1, w6, sxtw]
               	strb	w6, [x5, x0]
               	add	x3, x3, #0x10
               	add	x4, x4, #0x2
               	ldrsb	x4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x4b38]
               	ldr	x3, [sp, #0x4b40]
               	ldr	x4, [sp, #0x4b48]
               	str	x0, [sp, #0x4550]
               	str	x3, [sp, #0x4558]
               	str	x4, [sp, #0x4560]
               	add	x3, x1, #0x1
               	sub	x0, x29, #0xa20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x3, x29, #0xfa8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d8
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d7
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d6
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d5
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d4
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d3
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d2
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x3]
               	sub	x17, x29, #0x9d1
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9d0
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9cf
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9ce
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9cd
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9cc
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9cb
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9ca
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x4]
               	sub	x17, x29, #0x9c9
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c8
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c7
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c6
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c5
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c4
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c3
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c2
               	strb	w0, [x17]
               	ldrsb	x0, [x1, #0x5]
               	sub	x17, x29, #0x9c1
               	strb	w0, [x17]
               	ldr	x0, [sp, #0x4b38]
               	ldr	x3, [sp, #0x4b40]
               	ldr	x4, [sp, #0x4b48]
               	str	x0, [sp, #0x4580]
               	str	x3, [sp, #0x4588]
               	str	x4, [sp, #0x4590]
               	sub	x0, x29, #0xfc0
               	sub	x3, x29, #0xf60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	add	x4, x1, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xf60
               	add	x1, x1, x0, lsl #3
               	ldrsb	x3, [x4, x0]
               	strb	w3, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0xf60
               	sub	x0, x29, #0xf78
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x3, x29, #0x9d8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	add	x4, x3, #0x8
               	add	x5, x3, #0x10
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrsb	x6, [x3, x0]
               	strb	w6, [x2, w1, sxtw]
               	add	x6, x1, #0x1
               	ldrsb	x7, [x4, x0]
               	strb	w7, [x2, w6, sxtw]
               	add	x1, x1, #0x2
               	ldrsb	x6, [x5, x0]
               	strb	w6, [x2, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x1, x2, #0x18
               	sub	x3, x29, #0xf90
               	sub	x0, x29, #0x9d8
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0xfa8
               	sub	x1, x29, #0xf48
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x3, x2, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xf48
               	lsl	x2, x0, #3
               	ldrsb	x1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xfc0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0xfa8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	d0, [x5]
               	ldr	d1, [x5, #0x8]
               	ldr	d2, [x5, #0x10]
               	ldr	d3, [x5, #0x18]
               	uzp1	v4.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	uzp1	v1.8b, v2.8b, v3.8b
               	uzp2	v2.8b, v2.8b, v3.8b
               	uzp1	v3.8b, v4.8b, v1.8b
               	uzp1	v5.8b, v0.8b, v2.8b
               	uzp2	v1.8b, v4.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v2.8b
               	str	d3, [sp, #0x4b50]
               	str	d5, [sp, #0x4b58]
               	str	d1, [sp, #0x4b60]
               	str	d0, [sp, #0x4b68]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x200
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x9a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x140
               	lsl	x3, x0, #3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x140
               	add	x2, x2, x3
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x53d0]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x0, [sp, #0x4b90]
               	str	x1, [sp, #0x4b98]
               	str	x2, [sp, #0x4ba0]
               	str	x3, [sp, #0x4ba8]
               	sub	x0, x29, #0x9c0
               	sub	x1, x29, #0x940
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x940
               	add	x1, x1, x0, lsl #3
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x940
               	sub	x0, x29, #0x960
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4bb0]
               	ldr	d1, [sp, #0x4bc0]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldr	d1, [sp, #0x53f0]
               	ldr	d2, [sp, #0x5400]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldr	d2, [sp, #0x53f8]
               	ldr	d3, [sp, #0x5408]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x6]
               	add	x1, x6, #0x8
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x10
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x18
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x20
               	sub	x2, x29, #0x980
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x9a0
               	sub	x1, x29, #0x920
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x6, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #3
               	ldrsb	x3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x9c0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0x9a0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	str	q2, [sp, #0x2470]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x2480]
               	str	q2, [sp, #0x20]
               	str	q0, [sp, #0x30]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x4c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x1, sp, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	lsl	x3, x0, #4
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x3, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x3, #0x7]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x8]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x9]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xa]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xb]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xc]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xd]
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x80
               	add	x3, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x3, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2490]
               	ldr	q1, [sp, #0x24a0]
               	str	q0, [sp, #0x60]
               	str	q1, [sp, #0x70]
               	add	x0, sp, #0x20
               	add	x1, sp, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x80
               	add	x1, x1, x0, lsl #4
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, sp, #0x80
               	add	x0, sp, #0xa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xa0]
               	ldr	q1, [sp, #0xb0]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x6]
               	ldr	q0, [sp, #0x24b0]
               	ldr	q1, [sp, #0x24c0]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x6, #0x10]
               	add	x1, x6, #0x20
               	add	x2, sp, #0x60
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0x40
               	add	x1, sp, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x6, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #4
               	ldrsb	x3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x20
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	add	x2, sp, #0x40
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x20
               	add	x2, x0, x0, lsl #1
               	ldrsb	x5, [x3, w2, sxtw]
               	strb	w5, [x1, x0]
               	add	x5, x1, #0x10
               	add	x6, x2, #0x1
               	ldrsb	x6, [x3, w6, sxtw]
               	strb	w6, [x5, x0]
               	add	x1, x1, #0x20
               	add	x2, x2, #0x2
               	ldrsb	x2, [x3, w2, sxtw]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x24f0]
               	ldr	q1, [sp, #0x2500]
               	ldr	q2, [sp, #0x2510]
               	str	q0, [sp, #0xe0]
               	str	q1, [sp, #0xf0]
               	str	q2, [sp, #0x100]
               	add	x1, x3, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x4a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x1, sp, #0x110
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xff0
               	lsl	x5, x0, #4
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, x5]
               	add	x2, x2, x5
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x1]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x2]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x3]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x4]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x5]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xff0
               	add	x5, x2, x5
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x5, #0x7]
               	lsl	x5, x0, #4
               	add	x2, x2, x5
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x8]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0x9]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0xa]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0xb]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0xc]
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xff0
               	add	x5, x2, x5
               	ldrsb	x6, [x1, x0]
               	strb	w6, [x5, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrsb	x5, [x1, x0]
               	strb	w5, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2520]
               	ldr	q1, [sp, #0x2530]
               	ldr	q2, [sp, #0x2540]
               	str	q0, [sp, #0x140]
               	str	q1, [sp, #0x150]
               	str	q2, [sp, #0x160]
               	add	x0, sp, #0xe0
               	add	x1, sp, #0x170
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x3, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x170
               	add	x1, x1, x0, lsl #4
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, sp, #0x170
               	add	x0, sp, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xfc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x2, #0x10
               	add	x5, x2, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrsb	x6, [x2, x0]
               	strb	w6, [x4, w1, sxtw]
               	add	x6, x1, #0x1
               	ldrsb	x7, [x3, x0]
               	strb	w7, [x4, w6, sxtw]
               	add	x1, x1, #0x2
               	ldrsb	x6, [x5, x0]
               	strb	w6, [x4, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x1, x4, #0x30
               	add	x2, sp, #0x140
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xf90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0x110
               	add	x1, sp, #0x1d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x4, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x1d0
               	lsl	x2, x0, #4
               	ldrsb	x1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0xe0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lo	<addr>
               	add	x2, sp, #0x110
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.16b, v0.16b, v1.16b
               	uzp2	v0.16b, v0.16b, v1.16b
               	uzp1	v1.16b, v2.16b, v3.16b
               	uzp2	v2.16b, v2.16b, v3.16b
               	uzp1	v3.16b, v4.16b, v1.16b
               	str	q3, [sp, #0x25b0]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x25c0]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x25d0]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x25e0]
               	str	q3, [sp, #0x200]
               	str	q5, [sp, #0x210]
               	str	q1, [sp, #0x220]
               	str	q0, [sp, #0x230]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x470
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x1, sp, #0x240
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xf20
               	lsl	x3, x0, #4
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xf20
               	add	x3, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x3, #0x7]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x8]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0x9]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xa]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xb]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xc]
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xf20
               	add	x3, x2, x3
               	ldrsb	x4, [x1, x0]
               	strb	w4, [x3, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrsb	x3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x25f0]
               	ldr	q1, [sp, #0x2600]
               	ldr	q2, [sp, #0x2610]
               	ldr	q3, [sp, #0x2620]
               	str	q0, [sp, #0x280]
               	str	q1, [sp, #0x290]
               	str	q2, [sp, #0x2a0]
               	str	q3, [sp, #0x2b0]
               	add	x0, sp, #0x200
               	add	x1, sp, #0x2c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x2c0
               	add	x1, x1, x0, lsl #4
               	ldrsb	x2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x1, sp, #0x2c0
               	add	x0, sp, #0x300
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xee0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x300]
               	ldr	q1, [sp, #0x320]
               	zip1	v0.16b, v0.16b, v1.16b
               	ldr	q1, [sp, #0x2630]
               	ldr	q2, [sp, #0x2650]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x2640]
               	ldr	q3, [sp, #0x2660]
               	zip1	v4.16b, v2.16b, v3.16b
               	zip2	v2.16b, v2.16b, v3.16b
               	zip1	v3.16b, v0.16b, v4.16b
               	str	q3, [x6]
               	zip2	v0.16b, v0.16b, v4.16b
               	str	q0, [x6, #0x10]
               	zip1	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x20]
               	zip2	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x30]
               	add	x1, x6, #0x40
               	add	x2, sp, #0x280
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xea0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x240
               	add	x1, sp, #0x340
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x6, #0x80
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #4
               	ldrsb	x3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x200
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	add	x2, sp, #0x240
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	str	d2, [sp, #0x4120]
               	str	d0, [sp, #0x4128]
               	add	x2, x0, #0x1
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x80
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x130
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12f
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12e
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12d
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12c
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12b
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12a
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x129
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x128
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x127
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x126
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x125
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x124
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x123
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x122
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x121
               	strb	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x2, [sp, #0x53e8]
               	str	x1, [sp, #0x4140]
               	str	x2, [sp, #0x4148]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3f0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x5
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrb	w4, [x2, x0]
               	strb	w4, [x3, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3b0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4150]
               	ldr	d1, [sp, #0x4158]
               	zip1	v0.8b, v0.8b, v1.8b
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	ldr	d0, [sp, #0x44d0]
               	ldr	d1, [sp, #0x44d8]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3d0
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3e0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x3a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x5, #0x20
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #3
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3f0
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3e0
               	mov	x0, #0x0                // =0
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x138
               	add	x4, x0, x0, lsl #1
               	ldrb	w5, [x1, w4, sxtw]
               	strb	w5, [x3, x0]
               	add	x5, x3, #0x8
               	add	x6, x4, #0x1
               	ldrb	w6, [x1, w6, sxtw]
               	strb	w6, [x5, x0]
               	add	x3, x3, #0x10
               	add	x4, x4, #0x2
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x0, [sp, #0x45e0]
               	str	x3, [sp, #0x45e8]
               	str	x4, [sp, #0x45f0]
               	add	x3, x1, #0x1
               	sub	x0, x29, #0xa08
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x3, x29, #0xf18
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x138
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x137
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x136
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x135
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x134
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x133
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x132
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x131
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x130
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12f
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12e
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12d
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12c
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12b
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12a
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x129
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x128
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x127
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x126
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x125
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x124
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x123
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x122
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x121
               	strb	w0, [x17]
               	ldr	x0, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x0, [sp, #0x4610]
               	str	x3, [sp, #0x4618]
               	str	x4, [sp, #0x4620]
               	sub	x0, x29, #0xf30
               	sub	x3, x29, #0xed0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	add	x4, x1, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xed0
               	add	x1, x1, x0, lsl #3
               	ldrb	w3, [x4, x0]
               	strb	w3, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0xed0
               	sub	x0, x29, #0xee8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x3, x29, #0x138
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	add	x4, x3, #0x8
               	add	x5, x3, #0x10
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrb	w6, [x3, x0]
               	strb	w6, [x2, w1, sxtw]
               	add	x6, x1, #0x1
               	ldrb	w7, [x4, x0]
               	strb	w7, [x2, w6, sxtw]
               	add	x1, x1, #0x2
               	ldrb	w6, [x5, x0]
               	strb	w6, [x2, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x1, x2, #0x18
               	sub	x3, x29, #0xf00
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0xf18
               	sub	x1, x29, #0xeb8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x3, x2, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xeb8
               	lsl	x2, x0, #3
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xf30
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0xf18
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	d0, [x5]
               	ldr	d1, [x5, #0x8]
               	ldr	d2, [x5, #0x10]
               	ldr	d3, [x5, #0x18]
               	uzp1	v4.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	uzp1	v1.8b, v2.8b, v3.8b
               	uzp2	v2.8b, v2.8b, v3.8b
               	uzp1	v3.8b, v4.8b, v1.8b
               	uzp1	v5.8b, v0.8b, v2.8b
               	uzp2	v1.8b, v4.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v2.8b
               	str	d3, [sp, #0x4c10]
               	str	d5, [sp, #0x4c18]
               	str	d1, [sp, #0x4c20]
               	str	d0, [sp, #0x4c28]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x1e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x8e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x140
               	lsl	x3, x0, #3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x140
               	add	x2, x2, x3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x53d0]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x0, [sp, #0x4c50]
               	str	x1, [sp, #0x4c58]
               	str	x2, [sp, #0x4c60]
               	str	x3, [sp, #0x4c68]
               	sub	x0, x29, #0x900
               	sub	x1, x29, #0x880
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x880
               	add	x1, x1, x0, lsl #3
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x880
               	sub	x0, x29, #0x8a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4c70]
               	ldr	d1, [sp, #0x4c80]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldur	d1, [x29, #-0x100]
               	ldur	d2, [x29, #-0xf0]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldur	d2, [x29, #-0xf8]
               	ldur	d3, [x29, #-0xe8]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x6]
               	add	x1, x6, #0x8
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x10
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x18
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x20
               	sub	x2, x29, #0x8c0
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x8e0
               	sub	x1, x29, #0x860
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x6, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #3
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x900
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0x8e0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	str	q2, [sp, #0x26b0]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x26c0]
               	str	q2, [sp, #0x380]
               	str	q0, [sp, #0x390]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x430
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x1, sp, #0x3a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0x7]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xe40
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	q0, [sp, #0x26d0]
               	ldr	q1, [sp, #0x26e0]
               	str	q0, [sp, #0x3c0]
               	str	q1, [sp, #0x3d0]
               	add	x0, sp, #0x380
               	add	x1, sp, #0x3e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x3e0
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, sp, #0x3e0
               	add	x0, sp, #0x400
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xe20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x400]
               	ldr	q1, [sp, #0x410]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x6]
               	ldr	q0, [sp, #0x26f0]
               	ldr	q1, [sp, #0x2700]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x6, #0x10]
               	add	x1, x6, #0x20
               	add	x2, sp, #0x3c0
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xe00
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0x3a0
               	add	x1, sp, #0x420
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x6, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #4
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x380
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	add	x2, sp, #0x3a0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xde0
               	add	x2, x0, x0, lsl #1
               	ldrb	w5, [x3, w2, sxtw]
               	strb	w5, [x1, x0]
               	add	x5, x1, #0x10
               	add	x6, x2, #0x1
               	ldrb	w6, [x3, w6, sxtw]
               	strb	w6, [x5, x0]
               	add	x1, x1, #0x20
               	add	x2, x2, #0x2
               	ldrb	w2, [x3, w2, sxtw]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2730]
               	ldr	q1, [sp, #0x2740]
               	ldr	q2, [sp, #0x2750]
               	str	q0, [sp, #0x440]
               	str	q1, [sp, #0x450]
               	str	q2, [sp, #0x460]
               	add	x1, x3, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x410
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x1, sp, #0x470
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xdb0
               	lsl	x5, x0, #4
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, x5]
               	add	x2, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x1]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x2]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x3]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x4]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x5]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xdb0
               	add	x5, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x5, #0x7]
               	lsl	x5, x0, #4
               	add	x2, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x8]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x9]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xa]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xb]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xc]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xdb0
               	add	x5, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x5, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2760]
               	ldr	q1, [sp, #0x2770]
               	ldr	q2, [sp, #0x2780]
               	str	q0, [sp, #0x4a0]
               	str	q1, [sp, #0x4b0]
               	str	q2, [sp, #0x4c0]
               	add	x0, sp, #0x440
               	add	x1, sp, #0x4d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x3, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x4d0
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, sp, #0x4d0
               	add	x0, sp, #0x500
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xd80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x2, #0x10
               	add	x5, x2, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrb	w6, [x2, x0]
               	strb	w6, [x4, w1, sxtw]
               	add	x6, x1, #0x1
               	ldrb	w7, [x3, x0]
               	strb	w7, [x4, w6, sxtw]
               	add	x1, x1, #0x2
               	ldrb	w6, [x5, x0]
               	strb	w6, [x4, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x1, x4, #0x30
               	add	x2, sp, #0x4a0
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xd50
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0x470
               	add	x1, sp, #0x530
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x4, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x530
               	lsl	x2, x0, #4
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x440
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lo	<addr>
               	add	x2, sp, #0x470
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.16b, v0.16b, v1.16b
               	uzp2	v0.16b, v0.16b, v1.16b
               	uzp1	v1.16b, v2.16b, v3.16b
               	uzp2	v2.16b, v2.16b, v3.16b
               	uzp1	v3.16b, v4.16b, v1.16b
               	str	q3, [sp, #0x27f0]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x2800]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x2810]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x2820]
               	str	q3, [sp, #0x560]
               	str	q5, [sp, #0x570]
               	str	q1, [sp, #0x580]
               	str	q0, [sp, #0x590]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x3e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x1, sp, #0x5a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xce0
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xce0
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0x7]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xce0
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2830]
               	ldr	q1, [sp, #0x2840]
               	ldr	q2, [sp, #0x2850]
               	ldr	q3, [sp, #0x2860]
               	str	q0, [sp, #0x5e0]
               	str	q1, [sp, #0x5f0]
               	str	q2, [sp, #0x600]
               	str	q3, [sp, #0x610]
               	add	x0, sp, #0x560
               	add	x1, sp, #0x620
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x620
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x1, sp, #0x620
               	add	x0, sp, #0x660
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xca0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x660]
               	ldr	q1, [sp, #0x680]
               	zip1	v0.16b, v0.16b, v1.16b
               	ldr	q1, [sp, #0x2870]
               	ldr	q2, [sp, #0x2890]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x2880]
               	ldr	q3, [sp, #0x28a0]
               	zip1	v4.16b, v2.16b, v3.16b
               	zip2	v2.16b, v2.16b, v3.16b
               	zip1	v3.16b, v0.16b, v4.16b
               	str	q3, [x6]
               	zip2	v0.16b, v0.16b, v4.16b
               	str	q0, [x6, #0x10]
               	zip1	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x20]
               	zip2	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x30]
               	add	x1, x6, #0x40
               	add	x2, sp, #0x5e0
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xc60
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x5a0
               	add	x1, sp, #0x6a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x6, #0x80
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #4
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x560
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	add	x2, sp, #0x5a0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	str	d2, [sp, #0x4180]
               	str	d0, [sp, #0x4188]
               	add	x2, x0, #0x1
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x70
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x380
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x130
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12f
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12e
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12d
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12c
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12b
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x12a
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x3]
               	sub	x17, x29, #0x129
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x128
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x127
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x126
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x125
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x124
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x123
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x122
               	strb	w1, [x17]
               	ldrb	w1, [x0, #0x4]
               	sub	x17, x29, #0x121
               	strb	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x2, [sp, #0x53e8]
               	str	x1, [sp, #0x41a0]
               	str	x2, [sp, #0x41a8]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x390
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x350
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x5
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrb	w4, [x2, x0]
               	strb	w4, [x3, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x350
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x360
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x41b0]
               	ldr	d1, [sp, #0x41b8]
               	zip1	v0.8b, v0.8b, v1.8b
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	ldr	d0, [sp, #0x44e0]
               	ldr	d1, [sp, #0x44e8]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x370
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x380
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x340
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x5, #0x20
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #3
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x390
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x380
               	mov	x0, #0x0                // =0
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x138
               	add	x4, x0, x0, lsl #1
               	ldrb	w5, [x1, w4, sxtw]
               	strb	w5, [x3, x0]
               	add	x5, x3, #0x8
               	add	x6, x4, #0x1
               	ldrb	w6, [x1, w6, sxtw]
               	strb	w6, [x5, x0]
               	add	x3, x3, #0x10
               	add	x4, x4, #0x2
               	ldrb	w4, [x1, w4, sxtw]
               	strb	w4, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	x0, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x0, [sp, #0x4670]
               	str	x3, [sp, #0x4678]
               	str	x4, [sp, #0x4680]
               	add	x3, x1, #0x1
               	sub	x0, x29, #0x9f0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x3, x29, #0xe88
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x138
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x137
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x136
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x135
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x134
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x133
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x132
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x3]
               	sub	x17, x29, #0x131
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x130
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12f
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12e
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12d
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12c
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12b
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x12a
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x4]
               	sub	x17, x29, #0x129
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x128
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x127
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x126
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x125
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x124
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x123
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x122
               	strb	w0, [x17]
               	ldrb	w0, [x1, #0x5]
               	sub	x17, x29, #0x121
               	strb	w0, [x17]
               	ldr	x0, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x0, [sp, #0x46a0]
               	str	x3, [sp, #0x46a8]
               	str	x4, [sp, #0x46b0]
               	sub	x0, x29, #0xea0
               	sub	x3, x29, #0xe40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	add	x4, x1, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xe40
               	add	x1, x1, x0, lsl #3
               	ldrb	w3, [x4, x0]
               	strb	w3, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0xe40
               	sub	x0, x29, #0xe58
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x3, x29, #0x138
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x3, #0x10]
               	add	x4, x3, #0x8
               	add	x5, x3, #0x10
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrb	w6, [x3, x0]
               	strb	w6, [x2, w1, sxtw]
               	add	x6, x1, #0x1
               	ldrb	w7, [x4, x0]
               	strb	w7, [x2, w6, sxtw]
               	add	x1, x1, #0x2
               	ldrb	w6, [x5, x0]
               	strb	w6, [x2, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x1, x2, #0x18
               	sub	x3, x29, #0xe70
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0xe88
               	sub	x1, x29, #0xe28
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x3, x2, #0x30
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xe28
               	lsl	x2, x0, #3
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xea0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0xe88
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	d0, [x5]
               	ldr	d1, [x5, #0x8]
               	ldr	d2, [x5, #0x10]
               	ldr	d3, [x5, #0x18]
               	uzp1	v4.8b, v0.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v1.8b
               	uzp1	v1.8b, v2.8b, v3.8b
               	uzp2	v2.8b, v2.8b, v3.8b
               	uzp1	v3.8b, v4.8b, v1.8b
               	uzp1	v5.8b, v0.8b, v2.8b
               	uzp2	v1.8b, v4.8b, v1.8b
               	uzp2	v0.8b, v0.8b, v2.8b
               	str	d3, [sp, #0x4cd0]
               	str	d5, [sp, #0x4cd8]
               	str	d1, [sp, #0x4ce0]
               	str	d0, [sp, #0x4ce8]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x1c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x820
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x140
               	lsl	x3, x0, #3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x140
               	add	x2, x2, x3
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	x0, [sp, #0x53d0]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x0, [sp, #0x4d10]
               	str	x1, [sp, #0x4d18]
               	str	x2, [sp, #0x4d20]
               	str	x3, [sp, #0x4d28]
               	sub	x0, x29, #0x840
               	sub	x1, x29, #0x7c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x7c0
               	add	x1, x1, x0, lsl #3
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0x7]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x7c0
               	sub	x0, x29, #0x7e0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4d30]
               	ldr	d1, [sp, #0x4d40]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldur	d1, [x29, #-0xe0]
               	ldur	d2, [x29, #-0xd0]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldur	d2, [x29, #-0xd8]
               	ldur	d3, [x29, #-0xc8]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x6]
               	add	x1, x6, #0x8
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x10
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x18
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x20
               	sub	x2, x29, #0x800
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x820
               	sub	x1, x29, #0x7a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x6, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #3
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x840
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0x820
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	uzp1	v2.16b, v0.16b, v1.16b
               	str	q2, [sp, #0x28f0]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x2900]
               	str	q2, [sp, #0x6e0]
               	str	q0, [sp, #0x6f0]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x3a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	add	x1, sp, #0x700
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0x7]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xc00
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2910]
               	ldr	q1, [sp, #0x2920]
               	str	q0, [sp, #0x720]
               	str	q1, [sp, #0x730]
               	add	x0, sp, #0x6e0
               	add	x1, sp, #0x740
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x740
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, sp, #0x740
               	add	x0, sp, #0x760
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xbe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x760]
               	ldr	q1, [sp, #0x770]
               	zip1	v0.16b, v0.16b, v1.16b
               	str	q0, [x6]
               	ldr	q0, [sp, #0x2930]
               	ldr	q1, [sp, #0x2940]
               	zip2	v0.16b, v0.16b, v1.16b
               	str	q0, [x6, #0x10]
               	add	x1, x6, #0x20
               	add	x2, sp, #0x720
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xbc0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0x700
               	add	x1, sp, #0x780
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x6, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #4
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x6e0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	add	x2, sp, #0x700
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xba0
               	add	x2, x0, x0, lsl #1
               	ldrb	w5, [x3, w2, sxtw]
               	strb	w5, [x1, x0]
               	add	x5, x1, #0x10
               	add	x6, x2, #0x1
               	ldrb	w6, [x3, w6, sxtw]
               	strb	w6, [x5, x0]
               	add	x1, x1, #0x20
               	add	x2, x2, #0x2
               	ldrb	w2, [x3, w2, sxtw]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2970]
               	ldr	q1, [sp, #0x2980]
               	ldr	q2, [sp, #0x2990]
               	str	q0, [sp, #0x7a0]
               	str	q1, [sp, #0x7b0]
               	str	q2, [sp, #0x7c0]
               	add	x1, x3, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x380
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x1, sp, #0x7d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xb70
               	lsl	x5, x0, #4
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, x5]
               	add	x2, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x1]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x2]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x3]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x4]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x5]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xb70
               	add	x5, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x5, #0x7]
               	lsl	x5, x0, #4
               	add	x2, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x8]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0x9]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xa]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xb]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xc]
               	ldrb	w6, [x1, x0]
               	strb	w6, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xb70
               	add	x5, x2, x5
               	ldrb	w6, [x1, x0]
               	strb	w6, [x5, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrb	w5, [x1, x0]
               	strb	w5, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	q0, [sp, #0x29a0]
               	ldr	q1, [sp, #0x29b0]
               	ldr	q2, [sp, #0x29c0]
               	str	q0, [sp, #0x800]
               	str	q1, [sp, #0x810]
               	str	q2, [sp, #0x820]
               	add	x0, sp, #0x7a0
               	add	x1, sp, #0x830
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x3, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x830
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, sp, #0x830
               	add	x0, sp, #0x860
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xb40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x2, #0x10
               	add	x5, x2, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrb	w6, [x2, x0]
               	strb	w6, [x4, w1, sxtw]
               	add	x6, x1, #0x1
               	ldrb	w7, [x3, x0]
               	strb	w7, [x4, w6, sxtw]
               	add	x1, x1, #0x2
               	ldrb	w6, [x5, x0]
               	strb	w6, [x4, w1, sxtw]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	add	x1, x4, #0x30
               	add	x2, sp, #0x800
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xb10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0x7d0
               	add	x1, sp, #0x890
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x3, x4, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x890
               	lsl	x2, x0, #4
               	ldrb	w1, [x1, x2]
               	strb	w1, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x7a0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lo	<addr>
               	add	x2, sp, #0x7d0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x30
               	b.lo	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.16b, v0.16b, v1.16b
               	uzp2	v0.16b, v0.16b, v1.16b
               	uzp1	v1.16b, v2.16b, v3.16b
               	uzp2	v2.16b, v2.16b, v3.16b
               	uzp1	v3.16b, v4.16b, v1.16b
               	str	q3, [sp, #0x2a30]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x2a40]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x2a50]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x2a60]
               	str	q3, [sp, #0x8c0]
               	str	q5, [sp, #0x8d0]
               	str	q1, [sp, #0x8e0]
               	str	q0, [sp, #0x8f0]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x350
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x1, sp, #0x900
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x3
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xaa0
               	lsl	x3, x0, #4
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, x3]
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x1]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x2]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x3]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x4]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x5]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x6]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xaa0
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0x7]
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x8]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0x9]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xa]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xb]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xc]
               	ldrb	w4, [x1, x0]
               	strb	w4, [x2, #0xd]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0xaa0
               	add	x3, x2, x3
               	ldrb	w4, [x1, x0]
               	strb	w4, [x3, #0xe]
               	add	x2, x2, x0, lsl #4
               	ldrb	w3, [x1, x0]
               	strb	w3, [x2, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2a70]
               	ldr	q1, [sp, #0x2a80]
               	ldr	q2, [sp, #0x2a90]
               	ldr	q3, [sp, #0x2aa0]
               	str	q0, [sp, #0x940]
               	str	q1, [sp, #0x950]
               	str	q2, [sp, #0x960]
               	str	q3, [sp, #0x970]
               	add	x0, sp, #0x8c0
               	add	x1, sp, #0x980
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0x5
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0x980
               	add	x1, x1, x0, lsl #4
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, #0xf]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x1, sp, #0x980
               	add	x0, sp, #0x9c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xa60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x9c0]
               	ldr	q1, [sp, #0x9e0]
               	zip1	v0.16b, v0.16b, v1.16b
               	ldr	q1, [sp, #0x2ab0]
               	ldr	q2, [sp, #0x2ad0]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x2ac0]
               	ldr	q3, [sp, #0x2ae0]
               	zip1	v4.16b, v2.16b, v3.16b
               	zip2	v2.16b, v2.16b, v3.16b
               	zip1	v3.16b, v0.16b, v4.16b
               	str	q3, [x6]
               	zip2	v0.16b, v0.16b, v4.16b
               	str	q0, [x6, #0x10]
               	zip1	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x20]
               	zip2	v0.16b, v1.16b, v2.16b
               	str	q0, [x6, #0x30]
               	add	x1, x6, #0x40
               	add	x2, sp, #0x940
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xa20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0x900
               	add	x1, sp, #0xa00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x6, #0x80
               	mov	x0, #0x0                // =0
               	lsl	x3, x0, #4
               	ldrb	w3, [x1, x3]
               	strb	w3, [x2, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x2, sp, #0x8c0
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	add	x2, sp, #0x900
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x330
               	str	d2, [sp, #0x41e0]
               	str	d0, [sp, #0x41e8]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w3, [x0, #0x4]
               	ldrh	w4, [x0, #0x6]
               	ldrh	w6, [x0, #0x8]
               	ldrh	w7, [x0, #0xa]
               	ldrh	w8, [x0, #0xc]
               	ldrh	w9, [x0, #0xe]
               	ldrh	w10, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w1, [x17, #0xce0]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w3, [x17, #0xce2]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w4, [x17, #0xce4]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w6, [x17, #0xce6]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w7, [x17, #0xce8]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w8, [x17, #0xcea]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w9, [x17, #0xcec]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	strh	w10, [x17, #0xcee]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4200]
               	str	x3, [sp, #0x4208]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2f0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsh	x4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2f0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x300
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4210]
               	ldr	d1, [sp, #0x4218]
               	zip1	v0.4h, v0.4h, v1.4h
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	ldr	d0, [sp, #0x44f0]
               	ldr	d1, [sp, #0x44f8]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x310
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x320
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x5, #0x20
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsh	x3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x330
               	mov	x0, #0x0                // =0
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
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x320
               	mov	x0, #0x0                // =0
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsh	x2, [x0]
               	sub	x17, x29, #0x138
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x2]
               	sub	x17, x29, #0x130
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x4]
               	sub	x17, x29, #0x128
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x6]
               	sub	x17, x29, #0x136
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x8]
               	sub	x17, x29, #0x12e
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xa]
               	sub	x17, x29, #0x126
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xc]
               	sub	x17, x29, #0x134
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xe]
               	sub	x17, x29, #0x12c
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x10]
               	sub	x17, x29, #0x124
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x12]
               	sub	x17, x29, #0x132
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x14]
               	sub	x17, x29, #0x12a
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x16]
               	sub	x17, x29, #0x122
               	strh	w2, [x17]
               	ldr	x2, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	sub	x5, x29, #0xe10
               	str	x2, [sp, #0x4700]
               	str	x3, [sp, #0x4708]
               	str	x4, [sp, #0x4710]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w3, [x0, #0x4]
               	ldrh	w4, [x0, #0x6]
               	ldrh	w6, [x0, #0x8]
               	ldrh	w7, [x0, #0xa]
               	ldrh	w8, [x0, #0xc]
               	ldrh	w9, [x0, #0xe]
               	ldrh	w10, [x0, #0x10]
               	ldrh	w11, [x0, #0x12]
               	ldrh	w12, [x0, #0x14]
               	ldrh	w13, [x0, #0x16]
               	ldrh	w14, [x0, #0x18]
               	sub	x17, x29, #0xdf8
               	strh	w2, [x17]
               	sub	x17, x29, #0xdf6
               	strh	w3, [x17]
               	sub	x17, x29, #0xdf4
               	strh	w4, [x17]
               	sub	x17, x29, #0xdf2
               	strh	w6, [x17]
               	sub	x17, x29, #0xdf0
               	strh	w7, [x17]
               	sub	x17, x29, #0xdee
               	strh	w8, [x17]
               	sub	x17, x29, #0xdec
               	strh	w9, [x17]
               	sub	x17, x29, #0xdea
               	strh	w10, [x17]
               	sub	x17, x29, #0xde8
               	strh	w11, [x17]
               	sub	x17, x29, #0xde6
               	strh	w12, [x17]
               	sub	x17, x29, #0xde4
               	strh	w13, [x17]
               	sub	x17, x29, #0xde2
               	strh	w14, [x17]
               	ldrsh	x2, [x0, #0x6]
               	sub	x17, x29, #0x138
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x6]
               	sub	x17, x29, #0x136
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x6]
               	sub	x17, x29, #0x134
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x6]
               	sub	x17, x29, #0x132
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x8]
               	sub	x17, x29, #0x130
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x8]
               	sub	x17, x29, #0x12e
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x8]
               	sub	x17, x29, #0x12c
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0x8]
               	sub	x17, x29, #0x12a
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xa]
               	sub	x17, x29, #0x128
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xa]
               	sub	x17, x29, #0x126
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xa]
               	sub	x17, x29, #0x124
               	strh	w2, [x17]
               	ldrsh	x2, [x0, #0xa]
               	sub	x17, x29, #0x122
               	strh	w2, [x17]
               	ldr	x2, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x2, [sp, #0x4730]
               	str	x3, [sp, #0x4738]
               	str	x4, [sp, #0x4740]
               	sub	x2, x29, #0xdb0
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x2]
               	ldr	x16, [x5, #0x10]
               	str	x16, [x2, #0x10]
               	add	x3, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x4, x2, x0, lsl #3
               	ldrsh	x5, [x3, x0, lsl #1]
               	strh	w5, [x4, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xdb0
               	sub	x2, x29, #0xdc8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x16, x29, #0xdc8
               	ldrsh	x2, [x16]
               	strh	w2, [x1]
               	sub	x16, x29, #0x130
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x2]
               	sub	x16, x29, #0x128
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x4]
               	sub	x16, x29, #0x136
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x6]
               	sub	x16, x29, #0x12e
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x8]
               	sub	x16, x29, #0x126
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0xa]
               	sub	x16, x29, #0x134
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0xc]
               	sub	x16, x29, #0x12c
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0xe]
               	sub	x16, x29, #0x124
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x10]
               	sub	x16, x29, #0x132
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x12]
               	sub	x16, x29, #0x12a
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x14]
               	sub	x16, x29, #0x122
               	ldrsh	x2, [x16]
               	strh	w2, [x1, #0x16]
               	add	x2, x1, #0x18
               	sub	x3, x29, #0xde0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	sub	x0, x29, #0xdf8
               	sub	x2, x29, #0xd98
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	add	x1, x1, #0x30
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #3
               	ldrsh	x3, [x3]
               	strh	w3, [x1, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0xe10
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	sub	x2, x29, #0xdf8
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x18
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	uzp1	v1.4h, v2.4h, v3.4h
               	uzp2	v2.4h, v2.4h, v3.4h
               	uzp1	v3.4h, v4.4h, v1.4h
               	uzp1	v5.4h, v0.4h, v2.4h
               	uzp2	v1.4h, v4.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v2.4h
               	str	d3, [sp, #0x4d90]
               	str	d5, [sp, #0x4d98]
               	str	d1, [sp, #0x4da0]
               	str	d0, [sp, #0x4da8]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x1a0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x2, x29, #0x760
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x140
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x13e
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x13c
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x13a
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xa]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xa]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xa]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xa]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xc]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xc]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xc]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrsh	x1, [x0, #0xc]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d0]
               	ldr	x2, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x1, [sp, #0x4dd0]
               	str	x2, [sp, #0x4dd8]
               	str	x3, [sp, #0x4de0]
               	str	x4, [sp, #0x4de8]
               	sub	x2, x29, #0x780
               	sub	x1, x29, #0x700
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsh	x4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x700
               	sub	x0, x29, #0x720
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4df0]
               	ldr	d1, [sp, #0x4e00]
               	zip1	v0.4h, v0.4h, v1.4h
               	ldur	d1, [x29, #-0xc0]
               	ldur	d2, [x29, #-0xb0]
               	zip2	v1.4h, v1.4h, v2.4h
               	ldur	d2, [x29, #-0xb8]
               	ldur	d3, [x29, #-0xa8]
               	zip1	v4.4h, v2.4h, v3.4h
               	zip2	v2.4h, v2.4h, v3.4h
               	zip1	v3.4h, v0.4h, v4.4h
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x10
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x18
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x20
               	sub	x2, x29, #0x740
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x760
               	sub	x1, x29, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x5, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsh	x3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	sub	x2, x29, #0x780
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	sub	x2, x29, #0x760
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	str	q2, [sp, #0x2b30]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x2b40]
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x310
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x640]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x642]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x644]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x646]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x648]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x64a]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x64c]
               	ldrsh	x1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x64e]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x650]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x652]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x654]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x656]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x658]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x65a]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x65c]
               	ldrsh	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x65e]
               	ldr	q0, [sp, #0x2b50]
               	ldr	q1, [sp, #0x2b60]
               	str	q0, [sp, #0xac0]
               	str	q1, [sp, #0xad0]
               	add	x2, sp, #0xa40
               	add	x1, sp, #0xae0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsh	x4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, sp, #0xae0
               	add	x0, sp, #0xb00
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x9a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xb00]
               	ldr	q1, [sp, #0xb10]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x5]
               	ldr	q0, [sp, #0x2b70]
               	ldr	q1, [sp, #0x2b80]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x5, #0x10]
               	add	x1, x5, #0x20
               	add	x2, sp, #0xac0
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x980
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xb20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x5, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsh	x3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	ldr	x3, [x1, #0x18]
               	ldrb	w4, [x2, x0]
               	eor	x3, x3, x4
               	mov	x17, #0x1b3             // =435
               	movk	x17, #0x100, lsl #32
               	mul	x3, x3, x17
               	str	x3, [x1, #0x18]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lo	<addr>
               	add	x0, sp, #0xa40
               	mov	x20, #0x20              // =32
               	mov	x1, x20
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0x960
               	add	x4, x0, x0, lsl #1
               	ldrsh	x5, [x1, w4, sxtw #1]
               	strh	w5, [x3, x0, lsl #1]
               	add	x5, x3, #0x10
               	add	x6, x4, #0x1
               	ldrsh	x6, [x1, w6, sxtw #1]
               	strh	w6, [x5, x0, lsl #1]
               	add	x3, x3, #0x20
               	add	x4, x4, #0x2
               	ldrsh	x4, [x1, w4, sxtw #1]
               	strh	w4, [x3, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2bb0]
               	ldr	q1, [sp, #0x2bc0]
               	ldr	q2, [sp, #0x2bd0]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	add	x3, x1, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x2f0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x3, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x3, sp, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6d0]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6d2]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6d4]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6d6]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6d8]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6da]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6dc]
               	ldrsh	x0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6de]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6e0]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6e2]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6e4]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6e6]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6e8]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6ea]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6ec]
               	ldrsh	x0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6ee]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6f0]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6f2]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6f4]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6f6]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6f8]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6fa]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6fc]
               	ldrsh	x0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x6fe]
               	ldr	q0, [sp, #0x2be0]
               	ldr	q1, [sp, #0x2bf0]
               	ldr	q2, [sp, #0x2c00]
               	str	q0, [sp, #0xb40]
               	str	q1, [sp, #0xb50]
               	str	q2, [sp, #0xb60]
               	add	x0, sp, #0xa40
               	add	x3, sp, #0xb70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x4, x1, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xb70
               	add	x1, x1, x0, lsl #4
               	ldrsh	x3, [x4, x0, lsl #1]
               	strh	w3, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, sp, #0xb70
               	add	x0, sp, #0xba0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x3, x29, #0x2, lsl #12  // =0x2000
               	sub	x3, x3, #0x900
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x4, x3, #0x10
               	add	x5, x3, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrsh	x6, [x3, x0, lsl #1]
               	strh	w6, [x2, w1, sxtw #1]
               	add	x6, x1, #0x1
               	ldrsh	x7, [x4, x0, lsl #1]
               	strh	w7, [x2, w6, sxtw #1]
               	add	x1, x1, #0x2
               	ldrsh	x6, [x5, x0, lsl #1]
               	strh	w6, [x2, w1, sxtw #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x1, x2, #0x30
               	add	x3, sp, #0xb40
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x8d0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x3, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xbd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x2, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xbd0
               	add	x1, x1, x0, lsl #4
               	ldrsh	x1, [x1]
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.8h, v0.8h, v1.8h
               	uzp2	v0.8h, v0.8h, v1.8h
               	uzp1	v1.8h, v2.8h, v3.8h
               	uzp2	v2.8h, v2.8h, v3.8h
               	uzp1	v3.8h, v4.8h, v1.8h
               	str	q3, [sp, #0x2c70]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x2c80]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x2c90]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x2ca0]
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	add	x1, x5, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x2c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x1, sp, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x6
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x860
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x2]
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x2]
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x4]
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x6]
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x8]
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0xa]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x860
               	add	x3, x2, x3
               	ldrsh	x4, [x1, x0, lsl #1]
               	strh	w4, [x3, #0xc]
               	add	x2, x2, x0, lsl #4
               	ldrsh	x3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2cb0]
               	ldr	q1, [sp, #0x2cc0]
               	ldr	q2, [sp, #0x2cd0]
               	ldr	q3, [sp, #0x2ce0]
               	str	q0, [sp, #0xc00]
               	str	q1, [sp, #0xc10]
               	str	q2, [sp, #0xc20]
               	str	q3, [sp, #0xc30]
               	add	x0, sp, #0xa40
               	add	x1, sp, #0xc40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xc40
               	add	x1, x1, x0, lsl #4
               	ldrsh	x2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x1, sp, #0xc40
               	add	x0, sp, #0xc80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x820
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0xc80]
               	ldr	q1, [sp, #0xca0]
               	zip1	v0.8h, v0.8h, v1.8h
               	ldr	q1, [sp, #0x2cf0]
               	ldr	q2, [sp, #0x2d10]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x2d00]
               	ldr	q3, [sp, #0x2d20]
               	zip1	v4.8h, v2.8h, v3.8h
               	zip2	v2.8h, v2.8h, v3.8h
               	zip1	v3.8h, v0.8h, v4.8h
               	str	q3, [x20]
               	zip2	v0.8h, v0.8h, v4.8h
               	str	q0, [x20, #0x10]
               	zip1	v0.8h, v1.8h, v2.8h
               	str	q0, [x20, #0x20]
               	zip2	v0.8h, v1.8h, v2.8h
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	add	x2, sp, #0xc00
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x7e0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xcc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsh	x3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	sub	x2, x29, #0x2b0
               	str	d2, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w3, [x0, #0x4]
               	ldrh	w4, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	sub	x17, x29, #0x290
               	strh	w1, [x17]
               	sub	x17, x29, #0x28e
               	strh	w3, [x17]
               	sub	x17, x29, #0x28c
               	strh	w4, [x17]
               	sub	x17, x29, #0x28a
               	strh	w5, [x17]
               	sub	x17, x29, #0x288
               	strh	w6, [x17]
               	sub	x17, x29, #0x286
               	strh	w7, [x17]
               	sub	x17, x29, #0x284
               	strh	w8, [x17]
               	sub	x17, x29, #0x282
               	strh	w9, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4240]
               	str	x3, [sp, #0x4248]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2b0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x2c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4250]
               	ldr	d1, [sp, #0x4258]
               	zip1	v0.4h, v0.4h, v1.4h
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x4500]
               	ldr	d1, [sp, #0x4508]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x2d0
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x2a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x2]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x4]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xe]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x10]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x12]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x14]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x16]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w2, [x0, #0x4]
               	ldrh	w3, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	ldrh	w10, [x0, #0x12]
               	ldrh	w11, [x0, #0x14]
               	ldrh	w12, [x0, #0x16]
               	ldrh	w13, [x0, #0x18]
               	sub	x17, x29, #0x298
               	strh	w1, [x17]
               	sub	x17, x29, #0x296
               	strh	w2, [x17]
               	sub	x17, x29, #0x294
               	strh	w3, [x17]
               	sub	x17, x29, #0x292
               	strh	w5, [x17]
               	sub	x17, x29, #0x290
               	strh	w6, [x17]
               	sub	x17, x29, #0x28e
               	strh	w7, [x17]
               	sub	x17, x29, #0x28c
               	strh	w8, [x17]
               	sub	x17, x29, #0x28a
               	strh	w9, [x17]
               	sub	x17, x29, #0x288
               	strh	w10, [x17]
               	sub	x17, x29, #0x286
               	strh	w11, [x17]
               	sub	x17, x29, #0x284
               	strh	w12, [x17]
               	sub	x17, x29, #0x282
               	strh	w13, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4790]
               	str	x2, [sp, #0x4798]
               	str	x3, [sp, #0x47a0]
               	sub	x1, x29, #0xd50
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xd50
               	sub	x1, x29, #0xd68
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x16, x29, #0xd68
               	ldrh	w1, [x16]
               	strh	w1, [x20]
               	sub	x16, x29, #0x130
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x2]
               	sub	x16, x29, #0x128
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x4]
               	sub	x16, x29, #0x136
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x6]
               	sub	x16, x29, #0x12e
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x8]
               	sub	x16, x29, #0x126
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0xa]
               	sub	x16, x29, #0x134
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0xc]
               	sub	x16, x29, #0x12c
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0xe]
               	sub	x16, x29, #0x124
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x10]
               	sub	x16, x29, #0x132
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x12]
               	sub	x16, x29, #0x12a
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x14]
               	sub	x16, x29, #0x122
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x16]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xd80
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xd38
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	uzp1	v1.4h, v2.4h, v3.4h
               	uzp2	v2.4h, v2.4h, v3.4h
               	uzp1	v3.4h, v4.4h, v1.4h
               	uzp1	v5.4h, v0.4h, v2.4h
               	uzp2	v1.4h, v4.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v2.4h
               	str	d3, [sp, #0x5250]
               	str	d5, [sp, #0x5258]
               	str	d1, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x180
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x2, x29, #0x2a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x140
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x13e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x13c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x13a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d0]
               	ldr	x2, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x1, [sp, #0x4e50]
               	str	x2, [sp, #0x4e58]
               	str	x3, [sp, #0x4e60]
               	str	x4, [sp, #0x4e68]
               	sub	x2, x29, #0x2c0
               	sub	x1, x29, #0x680
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x680
               	sub	x0, x29, #0x6a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4e70]
               	ldr	d1, [sp, #0x4e80]
               	zip1	v0.4h, v0.4h, v1.4h
               	ldur	d1, [x29, #-0xa0]
               	ldur	d2, [x29, #-0x90]
               	zip2	v1.4h, v1.4h, v2.4h
               	ldur	d2, [x29, #-0x98]
               	ldur	d3, [x29, #-0x88]
               	zip1	v4.4h, v2.4h, v3.4h
               	zip2	v2.4h, v2.4h, v3.4h
               	zip1	v3.4h, v0.4h, v4.4h
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x6c0
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x660
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	str	q2, [sp, #0x2d70]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x2d80]
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x280
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x880]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x882]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x884]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x886]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x888]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x88a]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x88c]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x88e]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x890]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x892]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x894]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x896]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x898]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x89a]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x89c]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0x89e]
               	ldr	q0, [sp, #0x2d90]
               	ldr	q1, [sp, #0x2da0]
               	str	q0, [sp, #0xd00]
               	str	q1, [sp, #0xd10]
               	add	x2, sp, #0xa40
               	add	x1, sp, #0xd20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, sp, #0xd20
               	add	x0, sp, #0xd40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x760
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xd40]
               	ldr	q1, [sp, #0xd50]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x20]
               	ldr	q0, [sp, #0x2db0]
               	ldr	q1, [sp, #0x2dc0]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	add	x2, sp, #0xd00
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x740
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xd60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x720
               	add	x3, x0, x0, lsl #1
               	ldrh	w4, [x1, w3, sxtw #1]
               	strh	w4, [x2, x0, lsl #1]
               	add	x4, x2, #0x10
               	add	x5, x3, #0x1
               	ldrh	w5, [x1, w5, sxtw #1]
               	strh	w5, [x4, x0, lsl #1]
               	add	x2, x2, #0x20
               	add	x3, x3, #0x2
               	ldrh	w3, [x1, w3, sxtw #1]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2df0]
               	ldr	q1, [sp, #0x2e00]
               	ldr	q2, [sp, #0x2e10]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	add	x2, x1, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x260
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x910]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x912]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x914]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x916]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x918]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x91a]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x91c]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x91e]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x920]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x922]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x924]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x926]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x928]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x92a]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x92c]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x92e]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x930]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x932]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x934]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x936]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x938]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x93a]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x93c]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0x93e]
               	ldr	q0, [sp, #0x2e20]
               	ldr	q1, [sp, #0x2e30]
               	ldr	q2, [sp, #0x2e40]
               	str	q0, [sp, #0xd80]
               	str	q1, [sp, #0xd90]
               	str	q2, [sp, #0xda0]
               	add	x0, sp, #0xa40
               	add	x2, sp, #0xdb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x1, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xdb0
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, sp, #0xdb0
               	add	x0, sp, #0xde0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x6c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x2, #0x10
               	add	x4, x2, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrh	w5, [x2, x0, lsl #1]
               	strh	w5, [x20, w1, sxtw #1]
               	add	x5, x1, #0x1
               	ldrh	w6, [x3, x0, lsl #1]
               	strh	w6, [x20, w5, sxtw #1]
               	add	x1, x1, #0x2
               	ldrh	w5, [x4, x0, lsl #1]
               	strh	w5, [x20, w1, sxtw #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x1, x20, #0x30
               	add	x2, sp, #0xd80
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x690
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xe10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xe10
               	add	x1, x1, x0, lsl #4
               	ldrh	w1, [x1]
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.8h, v0.8h, v1.8h
               	uzp2	v0.8h, v0.8h, v1.8h
               	uzp1	v1.8h, v2.8h, v3.8h
               	uzp2	v2.8h, v2.8h, v3.8h
               	uzp1	v3.8h, v4.8h, v1.8h
               	str	q3, [sp, #0x2eb0]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x2ec0]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x2ed0]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x2ee0]
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	add	x1, x5, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x230
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x1, sp, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x6
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x620
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x2]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x4]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x6]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x8]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0xa]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x620
               	add	x3, x2, x3
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x3, #0xc]
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x2ef0]
               	ldr	q1, [sp, #0x2f00]
               	ldr	q2, [sp, #0x2f10]
               	ldr	q3, [sp, #0x2f20]
               	str	q0, [sp, #0xe40]
               	str	q1, [sp, #0xe50]
               	str	q2, [sp, #0xe60]
               	str	q3, [sp, #0xe70]
               	add	x0, sp, #0xa40
               	add	x1, sp, #0xe80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xe80
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x1, sp, #0xe80
               	add	x0, sp, #0xec0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x5e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0xec0]
               	ldr	q1, [sp, #0xee0]
               	zip1	v0.8h, v0.8h, v1.8h
               	ldr	q1, [sp, #0x2f30]
               	ldr	q2, [sp, #0x2f50]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x2f40]
               	ldr	q3, [sp, #0x2f60]
               	zip1	v4.8h, v2.8h, v3.8h
               	zip2	v2.8h, v2.8h, v3.8h
               	zip1	v3.8h, v0.8h, v4.8h
               	str	q3, [x20]
               	zip2	v0.8h, v0.8h, v4.8h
               	str	q0, [x20, #0x10]
               	zip1	v0.8h, v1.8h, v2.8h
               	str	q0, [x20, #0x20]
               	zip2	v0.8h, v1.8h, v2.8h
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	add	x2, sp, #0xe40
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x5a0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xf00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	sub	x2, x29, #0x2b0
               	str	d2, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w3, [x0, #0x4]
               	ldrh	w4, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	sub	x17, x29, #0x290
               	strh	w1, [x17]
               	sub	x17, x29, #0x28e
               	strh	w3, [x17]
               	sub	x17, x29, #0x28c
               	strh	w4, [x17]
               	sub	x17, x29, #0x28a
               	strh	w5, [x17]
               	sub	x17, x29, #0x288
               	strh	w6, [x17]
               	sub	x17, x29, #0x286
               	strh	w7, [x17]
               	sub	x17, x29, #0x284
               	strh	w8, [x17]
               	sub	x17, x29, #0x282
               	strh	w9, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4280]
               	str	x3, [sp, #0x4288]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x270
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x270
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x280
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4290]
               	ldr	d1, [sp, #0x4298]
               	zip1	v0.4h, v0.4h, v1.4h
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x4510]
               	ldr	d1, [sp, #0x4518]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x290
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x260
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x2]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x4]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xe]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x10]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x12]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x14]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x16]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldrh	w1, [x0, #0x2]
               	ldrh	w2, [x0, #0x4]
               	ldrh	w3, [x0, #0x6]
               	ldrh	w5, [x0, #0x8]
               	ldrh	w6, [x0, #0xa]
               	ldrh	w7, [x0, #0xc]
               	ldrh	w8, [x0, #0xe]
               	ldrh	w9, [x0, #0x10]
               	ldrh	w10, [x0, #0x12]
               	ldrh	w11, [x0, #0x14]
               	ldrh	w12, [x0, #0x16]
               	ldrh	w13, [x0, #0x18]
               	sub	x17, x29, #0x298
               	strh	w1, [x17]
               	sub	x17, x29, #0x296
               	strh	w2, [x17]
               	sub	x17, x29, #0x294
               	strh	w3, [x17]
               	sub	x17, x29, #0x292
               	strh	w5, [x17]
               	sub	x17, x29, #0x290
               	strh	w6, [x17]
               	sub	x17, x29, #0x28e
               	strh	w7, [x17]
               	sub	x17, x29, #0x28c
               	strh	w8, [x17]
               	sub	x17, x29, #0x28a
               	strh	w9, [x17]
               	sub	x17, x29, #0x288
               	strh	w10, [x17]
               	sub	x17, x29, #0x286
               	strh	w11, [x17]
               	sub	x17, x29, #0x284
               	strh	w12, [x17]
               	sub	x17, x29, #0x282
               	strh	w13, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x47f0]
               	str	x2, [sp, #0x47f8]
               	str	x3, [sp, #0x4800]
               	sub	x1, x29, #0xcf0
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xcf0
               	sub	x1, x29, #0xd08
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x16, x29, #0xd08
               	ldrh	w1, [x16]
               	strh	w1, [x20]
               	sub	x16, x29, #0x130
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x2]
               	sub	x16, x29, #0x128
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x4]
               	sub	x16, x29, #0x136
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x6]
               	sub	x16, x29, #0x12e
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x8]
               	sub	x16, x29, #0x126
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0xa]
               	sub	x16, x29, #0x134
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0xc]
               	sub	x16, x29, #0x12c
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0xe]
               	sub	x16, x29, #0x124
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x10]
               	sub	x16, x29, #0x132
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x12]
               	sub	x16, x29, #0x12a
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x14]
               	sub	x16, x29, #0x122
               	ldrh	w1, [x16]
               	strh	w1, [x20, #0x16]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xd20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xcd8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.4h, v0.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v1.4h
               	uzp1	v1.4h, v2.4h, v3.4h
               	uzp2	v2.4h, v2.4h, v3.4h
               	uzp1	v3.4h, v4.4h, v1.4h
               	uzp1	v5.4h, v0.4h, v2.4h
               	uzp2	v1.4h, v4.4h, v1.4h
               	uzp2	v0.4h, v0.4h, v2.4h
               	str	d3, [sp, #0x5250]
               	str	d5, [sp, #0x5258]
               	str	d1, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x160
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x2, x29, #0x2a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x140
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x13e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x13c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x13a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x138
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x136
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x134
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x132
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x130
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x12e
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x12c
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xa]
               	sub	x17, x29, #0x12a
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x128
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x126
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x124
               	strh	w1, [x17]
               	ldrh	w1, [x0, #0xc]
               	sub	x17, x29, #0x122
               	strh	w1, [x17]
               	ldr	x1, [sp, #0x53d0]
               	ldr	x2, [sp, #0x53d8]
               	ldr	x3, [sp, #0x53e0]
               	ldr	x4, [sp, #0x53e8]
               	str	x1, [sp, #0x4ed0]
               	str	x2, [sp, #0x4ed8]
               	str	x3, [sp, #0x4ee0]
               	str	x4, [sp, #0x4ee8]
               	sub	x2, x29, #0x2c0
               	sub	x1, x29, #0x600
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0x6]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x600
               	sub	x0, x29, #0x620
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4ef0]
               	ldr	d1, [sp, #0x4f00]
               	zip1	v0.4h, v0.4h, v1.4h
               	ldur	d1, [x29, #-0x80]
               	ldur	d2, [x29, #-0x70]
               	zip2	v1.4h, v1.4h, v2.4h
               	ldur	d2, [x29, #-0x78]
               	ldur	d3, [x29, #-0x68]
               	zip1	v4.4h, v2.4h, v3.4h
               	zip2	v2.4h, v2.4h, v3.4h
               	zip1	v3.4h, v0.4h, v4.4h
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x640
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x5e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.8h, v0.8h, v1.8h
               	str	q2, [sp, #0x2fb0]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x2fc0]
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x1f0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xac0]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xac2]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xac4]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xac6]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xac8]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xaca]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xacc]
               	ldrh	w1, [x0, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xace]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xad0]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xad2]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xad4]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xad6]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xad8]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xada]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xadc]
               	ldrh	w1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w1, [x17, #0xade]
               	ldr	q0, [sp, #0x2fd0]
               	ldr	q1, [sp, #0x2fe0]
               	str	q0, [sp, #0xf40]
               	str	q1, [sp, #0xf50]
               	add	x2, sp, #0xa40
               	add	x1, sp, #0xf60
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0xa
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrh	w4, [x2, x0, lsl #1]
               	strh	w4, [x3, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	add	x1, sp, #0xf60
               	add	x0, sp, #0xf80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x520
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0xf80]
               	ldr	q1, [sp, #0xf90]
               	zip1	v0.8h, v0.8h, v1.8h
               	str	q0, [x20]
               	ldr	q0, [sp, #0x2ff0]
               	ldr	q1, [sp, #0x3000]
               	zip2	v0.8h, v0.8h, v1.8h
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	add	x2, sp, #0xf40
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x500
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	add	x1, sp, #0xfa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x4e0
               	add	x3, x0, x0, lsl #1
               	ldrh	w4, [x1, w3, sxtw #1]
               	strh	w4, [x2, x0, lsl #1]
               	add	x4, x2, #0x10
               	add	x5, x3, #0x1
               	ldrh	w5, [x1, w5, sxtw #1]
               	strh	w5, [x4, x0, lsl #1]
               	add	x2, x2, #0x20
               	add	x3, x3, #0x2
               	ldrh	w3, [x1, w3, sxtw #1]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	ldr	q0, [sp, #0x3030]
               	ldr	q1, [sp, #0x3040]
               	ldr	q2, [sp, #0x3050]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	add	x2, x1, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x1d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb50]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb52]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb54]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb56]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb58]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb5a]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb5c]
               	ldrh	w0, [x1, #0x6]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb5e]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb60]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb62]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb64]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb66]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb68]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb6a]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb6c]
               	ldrh	w0, [x1, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb6e]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb70]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb72]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb74]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb76]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb78]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb7a]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb7c]
               	ldrh	w0, [x1, #0xa]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	strh	w0, [x17, #0xb7e]
               	ldr	q0, [sp, #0x3060]
               	ldr	q1, [sp, #0x3070]
               	ldr	q2, [sp, #0x3080]
               	str	q0, [sp, #0xfc0]
               	str	q1, [sp, #0xfd0]
               	str	q2, [sp, #0xfe0]
               	add	x0, sp, #0xa40
               	add	x2, sp, #0xff0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x1, #0xa
               	mov	x0, #0x0                // =0
               	add	x1, sp, #0xff0
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	add	x1, sp, #0xff0
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x4f0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x480
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x3, x2, #0x10
               	add	x4, x2, #0x20
               	mov	x0, #0x0                // =0
               	add	x1, x0, x0, lsl #1
               	ldrh	w5, [x2, x0, lsl #1]
               	strh	w5, [x20, w1, sxtw #1]
               	add	x5, x1, #0x1
               	ldrh	w6, [x3, x0, lsl #1]
               	strh	w6, [x20, w5, sxtw #1]
               	add	x1, x1, #0x2
               	ldrh	w5, [x4, x0, lsl #1]
               	strh	w5, [x20, w1, sxtw #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	add	x1, x20, #0x30
               	add	x2, sp, #0xfc0
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x450
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x4c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x4c0
               	add	x1, x1, x0, lsl #4
               	ldrh	w1, [x1]
               	strh	w1, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	q0, [x5]
               	ldr	q1, [x5, #0x10]
               	ldr	q2, [x5, #0x20]
               	ldr	q3, [x5, #0x30]
               	uzp1	v4.8h, v0.8h, v1.8h
               	uzp2	v0.8h, v0.8h, v1.8h
               	uzp1	v1.8h, v2.8h, v3.8h
               	uzp2	v2.8h, v2.8h, v3.8h
               	uzp1	v3.8h, v4.8h, v1.8h
               	str	q3, [sp, #0x30f0]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x3100]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x3110]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x3120]
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	add	x1, x5, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x1a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x1, sp, #0xa80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x6
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x3e0
               	lsl	x3, x0, #4
               	add	x2, x2, x3
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x2]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x4]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x6]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0x8]
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x2, #0xa]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	sub	x2, x2, #0x3e0
               	add	x3, x2, x3
               	ldrh	w4, [x1, x0, lsl #1]
               	strh	w4, [x3, #0xc]
               	add	x2, x2, x0, lsl #4
               	ldrh	w3, [x1, x0, lsl #1]
               	strh	w3, [x2, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	ldr	q0, [sp, #0x3130]
               	ldr	q1, [sp, #0x3140]
               	ldr	q2, [sp, #0x3150]
               	ldr	q3, [sp, #0x3160]
               	str	q0, [sp, #0x1080]
               	str	q1, [sp, #0x1090]
               	str	q2, [sp, #0x10a0]
               	str	q3, [sp, #0x10b0]
               	add	x0, sp, #0xa40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x450
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, x5, #0xa
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x450
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x450
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x410
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x3a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1100]
               	ldr	q1, [sp, #0x1120]
               	zip1	v0.8h, v0.8h, v1.8h
               	ldr	q1, [sp, #0x3170]
               	ldr	q2, [sp, #0x3190]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x3180]
               	ldr	q3, [sp, #0x31a0]
               	zip1	v4.8h, v2.8h, v3.8h
               	zip2	v2.8h, v2.8h, v3.8h
               	zip1	v3.8h, v0.8h, v4.8h
               	str	q3, [x20]
               	zip2	v0.8h, v0.8h, v4.8h
               	str	q0, [x20, #0x10]
               	zip1	v0.8h, v1.8h, v2.8h
               	str	q0, [x20, #0x20]
               	zip2	v0.8h, v1.8h, v2.8h
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x490
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x360
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x3d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrh	w3, [x3]
               	strh	w3, [x2, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	sub	x2, x29, #0x2b0
               	str	d2, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	sub	x17, x29, #0x290
               	str	w1, [x17]
               	sub	x17, x29, #0x28c
               	str	w3, [x17]
               	sub	x17, x29, #0x288
               	str	w4, [x17]
               	sub	x17, x29, #0x284
               	str	w5, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x42c0]
               	str	x3, [sp, #0x42c8]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x230
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x230
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x240
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0xff0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x42d0]
               	ldr	d1, [sp, #0x42d8]
               	zip1	v0.2s, v0.2s, v1.2s
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x4520]
               	ldr	d1, [sp, #0x4528]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x250
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x220
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsw	x3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x4]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x8]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x134
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	sub	x17, x29, #0x298
               	str	w1, [x17]
               	sub	x17, x29, #0x294
               	str	w2, [x17]
               	sub	x17, x29, #0x290
               	str	w3, [x17]
               	sub	x17, x29, #0x28c
               	str	w5, [x17]
               	sub	x17, x29, #0x288
               	str	w6, [x17]
               	sub	x17, x29, #0x284
               	str	w7, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x134
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4850]
               	str	x2, [sp, #0x4858]
               	str	x3, [sp, #0x4860]
               	sub	x1, x29, #0xc90
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xc90
               	sub	x1, x29, #0xca8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x16, x29, #0xca8
               	ldrsw	x1, [x16]
               	str	w1, [x20]
               	sub	x16, x29, #0x130
               	ldrsw	x1, [x16]
               	str	w1, [x20, #0x4]
               	sub	x16, x29, #0x128
               	ldrsw	x1, [x16]
               	str	w1, [x20, #0x8]
               	sub	x16, x29, #0x134
               	ldrsw	x1, [x16]
               	str	w1, [x20, #0xc]
               	sub	x16, x29, #0x12c
               	ldrsw	x1, [x16]
               	str	w1, [x20, #0x10]
               	sub	x16, x29, #0x124
               	ldrsw	x1, [x16]
               	str	w1, [x20, #0x14]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xcc0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xc78
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsw	x3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	uzp1	v1.2s, v2.2s, v3.2s
               	uzp2	v2.2s, v2.2s, v3.2s
               	uzp1	v3.2s, v4.2s, v1.2s
               	uzp1	v5.2s, v0.2s, v2.2s
               	uzp2	v1.2s, v4.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v2.2s
               	sub	x2, x29, #0x2c0
               	str	d3, [sp, #0x5250]
               	str	d5, [sp, #0x5258]
               	str	d1, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	sub	x17, x29, #0x2a0
               	str	w1, [x17]
               	sub	x17, x29, #0x29c
               	str	w3, [x17]
               	sub	x17, x29, #0x298
               	str	w4, [x17]
               	sub	x17, x29, #0x294
               	str	w5, [x17]
               	sub	x17, x29, #0x290
               	str	w6, [x17]
               	sub	x17, x29, #0x28c
               	str	w7, [x17]
               	sub	x17, x29, #0x288
               	str	w8, [x17]
               	sub	x17, x29, #0x284
               	str	w9, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x140
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x13c
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x134
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53d0]
               	ldr	x3, [sp, #0x53d8]
               	ldr	x4, [sp, #0x53e0]
               	ldr	x5, [sp, #0x53e8]
               	str	x1, [sp, #0x4f50]
               	str	x3, [sp, #0x4f58]
               	str	x4, [sp, #0x4f60]
               	str	x5, [sp, #0x4f68]
               	sub	x1, x29, #0x580
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x580
               	sub	x0, x29, #0x5a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4f70]
               	ldr	d1, [sp, #0x4f80]
               	zip1	v0.2s, v0.2s, v1.2s
               	ldur	d1, [x29, #-0x60]
               	ldur	d2, [x29, #-0x50]
               	zip2	v1.2s, v1.2s, v2.2s
               	ldur	d2, [x29, #-0x58]
               	ldur	d3, [x29, #-0x48]
               	zip1	v4.2s, v2.2s, v3.2s
               	zip2	v2.2s, v2.2s, v3.2s
               	zip1	v3.2s, v0.2s, v4.2s
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x5c0
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x560
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldrsw	x3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp, #0x31f0]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x3200]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	str	w1, [sp, #0xa80]
               	str	w3, [sp, #0xa84]
               	str	w4, [sp, #0xa88]
               	str	w5, [sp, #0xa8c]
               	str	w6, [sp, #0xa90]
               	str	w7, [sp, #0xa94]
               	str	w8, [sp, #0xa98]
               	str	w9, [sp, #0xa9c]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3210]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3214]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3218]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x321c]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3220]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3224]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3228]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x322c]
               	ldr	q0, [sp, #0x3210]
               	ldr	q1, [sp, #0x3220]
               	str	q0, [sp, #0x1180]
               	str	q1, [sp, #0x1190]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x370
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x370
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x350
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x2e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x11c0]
               	ldr	q1, [sp, #0x11d0]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3230]
               	ldr	q1, [sp, #0x3240]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x390
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x2c0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x330
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsw	x3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	str	w1, [sp, #0x3270]
               	ldrsw	x1, [x0, #0x4]
               	str	w1, [sp, #0x3280]
               	ldrsw	x1, [x0, #0x8]
               	str	w1, [sp, #0x3290]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3274]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3284]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3294]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x3278]
               	ldrsw	x1, [x0, #0x1c]
               	str	w1, [sp, #0x3288]
               	ldrsw	x1, [x0, #0x20]
               	str	w1, [sp, #0x3298]
               	ldrsw	x1, [x0, #0x24]
               	str	w1, [sp, #0x327c]
               	ldrsw	x1, [x0, #0x28]
               	str	w1, [sp, #0x328c]
               	ldrsw	x1, [x0, #0x2c]
               	str	w1, [sp, #0x329c]
               	add	x2, sp, #0xa40
               	ldr	q0, [sp, #0x3270]
               	ldr	q1, [sp, #0x3280]
               	ldr	q2, [sp, #0x3290]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	ldr	w10, [x0, #0x24]
               	ldr	w11, [x0, #0x28]
               	ldr	w12, [x0, #0x2c]
               	ldr	w13, [x0, #0x30]
               	str	w1, [sp, #0xa80]
               	str	w3, [sp, #0xa84]
               	str	w4, [sp, #0xa88]
               	str	w5, [sp, #0xa8c]
               	str	w6, [sp, #0xa90]
               	str	w7, [sp, #0xa94]
               	str	w8, [sp, #0xa98]
               	str	w9, [sp, #0xa9c]
               	str	w10, [sp, #0xaa0]
               	str	w11, [sp, #0xaa4]
               	str	w12, [sp, #0xaa8]
               	str	w13, [sp, #0xaac]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x32a0]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x32a4]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x32a8]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x32ac]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x32b0]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x32b4]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x32b8]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x32bc]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x32c0]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x32c4]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x32c8]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x32cc]
               	ldr	q0, [sp, #0x32a0]
               	ldr	q1, [sp, #0x32b0]
               	ldr	q2, [sp, #0x32c0]
               	str	q0, [sp, #0x1200]
               	str	q1, [sp, #0x1210]
               	str	q2, [sp, #0x1220]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x2e0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	w0, [sp, #0x1230]
               	ldr	w1, [sp, #0x1234]
               	ldr	w2, [sp, #0x1238]
               	ldr	w3, [sp, #0x123c]
               	ldr	w4, [sp, #0x1240]
               	ldr	w5, [sp, #0x1244]
               	ldr	w6, [sp, #0x1248]
               	ldr	w7, [sp, #0x124c]
               	ldr	w8, [sp, #0x1250]
               	ldr	w9, [sp, #0x1254]
               	ldr	w10, [sp, #0x1258]
               	ldr	w11, [sp, #0x125c]
               	str	w0, [x20]
               	str	w4, [x20, #0x4]
               	str	w8, [x20, #0x8]
               	str	w1, [x20, #0xc]
               	str	w5, [x20, #0x10]
               	str	w9, [x20, #0x14]
               	str	w2, [x20, #0x18]
               	str	w6, [x20, #0x1c]
               	str	w10, [x20, #0x20]
               	str	w3, [x20, #0x24]
               	str	w7, [x20, #0x28]
               	str	w11, [x20, #0x2c]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x310
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x240
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x2b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsw	x3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.4s, v0.4s, v1.4s
               	uzp2	v0.4s, v0.4s, v1.4s
               	uzp1	v1.4s, v2.4s, v3.4s
               	uzp2	v2.4s, v2.4s, v3.4s
               	uzp1	v3.4s, v4.4s, v1.4s
               	str	q3, [sp, #0x3300]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x3310]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x3320]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x3330]
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	add	x2, x0, #0x4
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x160
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3340]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3344]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x3348]
               	ldrsw	x1, [x0, #0xc]
               	str	w1, [sp, #0x334c]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3350]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3354]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x3358]
               	ldrsw	x1, [x0, #0x10]
               	str	w1, [sp, #0x335c]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3360]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3364]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x3368]
               	ldrsw	x1, [x0, #0x14]
               	str	w1, [sp, #0x336c]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x3370]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x3374]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x3378]
               	ldrsw	x1, [x0, #0x18]
               	str	w1, [sp, #0x337c]
               	ldr	q0, [sp, #0x3340]
               	ldr	q1, [sp, #0x3350]
               	ldr	q2, [sp, #0x3360]
               	ldr	q3, [sp, #0x3370]
               	str	q0, [sp, #0x1290]
               	str	q1, [sp, #0x12a0]
               	str	q2, [sp, #0x12b0]
               	str	q3, [sp, #0x12c0]
               	add	x2, sp, #0xa40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x240
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsw	x4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x240
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x200
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0x190
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1310]
               	ldr	q1, [sp, #0x1330]
               	zip1	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x3380]
               	ldr	q2, [sp, #0x33a0]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x3390]
               	ldr	q3, [sp, #0x33b0]
               	zip1	v4.4s, v2.4s, v3.4s
               	zip2	v2.4s, v2.4s, v3.4s
               	zip1	v3.4s, v0.4s, v4.4s
               	str	q3, [x20]
               	zip2	v0.4s, v0.4s, v4.4s
               	str	q0, [x20, #0x10]
               	zip1	v0.4s, v1.4s, v2.4s
               	str	q0, [x20, #0x20]
               	zip2	v0.4s, v1.4s, v2.4s
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x280
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x150
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x1c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldrsw	x3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	sub	x2, x29, #0x2b0
               	str	d2, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	sub	x17, x29, #0x290
               	str	w1, [x17]
               	sub	x17, x29, #0x28c
               	str	w3, [x17]
               	sub	x17, x29, #0x288
               	str	w4, [x17]
               	sub	x17, x29, #0x284
               	str	w5, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4300]
               	str	x3, [sp, #0x4308]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1f0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x200
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0xfe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4310]
               	ldr	d1, [sp, #0x4318]
               	zip1	v0.2s, v0.2s, v1.2s
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x4530]
               	ldr	d1, [sp, #0x4538]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x210
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldr	w3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	ldr	w1, [x0, #0x4]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldr	w1, [x0, #0x8]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x134
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	sub	x17, x29, #0x298
               	str	w1, [x17]
               	sub	x17, x29, #0x294
               	str	w2, [x17]
               	sub	x17, x29, #0x290
               	str	w3, [x17]
               	sub	x17, x29, #0x28c
               	str	w5, [x17]
               	sub	x17, x29, #0x288
               	str	w6, [x17]
               	sub	x17, x29, #0x284
               	str	w7, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x134
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x48b0]
               	str	x2, [sp, #0x48b8]
               	str	x3, [sp, #0x48c0]
               	sub	x1, x29, #0xc30
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xc30
               	sub	x1, x29, #0xc48
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x16, x29, #0xc48
               	ldr	w1, [x16]
               	str	w1, [x20]
               	sub	x16, x29, #0x130
               	ldr	w1, [x16]
               	str	w1, [x20, #0x4]
               	sub	x16, x29, #0x128
               	ldr	w1, [x16]
               	str	w1, [x20, #0x8]
               	sub	x16, x29, #0x134
               	ldr	w1, [x16]
               	str	w1, [x20, #0xc]
               	sub	x16, x29, #0x12c
               	ldr	w1, [x16]
               	str	w1, [x20, #0x10]
               	sub	x16, x29, #0x124
               	ldr	w1, [x16]
               	str	w1, [x20, #0x14]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xc60
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xc18
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldr	w3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	uzp1	v1.2s, v2.2s, v3.2s
               	uzp2	v2.2s, v2.2s, v3.2s
               	uzp1	v3.2s, v4.2s, v1.2s
               	uzp1	v5.2s, v0.2s, v2.2s
               	uzp2	v1.2s, v4.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v2.2s
               	sub	x2, x29, #0x2c0
               	str	d3, [sp, #0x5250]
               	str	d5, [sp, #0x5258]
               	str	d1, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	sub	x17, x29, #0x2a0
               	str	w1, [x17]
               	sub	x17, x29, #0x29c
               	str	w3, [x17]
               	sub	x17, x29, #0x298
               	str	w4, [x17]
               	sub	x17, x29, #0x294
               	str	w5, [x17]
               	sub	x17, x29, #0x290
               	str	w6, [x17]
               	sub	x17, x29, #0x28c
               	str	w7, [x17]
               	sub	x17, x29, #0x288
               	str	w8, [x17]
               	sub	x17, x29, #0x284
               	str	w9, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x140
               	str	w1, [x17]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x13c
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x138
               	str	w1, [x17]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x134
               	str	w1, [x17]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x130
               	str	w1, [x17]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x12c
               	str	w1, [x17]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x128
               	str	w1, [x17]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x124
               	str	w1, [x17]
               	ldr	x1, [sp, #0x53d0]
               	ldr	x3, [sp, #0x53d8]
               	ldr	x4, [sp, #0x53e0]
               	ldr	x5, [sp, #0x53e8]
               	str	x1, [sp, #0x4fd0]
               	str	x3, [sp, #0x4fd8]
               	str	x4, [sp, #0x4fe0]
               	str	x5, [sp, #0x4fe8]
               	sub	x1, x29, #0x500
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x500
               	sub	x0, x29, #0x520
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x4ff0]
               	ldr	d1, [sp, #0x5000]
               	zip1	v0.2s, v0.2s, v1.2s
               	ldur	d1, [x29, #-0x40]
               	ldur	d2, [x29, #-0x30]
               	zip2	v1.2s, v1.2s, v2.2s
               	ldur	d2, [x29, #-0x38]
               	ldur	d3, [x29, #-0x28]
               	zip1	v4.2s, v2.2s, v3.2s
               	zip2	v2.2s, v2.2s, v3.2s
               	zip1	v3.2s, v0.2s, v4.2s
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x540
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x4e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	ldr	w3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp, #0x3400]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x3410]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	str	w1, [sp, #0xa80]
               	str	w3, [sp, #0xa84]
               	str	w4, [sp, #0xa88]
               	str	w5, [sp, #0xa8c]
               	str	w6, [sp, #0xa90]
               	str	w7, [sp, #0xa94]
               	str	w8, [sp, #0xa98]
               	str	w9, [sp, #0xa9c]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3420]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3424]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3428]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x342c]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3430]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3434]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3438]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x343c]
               	ldr	q0, [sp, #0x3420]
               	ldr	q1, [sp, #0x3430]
               	str	q0, [sp, #0x1390]
               	str	q1, [sp, #0x13a0]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x160
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x160
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x140
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	sub	x1, x1, #0xd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x13d0]
               	ldr	q1, [sp, #0x13e0]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3440]
               	ldr	q1, [sp, #0x3450]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x180
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0xb0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	w3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	str	w1, [sp, #0x3480]
               	ldr	w1, [x0, #0x4]
               	str	w1, [sp, #0x3490]
               	ldr	w1, [x0, #0x8]
               	str	w1, [sp, #0x34a0]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3484]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3494]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x34a4]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x3488]
               	ldr	w1, [x0, #0x1c]
               	str	w1, [sp, #0x3498]
               	ldr	w1, [x0, #0x20]
               	str	w1, [sp, #0x34a8]
               	ldr	w1, [x0, #0x24]
               	str	w1, [sp, #0x348c]
               	ldr	w1, [x0, #0x28]
               	str	w1, [sp, #0x349c]
               	ldr	w1, [x0, #0x2c]
               	str	w1, [sp, #0x34ac]
               	add	x2, sp, #0xa40
               	ldr	q0, [sp, #0x3480]
               	ldr	q1, [sp, #0x3490]
               	ldr	q2, [sp, #0x34a0]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	ldr	w10, [x0, #0x24]
               	ldr	w11, [x0, #0x28]
               	ldr	w12, [x0, #0x2c]
               	ldr	w13, [x0, #0x30]
               	str	w1, [sp, #0xa80]
               	str	w3, [sp, #0xa84]
               	str	w4, [sp, #0xa88]
               	str	w5, [sp, #0xa8c]
               	str	w6, [sp, #0xa90]
               	str	w7, [sp, #0xa94]
               	str	w8, [sp, #0xa98]
               	str	w9, [sp, #0xa9c]
               	str	w10, [sp, #0xaa0]
               	str	w11, [sp, #0xaa4]
               	str	w12, [sp, #0xaa8]
               	str	w13, [sp, #0xaac]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x34b0]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x34b4]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x34b8]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x34bc]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x34c0]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x34c4]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x34c8]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x34cc]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x34d0]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x34d4]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x34d8]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x34dc]
               	ldr	q0, [sp, #0x34b0]
               	ldr	q1, [sp, #0x34c0]
               	ldr	q2, [sp, #0x34d0]
               	str	q0, [sp, #0x1410]
               	str	q1, [sp, #0x1420]
               	str	q2, [sp, #0x1430]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xd0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	w0, [sp, #0x1440]
               	ldr	w1, [sp, #0x1444]
               	ldr	w2, [sp, #0x1448]
               	ldr	w3, [sp, #0x144c]
               	ldr	w4, [sp, #0x1450]
               	ldr	w5, [sp, #0x1454]
               	ldr	w6, [sp, #0x1458]
               	ldr	w7, [sp, #0x145c]
               	ldr	w8, [sp, #0x1460]
               	ldr	w9, [sp, #0x1464]
               	ldr	w10, [sp, #0x1468]
               	ldr	w11, [sp, #0x146c]
               	str	w0, [x20]
               	str	w4, [x20, #0x4]
               	str	w8, [x20, #0x8]
               	str	w1, [x20, #0xc]
               	str	w5, [x20, #0x10]
               	str	w9, [x20, #0x14]
               	str	w2, [x20, #0x18]
               	str	w6, [x20, #0x1c]
               	str	w10, [x20, #0x20]
               	str	w3, [x20, #0x24]
               	str	w7, [x20, #0x28]
               	str	w11, [x20, #0x2c]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x100
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	w3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.4s, v0.4s, v1.4s
               	uzp2	v0.4s, v0.4s, v1.4s
               	uzp1	v1.4s, v2.4s, v3.4s
               	uzp2	v2.4s, v2.4s, v3.4s
               	uzp1	v3.4s, v4.4s, v1.4s
               	str	q3, [sp, #0x3510]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x3520]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x3530]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x3540]
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	add	x2, x0, #0x4
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x120
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, sp, #0xa80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3550]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3554]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x3558]
               	ldr	w1, [x0, #0xc]
               	str	w1, [sp, #0x355c]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3560]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3564]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x3568]
               	ldr	w1, [x0, #0x10]
               	str	w1, [sp, #0x356c]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x3570]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x3574]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x3578]
               	ldr	w1, [x0, #0x14]
               	str	w1, [sp, #0x357c]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x3580]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x3584]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x3588]
               	ldr	w1, [x0, #0x18]
               	str	w1, [sp, #0x358c]
               	ldr	q0, [sp, #0x3550]
               	ldr	q1, [sp, #0x3560]
               	ldr	q2, [sp, #0x3570]
               	ldr	q3, [sp, #0x3580]
               	str	q0, [sp, #0x14a0]
               	str	q1, [sp, #0x14b0]
               	str	q2, [sp, #0x14c0]
               	str	q3, [sp, #0x14d0]
               	add	x2, sp, #0xa40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	w4, [x2, x0, lsl #2]
               	str	w4, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x30
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xff0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xf80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1520]
               	ldr	q1, [sp, #0x1540]
               	zip1	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x3590]
               	ldr	q2, [sp, #0x35b0]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x35a0]
               	ldr	q3, [sp, #0x35c0]
               	zip1	v4.4s, v2.4s, v3.4s
               	zip2	v2.4s, v2.4s, v3.4s
               	zip1	v3.4s, v0.4s, v4.4s
               	str	q3, [x20]
               	zip2	v0.4s, v0.4s, v4.4s
               	str	q0, [x20, #0x10]
               	zip1	v0.4s, v1.4s, v2.4s
               	str	q0, [x20, #0x20]
               	zip2	v0.4s, v1.4s, v2.4s
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x70
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xf40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xfb0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	w3, [x3]
               	str	w3, [x2, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	uzp1	v2.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	sub	x2, x29, #0x2b0
               	str	d2, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	sub	x17, x29, #0x290
               	str	w1, [x17]
               	sub	x17, x29, #0x28c
               	str	w3, [x17]
               	sub	x17, x29, #0x288
               	str	w4, [x17]
               	sub	x17, x29, #0x284
               	str	w5, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x130
               	str	s0, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x12c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x128
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x124
               	str	s0, [x17]
               	ldr	x1, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4340]
               	str	x3, [sp, #0x4348]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1b0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	add	x4, x2, x0, lsl #2
               	ldr	s0, [x4]
               	str	s0, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1b0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x1c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0xfd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4350]
               	ldr	d1, [sp, #0x4358]
               	zip1	v0.2s, v0.2s, v1.2s
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x4540]
               	ldr	d1, [sp, #0x4548]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x1d0
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x1a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #2
               	add	x4, x1, x0, lsl #3
               	ldr	s0, [x4]
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	sub	x17, x29, #0x138
               	str	s0, [x17]
               	ldr	s0, [x0, #0x4]
               	sub	x17, x29, #0x130
               	str	s0, [x17]
               	ldr	s0, [x0, #0x8]
               	sub	x17, x29, #0x128
               	str	s0, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x134
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x12c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x124
               	str	s0, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w2, [x0, #0x8]
               	ldr	w3, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	sub	x17, x29, #0x298
               	str	w1, [x17]
               	sub	x17, x29, #0x294
               	str	w2, [x17]
               	sub	x17, x29, #0x290
               	str	w3, [x17]
               	sub	x17, x29, #0x28c
               	str	w5, [x17]
               	sub	x17, x29, #0x288
               	str	w6, [x17]
               	sub	x17, x29, #0x284
               	str	w7, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x138
               	str	s0, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x134
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x130
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x12c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x128
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x124
               	str	s0, [x17]
               	ldr	x1, [sp, #0x53d8]
               	ldr	x2, [sp, #0x53e0]
               	ldr	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4910]
               	str	x2, [sp, #0x4918]
               	str	x3, [sp, #0x4920]
               	sub	x1, x29, #0xbd0
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	add	x4, x2, x0, lsl #2
               	ldr	s0, [x4]
               	str	s0, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xbd0
               	sub	x1, x29, #0xbe8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x16, x29, #0xbe8
               	ldr	s0, [x16]
               	str	s0, [x20]
               	sub	x16, x29, #0x130
               	ldr	s0, [x16]
               	str	s0, [x20, #0x4]
               	sub	x16, x29, #0x128
               	ldr	s0, [x16]
               	str	s0, [x20, #0x8]
               	sub	x16, x29, #0x134
               	ldr	s0, [x16]
               	str	s0, [x20, #0xc]
               	sub	x16, x29, #0x12c
               	ldr	s0, [x16]
               	str	s0, [x20, #0x10]
               	sub	x16, x29, #0x124
               	ldr	s0, [x16]
               	str	s0, [x20, #0x14]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xc00
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xbb8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #2
               	add	x4, x1, x0, lsl #3
               	ldr	s0, [x4]
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	ldr	d2, [x0, #0x10]
               	ldr	d3, [x0, #0x18]
               	uzp1	v4.2s, v0.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v1.2s
               	uzp1	v1.2s, v2.2s, v3.2s
               	uzp2	v2.2s, v2.2s, v3.2s
               	uzp1	v3.2s, v4.2s, v1.2s
               	uzp1	v5.2s, v0.2s, v2.2s
               	uzp2	v1.2s, v4.2s, v1.2s
               	uzp2	v0.2s, v0.2s, v2.2s
               	sub	x2, x29, #0x2c0
               	str	d3, [sp, #0x5250]
               	str	d5, [sp, #0x5258]
               	str	d1, [sp, #0x5260]
               	str	d0, [sp, #0x5268]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	sub	x17, x29, #0x2a0
               	str	w1, [x17]
               	sub	x17, x29, #0x29c
               	str	w3, [x17]
               	sub	x17, x29, #0x298
               	str	w4, [x17]
               	sub	x17, x29, #0x294
               	str	w5, [x17]
               	sub	x17, x29, #0x290
               	str	w6, [x17]
               	sub	x17, x29, #0x28c
               	str	w7, [x17]
               	sub	x17, x29, #0x288
               	str	w8, [x17]
               	sub	x17, x29, #0x284
               	str	w9, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x140
               	str	s0, [x17]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x13c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x138
               	str	s0, [x17]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x134
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x130
               	str	s0, [x17]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x12c
               	str	s0, [x17]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x128
               	str	s0, [x17]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x124
               	str	s0, [x17]
               	ldr	x1, [sp, #0x53d0]
               	ldr	x3, [sp, #0x53d8]
               	ldr	x4, [sp, #0x53e0]
               	ldr	x5, [sp, #0x53e8]
               	str	x1, [sp, #0x5050]
               	str	x3, [sp, #0x5058]
               	str	x4, [sp, #0x5060]
               	str	x5, [sp, #0x5068]
               	sub	x1, x29, #0x480
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #3
               	add	x4, x2, x0, lsl #2
               	ldr	s0, [x4]
               	str	s0, [x3, #0x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x480
               	sub	x0, x29, #0x4a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	d0, [sp, #0x5070]
               	ldr	d1, [sp, #0x5080]
               	zip1	v0.2s, v0.2s, v1.2s
               	ldur	d1, [x29, #-0x20]
               	ldur	d2, [x29, #-0x10]
               	zip2	v1.2s, v1.2s, v2.2s
               	ldur	d2, [x29, #-0x18]
               	ldur	d3, [x29, #-0x8]
               	zip1	v4.2s, v2.2s, v3.2s
               	zip2	v2.2s, v2.2s, v3.2s
               	zip1	v3.2s, v0.2s, v4.2s
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x53e8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4c0
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x460
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #2
               	add	x4, x1, x0, lsl #3
               	ldr	s0, [x4]
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.4s, v0.4s, v1.4s
               	str	q2, [sp, #0x3610]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x3620]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	str	w1, [sp, #0xa80]
               	str	w3, [sp, #0xa84]
               	str	w4, [sp, #0xa88]
               	str	w5, [sp, #0xa8c]
               	str	w6, [sp, #0xa90]
               	str	w7, [sp, #0xa94]
               	str	w8, [sp, #0xa98]
               	str	w9, [sp, #0xa9c]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3630]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3634]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3638]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x363c]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3640]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3644]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x3648]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x364c]
               	ldr	q0, [sp, #0x3630]
               	ldr	q1, [sp, #0x3640]
               	str	q0, [sp, #0x15a0]
               	str	q1, [sp, #0x15b0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xf50
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	add	x4, x2, x0, lsl #2
               	ldr	s0, [x4]
               	str	s0, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xf50
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xf30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xec0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x15e0]
               	ldr	q1, [sp, #0x15f0]
               	zip1	v0.4s, v0.4s, v1.4s
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3650]
               	ldr	q1, [sp, #0x3660]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xf70
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xea0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xf10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #2
               	add	x4, x1, x0, lsl #4
               	ldr	s0, [x4]
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	str	s0, [sp, #0x3690]
               	ldr	s0, [x0, #0x4]
               	str	s0, [sp, #0x36a0]
               	ldr	s0, [x0, #0x8]
               	str	s0, [sp, #0x36b0]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3694]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x36a4]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x36b4]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x3698]
               	ldr	s0, [x0, #0x1c]
               	str	s0, [sp, #0x36a8]
               	ldr	s0, [x0, #0x20]
               	str	s0, [sp, #0x36b8]
               	ldr	s0, [x0, #0x24]
               	str	s0, [sp, #0x369c]
               	ldr	s0, [x0, #0x28]
               	str	s0, [sp, #0x36ac]
               	ldr	s0, [x0, #0x2c]
               	str	s0, [sp, #0x36bc]
               	add	x2, sp, #0xa40
               	ldr	q0, [sp, #0x3690]
               	ldr	q1, [sp, #0x36a0]
               	ldr	q2, [sp, #0x36b0]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	w1, [x0, #0x4]
               	ldr	w3, [x0, #0x8]
               	ldr	w4, [x0, #0xc]
               	ldr	w5, [x0, #0x10]
               	ldr	w6, [x0, #0x14]
               	ldr	w7, [x0, #0x18]
               	ldr	w8, [x0, #0x1c]
               	ldr	w9, [x0, #0x20]
               	ldr	w10, [x0, #0x24]
               	ldr	w11, [x0, #0x28]
               	ldr	w12, [x0, #0x2c]
               	ldr	w13, [x0, #0x30]
               	str	w1, [sp, #0xa80]
               	str	w3, [sp, #0xa84]
               	str	w4, [sp, #0xa88]
               	str	w5, [sp, #0xa8c]
               	str	w6, [sp, #0xa90]
               	str	w7, [sp, #0xa94]
               	str	w8, [sp, #0xa98]
               	str	w9, [sp, #0xa9c]
               	str	w10, [sp, #0xaa0]
               	str	w11, [sp, #0xaa4]
               	str	w12, [sp, #0xaa8]
               	str	w13, [sp, #0xaac]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36c0]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36c4]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36c8]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x36cc]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x36d0]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x36d4]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x36d8]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x36dc]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x36e0]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x36e4]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x36e8]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x36ec]
               	ldr	q0, [sp, #0x36c0]
               	ldr	q1, [sp, #0x36d0]
               	ldr	q2, [sp, #0x36e0]
               	str	q0, [sp, #0x1620]
               	str	q1, [sp, #0x1630]
               	str	q2, [sp, #0x1640]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xec0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	add	x4, x2, x0, lsl #2
               	ldr	s0, [x4]
               	str	s0, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xec0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xe90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xe20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldr	s0, [sp, #0x1680]
               	str	s0, [x20]
               	ldr	s0, [sp, #0x3700]
               	str	s0, [x20, #0x4]
               	ldr	s0, [sp, #0x3710]
               	str	s0, [x20, #0x8]
               	ldr	s0, [sp, #0x36f4]
               	str	s0, [x20, #0xc]
               	ldr	s0, [sp, #0x3704]
               	str	s0, [x20, #0x10]
               	ldr	s0, [sp, #0x3714]
               	str	s0, [x20, #0x14]
               	ldr	s0, [sp, #0x36f8]
               	str	s0, [x20, #0x18]
               	ldr	s0, [sp, #0x3708]
               	str	s0, [x20, #0x1c]
               	ldr	s0, [sp, #0x3718]
               	str	s0, [x20, #0x20]
               	ldr	s0, [sp, #0x36fc]
               	str	s0, [x20, #0x24]
               	ldr	s0, [sp, #0x370c]
               	str	s0, [x20, #0x28]
               	ldr	s0, [sp, #0x371c]
               	str	s0, [x20, #0x2c]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xef0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xdf0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #2
               	add	x4, x1, x0, lsl #4
               	ldr	s0, [x4]
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.4s, v0.4s, v1.4s
               	uzp2	v0.4s, v0.4s, v1.4s
               	uzp1	v1.4s, v2.4s, v3.4s
               	uzp2	v2.4s, v2.4s, v3.4s
               	uzp1	v3.4s, v4.4s, v1.4s
               	str	q3, [sp, #0x3750]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x3760]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x3770]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x3780]
               	add	x2, sp, #0xa40
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	add	x3, x0, #0x4
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x3, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x3, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x3, sp, #0xa80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3790]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3794]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x3798]
               	ldr	s0, [x0, #0xc]
               	str	s0, [sp, #0x379c]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37a0]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37a4]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37a8]
               	ldr	s0, [x0, #0x10]
               	str	s0, [sp, #0x37ac]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37b0]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37b4]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37b8]
               	ldr	s0, [x0, #0x14]
               	str	s0, [sp, #0x37bc]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37c0]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37c4]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37c8]
               	ldr	s0, [x0, #0x18]
               	str	s0, [sp, #0x37cc]
               	ldr	q0, [sp, #0x3790]
               	ldr	q1, [sp, #0x37a0]
               	ldr	q2, [sp, #0x37b0]
               	ldr	q3, [sp, #0x37c0]
               	str	q0, [sp, #0x16e0]
               	str	q1, [sp, #0x16f0]
               	str	q2, [sp, #0x1700]
               	str	q3, [sp, #0x1710]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xdf0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x14
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	add	x4, x2, x0, lsl #2
               	ldr	s0, [x4]
               	str	s0, [x3, #0xc]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xdf0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xdb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xd40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1760]
               	ldr	q1, [sp, #0x1780]
               	zip1	v0.4s, v0.4s, v1.4s
               	ldr	q1, [sp, #0x37d0]
               	ldr	q2, [sp, #0x37f0]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x37e0]
               	ldr	q3, [sp, #0x3800]
               	zip1	v4.4s, v2.4s, v3.4s
               	zip2	v2.4s, v2.4s, v3.4s
               	zip1	v3.4s, v0.4s, v4.4s
               	str	q3, [x20]
               	zip2	v0.4s, v0.4s, v4.4s
               	str	q0, [x20, #0x10]
               	zip1	v0.4s, v1.4s, v2.4s
               	str	q0, [x20, #0x20]
               	zip2	v0.4s, v1.4s, v2.4s
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xe30
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xd00
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xd70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #2
               	add	x4, x1, x0, lsl #4
               	ldr	s0, [x4]
               	str	s0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53e0]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53e8]
               	sub	x3, x29, #0x2b0
               	str	x1, [sp, #0x5260]
               	str	x2, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5280]
               	str	x2, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53e0]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53e8]
               	str	x1, [sp, #0x4380]
               	str	x2, [sp, #0x4388]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x170
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x170
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x180
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x1, [sp, #0x4390]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x8]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x190
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x160
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53d8]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53e0]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x5278]
               	str	x2, [sp, #0x5280]
               	str	x3, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53d8]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53e0]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4970]
               	str	x2, [sp, #0x4978]
               	str	x3, [sp, #0x4980]
               	sub	x2, x29, #0xb70
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x2]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xb70
               	sub	x1, x29, #0xb88
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	ldr	x1, [sp, #0x4988]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53e0]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x10]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xba0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xb58
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53d0]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53d8]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x53e0]
               	ldr	x4, [x0, #0x18]
               	str	x4, [sp, #0x53e8]
               	sub	x5, x29, #0x2c0
               	str	x1, [sp, #0x5250]
               	str	x2, [sp, #0x5258]
               	str	x3, [sp, #0x5260]
               	str	x4, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x0, #0x20]
               	str	x1, [sp, #0x5270]
               	str	x2, [sp, #0x5278]
               	str	x3, [sp, #0x5280]
               	str	x4, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53d0]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53d8]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x53e0]
               	ldr	x4, [x0, #0x30]
               	str	x4, [sp, #0x53e8]
               	str	x1, [sp, #0x50d0]
               	str	x2, [sp, #0x50d8]
               	str	x3, [sp, #0x50e0]
               	str	x4, [sp, #0x50e8]
               	sub	x2, x29, #0x400
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x5, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x400
               	sub	x1, x29, #0x420
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x1, [sp, #0x50f0]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53d8]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x53e0]
               	str	x1, [x20, #0x10]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x18]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x440
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x3e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3850]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3860]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3870]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3878]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3880]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3888]
               	ldr	q0, [sp, #0x3870]
               	ldr	q1, [sp, #0x3880]
               	str	q0, [sp, #0x17e0]
               	str	q1, [sp, #0x17f0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xd10
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xd10
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xcf0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xc80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1820]
               	ldr	q1, [sp, #0x1830]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3890]
               	ldr	q1, [sp, #0x38a0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xd30
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xc60
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xcd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x38d0]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x38e0]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x38f0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x38d8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x38e8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x38f8]
               	add	x2, sp, #0xa40
               	ldr	q0, [sp, #0x38d0]
               	ldr	q1, [sp, #0x38e0]
               	ldr	q2, [sp, #0x38f0]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3900]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3908]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3910]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3918]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3920]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3928]
               	ldr	q0, [sp, #0x3900]
               	ldr	q1, [sp, #0x3910]
               	ldr	q2, [sp, #0x3920]
               	str	q0, [sp, #0x1860]
               	str	q1, [sp, #0x1870]
               	str	q2, [sp, #0x1880]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc80
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x1890]
               	ldr	x1, [sp, #0x1898]
               	ldr	x2, [sp, #0x18a0]
               	ldr	x3, [sp, #0x18a8]
               	ldr	x4, [sp, #0x18b0]
               	ldr	x5, [sp, #0x18b8]
               	str	x0, [x20]
               	str	x2, [x20, #0x8]
               	str	x4, [x20, #0x10]
               	str	x1, [x20, #0x18]
               	str	x3, [x20, #0x20]
               	str	x5, [x20, #0x28]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xcb0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xbe0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3960]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x3970]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x3980]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x3990]
               	add	x2, sp, #0xa40
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	str	x8, [sp, #0xab0]
               	str	x9, [sp, #0xab8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x39a0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x39a8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x39b0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x39b8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x39c0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x39c8]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x39d0]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x39d8]
               	ldr	q0, [sp, #0x39a0]
               	ldr	q1, [sp, #0x39b0]
               	ldr	q2, [sp, #0x39c0]
               	ldr	q3, [sp, #0x39d0]
               	str	q0, [sp, #0x18f0]
               	str	q1, [sp, #0x1900]
               	str	q2, [sp, #0x1910]
               	str	q3, [sp, #0x1920]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xbe0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xbe0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xba0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xb30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1970]
               	ldr	q1, [sp, #0x1990]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x39e0]
               	ldr	q2, [sp, #0x3a00]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x39f0]
               	ldr	q3, [sp, #0x3a10]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x20]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x20, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xc20
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xaf0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xb60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53e0]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53e8]
               	sub	x3, x29, #0x2b0
               	str	x1, [sp, #0x5260]
               	str	x2, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5280]
               	str	x2, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53e0]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53e8]
               	str	x1, [sp, #0x43c0]
               	str	x2, [sp, #0x43c8]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x130
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x130
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x1, [sp, #0x43d0]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x8]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x150
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x120
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53d8]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53e0]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x5278]
               	str	x2, [sp, #0x5280]
               	str	x3, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53d8]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53e0]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x49d0]
               	str	x2, [sp, #0x49d8]
               	str	x3, [sp, #0x49e0]
               	sub	x2, x29, #0xb10
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x2]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xb10
               	sub	x1, x29, #0xb28
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	ldr	x1, [sp, #0x49e8]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53e0]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x10]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xb40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xaf8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53d0]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53d8]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x53e0]
               	ldr	x4, [x0, #0x18]
               	str	x4, [sp, #0x53e8]
               	sub	x5, x29, #0x2c0
               	str	x1, [sp, #0x5250]
               	str	x2, [sp, #0x5258]
               	str	x3, [sp, #0x5260]
               	str	x4, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x0, #0x20]
               	str	x1, [sp, #0x5270]
               	str	x2, [sp, #0x5278]
               	str	x3, [sp, #0x5280]
               	str	x4, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53d0]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53d8]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x53e0]
               	ldr	x4, [x0, #0x30]
               	str	x4, [sp, #0x53e8]
               	str	x1, [sp, #0x5150]
               	str	x2, [sp, #0x5158]
               	str	x3, [sp, #0x5160]
               	str	x4, [sp, #0x5168]
               	sub	x2, x29, #0x380
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x5, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x380
               	sub	x1, x29, #0x3a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x1, [sp, #0x5170]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53d8]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x53e0]
               	str	x1, [x20, #0x10]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x18]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x3c0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x360
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3a60]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3a70]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3a80]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3a88]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3a90]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3a98]
               	ldr	q0, [sp, #0x3a80]
               	ldr	q1, [sp, #0x3a90]
               	str	q0, [sp, #0x19f0]
               	str	q1, [sp, #0x1a00]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xb00
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xb00
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xae0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xa70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1a30]
               	ldr	q1, [sp, #0x1a40]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3aa0]
               	ldr	q1, [sp, #0x3ab0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xb20
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xa50
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xac0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x3ae0]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x3af0]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x3b00]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3ae8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3af8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3b08]
               	add	x2, sp, #0xa40
               	ldr	q0, [sp, #0x3ae0]
               	ldr	q1, [sp, #0x3af0]
               	ldr	q2, [sp, #0x3b00]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3b10]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3b18]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3b20]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3b28]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3b30]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3b38]
               	ldr	q0, [sp, #0x3b10]
               	ldr	q1, [sp, #0x3b20]
               	ldr	q2, [sp, #0x3b30]
               	str	q0, [sp, #0x1a70]
               	str	q1, [sp, #0x1a80]
               	str	q2, [sp, #0x1a90]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xa70
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x1aa0]
               	ldr	x1, [sp, #0x1aa8]
               	ldr	x2, [sp, #0x1ab0]
               	ldr	x3, [sp, #0x1ab8]
               	ldr	x4, [sp, #0x1ac0]
               	ldr	x5, [sp, #0x1ac8]
               	str	x0, [x20]
               	str	x2, [x20, #0x8]
               	str	x4, [x20, #0x10]
               	str	x1, [x20, #0x18]
               	str	x3, [x20, #0x20]
               	str	x5, [x20, #0x28]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xaa0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x9d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3b70]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x3b80]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x3b90]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x3ba0]
               	add	x2, sp, #0xa40
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	str	x8, [sp, #0xab0]
               	str	x9, [sp, #0xab8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3bb0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3bb8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3bc0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3bc8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3bd0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3bd8]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3be0]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3be8]
               	ldr	q0, [sp, #0x3bb0]
               	ldr	q1, [sp, #0x3bc0]
               	ldr	q2, [sp, #0x3bd0]
               	ldr	q3, [sp, #0x3be0]
               	str	q0, [sp, #0x1b00]
               	str	q1, [sp, #0x1b10]
               	str	q2, [sp, #0x1b20]
               	str	q3, [sp, #0x1b30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x9d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x9d0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x990
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x920
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1b80]
               	ldr	q1, [sp, #0x1ba0]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x3bf0]
               	ldr	q2, [sp, #0x3c10]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x3c00]
               	ldr	q3, [sp, #0x3c20]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x20]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x20, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0xa10
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x8e0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x950
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53e0]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53e8]
               	sub	x3, x29, #0x2b0
               	str	x1, [sp, #0x5260]
               	str	x2, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x5280]
               	str	x2, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53e0]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53e8]
               	str	x1, [sp, #0x4400]
               	str	x2, [sp, #0x4408]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xf0
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x2]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xf0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x1, [sp, #0x4410]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x8]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x110
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	add	x2, x20, #0x20
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53d8]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53e0]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x53e8]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x5258]
               	str	x2, [sp, #0x5260]
               	str	x3, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x5278]
               	str	x2, [sp, #0x5280]
               	str	x3, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53d8]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53e0]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x53e8]
               	str	x1, [sp, #0x4a30]
               	str	x2, [sp, #0x4a38]
               	str	x3, [sp, #0x4a40]
               	sub	x2, x29, #0xab0
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x2]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xab0
               	sub	x1, x29, #0xac8
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	ldr	x1, [sp, #0x4a48]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53e0]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x10]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xae0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x1, x29, #0xa98
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	add	x2, x20, #0x30
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x53d0]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x53d8]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x53e0]
               	ldr	x4, [x0, #0x18]
               	str	x4, [sp, #0x53e8]
               	sub	x5, x29, #0x2c0
               	str	x1, [sp, #0x5250]
               	str	x2, [sp, #0x5258]
               	str	x3, [sp, #0x5260]
               	str	x4, [sp, #0x5268]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x0, #0x20]
               	str	x1, [sp, #0x5270]
               	str	x2, [sp, #0x5278]
               	str	x3, [sp, #0x5280]
               	str	x4, [sp, #0x5288]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x53d0]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x53d8]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x53e0]
               	ldr	x4, [x0, #0x30]
               	str	x4, [sp, #0x53e8]
               	str	x1, [sp, #0x51d0]
               	str	x2, [sp, #0x51d8]
               	str	x3, [sp, #0x51e0]
               	str	x4, [sp, #0x51e8]
               	sub	x2, x29, #0x300
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x5, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	x1, [x1]
               	str	x1, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x300
               	sub	x1, x29, #0x320
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x1, [sp, #0x51f0]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x53d8]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x53e0]
               	str	x1, [x20, #0x10]
               	ldr	x1, [sp, #0x53e8]
               	str	x1, [x20, #0x18]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x340
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x1, x29, #0x2e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	ldr	x3, [x1, x0, lsl #3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3c70]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3c80]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3c90]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3c98]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3ca0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3ca8]
               	ldr	q0, [sp, #0x3c90]
               	ldr	q1, [sp, #0x3ca0]
               	str	q0, [sp, #0x1c00]
               	str	q1, [sp, #0x1c10]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8f0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8f0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x8d0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x860
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1c40]
               	ldr	q1, [sp, #0x1c50]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3cb0]
               	ldr	q1, [sp, #0x3cc0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x910
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x840
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	str	x1, [sp, #0x3cf0]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x3d00]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x3d10]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3cf8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3d08]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3d18]
               	add	x2, sp, #0xa40
               	ldr	q0, [sp, #0x3cf0]
               	ldr	q1, [sp, #0x3d00]
               	ldr	q2, [sp, #0x3d10]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3d20]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3d28]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3d30]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3d38]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3d40]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3d48]
               	ldr	q0, [sp, #0x3d20]
               	ldr	q1, [sp, #0x3d30]
               	ldr	q2, [sp, #0x3d40]
               	str	q0, [sp, #0x1c80]
               	str	q1, [sp, #0x1c90]
               	str	q2, [sp, #0x1ca0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x860
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	ldr	x0, [sp, #0x1cb0]
               	ldr	x1, [sp, #0x1cb8]
               	ldr	x2, [sp, #0x1cc0]
               	ldr	x3, [sp, #0x1cc8]
               	ldr	x4, [sp, #0x1cd0]
               	ldr	x5, [sp, #0x1cd8]
               	str	x0, [x20]
               	str	x2, [x20, #0x8]
               	str	x4, [x20, #0x10]
               	str	x1, [x20, #0x18]
               	str	x3, [x20, #0x20]
               	str	x5, [x20, #0x28]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x890
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x7c0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x830
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3d80]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x3d90]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x3da0]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x3db0]
               	add	x2, sp, #0xa40
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	str	x8, [sp, #0xab0]
               	str	x9, [sp, #0xab8]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3dc0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x3dc8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3dd0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x3dd8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3de0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x3de8]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3df0]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x3df8]
               	ldr	q0, [sp, #0x3dc0]
               	ldr	q1, [sp, #0x3dd0]
               	ldr	q2, [sp, #0x3de0]
               	ldr	q3, [sp, #0x3df0]
               	str	q0, [sp, #0x1d10]
               	str	q1, [sp, #0x1d20]
               	str	q2, [sp, #0x1d30]
               	str	q3, [sp, #0x1d40]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x7c0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x4, [x2, x0, lsl #3]
               	str	x4, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x7c0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x780
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x710
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1d90]
               	ldr	q1, [sp, #0x1db0]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x3e00]
               	ldr	q2, [sp, #0x3e20]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x3e10]
               	ldr	q3, [sp, #0x3e30]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x20]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x20, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x800
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x6d0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x740
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	ldr	x3, [x3]
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x40              // =64
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	str	d0, [sp, #0x53e0]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x53e8]
               	sub	x1, x29, #0x2b0
               	str	d0, [sp, #0x5260]
               	str	d1, [sp, #0x5268]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	str	x2, [sp, #0x5280]
               	str	x3, [sp, #0x5288]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x53e0]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x53e8]
               	str	d0, [sp, #0x4440]
               	str	d1, [sp, #0x4448]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xb0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	d0, [x1]
               	str	d0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0xb0
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0xc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x130
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	d0, [sp, #0x4450]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x53e8]
               	str	d0, [x20, #0x8]
               	add	x1, x20, #0x10
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xd0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x290
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	add	x3, x20, #0x20
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x3, x1
               	add	x1, x2, x1
               	ldr	d0, [x1]
               	str	d0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b0
               	mov	x22, #0x10              // =16
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x290
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	str	d0, [sp, #0x53d8]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x53e0]
               	ldr	d2, [x0, #0x10]
               	str	d2, [sp, #0x53e8]
               	sub	x1, x29, #0x2b8
               	str	d0, [sp, #0x5258]
               	str	d1, [sp, #0x5260]
               	str	d2, [sp, #0x5268]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	str	x2, [sp, #0x5278]
               	str	x3, [sp, #0x5280]
               	str	x4, [sp, #0x5288]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x53d8]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x53e0]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x53e8]
               	str	d0, [sp, #0x4a90]
               	str	d1, [sp, #0x4a98]
               	str	d2, [sp, #0x4aa0]
               	sub	x2, x29, #0xa50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	d0, [x1]
               	str	d0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xa50
               	sub	x1, x29, #0xa68
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x138
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	ldr	d0, [sp, #0x4aa8]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x53e0]
               	str	d0, [x20, #0x8]
               	ldr	d0, [sp, #0x53e8]
               	str	d0, [x20, #0x10]
               	add	x1, x20, #0x18
               	sub	x2, x29, #0xa80
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0x298
               	sub	x2, x29, #0xa38
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x2, #0x10]
               	add	x3, x20, #0x30
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x3, x1
               	add	x1, x2, x1
               	ldr	d0, [x1]
               	str	d0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2b8
               	mov	x22, #0x18              // =24
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x298
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	str	d0, [sp, #0x53d0]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x53d8]
               	ldr	d2, [x0, #0x10]
               	str	d2, [sp, #0x53e0]
               	ldr	d3, [x0, #0x18]
               	str	d3, [sp, #0x53e8]
               	sub	x1, x29, #0x2c0
               	str	d0, [sp, #0x5250]
               	str	d1, [sp, #0x5258]
               	str	d2, [sp, #0x5260]
               	str	d3, [sp, #0x5268]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x2, [sp, #0x5270]
               	str	x3, [sp, #0x5278]
               	str	x4, [sp, #0x5280]
               	str	x5, [sp, #0x5288]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x53d0]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x53d8]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x53e0]
               	ldr	d3, [x0, #0x30]
               	str	d3, [sp, #0x53e8]
               	str	d0, [sp, #0x5290]
               	str	d1, [sp, #0x5298]
               	str	d2, [sp, #0x52a0]
               	str	d3, [sp, #0x52a8]
               	sub	x2, x29, #0x240
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x3, x0, #0x28
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x2, x1
               	add	x1, x3, x1
               	ldr	d0, [x1]
               	str	d0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x240
               	sub	x1, x29, #0x260
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x140
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	d0, [sp, #0x52b0]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x53d8]
               	str	d0, [x20, #0x8]
               	ldr	d0, [sp, #0x53e0]
               	str	d0, [x20, #0x10]
               	ldr	d0, [sp, #0x53e8]
               	str	d0, [x20, #0x18]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x280
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x2a0
               	sub	x2, x29, #0x220
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x3, x20, #0x40
               	mov	x0, #0x0                // =0
               	lsl	x1, x0, #3
               	add	x4, x3, x1
               	add	x1, x2, x1
               	ldr	d0, [x1]
               	str	d0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sub	x0, x29, #0x2c0
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x29, #0x2a0
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	uzp1	v2.2d, v0.2d, v1.2d
               	str	q2, [sp, #0x3e80]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x3e90]
               	add	x2, sp, #0xa40
               	str	q2, [sp, #0xa40]
               	str	q0, [sp, #0xa50]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x3ea0]
               	ldr	d1, [x0, #0x18]
               	str	d1, [sp, #0x3ea8]
               	ldr	d2, [x0, #0x20]
               	str	d2, [sp, #0x3eb0]
               	ldr	d3, [x0, #0x20]
               	str	d3, [sp, #0x3eb8]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	str	q0, [sp, #0x1e10]
               	str	q1, [sp, #0x1e20]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x6e0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	add	x4, x2, x0, lsl #3
               	ldr	d0, [x4]
               	str	d0, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x6e0
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x6c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x650
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldr	q0, [sp, #0x1e50]
               	ldr	q1, [sp, #0x1e60]
               	zip1	v0.2d, v0.2d, v1.2d
               	str	q0, [x20]
               	ldr	q0, [sp, #0x3ec0]
               	ldr	q1, [sp, #0x3ed0]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x700
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x630
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x6a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x2, x20, #0x40
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #3
               	add	x4, x1, x0, lsl #4
               	ldr	d0, [x4]
               	str	d0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x20              // =32
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	str	d0, [sp, #0x3f00]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x3f10]
               	ldr	d2, [x0, #0x10]
               	str	d2, [sp, #0x3f20]
               	ldr	d3, [x0, #0x18]
               	str	d3, [sp, #0x3f08]
               	ldr	d4, [x0, #0x20]
               	str	d4, [sp, #0x3f18]
               	ldr	d5, [x0, #0x28]
               	str	d5, [sp, #0x3f28]
               	add	x2, sp, #0xa40
               	mov	v0.d[1], v3.d[0]
               	mov	v1.d[1], v4.d[0]
               	mov	v2.d[1], v5.d[0]
               	str	q0, [sp, #0xa40]
               	str	q1, [sp, #0xa50]
               	str	q2, [sp, #0xa60]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x3f30]
               	ldr	d1, [x0, #0x18]
               	str	d1, [sp, #0x3f38]
               	ldr	d2, [x0, #0x20]
               	str	d2, [sp, #0x3f40]
               	ldr	d3, [x0, #0x20]
               	str	d3, [sp, #0x3f48]
               	ldr	d4, [x0, #0x28]
               	str	d4, [sp, #0x3f50]
               	ldr	d5, [x0, #0x28]
               	str	d5, [sp, #0x3f58]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	zip1	v2.2d, v4.2d, v5.2d
               	str	q0, [sp, #0x1e90]
               	str	q1, [sp, #0x1ea0]
               	str	q2, [sp, #0x1eb0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x650
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	add	x4, x2, x0, lsl #3
               	ldr	d0, [x4]
               	str	d0, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x650
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x620
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x5b0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldr	d0, [sp, #0x1ef0]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x3f70]
               	str	d0, [x20, #0x8]
               	ldr	d0, [sp, #0x3f80]
               	str	d0, [x20, #0x10]
               	ldr	d0, [sp, #0x3f68]
               	str	d0, [x20, #0x18]
               	ldr	d0, [sp, #0x3f78]
               	str	d0, [x20, #0x20]
               	ldr	d0, [sp, #0x3f88]
               	str	d0, [x20, #0x28]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x680
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x580
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x5f0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #3
               	add	x4, x1, x0, lsl #4
               	ldr	d0, [x4]
               	str	d0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x1, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x22, #0x30              // =48
               	mov	x1, x22
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x22
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q0, [x0]
               	ldr	q1, [x0, #0x10]
               	ldr	q2, [x0, #0x20]
               	ldr	q3, [x0, #0x30]
               	uzp1	v4.2d, v0.2d, v1.2d
               	uzp2	v0.2d, v0.2d, v1.2d
               	uzp1	v1.2d, v2.2d, v3.2d
               	uzp2	v2.2d, v2.2d, v3.2d
               	uzp1	v3.2d, v4.2d, v1.2d
               	str	q3, [sp, #0x3fc0]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x3fd0]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x3fe0]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x3ff0]
               	add	x2, sp, #0xa40
               	str	q3, [sp, #0xa40]
               	str	q5, [sp, #0xa50]
               	str	q1, [sp, #0xa60]
               	str	q0, [sp, #0xa70]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	ldr	x6, [x0, #0x28]
               	ldr	x7, [x0, #0x30]
               	ldr	x8, [x0, #0x38]
               	ldr	x9, [x0, #0x40]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	str	x6, [sp, #0xaa0]
               	str	x7, [sp, #0xaa8]
               	str	x8, [sp, #0xab0]
               	str	x9, [sp, #0xab8]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x4000]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x4008]
               	ldr	d0, [x0, #0x20]
               	str	d0, [sp, #0x4010]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x4018]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x4020]
               	ldr	d3, [x0, #0x28]
               	str	d3, [sp, #0x4028]
               	ldr	d4, [x0, #0x30]
               	str	d4, [sp, #0x4030]
               	ldr	d5, [x0, #0x30]
               	str	d5, [sp, #0x4038]
               	ldr	q6, [sp, #0x4000]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	zip1	v2.2d, v4.2d, v5.2d
               	str	q6, [sp, #0x1f50]
               	str	q0, [sp, #0x1f60]
               	str	q1, [sp, #0x1f70]
               	str	q2, [sp, #0x1f80]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x580
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x0, #0x28
               	mov	x0, #0x0                // =0
               	add	x3, x1, x0, lsl #4
               	add	x4, x2, x0, lsl #3
               	ldr	d0, [x4]
               	str	d0, [x3, #0x8]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x580
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x540
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x4d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldr	q0, [sp, #0x1fd0]
               	ldr	q1, [sp, #0x1ff0]
               	zip1	v0.2d, v0.2d, v1.2d
               	ldr	q1, [sp, #0x4040]
               	ldr	q2, [sp, #0x4060]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x4050]
               	ldr	q3, [sp, #0x4070]
               	zip1	v4.2d, v2.2d, v3.2d
               	zip2	v2.2d, v2.2d, v3.2d
               	zip1	v3.2d, v0.2d, v4.2d
               	str	q3, [x20]
               	zip2	v0.2d, v0.2d, v4.2d
               	str	q0, [x20, #0x10]
               	zip1	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x20]
               	zip2	v0.2d, v1.2d, v2.2d
               	str	q0, [x20, #0x30]
               	add	x1, x20, #0x40
               	sub	x2, x29, #0x3, lsl #12  // =0x3000
               	sub	x2, x2, #0x5c0
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x490
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa80
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x500
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x2, x20, #0x80
               	mov	x0, #0x0                // =0
               	add	x3, x2, x0, lsl #3
               	add	x4, x1, x0, lsl #4
               	ldr	d0, [x4]
               	str	d0, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x200              // =512
               	bl	<addr>
               	add	x0, sp, #0xa40
               	mov	x20, #0x40              // =64
               	mov	x1, x20
               	bl	<addr>
               	add	x0, sp, #0xa80
               	mov	x1, x20
               	bl	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x64
               	b.lt	<addr>
               	adrp	x0, <page>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	ldr	x0, [x0, #0x18]
               	mov	x17, #0x6be0            // =27616
               	movk	x17, #0x6974, lsl #16
               	movk	x17, #0x4a86, lsl #32
               	movk	x17, #0x175c, lsl #48
               	cmp	x0, x17
               	csel	x0, x1, x2, eq
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x5, lsl #12   // =0x5000
               	add	sp, sp, #0x510
               	ldp	x29, x30, [sp], #0x10
               	ret
