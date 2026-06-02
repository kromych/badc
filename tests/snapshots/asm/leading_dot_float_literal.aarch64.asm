
leading_dot_float_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x110
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x116
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x11d
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0x3fe0000000000000 // =4602678819172646912
               	sub	x14, x29, #0x8
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x14]
               	mov	x14, #0x3fd0000000000000 // =4598175219545276416
               	mov	x13, #0x4039000000000000 // =4627730092099895296
               	sub	x12, x29, #0x20
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x12]
               	mov	x12, #0x1               // =1
               	stur	w12, [x29, #-0x28]
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x11, ne
               	cbz	x11, <addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x28]
               	b	<addr>
               	mov	x15, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d0, x14
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x14, ne
               	cbz	x14, <addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x28]
               	b	<addr>
               	mov	x15, #0x4039000000000000 // =4627730092099895296
               	fmov	d0, x13
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, <addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x28]
               	b	<addr>
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x13
               	fcmp	d7, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x28]
               	b	<addr>
               	ldursw	x13, [x29, #-0x28]
               	cbz	x13, <addr>
               	mov	x15, #0x7               // =7
               	stur	x15, [x29, #-0x30]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x30]
               	b	<addr>
               	ldur	x0, [x29, #-0x30]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
