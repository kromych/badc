
arm_neon_immediate_shifts.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0xd0
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x90
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	sub	x6, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x6]
               	sub	x5, x29, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
               	sub	x12, x29, #0x70
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x12]
               	sub	x2, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x2]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x5]
               	ldr	q0, [x1]
               	sqshl	v1.16b, v0.16b, #0x3
               	sub	x7, x29, #0xd0
               	stur	q1, [x29, #-0xd0]
               	uqshl	v1.16b, v0.16b, #0x2
               	sub	x8, x29, #0xc0
               	stur	q1, [x29, #-0xc0]
               	srshr	v1.16b, v0.16b, #0x3
               	sub	x9, x29, #0xb0
               	stur	q1, [x29, #-0xb0]
               	urshr	v1.8h, v0.8h, #0x10
               	sub	x13, x29, #0xa0
               	stur	q1, [x29, #-0xa0]
               	mov	x1, x0
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	ldrsb	x10, [x7, x0]
               	ldrsb	x2, [x3, x0]
               	lsl	x4, x2, #3
               	mov	x2, #-0x80              // =-128
               	cmp	w4, w2
               	b.ge	<addr>
               	cmp	w10, w2
               	cset	x2, ne
               	orr	x2, x1, x2
               	ldrb	w4, [x8, x0]
               	ldrb	w1, [x6, x0]
               	lsl	x1, x1, #2
               	cmp	w1, #0xff
               	mov	x16, #0xff              // =255
               	csel	x1, x16, x1, gt
               	cmp	w4, w1
               	cset	x1, ne
               	orr	x1, x2, x1, lsl #1
               	ldrsb	x2, [x9, x0]
               	ldrsb	x4, [x3, x0]
               	add	x4, x4, #0x4
               	asr	x4, x4, #3
               	cmp	w2, w4
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #2
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrh	w2, [x13, x0, lsl #1]
               	ldrh	w4, [x12, x0, lsl #1]
               	add	x4, x4, #0x8, lsl #12   // =0x8000
               	lsr	x4, x4, #16
               	cmp	w2, w4
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #3
               	b	<addr>
               	cmp	w4, #0x7f
               	mov	x16, #0x7f              // =127
               	csel	x2, x16, x4, gt
               	b	<addr>
               	shrn	v1.8b, v0.8h, #0x3
               	rshrn	v2.4h, v0.4s, #0x10
               	smov	x0, v1.b[0]
               	cmn	x0, #0x10
               	cset	x0, ne
               	orr	x0, x1, x0, lsl #4
               	smov	x1, v1.b[1]
               	cmp	x1, #0x3f
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v1.b[2]
               	cmn	x1, #0x60
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v1.b[3]
               	cmp	x1, #0x55
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v1.b[4]
               	cmn	x1, #0x3a
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v1.b[5]
               	cmn	x1, #0x30
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v1.b[6]
               	cmn	x1, #0x60
               	cset	x1, ne
               	orr	x0, x0, x1, lsl #4
               	smov	x1, v1.b[7]
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
               	orr	x1, x0, x1, lsl #5
               	sqshl	v1.2d, v0.2d, #0x1
               	sub	x3, x29, #0xa0
               	stur	q1, [x29, #-0xa0]
               	mov	x0, #0x0                // =0
               	mov	x8, #-0x4000000000000000 // =-4611686018427387904
               	mov	x4, #0x3fffffffffffffff // =4611686018427387903
               	b	<addr>
               	cmp	x6, x2
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #6
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.ge	<addr>
               	ldr	x6, [x3, x0, lsl #3]
               	ldr	x2, [x5, x0, lsl #3]
               	cmp	x2, x4
               	b.le	<addr>
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	b	<addr>
               	lsl	x7, x2, #1
               	cmp	x2, x8
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	csel	x2, x16, x7, lt
               	b	<addr>
               	mov	x0, #0xc0               // =192
               	mov	x2, #0x0                // =0
               	fmov	d1, x2
               	mov	v1.b[0], w0
               	mov	x0, #0x40               // =64
               	mov	v1.b[1], w0
               	mov	x0, #0xfd               // =253
               	mov	v1.b[2], w0
               	mov	x0, #0x2                // =2
               	mov	v1.b[3], w0
               	mov	x0, #0x7e               // =126
               	mov	v1.b[4], w0
               	mov	x0, #0x81               // =129
               	mov	v1.b[5], w0
               	mov	x0, #0xfe               // =254
               	mov	v1.b[6], w0
               	mov	x0, #0x34               // =52
               	mov	v2.16b, v1.16b
               	mov	v2.b[7], w0
               	mov	x0, #0x12               // =18
               	mov	v1.16b, v2.16b
               	mov	v1.b[8], w0
               	mov	x0, #0xaa               // =170
               	mov	v1.b[9], w0
               	mov	x0, #0x55               // =85
               	mov	v1.b[10], w0
               	mov	x0, #0x0                // =0
               	mov	v1.b[11], w0
               	mov	x2, #0x1                // =1
               	mov	v1.b[12], w2
               	mov	x2, #0xff               // =255
               	mov	v1.b[13], w2
               	mov	x2, #0x7f               // =127
               	mov	v1.b[14], w2
               	mov	x2, #0x80               // =128
               	mov	v1.b[15], w2
               	sub	x3, x29, #0x50
               	stur	q1, [x29, #-0x50]
               	sub	x5, x29, #0x40
               	stur	q1, [x29, #-0x40]
               	sub	x10, x29, #0x30
               	stur	q1, [x29, #-0x30]
               	sub	x9, x29, #0x20
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x9]
               	sub	x4, x29, #0x10
               	stur	q1, [x29, #-0x10]
               	ldr	q3, [x2]
               	ldr	d4, [x2]
               	mov	d5, v2.d[0]
               	mov	d6, v2.d[0]
               	mov	v7.16b, v0.16b
               	ssra	v7.16b, v1.16b, #0x3
               	sub	x6, x29, #0xc0
               	stur	q7, [x29, #-0xc0]
               	mov	v7.16b, v0.16b
               	ursra	v7.8h, v1.8h, #0x10
               	sub	x11, x29, #0xb0
               	stur	q7, [x29, #-0xb0]
               	mov	v16.16b, v4.16b
               	ssra	d16, d5, #0x40
               	mov	v5.16b, v16.16b
               	mov	v7.16b, v3.16b
               	ursra	v7.2d, v1.2d, #0x1
               	sub	x12, x29, #0xa0
               	stur	q7, [x29, #-0xa0]
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	ldrsb	x2, [x6, x0]
               	sub	x7, x29, #0x90
               	ldrsb	x7, [x7, x0]
               	ldrsb	x8, [x3, x0]
               	add	x7, x7, x8, asr #3
               	sxtb	x7, w7
               	cmp	w2, w7
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #7
               	cmp	w0, #0x8
               	b.ge	<addr>
               	ldrh	w2, [x11, x0, lsl #1]
               	sub	x7, x29, #0x70
               	ldrh	w7, [x7, x0, lsl #1]
               	ldrh	w8, [x10, x0, lsl #1]
               	add	x8, x8, #0x8, lsl #12   // =0x8000
               	add	x7, x7, x8, lsr #16
               	and	x7, x7, #0xffff
               	cmp	w2, w7
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #8
               	cmp	w0, #0x2
               	b.ge	<addr>
               	ldr	x7, [x12, x0, lsl #3]
               	ldr	x8, [x9, x0, lsl #3]
               	ldr	x2, [x4, x0, lsl #3]
               	add	x8, x8, x2, lsr #1
               	and	x2, x2, #0x1
               	add	x2, x8, x2
               	cmp	x7, x2
               	cset	x2, ne
               	orr	x1, x1, x2, lsl #9
               	b	<addr>
               	mov	x0, v5.d[0]
               	mov	x2, v2.d[0]
               	cmp	x2, #0x0
               	mov	x16, #-0x1              // =-1
               	csel	x2, x16, xzr, lt
               	mov	x17, #0x7f80            // =32640
               	movk	x17, #0x1ff, lsl #16
               	movk	x17, #0x5500, lsl #32
               	movk	x17, #0x12aa, lsl #48
               	add	x2, x2, x17
               	cmp	x0, x2
               	cset	x0, ne
               	orr	x0, x1, x0, lsl #9
               	mov	v2.16b, v0.16b
               	sli	v2.16b, v1.16b, #0x3
               	sub	x6, x29, #0xc0
               	stur	q2, [x29, #-0xc0]
               	mov	v2.16b, v4.16b
               	sri	v2.8b, v6.8b, #0x3
               	sub	x9, x29, #0x18
               	stur	d2, [x29, #-0x18]
               	sri	v0.4s, v1.4s, #0x20
               	sub	x10, x29, #0xb0
               	stur	q0, [x29, #-0xb0]
               	mov	v0.16b, v3.16b
               	sli	v0.2d, v1.2d, #0x0
               	sub	x11, x29, #0xa0
               	stur	q0, [x29, #-0xa0]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x10
               	b.ge	<addr>
               	ldrb	w7, [x6, x1]
               	ldrb	w2, [x5, x1]
               	sub	x3, x29, #0x80
               	ldrb	w3, [x3, x1]
               	and	x8, x3, #0x7
               	orr	x8, x8, x2, lsl #3
               	and	x8, x8, #0xff
               	cmp	w7, w8
               	cset	x7, ne
               	orr	x0, x0, x7, lsl #10
               	cmp	w1, #0x8
               	b.ge	<addr>
               	ldrb	w7, [x9, x1]
               	and	x3, x3, #0xe0
               	orr	x2, x3, x2, lsr #3
               	cmp	w7, w2
               	cset	x2, ne
               	orr	x0, x0, x2, lsl #10
               	cmp	w1, #0x4
               	b.ge	<addr>
               	ldr	w2, [x10, x1, lsl #2]
               	sub	x3, x29, #0x60
               	ldr	w3, [x3, x1, lsl #2]
               	cmp	w2, w3
               	cset	x2, ne
               	orr	x0, x0, x2, lsl #11
               	cmp	w1, #0x2
               	b.ge	<addr>
               	ldr	x2, [x11, x1, lsl #3]
               	ldr	x3, [x4, x1, lsl #3]
               	cmp	x2, x3
               	cset	x2, ne
               	orr	x0, x0, x2, lsl #11
               	b	<addr>
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
