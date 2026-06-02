
negative_float_in_array_init.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
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
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
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
               	sub	sp, sp, #0x10
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldr	x15, [x15]
               	mov	x14, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	mov	x0, #0x94000000         // =2483027968
               	movk	x0, #0x449a, lsl #32
               	movk	x0, #0x421e, lsl #48
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x148
               	ldr	x0, [x15]
               	add	x13, x15, #0x8
               	ldr	x13, [x13]
               	fmov	d0, x0
               	fmov	d1, x13
               	fadd	d7, d0, d1
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	fmov	d1, x15
               	fadd	d7, d7, d1
               	fmov	x16, d7
               	stur	x16, [x29, #-0x8]
               	ldur	x15, [x29, #-0x8]
               	mov	x13, #0x94000000        // =2483027968
               	movk	x13, #0x449a, lsl #32
               	movk	x13, #0x421e, lsl #48
               	fmov	d0, x13
               	fneg	d7, d0
               	mov	x13, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x13
               	fadd	d7, d7, d1
               	fmov	d0, x15
               	fcmp	d0, d7
               	cset	x15, gt
               	stur	x15, [x29, #-0x10]
               	cbnz	x15, <addr>
               	ldur	x13, [x29, #-0x8]
               	mov	x15, #0x94000000        // =2483027968
               	movk	x15, #0x449a, lsl #32
               	movk	x15, #0x421e, lsl #48
               	fmov	d0, x15
               	fneg	d7, d0
               	mov	x15, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x15
               	fsub	d7, d7, d1
               	fmov	d0, x13
               	fcmp	d0, d7
               	cset	x13, mi
               	stur	x13, [x29, #-0x10]
               	b	<addr>
               	ldur	x13, [x29, #-0x10]
               	cbz	x13, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
