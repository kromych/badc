
leading_dot_float_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003d0 <.text+0x150>
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
               	bl	0x400618 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0x3fe0000000000000 // =4602678819172646912
               	sub	x14, x29, #0x8
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x14]
               	mov	x14, #0x3fd0000000000000 // =4598175219545276416
               	mov	x13, #0x4039000000000000 // =4627730092099895296
               	sub	x12, x29, #0x20
               	fmov	d0, x15
               	fcvt	s0, d0
               	str	s0, [x12]
               	mov	x12, #0x1               // =1
               	stur	w12, [x29, #-0x28]
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fmov	d1, x15
               	fcmp	d7, d1
               	cset	x11, ne
               	cbz	x11, 0x400438 <.text+0x1b8>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x28]
               	b	0x400438 <.text+0x1b8>
               	mov	x15, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d0, x14
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x11, ne
               	cbz	x11, 0x40045c <.text+0x1dc>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x28]
               	b	0x40045c <.text+0x1dc>
               	mov	x15, #0x4039000000000000 // =4627730092099895296
               	fmov	d0, x13
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x11, ne
               	cbz	x11, 0x400480 <.text+0x200>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x28]
               	b	0x400480 <.text+0x200>
               	sub	x16, x29, #0x20
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	mov	x11, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x11
               	fcmp	d7, d1
               	cset	x15, ne
               	cbz	x15, 0x4004ac <.text+0x22c>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x28]
               	b	0x4004ac <.text+0x22c>
               	ldursw	x11, [x29, #-0x28]
               	cbz	x11, 0x4004c0 <.text+0x240>
               	mov	x15, #0x7               // =7
               	stur	x15, [x29, #-0x30]
               	b	0x4004cc <.text+0x24c>
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x30]
               	b	0x4004cc <.text+0x24c>
               	ldur	x0, [x29, #-0x30]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
