
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
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.le	<addr>
               	fmov	d16, x2
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x3, gt
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x3, gt
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbnz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.lt	<addr>
               	mov	x3, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x3
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x3, ge
               	cbz	x3, <addr>
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x3, ge
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbnz	x3, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x2
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.pl	<addr>
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x2, mi
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x2, mi
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.hi	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ls
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ls
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x3ff0000000000000 // =4607182418800017408
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x3
               	fmov	d17, x0
               	fcmp	d16, d17
               	mov	x1, #0x1                // =1
               	b.mi	<addr>
               	fmov	d16, x3
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x3, gt
               	cbz	x3, <addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.mi	<addr>
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x3, gt
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.mi	<addr>
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x3, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x3, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x1, w0
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x1, [x29, #-0x8]
               	lsr	x3, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x3, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	sxtw	x1, w1
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x17, x29, #0x8
               	str	d0, [x17]
               	ldur	x1, [x29, #-0x8]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x8]
               	lsr	x2, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x2, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x2, w0
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x2
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	ldur	x2, [x29, #-0x8]
               	lsr	x3, x2, #52
               	mov	x17, #0x7ff             // =2047
               	and	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x2, x2, x17
               	cbnz	x3, <addr>
               	cbnz	x2, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
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
               	cmp	w3, #0x7ff
               	b.ne	<addr>
               	cbnz	x2, <addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	sxtw	x0, w3
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	w3, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	sxtw	x1, w2
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, x2
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w3, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	sxtw	x0, w1
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
