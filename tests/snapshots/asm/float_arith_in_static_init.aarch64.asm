
float_arith_in_static_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003cc <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4006c8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x15, x19
               	ldr	s7, [x15]
               	fcvt	d7, s7
               	mov	x15, #0x4000000000000000 // =4611686018427387904
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x14, ne
               	cbz	x14, 0x400418 <.text+0x198>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x14, x19
               	add	x14, x14, #0x4
               	ldr	s7, [x14]
               	fcvt	d7, s7
               	mov	x14, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x14
               	fneg	d6, d0
               	fcmp	d7, d6
               	cset	x14, ne
               	cbz	x14, 0x40045c <.text+0x1dc>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x14, x19
               	add	x14, x14, #0x8
               	ldr	s6, [x14]
               	fcvt	d6, s6
               	mov	x14, #0x4028000000000000 // =4622945017495814144
               	fmov	d1, x14
               	fcmp	d6, d1
               	cset	x0, ne
               	cbz	x0, 0x4004a0 <.text+0x220>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldr	x14, [x0]
               	mov	x0, #0x8f5c             // =36700
               	movk	x0, #0xf5c2, lsl #16
               	movk	x0, #0x5c28, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, mi
               	stur	x14, [x29, #-0x8]
               	cbnz	x14, 0x400510 <.text+0x290>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldr	x14, [x0]
               	mov	x0, #0x3d71             // =15729
               	movk	x0, #0xd70a, lsl #16
               	movk	x0, #0x70a3, lsl #32
               	movk	x0, #0x400f, lsl #48
               	fmov	d0, x14
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x14, gt
               	stur	x14, [x29, #-0x8]
               	b	0x400510 <.text+0x290>
               	ldur	x14, [x29, #-0x8]
               	cbz	x14, 0x40052c <.text+0x2ac>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	add	x14, x14, #0x8
               	ldr	x0, [x14]
               	mov	x14, #0x3fe8000000000000 // =4604930618986332160
               	fmov	d0, x14
               	fneg	d6, d0
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, 0x400574 <.text+0x2f4>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
