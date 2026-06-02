
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x2a              // =42
               	mov	x21, #0x63              // =99
               	sub	x13, x29, #0x18
               	adrp	x12, <page>
               	add	x12, x12, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldr	x10, [sp], #0x10
               	sub	x13, x29, #0x18
               	str	w20, [x13]
               	sub	x12, x29, #0x18
               	add	x12, x12, #0x4
               	str	w21, [x12]
               	sub	x13, x29, #0x18
               	ldrsw	x13, [x13]
               	cmp	x13, #0x2a
               	cset	x13, ne
               	stur	x13, [x29, #-0xa0]
               	cbnz	x13, <addr>
               	sub	x12, x29, #0x18
               	add	x12, x12, #0x4
               	ldrsw	x12, [x12]
               	cmp	x12, #0x63
               	cset	x12, ne
               	stur	x12, [x29, #-0xa0]
               	b	<addr>
               	ldur	x12, [x29, #-0xa0]
               	cbz	x12, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	sub	x12, x29, #0x18
               	ldrsw	x1, [x12]
               	sub	x12, x29, #0x18
               	add	x12, x12, #0x4
               	ldrsw	x2, [x12]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x20
               	adrp	x12, <page>
               	add	x12, x12, #0x168
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x7                // =7
               	sub	x12, x29, #0x20
               	str	w2, [x12]
               	sub	x1, x29, #0x20
               	add	x1, x1, #0x4
               	str	w21, [x1]
               	sub	x12, x29, #0x20
               	ldrsw	x12, [x12]
               	cmp	x12, #0x7
               	cset	x12, ne
               	stur	x12, [x29, #-0xa8]
               	cbnz	x12, <addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0x63
               	cset	x1, ne
               	stur	x1, [x29, #-0xa8]
               	b	<addr>
               	ldur	x1, [x29, #-0xa8]
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	sub	x1, x29, #0x20
               	ldrsw	x2, [x1]
               	sub	x1, x29, #0x20
               	add	x1, x1, #0x4
               	ldrsw	x12, [x1]
               	mov	x1, x2
               	mov	x2, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, #0x180
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x12]
               	ldr	x10, [sp], #0x10
               	mov	x12, #0xb               // =11
               	sub	x1, x29, #0x28
               	str	w12, [x1]
               	mov	x2, #0x16               // =22
               	sub	x1, x29, #0x28
               	add	x1, x1, #0x4
               	str	w2, [x1]
               	sub	x12, x29, #0x28
               	ldrsw	x12, [x12]
               	cmp	x12, #0xb
               	cset	x12, ne
               	stur	x12, [x29, #-0xb0]
               	cbnz	x12, <addr>
               	sub	x1, x29, #0x28
               	add	x1, x1, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0x16
               	cset	x1, ne
               	stur	x1, [x29, #-0xb0]
               	b	<addr>
               	ldur	x1, [x29, #-0xb0]
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	sub	x1, x29, #0x28
               	ldrsw	x2, [x1]
               	sub	x1, x29, #0x28
               	add	x1, x1, #0x4
               	ldrsw	x12, [x1]
               	mov	x1, x2
               	mov	x2, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x3                // =3
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, #0x198
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x12]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x12, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x12, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x12, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x12, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x12, x29, #0x38
               	str	w20, [x12]
               	sub	x1, x29, #0x38
               	add	x1, x1, #0x8
               	str	w21, [x1]
               	sub	x12, x29, #0x38
               	ldrsw	x12, [x12]
               	cmp	x12, #0x2a
               	cset	x12, ne
               	stur	x12, [x29, #-0xc0]
               	cbnz	x12, <addr>
               	sub	x1, x29, #0x38
               	add	x1, x1, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0xc0]
               	b	<addr>
               	ldur	x1, [x29, #-0xc0]
               	stur	x1, [x29, #-0xb8]
               	cbnz	x1, <addr>
               	sub	x12, x29, #0x38
               	add	x12, x12, #0x8
               	ldrsw	x12, [x12]
               	cmp	x12, #0x63
               	cset	x12, ne
               	stur	x12, [x29, #-0xb8]
               	b	<addr>
               	ldur	x12, [x29, #-0xb8]
               	cbz	x12, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a4
               	sub	x12, x29, #0x38
               	ldrsw	x1, [x12]
               	sub	x12, x29, #0x38
               	add	x12, x12, #0x4
               	ldrsw	x2, [x12]
               	sub	x12, x29, #0x38
               	add	x12, x12, #0x8
               	ldrsw	x3, [x12]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x48
               	adrp	x12, <page>
               	add	x12, x12, #0x1b7
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x3]
               	ldrb	w10, [x12, #0x8]
               	strb	w10, [x3, #0x8]
               	ldrb	w10, [x12, #0x9]
               	strb	w10, [x3, #0x9]
               	ldrb	w10, [x12, #0xa]
               	strb	w10, [x3, #0xa]
               	ldrb	w10, [x12, #0xb]
               	strb	w10, [x3, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x48
               	add	x3, x3, #0x8
               	str	w21, [x3]
               	sub	x12, x29, #0x48
               	str	w20, [x12]
               	sub	x3, x29, #0x48
               	ldrsw	x3, [x3]
               	cmp	x3, #0x2a
               	cset	x3, ne
               	stur	x3, [x29, #-0xd0]
               	cbnz	x3, <addr>
               	sub	x12, x29, #0x48
               	add	x12, x12, #0x4
               	ldrsw	x12, [x12]
               	cmp	x12, #0x0
               	cset	x12, ne
               	stur	x12, [x29, #-0xd0]
               	b	<addr>
               	ldur	x12, [x29, #-0xd0]
               	stur	x12, [x29, #-0xc8]
               	cbnz	x12, <addr>
               	sub	x3, x29, #0x48
               	add	x3, x3, #0x8
               	ldrsw	x3, [x3]
               	cmp	x3, #0x63
               	cset	x3, ne
               	stur	x3, [x29, #-0xc8]
               	b	<addr>
               	ldur	x3, [x29, #-0xc8]
               	cbz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c3
               	sub	x3, x29, #0x48
               	ldrsw	x1, [x3]
               	sub	x3, x29, #0x48
               	add	x3, x3, #0x4
               	ldrsw	x2, [x3]
               	sub	x3, x29, #0x48
               	add	x3, x3, #0x8
               	ldrsw	x12, [x3]
               	mov	x3, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	mov	x3, #0x5                // =5
               	mov	x0, x3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x58
               	adrp	x3, <page>
               	add	x3, x3, #0x1d6
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x12]
               	ldrb	w10, [x3, #0x8]
               	strb	w10, [x12, #0x8]
               	ldrb	w10, [x3, #0x9]
               	strb	w10, [x12, #0x9]
               	ldrb	w10, [x3, #0xa]
               	strb	w10, [x12, #0xa]
               	ldrb	w10, [x3, #0xb]
               	strb	w10, [x12, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x12, x29, #0x58
               	str	w20, [x12]
               	sub	x3, x29, #0x58
               	add	x3, x3, #0x8
               	str	w21, [x3]
               	sub	x12, x29, #0x58
               	ldrsw	x12, [x12]
               	cmp	x12, #0x2a
               	cset	x12, ne
               	stur	x12, [x29, #-0xe0]
               	cbnz	x12, <addr>
               	sub	x3, x29, #0x58
               	add	x3, x3, #0x4
               	ldrsw	x3, [x3]
               	cmp	x3, #0x0
               	cset	x3, ne
               	stur	x3, [x29, #-0xe0]
               	b	<addr>
               	ldur	x3, [x29, #-0xe0]
               	stur	x3, [x29, #-0xd8]
               	cbnz	x3, <addr>
               	sub	x12, x29, #0x58
               	add	x12, x12, #0x8
               	ldrsw	x12, [x12]
               	cmp	x12, #0x63
               	cset	x12, ne
               	stur	x12, [x29, #-0xd8]
               	b	<addr>
               	ldur	x12, [x29, #-0xd8]
               	cbz	x12, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e2
               	sub	x12, x29, #0x58
               	ldrsw	x1, [x12]
               	sub	x12, x29, #0x58
               	add	x12, x12, #0x4
               	ldrsw	x2, [x12]
               	sub	x12, x29, #0x58
               	add	x12, x12, #0x8
               	ldrsw	x3, [x12]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x68
               	adrp	x12, <page>
               	add	x12, x12, #0x1f5
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x3]
               	ldrb	w10, [x12, #0x8]
               	strb	w10, [x3, #0x8]
               	ldrb	w10, [x12, #0x9]
               	strb	w10, [x3, #0x9]
               	ldrb	w10, [x12, #0xa]
               	strb	w10, [x3, #0xa]
               	ldrb	w10, [x12, #0xb]
               	strb	w10, [x3, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x78
               	adrp	x12, <page>
               	add	x12, x12, #0x201
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x3]
               	ldrb	w10, [x12, #0x8]
               	strb	w10, [x3, #0x8]
               	ldrb	w10, [x12, #0x9]
               	strb	w10, [x3, #0x9]
               	ldrb	w10, [x12, #0xa]
               	strb	w10, [x3, #0xa]
               	ldrb	w10, [x12, #0xb]
               	strb	w10, [x3, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x78
               	add	x3, x3, #0x4
               	str	w21, [x3]
               	sub	x12, x29, #0x78
               	ldrsw	x12, [x12]
               	cmp	x12, #0x0
               	cset	x12, ne
               	stur	x12, [x29, #-0xf0]
               	cbnz	x12, <addr>
               	sub	x3, x29, #0x78
               	add	x3, x3, #0x4
               	ldrsw	x3, [x3]
               	cmp	x3, #0x63
               	cset	x3, ne
               	stur	x3, [x29, #-0xf0]
               	b	<addr>
               	ldur	x3, [x29, #-0xf0]
               	stur	x3, [x29, #-0xe8]
               	cbnz	x3, <addr>
               	sub	x12, x29, #0x78
               	add	x12, x12, #0x8
               	ldrsw	x12, [x12]
               	cmp	x12, #0x0
               	cset	x12, ne
               	stur	x12, [x29, #-0xe8]
               	b	<addr>
               	ldur	x12, [x29, #-0xe8]
               	cbz	x12, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x20d
               	sub	x12, x29, #0x78
               	ldrsw	x1, [x12]
               	sub	x12, x29, #0x78
               	add	x12, x12, #0x4
               	ldrsw	x2, [x12]
               	sub	x12, x29, #0x78
               	add	x12, x12, #0x8
               	ldrsw	x3, [x12]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x7               // =7
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, #0x0                // =0
               	mov	x0, x3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
