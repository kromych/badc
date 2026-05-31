
nonconst_local_struct_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
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
               	str	x19, [sp, #0x40]
               	mov	x20, #0x2a              // =42
               	mov	x21, #0x63              // =99
               	sub	x13, x29, #0x18
               	adrp	x19, <page>
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
               	add	x12, x12, #0x4
               	str	w13, [x12]
               	sub	x11, x29, #0x18
               	ldrsw	x11, [x11]
               	cmp	x11, #0x2a
               	cset	x11, ne
               	stur	x11, [x29, #-0xa0]
               	cbnz	x11, <addr>
               	sub	x12, x29, #0x18
               	add	x12, x12, #0x4
               	ldrsw	x12, [x12]
               	cmp	x12, #0x63
               	cset	x12, ne
               	stur	x12, [x29, #-0xa0]
               	b	<addr>
               	ldur	x12, [x29, #-0xa0]
               	cbz	x12, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	sub	x12, x29, #0x18
               	ldrsw	x23, [x12]
               	sub	x12, x29, #0x18
               	add	x12, x12, #0x4
               	ldrsw	x24, [x12]
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x20
               	adrp	x19, <page>
               	add	x19, x19, #0x168
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x24]
               	ldr	x10, [sp], #0x10
               	mov	x23, x24
               	mov	x23, #0x7               // =7
               	sub	x0, x29, #0x20
               	str	w23, [x0]
               	sxtw	x24, w21
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	str	w24, [x0]
               	sub	x23, x29, #0x20
               	ldrsw	x23, [x23]
               	cmp	x23, #0x7
               	cset	x23, ne
               	stur	x23, [x29, #-0xa8]
               	cbnz	x23, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x63
               	cset	x0, ne
               	stur	x0, [x29, #-0xa8]
               	b	<addr>
               	ldur	x0, [x29, #-0xa8]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x170
               	mov	x25, x19
               	sub	x0, x29, #0x20
               	ldrsw	x23, [x0]
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x4
               	ldrsw	x24, [x0]
               	mov	x0, x25
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0x180
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x24]
               	ldr	x10, [sp], #0x10
               	mov	x23, x24
               	mov	x23, #0xb               // =11
               	sub	x0, x29, #0x28
               	str	w23, [x0]
               	mov	x24, #0x16              // =22
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x4
               	str	w24, [x0]
               	sub	x23, x29, #0x28
               	ldrsw	x23, [x23]
               	cmp	x23, #0xb
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	cbnz	x23, <addr>
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x16
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	b	<addr>
               	ldur	x0, [x29, #-0xb0]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	sub	x0, x29, #0x28
               	ldrsw	x23, [x0]
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x4
               	ldrsw	x24, [x0]
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x24, x29, #0x38
               	adrp	x19, <page>
               	add	x19, x19, #0x198
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x24]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x24, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x24, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x24, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x24, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x23, x24
               	sxtw	x23, w20
               	sub	x0, x29, #0x38
               	str	w23, [x0]
               	sxtw	x24, w21
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x8
               	str	w24, [x0]
               	sub	x23, x29, #0x38
               	ldrsw	x23, [x23]
               	cmp	x23, #0x2a
               	cset	x23, ne
               	stur	x23, [x29, #-0xc0]
               	cbnz	x23, <addr>
               	sub	x0, x29, #0x38
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xc0]
               	b	<addr>
               	ldur	x0, [x29, #-0xc0]
               	stur	x0, [x29, #-0xb8]
               	cbnz	x0, <addr>
               	sub	x23, x29, #0x38
               	add	x23, x23, #0x8
               	ldrsw	x23, [x23]
               	cmp	x23, #0x63
               	cset	x23, ne
               	stur	x23, [x29, #-0xb8]
               	b	<addr>
               	ldur	x23, [x29, #-0xb8]
               	cbz	x23, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1a4
               	mov	x25, x19
               	sub	x23, x29, #0x38
               	ldrsw	x23, [x23]
               	sub	x24, x29, #0x38
               	add	x24, x24, #0x4
               	ldrsw	x24, [x24]
               	sub	x22, x29, #0x38
               	add	x22, x22, #0x8
               	ldrsw	x22, [x22]
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x48
               	adrp	x19, <page>
               	add	x19, x19, #0x1b7
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x22, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x22, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x22, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x22, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x24, x22
               	sxtw	x24, w21
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x8
               	str	w24, [x0]
               	sxtw	x22, w20
               	sub	x0, x29, #0x48
               	str	w22, [x0]
               	sub	x24, x29, #0x48
               	ldrsw	x24, [x24]
               	cmp	x24, #0x2a
               	cset	x24, ne
               	stur	x24, [x29, #-0xd0]
               	cbnz	x24, <addr>
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xd0]
               	b	<addr>
               	ldur	x0, [x29, #-0xd0]
               	stur	x0, [x29, #-0xc8]
               	cbnz	x0, <addr>
               	sub	x24, x29, #0x48
               	add	x24, x24, #0x8
               	ldrsw	x24, [x24]
               	cmp	x24, #0x63
               	cset	x24, ne
               	stur	x24, [x29, #-0xc8]
               	b	<addr>
               	ldur	x24, [x29, #-0xc8]
               	cbz	x24, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1c3
               	mov	x26, x19
               	sub	x24, x29, #0x48
               	ldrsw	x24, [x24]
               	sub	x22, x29, #0x48
               	add	x22, x22, #0x4
               	ldrsw	x22, [x22]
               	sub	x23, x29, #0x48
               	add	x23, x23, #0x8
               	ldrsw	x23, [x23]
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x58
               	adrp	x19, <page>
               	add	x19, x19, #0x1d6
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x23, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x23, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x23, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x23, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x22, x23
               	sxtw	x20, w20
               	sub	x22, x29, #0x58
               	str	w20, [x22]
               	sxtw	x0, w21
               	sub	x22, x29, #0x58
               	add	x22, x22, #0x8
               	str	w0, [x22]
               	sub	x20, x29, #0x58
               	ldrsw	x20, [x20]
               	cmp	x20, #0x2a
               	cset	x20, ne
               	stur	x20, [x29, #-0xe0]
               	cbnz	x20, <addr>
               	sub	x22, x29, #0x58
               	add	x22, x22, #0x4
               	ldrsw	x22, [x22]
               	cmp	x22, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xe0]
               	b	<addr>
               	ldur	x22, [x29, #-0xe0]
               	stur	x22, [x29, #-0xd8]
               	cbnz	x22, <addr>
               	sub	x20, x29, #0x58
               	add	x20, x20, #0x8
               	ldrsw	x20, [x20]
               	cmp	x20, #0x63
               	cset	x20, ne
               	stur	x20, [x29, #-0xd8]
               	b	<addr>
               	ldur	x20, [x29, #-0xd8]
               	cbz	x20, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1e2
               	mov	x25, x19
               	sub	x20, x29, #0x58
               	ldrsw	x20, [x20]
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x4
               	ldrsw	x22, [x0]
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x8
               	ldrsw	x23, [x0]
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x68
               	adrp	x19, <page>
               	add	x19, x19, #0x1f5
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x23, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x23, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x23, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x23, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x22, x23
               	sub	x22, x29, #0x78
               	adrp	x19, <page>
               	add	x19, x19, #0x201
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x22]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x22, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x22, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x22, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x22, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x23, x22
               	sxtw	x21, w21
               	sub	x23, x29, #0x78
               	add	x23, x23, #0x4
               	str	w21, [x23]
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xf0]
               	cbnz	x0, <addr>
               	sub	x23, x29, #0x78
               	add	x23, x23, #0x4
               	ldrsw	x23, [x23]
               	cmp	x23, #0x63
               	cset	x23, ne
               	stur	x23, [x29, #-0xf0]
               	b	<addr>
               	ldur	x23, [x29, #-0xf0]
               	stur	x23, [x29, #-0xe8]
               	cbnz	x23, <addr>
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xe8]
               	b	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x20d
               	mov	x24, x19
               	sub	x0, x29, #0x78
               	ldrsw	x23, [x0]
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x4
               	ldrsw	x21, [x0]
               	sub	x0, x29, #0x78
               	add	x0, x0, #0x8
               	ldrsw	x22, [x0]
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x140
               	ldp	x29, x30, [sp], #0x10
               	ret
