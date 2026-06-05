
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
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x110
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x116
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x11d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	sub	x1, x29, #0x8
               	fmov	d16, x0
               	fcvt	s17, d16
               	str	s17, [x1]
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x1, #0x4039000000000000 // =4627730092099895296
               	fmov	d16, x1
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	sub	x1, x29, #0x20
               	fmov	d16, x0
               	fcvt	s17, d16
               	str	s17, [x1]
               	mov	x2, #0x1                // =1
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sub	x16, x29, #0x10
               	ldr	d0, [x16]
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x4039000000000000 // =4627730092099895296
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sub	x16, x29, #0x20
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cbz	x0, <addr>
               	mov	x1, #0x7                // =7
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
