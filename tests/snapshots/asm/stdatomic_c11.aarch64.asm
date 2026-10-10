
stdatomic_c11.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x40
               	stur	wzr, [x29, #-0x38]
               	sub	x1, x29, #0x38
               	mov	x0, #0x5                // =5
               	str	w0, [x1]
               	ldapr	w2, [x1]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xa                // =10
               	ldaddal	w2, w2, [x1]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x2, [x29, #-0x38]
               	cmp	w2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xf                // =15
               	mov	x3, #0x63               // =99
               	casal	w2, w3, [x1]
               	cmp	w2, #0xf
               	cset	x1, eq
               	cbnz	w1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x38]
               	cmp	w1, #0x63
               	b.eq	<addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	dmb	ish
               	dmb	ishld
               	dmb	ish
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	sub	x1, x29, #0x30
               	fmov	d0, #2.50000000
               	stur	d0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	stlr	x2, [x1]
               	ldapr	x1, [x1]
               	stur	x1, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	fmov	s0, #-1.25000000
               	stur	s0, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	str	w2, [x1]
               	ldar	w2, [x1]
               	stur	w2, [x29, #-0x8]
               	ldur	s1, [x29, #-0x8]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	stur	s0, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	stlr	w2, [x1]
               	ldur	s1, [x29, #-0x28]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	strb	wzr, [x1]
               	mov	x2, #0x1                // =1
               	swpalb	w2, w3, [x1]
               	sxtb	x3, w3
               	cbz	w3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stlrb	w0, [x1]
               	stur	w0, [x29, #-0x18]
               	sub	x1, x29, #0x18
               	mov	x3, #0x2a               // =42
               	stlr	w3, [x1]
               	ldar	w1, [x1]
               	cmp	w1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	x3, #0x64               // =100
               	stlr	x3, [x1]
               	ldaddal	x2, x16, [x1]
               	ldar	x1, [x1]
               	cmp	x1, #0x65
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	w2, [x29, #-0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
