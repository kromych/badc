
two_d_float_array_partial_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400408 <.text+0x148>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
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
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400858 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
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
               	b	0x400444 <.text+0x184>
               	ldursw	x15, [x29, #-0x8]
               	cmp	x15, #0xc
               	b.ge	0x400474 <.text+0x1b4>
               	b	0x400468 <.text+0x1a8>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x400444 <.text+0x184>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x10]
               	b	0x400490 <.text+0x1d0>
               	mov	x23, #0x0               // =0
               	sub	x0, x29, #0x18
               	fmov	d0, x23
               	fcvt	s0, d0
               	str	s0, [x0]
               	stur	w23, [x29, #-0x8]
               	b	0x4005d4 <.text+0x314>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x4
               	b.ge	0x40050c <.text+0x24c>
               	b	0x4004b4 <.text+0x1f4>
               	sub	x13, x29, #0x10
               	ldrsw	x14, [x13]
               	add	x15, x14, #0x1
               	str	w15, [x13]
               	b	0x400490 <.text+0x1d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x15, x19
               	ldursw	x14, [x29, #-0x8]
               	lsl	x13, x14, #4
               	add	x14, x15, x13
               	ldursw	x15, [x29, #-0x10]
               	lsl	x12, x15, #2
               	add	x15, x14, x12
               	ldr	s7, [x15]
               	fcvt	d7, s7
               	adrp	x19, 0x410000
               	add	x19, x19, #0x210
               	mov	x15, x19
               	add	x14, x15, x13
               	add	x15, x14, x12
               	ldr	s6, [x15]
               	fcvt	d6, s6
               	fcmp	d7, d6
               	cset	x15, ne
               	cbz	x15, 0x4005d0 <.text+0x310>
               	b	0x400510 <.text+0x250>
               	b	0x400454 <.text+0x194>
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
               	add	x9, x11, x10
               	lsl	x11, x23, #2
               	add	x8, x9, x11
               	ldr	s8, [x8]
               	fcvt	d8, s8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x210
               	mov	x8, x19
               	add	x9, x8, x10
               	add	x8, x9, x11
               	ldr	s9, [x8]
               	fcvt	d9, s9
               	fmov	x16, d8
               	fmov	d0, x16
               	fmov	x16, d9
               	fmov	d1, x16
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x400864 <fprintf>
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
               	b	0x4004a0 <.text+0x1e0>
               	ldursw	x23, [x29, #-0x8]
               	cmp	x23, #0xc
               	b.ge	0x400654 <.text+0x394>
               	b	0x4005f8 <.text+0x338>
               	sub	x23, x29, #0x8
               	ldrsw	x0, [x23]
               	add	x20, x0, #0x1
               	str	w20, [x23]
               	b	0x4005d4 <.text+0x314>
               	sub	x20, x29, #0x18
               	ldr	s9, [x20]
               	fcvt	d9, s9
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	ldursw	x23, [x29, #-0x8]
               	lsl	x22, x23, #4
               	add	x23, x0, x22
               	ldr	s8, [x23]
               	fcvt	d8, s8
               	add	x22, x23, #0x4
               	ldr	s5, [x22]
               	fcvt	d5, s5
               	fadd	d4, d8, d5
               	add	x22, x23, #0x8
               	ldr	s5, [x22]
               	fcvt	d5, s5
               	fadd	d8, d4, d5
               	fadd	d5, d9, d8
               	fcvt	s0, d5
               	str	s0, [x20]
               	b	0x4005e4 <.text+0x324>
               	sub	x16, x29, #0x18
               	ldr	s5, [x16]
               	fcvt	d5, s5
               	mov	x20, #0x0               // =0
               	fmov	d1, x20
               	fcmp	d5, d1
               	cset	x22, ne
               	cbz	x22, 0x4006e8 <.text+0x428>
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x4002d8 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2ee
               	mov	x22, x19
               	sub	x16, x29, #0x18
               	ldr	s10, [x16]
               	fcvt	d10, s10
               	fmov	x16, d10
               	fmov	d0, x16
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x400864 <fprintf>
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
