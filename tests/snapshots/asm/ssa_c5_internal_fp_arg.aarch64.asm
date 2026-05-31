
ssa_c5_internal_fp_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400448 <.text+0x188>
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
               	bl	0x400748 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	scvtf	d7, x14
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x0, mi
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	scvtf	d7, x14
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x0, ls
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x15, w0
               	mov	x14, x1
               	add	x13, x15, #0x64
               	sxtw	x13, w13
               	sub	x14, x13, x15
               	sxtw	x20, w14
               	mov	x13, #0x400000000000    // =70368744177664
               	movk	x13, #0x4049, lsl #48
               	sub	x12, x15, x15
               	sxtw	x12, w12
               	scvtf	d7, x12
               	fmov	d0, x13
               	fadd	d6, d0, d7
               	fmov	x16, d6
               	stur	x16, [x29, #-0x10]
               	ldur	x21, [x29, #-0x10]
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x400410 <.text+0x150>
               	mov	x12, x0
               	cmp	x12, #0x1
               	b.eq	0x4004e0 <.text+0x220>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0xd00000000000    // =228698418577408
               	movk	x22, #0x4062, lsl #48
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x400410 <.text+0x150>
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	0x400524 <.text+0x264>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d6, x20
               	fmov	x16, d6
               	stur	x16, [x29, #-0x38]
               	ldur	x21, [x29, #-0x38]
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x40042c <.text+0x16c>
               	mov	x12, x0
               	cmp	x12, #0x1
               	b.eq	0x400570 <.text+0x2b0>
               	mov	x12, #0x3               // =3
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d6, x20
               	mov	x21, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x21
               	fadd	d7, d6, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x40]
               	ldur	x22, [x29, #-0x40]
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x40042c <.text+0x16c>
               	mov	x12, x0
               	cmp	x12, #0x0
               	b.eq	0x4005c8 <.text+0x308>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x400754 <printf>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
