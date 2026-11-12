
math_classify.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d1, x16
               	mov	x16, #-0x10000000000000 // =-4503599627370496
               	fmov	d2, x16
               	stur	d0, [x29, #-0x8]
               	fmov	x1, d0
               	ubfx	x1, x1, #52, #11
               	fmov	x2, d0
               	and	x2, x2, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x3, #0x3                // =3
               	cmp	x2, #0x0
               	csel	x1, x3, x1, ne
               	cbz	w1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d3, #1.50000000
               	stur	d3, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	ubfx	x2, x1, #52, #11
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d3, #1.50000000
               	stur	d3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	fmov	x0, d0
               	ubfx	x0, x0, #52, #11
               	fmov	x1, d0
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cbz	w0, <addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x2, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w2, <addr>
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x3, x2, ne
               	cbz	w0, <addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	fmov	x0, d0
               	ubfx	x0, x0, #52, #11
               	fmov	x2, d0
               	and	x2, x2, #0xfffffffffffff
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x1, #0x3                // =3
               	cmp	x2, #0x0
               	csel	x0, x1, x0, ne
               	cbz	w0, <addr>
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	fmov	x0, d0
               	ubfx	x0, x0, #52, #11
               	fmov	x1, d0
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x1, x0, #52, #11
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.50000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	ubfx	x0, x0, #52, #11
               	cbnz	w0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w0, #0x7ff
               	b.eq	<addr>
               	stur	d2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #63
               	cbnz	w0, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x0, x0, #63
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x2, #0x0
               	csel	x0, x1, x0, ne
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	cmp	w0, #0x7ff
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x0, x0, x2, ne
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	cmp	x2, #0x0
               	csel	x1, x0, x1, ne
               	b	<addr>
