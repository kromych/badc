
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
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x0
               	fadd	d0, d16, d17
               	fmov	x16, d0
               	stur	x16, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fsub	d0, d16, d17
               	fmov	x16, d0
               	stur	x16, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x0
               	fmul	d0, d16, d17
               	fmov	x16, d0
               	stur	x16, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	mov	x2, #0x400e000000000000 // =4615626668101337088
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	fmov	x16, d0
               	stur	x16, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	mov	x2, #0x999a             // =39322
               	movk	x2, #0x9999, lsl #16
               	movk	x2, #0x9999, lsl #32
               	movk	x2, #0x3ff9, lsl #48
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x1, ls
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x18]
               	mov	x2, #0x3333             // =13107
               	movk	x2, #0x3333, lsl #16
               	movk	x2, #0x3333, lsl #32
               	movk	x2, #0x3ffb, lsl #48
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	cset	x1, ge
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fneg	d0, d16
               	fmov	x16, d0
               	stur	x16, [x29, #-0x18]
               	ldur	x1, [x29, #-0x18]
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x2
               	fneg	d0, d16
               	fmov	d16, x1
               	fcmp	d16, d0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x18]
               	fmov	d16, x1
               	fneg	d0, d16
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d17, x1
               	fcmp	d0, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, mi
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, gt
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, eq
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x1, ne
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, ls
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	fmov	d16, x1
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, ge
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	scvtf	d0, x0
               	fmov	x16, d0
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	fmov	x16, d0
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	fmov	d16, x0
               	fcvtzs	x0, d16
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	fcvtzs	x0, d0
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3ffb, lsl #48
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	x16, d0
               	stur	x16, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	fmov	d16, x0
               	fcvtzs	x0, d16
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
