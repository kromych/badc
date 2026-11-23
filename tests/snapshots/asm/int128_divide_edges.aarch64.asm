
int128_divide_edges.aarch64:	file format elf64-littleaarch64

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

<udiv>:
               	orr	x4, x1, x3
               	cbz	x4, <addr>
               	cbz	x3, <addr>
               	clz	x4, x3
               	eor	x14, x4, #0x3f
               	lsl	x4, x3, x4
               	lsr	x5, x2, #1
               	lsr	x5, x5, x14
               	orr	x5, x4, x5
               	lsr	x9, x1, #1
               	lsr	x4, x0, #1
               	orr	x6, x4, x1, lsl #63
               	clz	x4, x5
               	lsl	x10, x5, x4
               	lsr	x7, x10, #32
               	mov	w8, w10
               	eor	x5, x4, #0x3f
               	lsr	x11, x6, #1
               	lsr	x5, x11, x5
               	lsl	x9, x9, x4
               	orr	x11, x9, x5
               	lsl	x4, x6, x4
               	lsr	x9, x4, #32
               	mov	w12, w4
               	udiv	x4, x11, x7
               	msub	x5, x4, x7, x11
               	lsr	x6, x4, #32
               	cbnz	x6, <addr>
               	mul	x6, x4, x8
               	orr	x13, x9, x5, lsl #32
               	cmp	x6, x13
               	b.ls	<addr>
               	sub	x4, x4, #0x1
               	add	x5, x5, x7
               	lsr	x6, x5, #32
               	cbz	x6, <addr>
               	orr	x5, x9, x11, lsl #32
               	msub	x6, x4, x10, x5
               	udiv	x5, x6, x7
               	msub	x6, x5, x7, x6
               	lsr	x9, x5, #32
               	cbnz	x9, <addr>
               	mul	x9, x5, x8
               	orr	x10, x12, x6, lsl #32
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x5, x5, #0x1
               	add	x6, x6, x7
               	lsr	x9, x6, #32
               	cbz	x9, <addr>
               	orr	x4, x5, x4, lsl #32
               	lsr	x4, x4, x14
               	cmp	x4, #0x0
               	cset	x5, ne
               	sub	x4, x4, x5
               	umulh	x6, x4, x2
               	mul	x5, x4, x2
               	madd	x6, x4, x3, x6
               	cmp	x0, x5
               	cset	x7, lo
               	sub	x5, x0, x5
               	sub	x0, x1, x6
               	sub	x0, x0, x7
               	cmp	x0, x3
               	cset	x1, lo
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x5, x2
               	cset	x2, lo
               	and	x0, x0, x2
               	orr	x0, x1, x0
               	eor	x0, x0, #0x1
               	add	x0, x4, x0
               	mov	x4, #0x0                // =0
               	mov	x1, x4
               	ret
               	mov	x4, #0x0                // =0
               	cmp	x1, x2
               	b.lo	<addr>
               	udiv	x4, x1, x2
               	msub	x1, x4, x2, x1
               	clz	x3, x2
               	lsl	x7, x2, x3
               	lsr	x5, x7, #32
               	mov	w6, w7
               	eor	x2, x3, #0x3f
               	lsr	x8, x0, #1
               	lsr	x2, x8, x2
               	lsl	x1, x1, x3
               	orr	x8, x1, x2
               	lsl	x0, x0, x3
               	lsr	x3, x0, #32
               	mov	w9, w0
               	udiv	x0, x8, x5
               	msub	x2, x0, x5, x8
               	lsr	x1, x0, #32
               	cbnz	x1, <addr>
               	mul	x1, x0, x6
               	orr	x10, x3, x2, lsl #32
               	cmp	x1, x10
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x2, x2, x5
               	lsr	x1, x2, #32
               	cbz	x1, <addr>
               	orr	x1, x3, x8, lsl #32
               	msub	x1, x0, x7, x1
               	udiv	x2, x1, x5
               	msub	x3, x2, x5, x1
               	lsr	x1, x2, #32
               	cbnz	x1, <addr>
               	mul	x1, x2, x6
               	orr	x7, x9, x3, lsl #32
               	cmp	x1, x7
               	b.ls	<addr>
               	sub	x2, x2, #0x1
               	add	x3, x3, x5
               	lsr	x1, x3, #32
               	cbz	x1, <addr>
               	orr	x0, x2, x0, lsl #32
               	b	<addr>
               	udiv	x0, x0, x2
               	mov	x1, #0x0                // =0
               	mov	x4, x1
               	b	<addr>

<umod>:
               	orr	x4, x1, x3
               	cbz	x4, <addr>
               	cbz	x3, <addr>
               	clz	x4, x3
               	eor	x14, x4, #0x3f
               	lsl	x4, x3, x4
               	lsr	x5, x2, #1
               	lsr	x5, x5, x14
               	orr	x5, x4, x5
               	lsr	x9, x1, #1
               	lsr	x4, x0, #1
               	orr	x6, x4, x1, lsl #63
               	clz	x4, x5
               	lsl	x10, x5, x4
               	lsr	x7, x10, #32
               	mov	w8, w10
               	eor	x5, x4, #0x3f
               	lsr	x11, x6, #1
               	lsr	x5, x11, x5
               	lsl	x9, x9, x4
               	orr	x11, x9, x5
               	lsl	x4, x6, x4
               	lsr	x9, x4, #32
               	mov	w12, w4
               	udiv	x4, x11, x7
               	msub	x5, x4, x7, x11
               	lsr	x6, x4, #32
               	cbnz	x6, <addr>
               	mul	x6, x4, x8
               	orr	x13, x9, x5, lsl #32
               	cmp	x6, x13
               	b.ls	<addr>
               	sub	x4, x4, #0x1
               	add	x5, x5, x7
               	lsr	x6, x5, #32
               	cbz	x6, <addr>
               	orr	x5, x9, x11, lsl #32
               	msub	x6, x4, x10, x5
               	udiv	x5, x6, x7
               	msub	x6, x5, x7, x6
               	lsr	x9, x5, #32
               	cbnz	x9, <addr>
               	mul	x9, x5, x8
               	orr	x10, x12, x6, lsl #32
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x5, x5, #0x1
               	add	x6, x6, x7
               	lsr	x9, x6, #32
               	cbz	x9, <addr>
               	orr	x4, x5, x4, lsl #32
               	lsr	x4, x4, x14
               	cmp	x4, #0x0
               	cset	x5, ne
               	sub	x4, x4, x5
               	umulh	x6, x4, x2
               	mul	x5, x4, x2
               	madd	x4, x4, x3, x6
               	cmp	x0, x5
               	cset	x6, lo
               	sub	x0, x0, x5
               	sub	x1, x1, x4
               	sub	x4, x1, x6
               	cmp	x4, x3
               	cset	x1, lo
               	cmp	x4, x3
               	cset	x5, eq
               	cmp	x0, x2
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x1, x1, x5
               	eor	x6, x1, #0x1
               	neg	x1, x6
               	and	x2, x2, x1
               	and	x1, x3, x1
               	cmp	x0, x2
               	cset	x3, lo
               	sub	x0, x0, x2
               	sub	x1, x4, x1
               	sub	x1, x1, x3
               	ret
               	cmp	x1, x2
               	b.lo	<addr>
               	udiv	x17, x1, x2
               	msub	x1, x17, x2, x1
               	clz	x3, x2
               	lsl	x8, x2, x3
               	lsr	x5, x8, #32
               	mov	w6, w8
               	eor	x4, x3, #0x3f
               	lsr	x7, x0, #1
               	lsr	x4, x7, x4
               	lsl	x1, x1, x3
               	orr	x9, x1, x4
               	lsl	x1, x0, x3
               	lsr	x7, x1, #32
               	mov	w10, w1
               	udiv	x1, x9, x5
               	msub	x3, x1, x5, x9
               	lsr	x4, x1, #32
               	cbnz	x4, <addr>
               	mul	x4, x1, x6
               	orr	x11, x7, x3, lsl #32
               	cmp	x4, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x3, x3, x5
               	lsr	x4, x3, #32
               	cbz	x4, <addr>
               	orr	x3, x7, x9, lsl #32
               	msub	x4, x1, x8, x3
               	udiv	x3, x4, x5
               	msub	x4, x3, x5, x4
               	lsr	x7, x3, #32
               	cbnz	x7, <addr>
               	mul	x7, x3, x6
               	orr	x8, x10, x4, lsl #32
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x3, x3, #0x1
               	add	x4, x4, x5
               	lsr	x7, x4, #32
               	cbz	x7, <addr>
               	orr	x5, x3, x1, lsl #32
               	msub	x0, x5, x2, x0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	mov	x1, #0x0                // =0
               	b	<addr>

<sdiv>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	asr	x4, x1, #63
               	asr	x5, x3, #63
               	eor	x0, x0, x4
               	eor	x1, x1, x4
               	cmp	x0, x4
               	cset	x6, lo
               	sub	x9, x0, x4
               	sub	x0, x1, x4
               	sub	x6, x0, x6
               	eor	x0, x2, x5
               	eor	x1, x3, x5
               	cmp	x0, x5
               	cset	x2, lo
               	sub	x7, x0, x5
               	sub	x0, x1, x5
               	sub	x8, x0, x2
               	orr	x0, x6, x8
               	cbz	x0, <addr>
               	cbz	x8, <addr>
               	clz	x0, x8
               	eor	x20, x0, #0x3f
               	lsl	x0, x8, x0
               	lsr	x1, x7, #1
               	lsr	x1, x1, x20
               	orr	x1, x0, x1
               	lsr	x11, x6, #1
               	lsr	x0, x9, #1
               	orr	x2, x0, x6, lsl #63
               	clz	x0, x1
               	lsl	x12, x1, x0
               	lsr	x3, x12, #32
               	mov	w10, w12
               	eor	x1, x0, #0x3f
               	lsr	x13, x2, #1
               	lsr	x1, x13, x1
               	lsl	x11, x11, x0
               	orr	x13, x11, x1
               	lsl	x0, x2, x0
               	lsr	x11, x0, #32
               	mov	w14, w0
               	udiv	x0, x13, x3
               	msub	x1, x0, x3, x13
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x10
               	orr	x15, x11, x1, lsl #32
               	cmp	x2, x15
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x11, x13, lsl #32
               	msub	x2, x0, x12, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x11, x1, #32
               	cbnz	x11, <addr>
               	mul	x11, x1, x10
               	orr	x12, x14, x2, lsl #32
               	cmp	x11, x12
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x11, x2, #32
               	cbz	x11, <addr>
               	orr	x0, x1, x0, lsl #32
               	lsr	x0, x0, x20
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x7
               	mul	x1, x0, x7
               	madd	x2, x0, x8, x2
               	cmp	x9, x1
               	cset	x3, lo
               	sub	x9, x9, x1
               	sub	x1, x6, x2
               	sub	x1, x1, x3
               	cmp	x1, x8
               	cset	x2, lo
               	cmp	x1, x8
               	cset	x1, eq
               	cmp	x9, x7
               	cset	x3, lo
               	and	x1, x1, x3
               	orr	x1, x2, x1
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	mov	x3, #0x0                // =0
               	eor	x1, x4, x5
               	eor	x0, x0, x1
               	eor	x2, x3, x1
               	cmp	x0, x1
               	cset	x3, lo
               	sub	x0, x0, x1
               	sub	x1, x2, x1
               	sub	x1, x1, x3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x3, #0x0                // =0
               	cmp	x6, x7
               	b.lo	<addr>
               	udiv	x3, x6, x7
               	msub	x6, x3, x7, x6
               	clz	x0, x7
               	lsl	x10, x7, x0
               	lsr	x7, x10, #32
               	mov	w8, w10
               	eor	x1, x0, #0x3f
               	lsr	x2, x9, #1
               	lsr	x1, x2, x1
               	lsl	x2, x6, x0
               	orr	x11, x2, x1
               	lsl	x0, x9, x0
               	lsr	x6, x0, #32
               	mov	w9, w0
               	udiv	x0, x11, x7
               	msub	x1, x0, x7, x11
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x8
               	orr	x12, x6, x1, lsl #32
               	cmp	x2, x12
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x6, x11, lsl #32
               	msub	x2, x0, x10, x1
               	udiv	x1, x2, x7
               	msub	x2, x1, x7, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x8
               	orr	x10, x9, x2, lsl #32
               	cmp	x6, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x7
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x0, x1, x0, lsl #32
               	b	<addr>
               	udiv	x0, x9, x7
               	mov	x1, #0x0                // =0
               	mov	x3, x1
               	b	<addr>

<smod>:
               	asr	x4, x1, #63
               	asr	x5, x3, #63
               	eor	x0, x0, x4
               	eor	x1, x1, x4
               	cmp	x0, x4
               	cset	x6, lo
               	sub	x8, x0, x4
               	sub	x0, x1, x4
               	sub	x6, x0, x6
               	eor	x0, x2, x5
               	eor	x1, x3, x5
               	cmp	x0, x5
               	cset	x2, lo
               	sub	x3, x0, x5
               	sub	x0, x1, x5
               	sub	x5, x0, x2
               	orr	x0, x6, x5
               	cbz	x0, <addr>
               	cbz	x5, <addr>
               	clz	x0, x5
               	eor	x15, x0, #0x3f
               	lsl	x0, x5, x0
               	lsr	x1, x3, #1
               	lsr	x1, x1, x15
               	orr	x1, x0, x1
               	lsr	x10, x6, #1
               	lsr	x0, x8, #1
               	orr	x2, x0, x6, lsl #63
               	clz	x0, x1
               	lsl	x11, x1, x0
               	lsr	x7, x11, #32
               	mov	w9, w11
               	eor	x1, x0, #0x3f
               	lsr	x12, x2, #1
               	lsr	x1, x12, x1
               	lsl	x10, x10, x0
               	orr	x12, x10, x1
               	lsl	x0, x2, x0
               	lsr	x10, x0, #32
               	mov	w13, w0
               	udiv	x0, x12, x7
               	msub	x1, x0, x7, x12
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x9
               	orr	x14, x10, x1, lsl #32
               	cmp	x2, x14
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x10, x12, lsl #32
               	msub	x2, x0, x11, x1
               	udiv	x1, x2, x7
               	msub	x2, x1, x7, x2
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x9
               	orr	x11, x13, x2, lsl #32
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x7
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	orr	x0, x1, x0, lsl #32
               	lsr	x0, x0, x15
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x3
               	mul	x1, x0, x3
               	madd	x2, x0, x5, x2
               	cmp	x8, x1
               	cset	x7, lo
               	sub	x0, x8, x1
               	sub	x1, x6, x2
               	sub	x2, x1, x7
               	cmp	x2, x5
               	cset	x1, lo
               	cmp	x2, x5
               	cset	x6, eq
               	cmp	x0, x3
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x1, x1, x6
               	eor	x1, x1, #0x1
               	neg	x1, x1
               	and	x3, x3, x1
               	and	x5, x5, x1
               	cmp	x0, x3
               	cset	x6, lo
               	sub	x1, x0, x3
               	sub	x0, x2, x5
               	sub	x0, x0, x6
               	eor	x1, x1, x4
               	eor	x2, x0, x4
               	cmp	x1, x4
               	cset	x3, lo
               	sub	x0, x1, x4
               	sub	x1, x2, x4
               	sub	x1, x1, x3
               	ret
               	cmp	x6, x3
               	b.lo	<addr>
               	udiv	x17, x6, x3
               	msub	x6, x17, x3, x6
               	clz	x0, x3
               	lsl	x9, x3, x0
               	lsr	x5, x9, #32
               	mov	w7, w9
               	eor	x1, x0, #0x3f
               	lsr	x2, x8, #1
               	lsr	x1, x2, x1
               	lsl	x2, x6, x0
               	orr	x10, x2, x1
               	lsl	x0, x8, x0
               	lsr	x6, x0, #32
               	mov	w11, w0
               	udiv	x0, x10, x5
               	msub	x1, x0, x5, x10
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x7
               	orr	x12, x6, x1, lsl #32
               	cmp	x2, x12
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x5
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x6, x10, lsl #32
               	msub	x2, x0, x9, x1
               	udiv	x1, x2, x5
               	msub	x2, x1, x5, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x7
               	orr	x9, x11, x2, lsl #32
               	cmp	x6, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x5
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x6, x1, x0, lsl #32
               	msub	x1, x6, x3, x8
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x17, x8, x3
               	msub	x1, x17, x3, x8
               	mov	x0, #0x0                // =0
               	b	<addr>

<reference>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x22, x4
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	stur	x2, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	mov	x5, #0x0                // =0
               	mov	x3, #0x7f               // =127
               	ldur	x4, [x29, #-0x20]
               	ldur	x9, [x29, #-0x18]
               	ldur	x10, [x29, #-0x10]
               	ldur	x11, [x29, #-0x8]
               	mov	x0, x5
               	mov	x1, x5
               	mov	x7, x5
               	mov	x2, x5
               	b	<addr>
               	sub	x3, x3, #0x1
               	cmp	w3, #0x0
               	b.lt	<addr>
               	lsr	x13, x2, #63
               	lsl	x2, x2, #1
               	orr	x2, x2, x0, lsr #63
               	and	x6, x3, #0x3f
               	mov	x8, #0x3f               // =63
               	sub	x12, x8, x6
               	lsr	x8, x3, #6
               	neg	x8, x8
               	mvn	x14, x8
               	lsr	x15, x9, x6
               	lsl	x20, x9, x12
               	lsr	x21, x4, x6
               	orr	x20, x21, x20, lsl #1
               	and	x14, x20, x14
               	and	x15, x15, x8
               	orr	x14, x14, x15
               	and	x14, x14, #0x1
               	orr	x0, x14, x0, lsl #1
               	cbnz	x13, <addr>
               	cmp	x2, x11
               	cset	x13, lo
               	cmp	x2, x11
               	cset	x14, eq
               	cmp	x0, x10
               	cset	x15, lo
               	and	x14, x14, x15
               	orr	x13, x13, x14
               	eor	x13, x13, #0x1
               	cbz	x13, <addr>
               	cmp	x0, x10
               	cset	x13, lo
               	sub	x0, x0, x10
               	sub	x2, x2, x11
               	sub	x2, x2, x13
               	mov	x13, #0x1               // =1
               	mvn	x14, x8
               	lsl	x15, x13, x6
               	lsr	x12, x13, x12
               	lsl	x6, x5, x6
               	orr	x6, x6, x12, lsr #1
               	and	x12, x15, x14
               	and	x6, x6, x14
               	and	x8, x15, x8
               	orr	x6, x6, x8
               	orr	x7, x7, x12
               	orr	x1, x1, x6
               	b	<addr>
               	str	x0, [x22]
               	str	x2, [x22, #0x8]
               	mov	x0, x7
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<signed_ok>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x0, [x29, #-0x90]
               	sub	x0, x29, #0x90
               	stur	x1, [x29, #-0x88]
               	stur	x2, [x29, #-0x80]
               	sub	x2, x29, #0x80
               	stur	x3, [x29, #-0x78]
               	ldur	x3, [x29, #-0x90]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	cmp	x3, #0x0
               	cset	x0, hi
               	neg	x3, x3
               	neg	x1, x1
               	sub	x1, x1, x0
               	sub	x0, x29, #0x40
               	stur	x3, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	ldur	x3, [x29, #-0x80]
               	ldur	x1, [x29, #-0x78]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	cmp	x3, #0x0
               	cset	x2, hi
               	neg	x3, x3
               	neg	x1, x1
               	sub	x1, x1, x2
               	sub	x2, x29, #0x30
               	stur	x3, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	sub	x4, x29, #0x70
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	sub	x0, x29, #0x90
               	ldur	x1, [x29, #-0x90]
               	ldur	x2, [x29, #-0x88]
               	eor	x2, x2, #0x8000000000000000
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	ldur	x1, [x29, #-0x80]
               	ldur	x2, [x29, #-0x78]
               	mvn	x1, x1
               	mvn	x2, x2
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x80
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	stur	x1, [x29, #-0x48]
               	sub	x5, x29, #0x90
               	ldur	x2, [x29, #-0x88]
               	cmp	x2, #0x0
               	cset	x3, lt
               	sub	x2, x29, #0x80
               	ldur	x4, [x29, #-0x78]
               	cmp	x4, #0x0
               	cset	x4, lt
               	cmp	w3, w4
               	b.eq	<addr>
               	ldur	x3, [x29, #-0x60]
               	ldur	x4, [x29, #-0x58]
               	cmp	x3, #0x0
               	cset	x6, hi
               	neg	x7, x3
               	neg	x3, x4
               	sub	x4, x3, x6
               	sub	x3, x29, #0x20
               	stur	x7, [x29, #-0x20]
               	stur	x4, [x29, #-0x18]
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	eor	x4, x0, x4
               	eor	x1, x1, x3
               	orr	x3, x4, x1
               	mov	x1, #0x0                // =0
               	cbnz	x3, <addr>
               	mov	x0, x5
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	stur	x1, [x29, #-0x48]
               	ldur	x2, [x29, #-0x88]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	ldur	x2, [x29, #-0x70]
               	ldur	x3, [x29, #-0x68]
               	cmp	x2, #0x0
               	cset	x4, hi
               	neg	x5, x2
               	neg	x2, x3
               	sub	x3, x2, x4
               	sub	x2, x29, #0x10
               	stur	x5, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	eor	x0, x0, x3
               	eor	x1, x1, x2
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, x1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x70
               	b	<addr>
               	sub	x3, x29, #0x60
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x270
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0x9999999999999999
               	mov	x17, #0x9999            // =39321
               	movk	x17, #0x9999, lsl #16
               	movk	x17, #0x9999, lsl #32
               	movk	x17, #0x1999, lsl #48
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mvn	x0, x0
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x2, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0xfffffffffffffffe
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x5                // =5
               	mov	x2, #0x7                // =7
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0x7
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x2, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x123              // =291
               	mov	x2, #0x456              // =1110
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mov	x17, #0x456             // =1110
               	eor	x0, x0, x17
               	mov	x17, #0x123             // =291
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x123              // =291
               	mov	x2, #0x456              // =1110
               	sub	x0, x29, #0x20
               	stur	x2, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x21, x23
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0, x21, lsl #3]
               	sub	x22, x20, #0x1
               	mov	x0, #-0x1               // =-1
               	sub	x24, x29, #0x1c0
               	str	x0, [sp, #0xb0]
               	str	x22, [sp, #0xb8]
               	sub	x2, x29, #0x1b0
               	str	x20, [sp, #0xc0]
               	str	x23, [sp, #0xc8]
               	sub	x4, x29, #0x1f0
               	str	x2, [sp, #0x228]
               	mov	x0, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	mov	x3, x0
               	mov	x4, x1
               	str	x3, [sp, #0xd0]
               	str	x4, [sp, #0xd8]
               	str	x3, [sp, #0x228]
               	str	x4, [sp, #0x220]
               	mov	x0, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x3, [sp, #0x228]
               	ldr	x4, [sp, #0x220]
               	str	x0, [sp, #0xe0]
               	str	x1, [sp, #0xe8]
               	eor	x0, x0, x3
               	eor	x1, x1, x4
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1c0
               	sub	x2, x29, #0x1b0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0xf0]
               	str	x1, [sp, #0xf8]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x24, x29, #0x170
               	str	xzr, [sp, #0x100]
               	str	x22, [sp, #0x108]
               	sub	x22, x29, #0x160
               	str	x20, [sp, #0x110]
               	str	xzr, [sp, #0x118]
               	sub	x4, x29, #0x1f0
               	mov	x0, x24
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x2, x0
               	mov	x3, x1
               	str	x2, [sp, #0x120]
               	str	x3, [sp, #0x128]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x24
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	str	x0, [sp, #0x130]
               	str	x1, [sp, #0x138]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x170
               	sub	x2, x29, #0x160
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x140]
               	str	x1, [sp, #0x148]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	lsr	x0, x20, #1
               	mov	x2, #0x3039             // =12345
               	sub	x22, x29, #0x120
               	str	x2, [sp, #0x150]
               	str	x0, [sp, #0x158]
               	sub	x24, x29, #0x110
               	str	x20, [sp, #0x160]
               	str	xzr, [sp, #0x168]
               	sub	x4, x29, #0x1f0
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x2, x0
               	mov	x3, x1
               	stur	x2, [x29, #-0x100]
               	stur	x3, [x29, #-0xf8]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	str	x0, [sp, #0x50]
               	str	x1, [sp, #0x58]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x120
               	sub	x2, x29, #0x110
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x60]
               	str	x1, [sp, #0x68]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x1                // =1
               	sub	x22, x29, #0xf0
               	stur	x1, [x29, #-0xf0]
               	stur	x20, [x29, #-0xe8]
               	sub	x24, x29, #0xe0
               	stur	x20, [x29, #-0xe0]
               	stur	xzr, [x29, #-0xd8]
               	sub	x4, x29, #0x1f0
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x2, x0
               	mov	x3, x1
               	stur	x2, [x29, #-0xd0]
               	stur	x3, [x29, #-0xc8]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xf0
               	sub	x2, x29, #0xe0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	sub	x22, x29, #0xa0
               	stur	x0, [x29, #-0xa0]
               	stur	x0, [x29, #-0x98]
               	sub	x24, x29, #0x90
               	stur	x20, [x29, #-0x90]
               	stur	xzr, [x29, #-0x88]
               	sub	x4, x29, #0x1f0
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x2, x0
               	mov	x3, x1
               	stur	x2, [x29, #-0x80]
               	stur	x3, [x29, #-0x78]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa0
               	sub	x2, x29, #0x90
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x3039             // =12345
               	sub	x22, x29, #0x240
               	str	x1, [sp, #0x30]
               	str	xzr, [sp, #0x38]
               	sub	x24, x29, #0x230
               	str	x20, [sp, #0x40]
               	str	xzr, [sp, #0x48]
               	sub	x4, x29, #0x1f0
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x0
               	mov	x2, x1
               	str	x20, [sp, #0x90]
               	str	x2, [sp, #0x98]
               	str	x2, [sp, #0x228]
               	mov	x0, x22
               	mov	x2, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	str	x0, [sp, #0xa0]
               	str	x1, [sp, #0xa8]
               	eor	x0, x0, x20
               	eor	x1, x1, x2
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x2, x29, #0x230
               	mov	x0, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x13
               	b.lt	<addr>
               	mov	x23, #0x0               // =0
               	mov	x0, #0x1                // =1
               	mov	x3, #0x0                // =0
               	add	x1, x23, #0x40
               	and	x2, x1, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x8, x4, x2
               	lsr	x5, x1, #6
               	neg	x5, x5
               	mvn	x6, x5
               	lsl	x7, x0, x2
               	lsr	x8, x0, x8
               	lsl	x2, x3, x2
               	orr	x2, x2, x8, lsr #1
               	and	x8, x7, x6
               	and	x2, x2, x6
               	and	x5, x7, x5
               	orr	x21, x2, x5
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	movk	x17, #0xdef0, lsl #32
               	movk	x17, #0x9abc, lsl #48
               	orr	x22, x8, x17
               	and	x2, x1, #0x3f
               	sub	x6, x4, x2
               	lsr	x1, x1, #6
               	neg	x1, x1
               	mvn	x4, x1
               	lsl	x5, x0, x2
               	lsr	x0, x0, x6
               	lsl	x2, x3, x2
               	orr	x2, x2, x0, lsr #1
               	and	x0, x5, x4
               	and	x2, x2, x4
               	and	x1, x5, x1
               	orr	x1, x2, x1
               	cmp	x0, #0x1
               	cset	x2, lo
               	sub	x0, x0, #0x1
               	sub	x1, x1, x2
               	orr	x20, x8, x0
               	orr	x24, x21, x1
               	cmp	x22, #0x1
               	cset	x0, lo
               	sub	x1, x22, #0x1
               	sub	x2, x21, x0
               	sub	x0, x29, #0x1c0
               	str	x1, [sp, #0xb0]
               	str	x2, [sp, #0xb8]
               	sub	x2, x29, #0x1b0
               	str	x22, [sp, #0xc0]
               	str	x21, [sp, #0xc8]
               	sub	x4, x29, #0x1f0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x3, x0
               	mov	x4, x1
               	str	x3, [sp, #0xd0]
               	str	x4, [sp, #0xd8]
               	sub	x0, x29, #0x1c0
               	sub	x2, x29, #0x1b0
               	str	x3, [sp, #0x228]
               	str	x4, [sp, #0x220]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x3, [sp, #0x228]
               	ldr	x4, [sp, #0x220]
               	str	x0, [sp, #0xe0]
               	str	x1, [sp, #0xe8]
               	eor	x0, x0, x3
               	eor	x1, x1, x4
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1c0
               	sub	x2, x29, #0x1b0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0xf0]
               	str	x1, [sp, #0xf8]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x170
               	str	x22, [sp, #0x100]
               	str	x21, [sp, #0x108]
               	sub	x2, x29, #0x160
               	str	x22, [sp, #0x110]
               	str	x21, [sp, #0x118]
               	sub	x4, x29, #0x1f0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x3, x0
               	mov	x4, x1
               	str	x3, [sp, #0x120]
               	str	x4, [sp, #0x128]
               	sub	x0, x29, #0x170
               	sub	x2, x29, #0x160
               	str	x3, [sp, #0x228]
               	str	x4, [sp, #0x220]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x3, [sp, #0x228]
               	ldr	x4, [sp, #0x220]
               	str	x0, [sp, #0x130]
               	str	x1, [sp, #0x138]
               	eor	x0, x0, x3
               	eor	x1, x1, x4
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x170
               	sub	x2, x29, #0x160
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x140]
               	str	x1, [sp, #0x148]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	sub	x2, x29, #0x120
               	str	x0, [sp, #0x150]
               	str	x0, [sp, #0x158]
               	sub	x3, x29, #0x110
               	str	x22, [sp, #0x160]
               	str	x21, [sp, #0x168]
               	sub	x4, x29, #0x1f0
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x2
               	mov	x2, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	mov	x21, x0
               	mov	x22, x1
               	stur	x21, [x29, #-0x100]
               	stur	x22, [x29, #-0xf8]
               	mov	x0, x2
               	mov	x2, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x50]
               	str	x1, [sp, #0x58]
               	eor	x0, x0, x21
               	eor	x1, x1, x22
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x120
               	sub	x2, x29, #0x110
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x60]
               	str	x1, [sp, #0x68]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	sub	x21, x29, #0xf0
               	stur	x0, [x29, #-0xf0]
               	stur	x0, [x29, #-0xe8]
               	sub	x22, x29, #0xe0
               	stur	x20, [x29, #-0xe0]
               	stur	x24, [x29, #-0xd8]
               	sub	x4, x29, #0x1f0
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x2, x0
               	mov	x3, x1
               	stur	x2, [x29, #-0xd0]
               	stur	x3, [x29, #-0xc8]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xf0
               	sub	x2, x29, #0xe0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	cmp	x0, x20
               	cset	x1, lo
               	sub	x2, x0, x20
               	sub	x0, x0, x24
               	sub	x0, x0, x1
               	sub	x21, x29, #0xa0
               	stur	x2, [x29, #-0xa0]
               	stur	x0, [x29, #-0x98]
               	sub	x22, x29, #0x90
               	stur	x20, [x29, #-0x90]
               	stur	x24, [x29, #-0x88]
               	sub	x4, x29, #0x1f0
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x2, x0
               	mov	x3, x1
               	stur	x2, [x29, #-0x80]
               	stur	x3, [x29, #-0x78]
               	str	x2, [sp, #0x228]
               	str	x3, [sp, #0x220]
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	ldr	x3, [sp, #0x220]
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa0
               	sub	x2, x29, #0x90
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	add	x0, x20, #0x1
               	cmp	x0, x20
               	cset	x1, lo
               	add	x1, x24, x1
               	sub	x21, x29, #0x240
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x38]
               	sub	x22, x29, #0x230
               	str	x20, [sp, #0x40]
               	str	x24, [sp, #0x48]
               	sub	x4, x29, #0x1f0
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x0
               	mov	x24, x1
               	str	x20, [sp, #0x90]
               	str	x24, [sp, #0x98]
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0xa0]
               	str	x1, [sp, #0xa8]
               	eor	x0, x0, x20
               	eor	x1, x1, x24
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	add	x23, x23, #0x1
               	cmp	w23, #0x40
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x1f0
               	str	x1, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	sub	x2, x29, #0x1e0
               	str	xzr, [sp, #0x90]
               	str	x4, [sp, #0x98]
               	sub	x4, x29, #0x1d0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x0
               	mov	x21, x1
               	str	x20, [sp, #0x70]
               	str	x21, [sp, #0x78]
               	sub	x0, x29, #0x1f0
               	sub	x2, x29, #0x1e0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, x20
               	eor	x1, x1, x21
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1f0
               	sub	x2, x29, #0x1e0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	ldr	x2, [sp, #0xa0]
               	ldr	x3, [sp, #0xa8]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #-0x1               // =-1
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x4, #0x1                // =1
               	sub	x0, x29, #0x1f0
               	str	x1, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	sub	x2, x29, #0x1e0
               	str	x4, [sp, #0x90]
               	str	x3, [sp, #0x98]
               	sub	x4, x29, #0x1d0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x0
               	mov	x21, x1
               	str	x20, [sp, #0x70]
               	str	x21, [sp, #0x78]
               	sub	x0, x29, #0x1f0
               	sub	x2, x29, #0x1e0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, x20
               	eor	x1, x1, x21
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x1f0
               	sub	x2, x29, #0x1e0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	ldr	x2, [sp, #0xa0]
               	ldr	x3, [sp, #0xa8]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x1                // =1
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x1, x1, #0x8000000000000000
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #0x1                // =1
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x3, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x3, #0x2                // =2
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x1, x1, #0xc000000000000000
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x1, #-0x2               // =-2
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x1, x1, #0x4000000000000000
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	mov	x3, #-0x1               // =-1
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mvn	x0, x0
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	mov	x3, #-0x1               // =-1
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mvn	x0, x0
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	mov	x3, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x3, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	mov	x3, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	stur	x3, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mvn	x0, x0
               	eor	x1, x1, #0x7fffffffffffffff
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x7               // =-7
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0xfffffffffffffffd
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #-0x7               // =-7
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	mvn	x0, x0
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	mov	x1, #-0x2               // =-2
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0xfffffffffffffffd
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	mov	x1, #-0x2               // =-2
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x0, #0x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x3, #0x3                // =3
               	sub	x2, x29, #0x10
               	stur	x3, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x1, #-0x3               // =-3
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	mov	x1, #-0x1               // =-1
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x1, #-0x1               // =-1
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x10               // =16
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x3, #0x1000000000       // =68719476736
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	mov	x1, #-0x1               // =-1
               	mov	x3, #-0x2               // =-2
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x0, x0, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x1, x0, x17
               	eor	x0, x1, x1, lsr #29
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
               	str	x1, [x2, #0x10]
               	eor	x1, x1, x1, lsr #29
               	str	x1, [sp, #0x30]
               	str	x0, [sp, #0x38]
               	cbz	x0, <addr>
               	mov	x4, #0x0                // =0
               	cmp	x0, #0xa
               	b.lo	<addr>
               	lsr	x2, x0, #1
               	mov	x3, #0x6667             // =26215
               	movk	x3, #0x6666, lsl #16
               	movk	x3, #0x6666, lsl #32
               	movk	x3, #0x6666, lsl #48
               	umulh	x2, x2, x3
               	lsr	x20, x2, #1
               	mov	x17, #0xa               // =10
               	mul	x2, x20, x17
               	sub	x0, x0, x2
               	mov	x3, #0xa0000000         // =2684354560
               	lsr	x2, x1, #1
               	lsl	x0, x0, #60
               	orr	x5, x0, x2, lsr #3
               	lsl	x0, x1, #60
               	lsr	x2, x0, #32
               	mov	w6, w0
               	lsr	x0, x5, #29
               	mov	x1, #0x3334             // =13108
               	movk	x1, #0x3333, lsl #16
               	movk	x1, #0x3333, lsl #32
               	movk	x1, #0x3333, lsl #48
               	umulh	x0, x0, x1
               	msub	x1, x0, x3, x5
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	mul	x7, x0, x4
               	orr	x8, x2, x1, lsl #32
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	orr	x1, x2, x5, lsl #32
               	mov	x17, #-0x6000000000000000 // =-6917529027641081856
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #29
               	mov	x5, #0x3334             // =13108
               	movk	x5, #0x3333, lsl #16
               	movk	x5, #0x3333, lsl #32
               	movk	x5, #0x3333, lsl #48
               	umulh	x1, x1, x5
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	mul	x5, x1, x4
               	orr	x7, x6, x2, lsl #32
               	cmp	x5, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	orr	x22, x1, x0, lsl #32
               	sub	x0, x29, #0x240
               	mov	x23, #0xa               // =10
               	sub	x2, x29, #0x40
               	stur	x23, [x29, #-0x40]
               	stur	xzr, [x29, #-0x38]
               	sub	x4, x29, #0x230
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x80]
               	str	x1, [sp, #0x88]
               	eor	x0, x22, x0
               	eor	x1, x20, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x4, [sp, #0x30]
               	ldr	x0, [sp, #0x38]
               	cbz	x0, <addr>
               	cmp	x0, #0xa
               	b.lo	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x6667             // =26215
               	movk	x2, #0x6666, lsl #16
               	movk	x2, #0x6666, lsl #32
               	movk	x2, #0x6666, lsl #48
               	umulh	x1, x1, x2
               	lsr	x2, x1, #1
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	sub	x0, x0, x1
               	mov	x3, #0xa0000000         // =2684354560
               	mov	x5, #0x0                // =0
               	lsr	x1, x4, #1
               	lsl	x0, x0, #60
               	orr	x6, x0, x1, lsr #3
               	lsl	x0, x4, #60
               	lsr	x2, x0, #32
               	mov	w7, w0
               	lsr	x0, x6, #29
               	mov	x1, #0x3334             // =13108
               	movk	x1, #0x3333, lsl #16
               	movk	x1, #0x3333, lsl #32
               	movk	x1, #0x3333, lsl #48
               	umulh	x0, x0, x1
               	msub	x1, x0, x3, x6
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	mul	x8, x0, x5
               	orr	x9, x2, x1, lsl #32
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x8, x1, #32
               	cbz	x8, <addr>
               	orr	x1, x2, x6, lsl #32
               	mov	x17, #-0x6000000000000000 // =-6917529027641081856
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #29
               	mov	x6, #0x3334             // =13108
               	movk	x6, #0x3333, lsl #16
               	movk	x6, #0x3333, lsl #32
               	movk	x6, #0x3333, lsl #48
               	umulh	x1, x1, x6
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x5
               	orr	x8, x7, x2, lsl #32
               	cmp	x6, x8
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x1, x1, x0, lsl #32
               	msub	x0, x1, x23, x4
               	ldr	x1, [sp, #0x40]
               	ldr	x2, [sp, #0x48]
               	eor	x0, x0, x1
               	orr	x0, x0, x2
               	cbnz	x0, <addr>
               	ldr	x1, [sp, #0x30]
               	ldr	x0, [sp, #0x38]
               	mov	x2, #0xca07             // =51719
               	movk	x2, #0x3b9a, lsl #16
               	cbz	x0, <addr>
               	mov	x4, #0x0                // =0
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x2, #0x8fe5             // =36837
               	movk	x2, #0x12a2, lsl #16
               	movk	x2, #0x5f31, lsl #32
               	movk	x2, #0x8970, lsl #48
               	umulh	x2, x0, x2
               	lsr	x20, x2, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x2, x20, x17
               	sub	x0, x0, x2
               	mov	x3, #0x281c             // =10268
               	movk	x3, #0xee6b, lsl #16
               	lsr	x2, x1, #1
               	lsl	x0, x0, #34
               	orr	x5, x0, x2, lsr #29
               	lsl	x0, x1, #34
               	lsr	x2, x0, #32
               	mov	w6, w0
               	lsr	x0, x5, #2
               	mov	x1, #0x47f3             // =18419
               	movk	x1, #0x8951, lsl #16
               	movk	x1, #0x2f98, lsl #32
               	movk	x1, #0x44b8, lsl #48
               	umulh	x0, x0, x1
               	lsr	x0, x0, #28
               	msub	x1, x0, x3, x5
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	mul	x7, x0, x4
               	orr	x8, x2, x1, lsl #32
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	orr	x1, x2, x5, lsl #32
               	mov	x17, #0x281c00000000    // =44100724195328
               	movk	x17, #0xee6b, lsl #48
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #2
               	mov	x5, #0x47f3             // =18419
               	movk	x5, #0x8951, lsl #16
               	movk	x5, #0x2f98, lsl #32
               	movk	x5, #0x44b8, lsl #48
               	umulh	x1, x1, x5
               	lsr	x1, x1, #28
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	mul	x5, x1, x4
               	orr	x7, x6, x2, lsl #32
               	cmp	x5, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	orr	x22, x1, x0, lsl #32
               	sub	x0, x29, #0x240
               	mov	x23, #0xca07            // =51719
               	movk	x23, #0x3b9a, lsl #16
               	sub	x2, x29, #0x30
               	stur	x23, [x29, #-0x30]
               	stur	xzr, [x29, #-0x28]
               	sub	x4, x29, #0x230
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x90]
               	str	x1, [sp, #0x98]
               	eor	x0, x22, x0
               	eor	x1, x20, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x4, [sp, #0x30]
               	ldr	x0, [sp, #0x38]
               	cbz	x0, <addr>
               	cmp	x0, x23
               	b.lo	<addr>
               	mov	x1, #0x8fe5             // =36837
               	movk	x1, #0x12a2, lsl #16
               	movk	x1, #0x5f31, lsl #32
               	movk	x1, #0x8970, lsl #48
               	umulh	x1, x0, x1
               	lsr	x2, x1, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x2, x17
               	sub	x0, x0, x1
               	mov	x3, #0x281c             // =10268
               	movk	x3, #0xee6b, lsl #16
               	mov	x5, #0x0                // =0
               	lsr	x1, x4, #1
               	lsl	x0, x0, #34
               	orr	x6, x0, x1, lsr #29
               	lsl	x0, x4, #34
               	lsr	x2, x0, #32
               	mov	w7, w0
               	lsr	x0, x6, #2
               	mov	x1, #0x47f3             // =18419
               	movk	x1, #0x8951, lsl #16
               	movk	x1, #0x2f98, lsl #32
               	movk	x1, #0x44b8, lsl #48
               	umulh	x0, x0, x1
               	lsr	x0, x0, #28
               	msub	x1, x0, x3, x6
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	mul	x8, x0, x5
               	orr	x9, x2, x1, lsl #32
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x8, x1, #32
               	cbz	x8, <addr>
               	orr	x1, x2, x6, lsl #32
               	mov	x17, #0x281c00000000    // =44100724195328
               	movk	x17, #0xee6b, lsl #48
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #2
               	mov	x6, #0x47f3             // =18419
               	movk	x6, #0x8951, lsl #16
               	movk	x6, #0x2f98, lsl #32
               	movk	x6, #0x44b8, lsl #48
               	umulh	x1, x1, x6
               	lsr	x1, x1, #28
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x5
               	orr	x8, x7, x2, lsl #32
               	cmp	x6, x8
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x1, x1, x0, lsl #32
               	msub	x0, x1, x23, x4
               	ldr	x1, [sp, #0x40]
               	ldr	x2, [sp, #0x48]
               	eor	x0, x0, x1
               	orr	x0, x0, x2
               	cbnz	x0, <addr>
               	ldr	x4, [sp, #0x30]
               	ldr	x5, [sp, #0x38]
               	mov	x9, #0x3                // =3
               	mov	x10, #0x5               // =5
               	orr	x0, x5, x9
               	cbz	x0, <addr>
               	lsr	x6, x5, #1
               	lsr	x0, x4, #1
               	orr	x0, x0, x5, lsl #63
               	mov	x3, #0xc0000000         // =3221225472
               	lsr	x2, x0, #32
               	mov	w7, w0
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0x2aaa, lsl #48
               	umulh	x0, x6, x0
               	lsr	x0, x0, #29
               	msub	x1, x0, x3, x6
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	orr	x8, x2, x1, lsl #32
               	cmp	x0, x8
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x8, x1, #32
               	cbz	x8, <addr>
               	orr	x1, x2, x6, lsl #32
               	mov	x17, #-0x3fffffffffffffff // =-4611686018427387903
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #30
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	movk	x6, #0x5555, lsl #32
               	movk	x6, #0x5555, lsl #48
               	umulh	x1, x1, x6
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	orr	x6, x7, x2, lsl #32
               	cmp	x1, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x0, x1, x0, lsl #32
               	lsr	x0, x0, #1
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x10
               	mul	x1, x0, x10
               	madd	x2, x0, x9, x2
               	cmp	x4, x1
               	cset	x3, lo
               	sub	x4, x4, x1
               	sub	x1, x5, x2
               	sub	x1, x1, x3
               	cmp	x1, #0x3
               	cset	x2, lo
               	cmp	x1, #0x3
               	cset	x1, eq
               	cmp	x4, #0x5
               	cset	x3, lo
               	and	x1, x1, x3
               	orr	x1, x2, x1
               	eor	x1, x1, #0x1
               	add	x23, x0, x1
               	sub	x0, x29, #0x240
               	mov	x22, #0x3               // =3
               	mov	x20, #0x5               // =5
               	sub	x2, x29, #0x20
               	stur	x20, [x29, #-0x20]
               	stur	x22, [x29, #-0x18]
               	sub	x4, x29, #0x230
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0xa0]
               	str	x1, [sp, #0xa8]
               	eor	x0, x23, x0
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x4, [sp, #0x30]
               	ldr	x5, [sp, #0x38]
               	orr	x0, x5, x22
               	cbz	x0, <addr>
               	lsr	x6, x5, #1
               	lsr	x0, x4, #1
               	orr	x0, x0, x5, lsl #63
               	mov	x3, #0xc0000000         // =3221225472
               	lsr	x2, x0, #32
               	mov	w7, w0
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0x2aaa, lsl #48
               	umulh	x0, x6, x0
               	lsr	x0, x0, #29
               	msub	x1, x0, x3, x6
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	orr	x8, x2, x1, lsl #32
               	cmp	x0, x8
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x8, x1, #32
               	cbz	x8, <addr>
               	orr	x1, x2, x6, lsl #32
               	mov	x17, #-0x3fffffffffffffff // =-4611686018427387903
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #30
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	movk	x6, #0x5555, lsl #32
               	movk	x6, #0x5555, lsl #48
               	umulh	x1, x1, x6
               	msub	x2, x1, x3, x2
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	orr	x6, x7, x2, lsl #32
               	cmp	x1, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x0, x1, x0, lsl #32
               	lsr	x0, x0, #1
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x20
               	mul	x1, x0, x20
               	madd	x2, x0, x22, x2
               	cmp	x4, x1
               	cset	x3, lo
               	sub	x0, x4, x1
               	sub	x1, x5, x2
               	sub	x2, x1, x3
               	cmp	x2, #0x3
               	cset	x1, lo
               	cmp	x2, #0x3
               	cset	x3, eq
               	cmp	x0, #0x5
               	cset	x4, lo
               	and	x3, x3, x4
               	orr	x1, x1, x3
               	eor	x1, x1, #0x1
               	neg	x1, x1
               	and	x3, x20, x1
               	and	x4, x22, x1
               	cmp	x0, x3
               	cset	x5, lo
               	sub	x1, x0, x3
               	sub	x0, x2, x4
               	sub	x0, x0, x5
               	ldr	x2, [sp, #0x40]
               	ldr	x3, [sp, #0x48]
               	eor	x1, x1, x2
               	eor	x0, x0, x3
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	ldr	x1, [sp, #0x30]
               	ldr	x0, [sp, #0x38]
               	cbz	x0, <addr>
               	mov	x5, #0x0                // =0
               	cmn	x0, #0x1
               	cset	x2, hs
               	add	x4, x0, x2
               	cmn	x0, #0x1
               	csel	x4, x4, x0, hs
               	csel	x22, x2, x5, hs
               	mov	x3, #0xffffffff         // =4294967295
               	lsr	x2, x1, #32
               	mov	w5, w1
               	mov	x0, #0x1                // =1
               	movk	x0, #0x8000, lsl #16
               	movk	x0, #0x8000, lsl #48
               	umulh	x0, x4, x0
               	lsr	x0, x0, #31
               	msub	x1, x0, x3, x4
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x3
               	orr	x7, x2, x1, lsl #32
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	orr	x1, x2, x4, lsl #32
               	add	x2, x1, x0
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	movk	x1, #0x8000, lsl #48
               	umulh	x1, x2, x1
               	lsr	x1, x1, #31
               	msub	x2, x1, x3, x2
               	lsr	x4, x1, #32
               	cbnz	x4, <addr>
               	mul	x4, x1, x3
               	orr	x6, x5, x2, lsl #32
               	cmp	x4, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x4, x2, #32
               	cbz	x4, <addr>
               	orr	x20, x1, x0, lsl #32
               	sub	x0, x29, #0x240
               	mov	x23, #-0x1              // =-1
               	sub	x2, x29, #0x10
               	stur	x23, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	sub	x4, x29, #0x230
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	eor	x0, x20, x0
               	eor	x1, x22, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x4, [sp, #0x30]
               	ldr	x0, [sp, #0x38]
               	cbz	x0, <addr>
               	cmn	x0, #0x1
               	cset	x1, hs
               	add	x1, x0, x1
               	cmp	x0, x23
               	csel	x5, x1, x0, hs
               	mov	x3, #0xffffffff         // =4294967295
               	lsr	x2, x4, #32
               	mov	w6, w4
               	mov	x0, #0x1                // =1
               	movk	x0, #0x8000, lsl #16
               	movk	x0, #0x8000, lsl #48
               	umulh	x0, x5, x0
               	lsr	x0, x0, #31
               	msub	x1, x0, x3, x5
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	mul	x7, x0, x3
               	orr	x8, x2, x1, lsl #32
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	orr	x1, x2, x5, lsl #32
               	add	x2, x1, x0
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	movk	x1, #0x8000, lsl #48
               	umulh	x1, x2, x1
               	lsr	x1, x1, #31
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	mul	x5, x1, x3
               	orr	x7, x6, x2, lsl #32
               	cmp	x5, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	orr	x1, x1, x0, lsl #32
               	add	x0, x4, x1
               	ldr	x1, [sp, #0x40]
               	ldr	x2, [sp, #0x48]
               	eor	x0, x0, x1
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	b	<addr>
               	cmn	x4, #0x1
               	cset	x1, hs
               	add	x0, x4, x1
               	b	<addr>
               	cmn	x1, #0x1
               	cset	x20, hs
               	mov	x0, #0x0                // =0
               	mov	x22, x0
               	b	<addr>
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0xcccc, lsl #48
               	umulh	x0, x4, x0
               	lsr	x3, x0, #2
               	msub	x1, x3, x20, x4
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0xcccc, lsl #48
               	umulh	x0, x4, x0
               	lsr	x23, x0, #2
               	b	<addr>
               	mov	x0, #0x8fe5             // =36837
               	movk	x0, #0x12a2, lsl #16
               	movk	x0, #0x5f31, lsl #32
               	movk	x0, #0x8970, lsl #48
               	umulh	x0, x4, x0
               	lsr	x1, x0, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x0, x1, x17
               	sub	x0, x4, x0
               	b	<addr>
               	mov	x20, x4
               	b	<addr>
               	mov	x0, #0x8fe5             // =36837
               	movk	x0, #0x12a2, lsl #16
               	movk	x0, #0x5f31, lsl #32
               	movk	x0, #0x8970, lsl #48
               	umulh	x0, x1, x0
               	lsr	x22, x0, #29
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	b	<addr>
               	lsr	x0, x4, #1
               	mov	x1, #0x6667             // =26215
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x6666, lsl #48
               	umulh	x0, x0, x1
               	lsr	x1, x0, #1
               	mov	x17, #0xa               // =10
               	mul	x0, x1, x17
               	sub	x0, x4, x0
               	b	<addr>
               	mov	x20, x4
               	b	<addr>
               	lsr	x0, x1, #1
               	mov	x1, #0x6667             // =26215
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x6666, lsl #48
               	umulh	x0, x0, x1
               	lsr	x22, x0, #1
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	b	<addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0xc8
               	b.lt	<addr>
               	mov	x23, #0x0               // =0
               	mov	x21, x23
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
               	eor	x2, x1, x1, lsr #29
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
               	eor	x1, x1, x1, lsr #29
               	sub	x5, x29, #0x220
               	str	x1, [sp, #0x50]
               	str	x2, [sp, #0x58]
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
               	eor	x2, x1, x1, lsr #29
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
               	eor	x6, x1, x1, lsr #29
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
               	eor	x0, x1, x1, lsr #29
               	and	x1, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x7, x3, x0
               	lsr	x1, x1, #6
               	neg	x1, x1
               	mvn	x3, x1
               	lsr	x4, x2, x0
               	lsl	x2, x2, x7
               	lsr	x0, x6, x0
               	orr	x0, x0, x2, lsl #1
               	and	x0, x0, x3
               	and	x1, x4, x1
               	orr	x0, x0, x1
               	and	x1, x4, x3
               	sub	x2, x29, #0x210
               	str	x0, [sp, #0x60]
               	str	x1, [sp, #0x68]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	str	x0, [sp, #0x60]
               	str	x23, [sp, #0x68]
               	sub	x20, x29, #0xf0
               	ldp	x16, x17, [x5]
               	stp	x16, x17, [x20]
               	sub	x22, x29, #0xe0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x22]
               	sub	x4, x29, #0x1f0
               	mov	x0, x20
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x24, x0
               	mov	x2, x1
               	stur	x24, [x29, #-0xd0]
               	stur	x2, [x29, #-0xc8]
               	str	x2, [sp, #0x228]
               	mov	x0, x20
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	stur	x0, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	eor	x0, x0, x24
               	eor	x1, x1, x2
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x2, x29, #0xe0
               	mov	x0, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0xb0]
               	stur	x1, [x29, #-0xa8]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x5, [sp, #0x50]
               	ldr	x1, [sp, #0x58]
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x0, x0, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x0, x0, x17
               	str	x0, [x2, #0x10]
               	eor	x0, x0, x0, lsr #29
               	and	x2, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x6, x3, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x3, x2
               	lsr	x4, x1, x0
               	lsl	x1, x1, x6
               	lsr	x0, x5, x0
               	orr	x0, x0, x1, lsl #1
               	and	x0, x0, x3
               	and	x1, x4, x2
               	orr	x0, x0, x1
               	and	x1, x4, x3
               	sub	x2, x29, #0x210
               	sub	x20, x29, #0xa0
               	stur	x0, [x29, #-0xa0]
               	stur	x1, [x29, #-0x98]
               	sub	x22, x29, #0x90
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x22]
               	sub	x4, x29, #0x1f0
               	mov	x0, x20
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x24, x0
               	mov	x2, x1
               	stur	x24, [x29, #-0x80]
               	stur	x2, [x29, #-0x78]
               	str	x2, [sp, #0x228]
               	mov	x0, x20
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	stur	x0, [x29, #-0x70]
               	stur	x1, [x29, #-0x68]
               	eor	x0, x0, x24
               	eor	x1, x1, x2
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x2, x29, #0x90
               	mov	x0, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x0, [sp, #0x60]
               	sub	x2, x0, #0x1
               	adrp	x1, <page>
               	ldr	x0, [x1, #0x10]
               	mov	x17, #0x7f2d            // =32557
               	movk	x17, #0x4c95, lsl #16
               	movk	x17, #0xf42d, lsl #32
               	movk	x17, #0x5851, lsl #48
               	mul	x0, x0, x17
               	mov	x17, #0x814f            // =33103
               	movk	x17, #0xf767, lsl #16
               	movk	x17, #0x7b7e, lsl #32
               	movk	x17, #0x1405, lsl #48
               	add	x0, x0, x17
               	str	x0, [x1, #0x10]
               	eor	x0, x0, x0, lsr #29
               	ldr	x3, [sp, #0x60]
               	orr	x3, x3, #0x1
               	sub	x20, x29, #0x240
               	str	x0, [sp, #0x30]
               	str	x2, [sp, #0x38]
               	sub	x22, x29, #0x230
               	str	x3, [sp, #0x40]
               	str	xzr, [sp, #0x48]
               	sub	x4, x29, #0x1f0
               	mov	x0, x20
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x24, x0
               	mov	x2, x1
               	str	x24, [sp, #0x90]
               	str	x2, [sp, #0x98]
               	str	x2, [sp, #0x228]
               	mov	x0, x20
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	ldr	x2, [sp, #0x228]
               	str	x0, [sp, #0xa0]
               	str	x1, [sp, #0xa8]
               	eor	x0, x0, x24
               	eor	x1, x1, x2
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x2, x29, #0x230
               	mov	x0, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	str	x0, [sp, #0x70]
               	str	x1, [sp, #0x78]
               	ldr	x2, [sp, #0x80]
               	ldr	x3, [sp, #0x88]
               	eor	x0, x0, x2
               	eor	x1, x1, x3
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x220
               	sub	x20, x29, #0x210
               	mov	x2, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	ldr	x1, [sp, #0x50]
               	ldr	x0, [sp, #0x58]
               	lsr	x2, x0, #1
               	lsr	x1, x1, #1
               	orr	x0, x1, x0, lsl #63
               	cmp	x0, #0x0
               	cset	x1, hi
               	neg	x3, x0
               	neg	x0, x2
               	sub	x1, x0, x1
               	sub	x0, x29, #0x30
               	stur	x3, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	mov	x2, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	ldr	x1, [sp, #0x50]
               	ldr	x0, [sp, #0x58]
               	lsr	x2, x0, #1
               	lsr	x1, x1, #1
               	orr	x1, x1, x0, lsl #63
               	sub	x0, x29, #0x20
               	stur	x1, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	ldr	x2, [sp, #0x60]
               	ldr	x1, [sp, #0x68]
               	lsr	x3, x1, #1
               	lsr	x2, x2, #1
               	orr	x1, x2, x1, lsl #63
               	cmp	x1, #0x0
               	cset	x2, hi
               	neg	x4, x1
               	neg	x3, x3
               	sub	x2, x3, x2
               	cmp	x4, #0x1
               	cset	x3, lo
               	mvn	x1, x1
               	sub	x3, x2, x3
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	add	x21, x21, #0x1
               	cmp	w21, #0x3e8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x19               // =25
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x18               // =24
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x17               // =23
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x16               // =22
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x13               // =19
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x12               // =18
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x270
               	ldp	x29, x30, [sp], #0x10
               	ret
