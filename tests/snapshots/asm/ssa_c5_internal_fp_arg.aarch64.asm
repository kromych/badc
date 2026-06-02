
ssa_c5_internal_fp_arg.aarch64:	file format elf64-littleaarch64

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
               	scvtf	d7, x1
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x1, mi
               	mov	x0, x1
               	ret
               	scvtf	d7, x1
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x1, ls
               	mov	x0, x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	sxtw	x15, w0
               	mov	x14, x1
               	add	x14, x15, #0x64
               	sxtw	x14, w14
               	sub	x14, x14, x15
               	sxtw	x14, w14
               	mov	x13, #0x400000000000    // =70368744177664
               	movk	x13, #0x4049, lsl #48
               	sub	x15, x15, x15
               	sxtw	x15, w15
               	scvtf	d7, x15
               	fmov	d0, x13
               	fadd	d6, d0, d7
               	fmov	x16, d6
               	stur	x16, [x29, #-0x10]
               	ldur	x13, [x29, #-0x10]
               	scvtf	d6, x14
               	fmov	d0, x13
               	fcmp	d0, d6
               	cset	x13, mi
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0xd00000000000    // =228698418577408
               	movk	x13, #0x4062, lsl #48
               	scvtf	d6, x14
               	fmov	d0, x13
               	fcmp	d0, d6
               	cset	x13, mi
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d6, x14
               	fmov	x16, d6
               	stur	x16, [x29, #-0x38]
               	ldur	x13, [x29, #-0x38]
               	scvtf	d6, x14
               	fmov	d0, x13
               	fcmp	d0, d6
               	cset	x13, ls
               	cmp	x13, #0x1
               	b.eq	<addr>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d6, x14
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x13
               	fadd	d6, d6, d1
               	fmov	x16, d6
               	stur	x16, [x29, #-0x40]
               	ldur	x13, [x29, #-0x40]
               	scvtf	d6, x14
               	fmov	d0, x13
               	fcmp	d0, d6
               	cset	x13, ls
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
