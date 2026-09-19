
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
               	fmov	d1, #1.00000000
               	fmov	d17, x0
               	fdiv	d1, d1, d17
               	fmov	d2, #-1.00000000
               	fmov	d17, x0
               	fdiv	d2, d2, d17
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	cbz	w1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d3, #1.50000000
               	stur	d3, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d3, #1.50000000
               	stur	d3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x2
               	b.ge	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	stur	d16, [x29, #-0x8]
               	stur	d1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	cmp	w1, #0x2
               	b.lt	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	cmp	w1, #0x2
               	b.lt	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.50000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
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
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
