
negative_float_in_array_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003c8 <.text+0x148>
               	adrp	x16, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4006c8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x15, x19
               	ldr	x14, [x15]
               	mov	x15, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x14
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x13, ne
               	cbz	x13, 0x400414 <.text+0x194>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x13, x19
               	add	x0, x13, #0x8
               	ldr	x13, [x0]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x0
               	fneg	d7, d0
               	fmov	d0, x13
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, 0x40045c <.text+0x1dc>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x0, x19
               	add	x13, x0, #0x10
               	ldr	x0, [x13]
               	mov	x13, #0x94000000        // =2483027968
               	movk	x13, #0x449a, lsl #32
               	movk	x13, #0x421e, lsl #48
               	fmov	d0, x13
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x13, ne
               	cbz	x13, 0x4004a8 <.text+0x228>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x13, x19
               	ldr	x0, [x13]
               	add	x14, x13, #0x8
               	ldr	x12, [x14]
               	fmov	d0, x0
               	fmov	d1, x12
               	fadd	d7, d0, d1
               	add	x12, x13, #0x10
               	ldr	x13, [x12]
               	fmov	d1, x13
               	fadd	d6, d7, d1
               	fmov	x16, d6
               	stur	x16, [x29, #-0x8]
               	ldur	x13, [x29, #-0x8]
               	mov	x12, #0x94000000        // =2483027968
               	movk	x12, #0x449a, lsl #32
               	movk	x12, #0x421e, lsl #48
               	fmov	d0, x12
               	fneg	d6, d0
               	mov	x12, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x12
               	fadd	d7, d6, d1
               	fmov	d0, x13
               	fcmp	d0, d7
               	cset	x12, gt
               	stur	x12, [x29, #-0x10]
               	cbnz	x12, 0x400554 <.text+0x2d4>
               	ldur	x13, [x29, #-0x8]
               	mov	x12, #0x94000000        // =2483027968
               	movk	x12, #0x449a, lsl #32
               	movk	x12, #0x421e, lsl #48
               	fmov	d0, x12
               	fneg	d7, d0
               	mov	x12, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d1, x12
               	fsub	d6, d7, d1
               	fmov	d0, x13
               	fcmp	d0, d6
               	cset	x12, mi
               	stur	x12, [x29, #-0x10]
               	b	0x400554 <.text+0x2d4>
               	ldur	x12, [x29, #-0x10]
               	cbz	x12, 0x400570 <.text+0x2f0>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
