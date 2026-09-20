
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
               	sub	sp, sp, #0x50
               	stur	wzr, [x29, #-0x40]
               	sub	x1, x29, #0x40
               	mov	x0, #0x5                // =5
               	str	w0, [x1]
               	ldar	w2, [x1]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xa                // =10
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	w16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, w11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x2, x16
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x2, [x29, #-0x40]
               	cmp	w2, #0xf
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0xf                // =15
               	stur	w2, [x29, #-0x38]
               	sub	x2, x29, #0x38
               	mov	x3, #0x63               // =99
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	mov	x11, x3
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x1, x16
               	cbnz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x1, [x29, #-0x40]
               	cmp	w1, #0x63
               	b.eq	<addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	dmb	ish
               	dmb	ishld
               	dmb	ish
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x30]
               	sub	x2, x29, #0x30
               	fmov	d0, #2.50000000
               	sub	x1, x29, #0x48
               	str	d0, [x1]
               	ldr	x3, [x1]
               	stlr	x3, [x2]
               	ldar	x2, [x2]
               	str	x2, [x1]
               	ldr	d1, [x1]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x28
               	fmov	s0, #-1.25000000
               	str	s0, [x1]
               	ldr	w3, [x1]
               	str	w3, [x2]
               	ldar	w3, [x2]
               	str	w3, [x1]
               	ldr	s1, [x1]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #3.00000000
               	str	s0, [x1]
               	ldr	w1, [x1]
               	stlr	w1, [x2]
               	ldur	s1, [x29, #-0x28]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	strb	wzr, [x1]
               	mov	x2, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	sxtb	x3, w3
               	cbz	w3, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
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
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	mov	x3, #0x64               // =100
               	stlr	x3, [x1]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x1
               	mov	x10, x2
               	ldaxr	x16, [x9]
               	add	x11, x16, x10
               	stlxr	w12, x11, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	ldar	x3, [x1]
               	cmp	x3, #0x65
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	w2, [x1, #0x8]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
