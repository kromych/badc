
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
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
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
