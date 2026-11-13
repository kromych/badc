
register_aggregates_with_unions.aarch64:	file format elf64-littleaarch64

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

<make_int>:
               	mov	w0, w0
               	mov	x17, #0x5a00000000      // =386547056640
               	orr	x0, x0, x17
               	ret

<make_double>:
               	mov	x1, #0x7                // =7
               	fmov	x0, d0
               	ret

<step>:
               	cmp	x1, #0x7
               	b.ne	<addr>
               	fmov	d0, x0
               	fmov	d1, #2.00000000
               	sxtw	x0, w2
               	scvtf	d2, x0
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	eor	x1, x1, x3
               	ret
               	sxtw	x2, w2
               	add	x0, x0, x2
               	b	<addr>

<swap_fi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x4]
               	scvtf	s0, x0
               	stur	s0, [x29, #-0x10]
               	ldur	s0, [x29, #-0x8]
               	fcvtzs	x0, s0
               	stur	w0, [x29, #-0xc]
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<bump>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	sturh	w1, [x29, #-0x8]
               	lsr	x0, x1, #16
               	sturh	w0, [x29, #-0x6]
               	ldurb	w0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sturb	w0, [x29, #-0x10]
               	ldur	s0, [x29, #-0xc]
               	fmov	s1, #2.00000000
               	fmul	s0, s0, s1
               	stur	s0, [x29, #-0xc]
               	sxth	x0, w1
               	sub	x0, x0, #0x3
               	sturh	w0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x10]
               	ldurh	w1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<mix>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x3, x29, #0x10
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x20
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	cbz	w2, <addr>
               	ldur	s0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0xc]
               	scvtf	s1, x0
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x20]
               	ldur	x0, [x29, #-0x8]
               	add	x1, x0, x0, lsl #1
               	stur	x1, [x29, #-0x18]
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0xc]
               	add	x0, x0, x1
               	stur	w0, [x29, #-0x20]
               	b	<addr>

<through>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, #0x0                // =0
               	adrp	x2, <page>
               	b	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, w1
               	b.ge	<addr>
               	sub	x4, x29, #0x10
               	sub	x0, x0, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x4]
               	ldur	x4, [x29, #-0x8]
               	cmp	x4, #0x7
               	b.ne	<addr>
               	ldrsw	x4, [x2, #0x20]
               	ldur	d0, [x29, #-0x10]
               	fcvtzs	x5, d0
               	add	x4, x4, x5
               	str	w4, [x2, #0x20]
               	b	<addr>
               	ldrsw	x4, [x2, #0x20]
               	ldursw	x5, [x29, #-0x10]
               	add	x4, x4, x5
               	str	w4, [x2, #0x20]
               	b	<addr>
               	sub	x1, x29, #0x10
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldr	x2, [x0]
               	ldr	x1, [x0, #0x8]
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x0, #-0x5               // =-5
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldursw	x0, [x29, #-0x60]
               	cmn	w0, #0x5
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x5c]
               	cmp	w0, #0x5a
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #1.25000000
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	ldur	d0, [x29, #-0x50]
               	fmov	d1, #1.25000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x48]
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x60
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0x50]
               	fmov	d1, #-2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x8
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x10               // =16
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x18
               	cmp	x0, x3
               	b.ne	<addr>
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x2]
               	mov	x0, x2
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x48
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x48]
               	fmov	s1, #9.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0x44]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	w1, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x1, #0x8]
               	ldurb	w1, [x29, #-0x50]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x4c]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursh	x1, [x29, #-0x48]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x2, #0x1                // =1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	s0, [x29, #-0x50]
               	fmov	s1, #2.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x4c]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x48]
               	cmp	x1, #0xf
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	mov	x2, #0x0                // =0
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	ldur	w0, [x29, #-0x10]
               	cmp	w0, #0x2a
               	b.ne	<addr>
               	cmn	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x50
               	stur	x1, [x29, #-0x48]
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	fmov	d0, #2.00000000
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x50
               	stur	x1, [x29, #-0x48]
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x3                // =3
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x50
               	stur	x1, [x29, #-0x48]
               	sub	x1, x29, #0x40
               	add	x1, x1, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	mov	x0, #0x4                // =4
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x2, x29, #0x50
               	stur	x1, [x29, #-0x48]
               	sub	x0, x29, #0x40
               	add	x1, x0, #0x30
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	add	x0, x0, #0x40
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x50
               	stur	x1, [x29, #-0x48]
               	sub	x1, x29, #0x60
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldursw	x0, [x29, #-0x60]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x58]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	ldr	x16, [x1]
               	str	x16, [x0]
               	fmov	d0, #2.00000000
               	stur	d0, [x29, #-0x58]
               	sub	x1, x29, #0x48
               	sub	x2, x29, #0x58
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldurb	w2, [x29, #-0x58]
               	add	x2, x2, #0x1
               	sturb	w2, [x29, #-0x48]
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
