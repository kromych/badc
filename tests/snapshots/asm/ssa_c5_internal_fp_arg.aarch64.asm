
ssa_c5_internal_fp_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400440 <.text+0x180>
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
               	bl	0x400718 <dlsym>
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
               	bl	0x400408 <.text+0x148>
               	cmp	x0, #0x1
               	b.eq	0x4004d0 <.text+0x210>
               	mov	x0, #0x1                // =1
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
               	bl	0x400408 <.text+0x148>
               	cmp	x0, #0x0
               	b.eq	0x40050c <.text+0x24c>
               	mov	x0, #0x2                // =2
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
               	bl	0x400424 <.text+0x164>
               	cmp	x0, #0x1
               	b.eq	0x400550 <.text+0x290>
               	mov	x0, #0x3                // =3
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
               	bl	0x400424 <.text+0x164>
               	cmp	x0, #0x0
               	b.eq	0x4005a0 <.text+0x2e0>
               	mov	x0, #0x4                // =4
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
               	bl	0x400724 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
