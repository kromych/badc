
fp_const_return.aarch64:	file format elf64-littleaarch64

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

<sum_zero>:
               	mov	x1, #0x8                // =8
               	sub	x2, x1, #0x1
               	ldr	x2, [x0, x2, lsl #3]
               	cbnz	x2, <addr>
               	sub	x1, x1, #0x1
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cbnz	w1, <addr>
               	movi	d0, #0000000000000000
               	ret
               	sub	x1, x1, #0x1
               	ldr	x0, [x0, x1, lsl #3]
               	scvtf	d0, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x1, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	stp	xzr, xzr, [x0, #0x30]
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d0, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	movi	d0, #0000000000000000
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d0, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	fmov	d0, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d0, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	fmov	d0, #0.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d0, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	fmov	s0, #0.25000000
               	fcvt	d0, s0
               	fmov	d1, #0.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x50
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	lsl	x2, x0, #3
               	add	x2, x1, x2
               	ldr	d0, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
