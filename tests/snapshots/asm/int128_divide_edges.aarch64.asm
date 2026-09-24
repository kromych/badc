
int128_divide_edges.aarch64:	file format elf64-littleaarch64

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
               	lsl	x6, x1, #63
               	orr	x6, x4, x6
               	clz	x4, x5
               	lsl	x12, x5, x4
               	lsr	x7, x12, #32
               	mov	w8, w12
               	eor	x5, x4, #0x3f
               	lsr	x10, x6, #1
               	lsr	x5, x10, x5
               	lsl	x9, x9, x4
               	orr	x13, x9, x5
               	lsl	x4, x6, x4
               	lsr	x6, x4, #32
               	mov	w9, w4
               	udiv	x4, x13, x7
               	msub	x5, x4, x7, x13
               	lsr	x10, x4, #32
               	cbnz	x10, <addr>
               	mul	x10, x4, x8
               	lsl	x11, x5, #32
               	orr	x11, x11, x6
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x4, x4, #0x1
               	add	x5, x5, x7
               	lsr	x10, x5, #32
               	cbz	x10, <addr>
               	lsl	x5, x13, #32
               	orr	x5, x5, x6
               	msub	x6, x4, x12, x5
               	udiv	x5, x6, x7
               	msub	x6, x5, x7, x6
               	lsr	x10, x5, #32
               	cbnz	x10, <addr>
               	mul	x10, x5, x8
               	lsl	x11, x6, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x5, x5, #0x1
               	add	x6, x6, x7
               	lsr	x10, x6, #32
               	cbz	x10, <addr>
               	lsl	x4, x4, #32
               	orr	x4, x4, x5
               	lsr	x4, x4, x14
               	cmp	x4, #0x0
               	cset	x5, ne
               	sub	x4, x4, x5
               	umulh	x6, x4, x2
               	mul	x5, x4, x2
               	madd	x6, x4, x3, x6
               	cmp	x0, x5
               	cset	x7, lo
               	sub	x0, x0, x5
               	sub	x1, x1, x6
               	sub	x1, x1, x7
               	cmp	x1, x3
               	cset	x5, lo
               	cmp	x1, x3
               	cset	x6, eq
               	cmp	x0, x2
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x5, x5, x6
               	eor	x5, x5, #0x1
               	add	x4, x4, x5
               	mov	x11, #0x0               // =0
               	neg	x5, x5
               	and	x2, x2, x5
               	and	x3, x3, x5
               	cmp	x0, x2
               	cset	x5, lo
               	sub	x0, x0, x2
               	sub	x1, x1, x3
               	sub	x1, x1, x5
               	mov	x0, x4
               	mov	x1, x11
               	ret
               	mov	x11, #0x0               // =0
               	cmp	x1, x2
               	b.lo	<addr>
               	udiv	x11, x1, x2
               	msub	x1, x11, x2, x1
               	clz	x3, x2
               	lsl	x12, x2, x3
               	lsr	x6, x12, #32
               	mov	w7, w12
               	eor	x4, x3, #0x3f
               	lsr	x5, x0, #1
               	lsr	x4, x5, x4
               	lsl	x1, x1, x3
               	orr	x1, x1, x4
               	lsl	x3, x0, x3
               	lsr	x5, x3, #32
               	mov	w8, w3
               	udiv	x3, x1, x6
               	msub	x4, x3, x6, x1
               	lsr	x9, x3, #32
               	cbnz	x9, <addr>
               	mul	x9, x3, x7
               	lsl	x10, x4, #32
               	orr	x10, x10, x5
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x3, x3, #0x1
               	add	x4, x4, x6
               	lsr	x9, x4, #32
               	cbz	x9, <addr>
               	lsl	x1, x1, #32
               	orr	x1, x1, x5
               	msub	x1, x3, x12, x1
               	udiv	x4, x1, x6
               	msub	x5, x4, x6, x1
               	lsr	x9, x4, #32
               	cbnz	x9, <addr>
               	mul	x9, x4, x7
               	lsl	x10, x5, #32
               	orr	x10, x10, x8
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x4, x4, #0x1
               	add	x5, x5, x6
               	lsr	x9, x5, #32
               	cbz	x9, <addr>
               	lsl	x1, x3, #32
               	orr	x4, x1, x4
               	msub	x0, x4, x2, x0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	udiv	x4, x0, x2
               	msub	x0, x4, x2, x0
               	mov	x1, #0x0                // =0
               	mov	x11, x1
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
               	lsl	x6, x1, #63
               	orr	x6, x4, x6
               	clz	x4, x5
               	lsl	x12, x5, x4
               	lsr	x7, x12, #32
               	mov	w8, w12
               	eor	x5, x4, #0x3f
               	lsr	x10, x6, #1
               	lsr	x5, x10, x5
               	lsl	x9, x9, x4
               	orr	x13, x9, x5
               	lsl	x4, x6, x4
               	lsr	x6, x4, #32
               	mov	w9, w4
               	udiv	x4, x13, x7
               	msub	x5, x4, x7, x13
               	lsr	x10, x4, #32
               	cbnz	x10, <addr>
               	mul	x10, x4, x8
               	lsl	x11, x5, #32
               	orr	x11, x11, x6
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x4, x4, #0x1
               	add	x5, x5, x7
               	lsr	x10, x5, #32
               	cbz	x10, <addr>
               	lsl	x5, x13, #32
               	orr	x5, x5, x6
               	msub	x6, x4, x12, x5
               	udiv	x5, x6, x7
               	msub	x6, x5, x7, x6
               	lsr	x10, x5, #32
               	cbnz	x10, <addr>
               	mul	x10, x5, x8
               	lsl	x11, x6, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x5, x5, #0x1
               	add	x6, x6, x7
               	lsr	x10, x6, #32
               	cbz	x10, <addr>
               	lsl	x4, x4, #32
               	orr	x4, x4, x5
               	lsr	x4, x4, x14
               	cmp	x4, #0x0
               	cset	x5, ne
               	sub	x4, x4, x5
               	umulh	x6, x4, x2
               	mul	x5, x4, x2
               	madd	x6, x4, x3, x6
               	cmp	x0, x5
               	cset	x7, lo
               	sub	x0, x0, x5
               	sub	x1, x1, x6
               	sub	x1, x1, x7
               	cmp	x1, x3
               	cset	x5, lo
               	cmp	x1, x3
               	cset	x6, eq
               	cmp	x0, x2
               	cset	x7, lo
               	and	x6, x6, x7
               	orr	x5, x5, x6
               	eor	x5, x5, #0x1
               	add	x4, x4, x5
               	mov	x11, #0x0               // =0
               	neg	x5, x5
               	and	x2, x2, x5
               	and	x3, x3, x5
               	cmp	x0, x2
               	cset	x5, lo
               	sub	x0, x0, x2
               	sub	x1, x1, x3
               	sub	x1, x1, x5
               	ret
               	mov	x11, #0x0               // =0
               	cmp	x1, x2
               	b.lo	<addr>
               	udiv	x11, x1, x2
               	msub	x1, x11, x2, x1
               	clz	x3, x2
               	lsl	x12, x2, x3
               	lsr	x6, x12, #32
               	mov	w7, w12
               	eor	x4, x3, #0x3f
               	lsr	x5, x0, #1
               	lsr	x4, x5, x4
               	lsl	x1, x1, x3
               	orr	x1, x1, x4
               	lsl	x3, x0, x3
               	lsr	x5, x3, #32
               	mov	w8, w3
               	udiv	x3, x1, x6
               	msub	x4, x3, x6, x1
               	lsr	x9, x3, #32
               	cbnz	x9, <addr>
               	mul	x9, x3, x7
               	lsl	x10, x4, #32
               	orr	x10, x10, x5
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x3, x3, #0x1
               	add	x4, x4, x6
               	lsr	x9, x4, #32
               	cbz	x9, <addr>
               	lsl	x1, x1, #32
               	orr	x1, x1, x5
               	msub	x1, x3, x12, x1
               	udiv	x4, x1, x6
               	msub	x5, x4, x6, x1
               	lsr	x9, x4, #32
               	cbnz	x9, <addr>
               	mul	x9, x4, x7
               	lsl	x10, x5, #32
               	orr	x10, x10, x8
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x4, x4, #0x1
               	add	x5, x5, x6
               	lsr	x9, x5, #32
               	cbz	x9, <addr>
               	lsl	x1, x3, #32
               	orr	x4, x1, x4
               	msub	x0, x4, x2, x0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	udiv	x4, x0, x2
               	msub	x0, x4, x2, x0
               	mov	x1, #0x0                // =0
               	mov	x11, x1
               	b	<addr>

<sdiv>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	asr	x12, x1, #63
               	asr	x13, x3, #63
               	eor	x0, x0, x12
               	eor	x1, x1, x12
               	cmp	x0, x12
               	cset	x4, lo
               	sub	x10, x0, x12
               	sub	x0, x1, x12
               	sub	x7, x0, x4
               	eor	x0, x2, x13
               	eor	x1, x3, x13
               	cmp	x0, x13
               	cset	x2, lo
               	sub	x5, x0, x13
               	sub	x0, x1, x13
               	sub	x11, x0, x2
               	orr	x0, x7, x11
               	cbz	x0, <addr>
               	cbz	x11, <addr>
               	clz	x0, x11
               	eor	x20, x0, #0x3f
               	lsl	x0, x11, x0
               	lsr	x1, x5, #1
               	lsr	x1, x1, x20
               	orr	x1, x0, x1
               	lsr	x6, x7, #1
               	lsr	x0, x10, #1
               	lsl	x2, x7, #63
               	orr	x2, x0, x2
               	clz	x0, x1
               	lsl	x14, x1, x0
               	lsr	x3, x14, #32
               	mov	w4, w14
               	eor	x1, x0, #0x3f
               	lsr	x8, x2, #1
               	lsr	x1, x8, x1
               	lsl	x6, x6, x0
               	orr	x15, x6, x1
               	lsl	x0, x2, x0
               	lsr	x2, x0, #32
               	mov	w6, w0
               	udiv	x0, x15, x3
               	msub	x1, x0, x3, x15
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	mul	x8, x0, x4
               	lsl	x9, x1, #32
               	orr	x9, x9, x2
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x8, x1, #32
               	cbz	x8, <addr>
               	lsl	x1, x15, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x14, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x8, x1, #32
               	cbnz	x8, <addr>
               	mul	x8, x1, x4
               	lsl	x9, x2, #32
               	orr	x9, x9, x6
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x8, x2, #32
               	cbz	x8, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, x20
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x5
               	mul	x1, x0, x5
               	madd	x2, x0, x11, x2
               	cmp	x10, x1
               	cset	x3, lo
               	sub	x1, x10, x1
               	sub	x2, x7, x2
               	sub	x3, x2, x3
               	cmp	x3, x11
               	cset	x2, lo
               	cmp	x3, x11
               	cset	x4, eq
               	cmp	x1, x5
               	cset	x6, lo
               	and	x4, x4, x6
               	orr	x2, x2, x4
               	eor	x2, x2, #0x1
               	add	x0, x0, x2
               	mov	x9, #0x0                // =0
               	neg	x2, x2
               	and	x4, x5, x2
               	and	x5, x11, x2
               	cmp	x1, x4
               	cset	x6, lo
               	sub	x2, x1, x4
               	sub	x1, x3, x5
               	sub	x1, x1, x6
               	eor	x1, x12, x13
               	eor	x0, x0, x1
               	eor	x2, x9, x1
               	cmp	x0, x1
               	cset	x3, lo
               	sub	x0, x0, x1
               	sub	x1, x2, x1
               	sub	x1, x1, x3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x9, #0x0                // =0
               	cmp	x7, x5
               	b.lo	<addr>
               	udiv	x9, x7, x5
               	msub	x7, x9, x5, x7
               	clz	x0, x5
               	lsl	x11, x5, x0
               	lsr	x3, x11, #32
               	mov	w4, w11
               	eor	x1, x0, #0x3f
               	lsr	x2, x10, #1
               	lsr	x1, x2, x1
               	lsl	x2, x7, x0
               	orr	x14, x2, x1
               	lsl	x0, x10, x0
               	lsr	x2, x0, #32
               	mov	w6, w0
               	udiv	x0, x14, x3
               	msub	x1, x0, x3, x14
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	mul	x7, x0, x4
               	lsl	x8, x1, #32
               	orr	x8, x8, x2
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	lsl	x1, x14, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x11, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x7, x1, #32
               	cbnz	x7, <addr>
               	mul	x7, x1, x4
               	lsl	x8, x2, #32
               	orr	x8, x8, x6
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x7, x2, #32
               	cbz	x7, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	msub	x2, x0, x5, x10
               	mov	x1, #0x0                // =0
               	b	<addr>
               	udiv	x0, x10, x5
               	msub	x2, x0, x5, x10
               	mov	x1, #0x0                // =0
               	mov	x9, x1
               	b	<addr>

<smod>:
               	asr	x6, x1, #63
               	asr	x4, x3, #63
               	eor	x0, x0, x6
               	eor	x1, x1, x6
               	cmp	x0, x6
               	cset	x5, lo
               	sub	x11, x0, x6
               	sub	x0, x1, x6
               	sub	x8, x0, x5
               	eor	x0, x2, x4
               	eor	x1, x3, x4
               	cmp	x0, x4
               	cset	x2, lo
               	sub	x5, x0, x4
               	sub	x0, x1, x4
               	sub	x12, x0, x2
               	orr	x0, x8, x12
               	cbz	x0, <addr>
               	cbz	x12, <addr>
               	clz	x0, x12
               	eor	x15, x0, #0x3f
               	lsl	x0, x12, x0
               	lsr	x1, x5, #1
               	lsr	x1, x1, x15
               	orr	x1, x0, x1
               	lsr	x7, x8, #1
               	lsr	x0, x11, #1
               	lsl	x2, x8, #63
               	orr	x2, x0, x2
               	clz	x0, x1
               	lsl	x13, x1, x0
               	lsr	x3, x13, #32
               	mov	w4, w13
               	eor	x1, x0, #0x3f
               	lsr	x9, x2, #1
               	lsr	x1, x9, x1
               	lsl	x7, x7, x0
               	orr	x14, x7, x1
               	lsl	x0, x2, x0
               	lsr	x2, x0, #32
               	mov	w7, w0
               	udiv	x0, x14, x3
               	msub	x1, x0, x3, x14
               	lsr	x9, x0, #32
               	cbnz	x9, <addr>
               	mul	x9, x0, x4
               	lsl	x10, x1, #32
               	orr	x10, x10, x2
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x9, x1, #32
               	cbz	x9, <addr>
               	lsl	x1, x14, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x13, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	mul	x9, x1, x4
               	lsl	x10, x2, #32
               	orr	x10, x10, x7
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x9, x2, #32
               	cbz	x9, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, x15
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x5
               	mul	x1, x0, x5
               	madd	x3, x0, x12, x2
               	cmp	x11, x1
               	cset	x4, lo
               	sub	x2, x11, x1
               	sub	x1, x8, x3
               	sub	x3, x1, x4
               	cmp	x3, x12
               	cset	x1, lo
               	cmp	x3, x12
               	cset	x4, eq
               	cmp	x2, x5
               	cset	x7, lo
               	and	x4, x4, x7
               	orr	x1, x1, x4
               	eor	x4, x1, #0x1
               	add	x1, x0, x4
               	mov	x10, #0x0               // =0
               	neg	x0, x4
               	and	x4, x5, x0
               	and	x0, x12, x0
               	cmp	x2, x4
               	cset	x5, lo
               	sub	x2, x2, x4
               	sub	x0, x3, x0
               	sub	x0, x0, x5
               	eor	x1, x2, x6
               	eor	x2, x0, x6
               	cmp	x1, x6
               	cset	x3, lo
               	sub	x0, x1, x6
               	sub	x1, x2, x6
               	sub	x1, x1, x3
               	ret
               	mov	x10, #0x0               // =0
               	cmp	x8, x5
               	b.lo	<addr>
               	udiv	x10, x8, x5
               	msub	x8, x10, x5, x8
               	clz	x0, x5
               	lsl	x12, x5, x0
               	lsr	x3, x12, #32
               	mov	w4, w12
               	eor	x1, x0, #0x3f
               	lsr	x2, x11, #1
               	lsr	x1, x2, x1
               	lsl	x2, x8, x0
               	orr	x13, x2, x1
               	lsl	x0, x11, x0
               	lsr	x2, x0, #32
               	mov	w7, w0
               	udiv	x0, x13, x3
               	msub	x1, x0, x3, x13
               	lsr	x8, x0, #32
               	cbnz	x8, <addr>
               	mul	x8, x0, x4
               	lsl	x9, x1, #32
               	orr	x9, x9, x2
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x8, x1, #32
               	cbz	x8, <addr>
               	lsl	x1, x13, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x12, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x8, x1, #32
               	cbnz	x8, <addr>
               	mul	x8, x1, x4
               	lsl	x9, x2, #32
               	orr	x9, x9, x7
               	cmp	x8, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x8, x2, #32
               	cbz	x8, <addr>
               	lsl	x0, x0, #32
               	orr	x1, x0, x1
               	msub	x2, x1, x5, x11
               	mov	x0, #0x0                // =0
               	b	<addr>
               	udiv	x1, x11, x5
               	msub	x2, x1, x5, x11
               	mov	x0, #0x0                // =0
               	mov	x10, x0
               	b	<addr>

<reference>:
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x4
               	stur	x0, [x29, #-0x20]
               	sub	x10, x29, #0x20
               	str	x1, [x10, #0x8]
               	stur	x2, [x29, #-0x10]
               	sub	x7, x29, #0x10
               	str	x3, [x7, #0x8]
               	mov	x5, #0x0                // =0
               	mov	x3, #0x7f               // =127
               	mov	x0, x5
               	mov	x1, x5
               	mov	x8, x5
               	mov	x2, x5
               	lsr	x12, x2, #63
               	lsl	x13, x0, #1
               	lsl	x2, x2, #1
               	lsr	x0, x0, #63
               	orr	x2, x2, x0
               	ldr	x14, [x10]
               	ldr	x0, [x10, #0x8]
               	and	x6, x3, #0x3f
               	mov	x9, #0x3f               // =63
               	sub	x11, x9, x6
               	lsr	x9, x3, #6
               	neg	x9, x9
               	mvn	x15, x9
               	lsr	x4, x0, x6
               	lsl	x0, x0, x11
               	lsl	x0, x0, #1
               	lsr	x14, x14, x6
               	orr	x0, x14, x0
               	and	x0, x0, x15
               	and	x14, x4, x9
               	orr	x0, x0, x14
               	and	x0, x0, #0x1
               	orr	x0, x13, x0
               	cbnz	x12, <addr>
               	ldr	x13, [x7]
               	ldr	x12, [x7, #0x8]
               	cmp	x2, x12
               	cset	x14, lo
               	cmp	x2, x12
               	cset	x12, eq
               	cmp	x0, x13
               	cset	x13, lo
               	and	x12, x12, x13
               	orr	x12, x14, x12
               	eor	x12, x12, #0x1
               	cbz	x12, <addr>
               	ldr	x12, [x7]
               	ldr	x13, [x7, #0x8]
               	cmp	x0, x12
               	cset	x14, lo
               	sub	x0, x0, x12
               	sub	x2, x2, x13
               	sub	x2, x2, x14
               	mov	x12, #0x1               // =1
               	mvn	x13, x9
               	lsl	x14, x12, x6
               	lsr	x11, x12, x11
               	lsr	x11, x11, #1
               	lsl	x6, x5, x6
               	orr	x6, x6, x11
               	and	x11, x14, x13
               	and	x6, x6, x13
               	and	x9, x14, x9
               	orr	x6, x6, x9
               	orr	x8, x8, x11
               	orr	x1, x1, x6
               	sub	x3, x3, #0x1
               	cmp	w3, #0x0
               	b.ge	<addr>
               	str	x0, [x20]
               	str	x2, [x20, #0x8]
               	mov	x0, x8
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	ret

<signed_ok>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	stur	x0, [x29, #-0x90]
               	sub	x0, x29, #0x90
               	str	x1, [x0, #0x8]
               	stur	x2, [x29, #-0x80]
               	sub	x2, x29, #0x80
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x3, hi
               	neg	x1, x1
               	neg	x0, x0
               	sub	x3, x0, x3
               	sub	x0, x29, #0x40
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	ldr	x1, [x2, #0x8]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	ldr	x1, [x2]
               	ldr	x2, [x2, #0x8]
               	cmp	x1, #0x0
               	cset	x3, hi
               	neg	x1, x1
               	neg	x2, x2
               	sub	x3, x2, x3
               	sub	x2, x29, #0x30
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	sub	x4, x29, #0x70
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	sub	x2, x29, #0x60
               	str	x0, [x2]
               	str	x1, [x2, #0x8]
               	sub	x0, x29, #0x90
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	eor	x2, x2, #0x8000000000000000
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x80
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	mvn	x2, x2
               	mvn	x1, x1
               	orr	x1, x2, x1
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
               	sub	x0, x29, #0x50
               	str	x1, [x0, #0x8]
               	ldr	x5, [x0]
               	sub	x0, x29, #0x90
               	ldr	x2, [x0, #0x8]
               	cmp	x2, #0x0
               	cset	x3, lt
               	sub	x2, x29, #0x80
               	ldr	x4, [x2, #0x8]
               	cmp	x4, #0x0
               	cset	x4, lt
               	cmp	w3, w4
               	b.eq	<addr>
               	sub	x3, x29, #0x60
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	cmp	x4, #0x0
               	cset	x6, hi
               	neg	x4, x4
               	neg	x3, x3
               	sub	x6, x3, x6
               	sub	x3, x29, #0x20
               	str	x4, [x3]
               	str	x6, [x3, #0x8]
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	eor	x4, x5, x4
               	eor	x1, x1, x3
               	orr	x3, x4, x1
               	mov	x1, #0x0                // =0
               	cbnz	x3, <addr>
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x50
               	str	x1, [x0, #0x8]
               	ldr	x3, [x0]
               	sub	x0, x29, #0x90
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	sub	x0, x29, #0x70
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x2, #0x0
               	cset	x4, hi
               	neg	x2, x2
               	neg	x0, x0
               	sub	x4, x0, x4
               	sub	x0, x29, #0x10
               	str	x2, [x0]
               	str	x4, [x0, #0x8]
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x3, x2
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, x1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	b	<addr>
               	sub	x3, x29, #0x60
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x150]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x140]
               	add	x29, sp, #0x140
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0xa                // =10
               	sub	x2, x29, #0x10
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
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
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0xa                // =10
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x3, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mvn	x0, x0
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0xfffffffffffffffe
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x1, #0x5                // =5
               	mov	x4, #0x7                // =7
               	sub	x0, x29, #0x20
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	str	xzr, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x5                // =5
               	mov	x4, #0x7                // =7
               	sub	x0, x29, #0x20
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	str	xzr, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0x7
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #-0x2               // =-2
               	mov	x1, #-0x1               // =-1
               	sub	x0, x29, #0x20
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x1, #0x123              // =291
               	mov	x4, #0x456              // =1110
               	sub	x0, x29, #0x20
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mov	x17, #0x456             // =1110
               	eor	x0, x0, x17
               	mov	x17, #0x123             // =291
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x123              // =291
               	mov	x4, #0x456              // =1110
               	sub	x0, x29, #0x20
               	str	x4, [x0]
               	str	x1, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x25, #0x0               // =0
               	mov	x21, x25
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0, x21, lsl #3]
               	sub	x24, x20, #0x1
               	mov	x0, #-0x1               // =-1
               	sub	x22, x29, #0xe0
               	str	x0, [x22]
               	str	x24, [x22, #0x8]
               	sub	x23, x29, #0xd0
               	str	x20, [x23]
               	str	x25, [x23, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x26, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x26, [x0, #0x8]
               	ldr	x27, [x0]
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x27
               	eor	x1, x1, x26
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	sub	x22, x29, #0xe0
               	str	xzr, [x22]
               	str	x24, [x22, #0x8]
               	sub	x23, x29, #0xd0
               	str	x20, [x23]
               	str	xzr, [x23, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x24, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x24, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x26
               	eor	x1, x1, x24
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	lsr	x0, x20, #1
               	mov	x2, #0x3039             // =12345
               	sub	x22, x29, #0xe0
               	str	x2, [x22]
               	str	x0, [x22, #0x8]
               	sub	x23, x29, #0xd0
               	str	x20, [x23]
               	str	xzr, [x23, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x24, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x24, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x26
               	eor	x1, x1, x24
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x1, #0x1                // =1
               	sub	x22, x29, #0xe0
               	str	x1, [x22]
               	str	x20, [x22, #0x8]
               	sub	x23, x29, #0xd0
               	str	x20, [x23]
               	str	xzr, [x23, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x24, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x24, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x26
               	eor	x1, x1, x24
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	sub	x22, x29, #0xe0
               	str	x0, [x22]
               	str	x0, [x22, #0x8]
               	sub	x23, x29, #0xd0
               	str	x20, [x23]
               	str	xzr, [x23, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x26, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x26, [x0, #0x8]
               	ldr	x27, [x0]
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	str	x1, [x24, #0x8]
               	ldr	x0, [x24]
               	eor	x0, x0, x27
               	eor	x1, x1, x26
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x1, #0x3039             // =12345
               	sub	x22, x29, #0xe0
               	str	x1, [x22]
               	str	xzr, [x22, #0x8]
               	sub	x23, x29, #0xd0
               	str	x20, [x23]
               	str	xzr, [x23, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x20, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x22
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	str	x1, [x24, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x26
               	eor	x0, x0, x20
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
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
               	lsr	x8, x8, #1
               	lsl	x2, x3, x2
               	orr	x2, x2, x8
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
               	lsr	x0, x0, #1
               	lsl	x2, x3, x2
               	orr	x2, x2, x0
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
               	sub	x0, x29, #0xe0
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0xd0
               	str	x22, [x2]
               	str	x21, [x2, #0x8]
               	sub	x4, x29, #0xc0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x25, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x25, [x0, #0x8]
               	ldr	x26, [x0]
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x26
               	eor	x1, x1, x25
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	str	x22, [x0]
               	str	x21, [x0, #0x8]
               	sub	x2, x29, #0xd0
               	str	x22, [x2]
               	str	x21, [x2, #0x8]
               	sub	x4, x29, #0xc0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x25, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x25, [x0, #0x8]
               	ldr	x26, [x0]
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x26
               	eor	x1, x1, x25
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	sub	x25, x29, #0xe0
               	str	x0, [x25]
               	str	x0, [x25, #0x8]
               	sub	x26, x29, #0xd0
               	str	x22, [x26]
               	str	x21, [x26, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x25
               	mov	x2, x26
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x21, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x21, [x0, #0x8]
               	ldr	x22, [x0]
               	mov	x0, x25
               	mov	x2, x26
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x22
               	eor	x1, x1, x21
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	sub	x21, x29, #0xe0
               	str	x0, [x21]
               	str	x0, [x21, #0x8]
               	sub	x22, x29, #0xd0
               	str	x20, [x22]
               	str	x24, [x22, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x25, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x25, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x26
               	eor	x1, x1, x25
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x0, #-0x1               // =-1
               	cmp	x0, x20
               	cset	x1, lo
               	sub	x2, x0, x20
               	sub	x0, x0, x24
               	sub	x0, x0, x1
               	sub	x21, x29, #0xe0
               	str	x2, [x21]
               	str	x0, [x21, #0x8]
               	sub	x22, x29, #0xd0
               	str	x20, [x22]
               	str	x24, [x22, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x26, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x26, [x0, #0x8]
               	ldr	x27, [x0]
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x25, x29, #0x20
               	str	x1, [x25, #0x8]
               	ldr	x0, [x25]
               	eor	x0, x0, x27
               	eor	x1, x1, x26
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	add	x0, x20, #0x1
               	cmp	x0, x20
               	cset	x1, lo
               	add	x1, x24, x1
               	sub	x21, x29, #0xe0
               	str	x0, [x21]
               	str	x1, [x21, #0x8]
               	sub	x22, x29, #0xd0
               	str	x20, [x22]
               	str	x24, [x22, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x20, [x0, #0x8]
               	ldr	x24, [x0]
               	mov	x0, x21
               	mov	x2, x22
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	str	x1, [x25, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x24
               	eor	x0, x0, x20
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x2, x29, #0xd0
               	mov	x0, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	add	x23, x23, #0x1
               	cmp	w23, #0x40
               	b.lt	<addr>
               	mov	x1, #-0x1               // =-1
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0xe0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	sub	x2, x29, #0xd0
               	str	xzr, [x2]
               	str	x4, [x2, #0x8]
               	sub	x4, x29, #0xc0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x20, [x0, #0x8]
               	ldr	x21, [x0]
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x21
               	eor	x1, x1, x20
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	mov	x1, #-0x1               // =-1
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	mov	x4, #0x1                // =1
               	sub	x0, x29, #0xe0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	sub	x2, x29, #0xd0
               	str	x4, [x2]
               	str	x3, [x2, #0x8]
               	sub	x4, x29, #0xc0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x20, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x20, [x0, #0x8]
               	ldr	x21, [x0]
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x21
               	eor	x1, x1, x20
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x3, #0x1                // =1
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x40
               	str	x3, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x1, x1, #0x8000000000000000
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #0x1                // =1
               	mov	x4, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x4, [x0, #0x8]
               	str	x3, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x3, [x0, #0x8]
               	str	xzr, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x2                // =2
               	str	x3, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x1, x1, #0xc000000000000000
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #-0x2               // =-2
               	str	x1, [x2]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x1, x1, #0x4000000000000000
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	mov	x3, #-0x1               // =-1
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mvn	x0, x0
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x3, [x0, #0x8]
               	mov	x1, #0x7fffffffffffffff // =9223372036854775807
               	mov	x3, #-0x1               // =-1
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mvn	x0, x0
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	mov	x4, #-0x1               // =-1
               	sub	x0, x29, #0x50
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	xzr, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	mov	x4, #-0x1               // =-1
               	sub	x0, x29, #0x50
               	str	x4, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	xzr, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mvn	x0, x0
               	eor	x1, x1, #0x7fffffffffffffff
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x1, #-0x7               // =-7
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0xfffffffffffffffd
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #-0x7               // =-7
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	str	x1, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	mvn	x0, x0
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	str	xzr, [x0, #0x8]
               	mov	x1, #-0x2               // =-2
               	str	x1, [x2]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0xfffffffffffffffd
               	mvn	x1, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	str	xzr, [x0, #0x8]
               	mov	x1, #-0x2               // =-2
               	str	x1, [x2]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x2, x29, #0x40
               	str	x1, [x2, #0x8]
               	ldr	x0, [x2]
               	eor	x0, x0, #0x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x3, [x0, #0x8]
               	mov	x3, #0x3                // =3
               	str	x3, [x2]
               	str	xzr, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #-0x3               // =-3
               	sub	x2, x29, #0x40
               	str	x1, [x2]
               	mov	x1, #-0x1               // =-1
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x1, #-0x1               // =-1
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x2, x29, #0x40
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #-0x1               // =-1
               	sub	x2, x29, #0x40
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x2, [x0, #0x8]
               	mov	x3, #0x1000000000       // =68719476736
               	sub	x2, x29, #0x40
               	str	xzr, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x2, #-0x8000000000000000 // =-9223372036854775808
               	sub	x0, x29, #0x50
               	str	xzr, [x0]
               	str	x2, [x0, #0x8]
               	mov	x1, #-0x1               // =-1
               	mov	x3, #-0x2               // =-2
               	sub	x2, x29, #0x40
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x22, #0x0               // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
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
               	str	x0, [x1]
               	lsr	x2, x0, #29
               	eor	x0, x0, x2
               	ldr	x2, [x1]
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
               	str	x2, [x1]
               	lsr	x1, x2, #29
               	eor	x8, x2, x1
               	sub	x1, x29, #0x100
               	str	x8, [x1]
               	str	x0, [x1, #0x8]
               	mov	x10, #0xa               // =10
               	cbz	x0, <addr>
               	mov	x4, #0x0                // =0
               	cmp	x0, #0xa
               	b.lo	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x6667             // =26215
               	movk	x2, #0x6666, lsl #16
               	movk	x2, #0x6666, lsl #32
               	movk	x2, #0x6666, lsl #48
               	umulh	x1, x1, x2
               	lsr	x21, x1, #1
               	mov	x17, #0xa               // =10
               	mul	x1, x21, x17
               	sub	x0, x0, x1
               	mov	x3, #0xa0000000         // =2684354560
               	lsr	x1, x8, #1
               	lsr	x1, x1, #3
               	lsl	x0, x0, #60
               	orr	x9, x0, x1
               	lsl	x0, x8, #60
               	lsr	x2, x0, #32
               	mov	w5, w0
               	lsr	x0, x9, #29
               	mov	x1, #0x3334             // =13108
               	movk	x1, #0x3333, lsl #16
               	movk	x1, #0x3333, lsl #32
               	movk	x1, #0x3333, lsl #48
               	umulh	x0, x0, x1
               	msub	x1, x0, x3, x9
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
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
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x20, x0, x1
               	msub	x1, x20, x10, x8
               	mov	x0, #0x0                // =0
               	sub	x23, x29, #0x100
               	mov	x24, #0xa               // =10
               	sub	x2, x29, #0xb0
               	str	x24, [x2]
               	str	xzr, [x2, #0x8]
               	sub	x4, x29, #0xf0
               	mov	x0, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0xa0]
               	sub	x0, x29, #0xa0
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x20, x0
               	eor	x1, x21, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x8, [x23]
               	ldr	x0, [x23, #0x8]
               	cbz	x0, <addr>
               	mov	x4, #0x0                // =0
               	cmp	x0, #0xa
               	b.lo	<addr>
               	lsr	x1, x0, #1
               	mov	x2, #0x6667             // =26215
               	movk	x2, #0x6666, lsl #16
               	movk	x2, #0x6666, lsl #32
               	movk	x2, #0x6666, lsl #48
               	umulh	x1, x1, x2
               	lsr	x9, x1, #1
               	mov	x17, #0xa               // =10
               	mul	x1, x9, x17
               	sub	x0, x0, x1
               	mov	x3, #0xa0000000         // =2684354560
               	lsr	x1, x8, #1
               	lsr	x1, x1, #3
               	lsl	x0, x0, #60
               	orr	x10, x0, x1
               	lsl	x0, x8, #60
               	lsr	x2, x0, #32
               	mov	w5, w0
               	lsr	x0, x10, #29
               	mov	x1, #0x3334             // =13108
               	movk	x1, #0x3333, lsl #16
               	movk	x1, #0x3333, lsl #32
               	movk	x1, #0x3333, lsl #48
               	umulh	x0, x0, x1
               	msub	x1, x0, x3, x10
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x10, #32
               	orr	x1, x1, x2
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
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	msub	x2, x0, x24, x8
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0xf0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x2, x1
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x100
               	ldr	x8, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x10, #0xca07            // =51719
               	movk	x10, #0x3b9a, lsl #16
               	cbz	x0, <addr>
               	mov	x4, #0x0                // =0
               	cmp	x0, x10
               	b.lo	<addr>
               	mov	x1, #0x8fe5             // =36837
               	movk	x1, #0x12a2, lsl #16
               	movk	x1, #0x5f31, lsl #32
               	movk	x1, #0x8970, lsl #48
               	umulh	x1, x0, x1
               	lsr	x21, x1, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x21, x17
               	sub	x0, x0, x1
               	mov	x3, #0x281c             // =10268
               	movk	x3, #0xee6b, lsl #16
               	lsr	x1, x8, #1
               	lsr	x1, x1, #29
               	lsl	x0, x0, #34
               	orr	x9, x0, x1
               	lsl	x0, x8, #34
               	lsr	x2, x0, #32
               	mov	w5, w0
               	lsr	x0, x9, #2
               	mov	x1, #0x47f3             // =18419
               	movk	x1, #0x8951, lsl #16
               	movk	x1, #0x2f98, lsl #32
               	movk	x1, #0x44b8, lsl #48
               	umulh	x0, x0, x1
               	lsr	x0, x0, #28
               	msub	x1, x0, x3, x9
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
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
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x20, x0, x1
               	msub	x1, x20, x10, x8
               	mov	x0, #0x0                // =0
               	sub	x23, x29, #0x100
               	mov	x24, #0xca07            // =51719
               	movk	x24, #0x3b9a, lsl #16
               	sub	x2, x29, #0x90
               	str	x24, [x2]
               	str	xzr, [x2, #0x8]
               	sub	x4, x29, #0xf0
               	mov	x0, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x80]
               	sub	x0, x29, #0x80
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x20, x0
               	eor	x1, x21, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x8, [x23]
               	ldr	x0, [x23, #0x8]
               	cbz	x0, <addr>
               	mov	x4, #0x0                // =0
               	cmp	x0, x24
               	b.lo	<addr>
               	mov	x1, #0x8fe5             // =36837
               	movk	x1, #0x12a2, lsl #16
               	movk	x1, #0x5f31, lsl #32
               	movk	x1, #0x8970, lsl #48
               	umulh	x1, x0, x1
               	lsr	x9, x1, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x9, x17
               	sub	x0, x0, x1
               	mov	x3, #0x281c             // =10268
               	movk	x3, #0xee6b, lsl #16
               	lsr	x1, x8, #1
               	lsr	x1, x1, #29
               	lsl	x0, x0, #34
               	orr	x10, x0, x1
               	lsl	x0, x8, #34
               	lsr	x2, x0, #32
               	mov	w5, w0
               	lsr	x0, x10, #2
               	mov	x1, #0x47f3             // =18419
               	movk	x1, #0x8951, lsl #16
               	movk	x1, #0x2f98, lsl #32
               	movk	x1, #0x44b8, lsl #48
               	umulh	x0, x0, x1
               	lsr	x0, x0, #28
               	msub	x1, x0, x3, x10
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x10, #32
               	orr	x1, x1, x2
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
               	mul	x6, x1, x4
               	lsl	x7, x2, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	msub	x2, x0, x24, x8
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0xf0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x2, x1
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x100
               	ldr	x6, [x0]
               	ldr	x7, [x0, #0x8]
               	mov	x9, #0x3                // =3
               	mov	x8, #0x5                // =5
               	orr	x0, x7, x9
               	cbz	x0, <addr>
               	lsr	x10, x7, #1
               	lsr	x0, x6, #1
               	lsl	x1, x7, #63
               	orr	x0, x0, x1
               	mov	x3, #0xc0000000         // =3221225472
               	lsr	x2, x0, #32
               	mov	w4, w0
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0x2aaa, lsl #48
               	umulh	x0, x10, x0
               	lsr	x0, x0, #29
               	msub	x1, x0, x3, x10
               	lsr	x5, x0, #32
               	cbnz	x5, <addr>
               	lsl	x5, x1, #32
               	orr	x5, x5, x2
               	cmp	x0, x5
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x5, x1, #32
               	cbz	x5, <addr>
               	lsl	x1, x10, #32
               	orr	x1, x1, x2
               	mov	x17, #-0x3fffffffffffffff // =-4611686018427387903
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #30
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	movk	x5, #0x5555, lsl #32
               	movk	x5, #0x5555, lsl #48
               	umulh	x1, x1, x5
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	lsl	x5, x2, #32
               	orr	x5, x5, x4
               	cmp	x1, x5
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #1
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x8
               	mul	x1, x0, x8
               	madd	x2, x0, x9, x2
               	cmp	x6, x1
               	cset	x3, lo
               	sub	x1, x6, x1
               	sub	x2, x7, x2
               	sub	x2, x2, x3
               	cmp	x2, #0x3
               	cset	x3, lo
               	cmp	x2, #0x3
               	cset	x4, eq
               	cmp	x1, #0x5
               	cset	x5, lo
               	and	x4, x4, x5
               	orr	x3, x3, x4
               	eor	x3, x3, #0x1
               	add	x21, x0, x3
               	mov	x4, #0x0                // =0
               	neg	x0, x3
               	and	x3, x8, x0
               	and	x0, x9, x0
               	cmp	x1, x3
               	cset	x5, lo
               	sub	x1, x1, x3
               	sub	x0, x2, x0
               	sub	x0, x0, x5
               	sub	x24, x29, #0x100
               	mov	x23, #0x3               // =3
               	mov	x20, #0x5               // =5
               	sub	x2, x29, #0x70
               	str	x20, [x2]
               	str	x23, [x2, #0x8]
               	sub	x4, x29, #0xf0
               	mov	x0, x24
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x60]
               	sub	x0, x29, #0x60
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x21, x0
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x6, [x24]
               	ldr	x7, [x24, #0x8]
               	orr	x0, x7, x23
               	cbz	x0, <addr>
               	lsr	x8, x7, #1
               	lsr	x0, x6, #1
               	lsl	x1, x7, #63
               	orr	x0, x0, x1
               	mov	x3, #0xc0000000         // =3221225472
               	lsr	x2, x0, #32
               	mov	w4, w0
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0x2aaa, lsl #48
               	umulh	x0, x8, x0
               	lsr	x0, x0, #29
               	msub	x1, x0, x3, x8
               	lsr	x5, x0, #32
               	cbnz	x5, <addr>
               	lsl	x5, x1, #32
               	orr	x5, x5, x2
               	cmp	x0, x5
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x5, x1, #32
               	cbz	x5, <addr>
               	lsl	x1, x8, #32
               	orr	x1, x1, x2
               	mov	x17, #-0x3fffffffffffffff // =-4611686018427387903
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #30
               	mov	x5, #0x5556             // =21846
               	movk	x5, #0x5555, lsl #16
               	movk	x5, #0x5555, lsl #32
               	movk	x5, #0x5555, lsl #48
               	umulh	x1, x1, x5
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	lsl	x5, x2, #32
               	orr	x5, x5, x4
               	cmp	x1, x5
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #1
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x20
               	mul	x1, x0, x20
               	madd	x2, x0, x23, x2
               	cmp	x6, x1
               	cset	x3, lo
               	sub	x1, x6, x1
               	sub	x2, x7, x2
               	sub	x3, x2, x3
               	cmp	x3, #0x3
               	cset	x2, lo
               	cmp	x3, #0x3
               	cset	x4, eq
               	cmp	x1, #0x5
               	cset	x5, lo
               	and	x4, x4, x5
               	orr	x2, x2, x4
               	eor	x4, x2, #0x1
               	add	x2, x0, x4
               	mov	x5, #0x0                // =0
               	neg	x0, x4
               	and	x4, x20, x0
               	and	x0, x23, x0
               	cmp	x1, x4
               	cset	x6, lo
               	sub	x1, x1, x4
               	sub	x0, x3, x0
               	sub	x0, x0, x6
               	sub	x2, x29, #0xf0
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	eor	x1, x1, x3
               	eor	x0, x0, x2
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x100
               	ldr	x8, [x0]
               	ldr	x7, [x0, #0x8]
               	mov	x0, #-0x1               // =-1
               	cbz	x7, <addr>
               	mov	x20, #0x0               // =0
               	cmp	x7, x0
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x7, x17
               	cset	x20, hs
               	mov	x17, #-0x1              // =-1
               	mul	x0, x20, x17
               	sub	x7, x7, x0
               	mov	x3, #0xffffffff         // =4294967295
               	lsr	x2, x8, #32
               	mov	w4, w8
               	mov	x0, #0x1                // =1
               	movk	x0, #0x8000, lsl #16
               	movk	x0, #0x8000, lsl #48
               	umulh	x0, x7, x0
               	lsr	x0, x0, #31
               	msub	x1, x0, x3, x7
               	lsr	x5, x0, #32
               	cbnz	x5, <addr>
               	mul	x5, x0, x3
               	lsl	x6, x1, #32
               	orr	x6, x6, x2
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x5, x1, #32
               	cbz	x5, <addr>
               	lsl	x1, x7, #32
               	orr	x1, x1, x2
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
               	lsl	x6, x2, #32
               	orr	x6, x6, x4
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	lsl	x0, x0, #32
               	orr	x21, x0, x1
               	add	x1, x8, x21
               	mov	x0, #0x0                // =0
               	sub	x23, x29, #0x100
               	mov	x24, #-0x1              // =-1
               	sub	x2, x29, #0x50
               	str	x24, [x2]
               	str	xzr, [x2, #0x8]
               	sub	x4, x29, #0xf0
               	mov	x0, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x21, x0
               	eor	x1, x20, x1
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	ldr	x8, [x23]
               	ldr	x7, [x23, #0x8]
               	cbz	x7, <addr>
               	mov	x9, #0x0                // =0
               	cmp	x7, x24
               	b.lo	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x7, x17
               	cset	x9, hs
               	mov	x17, #-0x1              // =-1
               	mul	x0, x9, x17
               	sub	x7, x7, x0
               	mov	x3, #0xffffffff         // =4294967295
               	lsr	x2, x8, #32
               	mov	w4, w8
               	mov	x0, #0x1                // =1
               	movk	x0, #0x8000, lsl #16
               	movk	x0, #0x8000, lsl #48
               	umulh	x0, x7, x0
               	lsr	x0, x0, #31
               	msub	x1, x0, x3, x7
               	lsr	x5, x0, #32
               	cbnz	x5, <addr>
               	mul	x5, x0, x3
               	lsl	x6, x1, #32
               	orr	x6, x6, x2
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x5, x1, #32
               	cbz	x5, <addr>
               	lsl	x1, x7, #32
               	orr	x1, x1, x2
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
               	lsl	x6, x2, #32
               	orr	x6, x6, x4
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	add	x2, x8, x0
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0xf0
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x2, x1
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x8, x17
               	cset	x0, hs
               	mov	x17, #-0x1              // =-1
               	mul	x1, x0, x17
               	sub	x2, x8, x1
               	mov	x1, #0x0                // =0
               	mov	x9, x1
               	b	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x8, x17
               	cset	x21, hs
               	mov	x17, #-0x1              // =-1
               	mul	x0, x21, x17
               	sub	x1, x8, x0
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	b	<addr>
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0xcccc, lsl #48
               	umulh	x0, x6, x0
               	lsr	x2, x0, #2
               	msub	x1, x2, x20, x6
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	b	<addr>
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0xcccc, lsl #48
               	umulh	x0, x6, x0
               	lsr	x21, x0, #2
               	msub	x1, x21, x8, x6
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	b	<addr>
               	mov	x9, x4
               	b	<addr>
               	mov	x0, #0x8fe5             // =36837
               	movk	x0, #0x12a2, lsl #16
               	movk	x0, #0x5f31, lsl #32
               	movk	x0, #0x8970, lsl #48
               	umulh	x0, x8, x0
               	lsr	x0, x0, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x1, x0, x17
               	sub	x2, x8, x1
               	mov	x1, #0x0                // =0
               	mov	x9, x1
               	b	<addr>
               	mov	x21, x4
               	b	<addr>
               	mov	x0, #0x8fe5             // =36837
               	movk	x0, #0x12a2, lsl #16
               	movk	x0, #0x5f31, lsl #32
               	movk	x0, #0x8970, lsl #48
               	umulh	x0, x8, x0
               	lsr	x20, x0, #29
               	mov	x17, #0xca07            // =51719
               	movk	x17, #0x3b9a, lsl #16
               	mul	x0, x20, x17
               	sub	x1, x8, x0
               	mov	x0, #0x0                // =0
               	mov	x21, x0
               	b	<addr>
               	mov	x9, x4
               	b	<addr>
               	lsr	x0, x8, #1
               	mov	x1, #0x6667             // =26215
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x6666, lsl #48
               	umulh	x0, x0, x1
               	lsr	x0, x0, #1
               	mov	x17, #0xa               // =10
               	mul	x1, x0, x17
               	sub	x2, x8, x1
               	mov	x1, #0x0                // =0
               	mov	x9, x1
               	b	<addr>
               	mov	x21, x4
               	b	<addr>
               	lsr	x0, x8, #1
               	mov	x1, #0x6667             // =26215
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x6666, lsl #48
               	umulh	x0, x0, x1
               	lsr	x20, x0, #1
               	mov	x17, #0xa               // =10
               	mul	x0, x20, x17
               	sub	x1, x8, x0
               	mov	x0, #0x0                // =0
               	mov	x21, x0
               	b	<addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0xc8
               	b.lt	<addr>
               	mov	x24, #0x0               // =0
               	mov	x22, x24
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
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
               	str	x1, [x0]
               	lsr	x2, x1, #29
               	eor	x3, x1, x2
               	ldr	x1, [x0]
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
               	str	x1, [x0]
               	lsr	x2, x1, #29
               	eor	x1, x1, x2
               	sub	x2, x29, #0x100
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0]
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
               	str	x1, [x0]
               	lsr	x3, x1, #29
               	eor	x3, x1, x3
               	ldr	x1, [x0]
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
               	str	x1, [x0]
               	lsr	x4, x1, #29
               	eor	x6, x1, x4
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
               	str	x1, [x0]
               	lsr	x0, x1, #29
               	eor	x0, x1, x0
               	and	x1, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x4, #0x3f               // =63
               	sub	x7, x4, x0
               	lsr	x1, x1, #6
               	neg	x1, x1
               	mvn	x4, x1
               	lsr	x5, x3, x0
               	lsl	x3, x3, x7
               	lsl	x3, x3, #1
               	lsr	x0, x6, x0
               	orr	x0, x0, x3
               	and	x0, x0, x4
               	and	x1, x5, x1
               	orr	x1, x0, x1
               	and	x3, x5, x4
               	sub	x0, x29, #0xf0
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	orr	x1, x1, x3
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	str	x24, [x0, #0x8]
               	sub	x20, x29, #0xe0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x20]
               	sub	x21, x29, #0xd0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x21]
               	sub	x4, x29, #0xc0
               	mov	x0, x20
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x23, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x23, [x0, #0x8]
               	ldr	x25, [x0]
               	mov	x0, x20
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x21, x29, #0x20
               	str	x1, [x21, #0x8]
               	ldr	x0, [x21]
               	eor	x0, x0, x25
               	eor	x1, x1, x23
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x2, x29, #0xd0
               	mov	x0, x20
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x100
               	ldr	x5, [x0]
               	ldr	x1, [x0, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
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
               	str	x0, [x2]
               	lsr	x2, x0, #29
               	eor	x0, x0, x2
               	and	x2, x0, #0x7f
               	and	x0, x0, #0x3f
               	mov	x3, #0x3f               // =63
               	sub	x6, x3, x0
               	lsr	x2, x2, #6
               	neg	x2, x2
               	mvn	x3, x2
               	lsr	x4, x1, x0
               	lsl	x1, x1, x6
               	lsl	x1, x1, #1
               	lsr	x0, x5, x0
               	orr	x0, x0, x1
               	and	x0, x0, x3
               	and	x1, x4, x2
               	orr	x0, x0, x1
               	and	x1, x4, x3
               	sub	x2, x29, #0xf0
               	sub	x20, x29, #0xe0
               	str	x0, [x20]
               	str	x1, [x20, #0x8]
               	sub	x23, x29, #0xd0
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x23]
               	sub	x4, x29, #0xc0
               	mov	x0, x20
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x25, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x25, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x20
               	mov	x2, x23
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	str	x1, [x21, #0x8]
               	sub	x23, x29, #0x20
               	ldr	x0, [x23]
               	ldr	x1, [x23, #0x8]
               	eor	x0, x0, x26
               	eor	x1, x1, x25
               	orr	x0, x0, x1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	sub	x1, x29, #0xf0
               	ldr	x0, [x1]
               	sub	x3, x0, #0x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
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
               	str	x0, [x2]
               	lsr	x2, x0, #29
               	eor	x0, x0, x2
               	ldr	x1, [x1]
               	orr	x1, x1, #0x1
               	sub	x20, x29, #0xe0
               	str	x0, [x20]
               	str	x3, [x20, #0x8]
               	sub	x21, x29, #0xd0
               	str	x1, [x21]
               	str	xzr, [x21, #0x8]
               	sub	x4, x29, #0xc0
               	mov	x0, x20
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	mov	x25, x1
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x30
               	str	x25, [x0, #0x8]
               	ldr	x26, [x0]
               	mov	x0, x20
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	str	x1, [x23, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x26
               	eor	x0, x0, x25
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xe0
               	sub	x2, x29, #0xd0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x2, [x0]
               	sub	x0, x29, #0xc0
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x2, x2, x3
               	eor	x0, x1, x0
               	orr	x0, x2, x0
               	cbnz	x0, <addr>
               	sub	x20, x29, #0x100
               	sub	x21, x29, #0xf0
               	mov	x0, x20
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	ldr	x1, [x20]
               	ldr	x0, [x20, #0x8]
               	lsr	x2, x0, #1
               	lsr	x1, x1, #1
               	lsl	x0, x0, #63
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, hi
               	neg	x3, x0
               	neg	x0, x2
               	sub	x1, x0, x1
               	sub	x0, x29, #0x60
               	str	x3, [x0]
               	str	x1, [x0, #0x8]
               	mov	x2, x21
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	sub	x0, x29, #0x100
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	lsr	x2, x0, #1
               	lsr	x1, x1, #1
               	lsl	x0, x0, #63
               	orr	x1, x1, x0
               	sub	x0, x29, #0x50
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	sub	x1, x29, #0xf0
               	ldr	x2, [x1]
               	ldr	x1, [x1, #0x8]
               	lsr	x3, x1, #1
               	lsr	x2, x2, #1
               	lsl	x1, x1, #63
               	orr	x1, x2, x1
               	cmp	x1, #0x0
               	cset	x2, hi
               	neg	x4, x1
               	neg	x3, x3
               	sub	x2, x3, x2
               	cmp	x4, #0x1
               	cset	x3, lo
               	mvn	x1, x1
               	sub	x3, x2, x3
               	sub	x2, x29, #0x40
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	cbz	w0, <addr>
               	add	x22, x22, #0x1
               	cmp	w22, #0x3e8
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x140]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x150
               	ret
