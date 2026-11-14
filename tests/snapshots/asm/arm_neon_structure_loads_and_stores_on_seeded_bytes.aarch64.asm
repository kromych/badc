
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
               	mov	x16, #0x6               // =6
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x16, x16, #0x1
               	b.ne	<addr>
               	sub	sp, sp, #0x3b0
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
               	str	d2, [sp, #0x4f60]
               	str	d0, [sp, #0x4f68]
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
               	ldr	x1, [sp, #0x5350]
               	ldr	x2, [sp, #0x5358]
               	str	x1, [sp, #0x4f80]
               	str	x2, [sp, #0x4f88]
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
               	ldr	d0, [sp, #0x4f90]
               	ldr	d1, [sp, #0x4f98]
               	zip1	v0.8b, v0.8b, v1.8b
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x5360]
               	ldr	d1, [sp, #0x5368]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [sp, #0x6288]
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
               	ldr	x0, [sp, #0x59d8]
               	ldr	x3, [sp, #0x59e0]
               	ldr	x4, [sp, #0x59e8]
               	str	x0, [sp, #0x53f0]
               	str	x3, [sp, #0x53f8]
               	str	x4, [sp, #0x5400]
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
               	ldr	x0, [sp, #0x59d8]
               	ldr	x3, [sp, #0x59e0]
               	ldr	x4, [sp, #0x59e8]
               	str	x0, [sp, #0x5420]
               	str	x3, [sp, #0x5428]
               	str	x4, [sp, #0x5430]
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
               	str	d3, [sp, #0x59f0]
               	str	d5, [sp, #0x59f8]
               	str	d1, [sp, #0x5a00]
               	str	d0, [sp, #0x5a08]
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
               	ldr	x0, [sp, #0x6270]
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x0, [sp, #0x5a30]
               	str	x1, [sp, #0x5a38]
               	str	x2, [sp, #0x5a40]
               	str	x3, [sp, #0x5a48]
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
               	ldr	d0, [sp, #0x5a50]
               	ldr	d1, [sp, #0x5a60]
               	zip1	v0.8b, v0.8b, v1.8b
               	ldr	d1, [sp, #0x6290]
               	ldr	d2, [sp, #0x62a0]
               	zip2	v1.8b, v1.8b, v2.8b
               	ldr	d2, [sp, #0x6298]
               	ldr	d3, [sp, #0x62a8]
               	zip1	v4.8b, v2.8b, v3.8b
               	zip2	v2.8b, v2.8b, v3.8b
               	zip1	v3.8b, v0.8b, v4.8b
               	sub	x0, x29, #0x128
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x6]
               	add	x1, x6, #0x8
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x10
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x18
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x3310]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x3320]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x360
               	str	q2, [sp, #0x2050]
               	str	q0, [sp, #0x2060]
               	add	x1, sp, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x340
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x320
               	ldr	q0, [sp, #0x3330]
               	ldr	q1, [sp, #0x3340]
               	str	q0, [sp, #0x2090]
               	str	q1, [sp, #0x20a0]
               	add	x1, sp, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
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
               	ldr	q0, [sp, #0x3350]
               	ldr	q1, [sp, #0x3360]
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x300
               	ldr	q0, [sp, #0x3390]
               	ldr	q1, [sp, #0x33a0]
               	ldr	q2, [sp, #0x33b0]
               	str	q0, [sp, #0x20b0]
               	str	q1, [sp, #0x20c0]
               	str	q2, [sp, #0x20d0]
               	add	x1, sp, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x1
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x2d0
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x2a0
               	ldr	q0, [sp, #0x33c0]
               	ldr	q1, [sp, #0x33d0]
               	ldr	q2, [sp, #0x33e0]
               	str	q0, [sp, #0x2110]
               	str	q1, [sp, #0x2120]
               	str	q2, [sp, #0x2130]
               	add	x1, sp, #0x140
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
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
               	str	q3, [sp, #0x3450]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x3460]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x3470]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x3480]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x270
               	str	q3, [sp, #0x2140]
               	str	q5, [sp, #0x2150]
               	str	q1, [sp, #0x2160]
               	str	q0, [sp, #0x2170]
               	add	x1, sp, #0x200
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x230
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x1f0
               	ldr	q0, [sp, #0x3490]
               	ldr	q1, [sp, #0x34a0]
               	ldr	q2, [sp, #0x34b0]
               	ldr	q3, [sp, #0x34c0]
               	str	q0, [sp, #0x21c0]
               	str	q1, [sp, #0x21d0]
               	str	q2, [sp, #0x21e0]
               	str	q3, [sp, #0x21f0]
               	add	x1, sp, #0x280
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
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
               	ldr	q1, [sp, #0x34d0]
               	ldr	q2, [sp, #0x34f0]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x34e0]
               	ldr	q3, [sp, #0x3500]
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
               	str	d2, [sp, #0x4fc0]
               	str	d0, [sp, #0x4fc8]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x2, [sp, #0x6288]
               	str	x1, [sp, #0x4fe0]
               	str	x2, [sp, #0x4fe8]
               	sub	x2, x29, #0x1, lsl #12  // =0x1000
               	sub	x2, x2, #0x3f0
               	add	x1, sp, #0x5, lsl #12   // =0x5000
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
               	add	x1, sp, #0x5, lsl #12   // =0x5000
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	sub	x0, x0, #0x3c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x1, lsl #12  // =0x1000
               	sub	x1, x1, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	d0, [sp, #0x4ff0]
               	ldr	d1, [sp, #0x4ff8]
               	zip1	v0.8b, v0.8b, v1.8b
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	ldr	d0, [sp, #0x5370]
               	ldr	d1, [sp, #0x5378]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [sp, #0x6288]
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
               	ldr	x0, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x0, [sp, #0x5480]
               	str	x3, [sp, #0x5488]
               	str	x4, [sp, #0x5490]
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
               	ldr	x0, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x0, [sp, #0x54b0]
               	str	x3, [sp, #0x54b8]
               	str	x4, [sp, #0x54c0]
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
               	str	d3, [sp, #0x5ab0]
               	str	d5, [sp, #0x5ab8]
               	str	d1, [sp, #0x5ac0]
               	str	d0, [sp, #0x5ac8]
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
               	ldr	x0, [sp, #0x6270]
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x0, [sp, #0x5af0]
               	str	x1, [sp, #0x5af8]
               	str	x2, [sp, #0x5b00]
               	str	x3, [sp, #0x5b08]
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
               	ldr	d0, [sp, #0x5b10]
               	ldr	d1, [sp, #0x5b20]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x6]
               	add	x1, x6, #0x8
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x10
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x18
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x3550]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x3560]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x1b0
               	str	q2, [sp, #0x2200]
               	str	q0, [sp, #0x2210]
               	add	x1, sp, #0x380
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x190
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x170
               	ldr	q0, [sp, #0x3570]
               	ldr	q1, [sp, #0x3580]
               	str	q0, [sp, #0x2240]
               	str	q1, [sp, #0x2250]
               	add	x1, sp, #0x3c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
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
               	ldr	q0, [sp, #0x3590]
               	ldr	q1, [sp, #0x35a0]
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x150
               	ldr	q0, [sp, #0x35d0]
               	ldr	q1, [sp, #0x35e0]
               	ldr	q2, [sp, #0x35f0]
               	str	q0, [sp, #0x2260]
               	str	q1, [sp, #0x2270]
               	str	q2, [sp, #0x2280]
               	add	x1, sp, #0x440
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x1
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x120
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xf0
               	ldr	q0, [sp, #0x3600]
               	ldr	q1, [sp, #0x3610]
               	ldr	q2, [sp, #0x3620]
               	str	q0, [sp, #0x22c0]
               	str	q1, [sp, #0x22d0]
               	str	q2, [sp, #0x22e0]
               	add	x1, sp, #0x4a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
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
               	str	q3, [sp, #0x3690]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x36a0]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x36b0]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x36c0]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xc0
               	str	q3, [sp, #0x22f0]
               	str	q5, [sp, #0x2300]
               	str	q1, [sp, #0x2310]
               	str	q0, [sp, #0x2320]
               	add	x1, sp, #0x560
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x80
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
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x40
               	ldr	q0, [sp, #0x36d0]
               	ldr	q1, [sp, #0x36e0]
               	ldr	q2, [sp, #0x36f0]
               	ldr	q3, [sp, #0x3700]
               	str	q0, [sp, #0x2370]
               	str	q1, [sp, #0x2380]
               	str	q2, [sp, #0x2390]
               	str	q3, [sp, #0x23a0]
               	add	x1, sp, #0x5e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
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
               	ldr	q1, [sp, #0x3710]
               	ldr	q2, [sp, #0x3730]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x3720]
               	ldr	q3, [sp, #0x3740]
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
               	str	d2, [sp, #0x5020]
               	str	d0, [sp, #0x5028]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x2, [sp, #0x6288]
               	str	x1, [sp, #0x5040]
               	str	x2, [sp, #0x5048]
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
               	ldr	d0, [sp, #0x5050]
               	ldr	d1, [sp, #0x5058]
               	zip1	v0.8b, v0.8b, v1.8b
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	ldr	d0, [sp, #0x5380]
               	ldr	d1, [sp, #0x5388]
               	zip2	v0.8b, v0.8b, v1.8b
               	str	d0, [sp, #0x6288]
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
               	ldr	x0, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x0, [sp, #0x5510]
               	str	x3, [sp, #0x5518]
               	str	x4, [sp, #0x5520]
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
               	ldr	x0, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x0, [sp, #0x5540]
               	str	x3, [sp, #0x5548]
               	str	x4, [sp, #0x5550]
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
               	str	d3, [sp, #0x5b70]
               	str	d5, [sp, #0x5b78]
               	str	d1, [sp, #0x5b80]
               	str	d0, [sp, #0x5b88]
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
               	ldr	x0, [sp, #0x6270]
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x0, [sp, #0x5bb0]
               	str	x1, [sp, #0x5bb8]
               	str	x2, [sp, #0x5bc0]
               	str	x3, [sp, #0x5bc8]
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
               	ldr	d0, [sp, #0x5bd0]
               	ldr	d1, [sp, #0x5be0]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x6]
               	add	x1, x6, #0x8
               	zip2	v0.8b, v0.8b, v4.8b
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x10
               	zip1	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x6, #0x18
               	zip2	v0.8b, v1.8b, v2.8b
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x3790]
               	uzp2	v0.16b, v0.16b, v1.16b
               	str	q0, [sp, #0x37a0]
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	str	q2, [sp, #0x23b0]
               	str	q0, [sp, #0x23c0]
               	add	x1, sp, #0x6e0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xfe0
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xfc0
               	ldr	q0, [sp, #0x37b0]
               	ldr	q1, [sp, #0x37c0]
               	str	q0, [sp, #0x23f0]
               	str	q1, [sp, #0x2400]
               	add	x1, sp, #0x720
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
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
               	ldr	q0, [sp, #0x37d0]
               	ldr	q1, [sp, #0x37e0]
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xfa0
               	ldr	q0, [sp, #0x3810]
               	ldr	q1, [sp, #0x3820]
               	ldr	q2, [sp, #0x3830]
               	str	q0, [sp, #0x2410]
               	str	q1, [sp, #0x2420]
               	str	q2, [sp, #0x2430]
               	add	x1, sp, #0x7a0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x1, x3, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xf70
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xf40
               	ldr	q0, [sp, #0x3840]
               	ldr	q1, [sp, #0x3850]
               	ldr	q2, [sp, #0x3860]
               	str	q0, [sp, #0x2470]
               	str	q1, [sp, #0x2480]
               	str	q2, [sp, #0x2490]
               	add	x1, sp, #0x800
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
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
               	str	q3, [sp, #0x38d0]
               	uzp1	v5.16b, v0.16b, v2.16b
               	str	q5, [sp, #0x38e0]
               	uzp2	v1.16b, v4.16b, v1.16b
               	str	q1, [sp, #0x38f0]
               	uzp2	v0.16b, v0.16b, v2.16b
               	str	q0, [sp, #0x3900]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xf10
               	str	q3, [sp, #0x24a0]
               	str	q5, [sp, #0x24b0]
               	str	q1, [sp, #0x24c0]
               	str	q0, [sp, #0x24d0]
               	add	x1, sp, #0x8c0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x1
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xed0
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xe90
               	ldr	q0, [sp, #0x3910]
               	ldr	q1, [sp, #0x3920]
               	ldr	q2, [sp, #0x3930]
               	ldr	q3, [sp, #0x3940]
               	str	q0, [sp, #0x2520]
               	str	q1, [sp, #0x2530]
               	str	q2, [sp, #0x2540]
               	str	q3, [sp, #0x2550]
               	add	x1, sp, #0x940
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
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
               	ldr	q1, [sp, #0x3950]
               	ldr	q2, [sp, #0x3970]
               	zip2	v1.16b, v1.16b, v2.16b
               	ldr	q2, [sp, #0x3960]
               	ldr	q3, [sp, #0x3980]
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
               	str	d2, [sp, #0x5080]
               	str	d0, [sp, #0x5088]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x50a0]
               	str	x3, [sp, #0x50a8]
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
               	ldr	d0, [sp, #0x50b0]
               	ldr	d1, [sp, #0x50b8]
               	zip1	v0.4h, v0.4h, v1.4h
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	ldr	d0, [sp, #0x5390]
               	ldr	d1, [sp, #0x5398]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [sp, #0x6288]
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
               	ldr	x2, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	sub	x5, x29, #0xe10
               	str	x2, [sp, #0x55a0]
               	str	x3, [sp, #0x55a8]
               	str	x4, [sp, #0x55b0]
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
               	ldr	x2, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x2, [sp, #0x55d0]
               	str	x3, [sp, #0x55d8]
               	str	x4, [sp, #0x55e0]
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
               	str	d3, [sp, #0x5c30]
               	str	d5, [sp, #0x5c38]
               	str	d1, [sp, #0x5c40]
               	str	d0, [sp, #0x5c48]
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
               	ldr	x1, [sp, #0x6270]
               	ldr	x2, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x1, [sp, #0x5c70]
               	str	x2, [sp, #0x5c78]
               	str	x3, [sp, #0x5c80]
               	str	x4, [sp, #0x5c88]
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
               	ldr	d0, [sp, #0x5c90]
               	ldr	d1, [sp, #0x5ca0]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x5]
               	add	x1, x5, #0x8
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x10
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x5, #0x18
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x39d0]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x39e0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe50
               	str	q2, [sp, #0x2560]
               	str	q0, [sp, #0x2570]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe30
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
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe10
               	ldr	q0, [sp, #0x39f0]
               	ldr	q1, [sp, #0x3a00]
               	str	q0, [sp, #0x25a0]
               	str	q1, [sp, #0x25b0]
               	add	x2, sp, #0xac0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
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
               	ldr	q0, [sp, #0x3a10]
               	ldr	q1, [sp, #0x3a20]
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xdf0
               	ldr	q0, [sp, #0x3a50]
               	ldr	q1, [sp, #0x3a60]
               	ldr	q2, [sp, #0x3a70]
               	str	q0, [sp, #0x25c0]
               	str	q1, [sp, #0x25d0]
               	str	q2, [sp, #0x25e0]
               	add	x3, sp, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	add	x3, x1, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xdc0
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xd90
               	ldr	q0, [sp, #0x3a80]
               	ldr	q1, [sp, #0x3a90]
               	ldr	q2, [sp, #0x3aa0]
               	str	q0, [sp, #0x2620]
               	str	q1, [sp, #0x2630]
               	str	q2, [sp, #0x2640]
               	add	x3, sp, #0xb40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x3, #0x20]
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
               	str	q3, [sp, #0x3b10]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x3b20]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x3b30]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x3b40]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xd60
               	str	q3, [sp, #0x2650]
               	str	q5, [sp, #0x2660]
               	str	q1, [sp, #0x2670]
               	str	q0, [sp, #0x2680]
               	add	x1, sp, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xd20
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xce0
               	ldr	q0, [sp, #0x3b50]
               	ldr	q1, [sp, #0x3b60]
               	ldr	q2, [sp, #0x3b70]
               	ldr	q3, [sp, #0x3b80]
               	str	q0, [sp, #0x26d0]
               	str	q1, [sp, #0x26e0]
               	str	q2, [sp, #0x26f0]
               	str	q3, [sp, #0x2700]
               	add	x1, sp, #0xc00
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
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
               	ldr	q1, [sp, #0x3b90]
               	ldr	q2, [sp, #0x3bb0]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x3ba0]
               	ldr	q3, [sp, #0x3bc0]
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
               	str	d2, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x50e0]
               	str	x3, [sp, #0x50e8]
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
               	ldr	d0, [sp, #0x50f0]
               	ldr	d1, [sp, #0x50f8]
               	zip1	v0.4h, v0.4h, v1.4h
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x53a0]
               	ldr	d1, [sp, #0x53a8]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [sp, #0x6288]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5630]
               	str	x2, [sp, #0x5638]
               	str	x3, [sp, #0x5640]
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
               	str	d3, [sp, #0x60f0]
               	str	d5, [sp, #0x60f8]
               	str	d1, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6270]
               	ldr	x2, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x1, [sp, #0x5cf0]
               	str	x2, [sp, #0x5cf8]
               	str	x3, [sp, #0x5d00]
               	str	x4, [sp, #0x5d08]
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
               	ldr	d0, [sp, #0x5d10]
               	ldr	d1, [sp, #0x5d20]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x3c10]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x3c20]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xca0
               	str	q2, [sp, #0x2710]
               	str	q0, [sp, #0x2720]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc80
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
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xc60
               	ldr	q0, [sp, #0x3c30]
               	ldr	q1, [sp, #0x3c40]
               	str	q0, [sp, #0x2750]
               	str	q1, [sp, #0x2760]
               	add	x2, sp, #0xd00
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
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
               	ldr	q0, [sp, #0x3c50]
               	ldr	q1, [sp, #0x3c60]
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xc40
               	ldr	q0, [sp, #0x3c90]
               	ldr	q1, [sp, #0x3ca0]
               	ldr	q2, [sp, #0x3cb0]
               	str	q0, [sp, #0x2770]
               	str	q1, [sp, #0x2780]
               	str	q2, [sp, #0x2790]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x2, x1, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xc10
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xbe0
               	ldr	q0, [sp, #0x3cc0]
               	ldr	q1, [sp, #0x3cd0]
               	ldr	q2, [sp, #0x3ce0]
               	str	q0, [sp, #0x27d0]
               	str	q1, [sp, #0x27e0]
               	str	q2, [sp, #0x27f0]
               	add	x2, sp, #0xd80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	str	q3, [sp, #0x3d50]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x3d60]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x3d70]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x3d80]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xbb0
               	str	q3, [sp, #0x2800]
               	str	q5, [sp, #0x2810]
               	str	q1, [sp, #0x2820]
               	str	q0, [sp, #0x2830]
               	add	x1, sp, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xb70
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xb30
               	ldr	q0, [sp, #0x3d90]
               	ldr	q1, [sp, #0x3da0]
               	ldr	q2, [sp, #0x3db0]
               	ldr	q3, [sp, #0x3dc0]
               	str	q0, [sp, #0x2880]
               	str	q1, [sp, #0x2890]
               	str	q2, [sp, #0x28a0]
               	str	q3, [sp, #0x28b0]
               	add	x1, sp, #0xe40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
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
               	ldr	q1, [sp, #0x3dd0]
               	ldr	q2, [sp, #0x3df0]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x3de0]
               	ldr	q3, [sp, #0x3e00]
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
               	str	d2, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5120]
               	str	x3, [sp, #0x5128]
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
               	ldr	d0, [sp, #0x5130]
               	ldr	d1, [sp, #0x5138]
               	zip1	v0.4h, v0.4h, v1.4h
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x53b0]
               	ldr	d1, [sp, #0x53b8]
               	zip2	v0.4h, v0.4h, v1.4h
               	str	d0, [sp, #0x6288]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5690]
               	str	x2, [sp, #0x5698]
               	str	x3, [sp, #0x56a0]
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
               	str	d3, [sp, #0x60f0]
               	str	d5, [sp, #0x60f8]
               	str	d1, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6270]
               	ldr	x2, [sp, #0x6278]
               	ldr	x3, [sp, #0x6280]
               	ldr	x4, [sp, #0x6288]
               	str	x1, [sp, #0x5d70]
               	str	x2, [sp, #0x5d78]
               	str	x3, [sp, #0x5d80]
               	str	x4, [sp, #0x5d88]
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
               	ldr	d0, [sp, #0x5d90]
               	ldr	d1, [sp, #0x5da0]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.4h, v0.4h, v4.4h
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.4h, v1.4h, v2.4h
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x3e50]
               	uzp2	v0.8h, v0.8h, v1.8h
               	str	q0, [sp, #0x3e60]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xaf0
               	str	q2, [sp, #0x28c0]
               	str	q0, [sp, #0x28d0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	add	x2, x0, #0x2
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xad0
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
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xab0
               	ldr	q0, [sp, #0x3e70]
               	ldr	q1, [sp, #0x3e80]
               	str	q0, [sp, #0x2900]
               	str	q1, [sp, #0x2910]
               	add	x2, sp, #0xf40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
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
               	ldr	q0, [sp, #0x3e90]
               	ldr	q1, [sp, #0x3ea0]
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa90
               	ldr	q0, [sp, #0x3ed0]
               	ldr	q1, [sp, #0x3ee0]
               	ldr	q2, [sp, #0x3ef0]
               	str	q0, [sp, #0x2920]
               	str	q1, [sp, #0x2930]
               	str	q2, [sp, #0x2940]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	add	x2, x1, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa60
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa30
               	ldr	q0, [sp, #0x3f00]
               	ldr	q1, [sp, #0x3f10]
               	ldr	q2, [sp, #0x3f20]
               	str	q0, [sp, #0x2980]
               	str	q1, [sp, #0x2990]
               	str	q2, [sp, #0x29a0]
               	add	x2, sp, #0xfc0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	sub	x0, x29, #0x5, lsl #12  // =0x5000
               	sub	x0, x0, #0x390
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x360
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	add	x2, x20, #0x60
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x360
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
               	str	q3, [sp, #0x3f90]
               	uzp1	v5.8h, v0.8h, v2.8h
               	str	q5, [sp, #0x3fa0]
               	uzp2	v1.8h, v4.8h, v1.8h
               	str	q1, [sp, #0x3fb0]
               	uzp2	v0.8h, v0.8h, v2.8h
               	str	q0, [sp, #0x3fc0]
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0xa00
               	str	q3, [sp, #0x29b0]
               	str	q5, [sp, #0x29c0]
               	str	q1, [sp, #0x29d0]
               	str	q0, [sp, #0x29e0]
               	add	x1, sp, #0xa40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x1, x5, #0x2
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x9c0
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
               	sub	x0, x29, #0x3, lsl #12  // =0x3000
               	sub	x0, x0, #0x980
               	ldr	q0, [sp, #0x3fd0]
               	ldr	q1, [sp, #0x3fe0]
               	ldr	q2, [sp, #0x3ff0]
               	ldr	q3, [sp, #0x4000]
               	str	q0, [sp, #0x2a30]
               	str	q1, [sp, #0x2a40]
               	str	q2, [sp, #0x2a50]
               	str	q3, [sp, #0x2a60]
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x330
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x0, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x0, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	add	x0, sp, #0xa40
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x2f0
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x2f0
               	add	x1, x1, x0, lsl #4
               	ldrh	w2, [x3, x0, lsl #1]
               	strh	w2, [x1, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x2f0
               	sub	x0, x29, #0x5, lsl #12  // =0x5000
               	sub	x0, x0, #0x2b0
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
               	ldr	q1, [sp, #0x4010]
               	ldr	q2, [sp, #0x4030]
               	zip2	v1.8h, v1.8h, v2.8h
               	ldr	q2, [sp, #0x4020]
               	ldr	q3, [sp, #0x4040]
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
               	sub	x2, x29, #0x5, lsl #12  // =0x5000
               	sub	x2, x2, #0x330
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x270
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
               	str	d2, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5160]
               	str	x3, [sp, #0x5168]
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
               	ldr	d0, [sp, #0x5170]
               	ldr	d1, [sp, #0x5178]
               	zip1	v0.2s, v0.2s, v1.2s
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x53c0]
               	ldr	d1, [sp, #0x53c8]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [sp, #0x6288]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x56f0]
               	str	x2, [sp, #0x56f8]
               	str	x3, [sp, #0x5700]
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
               	str	d3, [sp, #0x60f0]
               	str	d5, [sp, #0x60f8]
               	str	d1, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6270]
               	ldr	x3, [sp, #0x6278]
               	ldr	x4, [sp, #0x6280]
               	ldr	x5, [sp, #0x6288]
               	str	x1, [sp, #0x5df0]
               	str	x3, [sp, #0x5df8]
               	str	x4, [sp, #0x5e00]
               	str	x5, [sp, #0x5e08]
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
               	ldr	d0, [sp, #0x5e10]
               	ldr	d1, [sp, #0x5e20]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x4090]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x40a0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x940
               	str	q2, [sp, #0x2a70]
               	str	q0, [sp, #0x2a80]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
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
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd00]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd04]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd08]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd0c]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd10]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd14]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd18]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd1c]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x920
               	ldr	q0, [sp, #0x40b0]
               	ldr	q1, [sp, #0x40c0]
               	str	q0, [sp, #0x2a90]
               	str	q1, [sp, #0x2aa0]
               	sub	x3, x29, #0x5, lsl #12  // =0x5000
               	sub	x3, x3, #0x230
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x210
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x210
               	sub	x0, x29, #0x5, lsl #12  // =0x5000
               	sub	x0, x0, #0x1f0
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
               	ldr	q0, [sp, #0x40d0]
               	ldr	q1, [sp, #0x40e0]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x5, lsl #12  // =0x5000
               	sub	x2, x2, #0x230
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x1d0
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
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd60]
               	ldrsw	x1, [x0, #0x4]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd70]
               	ldrsw	x1, [x0, #0x8]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd80]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd64]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd74]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd84]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd68]
               	ldrsw	x1, [x0, #0x1c]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd78]
               	ldrsw	x1, [x0, #0x20]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd88]
               	ldrsw	x1, [x0, #0x24]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd6c]
               	ldrsw	x1, [x0, #0x28]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd7c]
               	ldrsw	x1, [x0, #0x2c]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd8c]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x900
               	ldr	q0, [sp, #0x4110]
               	ldr	q1, [sp, #0x4120]
               	ldr	q2, [sp, #0x4130]
               	str	q0, [sp, #0x2ab0]
               	str	q1, [sp, #0x2ac0]
               	str	q2, [sp, #0x2ad0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd90]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd94]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd98]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xd9c]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xda0]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xda4]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xda8]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xdac]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xdb0]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xdb4]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xdb8]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xdbc]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8d0
               	ldr	q0, [sp, #0x4140]
               	ldr	q1, [sp, #0x4150]
               	ldr	q2, [sp, #0x4160]
               	str	q0, [sp, #0x2ae0]
               	str	q1, [sp, #0x2af0]
               	str	q2, [sp, #0x2b00]
               	sub	x3, x29, #0x5, lsl #12  // =0x5000
               	sub	x3, x3, #0x1b0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x180
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
               	sub	x2, x29, #0x5, lsl #12  // =0x5000
               	sub	x2, x2, #0x1b0
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x150
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
               	str	q3, [sp, #0x41a0]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x41b0]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x41c0]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x41d0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x8a0
               	str	q3, [sp, #0x2b10]
               	str	q5, [sp, #0x2b20]
               	str	q1, [sp, #0x2b30]
               	str	q0, [sp, #0x2b40]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x2, x0, #0x4
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x860
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
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe30]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe34]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe38]
               	ldrsw	x1, [x0, #0xc]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe3c]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe40]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe44]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe48]
               	ldrsw	x1, [x0, #0x10]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe4c]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe50]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe54]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe58]
               	ldrsw	x1, [x0, #0x14]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe5c]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe60]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe64]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe68]
               	ldrsw	x1, [x0, #0x18]
               	sub	x17, x29, #0x3, lsl #12 // =0x3000
               	str	w1, [x17, #0xe6c]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x820
               	ldr	q0, [sp, #0x41e0]
               	ldr	q1, [sp, #0x41f0]
               	ldr	q2, [sp, #0x4200]
               	ldr	q3, [sp, #0x4210]
               	str	q0, [sp, #0x2b90]
               	str	q1, [sp, #0x2ba0]
               	str	q2, [sp, #0x2bb0]
               	str	q3, [sp, #0x2bc0]
               	sub	x2, x29, #0x5, lsl #12  // =0x5000
               	sub	x2, x2, #0x120
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x2, sp, #0xa40
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0xe0
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0xe0
               	sub	x0, x29, #0x5, lsl #12  // =0x5000
               	sub	x0, x0, #0xa0
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
               	ldr	q1, [sp, #0x4220]
               	ldr	q2, [sp, #0x4240]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x4230]
               	ldr	q3, [sp, #0x4250]
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
               	sub	x2, x29, #0x5, lsl #12  // =0x5000
               	sub	x2, x2, #0x120
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x1, x1, #0x60
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
               	str	d2, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x51a0]
               	str	x3, [sp, #0x51a8]
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
               	ldr	d0, [sp, #0x51b0]
               	ldr	d1, [sp, #0x51b8]
               	zip1	v0.2s, v0.2s, v1.2s
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x53d0]
               	ldr	d1, [sp, #0x53d8]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [sp, #0x6288]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5750]
               	str	x2, [sp, #0x5758]
               	str	x3, [sp, #0x5760]
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
               	str	d3, [sp, #0x60f0]
               	str	d5, [sp, #0x60f8]
               	str	d1, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6270]
               	ldr	x3, [sp, #0x6278]
               	ldr	x4, [sp, #0x6280]
               	ldr	x5, [sp, #0x6288]
               	str	x1, [sp, #0x5e70]
               	str	x3, [sp, #0x5e78]
               	str	x4, [sp, #0x5e80]
               	str	x5, [sp, #0x5e88]
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
               	ldr	d0, [sp, #0x5e90]
               	ldr	d1, [sp, #0x5ea0]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x42a0]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x42b0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x7e0
               	str	q2, [sp, #0x2bd0]
               	str	q0, [sp, #0x2be0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xf0]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xec]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xe8]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xe4]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xe0]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xdc]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xd8]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0xd4]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x7c0
               	ldr	q0, [sp, #0x42c0]
               	ldr	q1, [sp, #0x42d0]
               	str	q0, [sp, #0x2bf0]
               	str	q1, [sp, #0x2c00]
               	sub	x3, x29, #0x5, lsl #12  // =0x5000
               	sub	x3, x3, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
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
               	sub	x1, x29, #0x5, lsl #12  // =0x5000
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xfe0
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
               	ldr	q0, [sp, #0x42e0]
               	ldr	q1, [sp, #0x42f0]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x5, lsl #12  // =0x5000
               	sub	x2, x2, #0x20
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
               	sub	x1, x1, #0xfc0
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x90]
               	ldr	w1, [x0, #0x4]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x80]
               	ldr	w1, [x0, #0x8]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x70]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x8c]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x7c]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x6c]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x88]
               	ldr	w1, [x0, #0x1c]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x78]
               	ldr	w1, [x0, #0x20]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x68]
               	ldr	w1, [x0, #0x24]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x84]
               	ldr	w1, [x0, #0x28]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x74]
               	ldr	w1, [x0, #0x2c]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x64]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x7a0
               	ldr	q0, [sp, #0x4320]
               	ldr	q1, [sp, #0x4330]
               	ldr	q2, [sp, #0x4340]
               	str	q0, [sp, #0x2c10]
               	str	q1, [sp, #0x2c20]
               	str	q2, [sp, #0x2c30]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x60]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x5c]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x58]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x54]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x50]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x4c]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x48]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x44]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x40]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x3c]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x38]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	stur	w1, [x17, #-0x34]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x770
               	ldr	q0, [sp, #0x4350]
               	ldr	q1, [sp, #0x4360]
               	ldr	q2, [sp, #0x4370]
               	str	q0, [sp, #0x2c40]
               	str	q1, [sp, #0x2c50]
               	str	q2, [sp, #0x2c60]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xfa0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xf70
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
               	sub	x2, x2, #0xfa0
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
               	sub	x1, x1, #0xf40
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
               	str	q3, [sp, #0x43b0]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x43c0]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x43d0]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x43e0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x740
               	str	q3, [sp, #0x2c70]
               	str	q5, [sp, #0x2c80]
               	str	q1, [sp, #0x2c90]
               	str	q0, [sp, #0x2ca0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x2, x0, #0x4
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x700
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x40]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x44]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x48]
               	ldr	w1, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x4c]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x50]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x54]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x58]
               	ldr	w1, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x5c]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x60]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x64]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x68]
               	ldr	w1, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x6c]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x70]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x74]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x78]
               	ldr	w1, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	w1, [x17, #0x7c]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x6c0
               	ldr	q0, [sp, #0x43f0]
               	ldr	q1, [sp, #0x4400]
               	ldr	q2, [sp, #0x4410]
               	ldr	q3, [sp, #0x4420]
               	str	q0, [sp, #0x2cf0]
               	str	q1, [sp, #0x2d00]
               	str	q2, [sp, #0x2d10]
               	str	q3, [sp, #0x2d20]
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xf10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x2, sp, #0xa40
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xed0
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
               	sub	x1, x1, #0xed0
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xe90
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
               	ldr	q1, [sp, #0x4430]
               	ldr	q2, [sp, #0x4450]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x4440]
               	ldr	q3, [sp, #0x4460]
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
               	sub	x2, x2, #0xf10
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xe50
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
               	str	d2, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x51e0]
               	str	x3, [sp, #0x51e8]
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
               	ldr	d0, [sp, #0x51f0]
               	ldr	d1, [sp, #0x51f8]
               	zip1	v0.2s, v0.2s, v1.2s
               	sub	x0, x29, #0x128
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	ldr	d0, [sp, #0x53e0]
               	ldr	d1, [sp, #0x53e8]
               	zip2	v0.2s, v0.2s, v1.2s
               	str	d0, [sp, #0x6288]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6278]
               	ldr	x2, [sp, #0x6280]
               	ldr	x3, [sp, #0x6288]
               	str	x1, [sp, #0x57b0]
               	str	x2, [sp, #0x57b8]
               	str	x3, [sp, #0x57c0]
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
               	str	d3, [sp, #0x60f0]
               	str	d5, [sp, #0x60f8]
               	str	d1, [sp, #0x6100]
               	str	d0, [sp, #0x6108]
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
               	ldr	x1, [sp, #0x6270]
               	ldr	x3, [sp, #0x6278]
               	ldr	x4, [sp, #0x6280]
               	ldr	x5, [sp, #0x6288]
               	str	x1, [sp, #0x5ef0]
               	str	x3, [sp, #0x5ef8]
               	str	x4, [sp, #0x5f00]
               	str	x5, [sp, #0x5f08]
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
               	ldr	d0, [sp, #0x5f10]
               	ldr	d1, [sp, #0x5f20]
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
               	str	d3, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x20]
               	add	x1, x20, #0x8
               	zip2	v0.2s, v0.2s, v4.2s
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x10
               	zip1	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x6288]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	add	x1, x20, #0x18
               	zip2	v0.2s, v1.2s, v2.2s
               	str	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x44b0]
               	uzp2	v0.4s, v0.4s, v1.4s
               	str	q0, [sp, #0x44c0]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x680
               	str	q2, [sp, #0x2d30]
               	str	q0, [sp, #0x2d40]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x120]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x124]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x128]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x12c]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x130]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x134]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x138]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x13c]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x660
               	ldr	q0, [sp, #0x44d0]
               	ldr	q1, [sp, #0x44e0]
               	str	q0, [sp, #0x2d50]
               	str	q1, [sp, #0x2d60]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xe10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xdf0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xdf0
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xdd0
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
               	ldr	q0, [sp, #0x44f0]
               	ldr	q1, [sp, #0x4500]
               	zip2	v0.4s, v0.4s, v1.4s
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xe10
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xdb0
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x180]
               	ldr	s0, [x0, #0x4]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x190]
               	ldr	s0, [x0, #0x8]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1a0]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x184]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x194]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1a4]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x188]
               	ldr	s0, [x0, #0x1c]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x198]
               	ldr	s0, [x0, #0x20]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1a8]
               	ldr	s0, [x0, #0x24]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x18c]
               	ldr	s0, [x0, #0x28]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x19c]
               	ldr	s0, [x0, #0x2c]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1ac]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x640
               	ldr	q0, [sp, #0x4530]
               	ldr	q1, [sp, #0x4540]
               	ldr	q2, [sp, #0x4550]
               	str	q0, [sp, #0x2d70]
               	str	q1, [sp, #0x2d80]
               	str	q2, [sp, #0x2d90]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1b0]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1b4]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1b8]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1bc]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1c0]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1c4]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1c8]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1cc]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1d0]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1d4]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1d8]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x1dc]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x610
               	ldr	q0, [sp, #0x4560]
               	ldr	q1, [sp, #0x4570]
               	ldr	q2, [sp, #0x4580]
               	str	q0, [sp, #0x2da0]
               	str	q1, [sp, #0x2db0]
               	str	q2, [sp, #0x2dc0]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xd90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xd60
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xd60
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xd30
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
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1f0]
               	str	s0, [x20, #0x4]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x200]
               	str	s0, [x20, #0x8]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1e4]
               	str	s0, [x20, #0xc]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1f4]
               	str	s0, [x20, #0x10]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x204]
               	str	s0, [x20, #0x14]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1e8]
               	str	s0, [x20, #0x18]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1f8]
               	str	s0, [x20, #0x1c]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x208]
               	str	s0, [x20, #0x20]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1ec]
               	str	s0, [x20, #0x24]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x1fc]
               	str	s0, [x20, #0x28]
               	sub	x16, x29, #0x2, lsl #12 // =0x2000
               	ldr	s0, [x16, #0x20c]
               	str	s0, [x20, #0x2c]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xd90
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xd00
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
               	str	q3, [sp, #0x45f0]
               	uzp1	v5.4s, v0.4s, v2.4s
               	str	q5, [sp, #0x4600]
               	uzp2	v1.4s, v4.4s, v1.4s
               	str	q1, [sp, #0x4610]
               	uzp2	v0.4s, v0.4s, v2.4s
               	str	q0, [sp, #0x4620]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x5e0
               	str	q3, [sp, #0x2dd0]
               	str	q5, [sp, #0x2de0]
               	str	q1, [sp, #0x2df0]
               	str	q0, [sp, #0x2e00]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
               	add	x3, x0, #0x4
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x5a0
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
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x280]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x284]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x288]
               	ldr	s0, [x0, #0xc]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x28c]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x290]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x294]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x298]
               	ldr	s0, [x0, #0x10]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x29c]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2a0]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2a4]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2a8]
               	ldr	s0, [x0, #0x14]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2ac]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2b0]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2b4]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2b8]
               	ldr	s0, [x0, #0x18]
               	sub	x17, x29, #0x2, lsl #12 // =0x2000
               	str	s0, [x17, #0x2bc]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x560
               	ldr	q0, [sp, #0x4630]
               	ldr	q1, [sp, #0x4640]
               	ldr	q2, [sp, #0x4650]
               	ldr	q3, [sp, #0x4660]
               	str	q0, [sp, #0x2e50]
               	str	q1, [sp, #0x2e60]
               	str	q2, [sp, #0x2e70]
               	str	q3, [sp, #0x2e80]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xcd0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xc90
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xc90
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xc50
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
               	ldr	q1, [sp, #0x4670]
               	ldr	q2, [sp, #0x4690]
               	zip2	v1.4s, v1.4s, v2.4s
               	ldr	q2, [sp, #0x4680]
               	ldr	q3, [sp, #0x46a0]
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
               	sub	x2, x2, #0xcd0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xc10
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
               	str	x1, [sp, #0x6280]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6288]
               	sub	x3, x29, #0x2b0
               	str	x1, [sp, #0x6100]
               	str	x2, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x6120]
               	str	x2, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6280]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6288]
               	str	x1, [sp, #0x5220]
               	str	x2, [sp, #0x5228]
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
               	ldr	x1, [sp, #0x5230]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6288]
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
               	str	x1, [sp, #0x6278]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6280]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x6118]
               	str	x2, [sp, #0x6120]
               	str	x3, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6278]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6280]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5810]
               	str	x2, [sp, #0x5818]
               	str	x3, [sp, #0x5820]
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
               	ldr	x1, [sp, #0x5828]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6280]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x6288]
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
               	str	x1, [sp, #0x6270]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6278]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x6280]
               	ldr	x4, [x0, #0x18]
               	str	x4, [sp, #0x6288]
               	sub	x5, x29, #0x2c0
               	str	x1, [sp, #0x60f0]
               	str	x2, [sp, #0x60f8]
               	str	x3, [sp, #0x6100]
               	str	x4, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x0, #0x20]
               	str	x1, [sp, #0x6110]
               	str	x2, [sp, #0x6118]
               	str	x3, [sp, #0x6120]
               	str	x4, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6270]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6278]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x6280]
               	ldr	x4, [x0, #0x30]
               	str	x4, [sp, #0x6288]
               	str	x1, [sp, #0x5f70]
               	str	x2, [sp, #0x5f78]
               	str	x3, [sp, #0x5f80]
               	str	x4, [sp, #0x5f88]
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
               	ldr	x1, [sp, #0x5f90]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6278]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x6280]
               	str	x1, [x20, #0x10]
               	ldr	x1, [sp, #0x6288]
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
               	str	q2, [sp, #0x46f0]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x4700]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x520
               	str	q2, [sp, #0x2e90]
               	str	q0, [sp, #0x2ea0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4710]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4718]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4720]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4728]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x500
               	ldr	q0, [sp, #0x4710]
               	ldr	q1, [sp, #0x4720]
               	str	q0, [sp, #0x2eb0]
               	str	q1, [sp, #0x2ec0]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xbd0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xbb0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xbb0
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xb90
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
               	ldr	q0, [sp, #0x4730]
               	ldr	q1, [sp, #0x4740]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xbd0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xb70
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
               	str	x1, [sp, #0x4770]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x4780]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x4790]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4778]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4788]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4798]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x4e0
               	ldr	q0, [sp, #0x4770]
               	ldr	q1, [sp, #0x4780]
               	ldr	q2, [sp, #0x4790]
               	str	q0, [sp, #0x2ed0]
               	str	q1, [sp, #0x2ee0]
               	str	q2, [sp, #0x2ef0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	str	x1, [sp, #0x47a0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x47a8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x47b0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x47b8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x47c0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x47c8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x4b0
               	ldr	q0, [sp, #0x47a0]
               	ldr	q1, [sp, #0x47b0]
               	ldr	q2, [sp, #0x47c0]
               	str	q0, [sp, #0x2f00]
               	str	q1, [sp, #0x2f10]
               	str	q2, [sp, #0x2f20]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xb50
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xb20
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xb50
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xaf0
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
               	str	q3, [sp, #0x4800]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x4810]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x4820]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x4830]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x480
               	str	q3, [sp, #0x2f30]
               	str	q5, [sp, #0x2f40]
               	str	q1, [sp, #0x2f50]
               	str	q0, [sp, #0x2f60]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
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
               	str	x1, [sp, #0x4840]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4848]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4850]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4858]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4860]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4868]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x4870]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x4878]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x440
               	ldr	q0, [sp, #0x4840]
               	ldr	q1, [sp, #0x4850]
               	ldr	q2, [sp, #0x4860]
               	ldr	q3, [sp, #0x4870]
               	str	q0, [sp, #0x2f70]
               	str	q1, [sp, #0x2f80]
               	str	q2, [sp, #0x2f90]
               	str	q3, [sp, #0x2fa0]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0xac0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa80
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa80
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0xa40
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
               	ldr	q1, [sp, #0x4880]
               	ldr	q2, [sp, #0x48a0]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x4890]
               	ldr	q3, [sp, #0x48b0]
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0xac0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0xa00
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
               	str	x1, [sp, #0x6280]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6288]
               	sub	x3, x29, #0x2b0
               	str	x1, [sp, #0x6100]
               	str	x2, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x6120]
               	str	x2, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6280]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6288]
               	str	x1, [sp, #0x5260]
               	str	x2, [sp, #0x5268]
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
               	ldr	x1, [sp, #0x5270]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6288]
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
               	str	x1, [sp, #0x6278]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6280]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x6118]
               	str	x2, [sp, #0x6120]
               	str	x3, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6278]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6280]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x6288]
               	str	x1, [sp, #0x5870]
               	str	x2, [sp, #0x5878]
               	str	x3, [sp, #0x5880]
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
               	ldr	x1, [sp, #0x5888]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6280]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x6288]
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
               	str	x1, [sp, #0x6270]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6278]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x6280]
               	ldr	x4, [x0, #0x18]
               	str	x4, [sp, #0x6288]
               	sub	x5, x29, #0x2c0
               	str	x1, [sp, #0x60f0]
               	str	x2, [sp, #0x60f8]
               	str	x3, [sp, #0x6100]
               	str	x4, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x0, #0x20]
               	str	x1, [sp, #0x6110]
               	str	x2, [sp, #0x6118]
               	str	x3, [sp, #0x6120]
               	str	x4, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6270]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6278]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x6280]
               	ldr	x4, [x0, #0x30]
               	str	x4, [sp, #0x6288]
               	str	x1, [sp, #0x5ff0]
               	str	x2, [sp, #0x5ff8]
               	str	x3, [sp, #0x6000]
               	str	x4, [sp, #0x6008]
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
               	ldr	x1, [sp, #0x6010]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6278]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x6280]
               	str	x1, [x20, #0x10]
               	ldr	x1, [sp, #0x6288]
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
               	str	q2, [sp, #0x4900]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x4910]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x400
               	str	q2, [sp, #0x2fb0]
               	str	q0, [sp, #0x2fc0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4920]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4928]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4930]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4938]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x3e0
               	ldr	q0, [sp, #0x4920]
               	ldr	q1, [sp, #0x4930]
               	str	q0, [sp, #0x2fd0]
               	str	q1, [sp, #0x2fe0]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x9c0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x9a0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x9a0
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x980
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
               	ldr	q0, [sp, #0x4940]
               	ldr	q1, [sp, #0x4950]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x9c0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x960
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
               	str	x1, [sp, #0x4980]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x4990]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x49a0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4988]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4998]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x49a8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x3c0
               	ldr	q0, [sp, #0x4980]
               	ldr	q1, [sp, #0x4990]
               	ldr	q2, [sp, #0x49a0]
               	str	q0, [sp, #0x2ff0]
               	str	q1, [sp, #0x3000]
               	str	q2, [sp, #0x3010]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	str	x1, [sp, #0x49b0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x49b8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x49c0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x49c8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x49d0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x49d8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x390
               	ldr	q0, [sp, #0x49b0]
               	ldr	q1, [sp, #0x49c0]
               	ldr	q2, [sp, #0x49d0]
               	str	q0, [sp, #0x3020]
               	str	q1, [sp, #0x3030]
               	str	q2, [sp, #0x3040]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x940
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x910
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x940
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x8e0
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
               	str	q3, [sp, #0x4a10]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x4a20]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x4a30]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x4a40]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x360
               	str	q3, [sp, #0x3050]
               	str	q5, [sp, #0x3060]
               	str	q1, [sp, #0x3070]
               	str	q0, [sp, #0x3080]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
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
               	str	x1, [sp, #0x4a50]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4a58]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4a60]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4a68]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4a70]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4a78]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x4a80]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x4a88]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x320
               	ldr	q0, [sp, #0x4a50]
               	ldr	q1, [sp, #0x4a60]
               	ldr	q2, [sp, #0x4a70]
               	ldr	q3, [sp, #0x4a80]
               	str	q0, [sp, #0x3090]
               	str	q1, [sp, #0x30a0]
               	str	q2, [sp, #0x30b0]
               	str	q3, [sp, #0x30c0]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x8b0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x870
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x870
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x830
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
               	ldr	q1, [sp, #0x4a90]
               	ldr	q2, [sp, #0x4ab0]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x4aa0]
               	ldr	q3, [sp, #0x4ac0]
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x8b0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x7f0
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
               	str	x1, [sp, #0x6280]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6288]
               	sub	x3, x29, #0x2b0
               	str	x1, [sp, #0x6100]
               	str	x2, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	str	x1, [sp, #0x6120]
               	str	x2, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6280]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6288]
               	str	x1, [sp, #0x52a0]
               	str	x2, [sp, #0x52a8]
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
               	ldr	x1, [sp, #0x52b0]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6288]
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
               	str	x1, [sp, #0x6278]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6280]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x6288]
               	sub	x4, x29, #0x2b8
               	str	x1, [sp, #0x60f8]
               	str	x2, [sp, #0x6100]
               	str	x3, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	str	x1, [sp, #0x6118]
               	str	x2, [sp, #0x6120]
               	str	x3, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6278]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6280]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x6288]
               	str	x1, [sp, #0x58d0]
               	str	x2, [sp, #0x58d8]
               	str	x3, [sp, #0x58e0]
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
               	ldr	x1, [sp, #0x58e8]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6280]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x6288]
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
               	str	x1, [sp, #0x6270]
               	ldr	x2, [x0, #0x8]
               	str	x2, [sp, #0x6278]
               	ldr	x3, [x0, #0x10]
               	str	x3, [sp, #0x6280]
               	ldr	x4, [x0, #0x18]
               	str	x4, [sp, #0x6288]
               	sub	x5, x29, #0x2c0
               	str	x1, [sp, #0x60f0]
               	str	x2, [sp, #0x60f8]
               	str	x3, [sp, #0x6100]
               	str	x4, [sp, #0x6108]
               	ldr	x1, [x0, #0x8]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	ldr	x4, [x0, #0x20]
               	str	x1, [sp, #0x6110]
               	str	x2, [sp, #0x6118]
               	str	x3, [sp, #0x6120]
               	str	x4, [sp, #0x6128]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x6270]
               	ldr	x2, [x0, #0x20]
               	str	x2, [sp, #0x6278]
               	ldr	x3, [x0, #0x28]
               	str	x3, [sp, #0x6280]
               	ldr	x4, [x0, #0x30]
               	str	x4, [sp, #0x6288]
               	str	x1, [sp, #0x6070]
               	str	x2, [sp, #0x6078]
               	str	x3, [sp, #0x6080]
               	str	x4, [sp, #0x6088]
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
               	ldr	x1, [sp, #0x6090]
               	str	x1, [x20]
               	ldr	x1, [sp, #0x6278]
               	str	x1, [x20, #0x8]
               	ldr	x1, [sp, #0x6280]
               	str	x1, [x20, #0x10]
               	ldr	x1, [sp, #0x6288]
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
               	str	q2, [sp, #0x4b10]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x4b20]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x2e0
               	str	q2, [sp, #0x30d0]
               	str	q0, [sp, #0x30e0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4b30]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4b38]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4b40]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4b48]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x2c0
               	ldr	q0, [sp, #0x4b30]
               	ldr	q1, [sp, #0x4b40]
               	str	q0, [sp, #0x30f0]
               	str	q1, [sp, #0x3100]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x7b0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x790
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x790
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x770
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
               	ldr	q0, [sp, #0x4b50]
               	ldr	q1, [sp, #0x4b60]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x7b0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x750
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
               	str	x1, [sp, #0x4b90]
               	ldr	x1, [x0, #0x8]
               	str	x1, [sp, #0x4ba0]
               	ldr	x1, [x0, #0x10]
               	str	x1, [sp, #0x4bb0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4b98]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4ba8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4bb8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x2a0
               	ldr	q0, [sp, #0x4b90]
               	ldr	q1, [sp, #0x4ba0]
               	ldr	q2, [sp, #0x4bb0]
               	str	q0, [sp, #0x3110]
               	str	q1, [sp, #0x3120]
               	str	q2, [sp, #0x3130]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	str	x1, [sp, #0x4bc0]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4bc8]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4bd0]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4bd8]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4be0]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4be8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x270
               	ldr	q0, [sp, #0x4bc0]
               	ldr	q1, [sp, #0x4bd0]
               	ldr	q2, [sp, #0x4be0]
               	str	q0, [sp, #0x3140]
               	str	q1, [sp, #0x3150]
               	str	q2, [sp, #0x3160]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x730
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x700
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x730
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x6d0
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
               	str	q3, [sp, #0x4c20]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x4c30]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x4c40]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x4c50]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x240
               	str	q3, [sp, #0x3170]
               	str	q5, [sp, #0x3180]
               	str	q1, [sp, #0x3190]
               	str	q0, [sp, #0x31a0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
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
               	str	x1, [sp, #0x4c60]
               	ldr	x1, [x0, #0x18]
               	str	x1, [sp, #0x4c68]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4c70]
               	ldr	x1, [x0, #0x20]
               	str	x1, [sp, #0x4c78]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4c80]
               	ldr	x1, [x0, #0x28]
               	str	x1, [sp, #0x4c88]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x4c90]
               	ldr	x1, [x0, #0x30]
               	str	x1, [sp, #0x4c98]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x200
               	ldr	q0, [sp, #0x4c60]
               	ldr	q1, [sp, #0x4c70]
               	ldr	q2, [sp, #0x4c80]
               	ldr	q3, [sp, #0x4c90]
               	str	q0, [sp, #0x31b0]
               	str	q1, [sp, #0x31c0]
               	str	q2, [sp, #0x31d0]
               	str	q3, [sp, #0x31e0]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x6a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x660
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x660
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x620
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
               	ldr	q1, [sp, #0x4ca0]
               	ldr	q2, [sp, #0x4cc0]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x4cb0]
               	ldr	q3, [sp, #0x4cd0]
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x6a0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x5e0
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
               	str	d0, [sp, #0x6280]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x6288]
               	sub	x1, x29, #0x2b0
               	str	d0, [sp, #0x6100]
               	str	d1, [sp, #0x6108]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	str	x2, [sp, #0x6120]
               	str	x3, [sp, #0x6128]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x6280]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x6288]
               	str	d0, [sp, #0x52e0]
               	str	d1, [sp, #0x52e8]
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
               	ldr	d0, [sp, #0x52f0]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x6288]
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
               	str	d0, [sp, #0x6278]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x6280]
               	ldr	d2, [x0, #0x10]
               	str	d2, [sp, #0x6288]
               	sub	x1, x29, #0x2b8
               	str	d0, [sp, #0x60f8]
               	str	d1, [sp, #0x6100]
               	str	d2, [sp, #0x6108]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	str	x2, [sp, #0x6118]
               	str	x3, [sp, #0x6120]
               	str	x4, [sp, #0x6128]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x6278]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x6280]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x6288]
               	str	d0, [sp, #0x5930]
               	str	d1, [sp, #0x5938]
               	str	d2, [sp, #0x5940]
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
               	ldr	d0, [sp, #0x5948]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x6280]
               	str	d0, [x20, #0x8]
               	ldr	d0, [sp, #0x6288]
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
               	str	d0, [sp, #0x6270]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x6278]
               	ldr	d2, [x0, #0x10]
               	str	d2, [sp, #0x6280]
               	ldr	d3, [x0, #0x18]
               	str	d3, [sp, #0x6288]
               	sub	x1, x29, #0x2c0
               	str	d0, [sp, #0x60f0]
               	str	d1, [sp, #0x60f8]
               	str	d2, [sp, #0x6100]
               	str	d3, [sp, #0x6108]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x2, [sp, #0x6110]
               	str	x3, [sp, #0x6118]
               	str	x4, [sp, #0x6120]
               	str	x5, [sp, #0x6128]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x6270]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x6278]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x6280]
               	ldr	d3, [x0, #0x30]
               	str	d3, [sp, #0x6288]
               	str	d0, [sp, #0x6130]
               	str	d1, [sp, #0x6138]
               	str	d2, [sp, #0x6140]
               	str	d3, [sp, #0x6148]
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
               	ldr	d0, [sp, #0x6150]
               	str	d0, [x20]
               	ldr	d0, [sp, #0x6278]
               	str	d0, [x20, #0x8]
               	ldr	d0, [sp, #0x6280]
               	str	d0, [x20, #0x10]
               	ldr	d0, [sp, #0x6288]
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
               	str	q2, [sp, #0x4d20]
               	uzp2	v0.2d, v0.2d, v1.2d
               	str	q0, [sp, #0x4d30]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x1c0
               	str	q2, [sp, #0x31f0]
               	str	q0, [sp, #0x3200]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldr	x1, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	ldr	x5, [x0, #0x20]
               	str	x1, [sp, #0xa80]
               	str	x3, [sp, #0xa88]
               	str	x4, [sp, #0xa90]
               	str	x5, [sp, #0xa98]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x4d40]
               	ldr	d1, [x0, #0x18]
               	str	d1, [sp, #0x4d48]
               	ldr	d2, [x0, #0x20]
               	str	d2, [sp, #0x4d50]
               	ldr	d3, [x0, #0x20]
               	str	d3, [sp, #0x4d58]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x1a0
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	str	q0, [sp, #0x3210]
               	str	q1, [sp, #0x3220]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x5a0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x580
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x580
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x560
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
               	ldr	q0, [sp, #0x4d60]
               	ldr	q1, [sp, #0x4d70]
               	zip2	v0.2d, v0.2d, v1.2d
               	str	q0, [x20, #0x10]
               	add	x1, x20, #0x20
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x5a0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x540
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
               	str	d0, [sp, #0x4da0]
               	ldr	d1, [x0, #0x8]
               	str	d1, [sp, #0x4db0]
               	ldr	d2, [x0, #0x10]
               	str	d2, [sp, #0x4dc0]
               	ldr	d3, [x0, #0x18]
               	str	d3, [sp, #0x4da8]
               	ldr	d4, [x0, #0x20]
               	str	d4, [sp, #0x4db8]
               	ldr	d5, [x0, #0x28]
               	str	d5, [sp, #0x4dc8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x180
               	mov	v0.d[1], v3.d[0]
               	mov	v1.d[1], v4.d[0]
               	mov	v2.d[1], v5.d[0]
               	str	q0, [sp, #0x3230]
               	str	q1, [sp, #0x3240]
               	str	q2, [sp, #0x3250]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
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
               	str	d0, [sp, #0x4dd0]
               	ldr	d1, [x0, #0x18]
               	str	d1, [sp, #0x4dd8]
               	ldr	d2, [x0, #0x20]
               	str	d2, [sp, #0x4de0]
               	ldr	d3, [x0, #0x20]
               	str	d3, [sp, #0x4de8]
               	ldr	d4, [x0, #0x28]
               	str	d4, [sp, #0x4df0]
               	ldr	d5, [x0, #0x28]
               	str	d5, [sp, #0x4df8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x150
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	zip1	v2.2d, v4.2d, v5.2d
               	str	q0, [sp, #0x3260]
               	str	q1, [sp, #0x3270]
               	str	q2, [sp, #0x3280]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x520
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x4f0
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x4f0
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x4c0
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
               	ldr	d0, [sp, #0x4e10]
               	str	d0, [x20, #0x8]
               	ldr	d0, [sp, #0x4e20]
               	str	d0, [x20, #0x10]
               	ldr	d0, [sp, #0x4e08]
               	str	d0, [x20, #0x18]
               	ldr	d0, [sp, #0x4e18]
               	str	d0, [x20, #0x20]
               	ldr	d0, [sp, #0x4e28]
               	str	d0, [x20, #0x28]
               	add	x1, x20, #0x30
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x520
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x490
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
               	str	q3, [sp, #0x4e60]
               	uzp1	v5.2d, v0.2d, v2.2d
               	str	q5, [sp, #0x4e70]
               	uzp2	v1.2d, v4.2d, v1.2d
               	str	q1, [sp, #0x4e80]
               	uzp2	v0.2d, v0.2d, v2.2d
               	str	q0, [sp, #0x4e90]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0x120
               	str	q3, [sp, #0x3290]
               	str	q5, [sp, #0x32a0]
               	str	q1, [sp, #0x32b0]
               	str	q0, [sp, #0x32c0]
               	add	x2, sp, #0xa40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x2, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x2, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x2, #0x30]
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
               	str	d0, [sp, #0x4ea0]
               	ldr	d0, [x0, #0x18]
               	str	d0, [sp, #0x4ea8]
               	ldr	d0, [x0, #0x20]
               	str	d0, [sp, #0x4eb0]
               	ldr	d1, [x0, #0x20]
               	str	d1, [sp, #0x4eb8]
               	ldr	d2, [x0, #0x28]
               	str	d2, [sp, #0x4ec0]
               	ldr	d3, [x0, #0x28]
               	str	d3, [sp, #0x4ec8]
               	ldr	d4, [x0, #0x30]
               	str	d4, [sp, #0x4ed0]
               	ldr	d5, [x0, #0x30]
               	str	d5, [sp, #0x4ed8]
               	sub	x1, x29, #0x3, lsl #12  // =0x3000
               	sub	x1, x1, #0xe0
               	ldr	q6, [sp, #0x4ea0]
               	mov	v0.d[1], v1.d[0]
               	zip1	v1.2d, v2.2d, v3.2d
               	zip1	v2.2d, v4.2d, v5.2d
               	str	q6, [sp, #0x32d0]
               	str	q0, [sp, #0x32e0]
               	str	q1, [sp, #0x32f0]
               	str	q2, [sp, #0x3300]
               	sub	x3, x29, #0x4, lsl #12  // =0x4000
               	sub	x3, x3, #0x460
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x420
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x420
               	sub	x0, x29, #0x4, lsl #12  // =0x4000
               	sub	x0, x0, #0x3e0
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
               	ldr	q1, [sp, #0x4ee0]
               	ldr	q2, [sp, #0x4f00]
               	zip2	v1.2d, v1.2d, v2.2d
               	ldr	q2, [sp, #0x4ef0]
               	ldr	q3, [sp, #0x4f10]
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
               	sub	x2, x29, #0x4, lsl #12  // =0x4000
               	sub	x2, x2, #0x460
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
               	sub	x1, x29, #0x4, lsl #12  // =0x4000
               	sub	x1, x1, #0x3a0
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
               	add	sp, sp, #0x6, lsl #12   // =0x6000
               	add	sp, sp, #0x3b0
               	ldp	x29, x30, [sp], #0x10
               	ret
