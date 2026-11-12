
arm_neon_immediate_shifts.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	mov	x0, #0x0                // =0
               	sub	x5, x29, #0x40
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
               	sub	x6, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x6]
               	sub	x4, x29, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	sub	x7, x29, #0x20
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x7]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x4]
               	ldr	q1, [x1]
               	sqshl	v0.16b, v1.16b, #0x3
               	sub	x8, x29, #0x80
               	stur	q0, [x29, #-0x80]
               	uqshl	v0.16b, v1.16b, #0x2
               	sub	x9, x29, #0x70
               	stur	q0, [x29, #-0x70]
               	srshr	v0.16b, v1.16b, #0x3
               	sub	x10, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	urshr	v0.8h, v1.8h, #0x10
               	sub	x11, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x1, x0
               	ldrsb	x12, [x8, x0]
               	ldrsb	x2, [x5, x0]
               	lsl	x3, x2, #3
               	mov	x2, #-0x80              // =-128
               	mov	x13, #0x7f              // =127
               	cmp	w3, w2
               	b.ge	<addr>
               	cmp	w12, w2
               	cset	x2, ne
               	orr	x2, x1, x2
               	ldrb	w3, [x9, x0]
               	ldrb	w1, [x6, x0]
               	lsl	x1, x1, #2
               	mov	x12, #0xff              // =255
               	cmp	w1, #0xff
               	csel	x1, x12, x1, gt
               	cmp	w3, w1
               	cset	x1, ne
               	orr	x1, x2, x1, lsl #1
               	ldrsb	x2, [x10, x0]
               	ldrsb	x3, [x5, x0]
               	add	x3, x3, #0x4
               	asr	x3, x3, #3
               	cmp	w2, w3
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrh	w2, [x11, x0, lsl #1]
               	ldrh	w3, [x7, x0, lsl #1]
               	add	x3, x3, #0x8, lsl #12   // =0x8000
               	lsr	x3, x3, #16
               	cmp	w2, w3
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #3
               	b	<addr>
               	cmp	w3, #0x7f
               	csel	x2, x13, x3, gt
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	shrn	v0.8b, v1.8h, #0x3
               	rshrn	v2.4h, v1.4s, #0x10
               	smov	x0, v0.b[0]
               	mov	x17, #-0x10             // =-16
               	cmp	x0, x17
               	cset	x0, ne
               	orr	x0, x1, x0, lsl #4
               	smov	x1, v0.b[1]
               	cmp	x1, #0x3f
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v0.b[2]
               	mov	x17, #-0x60             // =-96
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v0.b[3]
               	cmp	x1, #0x55
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v0.b[4]
               	mov	x17, #-0x3a             // =-58
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v0.b[5]
               	mov	x17, #-0x30             // =-48
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v0.b[6]
               	mov	x17, #-0x60             // =-96
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v0.b[7]
               	cmp	x1, #0x8
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	umov	w1, v2.h[0]
               	cmp	x1, #0x1ff
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #5
               	umov	w1, v2.h[1]
               	mov	x17, #0x12aa            // =4778
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #5
               	umov	w1, v2.h[2]
               	mov	x17, #0x7e82            // =32386
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #5
               	umov	w1, v2.h[3]
               	mov	x17, #0xc041            // =49217
               	cmp	x1, x17
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #5
               	sqshl	v0.2d, v1.2d, #0x1
               	sub	x3, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x1, #0x0                // =0
               	mov	x5, #-0x4000000000000000 // =-4611686018427387904
               	mov	x6, #0x3fffffffffffffff // =4611686018427387903
               	ldr	x7, [x3, x1, lsl #3]
               	ldr	x2, [x4, x1, lsl #3]
               	cmp	x2, x6
               	b.le	<addr>
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	b	<addr>
               	cmp	x2, x5
               	b.ge	<addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	ldr	x2, [x4, x1, lsl #3]
               	lsl	x2, x2, #1
               	cmp	x7, x2
               	cset	x2, ne
               	orr	x0, x0, x2, lsl #6
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
