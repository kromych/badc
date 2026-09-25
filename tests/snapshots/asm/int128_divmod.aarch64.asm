
int128_divmod.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x5, [x0]
               	mov	x11, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	orr	x6, x11, x0
               	mov	x12, #-0x1              // =-1
               	mov	x7, #0x7fffffffffffffff // =9223372036854775807
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x7, x0
               	b.lo	<addr>
               	udiv	x11, x7, x0
               	msub	x2, x11, x0, x7
               	clz	x1, x0
               	lsl	x13, x0, x1
               	lsr	x3, x13, #32
               	mov	w4, w13
               	eor	x0, x1, #0x3f
               	lsr	x0, x7, x0
               	lsl	x2, x2, x1
               	orr	x14, x2, x0
               	lsl	x0, x12, x1
               	lsr	x2, x0, #32
               	mov	w8, w0
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
               	orr	x10, x10, x8
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x9, x2, #32
               	cbz	x9, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	mov	x17, #-0x3333333333333334 // =-3689348814741910324
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #0xcccc            // =52428
               	movk	x17, #0xcccc, lsl #16
               	movk	x17, #0xcccc, lsl #32
               	movk	x17, #0xccc, lsl #48
               	cmp	x11, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x10, [x0]
               	mov	x0, #0x0                // =0
               	cmp	x7, x10
               	b.lo	<addr>
               	udiv	x0, x7, x10
               	msub	x7, x0, x10, x7
               	clz	x0, x10
               	lsl	x11, x10, x0
               	lsr	x3, x11, #32
               	mov	w4, w11
               	eor	x1, x0, #0x3f
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	lsr	x1, x2, x1
               	lsl	x2, x7, x0
               	orr	x13, x2, x1
               	lsl	x0, x12, x0
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
               	msub	x2, x0, x11, x1
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
               	orr	x0, x0, x1
               	msub	x0, x0, x10, x12
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x8, #0x3                // =3
               	mov	x13, #0x1               // =1
               	orr	x0, x5, x13
               	cbz	x0, <addr>
               	lsr	x9, x5, #1
               	lsr	x0, x6, #1
               	lsl	x1, x5, #63
               	orr	x0, x0, x1
               	mov	x3, #0x80000000         // =2147483648
               	lsr	x2, x0, #32
               	mov	w4, w0
               	lsr	x0, x9, #31
               	lsl	x1, x0, #31
               	sub	x1, x9, x1
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x0, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #31
               	lsl	x7, x1, #31
               	sub	x2, x2, x7
               	lsr	x7, x1, #32
               	cbnz	x7, <addr>
               	lsl	x7, x2, #32
               	orr	x7, x7, x4
               	cmp	x1, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x7, x2, #32
               	cbz	x7, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x8
               	mul	x1, x0, x8
               	add	x2, x2, x0
               	cmp	x6, x1
               	cset	x3, lo
               	sub	x1, x6, x1
               	sub	x2, x5, x2
               	sub	x2, x2, x3
               	cmp	x2, #0x1
               	cset	x3, lo
               	cmp	x2, #0x1
               	cset	x4, eq
               	cmp	x1, #0x3
               	cset	x7, lo
               	and	x4, x4, x7
               	orr	x3, x3, x4
               	eor	x3, x3, #0x1
               	add	x0, x0, x3
               	mov	x7, #0x0                // =0
               	neg	x3, x3
               	and	x4, x8, x3
               	and	x9, x13, x3
               	cmp	x1, x4
               	cset	x10, lo
               	sub	x3, x1, x4
               	sub	x1, x2, x9
               	sub	x1, x1, x10
               	mov	x17, #0xeefd            // =61181
               	movk	x17, #0xccdd, lsl #16
               	movk	x17, #0xaabb, lsl #32
               	movk	x17, #0x8899, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	orr	x0, x5, x13
               	cbz	x0, <addr>
               	lsr	x9, x5, #1
               	lsr	x0, x6, #1
               	lsl	x1, x5, #63
               	orr	x0, x0, x1
               	mov	x3, #0x80000000         // =2147483648
               	lsr	x2, x0, #32
               	mov	w4, w0
               	lsr	x0, x9, #31
               	lsl	x1, x0, #31
               	sub	x1, x9, x1
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	lsl	x7, x1, #32
               	orr	x7, x7, x2
               	cmp	x0, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	lsl	x1, x9, #32
               	orr	x1, x1, x2
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #31
               	lsl	x7, x1, #31
               	sub	x2, x2, x7
               	lsr	x7, x1, #32
               	cbnz	x7, <addr>
               	lsl	x7, x2, #32
               	orr	x7, x7, x4
               	cmp	x1, x7
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x7, x2, #32
               	cbz	x7, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x8
               	mul	x1, x0, x8
               	add	x2, x2, x0
               	cmp	x6, x1
               	cset	x3, lo
               	sub	x1, x6, x1
               	sub	x2, x5, x2
               	sub	x3, x2, x3
               	cmp	x3, #0x1
               	cset	x2, lo
               	cmp	x3, #0x1
               	cset	x4, eq
               	cmp	x1, #0x3
               	cset	x7, lo
               	and	x4, x4, x7
               	orr	x2, x2, x4
               	eor	x4, x2, #0x1
               	add	x2, x0, x4
               	mov	x7, #0x0                // =0
               	neg	x0, x4
               	and	x4, x8, x0
               	and	x0, x13, x0
               	cmp	x1, x4
               	cset	x9, lo
               	sub	x1, x1, x4
               	sub	x0, x3, x0
               	sub	x0, x0, x9
               	mov	x17, #0x9980            // =39296
               	movk	x17, #0xddbb, lsl #16
               	movk	x17, #0x21ff, lsl #32
               	movk	x17, #0x6644, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x9, [x0]
               	lsr	x0, x9, #1
               	mov	x3, #0x80000000         // =2147483648
               	lsr	x1, x0, #32
               	mov	w4, w0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	lsr	x7, x2, #32
               	cbnz	x7, <addr>
               	lsl	x7, x0, #32
               	orr	x7, x7, x1
               	cmp	x2, x7
               	b.ls	<addr>
               	sub	x2, x2, #0x1
               	add	x0, x0, x3
               	lsr	x7, x0, #32
               	cbz	x7, <addr>
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x0, x2, x17
               	sub	x1, x1, x0
               	lsr	x0, x1, #31
               	lsl	x7, x0, #31
               	sub	x1, x1, x7
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	lsl	x7, x1, #32
               	orr	x7, x7, x4
               	cmp	x0, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	lsl	x1, x2, #32
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x8
               	mul	x1, x0, x8
               	add	x2, x2, x0
               	cmp	x9, x1
               	cset	x3, lo
               	sub	x4, x9, x1
               	neg	x1, x2
               	sub	x1, x1, x3
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x1, eq
               	cmp	x4, #0x3
               	cset	x3, lo
               	and	x1, x1, x3
               	orr	x1, x2, x1
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x9, [x0]
               	lsr	x0, x9, #1
               	mov	x3, #0x80000000         // =2147483648
               	lsr	x1, x0, #32
               	mov	w4, w0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	lsr	x7, x2, #32
               	cbnz	x7, <addr>
               	lsl	x7, x0, #32
               	orr	x7, x7, x1
               	cmp	x2, x7
               	b.ls	<addr>
               	sub	x2, x2, #0x1
               	add	x0, x0, x3
               	lsr	x7, x0, #32
               	cbz	x7, <addr>
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x0, x2, x17
               	sub	x1, x1, x0
               	lsr	x0, x1, #31
               	lsl	x7, x0, #31
               	sub	x1, x1, x7
               	lsr	x7, x0, #32
               	cbnz	x7, <addr>
               	lsl	x7, x1, #32
               	orr	x7, x7, x4
               	cmp	x0, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x7, x1, #32
               	cbz	x7, <addr>
               	lsl	x1, x2, #32
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x8
               	mul	x1, x0, x8
               	add	x2, x2, x0
               	cmp	x9, x1
               	cset	x3, lo
               	sub	x0, x9, x1
               	neg	x1, x2
               	sub	x1, x1, x3
               	cmp	x1, #0x1
               	cset	x2, lo
               	cmp	x1, #0x1
               	cset	x3, eq
               	cmp	x0, #0x3
               	cset	x4, lo
               	and	x3, x3, x4
               	orr	x2, x2, x3
               	eor	x2, x2, #0x1
               	neg	x2, x2
               	and	x3, x8, x2
               	and	x2, x13, x2
               	cmp	x0, x3
               	cset	x4, lo
               	sub	x0, x0, x3
               	sub	x1, x1, x2
               	sub	x1, x1, x4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	cmp	x0, x2
               	b.ne	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x10, #-0x1              // =-1
               	mov	x3, #0xe0000000         // =3758096384
               	mov	x4, #0x0                // =0
               	mov	x0, #0xdb6d             // =56173
               	movk	x0, #0x6db6, lsl #16
               	mov	x1, #0x607              // =1543
               	movk	x1, #0xa000, lsl #16
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, #0x20000000
               	cmp	x2, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x1, #0x20000000         // =536870912
               	movk	x1, #0x607, lsl #32
               	mov	x17, #-0x2000000000000000 // =-2305843009213693952
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #29
               	mov	x7, #0x2493             // =9363
               	movk	x7, #0x9249, lsl #16
               	movk	x7, #0x4924, lsl #32
               	movk	x7, #0x2492, lsl #48
               	umulh	x1, x1, x7
               	msub	x2, x1, x3, x2
               	lsr	x7, x1, #32
               	cbnz	x7, <addr>
               	mul	x7, x1, x4
               	lsl	x9, x2, #32
               	cmp	x7, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x7, x2, #32
               	cbz	x7, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	mvn	x0, x0
               	cmp	x0, x10
               	cset	x1, lo
               	add	x0, x0, #0x1
               	mov	x2, #-0xb6db            // =-46811
               	movk	x2, #0x2492, lsl #16
               	movk	x2, #0xfff9, lsl #32
               	sub	x1, x2, x1
               	mov	x17, #0x8b66            // =35686
               	movk	x17, #0x4924, lsl #16
               	movk	x17, #0x2492, lsl #32
               	movk	x17, #0x9249, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #-0xb6dc           // =-46812
               	movk	x17, #0x2492, lsl #16
               	movk	x17, #0xfff9, lsl #32
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x10, #-0x1              // =-1
               	mov	x11, #0x3039            // =12345
               	mov	x3, #0xe0000000         // =3758096384
               	mov	x4, #0x0                // =0
               	mov	x0, #0xdb6d             // =56173
               	movk	x0, #0x6db6, lsl #16
               	mov	x1, #0x607              // =1543
               	movk	x1, #0xa000, lsl #16
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	lsl	x7, x1, #32
               	orr	x7, x7, #0x20000000
               	cmp	x2, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x3
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x1, #0x20000000         // =536870912
               	movk	x1, #0x607, lsl #32
               	mov	x17, #-0x2000000000000000 // =-2305843009213693952
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #29
               	mov	x7, #0x2493             // =9363
               	movk	x7, #0x9249, lsl #16
               	movk	x7, #0x4924, lsl #32
               	movk	x7, #0x2492, lsl #48
               	umulh	x1, x1, x7
               	msub	x2, x1, x3, x2
               	lsr	x7, x1, #32
               	cbnz	x7, <addr>
               	mul	x7, x1, x4
               	lsl	x9, x2, #32
               	cmp	x7, x9
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x3
               	lsr	x7, x2, #32
               	cbz	x7, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	sub	x0, x11, x0
               	mvn	x0, x0
               	cmp	x0, x10
               	cset	x1, lo
               	add	x0, x0, #0x1
               	neg	x1, x1
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x3, #0x0                // =0
               	mov	x11, #0x3039            // =12345
               	mov	x12, #0x3000000000      // =206158430208
               	mov	x4, #0x80000000         // =2147483648
               	mov	x0, #0x30               // =48
               	mov	x1, x3
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x3
               	lsl	x7, x1, #32
               	cmp	x2, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x1, x0, x17
               	neg	x2, x1
               	lsr	x1, x2, #31
               	lsl	x7, x1, #31
               	sub	x2, x2, x7
               	mov	x7, #0x181c             // =6172
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	mul	x9, x1, x3
               	lsl	x10, x2, #32
               	orr	x10, x10, x7
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x4
               	lsr	x9, x2, #32
               	cbz	x9, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #6
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x3
               	lsl	x2, x0, #6
               	mul	x4, x0, x3
               	add	x1, x1, x2
               	cmp	x11, x4
               	cset	x2, lo
               	sub	x1, x12, x1
               	sub	x1, x1, x2
               	cmp	x1, #0x40
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	mov	x17, #0xc0000000        // =3221225472
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x12, #0x3039            // =12345
               	mov	x14, #0x3000000000      // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80000000         // =2147483648
               	mov	x0, #0x30               // =48
               	mov	x1, x4
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	lsl	x9, x1, #32
               	cmp	x2, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x1, x0, x17
               	neg	x2, x1
               	lsr	x1, x2, #31
               	lsl	x9, x1, #31
               	sub	x2, x2, x9
               	mov	x9, #0x181c             // =6172
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x4
               	lsl	x11, x2, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x7
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #6
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x4
               	lsl	x2, x0, #6
               	mul	x0, x0, x4
               	add	x1, x1, x2
               	cmp	x12, x0
               	cset	x2, lo
               	sub	x4, x12, x0
               	sub	x0, x14, x1
               	sub	x0, x0, x2
               	cmp	x0, #0x40
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	neg	x1, x1
               	and	x1, x1, #0x40
               	sub	x1, x0, x1
               	mvn	x0, x4
               	mvn	x1, x1
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x2, lo
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	sub	x1, x1, x2
               	mov	x17, #-0x3039           // =-12345
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x12, #0x3039            // =12345
               	mov	x14, #0x3000000000      // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80000000         // =2147483648
               	mov	x0, #0x30               // =48
               	mov	x1, x4
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	lsl	x9, x1, #32
               	cmp	x2, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x1, x0, x17
               	neg	x2, x1
               	lsr	x1, x2, #31
               	lsl	x9, x1, #31
               	sub	x2, x2, x9
               	mov	x9, #0x181c             // =6172
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x4
               	lsl	x11, x2, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x7
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #6
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x4
               	lsl	x2, x0, #6
               	mul	x4, x0, x4
               	add	x1, x1, x2
               	cmp	x12, x4
               	cset	x2, lo
               	sub	x1, x14, x1
               	sub	x1, x1, x2
               	cmp	x1, #0x40
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	mvn	x0, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x1, lo
               	add	x0, x0, #0x1
               	neg	x1, x1
               	mov	x17, #-0x10000          // =-65536
               	movk	x17, #0x4000, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x12, #0x3039            // =12345
               	mov	x14, #0x3000000000      // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80000000         // =2147483648
               	mov	x0, #0x30               // =48
               	mov	x1, x4
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	lsl	x9, x1, #32
               	cmp	x2, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x1, x0, x17
               	neg	x2, x1
               	lsr	x1, x2, #31
               	lsl	x9, x1, #31
               	sub	x2, x2, x9
               	mov	x9, #0x181c             // =6172
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x4
               	lsl	x11, x2, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x7
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #6
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x4
               	lsl	x2, x0, #6
               	mul	x0, x0, x4
               	add	x1, x1, x2
               	cmp	x12, x0
               	cset	x2, lo
               	sub	x4, x12, x0
               	sub	x0, x14, x1
               	sub	x0, x0, x2
               	cmp	x0, #0x40
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	neg	x1, x1
               	and	x1, x1, #0x40
               	sub	x0, x0, x1
               	mov	x17, #0x3039            // =12345
               	cmp	x4, x17
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x12, [x0]
               	cbz	x5, <addr>
               	mov	x14, #0x0               // =0
               	cmp	x5, x12
               	b.lo	<addr>
               	udiv	x14, x5, x12
               	msub	x1, x14, x12, x5
               	clz	x0, x12
               	lsl	x15, x12, x0
               	lsr	x4, x15, #32
               	mov	w7, w15
               	eor	x2, x0, #0x3f
               	lsr	x9, x6, #1
               	lsr	x2, x9, x2
               	lsl	x1, x1, x0
               	orr	x20, x1, x2
               	lsl	x0, x6, x0
               	lsr	x2, x0, #32
               	mov	w9, w0
               	udiv	x0, x20, x4
               	msub	x1, x0, x4, x20
               	lsr	x10, x0, #32
               	cbnz	x10, <addr>
               	mul	x10, x0, x7
               	lsl	x11, x1, #32
               	orr	x11, x11, x2
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x10, x1, #32
               	cbz	x10, <addr>
               	lsl	x1, x20, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x15, x1
               	udiv	x1, x2, x4
               	msub	x2, x1, x4, x2
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x7
               	lsl	x11, x2, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x4
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	msub	x2, x0, x12, x6
               	mov	x1, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x2, [x4]
               	mov	x1, #0x0                // =0
               	mul	x21, x0, x2
               	umulh	x7, x0, x2
               	madd	x0, x0, x1, x7
               	madd	x22, x14, x2, x0
               	ldr	x12, [x4]
               	cbz	x5, <addr>
               	cmp	x5, x12
               	b.lo	<addr>
               	udiv	x14, x5, x12
               	msub	x1, x14, x12, x5
               	clz	x0, x12
               	lsl	x15, x12, x0
               	lsr	x4, x15, #32
               	mov	w7, w15
               	eor	x2, x0, #0x3f
               	lsr	x9, x6, #1
               	lsr	x2, x9, x2
               	lsl	x1, x1, x0
               	orr	x20, x1, x2
               	lsl	x0, x6, x0
               	lsr	x2, x0, #32
               	mov	w9, w0
               	udiv	x0, x20, x4
               	msub	x1, x0, x4, x20
               	lsr	x10, x0, #32
               	cbnz	x10, <addr>
               	mul	x10, x0, x7
               	lsl	x11, x1, #32
               	orr	x11, x11, x2
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x10, x1, #32
               	cbz	x10, <addr>
               	lsl	x1, x20, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x15, x1
               	udiv	x1, x2, x4
               	msub	x2, x1, x4, x2
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x7
               	lsl	x11, x2, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x4
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	msub	x2, x0, x12, x6
               	mov	x1, #0x0                // =0
               	add	x0, x21, x2
               	cmp	x0, x21
               	cset	x1, lo
               	add	x1, x22, x1
               	eor	x0, x6, x0
               	eor	x1, x5, x1
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x12, #0x3039            // =12345
               	mov	x14, #0x3000000000      // =206158430208
               	mov	x4, #0x0                // =0
               	mov	x7, #0x80000000         // =2147483648
               	mov	x0, #0x30               // =48
               	mov	x1, x4
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x4
               	lsl	x9, x1, #32
               	cmp	x2, x9
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x7
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x1, x0, x17
               	neg	x2, x1
               	lsr	x1, x2, #31
               	lsl	x9, x1, #31
               	sub	x2, x2, x9
               	mov	x9, #0x181c             // =6172
               	lsr	x10, x1, #32
               	cbnz	x10, <addr>
               	mul	x10, x1, x4
               	lsl	x11, x2, #32
               	orr	x11, x11, x9
               	cmp	x10, x11
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x7
               	lsr	x10, x2, #32
               	cbz	x10, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #6
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x4
               	lsl	x2, x0, #6
               	mul	x4, x0, x4
               	add	x1, x1, x2
               	cmp	x12, x4
               	cset	x2, lo
               	sub	x1, x14, x1
               	sub	x1, x1, x2
               	cmp	x1, #0x40
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	mul	x11, x0, x3
               	umulh	x1, x0, x3
               	mov	x17, #-0x40             // =-64
               	mul	x0, x0, x17
               	add	x14, x1, x0
               	mov	x12, #0x3039            // =12345
               	mov	x15, #0x3000000000      // =206158430208
               	mov	x3, #0x0                // =0
               	mov	x4, #0x80000000         // =2147483648
               	mov	x0, #0x30               // =48
               	mov	x1, x3
               	lsr	x2, x0, #32
               	cbnz	x2, <addr>
               	mul	x2, x0, x3
               	lsl	x7, x1, #32
               	cmp	x2, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x2, x1, #32
               	cbz	x2, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x1, x0, x17
               	neg	x2, x1
               	lsr	x1, x2, #31
               	lsl	x7, x1, #31
               	sub	x2, x2, x7
               	mov	x7, #0x181c             // =6172
               	lsr	x9, x1, #32
               	cbnz	x9, <addr>
               	mul	x9, x1, x3
               	lsl	x10, x2, #32
               	orr	x10, x10, x7
               	cmp	x9, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x2, x2, x4
               	lsr	x9, x2, #32
               	cbz	x9, <addr>
               	lsl	x0, x0, #32
               	orr	x0, x0, x1
               	lsr	x0, x0, #6
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x3
               	lsl	x2, x0, #6
               	mul	x0, x0, x3
               	add	x1, x1, x2
               	cmp	x12, x0
               	cset	x2, lo
               	sub	x3, x12, x0
               	sub	x0, x15, x1
               	sub	x0, x0, x2
               	cmp	x0, #0x40
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	neg	x1, x1
               	and	x1, x1, #0x40
               	sub	x1, x0, x1
               	mvn	x0, x3
               	mvn	x1, x1
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	cset	x2, lo
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	sub	x1, x1, x2
               	add	x0, x11, x0
               	cmp	x0, x11
               	cset	x2, lo
               	add	x1, x14, x1
               	add	x1, x1, x2
               	mov	x17, #-0x3039           // =-12345
               	eor	x0, x0, x17
               	eor	x1, x1, #0xffffffcfffffffff
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbz	x5, <addr>
               	mov	x9, #0x0                // =0
               	cmp	x5, x0
               	b.lo	<addr>
               	udiv	x9, x5, x0
               	msub	x5, x9, x0, x5
               	clz	x1, x0
               	lsl	x10, x0, x1
               	lsr	x3, x10, #32
               	mov	w4, w10
               	eor	x0, x1, #0x3f
               	lsr	x2, x6, #1
               	lsr	x0, x2, x0
               	lsl	x2, x5, x1
               	orr	x11, x2, x0
               	lsl	x0, x6, x1
               	lsr	x2, x0, #32
               	mov	w5, w0
               	udiv	x0, x11, x3
               	msub	x1, x0, x3, x11
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
               	lsl	x1, x11, #32
               	orr	x1, x1, x2
               	msub	x2, x0, x10, x1
               	udiv	x1, x2, x3
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
               	orr	x6, x0, x1
               	orr	x0, x9, x13
               	cbz	x0, <addr>
               	lsr	x7, x9, #1
               	lsr	x0, x6, #1
               	lsl	x1, x9, #63
               	orr	x0, x0, x1
               	mov	x3, #0x80000000         // =2147483648
               	lsr	x2, x0, #32
               	mov	w4, w0
               	lsr	x0, x7, #31
               	lsl	x1, x0, #31
               	sub	x1, x7, x1
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
               	lsl	x1, x7, #32
               	orr	x1, x1, x2
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	mul	x2, x0, x17
               	sub	x2, x1, x2
               	lsr	x1, x2, #31
               	lsl	x5, x1, #31
               	sub	x2, x2, x5
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
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x2, x0, x8
               	mul	x1, x0, x8
               	add	x2, x2, x0
               	cmp	x6, x1
               	cset	x3, lo
               	sub	x1, x6, x1
               	sub	x2, x9, x2
               	sub	x3, x2, x3
               	cmp	x3, #0x1
               	cset	x2, lo
               	cmp	x3, #0x1
               	cset	x4, eq
               	cmp	x1, #0x3
               	cset	x5, lo
               	and	x4, x4, x5
               	orr	x2, x2, x4
               	eor	x4, x2, #0x1
               	add	x2, x0, x4
               	mov	x5, #0x0                // =0
               	neg	x0, x4
               	and	x4, x8, x0
               	and	x0, x13, x0
               	cmp	x1, x4
               	cset	x6, lo
               	sub	x1, x1, x4
               	sub	x0, x3, x0
               	sub	x0, x0, x6
               	mov	x17, #0x5c28            // =23592
               	movk	x17, #0x962c, lsl #16
               	movk	x17, #0x3699, lsl #32
               	movk	x17, #0xbd6d, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x6, x0
               	lsr	x2, x0, #1
               	msub	x1, x2, x8, x6
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	b	<addr>
               	udiv	x6, x6, x0
               	mov	x9, #0x0                // =0
               	b	<addr>
               	mov	x14, x1
               	mov	x1, x5
               	b	<addr>
               	udiv	x0, x6, x12
               	msub	x2, x0, x12, x6
               	mov	x14, x1
               	b	<addr>
               	mov	x1, x5
               	b	<addr>
               	udiv	x0, x6, x12
               	msub	x2, x0, x12, x6
               	mov	x1, #0x0                // =0
               	mov	x14, x1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
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
               	umulh	x0, x6, x0
               	lsr	x2, x0, #1
               	msub	x1, x2, x8, x6
               	mov	x0, #0x0                // =0
               	mov	x7, x0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0xaaaa, lsl #16
               	movk	x0, #0xaaaa, lsl #32
               	movk	x0, #0xaaaa, lsl #48
               	umulh	x0, x6, x0
               	lsr	x0, x0, #1
               	msub	x3, x0, x8, x6
               	mov	x1, #0x0                // =0
               	mov	x7, x1
               	b	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, x7
               	b	<addr>
