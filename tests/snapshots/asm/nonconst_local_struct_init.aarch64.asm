
nonconst_local_struct_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400418 <.text+0x158>
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
               	bl	0x400de8 <dlsym>
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
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x140
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x20, #0x2a              // =42
               	mov	x21, #0x63              // =99
               	sub	x13, x29, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x12, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldr	x10, [sp], #0x10
               	mov	x11, x13
               	sxtw	x11, w20
               	sub	x12, x29, #0x18
               	str	w11, [x12]
               	sxtw	x13, w21
               	sub	x12, x29, #0x18
               	add	x11, x12, #0x4
               	str	w13, [x11]
               	sub	x12, x29, #0x18
               	ldrsw	x11, [x12]
               	cmp	x11, #0x2a
               	cset	x12, ne
               	stur	x12, [x29, #-0xa0]
               	cbnz	x12, 0x4004c4 <.text+0x204>
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x4
               	ldrsw	x11, [x12]
               	cmp	x11, #0x63
               	cset	x12, ne
               	stur	x12, [x29, #-0xa0]
               	b	0x4004c4 <.text+0x204>
               	ldur	x12, [x29, #-0xa0]
               	cbz	x12, 0x40053c <.text+0x27c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	sub	x12, x29, #0x18
               	ldrsw	x23, [x12]
               	sub	x12, x29, #0x18
               	add	x10, x12, #0x4
               	ldrsw	x24, [x10]
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x1               // =1
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0x168
               	mov	x10, x19
               	str	x11, [sp, #-0x10]!
               	ldr	x11, [x10]
               	str	x11, [x24]
               	ldr	x11, [sp], #0x10
               	mov	x23, x24
               	mov	x23, #0x7               // =7
               	sub	x10, x29, #0x20
               	str	w23, [x10]
               	sxtw	x24, w21
               	sub	x10, x29, #0x20
               	add	x23, x10, #0x4
               	str	w24, [x23]
               	sub	x10, x29, #0x20
               	ldrsw	x23, [x10]
               	cmp	x23, #0x7
               	cset	x10, ne
               	stur	x10, [x29, #-0xa8]
               	cbnz	x10, 0x4005b0 <.text+0x2f0>
               	sub	x23, x29, #0x20
               	add	x10, x23, #0x4
               	ldrsw	x23, [x10]
               	cmp	x23, #0x63
               	cset	x10, ne
               	stur	x10, [x29, #-0xa8]
               	b	0x4005b0 <.text+0x2f0>
               	ldur	x10, [x29, #-0xa8]
               	cbz	x10, 0x400628 <.text+0x368>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x170
               	mov	x25, x19
               	sub	x10, x29, #0x20
               	ldrsw	x23, [x10]
               	sub	x10, x29, #0x20
               	add	x22, x10, #0x4
               	ldrsw	x24, [x22]
               	mov	x0, x25
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x180
               	mov	x22, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x22]
               	str	x10, [x24]
               	ldr	x10, [sp], #0x10
               	mov	x23, x24
               	mov	x26, #0xb               // =11
               	mov	x0, x26
               	bl	0x400410 <.text+0x150>
               	mov	x22, x0
               	sub	x26, x29, #0x28
               	str	w22, [x26]
               	mov	x23, #0x16              // =22
               	mov	x0, x23
               	bl	0x400410 <.text+0x150>
               	mov	x26, x0
               	sub	x23, x29, #0x28
               	add	x22, x23, #0x4
               	str	w26, [x22]
               	sub	x23, x29, #0x28
               	ldrsw	x22, [x23]
               	cmp	x22, #0xb
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	cbnz	x23, 0x4006b4 <.text+0x3f4>
               	sub	x22, x29, #0x28
               	add	x23, x22, #0x4
               	ldrsw	x22, [x23]
               	cmp	x22, #0x16
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	b	0x4006b4 <.text+0x3f4>
               	ldur	x23, [x29, #-0xb0]
               	cbz	x23, 0x40072c <.text+0x46c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x24, x19
               	sub	x23, x29, #0x28
               	ldrsw	x22, [x23]
               	sub	x23, x29, #0x28
               	add	x25, x23, #0x4
               	ldrsw	x26, [x25]
               	mov	x0, x24
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x3               // =3
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x26, x29, #0x38
               	adrp	x19, 0x410000
               	add	x19, x19, #0x198
               	mov	x25, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x25]
               	str	x10, [x26]
               	ldrb	w10, [x25, #0x8]
               	strb	w10, [x26, #0x8]
               	ldrb	w10, [x25, #0x9]
               	strb	w10, [x26, #0x9]
               	ldrb	w10, [x25, #0xa]
               	strb	w10, [x26, #0xa]
               	ldrb	w10, [x25, #0xb]
               	strb	w10, [x26, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x22, x26
               	sxtw	x22, w20
               	sub	x25, x29, #0x38
               	str	w22, [x25]
               	sxtw	x26, w21
               	sub	x25, x29, #0x38
               	add	x22, x25, #0x8
               	str	w26, [x22]
               	sub	x25, x29, #0x38
               	ldrsw	x22, [x25]
               	cmp	x22, #0x2a
               	cset	x25, ne
               	stur	x25, [x29, #-0xc0]
               	cbnz	x25, 0x4007c0 <.text+0x500>
               	sub	x22, x29, #0x38
               	add	x25, x22, #0x4
               	ldrsw	x22, [x25]
               	cmp	x22, #0x0
               	cset	x25, ne
               	stur	x25, [x29, #-0xc0]
               	b	0x4007c0 <.text+0x500>
               	ldur	x25, [x29, #-0xc0]
               	stur	x25, [x29, #-0xb8]
               	cbnz	x25, 0x4007e8 <.text+0x528>
               	sub	x22, x29, #0x38
               	add	x25, x22, #0x8
               	ldrsw	x22, [x25]
               	cmp	x22, #0x63
               	cset	x25, ne
               	stur	x25, [x29, #-0xb8]
               	b	0x4007e8 <.text+0x528>
               	ldur	x25, [x29, #-0xb8]
               	cbz	x25, 0x400870 <.text+0x5b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a4
               	mov	x23, x19
               	sub	x25, x29, #0x38
               	ldrsw	x22, [x25]
               	sub	x25, x29, #0x38
               	add	x24, x25, #0x4
               	ldrsw	x26, [x24]
               	sub	x24, x29, #0x38
               	add	x9, x24, #0x8
               	ldrsw	x25, [x9]
               	mov	x0, x23
               	mov	x3, x25
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x9, x0
               	mov	x9, #0x4                // =4
               	mov	x0, x9
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x25, x29, #0x48
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b7
               	mov	x9, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x9]
               	str	x10, [x25]
               	ldrb	w10, [x9, #0x8]
               	strb	w10, [x25, #0x8]
               	ldrb	w10, [x9, #0x9]
               	strb	w10, [x25, #0x9]
               	ldrb	w10, [x9, #0xa]
               	strb	w10, [x25, #0xa]
               	ldrb	w10, [x9, #0xb]
               	strb	w10, [x25, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x26, x25
               	sxtw	x26, w21
               	sub	x9, x29, #0x48
               	add	x25, x9, #0x8
               	str	w26, [x25]
               	sxtw	x9, w20
               	sub	x25, x29, #0x48
               	str	w9, [x25]
               	sub	x26, x29, #0x48
               	ldrsw	x25, [x26]
               	cmp	x25, #0x2a
               	cset	x26, ne
               	stur	x26, [x29, #-0xd0]
               	cbnz	x26, 0x400904 <.text+0x644>
               	sub	x25, x29, #0x48
               	add	x26, x25, #0x4
               	ldrsw	x25, [x26]
               	cmp	x25, #0x0
               	cset	x26, ne
               	stur	x26, [x29, #-0xd0]
               	b	0x400904 <.text+0x644>
               	ldur	x26, [x29, #-0xd0]
               	stur	x26, [x29, #-0xc8]
               	cbnz	x26, 0x40092c <.text+0x66c>
               	sub	x25, x29, #0x48
               	add	x26, x25, #0x8
               	ldrsw	x25, [x26]
               	cmp	x25, #0x63
               	cset	x26, ne
               	stur	x26, [x29, #-0xc8]
               	b	0x40092c <.text+0x66c>
               	ldur	x26, [x29, #-0xc8]
               	cbz	x26, 0x4009b4 <.text+0x6f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c3
               	mov	x24, x19
               	sub	x26, x29, #0x48
               	ldrsw	x25, [x26]
               	sub	x26, x29, #0x48
               	add	x22, x26, #0x4
               	ldrsw	x27, [x22]
               	sub	x22, x29, #0x48
               	add	x23, x22, #0x8
               	ldrsw	x26, [x23]
               	mov	x0, x24
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x25
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x5               // =5
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x26, x29, #0x58
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d6
               	mov	x23, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x23]
               	str	x10, [x26]
               	ldrb	w10, [x23, #0x8]
               	strb	w10, [x26, #0x8]
               	ldrb	w10, [x23, #0x9]
               	strb	w10, [x26, #0x9]
               	ldrb	w10, [x23, #0xa]
               	strb	w10, [x26, #0xa]
               	ldrb	w10, [x23, #0xb]
               	strb	w10, [x26, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x27, x26
               	sxtw	x27, w20
               	sub	x20, x29, #0x58
               	str	w27, [x20]
               	sxtw	x23, w21
               	sub	x20, x29, #0x58
               	add	x27, x20, #0x8
               	str	w23, [x27]
               	sub	x20, x29, #0x58
               	ldrsw	x27, [x20]
               	cmp	x27, #0x2a
               	cset	x20, ne
               	stur	x20, [x29, #-0xe0]
               	cbnz	x20, 0x400a48 <.text+0x788>
               	sub	x27, x29, #0x58
               	add	x20, x27, #0x4
               	ldrsw	x27, [x20]
               	cmp	x27, #0x0
               	cset	x20, ne
               	stur	x20, [x29, #-0xe0]
               	b	0x400a48 <.text+0x788>
               	ldur	x20, [x29, #-0xe0]
               	stur	x20, [x29, #-0xd8]
               	cbnz	x20, 0x400a70 <.text+0x7b0>
               	sub	x27, x29, #0x58
               	add	x20, x27, #0x8
               	ldrsw	x27, [x20]
               	cmp	x27, #0x63
               	cset	x20, ne
               	stur	x20, [x29, #-0xd8]
               	b	0x400a70 <.text+0x7b0>
               	ldur	x20, [x29, #-0xd8]
               	cbz	x20, 0x400af8 <.text+0x838>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e2
               	mov	x22, x19
               	sub	x20, x29, #0x58
               	ldrsw	x27, [x20]
               	sub	x20, x29, #0x58
               	add	x26, x20, #0x4
               	ldrsw	x23, [x26]
               	sub	x26, x29, #0x58
               	add	x25, x26, #0x8
               	ldrsw	x20, [x25]
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x27
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x6               // =6
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x68
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1f5
               	mov	x25, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x25]
               	str	x10, [x20]
               	ldrb	w10, [x25, #0x8]
               	strb	w10, [x20, #0x8]
               	ldrb	w10, [x25, #0x9]
               	strb	w10, [x20, #0x9]
               	ldrb	w10, [x25, #0xa]
               	strb	w10, [x20, #0xa]
               	ldrb	w10, [x25, #0xb]
               	strb	w10, [x20, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x23, x20
               	sub	x25, x29, #0x78
               	adrp	x19, 0x410000
               	add	x19, x19, #0x201
               	mov	x23, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x23]
               	str	x10, [x25]
               	ldrb	w10, [x23, #0x8]
               	strb	w10, [x25, #0x8]
               	ldrb	w10, [x23, #0x9]
               	strb	w10, [x25, #0x9]
               	ldrb	w10, [x23, #0xa]
               	strb	w10, [x25, #0xa]
               	ldrb	w10, [x23, #0xb]
               	strb	w10, [x25, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x20, x25
               	sxtw	x20, w21
               	sub	x21, x29, #0x78
               	add	x23, x21, #0x4
               	str	w20, [x23]
               	sub	x21, x29, #0x78
               	ldrsw	x23, [x21]
               	cmp	x23, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0xf0]
               	cbnz	x21, 0x400bc4 <.text+0x904>
               	sub	x23, x29, #0x78
               	add	x21, x23, #0x4
               	ldrsw	x23, [x21]
               	cmp	x23, #0x63
               	cset	x21, ne
               	stur	x21, [x29, #-0xf0]
               	b	0x400bc4 <.text+0x904>
               	ldur	x21, [x29, #-0xf0]
               	stur	x21, [x29, #-0xe8]
               	cbnz	x21, 0x400bec <.text+0x92c>
               	sub	x23, x29, #0x78
               	add	x21, x23, #0x8
               	ldrsw	x23, [x21]
               	cmp	x23, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0xe8]
               	b	0x400bec <.text+0x92c>
               	ldur	x21, [x29, #-0xe8]
               	cbz	x21, 0x400c74 <.text+0x9b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x20d
               	mov	x26, x19
               	sub	x21, x29, #0x78
               	ldrsw	x23, [x21]
               	sub	x21, x29, #0x78
               	add	x25, x21, #0x4
               	ldrsw	x20, [x25]
               	sub	x25, x29, #0x78
               	add	x27, x25, #0x8
               	ldrsw	x21, [x27]
               	mov	x0, x26
               	mov	x3, x21
               	mov	x2, x20
               	mov	x1, x23
               	bl	0x400df4 <printf>
               	sxtw	x0, w0
               	mov	x27, x0
               	mov	x27, #0x7               // =7
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
