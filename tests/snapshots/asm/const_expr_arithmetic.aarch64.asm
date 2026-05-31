
const_expr_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40040c <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
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
               	adrp	x19, 0x410000
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400788 <dlsym>
               	cbz	x0, 0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x4003d4 <.text+0x114>
               	adrp	x19, 0x410000
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x20              // =32
               	mov	x15, #0x4               // =4
               	sdiv	x14, x14, x15
               	cmp	x14, #0x8
               	b.eq	0x40047c <.text+0x1bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x370
               	mov	x20, x19
               	mov	x14, #0x20              // =32
               	mov	x13, #0x4               // =4
               	sdiv	x21, x14, x13
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	b	0x40047c <.text+0x1bc>
               	mov	x0, #0x18               // =24
               	mov	x21, #0x4               // =4
               	sdiv	x0, x0, x21
               	cmp	x0, #0x6
               	b.eq	0x4004c4 <.text+0x204>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x383
               	mov	x22, x19
               	mov	x0, #0x18               // =24
               	mov	x20, #0x4               // =4
               	sdiv	x21, x0, x20
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x8]
               	b	0x4004c4 <.text+0x204>
               	mov	x0, #0x40               // =64
               	mov	x21, #0x4               // =4
               	sdiv	x0, x0, x21
               	cmp	x0, #0x10
               	b.eq	0x40050c <.text+0x24c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x396
               	mov	x23, x19
               	mov	x0, #0x40               // =64
               	mov	x22, #0x4               // =4
               	sdiv	x21, x0, x22
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	b	0x40050c <.text+0x24c>
               	mov	x0, #0x40               // =64
               	mov	x21, #0x4               // =4
               	sdiv	x0, x0, x21
               	cmp	x0, #0x10
               	b.eq	0x400550 <.text+0x290>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a9
               	mov	x20, x19
               	mov	x0, #0x40               // =64
               	mov	x21, #0x4               // =4
               	sdiv	x23, x0, x21
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	stur	w21, [x29, #-0x8]
               	b	0x400550 <.text+0x290>
               	mov	x21, #0x18              // =24
               	mov	x0, #0x4                // =4
               	sdiv	x21, x21, x0
               	cmp	x21, #0x6
               	b.eq	0x400598 <.text+0x2d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bc
               	mov	x22, x19
               	mov	x21, #0x18              // =24
               	mov	x23, #0x4               // =4
               	sdiv	x21, x21, x23
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	b	0x400598 <.text+0x2d8>
               	mov	x0, #0x20               // =32
               	mov	x21, #0x4               // =4
               	sdiv	x0, x0, x21
               	cmp	x0, #0x8
               	b.eq	0x4005e0 <.text+0x320>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cf
               	mov	x23, x19
               	mov	x0, #0x20               // =32
               	mov	x22, #0x4               // =4
               	sdiv	x21, x0, x22
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x8]
               	b	0x4005e0 <.text+0x320>
               	mov	x0, #0x18               // =24
               	mov	x21, #0x4               // =4
               	sdiv	x0, x0, x21
               	cmp	x0, #0x6
               	b.eq	0x400628 <.text+0x368>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e6
               	mov	x20, x19
               	mov	x0, #0x18               // =24
               	mov	x23, #0x4               // =4
               	sdiv	x21, x0, x23
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400794 <printf>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	b	0x400628 <.text+0x368>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
