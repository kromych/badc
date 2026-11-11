
vector_comparisons_shifts_and_negation_in_whole_registers.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x110
               	sub	x2, x29, #0x110
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x100
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q1, [x29, #-0x100]
               	ldr	q0, [sp]
               	cmgt	v1.16b, v1.16b, v0.16b
               	sub	x4, x29, #0xf0
               	stur	q1, [x29, #-0xf0]
               	ldur	q1, [x29, #-0x100]
               	cmge	v0.16b, v1.16b, v0.16b
               	sub	x5, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	ldr	q0, [sp]
               	cmgt	v1.16b, v0.16b, v1.16b
               	sub	x6, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	ldur	q1, [x29, #-0x100]
               	cmge	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldr	q0, [sp]
               	cmeq	v0.16b, v0.16b, v1.16b
               	sub	x8, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsb	x9, [x4, x0]
               	ldrsb	x10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrsb	x12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, lt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x5, x0]
               	ldrsb	x10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrsb	x12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, le
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x6, x0]
               	ldrsb	x10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrsb	x12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, gt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x7, x0]
               	ldrsb	x10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrsb	x12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, ge
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x8, x0]
               	sub	x10, x29, #0x110
               	sub	x11, x29, #0x100
               	ldrsb	x11, [x11, x0]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldrsb	x10, [x10, x0]
               	cmp	w10, w11
               	csel	x10, x12, x13, eq
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x0, x29, #0x110
               	sub	x2, x29, #0xa0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x100
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q1, [x29, #-0x90]
               	ldur	q0, [x29, #-0xa0]
               	cmhi	v1.16b, v1.16b, v0.16b
               	sub	x4, x29, #0xf0
               	stur	q1, [x29, #-0xf0]
               	ldur	q1, [x29, #-0x90]
               	cmhs	v0.16b, v1.16b, v0.16b
               	sub	x5, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	ldur	q0, [x29, #-0xa0]
               	cmhi	v1.16b, v0.16b, v1.16b
               	sub	x6, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	ldur	q1, [x29, #-0x90]
               	cmhs	v0.16b, v0.16b, v1.16b
               	sub	x7, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldur	q0, [x29, #-0xa0]
               	cmeq	v0.16b, v0.16b, v1.16b
               	sub	x8, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsb	x9, [x4, x0]
               	ldrb	w10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrb	w12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, lt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x5, x0]
               	ldrb	w10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrb	w12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, le
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x6, x0]
               	ldrb	w10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrb	w12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, gt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x7, x0]
               	ldrb	w10, [x3, x0]
               	mov	x11, #-0x1              // =-1
               	ldrb	w12, [x2, x0]
               	cmp	w12, w10
               	csel	x10, x11, x1, ge
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsb	x9, [x8, x0]
               	sub	x10, x29, #0xa0
               	sub	x11, x29, #0x90
               	ldrb	w11, [x11, x0]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldrb	w10, [x10, x0]
               	cmp	w10, w11
               	csel	x10, x12, x13, eq
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	sub	x2, x29, #0x48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x3, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x48]
               	cmgt	v2.4h, v0.4h, v1.4h
               	sub	x4, x29, #0x28
               	stur	d2, [x29, #-0x28]
               	cmge	v0.4h, v0.4h, v1.4h
               	sub	x5, x29, #0x20
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x48]
               	ldur	d1, [x29, #-0x40]
               	cmgt	v2.4h, v0.4h, v1.4h
               	sub	x6, x29, #0x18
               	stur	d2, [x29, #-0x18]
               	cmge	v0.4h, v0.4h, v1.4h
               	sub	x7, x29, #0x10
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x48]
               	ldur	d1, [x29, #-0x40]
               	cmeq	v0.4h, v0.4h, v1.4h
               	sub	x8, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsh	x9, [x4, x0, lsl #1]
               	ldrsh	x10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrsh	x12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, lt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x5, x0, lsl #1]
               	ldrsh	x10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrsh	x12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, le
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x6, x0, lsl #1]
               	ldrsh	x10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrsh	x12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, gt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x7, x0, lsl #1]
               	ldrsh	x10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrsh	x12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, ge
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x8, x0, lsl #1]
               	sub	x10, x29, #0x48
               	sub	x11, x29, #0x40
               	ldrsh	x11, [x11, x0, lsl #1]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldrsh	x10, [x10, x0, lsl #1]
               	cmp	w10, w11
               	csel	x10, x12, x13, eq
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x48
               	sub	x2, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x2]
               	sub	x0, x29, #0x40
               	sub	x3, x29, #0x30
               	ldr	x16, [x0]
               	str	x16, [x3]
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x38]
               	cmhi	v2.4h, v0.4h, v1.4h
               	sub	x4, x29, #0x28
               	stur	d2, [x29, #-0x28]
               	cmhs	v0.4h, v0.4h, v1.4h
               	sub	x5, x29, #0x20
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	cmhi	v2.4h, v0.4h, v1.4h
               	sub	x6, x29, #0x18
               	stur	d2, [x29, #-0x18]
               	cmhs	v0.4h, v0.4h, v1.4h
               	sub	x7, x29, #0x10
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x38]
               	ldur	d1, [x29, #-0x30]
               	cmeq	v0.4h, v0.4h, v1.4h
               	sub	x8, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsh	x9, [x4, x0, lsl #1]
               	ldrh	w10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrh	w12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, lt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x5, x0, lsl #1]
               	ldrh	w10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrh	w12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, le
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x6, x0, lsl #1]
               	ldrh	w10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrh	w12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, gt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x7, x0, lsl #1]
               	ldrh	w10, [x3, x0, lsl #1]
               	mov	x11, #-0x1              // =-1
               	ldrh	w12, [x2, x0, lsl #1]
               	cmp	w12, w10
               	csel	x10, x11, x1, ge
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsh	x9, [x8, x0, lsl #1]
               	sub	x10, x29, #0x38
               	sub	x11, x29, #0x30
               	ldrh	w11, [x11, x0, lsl #1]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldrh	w10, [x10, x0, lsl #1]
               	cmp	w10, w11
               	csel	x10, x12, x13, eq
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q1, [x29, #-0x70]
               	ldur	q0, [x29, #-0x80]
               	cmgt	v1.4s, v1.4s, v0.4s
               	sub	x4, x29, #0xf0
               	stur	q1, [x29, #-0xf0]
               	ldur	q1, [x29, #-0x70]
               	cmge	v0.4s, v1.4s, v0.4s
               	sub	x5, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	ldur	q0, [x29, #-0x80]
               	cmgt	v1.4s, v0.4s, v1.4s
               	sub	x6, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	ldur	q1, [x29, #-0x70]
               	cmge	v0.4s, v0.4s, v1.4s
               	sub	x7, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldur	q0, [x29, #-0x80]
               	cmeq	v0.4s, v0.4s, v1.4s
               	sub	x8, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsw	x9, [x4, x0, lsl #2]
               	ldrsw	x10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldrsw	x12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, lt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x5, x0, lsl #2]
               	ldrsw	x10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldrsw	x12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, le
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x6, x0, lsl #2]
               	ldrsw	x10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldrsw	x12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, gt
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x7, x0, lsl #2]
               	ldrsw	x10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldrsw	x12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, ge
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x8, x0, lsl #2]
               	sub	x10, x29, #0x80
               	sub	x11, x29, #0x70
               	ldrsw	x11, [x11, x0, lsl #2]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldrsw	x10, [x10, x0, lsl #2]
               	cmp	w10, w11
               	csel	x10, x12, x13, eq
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0x80
               	sub	x2, x29, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x70
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q1, [x29, #-0x90]
               	ldur	q0, [x29, #-0x100]
               	cmhi	v1.4s, v1.4s, v0.4s
               	sub	x4, x29, #0xf0
               	stur	q1, [x29, #-0xf0]
               	ldur	q1, [x29, #-0x90]
               	cmhs	v0.4s, v1.4s, v0.4s
               	sub	x5, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	ldur	q0, [x29, #-0x100]
               	cmhi	v1.4s, v0.4s, v1.4s
               	sub	x6, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	ldur	q1, [x29, #-0x90]
               	cmhs	v0.4s, v0.4s, v1.4s
               	sub	x7, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldur	q0, [x29, #-0x100]
               	cmeq	v0.4s, v0.4s, v1.4s
               	sub	x8, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrsw	x9, [x4, x0, lsl #2]
               	ldr	w10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldr	w12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, lo
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x5, x0, lsl #2]
               	ldr	w10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldr	w12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, ls
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x6, x0, lsl #2]
               	ldr	w10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldr	w12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, hi
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x7, x0, lsl #2]
               	ldr	w10, [x3, x0, lsl #2]
               	mov	x11, #-0x1              // =-1
               	ldr	w12, [x2, x0, lsl #2]
               	cmp	w12, w10
               	csel	x10, x11, x1, hs
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x9, [x8, x0, lsl #2]
               	sub	x10, x29, #0x100
               	sub	x11, x29, #0x90
               	ldr	w11, [x11, x0, lsl #2]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldr	w10, [x10, x0, lsl #2]
               	cmp	w10, w11
               	csel	x10, x12, x13, eq
               	cmp	w9, w10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x2, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x3, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q1, [x29, #-0x70]
               	ldur	q0, [x29, #-0x60]
               	cmgt	v1.2d, v1.2d, v0.2d
               	sub	x4, x29, #0xf0
               	stur	q1, [x29, #-0xf0]
               	ldur	q1, [x29, #-0x70]
               	cmge	v0.2d, v1.2d, v0.2d
               	sub	x5, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	ldur	q0, [x29, #-0x60]
               	cmgt	v1.2d, v0.2d, v1.2d
               	sub	x6, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	ldur	q1, [x29, #-0x70]
               	cmge	v0.2d, v0.2d, v1.2d
               	sub	x7, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldur	q0, [x29, #-0x60]
               	cmeq	v0.2d, v0.2d, v1.2d
               	sub	x8, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x9, [x4, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, lt
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x5, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, le
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x6, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, gt
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x7, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, ge
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x8, x0, lsl #3]
               	sub	x10, x29, #0x60
               	sub	x11, x29, #0x70
               	ldr	x11, [x11, x0, lsl #3]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldr	x10, [x10, x0, lsl #3]
               	cmp	x10, x11
               	csel	x10, x12, x13, eq
               	cmp	x9, x10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x60
               	sub	x2, x29, #0x100
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x70
               	sub	x3, x29, #0x90
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	ldur	q1, [x29, #-0x90]
               	ldur	q0, [x29, #-0x100]
               	cmhi	v1.2d, v1.2d, v0.2d
               	sub	x4, x29, #0xf0
               	stur	q1, [x29, #-0xf0]
               	ldur	q1, [x29, #-0x90]
               	cmhs	v0.2d, v1.2d, v0.2d
               	sub	x5, x29, #0xe0
               	stur	q0, [x29, #-0xe0]
               	ldur	q0, [x29, #-0x100]
               	cmhi	v1.2d, v0.2d, v1.2d
               	sub	x6, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	ldur	q1, [x29, #-0x90]
               	cmhs	v0.2d, v0.2d, v1.2d
               	sub	x7, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldur	q0, [x29, #-0x100]
               	cmeq	v0.2d, v0.2d, v1.2d
               	sub	x8, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x9, [x4, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, lo
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x5, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, ls
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x6, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, hi
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x7, x0, lsl #3]
               	ldr	x10, [x3, x0, lsl #3]
               	mov	x11, #-0x1              // =-1
               	ldr	x12, [x2, x0, lsl #3]
               	cmp	x12, x10
               	csel	x10, x11, x1, hs
               	cmp	x9, x10
               	b.ne	<addr>
               	ldr	x9, [x8, x0, lsl #3]
               	sub	x10, x29, #0x100
               	sub	x11, x29, #0x90
               	ldr	x11, [x11, x0, lsl #3]
               	mov	x12, #-0x1              // =-1
               	mov	x13, #0x0               // =0
               	ldr	x10, [x10, x0, lsl #3]
               	cmp	x10, x11
               	csel	x10, x12, x13, eq
               	cmp	x9, x10
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x3, x29, #0x110
               	ldr	q0, [sp]
               	shl	v1.16b, v0.16b, #0x3
               	sub	x4, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	sshr	v0.16b, v0.16b, #0x2
               	sub	x5, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	sub	x6, x29, #0xa0
               	ldur	q0, [x29, #-0xa0]
               	ushr	v0.16b, v0.16b, #0x3
               	sub	x7, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	sub	x1, x29, #0x48
               	ldur	d0, [x29, #-0x48]
               	shl	v1.4h, v0.4h, #0x5
               	sub	x8, x29, #0x10
               	stur	d1, [x29, #-0x10]
               	sshr	v0.4h, v0.4h, #0xf
               	sub	x9, x29, #0x8
               	stur	d0, [x29, #-0x8]
               	mov	x0, #0x0                // =0
               	ldrsb	x10, [x4, x0]
               	ldrsb	x2, [x3, x0]
               	lsl	x11, x2, #3
               	sxtb	x11, w11
               	cmp	w10, w11
               	b.ne	<addr>
               	ldrsb	x10, [x5, x0]
               	asr	x2, x2, #2
               	cmp	w10, w2
               	b.ne	<addr>
               	ldrb	w2, [x7, x0]
               	ldrb	w10, [x6, x0]
               	eor	x2, x2, x10, lsr #3
               	cbnz	w2, <addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldrsh	x2, [x8, x0, lsl #1]
               	ldrsh	x3, [x1, x0, lsl #1]
               	lsl	x3, x3, #5
               	sxth	x3, w3
               	cmp	w2, w3
               	b.ne	<addr>
               	ldrsh	x2, [x9, x0, lsl #1]
               	ldrsh	x3, [x1, x0, lsl #1]
               	asr	x3, x3, #15
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x1, x29, #0x80
               	ldur	q0, [x29, #-0x80]
               	neg	v1.4s, v0.4s
               	sub	x2, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	mvn	v0.16b, v0.16b
               	sub	x3, x29, #0xc0
               	stur	q0, [x29, #-0xc0]
               	ldur	q0, [x29, #-0x60]
               	neg	v0.2d, v0.2d
               	ldur	q1, [x29, #-0xa0]
               	mvn	v1.16b, v1.16b
               	stur	q1, [x29, #-0xb0]
               	mov	x0, #0x0                // =0
               	ldrsw	x4, [x2, x0, lsl #2]
               	ldrsw	x5, [x1, x0, lsl #2]
               	neg	x5, x5
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x4, [x3, x0, lsl #2]
               	ldrsw	x5, [x1, x0, lsl #2]
               	mvn	x5, x5
               	cmp	x4, x5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, v0.d[0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, v0.d[1]
               	mov	x17, #-0x5              // =-5
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0xb0]
               	cmp	w0, #0x7f
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0xaf]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0xae]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xad]
               	cmp	w0, #0xfe
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xac]
               	cmp	w0, #0x80
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xab]
               	cmp	w0, #0xfa
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xaa]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa9]
               	cmp	w0, #0xfc
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa8]
               	cmp	w0, #0xfc
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa7]
               	cmp	w0, #0xf6
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa6]
               	cmp	w0, #0x8
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa5]
               	cmp	w0, #0x9b
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa4]
               	cmp	w0, #0x63
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa3]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa2]
               	cmp	w0, #0xf8
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xa1]
               	cmp	w0, #0xf7
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
