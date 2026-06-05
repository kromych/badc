
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x100
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
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xc
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x18
               	fmov	d16, x0
               	fcvt	s17, d16
               	str	s17, [x1]
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x8]
               	lsl	x1, x1, #4
               	add	x0, x0, x1
               	ldursw	x2, [x29, #-0x10]
               	lsl	x2, x2, #2
               	add	x0, x0, x2
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	adrp	x0, <page>
               	add	x0, x0, #0x210
               	add	x0, x0, x1
               	add	x0, x0, x2
               	ldr	s1, [x0]
               	fcvt	d1, s1
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2d0
               	ldursw	x2, [x29, #-0x8]
               	ldursw	x3, [x29, #-0x10]
               	adrp	x4, <page>
               	add	x4, x4, #0x150
               	lsl	x5, x2, #4
               	add	x4, x4, x5
               	lsl	x6, x3, #2
               	add	x4, x4, x6
               	ldr	s0, [x4]
               	fcvt	d0, s0
               	adrp	x4, <page>
               	add	x4, x4, #0x210
               	add	x4, x4, x5
               	add	x4, x4, x6
               	ldr	s1, [x4]
               	fcvt	d1, s1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0xc
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldr	s0, [x0]
               	fcvt	d0, s0
               	adrp	x1, <page>
               	add	x1, x1, #0x150
               	ldursw	x2, [x29, #-0x8]
               	lsl	x2, x2, #4
               	add	x1, x1, x2
               	ldr	s1, [x1]
               	fcvt	d1, s1
               	add	x2, x1, #0x4
               	ldr	s2, [x2]
               	fcvt	d2, s2
               	fadd	d1, d1, d2
               	add	x1, x1, #0x8
               	ldr	s2, [x1]
               	fcvt	d2, s2
               	fadd	d1, d1, d2
               	fadd	d0, d0, d1
               	fcvt	s17, d0
               	str	s17, [x0]
               	b	<addr>
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2ee
               	sub	x16, x29, #0x18
               	ldr	s0, [x16]
               	fcvt	d0, s0
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
