
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
               	movi	d0, #0000000000000000
               	fdiv	d1, d0, d0
               	fmov	d0, #2.00000000
               	fmov	d2, #1.00000000
               	fcmp	d0, d2
               	b.le	<addr>
               	fcmp	d2, d0
               	b.gt	<addr>
               	fcmp	d1, d2
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d0
               	b.lt	<addr>
               	fmov	d3, #3.00000000
               	fcmp	d3, d0
               	b.lt	<addr>
               	fcmp	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d2, d0
               	b.pl	<addr>
               	fcmp	d0, d2
               	b.mi	<addr>
               	fcmp	d1, d0
               	b.pl	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d0
               	b.hi	<addr>
               	fcmp	d2, d0
               	b.hi	<addr>
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d2, d0
               	b.mi	<addr>
               	fcmp	d2, d0
               	b.le	<addr>
               	fmov	d0, #2.00000000
               	fcmp	d0, d0
               	b.mi	<addr>
               	fcmp	d0, d0
               	b.gt	<addr>
               	fcmp	d1, d0
               	b.mi	<addr>
               	fcmp	d1, d0
               	b.le	<addr>
               	mov	x0, #0x5                // =5
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
               	cbz	w0, <addr>
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbnz	w0, <addr>
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	stur	d1, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbnz	w0, <addr>
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	fmov	d0, #2.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cbnz	w0, <addr>
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
