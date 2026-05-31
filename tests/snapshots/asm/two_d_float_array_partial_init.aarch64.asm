
two_d_float_array_partial_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40040c <.text+0x14c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400868 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	str	d10, [sp, #0x10]
               	str	x20, [sp, #0x20]
               	str	x21, [sp, #0x28]
               	str	x22, [sp, #0x30]
               	str	x23, [sp, #0x38]
               	str	x24, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	b	0x400448 <.text+0x188>
               	ldursw	x15, [x29, #-0x8]
               	cmp	x15, #0xc
               	b.ge	0x400478 <.text+0x1b8>
               	b	0x40046c <.text+0x1ac>
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400448 <.text+0x188>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x10]
               	b	0x400494 <.text+0x1d4>
               	mov	x23, #0x0               // =0
               	sub	x0, x29, #0x18
               	fmov	d0, x23
               	fcvt	s0, d0
               	str	s0, [x0]
               	stur	w23, [x29, #-0x8]
               	b	0x4005d8 <.text+0x318>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x4
               	b.ge	0x400510 <.text+0x250>
               	b	0x4004b8 <.text+0x1f8>
               	sub	x13, x29, #0x10
               	ldrsw	x15, [x13]
               	add	x15, x15, #0x1
               	str	w15, [x13]
               	b	0x400494 <.text+0x1d4>
               	adrp	x19, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x210
               	mov	x15, x19
               	add	x15, x15, x14
               	add	x15, x15, x13
               	ldr	s6, [x15]
               	fcvt	d6, s6
               	fcmp	d7, d6
               	cset	x15, ne
               	cbz	x15, 0x4005d4 <.text+0x314>
               	b	0x400514 <.text+0x254>
               	b	0x400458 <.text+0x198>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x4002d8 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d0
               	mov	x22, x19
               	ldursw	x20, [x29, #-0x8]
               	ldursw	x23, [x29, #-0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x11, x19
               	lsl	x10, x20, #4
               	add	x11, x11, x10
               	lsl	x9, x23, #2
               	add	x11, x11, x9
               	ldr	s8, [x11]
               	fcvt	d8, s8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x210
               	mov	x11, x19
               	add	x11, x11, x10
               	add	x11, x11, x9
               	ldr	s9, [x11]
               	fcvt	d9, s9
               	fmov	x16, d8
               	fmov	d0, x16
               	fmov	x16, d9
               	fmov	d1, x16
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x400874 <fprintf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	x23, [sp, #0x38]
               	ldr	x24, [sp, #0x40]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4004a4 <.text+0x1e4>
               	ldursw	x23, [x29, #-0x8]
               	cmp	x23, #0xc
               	b.ge	0x400658 <.text+0x398>
               	b	0x4005fc <.text+0x33c>
               	sub	x0, x29, #0x8
               	ldrsw	x23, [x0]
               	add	x23, x23, #0x1
               	str	w23, [x0]
               	b	0x4005d8 <.text+0x318>
               	sub	x23, x29, #0x18
               	ldr	s9, [x23]
               	fcvt	d9, s9
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldursw	x0, [x29, #-0x8]
               	lsl	x0, x0, #4
               	add	x20, x20, x0
               	ldr	s8, [x20]
               	fcvt	d8, s8
               	add	x0, x20, #0x4
               	ldr	s5, [x0]
               	fcvt	d5, s5
               	fadd	d8, d8, d5
               	add	x20, x20, #0x8
               	ldr	s5, [x20]
               	fcvt	d5, s5
               	fadd	d8, d8, d5
               	fadd	d9, d9, d8
               	fcvt	s0, d9
               	str	s0, [x23]
               	b	0x4005e8 <.text+0x328>
               	sub	x16, x29, #0x18
               	ldr	s9, [x16]
               	fcvt	d9, s9
               	mov	x23, #0x0               // =0
               	fmov	d1, x23
               	fcmp	d9, d1
               	cset	x20, ne
               	cbz	x20, 0x4006ec <.text+0x42c>
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x4002d8 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2ee
               	mov	x20, x19
               	sub	x16, x29, #0x18
               	ldr	s10, [x16]
               	fcvt	d10, s10
               	fmov	x16, d10
               	fmov	d0, x16
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x400874 <fprintf>
               	sxtw	x0, w0
               	mov	x0, x24
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	x23, [sp, #0x38]
               	ldr	x24, [sp, #0x40]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x20]
               	ldr	x21, [sp, #0x28]
               	ldr	x22, [sp, #0x30]
               	ldr	x23, [sp, #0x38]
               	ldr	x24, [sp, #0x40]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	d10, [sp, #0x10]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
