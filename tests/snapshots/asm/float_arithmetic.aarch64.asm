
float_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x3ff8000000000000 // =4609434218613702656
               	stur	x15, [x29, #-0x8]
               	mov	x14, #0x4004000000000000 // =4612811918334230528
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x15
               	fmov	d1, x14
               	fadd	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x13, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x15
               	fmov	d1, x13
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x14
               	fmov	d1, x15
               	fsub	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x15
               	fmov	d1, x14
               	fmul	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x400e000000000000 // =4615626668101337088
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x14
               	fmov	d1, x15
               	fdiv	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3ff9, lsl #48
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, ls
               	cbz	x15, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3ffb, lsl #48
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, ge
               	cbz	x15, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x8]
               	fmov	d0, x15
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x18]
               	ldur	x15, [x29, #-0x18]
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x15, [x29, #-0x18]
               	fmov	d0, x15
               	fneg	d7, d0
               	mov	x15, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x15, #0x7               // =7
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, mi
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x0, eq
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x0, ls
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ge
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	scvtf	d7, x0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x14, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x0
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x14, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x0
               	fmov	d1, x14
               	fadd	d7, d0, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x14, [x29, #-0x8]
               	fmov	d0, x14
               	fcvtzs	x14, d0
               	sxtw	x14, w14
               	cmp	x14, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x14, [x29, #-0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x14
               	fmov	d1, x0
               	fadd	d7, d0, d1
               	fcvtzs	x0, d7
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x14, #0x10              // =16
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3ffb, lsl #48
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	fmov	d0, x0
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x14, #0x11              // =17
               	mov	x0, x14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
