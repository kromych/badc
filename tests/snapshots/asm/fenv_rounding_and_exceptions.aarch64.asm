
fenv_rounding_and_exceptions.aarch64:	file format elf64-littleaarch64

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

<f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	stur	s0, [x29, #-0x8]
               	ldur	w2, [x29, #-0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>

<main>:
               	str	d8, [sp, #-0xb0]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x22, x23, [sp, #0x20]
               	str	x24, [sp, #0x30]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	fmov	d0, #0.25000000
               	fmov	d1, #2.50000000
               	fmov	d2, #-0.25000000
               	adrp	x1, <page>
               	ldr	d3, [x1, #0x20]
               	adrp	x2, <page>
               	ldr	d4, [x2, #0x28]
               	fdiv	d3, d3, d4
               	ldr	d4, [x1, #0x20]
               	fneg	d4, d4
               	ldr	d5, [x2, #0x28]
               	fdiv	d4, d4, d5
               	ldr	d5, [x1, #0x20]
               	ldr	d6, [x2, #0x28]
               	fdiv	d5, d5, d6
               	ldr	d6, [x1, #0x20]
               	ldr	d7, [x2, #0x28]
               	fdiv	d6, d6, d7
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.ge	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, x20, lsl #2]
               	bl	<addr>
               	mov	x21, x0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x23, [x0, x20, lsl #3]
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, x20, lsl #2]
               	cmp	x0, x1
               	cset	x3, eq
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x21, <page>
               	ldr	d0, [x21, #0x20]
               	adrp	x22, <page>
               	ldr	d1, [x22, #0x28]
               	fdiv	d0, d0, d1
               	fmov	x2, d0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x23, #0x1f              // =31
               	mov	x0, x23
               	bl	<addr>
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x24
               	bl	<addr>
               	mov	x0, x23
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	d0, [x21, #0x20]
               	fneg	d0, d0
               	ldr	d1, [x22, #0x28]
               	fdiv	d0, d0, d1
               	fmov	x2, d0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x24
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x21, <page>
               	ldr	d0, [x21, #0x20]
               	mov	x16, #0x3c30000000000000 // =4336966441157787648
               	fmov	d1, x16
               	fadd	d0, d0, d1
               	fmov	x2, d0
               	mov	x0, x22
               	bl	<addr>
               	mov	x22, #0x1f              // =31
               	mov	x0, x22
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x22
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	d0, [x21, #0x20]
               	ldr	d1, [x21, #0x20]
               	fsub	d0, d0, d1
               	fmov	x2, d0
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	mov	x0, x24
               	bl	<addr>
               	mov	x0, x22
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0xf0]
               	ldr	d1, [x0, #0xf0]
               	fneg	d1, d1
               	fadd	d0, d0, d1
               	fmov	x2, d0
               	mov	x0, x24
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x23, <page>
               	ldr	d0, [x23, #0x30]
               	fmov	d8, #2.00000000
               	fmul	d0, d0, d8
               	fmov	x2, d0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	d0, [x23, #0x30]
               	fneg	d0, d0
               	fmul	d0, d0, d8
               	fmov	x2, d0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x30]
               	ldr	d1, [x0, #0x30]
               	mov	x16, #0x3c90000000000000 // =4363988038922010624
               	fmov	d2, x16
               	fmadd	d0, d1, d2, d0
               	fmov	x2, d0
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x22, <page>
               	ldr	d0, [x22, #0x40]
               	fmov	d8, #0.50000000
               	fmul	d0, d0, d8
               	fmov	x2, d0
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	d0, [x22, #0x40]
               	fneg	d0, d0
               	fmul	d0, d0, d8
               	fmov	x2, d0
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x60]
               	ldr	d1, [x0, #0x60]
               	fmul	d0, d0, d1
               	mov	x16, #0x170000000000000 // =103582791429521408
               	fmov	d1, x16
               	fmul	d0, d0, d1
               	fmov	x2, d0
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x38]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x28]
               	fdiv	d0, d0, d1
               	fmov	x2, d0
               	mov	x0, x23
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x58]
               	mov	x16, #0x1               // =1
               	fmov	d1, x16
               	fsub	d0, d0, d1
               	fmov	x2, d0
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x28]
               	fsqrt	d0, d0
               	fmov	x2, d0
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x20]
               	fmov	d1, #3.00000000
               	fdiv	d0, d0, d1
               	adrp	x2, <page>
               	ldr	d1, [x2, #0x28]
               	ldr	d2, [x0, #0x20]
               	fneg	d2, d2
               	fmadd	d0, d0, d1, d2
               	fmov	x2, d0
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x23, #0x1f              // =31
               	mov	x0, x23
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x23
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x58]
               	fmov	d1, #0.12500000
               	adrp	x0, <page>
               	ldr	d2, [x0, #0x40]
               	fmadd	d0, d0, d1, d2
               	fmov	x2, d0
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x22, <page>
               	ldr	s0, [x22, #0x88]
               	adrp	x21, <page>
               	ldr	s1, [x21, #0x8c]
               	fdiv	s0, s0, s1
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	s0, [x1, #0x90]
               	ldr	s1, [x21, #0x8c]
               	fmul	s0, s0, s1
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	s0, [x1, #0x94]
               	ldr	s1, [x21, #0x8c]
               	fdiv	s0, s0, s1
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	s0, [x21, #0x8c]
               	fsqrt	s0, s0
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	s0, [x22, #0x88]
               	adrp	x1, <page>
               	ldr	s1, [x1, #0x8c]
               	fdiv	s0, s0, s1
               	ldr	s1, [x1, #0x8c]
               	ldr	s2, [x22, #0x88]
               	fneg	s2, s2
               	fmadd	s0, s0, s1, s2
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0xb8]
               	scvtf	s0, x1
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x21, <page>
               	ldr	x0, [x21, #0xa8]
               	scvtf	d0, x0
               	fmov	x2, d0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x23, #0x1f              // =31
               	mov	x0, x23
               	bl	<addr>
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x24
               	bl	<addr>
               	mov	x0, x23
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldr	x1, [x21, #0xa8]
               	scvtf	s0, x1
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ucvtf	d0, x0
               	fmov	x2, d0
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x24
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x22, <page>
               	ldr	d0, [x22, #0x68]
               	fcvt	s0, d0
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x30]
               	fcvt	s0, d0
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x38]
               	fcvt	s0, d0
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	d0, [x22, #0x68]
               	fmov	x2, d0
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x24, #0x1f              // =31
               	mov	x0, x24
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldr	d0, [x22, #0x68]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x20]
               	fadd	d0, d0, d1
               	fmov	x2, d0
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x24
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x48]
               	fcvtzs	x2, d0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x70]
               	fcvtzs	x2, d0
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x48]
               	bl	<addr>
               	fmov	x2, d0
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x50]
               	bl	<addr>
               	fmov	x2, d0
               	mov	x0, x22
               	mov	x1, x24
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	adrp	x22, <page>
               	ldr	d0, [x22, #0x50]
               	bl	<addr>
               	fmov	x2, d0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	adrp	x0, <page>
               	ldr	s0, [x0, #0xa0]
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	ldr	d0, [x22, #0x50]
               	bl	<addr>
               	mov	x2, x0
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	mov	x0, x21
               	mov	x1, x24
               	bl	<addr>
               	mov	x22, #0x1f              // =31
               	mov	x0, x22
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x23
               	bl	<addr>
               	mov	x0, x22
               	bl	<addr>
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x48]
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	mov	x21, #0x1f              // =31
               	mov	x0, x21
               	bl	<addr>
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	adrp	x0, <page>
               	ldr	s0, [x0, #0xa0]
               	bl	<addr>
               	mov	x2, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x23
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x78]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x80]
               	fmul	d0, d0, d1
               	fmov	x2, d0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x38]
               	mov	x16, #0x3fefffffffffffff // =4607182418800017407
               	fmov	d1, x16
               	fmul	d0, d0, d1
               	fmov	x2, d0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	s0, [x1, #0x98]
               	adrp	x1, <page>
               	ldr	s1, [x1, #0x9c]
               	fmul	s0, s0, s1
               	bl	<addr>
               	mov	x0, #0x400000           // =4194304
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x400000          // =4194304
               	cmp	x0, x17
               	cset	x2, eq
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x400000          // =4194304
               	cmp	x0, x17
               	cset	x2, eq
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x58
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	sub	x0, x29, #0x58
               	mov	x1, #0x1f               // =31
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x2, eq
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x20, ne
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x2, eq
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7ff0, lsl #48
               	stur	x0, [x29, #-0x58]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x58
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	d0, [x29, #-0x8]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x20]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x50]
               	ldur	d0, [x29, #-0x50]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x8]
               	ldur	d1, [x29, #-0x8]
               	fcmp	d0, d1
               	cset	x0, eq
               	stur	w0, [x29, #-0x48]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x48]
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0xf0]
               	ldr	d1, [x0, #0xf0]
               	fdiv	d0, d0, d1
               	stur	d0, [x29, #-0x40]
               	ldur	d0, [x29, #-0x40]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0x20]
               	fcmpe	d0, d1
               	cset	x0, mi
               	stur	w0, [x29, #-0x38]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x40]
               	fcmp	d0, d1
               	cset	x0, ne
               	stur	w0, [x29, #-0x30]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x38]
               	ldursw	x2, [x29, #-0x30]
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x20]
               	adrp	x0, <page>
               	ldr	d1, [x0, #0xf0]
               	fdiv	d0, d0, d1
               	stur	d0, [x29, #-0x28]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldur	d0, [x29, #-0x28]
               	fmov	x2, d0
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	d0, [x29, #-0x28]
               	ldur	d1, [x29, #-0x28]
               	fsub	d0, d0, d1
               	stur	d0, [x29, #-0x20]
               	ldur	d0, [x29, #-0x20]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x20]
               	fneg	d0, d0
               	fsqrt	d0, d0
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x18]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x0, <page>
               	ldr	d0, [x0, #0x30]
               	fmov	d1, #0.50000000
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	tbz	w0, #0x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	tbz	w0, #0x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	tbz	w0, #0x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	tbz	w0, #0x3, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	tbz	w0, #0x4, <addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	cbz	w0, <addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x0, x7
               	bl	<addr>
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x24, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
