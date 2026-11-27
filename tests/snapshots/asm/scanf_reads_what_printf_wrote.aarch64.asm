
scanf_reads_what_printf_wrote.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x360
               	stp	x20, x21, [sp, #0x60]
               	str	wzr, [sp, #0xd8]
               	str	wzr, [sp, #0xe0]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x140]
               	fmov	d0, #3.25000000
               	add	x16, sp, #0x70
               	fmov	x17, d0
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x148]
               	add	x16, sp, #0x80
               	fmov	x17, d0
               	bl	<addr>
               	fmov	d0, #1.50000000
               	add	x16, sp, #0x90
               	fmov	x17, d0
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x150]
               	add	x16, sp, #0x70
               	bl	<addr>
               	fmov	d2, x16
               	add	x16, sp, #0x80
               	bl	<addr>
               	fmov	d3, x16
               	add	x16, sp, #0x90
               	bl	<addr>
               	fmov	d4, x16
               	sub	x0, x29, #0x2f0
               	add	x16, sp, #0x70
               	fmov	x17, d2
               	bl	<addr>
               	sub	x1, x29, #0x2e0
               	add	x16, sp, #0x80
               	fmov	x17, d3
               	bl	<addr>
               	sub	x2, x29, #0x2d0
               	add	x16, sp, #0x90
               	fmov	x17, d4
               	bl	<addr>
               	mov	x16, #0x2800            // =10240
               	movk	x16, #0xee6b, lsl #16
               	str	x16, [sp]
               	mov	x16, #0xbeef            // =48879
               	movk	x16, #0xdead, lsl #16
               	str	x16, [sp, #0x8]
               	mov	x16, #0x1ed             // =493
               	str	x16, [sp, #0x10]
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x18]
               	mov	x16, #0x71              // =113
               	str	x16, [sp, #0x20]
               	mov	x16, #0x1234            // =4660
               	str	x16, [sp, #0x28]
               	ldr	q2, [x0]
               	ldr	q3, [x1]
               	ldr	q4, [x2]
               	sub	x0, x29, #0x200
               	mov	x1, #0x100              // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #-0x64              // =-100
               	mov	x4, #-0x3039            // =-12345
               	mov	x5, #-0x7fffffff        // =-2147483647
               	mov	x6, #-0x2d2             // =-722
               	movk	x6, #0xb669, lsl #16
               	mov	x7, #0x1                // =1
               	movk	x7, #0x20, lsl #48
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x200
               	bl	<addr>
               	sub	x16, x29, #0x240
               	str	x16, [sp]
               	sub	x16, x29, #0x260
               	str	x16, [sp, #0x8]
               	sub	x16, x29, #0x238
               	str	x16, [sp, #0x10]
               	sub	x16, x29, #0x230
               	str	x16, [sp, #0x18]
               	sub	x16, x29, #0x2c0
               	str	x16, [sp, #0x20]
               	sub	x16, x29, #0x2b0
               	str	x16, [sp, #0x28]
               	sub	x16, x29, #0x2a0
               	str	x16, [sp, #0x30]
               	sub	x16, x29, #0x220
               	str	x16, [sp, #0x38]
               	sub	x16, x29, #0x290
               	str	x16, [sp, #0x40]
               	sub	x16, x29, #0x228
               	str	x16, [sp, #0x48]
               	sub	x16, x29, #0x288
               	str	x16, [sp, #0x50]
               	sub	x0, x29, #0x200
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x278
               	sub	x3, x29, #0x270
               	sub	x4, x29, #0x268
               	sub	x5, x29, #0x258
               	sub	x6, x29, #0x250
               	sub	x7, x29, #0x248
               	bl	<addr>
               	mov	x20, x0
               	ldrsb	x3, [sp, #0xe8]
               	ldrsh	x4, [sp, #0xf0]
               	ldrsw	x5, [sp, #0xf8]
               	ldr	x6, [sp, #0x108]
               	ldr	x7, [sp, #0x110]
               	ldr	w0, [sp, #0x118]
               	ldr	x1, [sp, #0x120]
               	ldrsw	x2, [sp, #0x100]
               	ldr	s0, [sp, #0x128]
               	fcvt	d0, s0
               	ldr	d1, [sp, #0x130]
               	add	x16, sp, #0xa0
               	bl	<addr>
               	fmov	d2, x16
               	add	x16, sp, #0xb0
               	bl	<addr>
               	fmov	d3, x16
               	add	x16, sp, #0xc0
               	bl	<addr>
               	fmov	d4, x16
               	ldrb	w8, [sp, #0xd0]
               	ldr	x9, [sp, #0x138]
               	sub	x10, x29, #0x2f0
               	add	x16, sp, #0x70
               	fmov	x17, d2
               	bl	<addr>
               	sub	x11, x29, #0x2e0
               	add	x16, sp, #0x80
               	fmov	x17, d3
               	bl	<addr>
               	sub	x12, x29, #0x2d0
               	add	x16, sp, #0x90
               	fmov	x17, d4
               	bl	<addr>
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	sub	x16, x29, #0x220
               	str	x16, [sp, #0x18]
               	str	x8, [sp, #0x20]
               	str	x9, [sp, #0x28]
               	ldr	q2, [x10]
               	ldr	q3, [x11]
               	ldr	q4, [x12]
               	sub	x0, x29, #0x100
               	mov	x1, #0x100              // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	ldrsw	x21, [sp, #0xd8]
               	sub	x0, x29, #0x200
               	bl	<addr>
               	cmp	w21, w0
               	cset	x21, eq
               	sub	x0, x29, #0x200
               	sub	x1, x29, #0x100
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sub	x3, x29, #0x100
               	mov	x1, x20
               	mov	x2, x21
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x210
               	sub	x3, x29, #0x290
               	bl	<addr>
               	mov	x1, x0
               	ldrb	w3, [sp, #0xd0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x2, x29, #0x210
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x280
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x280
               	bl	<addr>
               	mov	x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x280
               	bl	<addr>
               	mov	x3, x0
               	mov	x1, x20
               	mov	x2, x21
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x268
               	sub	x3, x29, #0x260
               	sub	x4, x29, #0x280
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x280
               	bl	<addr>
               	mov	x2, x0
               	mov	x1, x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp, #0x60]
               	add	sp, sp, #0x360
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldp	x9, x10, [x16]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	and	x10, x10, #0xffffffffffff
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	orr	x13, x13, x9, lsr #60
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	orr	x10, x10, x9, lsr #49
               	cmp	x12, #0x0
               	cset	x13, ne
               	orr	x10, x10, x13, lsl #63
               	and	x9, x9, #0x1ffffffffffff
               	cmp	x9, #0x0
               	cset	x9, ne
               	cmp	x12, #0x0
               	cset	x13, eq
               	add	x12, x12, x13
               	cbz	x10, <addr>
               	clz	x13, x10
               	lsl	x10, x10, x13
               	sub	x12, x12, x13
               	sub	x12, x12, #0x3, lsl #12 // =0x3000
               	sub	x12, x12, #0xc00
               	mov	x13, #0x7ff             // =2047
               	cmp	x12, x13
               	b.ge	<addr>
               	mov	x13, #0x1               // =1
               	sub	x13, x13, x12
               	bic	x13, x13, x13, asr #63
               	add	x13, x13, #0xa
               	mov	x15, #0x3f              // =63
               	cmp	x13, x15
               	b.gt	<addr>
               	lsr	x14, x10, #1
               	lsr	x14, x14, x13
               	lsr	x15, x10, x13
               	neg	x13, x13
               	lsl	x10, x10, x13
               	cmp	x10, #0x0
               	cset	x10, ne
               	orr	x9, x9, x10
               	and	x10, x14, #0x1
               	orr	x9, x9, x10
               	and	x15, x15, #0x1
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	bic	x12, x10, x10, asr #63
               	add	x14, x14, x12, lsl #52
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	orr	x14, x11, #0x7ff0000000000000
               	b	<addr>
               	mov	x14, x11
               	mov	x16, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	ret
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	mov	x9, x17
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	and	x12, x9, #0xfffffffffffff
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, x11, lsl #48
               	b	<addr>
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, #0x7fff000000000000
               	cbz	x12, <addr>
               	orr	x10, x10, #0x800000000000
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	and	x12, x12, #0xfffffffffffff
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	stp	x9, x10, [x16]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	ret
