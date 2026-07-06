
compound_assign_int_fp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x0, #0xa                // =10
               	scvtf	d0, x0
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	scvtf	d0, x0
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	scvtf	d0, x0
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	x0, #0x19
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	scvtf	d0, x0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	x0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x4039, lsl #16
               	fmov	s16, w0
               	fcvt	d1, s16
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xfff6             // =65526
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	scvtf	d0, x0
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0x2ccc, lsl #32
               	movk	x0, #0x4059, lsl #48
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	x0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	scvtf	d0, x0
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fcvtzs	x0, d0
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	scvtf	d0, x0
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0x4ccc, lsl #32
               	movk	x0, #0x4049, lsl #48
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	fcvtzs	x0, d0
               	sxth	x0, w0
               	cmp	x0, #0x96
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x64               // =100
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	sub	x17, x29, #0x50
               	str	d16, [x17]
               	scvtf	d0, x0
               	mov	x0, #0x1                // =1
               	scvtf	d1, x0
               	sub	x16, x29, #0x50
               	ldr	d2, [x16]
               	fdiv	d1, d1, d2
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x0
               	sub	x17, x29, #0x60
               	str	d16, [x17]
               	mov	x0, #0x3                // =3
               	sub	x16, x29, #0x60
               	ldr	d0, [x16]
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x60
               	str	d0, [x17]
               	sub	x16, x29, #0x60
               	ldr	d0, [x16]
               	mov	x0, #0x2                // =2
               	scvtf	d1, x0
               	fmul	d0, d0, d1
               	sub	x17, x29, #0x60
               	str	d0, [x17]
               	sub	x16, x29, #0x60
               	ldr	d0, [x16]
               	mov	x0, #0x4022000000000000 // =4621256167635550208
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
