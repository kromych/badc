
two_d_float_array_partial_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	<addr>
               	ldursw	x15, [x29, #-0x8]
               	cmp	x15, #0xc
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x10]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x18
               	fmov	d0, x2
               	fcvt	s0, d0
               	str	s0, [x0]
               	stur	w2, [x29, #-0x8]
               	b	<addr>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x10
               	ldrsw	x15, [x13]
               	add	x15, x15, #0x1
               	str	w15, [x13]
               	b	<addr>
               	adrp	x15, <page>
               	add	x15, x15, #0x150
               	ldursw	x14, [x29, #-0x8]
               	lsl	x14, x14, #4
               	add	x15, x15, x14
               	ldursw	x13, [x29, #-0x10]
               	lsl	x13, x13, #2
               	add	x15, x15, x13
               	ldr	s7, [x15]
               	fcvt	d7, s7
               	adrp	x15, <page>
               	add	x15, x15, #0x210
               	add	x15, x15, x14
               	add	x15, x15, x13
               	ldr	s6, [x15]
               	fcvt	d6, s6
               	fcmp	d7, d6
               	cset	x15, ne
               	cbz	x15, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2d0
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x10]
               	adrp	x11, <page>
               	add	x11, x11, #0x150
               	lsl	x10, x2, #4
               	add	x11, x11, x10
               	lsl	x9, x3, #2
               	add	x11, x11, x9
               	ldr	s6, [x11]
               	fcvt	d6, s6
               	adrp	x11, <page>
               	add	x11, x11, #0x210
               	add	x11, x11, x10
               	add	x11, x11, x9
               	ldr	s7, [x11]
               	fcvt	d7, s7
               	fmov	x16, d6
               	fmov	d0, x16
               	fmov	x16, d7
               	fmov	d1, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	cmp	x2, #0xc
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b	<addr>
               	sub	x2, x29, #0x18
               	ldr	s7, [x2]
               	fcvt	d7, s7
               	adrp	x1, <page>
               	add	x1, x1, #0x150
               	ldursw	x0, [x29, #-0x8]
               	lsl	x0, x0, #4
               	add	x1, x1, x0
               	ldr	s6, [x1]
               	fcvt	d6, s6
               	add	x0, x1, #0x4
               	ldr	s5, [x0]
               	fcvt	d5, s5
               	fadd	d6, d6, d5
               	add	x1, x1, #0x8
               	ldr	s5, [x1]
               	fcvt	d5, s5
               	fadd	d6, d6, d5
               	fadd	d7, d7, d6
               	fcvt	s0, d7
               	str	s0, [x2]
               	b	<addr>
               	sub	x16, x29, #0x18
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x2, #0x0                // =0
               	fmov	d1, x2
               	fcmp	d7, d1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2ee
               	sub	x16, x29, #0x18
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
