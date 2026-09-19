
math_compare_macros.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.le	<addr>
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.gt	<addr>
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.lt	<addr>
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x2
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.lt	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.mi	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.hi	<addr>
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.hi	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.mi	<addr>
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.le	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.mi	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.gt	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	mov	x1, #0x1                // =1
               	b.mi	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x2, x0, #52
               	and	x2, x2, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	x2, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	stur	d16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x2, x0, #52
               	and	x2, x2, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	x2, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x2
               	stur	d16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	fmov	d16, x2
               	stur	d16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x1, w0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x1
               	stur	d16, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	sxtw	x0, w1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, x1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
