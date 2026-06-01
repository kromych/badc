
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
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
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
               	mov	x3, #0x0                // =0
               	sub	x0, x29, #0x18
               	fmov	d0, x3
               	fcvt	s0, d0
               	str	s0, [x0]
               	stur	w3, [x29, #-0x8]
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
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x15, x19
               	ldursw	x14, [x29, #-0x8]
               	lsl	x14, x14, #4
               	add	x15, x15, x14
               	ldursw	x13, [x29, #-0x10]
               	lsl	x13, x13, #2
               	add	x15, x15, x13
               	ldr	s7, [x15]
               	fcvt	d7, s7
               	adrp	x19, <page>
               	add	x19, x19, #0x210
               	mov	x15, x19
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
               	mov	x15, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x2d0
               	mov	x1, x19
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x11, x19
               	lsl	x10, x2, #4
               	add	x11, x11, x10
               	lsl	x9, x3, #2
               	add	x11, x11, x9
               	ldr	s6, [x11]
               	fcvt	d6, s6
               	adrp	x19, <page>
               	add	x19, x19, #0x210
               	mov	x11, x19
               	add	x11, x11, x10
               	add	x11, x11, x9
               	ldr	s7, [x11]
               	fcvt	d7, s7
               	fmov	x16, d6
               	fmov	d0, x16
               	fmov	x16, d7
               	fmov	d1, x16
               	mov	x0, x15
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x3, [x29, #-0x8]
               	cmp	x3, #0xc
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x1
               	str	w3, [x0]
               	b	<addr>
               	sub	x3, x29, #0x18
               	ldr	s7, [x3]
               	fcvt	d7, s7
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x2, x19
               	ldursw	x0, [x29, #-0x8]
               	lsl	x0, x0, #4
               	add	x2, x2, x0
               	ldr	s6, [x2]
               	fcvt	d6, s6
               	add	x0, x2, #0x4
               	ldr	s5, [x0]
               	fcvt	d5, s5
               	fadd	d6, d6, d5
               	add	x2, x2, #0x8
               	ldr	s5, [x2]
               	fcvt	d5, s5
               	fadd	d6, d6, d5
               	fadd	d7, d7, d6
               	fcvt	s0, d7
               	str	s0, [x3]
               	b	<addr>
               	sub	x16, x29, #0x18
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x3, #0x0                // =0
               	fmov	d1, x3
               	fcmp	d7, d1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x2ee
               	mov	x1, x19
               	sub	x16, x29, #0x18
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	x16, d7
               	fmov	d0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
