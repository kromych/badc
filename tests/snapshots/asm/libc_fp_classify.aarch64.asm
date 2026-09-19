
libc_fp_classify.aarch64:	file format elf64-littleaarch64

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
               	fmov	d1, #3.00000000
               	fmov	d2, #-1.00000000
               	stur	d1, [x29, #-0x10]
               	stur	d2, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	and	x0, x0, #0x7fffffffffffffff
               	ldur	x1, [x29, #-0x8]
               	and	x1, x1, #0x8000000000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x10]
               	fmov	d3, #-3.00000000
               	fcmp	d0, d3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	stur	d3, [x29, #-0x10]
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	and	x0, x0, #0x7fffffffffffffff
               	ldur	x1, [x29, #-0x8]
               	and	x1, x1, #0x8000000000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x10]
               	ldur	d3, [x29, #-0x10]
               	fcmp	d3, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s1, #2.00000000
               	fmov	s3, #-5.00000000
               	fcvt	d1, s1
               	fcvt	d3, s3
               	stur	d1, [x29, #-0x10]
               	stur	d3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	and	x0, x0, #0x7fffffffffffffff
               	ldur	x1, [x29, #-0x8]
               	and	x1, x1, #0x8000000000000000
               	orr	x0, x0, x1
               	stur	x0, [x29, #-0x10]
               	ldur	d1, [x29, #-0x10]
               	fcvt	s1, d1
               	fmov	s3, #-2.00000000
               	fcmp	s1, s3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d2, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	lsr	x0, x0, #63
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	lsr	x0, x0, #63
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d1, x16
               	stur	d1, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	lsr	x0, x0, #63
               	cbnz	w0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	stur	d16, [x29, #-0x10]
               	stur	d0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	w2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fmov	d1, #10.00000000
               	fmul	d0, d0, d1
               	stur	d0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	stur	d0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	and	x2, x2, #0x7ff
               	and	x1, x1, #0xfffffffffffff
               	cbnz	w2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	lsr	x1, x0, #52
               	and	x1, x1, #0x7ff
               	and	x0, x0, #0xfffffffffffff
               	cbnz	w1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
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
