
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
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
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x15, x19
               	ldr	x15, [x15]
               	mov	x14, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x15
               	fmov	d1, x14
               	fcmp	d0, d1
               	cset	x15, ne
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x15, x19
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
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x15, x19
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
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x15, x19
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
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
