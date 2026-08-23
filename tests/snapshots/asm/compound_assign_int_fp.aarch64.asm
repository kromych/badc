
compound_assign_int_fp.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0xa                // =10
               	scvtf	d0, x0
               	mov	x1, #0x3333             // =13107
               	movk	x1, #0x3333, lsl #16
               	movk	x1, #0x3333, lsl #32
               	movk	x1, #0x400f, lsl #48
               	fmov	d17, x1
               	fadd	d1, d0, d17
               	fcvtzs	x1, d1
               	cmp	x1, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x1
               	fsub	d1, d0, d17
               	fcvtzs	x2, d1
               	cmp	x2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d17, x1
               	fmul	d0, d0, d17
               	fcvtzs	x1, d0
               	cmp	x1, #0x19
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x64               // =100
               	scvtf	d0, x1
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x2
               	fdiv	d1, d0, d17
               	fcvtzs	x3, d1
               	cmp	x3, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x7                // =7
               	scvtf	d1, x3
               	mov	x4, #0x999a             // =39322
               	movk	x4, #0x4039, lsl #16
               	fmov	s16, w4
               	fcvt	d2, s16
               	fadd	d1, d1, d2
               	fcvtzs	x4, d1
               	cmp	w4, #0x9
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0xfff6             // =65526
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	scvtf	d1, x4
               	mov	x4, #0xcccd             // =52429
               	movk	x4, #0xcccc, lsl #16
               	movk	x4, #0x2ccc, lsl #32
               	movk	x4, #0x4059, lsl #48
               	fmov	d17, x4
               	fadd	d1, d1, d17
               	fcvtzs	x4, d1
               	cmp	x4, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, #0x5                // =5
               	scvtf	d1, x4
               	mov	x4, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x4
               	fmul	d1, d1, d17
               	fcvtzs	x4, d1
               	cmp	x4, #0x11
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0xcccd             // =52429
               	movk	x3, #0xcccc, lsl #16
               	movk	x3, #0x4ccc, lsl #32
               	movk	x3, #0x4049, lsl #48
               	fmov	d17, x3
               	fadd	d1, d0, d17
               	fcvtzs	x3, d1
               	sxth	x3, w3
               	cmp	w3, #0x96
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x2
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fmov	d16, x1
               	fdiv	d1, d16, d1
               	fadd	d0, d0, d1
               	fcvtzs	x1, d0
               	cmp	x1, #0x64
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x1, #0x3                // =3
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	scvtf	d1, x1
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmul	d0, d0, d17
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x1, #0x4022000000000000 // =4621256167635550208
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
