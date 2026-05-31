
const_expr_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400410 <.text+0x150>
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
               	bl	0x4007b8 <dlsym>
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x20              // =32
               	mov	x15, #0x4               // =4
               	sdiv	x13, x14, x15
               	cmp	x13, #0x8
               	b.eq	0x400488 <.text+0x1c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x370
               	mov	x20, x19
               	mov	x15, #0x20              // =32
               	mov	x14, #0x4               // =4
               	sdiv	x21, x15, x14
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x1               // =1
               	stur	w14, [x29, #-0x8]
               	b	0x400488 <.text+0x1c8>
               	mov	x14, #0x18              // =24
               	mov	x21, #0x4               // =4
               	sdiv	x20, x14, x21
               	cmp	x20, #0x6
               	b.eq	0x4004d4 <.text+0x214>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x383
               	mov	x22, x19
               	mov	x21, #0x18              // =24
               	mov	x14, #0x4               // =4
               	sdiv	x20, x21, x14
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x2               // =2
               	stur	w14, [x29, #-0x8]
               	b	0x4004d4 <.text+0x214>
               	mov	x14, #0x40              // =64
               	mov	x20, #0x4               // =4
               	sdiv	x22, x14, x20
               	cmp	x22, #0x10
               	b.eq	0x400520 <.text+0x260>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x396
               	mov	x23, x19
               	mov	x20, #0x40              // =64
               	mov	x14, #0x4               // =4
               	sdiv	x22, x20, x14
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x3               // =3
               	stur	w14, [x29, #-0x8]
               	b	0x400520 <.text+0x260>
               	mov	x14, #0x40              // =64
               	mov	x22, #0x4               // =4
               	sdiv	x23, x14, x22
               	cmp	x23, #0x10
               	b.eq	0x400568 <.text+0x2a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a9
               	mov	x21, x19
               	mov	x22, #0x40              // =64
               	mov	x23, #0x4               // =4
               	sdiv	x24, x22, x23
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	stur	w23, [x29, #-0x8]
               	b	0x400568 <.text+0x2a8>
               	mov	x23, #0x18              // =24
               	mov	x22, #0x4               // =4
               	sdiv	x24, x23, x22
               	cmp	x24, #0x6
               	b.eq	0x4005b4 <.text+0x2f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bc
               	mov	x20, x19
               	mov	x22, #0x18              // =24
               	mov	x23, #0x4               // =4
               	sdiv	x24, x22, x23
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x5               // =5
               	stur	w23, [x29, #-0x8]
               	b	0x4005b4 <.text+0x2f4>
               	mov	x23, #0x20              // =32
               	mov	x24, #0x4               // =4
               	sdiv	x20, x23, x24
               	cmp	x20, #0x8
               	b.eq	0x400600 <.text+0x340>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cf
               	mov	x21, x19
               	mov	x24, #0x20              // =32
               	mov	x23, #0x4               // =4
               	sdiv	x20, x24, x23
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x6               // =6
               	stur	w23, [x29, #-0x8]
               	b	0x400600 <.text+0x340>
               	mov	x23, #0x18              // =24
               	mov	x20, #0x4               // =4
               	sdiv	x21, x23, x20
               	cmp	x21, #0x6
               	b.eq	0x40064c <.text+0x38c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e6
               	mov	x22, x19
               	mov	x20, #0x18              // =24
               	mov	x23, #0x4               // =4
               	sdiv	x21, x20, x23
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x4007c4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x7               // =7
               	stur	w23, [x29, #-0x8]
               	b	0x40064c <.text+0x38c>
               	ldursw	x23, [x29, #-0x8]
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
