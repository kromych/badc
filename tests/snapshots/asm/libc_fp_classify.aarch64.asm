
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
               	fmov	d0, #-1.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0x8000000000000000
               	mov	x17, #0x4008000000000000 // =4613937818241073152
               	orr	x0, x0, x17
               	fmov	d0, x0
               	fmov	d1, #-3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0x8000000000000000
               	mov	x17, #0x4008000000000000 // =4613937818241073152
               	orr	x0, x0, x17
               	fmov	d0, x0
               	fmov	d1, #3.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #-5.00000000
               	stur	d0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0x8000000000000000
               	orr	x0, x0, #0x4000000000000000
               	fmov	d0, x0
               	fcvt	s0, d0
               	fmov	s1, #-2.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7f800000        // =2139095040
               	fmov	s0, w16
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	ubfx	x1, x0, #23, #8
               	and	x0, x0, #0x7fffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	ubfx	x1, x0, #23, #8
               	and	x0, x0, #0x7fffff
               	cbnz	w1, <addr>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	w1, #0xff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
               	cmp	w1, #0xff
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	w0, #0x0
               	csel	x0, x2, x1, ne
               	b	<addr>
