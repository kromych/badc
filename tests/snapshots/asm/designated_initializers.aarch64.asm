
designated_initializers.aarch64:	file format elf64-littleaarch64

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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
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
               	add	x11, x11, #0x110
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x116
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x11d
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x15, x29, #0x8
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	cset	x15, ne
               	stur	x15, [x29, #-0x90]
               	cbnz	x15, <addr>
               	sub	x14, x29, #0x8
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0x2
               	cset	x14, ne
               	stur	x14, [x29, #-0x90]
               	b	<addr>
               	ldur	x14, [x29, #-0x90]
               	cbz	x14, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldr	x10, [sp], #0x10
               	sub	x14, x29, #0x10
               	ldrsw	x14, [x14]
               	cmp	x14, #0xa
               	cset	x14, ne
               	stur	x14, [x29, #-0x98]
               	cbnz	x14, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x14
               	cset	x0, ne
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	ldur	x0, [x29, #-0x98]
               	cbz	x0, <addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x14, <page>
               	add	x14, x14, #0x158
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xa0]
               	cbnz	x0, <addr>
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0x63
               	cset	x14, ne
               	stur	x14, [x29, #-0xa0]
               	b	<addr>
               	ldur	x14, [x29, #-0xa0]
               	cbz	x14, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x28
               	adrp	x0, <page>
               	add	x0, x0, #0x160
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x14, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x14, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x14, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x14, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x14, x29, #0x28
               	ldrsw	x14, [x14]
               	cmp	x14, #0x1
               	cset	x14, ne
               	stur	x14, [x29, #-0xb0]
               	cbnz	x14, <addr>
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	b	<addr>
               	ldur	x0, [x29, #-0xb0]
               	stur	x0, [x29, #-0xa8]
               	cbnz	x0, <addr>
               	sub	x14, x29, #0x28
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	cmp	x14, #0x3
               	cset	x14, ne
               	stur	x14, [x29, #-0xa8]
               	b	<addr>
               	ldur	x14, [x29, #-0xa8]
               	cbz	x14, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, #0x16c
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldr	x10, [sp], #0x10
               	sub	x14, x29, #0x30
               	ldrsw	x14, [x14]
               	cmp	x14, #0x7
               	cset	x14, ne
               	stur	x14, [x29, #-0xb8]
               	cbnz	x14, <addr>
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0xe
               	cset	x0, ne
               	stur	x0, [x29, #-0xb8]
               	b	<addr>
               	ldur	x0, [x29, #-0xb8]
               	cbz	x0, <addr>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	adrp	x14, <page>
               	add	x14, x14, #0x174
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x14, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x14, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x14, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x14, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x48
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0xd               // =13
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x32
               	b.eq	<addr>
               	mov	x14, #0xf               // =15
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	adrp	x14, <page>
               	add	x14, x14, #0x188
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x14, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x14, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x14, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x70
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x15              // =21
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x14, #0x16              // =22
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x17              // =23
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x1c
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2bc
               	b.eq	<addr>
               	mov	x14, #0x18              // =24
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x19              // =25
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x24
               	ldrsw	x0, [x0]
               	cmp	x0, #0x384
               	b.eq	<addr>
               	mov	x14, #0x1a              // =26
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	adrp	x14, <page>
               	add	x14, x14, #0x1b0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x14, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x88
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x14, #0x1f              // =31
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x14, #0x20              // =32
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x21              // =33
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x14, #0x22              // =34
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x32
               	b.eq	<addr>
               	mov	x14, #0x23              // =35
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x14, #0x24              // =36
               	mov	x0, x14
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
