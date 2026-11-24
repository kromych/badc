
int128_divmod.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	ldr	x7, [x0, #0x18]
               	mov	x9, #0x0                // =0
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	orr	x8, x9, x0
               	mov	x14, #-0x1              // =-1
               	mov	x6, #0x7fffffffffffffff // =9223372036854775807
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x6, x0
               	b.lo	<addr>
               	udiv	x9, x6, x0
               	msub	x2, x9, x0, x6
               	clz	x1, x0
               	lsl	x12, x0, x1
               	lsr	x3, x12, #32
               	mov	w4, w12
               	eor	x0, x1, #0x3f
               	lsr	x0, x6, x0
               	lsl	x2, x2, x1
               	orr	x13, x2, x0
               	lsl	x0, x14, x1
               	lsr	x5, x0, #32
               	mov	w10, w0
               	udiv	x0, x13, x3
               	msub	x1, x0, x3, x13
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	orr	x11, x5, x1, lsl #32
               	cmp	x2, x11
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x5, x13, lsl #32
               	msub	x2, x0, x12, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	mul	x5, x1, x4
               	orr	x11, x10, x2, lsl #32
               	cmp	x5, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	orr	x0, x1, x0, lsl #32
               	mov	x17, #-0x3333333333333334 // =-3689348814741910324
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x9, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x9, [x0, #0x20]
               	cmp	x6, x9
               	b.lo	<addr>
               	udiv	x17, x6, x9
               	msub	x6, x17, x9, x6
               	clz	x0, x9
               	lsl	x11, x9, x0
               	lsr	x3, x11, #32
               	mov	w4, w11
               	eor	x1, x0, #0x3f
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	lsr	x1, x2, x1
               	lsl	x2, x6, x0
               	orr	x12, x2, x1
               	lsl	x0, x14, x0
               	lsr	x5, x0, #32
               	mov	w6, w0
               	udiv	x0, x12, x3
               	msub	x1, x0, x3, x12
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	orr	x10, x5, x1, lsl #32
               	cmp	x2, x10
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x5, x12, lsl #32
               	msub	x2, x0, x11, x1
               	udiv	x1, x2, x3
               	msub	x2, x1, x3, x2
               	lsr	x5, x1, #32
               	cbnz	x5, <addr>
               	mul	x5, x1, x4
               	orr	x10, x6, x2, lsl #32
               	cmp	x5, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x5, x2, #32
               	cbz	x5, <addr>
               	orr	x0, x1, x0, lsl #32
               	msub	x0, x0, x9, x14
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3                // =3
               	mov	x4, #0x1                // =1
               	orr	x0, x7, x4
               	cbz	x0, <addr>
               	lsr	x9, x7, #1
               	lsr	x0, x8, #1
               	orr	x0, x0, x7, lsl #63
               	mov	x5, #0x80000000         // =2147483648
               	lsr	x6, x0, #32
               	mov	w10, w0
               	lsr	x0, x9, #31
               	sub	x1, x9, x0, lsl #31
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	orr	x2, x6, x1, lsl #32
               	cmp	x0, x2
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x5
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	orr	x1, x6, x9, lsl #32
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #31
               	sub	x2, x2, x1, lsl #31
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	orr	x6, x10, x2, lsl #32
               	cmp	x1, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x5
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x0, x1, x0, lsl #32
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x3
               	mul	x1, x0, x3
               	add	x2, x2, x0
               	cmp	x8, x1
               	cset	x5, lo
               	sub	x6, x8, x1
               	sub	x1, x7, x2
               	sub	x1, x1, x5
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x1, eq
               	cmp	x6, #0x3
               	cset	x5, lo
               	and	x1, x1, x5
               	orr	x1, x2, x1
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	mov	x17, #0xeefd            // =61181
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x0, x7, x4
               	cbz	x0, <addr>
               	lsr	x2, x7, #1
               	lsr	x0, x8, #1
               	orr	x0, x0, x7, lsl #63
               	mov	x5, #0x80000000         // =2147483648
               	lsr	x6, x0, #32
               	mov	w10, w0
               	lsr	x0, x2, #31
               	sub	x1, x2, x0, lsl #31
               	lsr	x9, x0, #32
               	cbnz	x9, <addr>
               	orr	x9, x6, x1, lsl #32
               	cmp	x0, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x5
               	lsr	x9, x1, #32
               	cbz	x9, <addr>
               	orr	x1, x6, x2, lsl #32
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #31
               	sub	x2, x2, x1, lsl #31
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	orr	x6, x10, x2, lsl #32
               	cmp	x1, x6
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x5
               	lsr	x6, x2, #32
               	cbz	x6, <addr>
               	orr	x0, x1, x0, lsl #32
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x3
               	mul	x1, x0, x3
               	add	x2, x2, x0
               	cmp	x8, x1
               	cset	x5, lo
               	sub	x0, x8, x1
               	sub	x1, x7, x2
               	sub	x1, x1, x5
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x5, eq
               	cmp	x0, #0x3
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x2, x2, x5
               	eor	x5, x2, #0x1
               	neg	x2, x5
               	and	x5, x3, x2
               	and	x2, x4, x2
               	cmp	x0, x5
               	cset	x6, lo
               	sub	x0, x0, x5
               	sub	x1, x1, x2
               	sub	x1, x1, x6
               	mov	x17, #0x9980            // =39296
               	movk	x17, #0xddbb, lsl #16
               	movk	x17, #0x21ff, lsl #32
               	movk	x17, #0x6644, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x6, [x0, #0x10]
               	lsr	x0, x6, #1
               	mov	x5, #0x80000000         // =2147483648
               	lsr	x2, x0, #32
               	mov	w10, w0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	orr	x9, x2, x0, lsl #32
               	cmp	x1, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x0, x0, x5
               	lsr	x9, x0, #32
               	cbz	x9, <addr>
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x0, x1, x17
               	sub	x2, x2, x0
               	lsr	x0, x2, #31
               	sub	x2, x2, x0, lsl #31
               	lsr	x9, x0, #32
               	cbnz	x9, <addr>
               	orr	x9, x10, x2, lsl #32
               	cmp	x0, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x2, x2, x5
               	lsr	x9, x2, #32
               	cbz	x9, <addr>
               	orr	x0, x0, x1, lsl #32
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x3
               	mul	x1, x0, x3
               	add	x2, x2, x0
               	cmp	x6, x1
               	cset	x5, lo
               	sub	x6, x6, x1
               	neg	x1, x2
               	sub	x1, x1, x5
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x1, eq
               	cmp	x6, #0x3
               	cset	x5, lo
               	and	x1, x1, x5
               	orr	x1, x2, x1
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x5, [x0, #0x10]
               	lsr	x0, x5, #1
               	mov	x6, #0x80000000         // =2147483648
               	lsr	x2, x0, #32
               	mov	w10, w0
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	orr	x9, x2, x0, lsl #32
               	cmp	x1, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x0, x0, x6
               	lsr	x9, x0, #32
               	cbz	x9, <addr>
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x0, x1, x17
               	sub	x2, x2, x0
               	lsr	x0, x2, #31
               	sub	x2, x2, x0, lsl #31
               	lsr	x9, x0, #32
               	cbnz	x9, <addr>
               	orr	x9, x10, x2, lsl #32
               	cmp	x0, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x2, x2, x6
               	lsr	x9, x2, #32
               	cbz	x9, <addr>
               	orr	x0, x0, x1, lsl #32
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x3
               	mul	x1, x0, x3
               	add	x2, x2, x0
               	cmp	x5, x1
               	cset	x6, lo
               	sub	x0, x5, x1
               	neg	x1, x2
               	sub	x1, x1, x6
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x5, eq
               	cmp	x0, #0x3
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x2, x2, x5
               	eor	x2, x2, #0x1
               	neg	x2, x2
               	and	x5, x3, x2
               	and	x2, x4, x2
               	cmp	x0, x5
               	cset	x6, lo
               	sub	x0, x0, x5
               	sub	x1, x1, x2
               	sub	x2, x1, x6
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x0, x1
               	b.ne	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x7, <addr>
               	mov	x6, #0x0                // =0
               	cmp	x7, x0
               	b.lo	<addr>
               	udiv	x6, x7, x0
               	msub	x9, x6, x0, x7
               	clz	x1, x0
               	lsl	x5, x0, x1
               	lsr	x2, x5, #32
               	mov	w10, w5
               	eor	x0, x1, #0x3f
               	lsr	x11, x8, #1
               	lsr	x0, x11, x0
               	lsl	x9, x9, x1
               	orr	x9, x9, x0
               	lsl	x0, x8, x1
               	lsr	x11, x0, #32
               	mov	w13, w0
               	udiv	x0, x9, x2
               	msub	x1, x0, x2, x9
               	lsr	x12, x0, #32
               	cbnz	x12, <addr>
               	mul	x12, x0, x10
               	orr	x14, x11, x1, lsl #32
               	cmp	x12, x14
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x2
               	lsr	x12, x1, #32
               	cbz	x12, <addr>
               	orr	x1, x11, x9, lsl #32
               	msub	x5, x0, x5, x1
               	udiv	x1, x5, x2
               	msub	x5, x1, x2, x5
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	mul	x9, x1, x10
               	orr	x11, x13, x5, lsl #32
               	cmp	x9, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x5, x5, x2
               	lsr	x9, x5, #32
               	cbz	x9, <addr>
               	orr	x0, x1, x0, lsl #32
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x20]
               	mul	x12, x0, x1
               	umulh	x0, x0, x1
               	madd	x16, x6, x1, x0
               	str	x16, [sp, #0x8]
               	ldr	x5, [x2, #0x20]
               	cbz	x7, <addr>
               	cmp	x7, x5
               	b.lo	<addr>
               	udiv	x17, x7, x5
               	msub	x1, x17, x5, x7
               	clz	x0, x5
               	lsl	x6, x5, x0
               	lsr	x2, x6, #32
               	mov	w10, w6
               	eor	x9, x0, #0x3f
               	lsr	x11, x8, #1
               	lsr	x9, x11, x9
               	lsl	x1, x1, x0
               	orr	x9, x1, x9
               	lsl	x0, x8, x0
               	lsr	x11, x0, #32
               	mov	w14, w0
               	udiv	x0, x9, x2
               	msub	x1, x0, x2, x9
               	lsr	x13, x0, #32
               	cbnz	x13, <addr>
               	mul	x13, x0, x10
               	orr	x15, x11, x1, lsl #32
               	cmp	x13, x15
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x2
               	lsr	x13, x1, #32
               	cbz	x13, <addr>
               	orr	x1, x11, x9, lsl #32
               	msub	x6, x0, x6, x1
               	udiv	x1, x6, x2
               	msub	x6, x1, x2, x6
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	mul	x9, x1, x10
               	orr	x11, x14, x6, lsl #32
               	cmp	x9, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x6, x6, x2
               	lsr	x9, x6, #32
               	cbz	x9, <addr>
               	orr	x1, x1, x0, lsl #32
               	msub	x0, x1, x5, x8
               	add	x0, x12, x0
               	cmp	x0, x12
               	cset	x1, lo
               	ldr	x16, [sp, #0x8]
               	add	x1, x16, x1
               	eor	x0, x8, x0
               	eor	x1, x7, x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cbz	x7, <addr>
               	mov	x2, #0x0                // =0
               	cmp	x7, x0
               	b.lo	<addr>
               	udiv	x2, x7, x0
               	msub	x7, x2, x0, x7
               	clz	x1, x0
               	lsl	x6, x0, x1
               	lsr	x5, x6, #32
               	mov	w9, w6
               	eor	x0, x1, #0x3f
               	lsr	x10, x8, #1
               	lsr	x0, x10, x0
               	lsl	x7, x7, x1
               	orr	x7, x7, x0
               	lsl	x0, x8, x1
               	lsr	x8, x0, #32
               	mov	w10, w0
               	udiv	x0, x7, x5
               	msub	x1, x0, x5, x7
               	lsr	x11, x0, #32
               	cbnz	x11, <addr>
               	mul	x11, x0, x9
               	orr	x12, x8, x1, lsl #32
               	cmp	x11, x12
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x5
               	lsr	x11, x1, #32
               	cbz	x11, <addr>
               	orr	x1, x8, x7, lsl #32
               	msub	x6, x0, x6, x1
               	udiv	x1, x6, x5
               	msub	x6, x1, x5, x6
               	lsr	x7, x1, #32
               	cbnz	x7, <addr>
               	mul	x7, x1, x9
               	orr	x8, x10, x6, lsl #32
               	cmp	x7, x8
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x6, x6, x5
               	lsr	x7, x6, #32
               	cbz	x7, <addr>
               	orr	x5, x1, x0, lsl #32
               	orr	x0, x2, x4
               	cbz	x0, <addr>
               	lsr	x6, x2, #1
               	lsr	x0, x5, #1
               	orr	x0, x0, x2, lsl #63
               	mov	x7, #0x80000000         // =2147483648
               	lsr	x8, x0, #32
               	mov	w9, w0
               	lsr	x0, x6, #31
               	sub	x1, x6, x0, lsl #31
               	lsr	x10, x0, #32
               	cbnz	x10, <addr>
               	orr	x10, x8, x1, lsl #32
               	cmp	x0, x10
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x10, x1, #32
               	cbz	x10, <addr>
               	orr	x1, x8, x6, lsl #32
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x6, x0, x17
               	sub	x6, x1, x6
               	lsr	x1, x6, #31
               	sub	x6, x6, x1, lsl #31
               	lsr	x8, x1, #32
               	cbnz	x8, <addr>
               	orr	x8, x9, x6, lsl #32
               	cmp	x1, x8
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x6, x6, x7
               	lsr	x8, x6, #32
               	cbz	x8, <addr>
               	orr	x0, x1, x0, lsl #32
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x6, x0, x3
               	mul	x1, x0, x3
               	add	x6, x6, x0
               	cmp	x5, x1
               	cset	x7, lo
               	sub	x0, x5, x1
               	sub	x1, x2, x6
               	sub	x1, x1, x7
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x5, eq
               	cmp	x0, #0x3
               	cset	x6, lo
               	and	x5, x5, x6
               	orr	x2, x2, x5
               	eor	x5, x2, #0x1
               	neg	x2, x5
               	and	x3, x3, x2
               	and	x2, x4, x2
               	cmp	x0, x3
               	cset	x4, lo
               	sub	x0, x0, x3
               	sub	x1, x1, x2
               	sub	x1, x1, x4
               	mov	x17, #0x5c28            // =23592
               	movk	x17, #0x962c, lsl #16
               	movk	x17, #0x3699, lsl #32
               	movk	x17, #0xbd6d, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x5, x0
               	lsr	x2, x0, #1
               	msub	x0, x2, x3, x5
               	mov	x1, #0x0                // =0
               	b	<addr>
               	udiv	x5, x8, x0
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, x7
               	b	<addr>
               	udiv	x17, x8, x5
               	msub	x0, x17, x5, x8
               	b	<addr>
               	mov	x9, x7
               	b	<addr>
               	udiv	x0, x8, x0
               	mov	x1, #0x0                // =0
               	mov	x6, x1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x8, x0
               	lsr	x2, x0, #1
               	msub	x0, x2, x3, x8
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x8, x0
               	lsr	x0, x0, #1
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, x6
               	b	<addr>
