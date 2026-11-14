
vector_wider_than_the_registers.aarch64:	file format elf64-littleaarch64

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

<ops_s8x32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	add	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	add	v1.16b, v1.16b, v2.16b
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	sub	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	sub	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	mul	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	mul	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	and	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x60]
               	str	q1, [x0, #0x70]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	orr	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	eor	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0xa0]
               	str	q1, [x0, #0xb0]
               	ldur	q0, [x29, #-0x40]
               	neg	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x30]
               	neg	v1.16b, v1.16b
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	ldur	q0, [x29, #-0x40]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x30]
               	mvn	v1.16b, v1.16b
               	str	q0, [x0, #0xe0]
               	str	q1, [x0, #0xf0]
               	ldur	q0, [x29, #-0x40]
               	shl	v0.16b, v0.16b, #0x3
               	ldur	q1, [x29, #-0x30]
               	shl	v1.16b, v1.16b, #0x3
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	ldur	q0, [x29, #-0x40]
               	sshr	v0.16b, v0.16b, #0x5
               	ldur	q1, [x29, #-0x30]
               	sshr	v1.16b, v1.16b, #0x5
               	str	q0, [x0, #0x120]
               	str	q1, [x0, #0x130]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x40]
               	cmgt	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x30]
               	cmgt	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmge	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmge	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x160]
               	str	q1, [x0, #0x170]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmeq	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmeq	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s8x32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	strb	w2, [x5, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.ge	<addr>
               	sub	x2, x29, #0x1e0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	lsr	x5, x5, #11
               	strb	w5, [x2, x0]
               	sub	x5, x29, #0x1c0
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	lsr	x2, x2, #11
               	sxtb	x2, w2
               	b	<addr>
               	ldrsb	x2, [x2, x0]
               	b	<addr>
               	sub	x0, x29, #0x1a0
               	sub	x20, x29, #0x1e0
               	sub	x21, x29, #0x1c0
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldrsb	x1, [x20, x0]
               	ldrsb	x2, [x21, x0]
               	add	x4, x1, x2
               	sxtb	x4, w4
               	sub	x5, x1, x2
               	sxtb	x5, w5
               	mul	x6, x1, x2
               	sxtb	x6, w6
               	and	x7, x1, x2
               	sxtb	x7, w7
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x2, x1
               	sxtb	x10, w2
               	mvn	x11, x1
               	lsl	x1, x1, #3
               	sxtb	x12, w1
               	ldrsb	x1, [x20, x0]
               	asr	x13, x1, #5
               	sub	x2, x29, #0x1c0
               	ldrsb	x2, [x2, x0]
               	cmp	w1, w2
               	cset	x1, lt
               	neg	x14, x1
               	sub	x1, x29, #0x1e0
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w2
               	cset	x1, ge
               	neg	x2, x1
               	sub	x1, x29, #0x1e0
               	ldrsb	x1, [x1, x0]
               	sub	x15, x29, #0x1c0
               	ldrsb	x15, [x15, x0]
               	cmp	w1, w15
               	cset	x1, eq
               	neg	x15, x1
               	sub	x1, x29, #0x1a0
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x20
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x40
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x60
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x80
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0xa0
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0xc0
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0xe0
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x100
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x120
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x140
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x160
               	ldrsb	x4, [x4, x0]
               	cmp	w4, w2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x180
               	ldrsb	x1, [x1, x0]
               	cmp	w1, w15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x10
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_u8x64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	add	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	add	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	add	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	add	v3.16b, v3.16b, v4.16b
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	str	q2, [x0, #0x20]
               	str	q3, [x0, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	sub	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	sub	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	sub	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	sub	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	str	q2, [x0, #0x60]
               	str	q3, [x0, #0x70]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	mul	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	mul	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	mul	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	mul	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	str	q2, [x0, #0xa0]
               	str	q3, [x0, #0xb0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	and	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	and	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	and	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	str	q2, [x0, #0xe0]
               	str	q3, [x0, #0xf0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	orr	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	orr	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	orr	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	str	q2, [x0, #0x120]
               	str	q3, [x0, #0x130]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	eor	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	eor	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	eor	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	str	q2, [x0, #0x160]
               	str	q3, [x0, #0x170]
               	ldur	q0, [x29, #-0x80]
               	neg	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x70]
               	neg	v1.16b, v1.16b
               	ldur	q2, [x29, #-0x60]
               	neg	v2.16b, v2.16b
               	ldur	q3, [x29, #-0x50]
               	neg	v3.16b, v3.16b
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	str	q2, [x0, #0x1a0]
               	str	q3, [x0, #0x1b0]
               	ldur	q0, [x29, #-0x80]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x70]
               	mvn	v1.16b, v1.16b
               	ldur	q2, [x29, #-0x60]
               	mvn	v2.16b, v2.16b
               	ldur	q3, [x29, #-0x50]
               	mvn	v3.16b, v3.16b
               	str	q0, [x0, #0x1c0]
               	str	q1, [x0, #0x1d0]
               	str	q2, [x0, #0x1e0]
               	str	q3, [x0, #0x1f0]
               	ldur	q0, [x29, #-0x80]
               	shl	v0.16b, v0.16b, #0x3
               	ldur	q1, [x29, #-0x70]
               	shl	v1.16b, v1.16b, #0x3
               	ldur	q2, [x29, #-0x60]
               	shl	v2.16b, v2.16b, #0x3
               	ldur	q3, [x29, #-0x50]
               	shl	v3.16b, v3.16b, #0x3
               	str	q0, [x0, #0x200]
               	str	q1, [x0, #0x210]
               	str	q2, [x0, #0x220]
               	str	q3, [x0, #0x230]
               	ldur	q0, [x29, #-0x80]
               	ushr	v0.16b, v0.16b, #0x5
               	ldur	q1, [x29, #-0x70]
               	ushr	v1.16b, v1.16b, #0x5
               	ldur	q2, [x29, #-0x60]
               	ushr	v2.16b, v2.16b, #0x5
               	ldur	q3, [x29, #-0x50]
               	ushr	v3.16b, v3.16b, #0x5
               	str	q0, [x0, #0x240]
               	str	q1, [x0, #0x250]
               	str	q2, [x0, #0x260]
               	str	q3, [x0, #0x270]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x80]
               	cmhi	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x70]
               	cmhi	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x20]
               	ldur	q3, [x29, #-0x60]
               	cmhi	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x10]
               	ldur	q4, [x29, #-0x50]
               	cmhi	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x280]
               	str	q1, [x0, #0x290]
               	str	q2, [x0, #0x2a0]
               	str	q3, [x0, #0x2b0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmhs	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmhs	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmhs	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmhs	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x2c0]
               	str	q1, [x0, #0x2d0]
               	str	q2, [x0, #0x2e0]
               	str	q3, [x0, #0x2f0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmeq	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmeq	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmeq	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmeq	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x300]
               	str	q1, [x0, #0x310]
               	str	q2, [x0, #0x320]
               	str	q3, [x0, #0x330]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u8x64>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x3e0
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	strb	w2, [x5, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.ge	<addr>
               	sub	x2, x29, #0x3c0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	ubfx	x5, x5, #11, #8
               	strb	w5, [x2, x0]
               	sub	x5, x29, #0x380
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	ubfx	x2, x2, #11, #8
               	b	<addr>
               	ldrb	w2, [x2, x0]
               	b	<addr>
               	sub	x0, x29, #0x340
               	sub	x20, x29, #0x3c0
               	sub	x21, x29, #0x380
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldrb	w1, [x20, x0]
               	ldrb	w2, [x21, x0]
               	add	x4, x1, x2
               	and	x4, x4, #0xff
               	sub	x5, x1, x2
               	and	x5, x5, #0xff
               	mul	x6, x1, x2
               	and	x6, x6, #0xff
               	and	x7, x1, x2
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x2, x1
               	and	x10, x2, #0xff
               	mvn	x2, x1
               	and	x11, x2, #0xff
               	lsl	x1, x1, #3
               	and	x12, x1, #0xff
               	ldrb	w1, [x20, x0]
               	lsr	x13, x1, #5
               	sub	x2, x29, #0x380
               	ldrb	w2, [x2, x0]
               	cmp	w1, w2
               	cset	x1, lt
               	neg	x1, x1
               	and	x14, x1, #0xff
               	sub	x1, x29, #0x3c0
               	ldrb	w1, [x1, x0]
               	cmp	w1, w2
               	cset	x1, ge
               	neg	x1, x1
               	and	x2, x1, #0xff
               	sub	x1, x29, #0x3c0
               	ldrb	w1, [x1, x0]
               	sub	x15, x29, #0x380
               	ldrb	w15, [x15, x0]
               	cmp	w1, w15
               	cset	x1, eq
               	neg	x1, x1
               	and	x15, x1, #0xff
               	sub	x1, x29, #0x340
               	ldrb	w1, [x1, x0]
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x40
               	ldrb	w4, [x4, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x80
               	ldrb	w1, [x1, x0]
               	cmp	w1, w6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x340
               	add	x4, x1, #0xc0
               	ldrb	w4, [x4, x0]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x100
               	ldrb	w4, [x4, x0]
               	cmp	w4, w8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0x140
               	ldrb	w4, [x4, x0]
               	cmp	w4, w9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0x180
               	ldrb	w1, [x1, x0]
               	cmp	w1, w10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x1c0
               	ldrb	w4, [x4, x0]
               	cmp	w4, w11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x200
               	ldrb	w4, [x4, x0]
               	cmp	w4, w12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x240
               	ldrb	w4, [x4, x0]
               	cmp	w4, w13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x280
               	ldrb	w4, [x4, x0]
               	cmp	w4, w14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x2c0
               	ldrb	w4, [x4, x0]
               	cmp	w4, w2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x300
               	ldrb	w1, [x1, x0]
               	cmp	w1, w15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x20
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_u16x16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	add	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	add	v1.8h, v1.8h, v2.8h
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	sub	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	sub	v1.8h, v1.8h, v2.8h
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	mul	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	mul	v1.8h, v1.8h, v2.8h
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	and	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x60]
               	str	q1, [x0, #0x70]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	orr	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	eor	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0xa0]
               	str	q1, [x0, #0xb0]
               	ldur	q0, [x29, #-0x40]
               	neg	v0.8h, v0.8h
               	ldur	q1, [x29, #-0x30]
               	neg	v1.8h, v1.8h
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	ldur	q0, [x29, #-0x40]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x30]
               	mvn	v1.16b, v1.16b
               	str	q0, [x0, #0xe0]
               	str	q1, [x0, #0xf0]
               	ldur	q0, [x29, #-0x40]
               	shl	v0.8h, v0.8h, #0x3
               	ldur	q1, [x29, #-0x30]
               	shl	v1.8h, v1.8h, #0x3
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	ldur	q0, [x29, #-0x40]
               	ushr	v0.8h, v0.8h, #0x5
               	ldur	q1, [x29, #-0x30]
               	ushr	v1.8h, v1.8h, #0x5
               	str	q0, [x0, #0x120]
               	str	q1, [x0, #0x130]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x40]
               	cmhi	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x30]
               	cmhi	v1.8h, v1.8h, v2.8h
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmhs	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmhs	v1.8h, v1.8h, v2.8h
               	str	q0, [x0, #0x160]
               	str	q1, [x0, #0x170]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmeq	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmeq	v1.8h, v1.8h, v2.8h
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u16x16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	strh	w2, [x5, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x2, x29, #0x1e0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	ubfx	x5, x5, #11, #16
               	strh	w5, [x2, x0, lsl #1]
               	sub	x5, x29, #0x1c0
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	ubfx	x2, x2, #11, #16
               	b	<addr>
               	ldrh	w2, [x2, x0, lsl #1]
               	b	<addr>
               	sub	x0, x29, #0x1a0
               	sub	x20, x29, #0x1e0
               	sub	x21, x29, #0x1c0
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldrh	w1, [x20, x0, lsl #1]
               	ldrh	w2, [x21, x0, lsl #1]
               	add	x4, x1, x2
               	and	x4, x4, #0xffff
               	sub	x5, x1, x2
               	and	x5, x5, #0xffff
               	mul	x6, x1, x2
               	and	x6, x6, #0xffff
               	and	x7, x1, x2
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x2, x1
               	and	x10, x2, #0xffff
               	mvn	x2, x1
               	and	x11, x2, #0xffff
               	lsl	x1, x1, #3
               	and	x12, x1, #0xffff
               	ldrh	w1, [x20, x0, lsl #1]
               	lsr	x13, x1, #5
               	sub	x2, x29, #0x1c0
               	ldrh	w2, [x2, x0, lsl #1]
               	cmp	w1, w2
               	cset	x1, lt
               	neg	x1, x1
               	and	x14, x1, #0xffff
               	sub	x1, x29, #0x1e0
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	cset	x1, ge
               	neg	x1, x1
               	and	x2, x1, #0xffff
               	sub	x1, x29, #0x1e0
               	ldrh	w1, [x1, x0, lsl #1]
               	sub	x15, x29, #0x1c0
               	ldrh	w15, [x15, x0, lsl #1]
               	cmp	w1, w15
               	cset	x1, eq
               	neg	x1, x1
               	and	x15, x1, #0xffff
               	sub	x1, x29, #0x1a0
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x20
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x40
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x60
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x80
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0xa0
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0xc0
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0xe0
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x100
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x120
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x140
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x160
               	ldrh	w4, [x4, x0, lsl #1]
               	cmp	w4, w2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x180
               	ldrh	w1, [x1, x0, lsl #1]
               	cmp	w1, w15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x30
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_s16x32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	add	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	add	v1.8h, v1.8h, v2.8h
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	add	v2.8h, v2.8h, v3.8h
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	add	v3.8h, v3.8h, v4.8h
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	str	q2, [x0, #0x20]
               	str	q3, [x0, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	sub	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	sub	v1.8h, v1.8h, v2.8h
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	sub	v2.8h, v2.8h, v3.8h
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	sub	v3.8h, v3.8h, v4.8h
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	str	q2, [x0, #0x60]
               	str	q3, [x0, #0x70]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	mul	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	mul	v1.8h, v1.8h, v2.8h
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	mul	v2.8h, v2.8h, v3.8h
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	mul	v3.8h, v3.8h, v4.8h
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	str	q2, [x0, #0xa0]
               	str	q3, [x0, #0xb0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	and	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	and	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	and	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	str	q2, [x0, #0xe0]
               	str	q3, [x0, #0xf0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	orr	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	orr	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	orr	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	str	q2, [x0, #0x120]
               	str	q3, [x0, #0x130]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	eor	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	eor	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	eor	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	str	q2, [x0, #0x160]
               	str	q3, [x0, #0x170]
               	ldur	q0, [x29, #-0x80]
               	neg	v0.8h, v0.8h
               	ldur	q1, [x29, #-0x70]
               	neg	v1.8h, v1.8h
               	ldur	q2, [x29, #-0x60]
               	neg	v2.8h, v2.8h
               	ldur	q3, [x29, #-0x50]
               	neg	v3.8h, v3.8h
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	str	q2, [x0, #0x1a0]
               	str	q3, [x0, #0x1b0]
               	ldur	q0, [x29, #-0x80]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x70]
               	mvn	v1.16b, v1.16b
               	ldur	q2, [x29, #-0x60]
               	mvn	v2.16b, v2.16b
               	ldur	q3, [x29, #-0x50]
               	mvn	v3.16b, v3.16b
               	str	q0, [x0, #0x1c0]
               	str	q1, [x0, #0x1d0]
               	str	q2, [x0, #0x1e0]
               	str	q3, [x0, #0x1f0]
               	ldur	q0, [x29, #-0x80]
               	shl	v0.8h, v0.8h, #0x3
               	ldur	q1, [x29, #-0x70]
               	shl	v1.8h, v1.8h, #0x3
               	ldur	q2, [x29, #-0x60]
               	shl	v2.8h, v2.8h, #0x3
               	ldur	q3, [x29, #-0x50]
               	shl	v3.8h, v3.8h, #0x3
               	str	q0, [x0, #0x200]
               	str	q1, [x0, #0x210]
               	str	q2, [x0, #0x220]
               	str	q3, [x0, #0x230]
               	ldur	q0, [x29, #-0x80]
               	sshr	v0.8h, v0.8h, #0x5
               	ldur	q1, [x29, #-0x70]
               	sshr	v1.8h, v1.8h, #0x5
               	ldur	q2, [x29, #-0x60]
               	sshr	v2.8h, v2.8h, #0x5
               	ldur	q3, [x29, #-0x50]
               	sshr	v3.8h, v3.8h, #0x5
               	str	q0, [x0, #0x240]
               	str	q1, [x0, #0x250]
               	str	q2, [x0, #0x260]
               	str	q3, [x0, #0x270]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x80]
               	cmgt	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x70]
               	cmgt	v1.8h, v1.8h, v2.8h
               	ldur	q2, [x29, #-0x20]
               	ldur	q3, [x29, #-0x60]
               	cmgt	v2.8h, v2.8h, v3.8h
               	ldur	q3, [x29, #-0x10]
               	ldur	q4, [x29, #-0x50]
               	cmgt	v3.8h, v3.8h, v4.8h
               	str	q0, [x0, #0x280]
               	str	q1, [x0, #0x290]
               	str	q2, [x0, #0x2a0]
               	str	q3, [x0, #0x2b0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmge	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmge	v1.8h, v1.8h, v2.8h
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmge	v2.8h, v2.8h, v3.8h
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmge	v3.8h, v3.8h, v4.8h
               	str	q0, [x0, #0x2c0]
               	str	q1, [x0, #0x2d0]
               	str	q2, [x0, #0x2e0]
               	str	q3, [x0, #0x2f0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmeq	v0.8h, v0.8h, v1.8h
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmeq	v1.8h, v1.8h, v2.8h
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmeq	v2.8h, v2.8h, v3.8h
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmeq	v3.8h, v3.8h, v4.8h
               	str	q0, [x0, #0x300]
               	str	q1, [x0, #0x310]
               	str	q2, [x0, #0x320]
               	str	q3, [x0, #0x330]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s16x32>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x3e0
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	strh	w2, [x5, x0, lsl #1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.ge	<addr>
               	sub	x2, x29, #0x3c0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	lsr	x5, x5, #11
               	strh	w5, [x2, x0, lsl #1]
               	sub	x5, x29, #0x380
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	lsr	x2, x2, #11
               	sxth	x2, w2
               	b	<addr>
               	ldrsh	x2, [x2, x0, lsl #1]
               	b	<addr>
               	sub	x0, x29, #0x340
               	sub	x20, x29, #0x3c0
               	sub	x21, x29, #0x380
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldrsh	x1, [x20, x0, lsl #1]
               	ldrsh	x2, [x21, x0, lsl #1]
               	add	x4, x1, x2
               	sxth	x4, w4
               	sub	x5, x1, x2
               	sxth	x5, w5
               	mul	x6, x1, x2
               	sxth	x6, w6
               	and	x7, x1, x2
               	sxth	x7, w7
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x2, x1
               	sxth	x10, w2
               	mvn	x11, x1
               	lsl	x1, x1, #3
               	sxth	x12, w1
               	ldrsh	x1, [x20, x0, lsl #1]
               	asr	x13, x1, #5
               	sub	x2, x29, #0x380
               	ldrsh	x2, [x2, x0, lsl #1]
               	cmp	w1, w2
               	cset	x1, lt
               	neg	x14, x1
               	sub	x1, x29, #0x3c0
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w2
               	cset	x1, ge
               	neg	x2, x1
               	sub	x1, x29, #0x3c0
               	ldrsh	x1, [x1, x0, lsl #1]
               	sub	x15, x29, #0x380
               	ldrsh	x15, [x15, x0, lsl #1]
               	cmp	w1, w15
               	cset	x1, eq
               	neg	x15, x1
               	sub	x1, x29, #0x340
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x40
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x80
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x340
               	add	x4, x1, #0xc0
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x100
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0x140
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0x180
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x1c0
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x200
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x240
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x280
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x2c0
               	ldrsh	x4, [x4, x0, lsl #1]
               	cmp	w4, w2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x300
               	ldrsh	x1, [x1, x0, lsl #1]
               	cmp	w1, w15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x40
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_s32x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	add	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	add	v1.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	sub	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	sub	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	mul	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	mul	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	and	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x60]
               	str	q1, [x0, #0x70]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	orr	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	eor	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0xa0]
               	str	q1, [x0, #0xb0]
               	ldur	q0, [x29, #-0x40]
               	neg	v0.4s, v0.4s
               	ldur	q1, [x29, #-0x30]
               	neg	v1.4s, v1.4s
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	ldur	q0, [x29, #-0x40]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x30]
               	mvn	v1.16b, v1.16b
               	str	q0, [x0, #0xe0]
               	str	q1, [x0, #0xf0]
               	ldur	q0, [x29, #-0x40]
               	shl	v0.4s, v0.4s, #0x3
               	ldur	q1, [x29, #-0x30]
               	shl	v1.4s, v1.4s, #0x3
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	ldur	q0, [x29, #-0x40]
               	sshr	v0.4s, v0.4s, #0x5
               	ldur	q1, [x29, #-0x30]
               	sshr	v1.4s, v1.4s, #0x5
               	str	q0, [x0, #0x120]
               	str	q1, [x0, #0x130]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x40]
               	cmgt	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x30]
               	cmgt	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmge	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmge	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x160]
               	str	q1, [x0, #0x170]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmeq	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmeq	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s32x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	str	w2, [x5, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x2, x29, #0x1e0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	lsr	x5, x5, #11
               	str	w5, [x2, x0, lsl #2]
               	sub	x5, x29, #0x1c0
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	lsr	x2, x2, #11
               	b	<addr>
               	ldrsw	x2, [x2, x0, lsl #2]
               	b	<addr>
               	sub	x0, x29, #0x1a0
               	sub	x20, x29, #0x1e0
               	sub	x21, x29, #0x1c0
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldrsw	x1, [x20, x0, lsl #2]
               	ldrsw	x2, [x21, x0, lsl #2]
               	add	x4, x1, x2
               	sub	x5, x1, x2
               	mul	x6, x1, x2
               	and	x7, x1, x2
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x10, x1
               	mvn	x11, x1
               	lsl	x12, x1, #3
               	asr	x13, x1, #5
               	sub	x2, x29, #0x1c0
               	ldrsw	x2, [x2, x0, lsl #2]
               	cmp	w1, w2
               	cset	x1, lt
               	neg	x14, x1
               	sub	x1, x29, #0x1e0
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w2
               	cset	x1, ge
               	neg	x2, x1
               	sub	x1, x29, #0x1e0
               	ldrsw	x1, [x1, x0, lsl #2]
               	sub	x15, x29, #0x1c0
               	ldrsw	x15, [x15, x0, lsl #2]
               	cmp	w1, w15
               	cset	x1, eq
               	neg	x15, x1
               	sub	x1, x29, #0x1a0
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x20
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x40
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x60
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x80
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0xa0
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0xc0
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0xe0
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x100
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x120
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x140
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x160
               	ldrsw	x4, [x4, x0, lsl #2]
               	cmp	w4, w2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x180
               	ldrsw	x1, [x1, x0, lsl #2]
               	cmp	w1, w15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x50
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_u32x16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	add	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	add	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	add	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	add	v3.4s, v3.4s, v4.4s
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	str	q2, [x0, #0x20]
               	str	q3, [x0, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	sub	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	sub	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	sub	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	sub	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	str	q2, [x0, #0x60]
               	str	q3, [x0, #0x70]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	mul	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	mul	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	mul	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	mul	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	str	q2, [x0, #0xa0]
               	str	q3, [x0, #0xb0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	and	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	and	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	and	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	str	q2, [x0, #0xe0]
               	str	q3, [x0, #0xf0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	orr	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	orr	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	orr	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	str	q2, [x0, #0x120]
               	str	q3, [x0, #0x130]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	eor	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	eor	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	eor	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	str	q2, [x0, #0x160]
               	str	q3, [x0, #0x170]
               	ldur	q0, [x29, #-0x80]
               	neg	v0.4s, v0.4s
               	ldur	q1, [x29, #-0x70]
               	neg	v1.4s, v1.4s
               	ldur	q2, [x29, #-0x60]
               	neg	v2.4s, v2.4s
               	ldur	q3, [x29, #-0x50]
               	neg	v3.4s, v3.4s
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	str	q2, [x0, #0x1a0]
               	str	q3, [x0, #0x1b0]
               	ldur	q0, [x29, #-0x80]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x70]
               	mvn	v1.16b, v1.16b
               	ldur	q2, [x29, #-0x60]
               	mvn	v2.16b, v2.16b
               	ldur	q3, [x29, #-0x50]
               	mvn	v3.16b, v3.16b
               	str	q0, [x0, #0x1c0]
               	str	q1, [x0, #0x1d0]
               	str	q2, [x0, #0x1e0]
               	str	q3, [x0, #0x1f0]
               	ldur	q0, [x29, #-0x80]
               	shl	v0.4s, v0.4s, #0x3
               	ldur	q1, [x29, #-0x70]
               	shl	v1.4s, v1.4s, #0x3
               	ldur	q2, [x29, #-0x60]
               	shl	v2.4s, v2.4s, #0x3
               	ldur	q3, [x29, #-0x50]
               	shl	v3.4s, v3.4s, #0x3
               	str	q0, [x0, #0x200]
               	str	q1, [x0, #0x210]
               	str	q2, [x0, #0x220]
               	str	q3, [x0, #0x230]
               	ldur	q0, [x29, #-0x80]
               	ushr	v0.4s, v0.4s, #0x5
               	ldur	q1, [x29, #-0x70]
               	ushr	v1.4s, v1.4s, #0x5
               	ldur	q2, [x29, #-0x60]
               	ushr	v2.4s, v2.4s, #0x5
               	ldur	q3, [x29, #-0x50]
               	ushr	v3.4s, v3.4s, #0x5
               	str	q0, [x0, #0x240]
               	str	q1, [x0, #0x250]
               	str	q2, [x0, #0x260]
               	str	q3, [x0, #0x270]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x80]
               	cmhi	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x70]
               	cmhi	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x20]
               	ldur	q3, [x29, #-0x60]
               	cmhi	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x10]
               	ldur	q4, [x29, #-0x50]
               	cmhi	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x280]
               	str	q1, [x0, #0x290]
               	str	q2, [x0, #0x2a0]
               	str	q3, [x0, #0x2b0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmhs	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmhs	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmhs	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmhs	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x2c0]
               	str	q1, [x0, #0x2d0]
               	str	q2, [x0, #0x2e0]
               	str	q3, [x0, #0x2f0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmeq	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmeq	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmeq	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmeq	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x300]
               	str	q1, [x0, #0x310]
               	str	q2, [x0, #0x320]
               	str	q3, [x0, #0x330]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u32x16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x3e0
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	str	w2, [x5, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.ge	<addr>
               	sub	x2, x29, #0x3c0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	lsr	x5, x5, #11
               	str	w5, [x2, x0, lsl #2]
               	sub	x5, x29, #0x380
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	lsr	x2, x2, #11
               	b	<addr>
               	ldr	w2, [x2, x0, lsl #2]
               	b	<addr>
               	sub	x0, x29, #0x340
               	sub	x20, x29, #0x3c0
               	sub	x21, x29, #0x380
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldr	w1, [x20, x0, lsl #2]
               	ldr	w2, [x21, x0, lsl #2]
               	add	x4, x1, x2
               	sub	x5, x1, x2
               	mul	x6, x1, x2
               	and	x7, x1, x2
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x10, x1
               	mvn	x11, x1
               	lsl	x12, x1, #3
               	lsr	x13, x1, #5
               	sub	x2, x29, #0x380
               	ldr	w2, [x2, x0, lsl #2]
               	cmp	w1, w2
               	cset	x1, lo
               	neg	x14, x1
               	sub	x1, x29, #0x3c0
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w2
               	cset	x1, hs
               	neg	x2, x1
               	sub	x1, x29, #0x3c0
               	ldr	w1, [x1, x0, lsl #2]
               	sub	x15, x29, #0x380
               	ldr	w15, [x15, x0, lsl #2]
               	cmp	w1, w15
               	cset	x1, eq
               	neg	x15, x1
               	sub	x1, x29, #0x340
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x40
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x80
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x340
               	add	x4, x1, #0xc0
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x100
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0x140
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0x180
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x1c0
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x200
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x240
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x280
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x2c0
               	ldr	w4, [x4, x0, lsl #2]
               	cmp	w4, w2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x300
               	ldr	w1, [x1, x0, lsl #2]
               	cmp	w1, w15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x60
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_u64x4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	add	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	add	v1.2d, v1.2d, v2.2d
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	sub	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	sub	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	ldur	x1, [x29, #-0x40]
               	ldur	x2, [x29, #-0x20]
               	mul	x1, x1, x2
               	ldur	x2, [x29, #-0x38]
               	ldur	x3, [x29, #-0x18]
               	mul	x2, x2, x3
               	ldur	x3, [x29, #-0x30]
               	ldur	x4, [x29, #-0x10]
               	mul	x3, x3, x4
               	ldur	x4, [x29, #-0x28]
               	ldur	x5, [x29, #-0x8]
               	mul	x4, x4, x5
               	str	x1, [x0, #0x40]
               	str	x2, [x0, #0x48]
               	str	x3, [x0, #0x50]
               	str	x4, [x0, #0x58]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	and	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x60]
               	str	q1, [x0, #0x70]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	orr	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	eor	v1.16b, v1.16b, v2.16b
               	str	q0, [x0, #0xa0]
               	str	q1, [x0, #0xb0]
               	ldur	q0, [x29, #-0x40]
               	neg	v0.2d, v0.2d
               	ldur	q1, [x29, #-0x30]
               	neg	v1.2d, v1.2d
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	ldur	q0, [x29, #-0x40]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x30]
               	mvn	v1.16b, v1.16b
               	str	q0, [x0, #0xe0]
               	str	q1, [x0, #0xf0]
               	ldur	q0, [x29, #-0x40]
               	shl	v0.2d, v0.2d, #0x3
               	ldur	q1, [x29, #-0x30]
               	shl	v1.2d, v1.2d, #0x3
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	ldur	q0, [x29, #-0x40]
               	ushr	v0.2d, v0.2d, #0x5
               	ldur	q1, [x29, #-0x30]
               	ushr	v1.2d, v1.2d, #0x5
               	str	q0, [x0, #0x120]
               	str	q1, [x0, #0x130]
               	ldur	q0, [x29, #-0x20]
               	ldur	q1, [x29, #-0x40]
               	cmhi	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x10]
               	ldur	q2, [x29, #-0x30]
               	cmhi	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmhs	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmhs	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x160]
               	str	q1, [x0, #0x170]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	cmeq	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	cmeq	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_u64x4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x200
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	str	x2, [x5, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.ge	<addr>
               	sub	x2, x29, #0x1e0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	lsr	x5, x5, #11
               	str	x5, [x2, x0, lsl #3]
               	sub	x5, x29, #0x1c0
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	lsr	x2, x2, #11
               	b	<addr>
               	ldr	x2, [x2, x0, lsl #3]
               	b	<addr>
               	sub	x0, x29, #0x1a0
               	sub	x20, x29, #0x1e0
               	sub	x21, x29, #0x1c0
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldr	x1, [x20, x0, lsl #3]
               	ldr	x2, [x21, x0, lsl #3]
               	add	x4, x1, x2
               	sub	x5, x1, x2
               	mul	x6, x1, x2
               	and	x7, x1, x2
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x10, x1
               	mvn	x11, x1
               	lsl	x12, x1, #3
               	lsr	x13, x1, #5
               	sub	x2, x29, #0x1c0
               	ldr	x2, [x2, x0, lsl #3]
               	cmp	x1, x2
               	cset	x1, lo
               	neg	x14, x1
               	sub	x1, x29, #0x1e0
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x2
               	cset	x1, hs
               	neg	x2, x1
               	sub	x1, x29, #0x1e0
               	ldr	x1, [x1, x0, lsl #3]
               	sub	x15, x29, #0x1c0
               	ldr	x15, [x15, x0, lsl #3]
               	cmp	x1, x15
               	cset	x1, eq
               	neg	x15, x1
               	sub	x1, x29, #0x1a0
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x20
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x40
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0x60
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x80
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0xa0
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0xc0
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x1a0
               	add	x4, x1, #0xe0
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x100
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x120
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x140
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x160
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x180
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x70
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_s64x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	add	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	add	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	add	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	add	v3.2d, v3.2d, v4.2d
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	str	q2, [x0, #0x20]
               	str	q3, [x0, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	sub	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	sub	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	sub	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	sub	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	str	q2, [x0, #0x60]
               	str	q3, [x0, #0x70]
               	ldur	x1, [x29, #-0x80]
               	ldur	x2, [x29, #-0x40]
               	mul	x1, x1, x2
               	ldur	x2, [x29, #-0x78]
               	ldur	x3, [x29, #-0x38]
               	mul	x2, x2, x3
               	ldur	x3, [x29, #-0x70]
               	ldur	x4, [x29, #-0x30]
               	mul	x3, x3, x4
               	ldur	x4, [x29, #-0x68]
               	ldur	x5, [x29, #-0x28]
               	mul	x4, x4, x5
               	ldur	x5, [x29, #-0x60]
               	ldur	x6, [x29, #-0x20]
               	mul	x5, x5, x6
               	ldur	x6, [x29, #-0x58]
               	ldur	x7, [x29, #-0x18]
               	mul	x6, x6, x7
               	ldur	x7, [x29, #-0x50]
               	ldur	x8, [x29, #-0x10]
               	mul	x7, x7, x8
               	ldur	x8, [x29, #-0x48]
               	ldur	x9, [x29, #-0x8]
               	mul	x8, x8, x9
               	str	x1, [x0, #0x80]
               	str	x2, [x0, #0x88]
               	str	x3, [x0, #0x90]
               	str	x4, [x0, #0x98]
               	str	x5, [x0, #0xa0]
               	str	x6, [x0, #0xa8]
               	str	x7, [x0, #0xb0]
               	str	x8, [x0, #0xb8]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	and	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	and	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	and	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	and	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	str	q2, [x0, #0xe0]
               	str	q3, [x0, #0xf0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	orr	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	orr	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	orr	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	orr	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x100]
               	str	q1, [x0, #0x110]
               	str	q2, [x0, #0x120]
               	str	q3, [x0, #0x130]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	eor	v0.16b, v0.16b, v1.16b
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	eor	v1.16b, v1.16b, v2.16b
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	eor	v2.16b, v2.16b, v3.16b
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	eor	v3.16b, v3.16b, v4.16b
               	str	q0, [x0, #0x140]
               	str	q1, [x0, #0x150]
               	str	q2, [x0, #0x160]
               	str	q3, [x0, #0x170]
               	ldur	q0, [x29, #-0x80]
               	neg	v0.2d, v0.2d
               	ldur	q1, [x29, #-0x70]
               	neg	v1.2d, v1.2d
               	ldur	q2, [x29, #-0x60]
               	neg	v2.2d, v2.2d
               	ldur	q3, [x29, #-0x50]
               	neg	v3.2d, v3.2d
               	str	q0, [x0, #0x180]
               	str	q1, [x0, #0x190]
               	str	q2, [x0, #0x1a0]
               	str	q3, [x0, #0x1b0]
               	ldur	q0, [x29, #-0x80]
               	mvn	v0.16b, v0.16b
               	ldur	q1, [x29, #-0x70]
               	mvn	v1.16b, v1.16b
               	ldur	q2, [x29, #-0x60]
               	mvn	v2.16b, v2.16b
               	ldur	q3, [x29, #-0x50]
               	mvn	v3.16b, v3.16b
               	str	q0, [x0, #0x1c0]
               	str	q1, [x0, #0x1d0]
               	str	q2, [x0, #0x1e0]
               	str	q3, [x0, #0x1f0]
               	ldur	q0, [x29, #-0x80]
               	shl	v0.2d, v0.2d, #0x3
               	ldur	q1, [x29, #-0x70]
               	shl	v1.2d, v1.2d, #0x3
               	ldur	q2, [x29, #-0x60]
               	shl	v2.2d, v2.2d, #0x3
               	ldur	q3, [x29, #-0x50]
               	shl	v3.2d, v3.2d, #0x3
               	str	q0, [x0, #0x200]
               	str	q1, [x0, #0x210]
               	str	q2, [x0, #0x220]
               	str	q3, [x0, #0x230]
               	ldur	q0, [x29, #-0x80]
               	sshr	v0.2d, v0.2d, #0x5
               	ldur	q1, [x29, #-0x70]
               	sshr	v1.2d, v1.2d, #0x5
               	ldur	q2, [x29, #-0x60]
               	sshr	v2.2d, v2.2d, #0x5
               	ldur	q3, [x29, #-0x50]
               	sshr	v3.2d, v3.2d, #0x5
               	str	q0, [x0, #0x240]
               	str	q1, [x0, #0x250]
               	str	q2, [x0, #0x260]
               	str	q3, [x0, #0x270]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x80]
               	cmgt	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x70]
               	cmgt	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x20]
               	ldur	q3, [x29, #-0x60]
               	cmgt	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x10]
               	ldur	q4, [x29, #-0x50]
               	cmgt	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0x280]
               	str	q1, [x0, #0x290]
               	str	q2, [x0, #0x2a0]
               	str	q3, [x0, #0x2b0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmge	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmge	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmge	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmge	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0x2c0]
               	str	q1, [x0, #0x2d0]
               	str	q2, [x0, #0x2e0]
               	str	q3, [x0, #0x2f0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	cmeq	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	cmeq	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	cmeq	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	cmeq	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0x300]
               	str	q1, [x0, #0x310]
               	str	q2, [x0, #0x320]
               	str	q3, [x0, #0x330]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_s64x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x3e0
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x3, #0x814f             // =33103
               	movk	x3, #0xf767, lsl #16
               	movk	x3, #0x7b7e, lsl #32
               	movk	x3, #0x1405, lsl #48
               	mov	x4, #0x7f2d             // =32557
               	movk	x4, #0x4c95, lsl #16
               	movk	x4, #0xf42d, lsl #32
               	movk	x4, #0x5851, lsl #48
               	adrp	x1, <page>
               	b	<addr>
               	str	x2, [x5, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.ge	<addr>
               	sub	x2, x29, #0x3c0
               	ldr	x5, [x1, #0x10]
               	mul	x5, x5, x4
               	add	x5, x5, x3
               	str	x5, [x1, #0x10]
               	lsr	x5, x5, #11
               	str	x5, [x2, x0, lsl #3]
               	sub	x5, x29, #0x380
               	mul	x7, x0, x6
               	lsr	x7, x7, #32
               	add	x7, x7, x7, lsl #1
               	sub	x7, x0, x7
               	cbz	x7, <addr>
               	ldr	x2, [x1, #0x10]
               	mul	x2, x2, x4
               	add	x2, x2, x3
               	str	x2, [x1, #0x10]
               	lsr	x2, x2, #11
               	b	<addr>
               	ldr	x2, [x2, x0, lsl #3]
               	b	<addr>
               	sub	x0, x29, #0x340
               	sub	x20, x29, #0x3c0
               	sub	x21, x29, #0x380
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldr	x1, [x20, x0, lsl #3]
               	ldr	x2, [x21, x0, lsl #3]
               	add	x4, x1, x2
               	sub	x5, x1, x2
               	mul	x6, x1, x2
               	and	x7, x1, x2
               	orr	x8, x1, x2
               	eor	x9, x1, x2
               	neg	x10, x1
               	mvn	x11, x1
               	lsl	x12, x1, #3
               	asr	x13, x1, #5
               	sub	x2, x29, #0x380
               	ldr	x2, [x2, x0, lsl #3]
               	cmp	x1, x2
               	cset	x1, lt
               	neg	x14, x1
               	sub	x1, x29, #0x3c0
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x2
               	cset	x1, ge
               	neg	x2, x1
               	sub	x1, x29, #0x3c0
               	ldr	x1, [x1, x0, lsl #3]
               	sub	x15, x29, #0x380
               	ldr	x15, [x15, x0, lsl #3]
               	cmp	x1, x15
               	cset	x1, eq
               	neg	x15, x1
               	sub	x1, x29, #0x340
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x4
               	b.ne	<addr>
               	mov	x22, #0x1               // =1
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x40
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x5
               	b.ne	<addr>
               	mov	x4, #0x2                // =2
               	add	x1, x1, #0x80
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x6
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	sub	x1, x29, #0x340
               	add	x4, x1, #0xc0
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x7
               	b.ne	<addr>
               	mov	x5, #0x4                // =4
               	add	x4, x1, #0x100
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x8
               	b.ne	<addr>
               	mov	x5, #0x5                // =5
               	add	x4, x1, #0x140
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x9
               	b.ne	<addr>
               	mov	x4, #0x6                // =6
               	add	x1, x1, #0x180
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x10
               	b.ne	<addr>
               	mov	x5, #0x7                // =7
               	sub	x1, x29, #0x340
               	add	x4, x1, #0x1c0
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x11
               	b.ne	<addr>
               	mov	x5, #0x8                // =8
               	add	x4, x1, #0x200
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x12
               	b.ne	<addr>
               	mov	x5, #0x9                // =9
               	add	x4, x1, #0x240
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x13
               	b.ne	<addr>
               	mov	x5, #0xa                // =10
               	add	x4, x1, #0x280
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x14
               	b.ne	<addr>
               	mov	x5, #0xb                // =11
               	add	x4, x1, #0x2c0
               	ldr	x4, [x4, x0, lsl #3]
               	cmp	x4, x2
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	add	x1, x1, #0x300
               	ldr	x1, [x1, x0, lsl #3]
               	cmp	x1, x15
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x2
               	add	x0, x3, #0x80
               	add	x0, x0, #0x1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x3e0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	mov	x3, x22
               	b	<addr>

<ops_f32x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fadd	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fadd	v1.4s, v1.4s, v2.4s
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fsub	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fsub	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fmul	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fmul	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fdiv	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fdiv	v1.4s, v1.4s, v2.4s
               	str	q0, [x0, #0x60]
               	str	q1, [x0, #0x70]
               	ldur	s0, [x29, #-0x40]
               	fneg	s0, s0
               	ldur	s1, [x29, #-0x3c]
               	fneg	s1, s1
               	ldur	s2, [x29, #-0x38]
               	fneg	s2, s2
               	ldur	s3, [x29, #-0x34]
               	fneg	s3, s3
               	ldur	s4, [x29, #-0x30]
               	fneg	s4, s4
               	ldur	s5, [x29, #-0x2c]
               	fneg	s5, s5
               	ldur	s6, [x29, #-0x28]
               	fneg	s6, s6
               	ldur	s7, [x29, #-0x24]
               	fneg	s7, s7
               	str	s0, [x0, #0x80]
               	str	s1, [x0, #0x84]
               	str	s2, [x0, #0x88]
               	str	s3, [x0, #0x8c]
               	str	s4, [x0, #0x90]
               	str	s5, [x0, #0x94]
               	str	s6, [x0, #0x98]
               	str	s7, [x0, #0x9c]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f32x8>:
               	stp	x20, x21, [sp, #-0x100]!
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x2, x1, #11
               	mov	x1, #0xf065             // =61541
               	movk	x1, #0x7159, lsl #16
               	movk	x1, #0xc06a, lsl #32
               	movk	x1, #0x20, lsl #48
               	umulh	x3, x2, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	sub	x2, x2, #0x3e8
               	scvtf	s1, x2
               	fmov	s0, #8.00000000
               	fdiv	s1, s1, s0
               	stur	s1, [x29, #-0xe0]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x3, x2, #11
               	mov	x2, #0xa7f0             // =42992
               	movk	x2, #0x4bc6, lsl #16
               	movk	x2, #0x8937, lsl #32
               	movk	x2, #0x41, lsl #48
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fmov	s1, #4.00000000
               	fdiv	s2, s2, s1
               	stur	s2, [x29, #-0xc0]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s0
               	stur	s2, [x29, #-0xdc]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s1
               	stur	s2, [x29, #-0xbc]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s0
               	stur	s2, [x29, #-0xd8]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s1, s2, s1
               	stur	s1, [x29, #-0xb8]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s1, x3
               	fdiv	s0, s1, s0
               	stur	s0, [x29, #-0xd4]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x3, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	add	x0, x0, #0x1
               	ucvtf	s1, x0
               	fmov	s0, #4.00000000
               	fdiv	s1, s1, s0
               	stur	s1, [x29, #-0xb4]
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fmov	s1, #8.00000000
               	fdiv	s2, s2, s1
               	stur	s2, [x29, #-0xd0]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s0
               	stur	s2, [x29, #-0xb0]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s1
               	stur	s2, [x29, #-0xcc]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s0
               	stur	s2, [x29, #-0xac]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s1
               	stur	s2, [x29, #-0xc8]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s0, s2, s0
               	stur	s0, [x29, #-0xa8]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x1, x0, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x3e8
               	scvtf	s0, x0
               	fdiv	s0, s0, s1
               	stur	s0, [x29, #-0xc4]
               	sub	x20, x29, #0xc0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x0, x1, #11
               	umulh	x1, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	add	x0, x0, #0x1
               	ucvtf	s0, x0
               	fmov	s1, #4.00000000
               	fdiv	s0, s0, s1
               	stur	s0, [x29, #-0xa4]
               	sub	x0, x29, #0xa0
               	sub	x21, x29, #0xe0
               	mov	x1, x21
               	mov	x2, x20
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x1, x3
               	lsl	x0, x1, #2
               	add	x2, x21, x0
               	ldr	s0, [x2]
               	add	x2, x20, x0
               	ldr	s1, [x2]
               	fadd	s2, s0, s1
               	fsub	s3, s0, s1
               	sub	x2, x29, #0xc0
               	add	x2, x2, x0
               	ldr	s1, [x2]
               	fmul	s4, s0, s1
               	sub	x2, x29, #0xe0
               	add	x2, x2, x0
               	ldr	s0, [x2]
               	fdiv	s1, s0, s1
               	fneg	s0, s0
               	sub	x2, x29, #0xa0
               	add	x4, x2, x0
               	ldr	s5, [x4]
               	fcmp	s5, s2
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	add	x4, x2, #0x20
               	add	x4, x4, x0
               	ldr	s2, [x4]
               	fcmp	s2, s3
               	b.ne	<addr>
               	mov	x5, #0x2                // =2
               	add	x4, x2, #0x40
               	add	x4, x4, x0
               	ldr	s2, [x4]
               	fcmp	s2, s4
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	add	x4, x2, #0x60
               	add	x0, x4, x0
               	ldr	s2, [x0]
               	fcmp	s2, s1
               	b.ne	<addr>
               	mov	x4, #0x4                // =4
               	add	x0, x2, #0x80
               	add	x0, x0, x1, lsl #2
               	ldr	s1, [x0]
               	fcmp	s1, s0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x3, x4
               	add	x0, x3, #0x90
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>

<ops_f32x16>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fadd	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fadd	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fadd	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fadd	v3.4s, v3.4s, v4.4s
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	str	q2, [x0, #0x20]
               	str	q3, [x0, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fsub	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fsub	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fsub	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fsub	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	str	q2, [x0, #0x60]
               	str	q3, [x0, #0x70]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fmul	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fmul	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fmul	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fmul	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	str	q2, [x0, #0xa0]
               	str	q3, [x0, #0xb0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fdiv	v0.4s, v0.4s, v1.4s
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fdiv	v1.4s, v1.4s, v2.4s
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fdiv	v2.4s, v2.4s, v3.4s
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fdiv	v3.4s, v3.4s, v4.4s
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	str	q2, [x0, #0xe0]
               	str	q3, [x0, #0xf0]
               	add	x0, x0, #0x100
               	sub	x1, x29, #0x40
               	ldur	s0, [x29, #-0x80]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x40]
               	ldur	s0, [x29, #-0x7c]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x3c]
               	ldur	s0, [x29, #-0x78]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x38]
               	ldur	s0, [x29, #-0x74]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x34]
               	ldur	s0, [x29, #-0x70]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x30]
               	ldur	s0, [x29, #-0x6c]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x2c]
               	ldur	s0, [x29, #-0x68]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x28]
               	ldur	s0, [x29, #-0x64]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x24]
               	ldur	s0, [x29, #-0x60]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x20]
               	ldur	s0, [x29, #-0x5c]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x1c]
               	ldur	s0, [x29, #-0x58]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x18]
               	ldur	s0, [x29, #-0x54]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x14]
               	ldur	s0, [x29, #-0x50]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x4c]
               	fneg	s0, s0
               	stur	s0, [x29, #-0xc]
               	ldur	s0, [x29, #-0x48]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x44]
               	fneg	s0, s0
               	stur	s0, [x29, #-0x4]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f32x16>:
               	stp	x20, x21, [sp, #-0x1e0]!
               	stp	x29, x30, [sp, #0x1d0]
               	add	x29, sp, #0x1d0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x2, x1, #11
               	mov	x1, #0xf065             // =61541
               	movk	x1, #0x7159, lsl #16
               	movk	x1, #0xc06a, lsl #32
               	movk	x1, #0x20, lsl #48
               	umulh	x3, x2, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	sub	x2, x2, #0x3e8
               	scvtf	s1, x2
               	fmov	s0, #8.00000000
               	fdiv	s1, s1, s0
               	str	s1, [sp, #0x10]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x3, x2, #11
               	mov	x2, #0xa7f0             // =42992
               	movk	x2, #0x4bc6, lsl #16
               	movk	x2, #0x8937, lsl #32
               	movk	x2, #0x41, lsl #48
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fmov	s1, #4.00000000
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x50]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x14]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x54]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x18]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s1, s2, s1
               	str	s1, [sp, #0x58]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s1, x3
               	fdiv	s0, s1, s0
               	str	s0, [sp, #0x1c]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x3, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	add	x0, x0, #0x1
               	ucvtf	s1, x0
               	fmov	s0, #4.00000000
               	fdiv	s1, s1, s0
               	str	s1, [sp, #0x5c]
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fmov	s1, #8.00000000
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x20]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x60]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x24]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x64]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x28]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s0, s2, s0
               	str	s0, [sp, #0x68]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x3, x0, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sub	x0, x0, #0x3e8
               	scvtf	s0, x0
               	fdiv	s0, s0, s1
               	str	s0, [sp, #0x2c]
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s1, x3
               	fmov	s0, #4.00000000
               	fdiv	s1, s1, s0
               	str	s1, [sp, #0x6c]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fmov	s1, #8.00000000
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x30]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x70]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x34]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x74]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s1, s2, s1
               	str	s1, [sp, #0x38]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s1, x3
               	fdiv	s0, s1, s0
               	str	s0, [sp, #0x78]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x3, x0, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	sub	x0, x0, #0x3e8
               	scvtf	s1, x0
               	fmov	s0, #8.00000000
               	fdiv	s1, s1, s0
               	str	s1, [sp, #0x3c]
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fmov	s1, #4.00000000
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x7c]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x40]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x80]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s2, s2, s0
               	str	s2, [sp, #0x44]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	s2, x3
               	fdiv	s2, s2, s1
               	str	s2, [sp, #0x84]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	s2, x3
               	fdiv	s0, s2, s0
               	str	s0, [sp, #0x48]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x3, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	add	x0, x0, #0x1
               	ucvtf	s0, x0
               	fdiv	s0, s0, s1
               	str	s0, [sp, #0x88]
               	sub	x20, x29, #0x1c0
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x1, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x1, x1, x17
               	sub	x1, x3, x1
               	sub	x1, x1, #0x3e8
               	scvtf	s0, x1
               	fmov	s1, #8.00000000
               	fdiv	s0, s0, s1
               	str	s0, [sp, #0x4c]
               	sub	x21, x29, #0x180
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x0, x1, #11
               	umulh	x1, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	add	x0, x0, #0x1
               	ucvtf	s0, x0
               	fmov	s1, #4.00000000
               	fdiv	s0, s0, s1
               	str	s0, [sp, #0x8c]
               	sub	x0, x29, #0x140
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x1, x3
               	lsl	x0, x1, #2
               	add	x2, x20, x0
               	ldr	s0, [x2]
               	add	x2, x21, x0
               	ldr	s1, [x2]
               	fadd	s2, s0, s1
               	fsub	s3, s0, s1
               	sub	x2, x29, #0x180
               	add	x2, x2, x0
               	ldr	s1, [x2]
               	fmul	s4, s0, s1
               	sub	x2, x29, #0x1c0
               	add	x2, x2, x0
               	ldr	s0, [x2]
               	fdiv	s1, s0, s1
               	fneg	s0, s0
               	sub	x2, x29, #0x140
               	add	x4, x2, x0
               	ldr	s5, [x4]
               	fcmp	s5, s2
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	add	x4, x2, #0x40
               	add	x4, x4, x0
               	ldr	s2, [x4]
               	fcmp	s2, s3
               	b.ne	<addr>
               	mov	x5, #0x2                // =2
               	add	x4, x2, #0x80
               	add	x4, x4, x0
               	ldr	s2, [x4]
               	fcmp	s2, s4
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	add	x4, x2, #0xc0
               	add	x0, x4, x0
               	ldr	s2, [x0]
               	fcmp	s2, s1
               	b.ne	<addr>
               	mov	x4, #0x4                // =4
               	add	x0, x2, #0x100
               	add	x0, x0, x1, lsl #2
               	ldr	s1, [x0]
               	fcmp	s1, s0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x10
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x1d0]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x3, x4
               	add	x0, x3, #0xa0
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0x1d0]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>

<ops_f64x4>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x3, x29, #0x40
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fadd	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fadd	v1.2d, v1.2d, v2.2d
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fsub	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fsub	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x20]
               	str	q1, [x0, #0x30]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fmul	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fmul	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	ldur	q0, [x29, #-0x40]
               	ldur	q1, [x29, #-0x20]
               	fdiv	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x30]
               	ldur	q2, [x29, #-0x10]
               	fdiv	v1.2d, v1.2d, v2.2d
               	str	q0, [x0, #0x60]
               	str	q1, [x0, #0x70]
               	ldur	d0, [x29, #-0x40]
               	fneg	d0, d0
               	ldur	d1, [x29, #-0x38]
               	fneg	d1, d1
               	ldur	d2, [x29, #-0x30]
               	fneg	d2, d2
               	ldur	d3, [x29, #-0x28]
               	fneg	d3, d3
               	str	d0, [x0, #0x80]
               	str	d1, [x0, #0x88]
               	str	d2, [x0, #0x90]
               	str	d3, [x0, #0x98]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f64x4>:
               	stp	x20, x21, [sp, #-0x100]!
               	stp	x29, x30, [sp, #0xf0]
               	add	x29, sp, #0xf0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x2, x1, #11
               	mov	x1, #0xf065             // =61541
               	movk	x1, #0x7159, lsl #16
               	movk	x1, #0xc06a, lsl #32
               	movk	x1, #0x20, lsl #48
               	umulh	x3, x2, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	sub	x2, x2, #0x3e8
               	scvtf	d1, x2
               	fmov	d0, #8.00000000
               	fdiv	d1, d1, d0
               	stur	d1, [x29, #-0xe0]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x3, x2, #11
               	mov	x2, #0xa7f0             // =42992
               	movk	x2, #0x4bc6, lsl #16
               	movk	x2, #0x8937, lsl #32
               	movk	x2, #0x41, lsl #48
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fmov	d1, #4.00000000
               	fdiv	d2, d2, d1
               	stur	d2, [x29, #-0xc0]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	stur	d2, [x29, #-0xd8]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d2, d2, d1
               	stur	d2, [x29, #-0xb8]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	stur	d2, [x29, #-0xd0]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d1, d2, d1
               	stur	d1, [x29, #-0xb0]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x1, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x1, x1, x17
               	sub	x1, x3, x1
               	sub	x1, x1, #0x3e8
               	scvtf	d1, x1
               	fdiv	d0, d1, d0
               	stur	d0, [x29, #-0xc8]
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x0, x1, #11
               	umulh	x1, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	add	x0, x0, #0x1
               	ucvtf	d0, x0
               	fmov	d1, #4.00000000
               	fdiv	d0, d0, d1
               	stur	d0, [x29, #-0xa8]
               	sub	x0, x29, #0xa0
               	sub	x20, x29, #0xe0
               	sub	x21, x29, #0xc0
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x1, x3
               	lsl	x0, x1, #3
               	add	x2, x20, x0
               	ldr	d0, [x2]
               	add	x2, x21, x0
               	ldr	d1, [x2]
               	fadd	d2, d0, d1
               	fsub	d3, d0, d1
               	sub	x2, x29, #0xc0
               	add	x2, x2, x0
               	ldr	d1, [x2]
               	fmul	d4, d0, d1
               	sub	x2, x29, #0xe0
               	add	x2, x2, x0
               	ldr	d0, [x2]
               	fdiv	d1, d0, d1
               	fneg	d0, d0
               	sub	x2, x29, #0xa0
               	add	x4, x2, x0
               	ldr	d5, [x4]
               	fcmp	d5, d2
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	add	x4, x2, #0x20
               	add	x4, x4, x0
               	ldr	d2, [x4]
               	fcmp	d2, d3
               	b.ne	<addr>
               	mov	x5, #0x2                // =2
               	add	x4, x2, #0x40
               	add	x4, x4, x0
               	ldr	d2, [x4]
               	fcmp	d2, d4
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	add	x4, x2, #0x60
               	add	x0, x4, x0
               	ldr	d2, [x0]
               	fcmp	d2, d1
               	b.ne	<addr>
               	mov	x4, #0x4                // =4
               	add	x0, x2, #0x80
               	add	x0, x0, x1, lsl #3
               	ldr	d1, [x0]
               	fcmp	d1, d0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x3, x4
               	add	x0, x3, #0xb0
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0xf0]
               	ldp	x20, x21, [sp], #0x100
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>

<ops_f64x8>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	ldp	x16, x17, [x2, #0x20]
               	stp	x16, x17, [x1, #0x20]
               	ldp	x16, x17, [x2, #0x30]
               	stp	x16, x17, [x1, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fadd	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fadd	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fadd	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fadd	v3.2d, v3.2d, v4.2d
               	str	q0, [x0]
               	str	q1, [x0, #0x10]
               	str	q2, [x0, #0x20]
               	str	q3, [x0, #0x30]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fsub	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fsub	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fsub	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fsub	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0x40]
               	str	q1, [x0, #0x50]
               	str	q2, [x0, #0x60]
               	str	q3, [x0, #0x70]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fmul	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fmul	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fmul	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fmul	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0x80]
               	str	q1, [x0, #0x90]
               	str	q2, [x0, #0xa0]
               	str	q3, [x0, #0xb0]
               	ldur	q0, [x29, #-0x80]
               	ldur	q1, [x29, #-0x40]
               	fdiv	v0.2d, v0.2d, v1.2d
               	ldur	q1, [x29, #-0x70]
               	ldur	q2, [x29, #-0x30]
               	fdiv	v1.2d, v1.2d, v2.2d
               	ldur	q2, [x29, #-0x60]
               	ldur	q3, [x29, #-0x20]
               	fdiv	v2.2d, v2.2d, v3.2d
               	ldur	q3, [x29, #-0x50]
               	ldur	q4, [x29, #-0x10]
               	fdiv	v3.2d, v3.2d, v4.2d
               	str	q0, [x0, #0xc0]
               	str	q1, [x0, #0xd0]
               	str	q2, [x0, #0xe0]
               	str	q3, [x0, #0xf0]
               	ldur	d0, [x29, #-0x80]
               	fneg	d0, d0
               	ldur	d1, [x29, #-0x78]
               	fneg	d1, d1
               	ldur	d2, [x29, #-0x70]
               	fneg	d2, d2
               	ldur	d3, [x29, #-0x68]
               	fneg	d3, d3
               	ldur	d4, [x29, #-0x60]
               	fneg	d4, d4
               	ldur	d5, [x29, #-0x58]
               	fneg	d5, d5
               	ldur	d6, [x29, #-0x50]
               	fneg	d6, d6
               	ldur	d7, [x29, #-0x48]
               	fneg	d7, d7
               	str	d0, [x0, #0x100]
               	str	d1, [x0, #0x108]
               	str	d2, [x0, #0x110]
               	str	d3, [x0, #0x118]
               	str	d4, [x0, #0x120]
               	str	d5, [x0, #0x128]
               	str	d6, [x0, #0x130]
               	str	d7, [x0, #0x138]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_f64x8>:
               	stp	x20, x21, [sp, #-0x1e0]!
               	stp	x29, x30, [sp, #0x1d0]
               	add	x29, sp, #0x1d0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x2, x1, #11
               	mov	x1, #0xf065             // =61541
               	movk	x1, #0x7159, lsl #16
               	movk	x1, #0xc06a, lsl #32
               	movk	x1, #0x20, lsl #48
               	umulh	x3, x2, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x3, x3, x17
               	sub	x2, x2, x3
               	sub	x2, x2, #0x3e8
               	scvtf	d1, x2
               	fmov	d0, #8.00000000
               	fdiv	d1, d1, d0
               	str	d1, [sp, #0x10]
               	ldr	x2, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x2, x2, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0, #0x10]
               	lsr	x3, x2, #11
               	mov	x2, #0xa7f0             // =42992
               	movk	x2, #0x4bc6, lsl #16
               	movk	x2, #0x8937, lsl #32
               	movk	x2, #0x41, lsl #48
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fmov	d1, #4.00000000
               	fdiv	d2, d2, d1
               	str	d2, [sp, #0x50]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	str	d2, [sp, #0x18]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d2, d2, d1
               	str	d2, [sp, #0x58]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	str	d2, [sp, #0x20]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d1, d2, d1
               	str	d1, [sp, #0x60]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d1, x3
               	fdiv	d0, d1, d0
               	str	d0, [sp, #0x28]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x3, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x3, x3, x17
               	sub	x0, x0, x3
               	add	x0, x0, #0x1
               	ucvtf	d1, x0
               	fmov	d0, #4.00000000
               	fdiv	d1, d1, d0
               	str	d1, [sp, #0x68]
               	adrp	x0, <page>
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fmov	d1, #8.00000000
               	fdiv	d2, d2, d1
               	str	d2, [sp, #0x30]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d2, d2, d0
               	str	d2, [sp, #0x70]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fdiv	d2, d2, d1
               	str	d2, [sp, #0x38]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d2, d2, d0
               	str	d2, [sp, #0x78]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	sub	x3, x3, #0x3e8
               	scvtf	d2, x3
               	fdiv	d2, d2, d1
               	str	d2, [sp, #0x40]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x3, x3, #11
               	umulh	x4, x3, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x4, x4, x17
               	sub	x3, x3, x4
               	add	x3, x3, #0x1
               	ucvtf	d2, x3
               	fdiv	d0, d2, d0
               	str	d0, [sp, #0x80]
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x3, x3, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x3, x3, x17
               	str	x3, [x0, #0x10]
               	lsr	x0, x3, #11
               	umulh	x1, x0, x1
               	mov	x17, #0x7d1             // =2001
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	sub	x0, x0, #0x3e8
               	scvtf	d0, x0
               	fdiv	d0, d0, d1
               	str	d0, [sp, #0x48]
               	sub	x20, x29, #0x180
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x1, x1, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0, #0x10]
               	lsr	x0, x1, #11
               	umulh	x1, x0, x2
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	add	x0, x0, #0x1
               	ucvtf	d0, x0
               	fmov	d1, #4.00000000
               	fdiv	d0, d0, d1
               	str	d0, [sp, #0x88]
               	sub	x0, x29, #0x140
               	sub	x21, x29, #0x1c0
               	mov	x1, x21
               	mov	x2, x20
               	bl	<addr>
               	mov	x3, #0x0                // =0
               	mov	x1, x3
               	lsl	x0, x1, #3
               	add	x2, x21, x0
               	ldr	d0, [x2]
               	add	x2, x20, x0
               	ldr	d1, [x2]
               	fadd	d2, d0, d1
               	fsub	d3, d0, d1
               	sub	x2, x29, #0x180
               	add	x2, x2, x0
               	ldr	d1, [x2]
               	fmul	d4, d0, d1
               	sub	x2, x29, #0x1c0
               	add	x2, x2, x0
               	ldr	d0, [x2]
               	fdiv	d1, d0, d1
               	fneg	d0, d0
               	sub	x2, x29, #0x140
               	add	x4, x2, x0
               	ldr	d5, [x4]
               	fcmp	d5, d2
               	b.ne	<addr>
               	mov	x5, #0x1                // =1
               	add	x4, x2, #0x40
               	add	x4, x4, x0
               	ldr	d2, [x4]
               	fcmp	d2, d3
               	b.ne	<addr>
               	mov	x5, #0x2                // =2
               	add	x4, x2, #0x80
               	add	x4, x4, x0
               	ldr	d2, [x4]
               	fcmp	d2, d4
               	b.ne	<addr>
               	mov	x5, #0x3                // =3
               	add	x4, x2, #0xc0
               	add	x0, x4, x0
               	ldr	d2, [x0]
               	fcmp	d2, d1
               	b.ne	<addr>
               	mov	x4, #0x4                // =4
               	add	x0, x2, #0x100
               	add	x0, x0, x1, lsl #3
               	ldr	d1, [x0]
               	fcmp	d1, d0
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x1d0]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x3, x4
               	add	x0, x3, #0xc0
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0x1d0]
               	ldp	x20, x21, [sp], #0x1e0
               	ret
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
               	mov	x3, x5
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
