
vsnprintf_underscore_alias.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x401b70 <.text+0x18f0>
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
               	bl	0x401d48 <dlsym>
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
               	sub	sp, sp, #0x10
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	stur	w13, [x29, #0x30]
               	sxtw	x12, w3
               	stur	w14, [x29, #-0x8]
               	ldursw	x13, [x29, #-0x8]
               	add	x14, x15, x13
               	mov	x13, #0x0               // =0
               	strb	w13, [x14]
               	ldursw	x11, [x29, #0x30]
               	cmp	x11, #0x0
               	b.ne	0x400450 <.text+0x1d0>
               	ldursw	x11, [x29, #-0x8]
               	sub	x13, x11, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x8]
               	ldursw	x11, [x29, #-0x8]
               	add	x13, x15, x11
               	mov	x11, #0x30              // =48
               	strb	w11, [x13]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	0x400454 <.text+0x1d4>
               	ldursw	x11, [x29, #0x30]
               	cmp	x11, #0x0
               	b.eq	0x40046c <.text+0x1ec>
               	cmp	x12, #0xa
               	b.ne	0x4004c4 <.text+0x244>
               	b	0x400484 <.text+0x204>
               	ldursw	x11, [x29, #-0x8]
               	mov	x0, x11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldursw	x0, [x29, #0x30]
               	mov	x11, #0xa               // =10
               	sdiv	x17, x0, x11
               	msub	x13, x17, x11, x0
               	stur	w13, [x29, #-0x10]
               	sdiv	x10, x0, x11
               	stur	w10, [x29, #0x30]
               	b	0x4004a4 <.text+0x224>
               	ldursw	x10, [x29, #-0x8]
               	sub	x0, x10, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x10, [x29, #-0x10]
               	cmp	x10, #0xa
               	b.ge	0x400514 <.text+0x294>
               	b	0x4004f4 <.text+0x274>
               	ldursw	x10, [x29, #0x30]
               	mov	x17, #0xf               // =15
               	and	x11, x10, x17
               	stur	w11, [x29, #-0x10]
               	asr	x0, x10, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x10, x0, x17
               	stur	w10, [x29, #0x30]
               	b	0x4004a4 <.text+0x224>
               	ldursw	x10, [x29, #-0x8]
               	add	x0, x15, x10
               	ldursw	x10, [x29, #-0x10]
               	add	x11, x10, #0x30
               	sxtw	x11, w11
               	strb	w11, [x0]
               	b	0x400510 <.text+0x290>
               	b	0x400454 <.text+0x1d4>
               	ldursw	x11, [x29, #-0x8]
               	add	x10, x15, x11
               	ldursw	x11, [x29, #-0x10]
               	add	x0, x11, #0x61
               	sxtw	x0, w0
               	sub	x11, x0, #0xa
               	sxtw	x11, w11
               	strb	w11, [x10]
               	b	0x400510 <.text+0x290>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, x2
               	sxtw	x12, w3
               	cmp	x14, #0x0
               	cset	x11, gt
               	stur	x11, [x29, #-0x8]
               	cbz	x11, 0x400580 <.text+0x300>
               	ldrsw	x10, [x13]
               	add	x11, x10, #0x1
               	sxtw	x11, w11
               	cmp	x11, x14
               	cset	x10, lt
               	stur	x10, [x29, #-0x8]
               	b	0x400580 <.text+0x300>
               	ldur	x10, [x29, #-0x8]
               	cbz	x10, 0x4005a0 <.text+0x320>
               	ldrsw	x11, [x13]
               	add	x10, x15, x11
               	mov	x17, #0xff              // =255
               	and	x11, x12, x17
               	strb	w11, [x10]
               	b	0x4005a0 <.text+0x320>
               	ldrsw	x11, [x13]
               	add	x12, x11, #0x1
               	sxtw	x12, w12
               	str	w12, [x13]
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x3, [sp, #-0x10]!
               	sub	sp, sp, #0x30
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x20, x0
               	sxtw	x21, w1
               	mov	x22, x2
               	mov	x12, x3
               	stur	x12, [x29, #0x40]
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x8]
               	stur	w11, [x29, #-0x10]
               	b	0x400620 <.text+0x3a0>
               	ldursw	x11, [x29, #-0x10]
               	add	x12, x22, x11
               	ldrb	w11, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x11, x17
               	cmp	x12, #0x0
               	b.eq	0x400674 <.text+0x3f4>
               	ldursw	x12, [x29, #-0x10]
               	add	x11, x22, x12
               	ldrb	w12, [x11]
               	sturb	w12, [x29, #-0x70]
               	ldurb	w11, [x29, #-0x70]
               	mov	x17, #0x25              // =37
               	eor	x12, x11, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x12, x17
               	cmp	x11, #0x0
               	b.eq	0x4006b4 <.text+0x434>
               	b	0x400680 <.text+0x400>
               	cmp	x21, #0x0
               	b.le	0x401a7c <.text+0x17fc>
               	b	0x401a6c <.text+0x17ec>
               	sub	x23, x29, #0x8
               	ldurb	w24, [x29, #-0x70]
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x10, x0
               	ldursw	x10, [x29, #-0x10]
               	add	x24, x10, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x400620 <.text+0x3a0>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x24, #0x1
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x10]
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x50]
               	stur	w24, [x29, #-0x58]
               	b	0x4006d4 <.text+0x454>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x2d              // =45
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	cset	x10, eq
               	sub	x17, x29, #0x110
               	str	x10, [x17]
               	cbnz	x10, 0x4007a0 <.text+0x520>
               	b	0x40076c <.text+0x4ec>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x2d              // =45
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	b.ne	0x400890 <.text+0x610>
               	b	0x400870 <.text+0x5f0>
               	mov	x10, #0x0               // =0
               	stur	w10, [x29, #-0x38]
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x2a              // =42
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	b.ne	0x400928 <.text+0x6a8>
               	b	0x4008c8 <.text+0x648>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x30              // =48
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	cset	x10, eq
               	sub	x17, x29, #0x110
               	str	x10, [x17]
               	b	0x4007a0 <.text+0x520>
               	sub	x16, x29, #0x110
               	ldr	x10, [x16]
               	sub	x17, x29, #0x108
               	str	x10, [x17]
               	cbnz	x10, 0x4007e8 <.text+0x568>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x2b              // =43
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	cset	x10, eq
               	sub	x17, x29, #0x108
               	str	x10, [x17]
               	b	0x4007e8 <.text+0x568>
               	sub	x16, x29, #0x108
               	ldr	x10, [x16]
               	stur	x10, [x29, #-0x100]
               	cbnz	x10, 0x400828 <.text+0x5a8>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x20              // =32
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	cset	x10, eq
               	stur	x10, [x29, #-0x100]
               	b	0x400828 <.text+0x5a8>
               	ldur	x10, [x29, #-0x100]
               	stur	x10, [x29, #-0xf8]
               	cbnz	x10, 0x400864 <.text+0x5e4>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x23              // =35
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	cset	x10, eq
               	stur	x10, [x29, #-0xf8]
               	b	0x400864 <.text+0x5e4>
               	ldur	x10, [x29, #-0xf8]
               	cbz	x10, 0x400738 <.text+0x4b8>
               	b	0x40070c <.text+0x48c>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x50]
               	b	0x40087c <.text+0x5fc>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x24, #0x1
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x10]
               	b	0x4006d4 <.text+0x454>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x30              // =48
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	b.ne	0x4008c4 <.text+0x644>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x58]
               	b	0x4008c4 <.text+0x644>
               	b	0x40087c <.text+0x5fc>
               	add	x24, x29, #0x40
               	ldr	x10, [x24]
               	add	x17, x10, #0x10
               	str	x17, [x24]
               	ldrsw	x24, [x10]
               	stur	w24, [x29, #-0x38]
               	ldursw	x10, [x29, #-0x38]
               	cmp	x10, #0x0
               	b.ge	0x400954 <.text+0x6d4>
               	b	0x40092c <.text+0x6ac>
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0x40]
               	stur	w23, [x29, #-0x48]
               	ldursw	x24, [x29, #-0x10]
               	add	x23, x22, x24
               	ldrb	w24, [x23]
               	mov	x17, #0x2e              // =46
               	eor	x23, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x23, x17
               	cmp	x24, #0x0
               	b.ne	0x400a44 <.text+0x7c4>
               	b	0x400a00 <.text+0x780>
               	b	0x400968 <.text+0x6e8>
               	mov	x10, #0x1               // =1
               	stur	w10, [x29, #-0x50]
               	ldursw	x24, [x29, #-0x38]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x10, x24, x17
               	stur	w10, [x29, #-0x38]
               	b	0x400954 <.text+0x6d4>
               	ldursw	x10, [x29, #-0x10]
               	add	x24, x10, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x4008f0 <.text+0x670>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	cmp	x24, #0x30
               	cset	x10, ge
               	sub	x17, x29, #0x118
               	str	x10, [x17]
               	cbz	x10, 0x4009f0 <.text+0x770>
               	b	0x4009d0 <.text+0x750>
               	ldursw	x24, [x29, #-0x38]
               	mov	x17, #0xa               // =10
               	mul	x10, x24, x17
               	sxtw	x10, w10
               	ldursw	x24, [x29, #-0x10]
               	add	x23, x22, x24
               	ldrb	w9, [x23]
               	sub	x23, x9, #0x30
               	sxtw	x23, w23
               	add	x9, x10, x23
               	sxtw	x9, w9
               	stur	w9, [x29, #-0x38]
               	add	x23, x24, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400968 <.text+0x6e8>
               	b	0x4008f0 <.text+0x670>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	cmp	x24, #0x39
               	cset	x10, le
               	sub	x17, x29, #0x118
               	str	x10, [x17]
               	b	0x4009f0 <.text+0x770>
               	sub	x16, x29, #0x118
               	ldr	x10, [x16]
               	cbz	x10, 0x4009cc <.text+0x74c>
               	b	0x40098c <.text+0x70c>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x48]
               	ldursw	x23, [x29, #-0x10]
               	add	x24, x23, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	ldursw	x23, [x29, #-0x10]
               	add	x24, x22, x23
               	ldrb	w23, [x24]
               	mov	x17, #0x2a              // =42
               	eor	x24, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x24, x17
               	cmp	x23, #0x0
               	b.ne	0x400a74 <.text+0x7f4>
               	b	0x400a48 <.text+0x7c8>
               	b	0x400b34 <.text+0x8b4>
               	add	x23, x29, #0x40
               	ldr	x24, [x23]
               	add	x17, x24, #0x10
               	str	x17, [x23]
               	ldrsw	x23, [x24]
               	stur	w23, [x29, #-0x40]
               	ldursw	x24, [x29, #-0x40]
               	cmp	x24, #0x0
               	b.ge	0x400a88 <.text+0x808>
               	b	0x400a78 <.text+0x7f8>
               	b	0x400a44 <.text+0x7c4>
               	b	0x400a9c <.text+0x81c>
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x48]
               	stur	w24, [x29, #-0x40]
               	b	0x400a88 <.text+0x808>
               	ldursw	x24, [x29, #-0x10]
               	add	x23, x24, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400a70 <.text+0x7f0>
               	ldursw	x23, [x29, #-0x10]
               	add	x24, x22, x23
               	ldrb	w23, [x24]
               	cmp	x23, #0x30
               	cset	x24, ge
               	sub	x17, x29, #0x120
               	str	x24, [x17]
               	cbz	x24, 0x400b24 <.text+0x8a4>
               	b	0x400b04 <.text+0x884>
               	ldursw	x23, [x29, #-0x40]
               	mov	x17, #0xa               // =10
               	mul	x24, x23, x17
               	sxtw	x24, w24
               	ldursw	x23, [x29, #-0x10]
               	add	x9, x22, x23
               	ldrb	w10, [x9]
               	sub	x9, x10, #0x30
               	sxtw	x9, w9
               	add	x10, x24, x9
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x40]
               	add	x9, x23, #0x1
               	sxtw	x9, w9
               	stur	w9, [x29, #-0x10]
               	b	0x400a9c <.text+0x81c>
               	b	0x400a70 <.text+0x7f0>
               	ldursw	x23, [x29, #-0x10]
               	add	x24, x22, x23
               	ldrb	w23, [x24]
               	cmp	x23, #0x39
               	cset	x24, le
               	sub	x17, x29, #0x120
               	str	x24, [x17]
               	b	0x400b24 <.text+0x8a4>
               	sub	x16, x29, #0x120
               	ldr	x24, [x16]
               	cbz	x24, 0x400b00 <.text+0x880>
               	b	0x400ac0 <.text+0x840>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x22, x9
               	ldrb	w9, [x23]
               	mov	x17, #0x6c              // =108
               	eor	x23, x9, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	cmp	x9, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x140
               	str	x23, [x17]
               	cbnz	x23, 0x400be8 <.text+0x968>
               	b	0x400bb4 <.text+0x934>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x9, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400b34 <.text+0x8b4>
               	ldursw	x23, [x29, #-0x10]
               	add	x9, x22, x23
               	ldrb	w23, [x9]
               	sturb	w23, [x29, #-0x70]
               	ldurb	w9, [x29, #-0x70]
               	mov	x17, #0x64              // =100
               	eor	x23, x9, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	cmp	x9, #0x0
               	b.ne	0x400d04 <.text+0xa84>
               	b	0x400cd0 <.text+0xa50>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x22, x9
               	ldrb	w9, [x23]
               	mov	x17, #0x68              // =104
               	eor	x23, x9, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	cmp	x9, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x140
               	str	x23, [x17]
               	b	0x400be8 <.text+0x968>
               	sub	x16, x29, #0x140
               	ldr	x23, [x16]
               	sub	x17, x29, #0x138
               	str	x23, [x17]
               	cbnz	x23, 0x400c30 <.text+0x9b0>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x22, x9
               	ldrb	w9, [x23]
               	mov	x17, #0x7a              // =122
               	eor	x23, x9, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	cmp	x9, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x138
               	str	x23, [x17]
               	b	0x400c30 <.text+0x9b0>
               	sub	x16, x29, #0x138
               	ldr	x23, [x16]
               	sub	x17, x29, #0x130
               	str	x23, [x17]
               	cbnz	x23, 0x400c78 <.text+0x9f8>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x22, x9
               	ldrb	w9, [x23]
               	mov	x17, #0x6a              // =106
               	eor	x23, x9, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	cmp	x9, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x130
               	str	x23, [x17]
               	b	0x400c78 <.text+0x9f8>
               	sub	x16, x29, #0x130
               	ldr	x23, [x16]
               	sub	x17, x29, #0x128
               	str	x23, [x17]
               	cbnz	x23, 0x400cc0 <.text+0xa40>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x22, x9
               	ldrb	w9, [x23]
               	mov	x17, #0x74              // =116
               	eor	x23, x9, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	cmp	x9, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x128
               	str	x23, [x17]
               	b	0x400cc0 <.text+0xa40>
               	sub	x16, x29, #0x128
               	ldr	x23, [x16]
               	cbz	x23, 0x400b80 <.text+0x900>
               	b	0x400b6c <.text+0x8ec>
               	add	x9, x29, #0x40
               	ldr	x23, [x9]
               	add	x17, x23, #0x10
               	str	x17, [x9]
               	ldrsw	x9, [x23]
               	stur	w9, [x29, #-0x20]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0x28]
               	ldursw	x9, [x29, #-0x20]
               	cmp	x9, #0x0
               	b.ge	0x400d5c <.text+0xadc>
               	b	0x400d34 <.text+0xab4>
               	b	0x400620 <.text+0x3a0>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x75              // =117
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	cset	x28, eq
               	sub	x17, x29, #0x188
               	str	x28, [x17]
               	cbnz	x28, 0x401120 <.text+0xea0>
               	b	0x4010f4 <.text+0xe74>
               	mov	x9, #0x1                // =1
               	stur	w9, [x29, #-0x28]
               	ldursw	x23, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x9, x23, x17
               	stur	w9, [x29, #-0x20]
               	b	0x400d5c <.text+0xadc>
               	sub	x25, x29, #0x90
               	mov	x26, #0x1f              // =31
               	ldursw	x23, [x29, #-0x20]
               	mov	x27, #0xa               // =10
               	mov	x0, x25
               	mov	x3, x27
               	mov	x2, x23
               	mov	x1, x26
               	bl	0x4003d0 <.text+0x150>
               	mov	x8, x0
               	stur	w8, [x29, #-0x18]
               	ldursw	x27, [x29, #-0x18]
               	sub	x8, x26, x27
               	sxtw	x8, w8
               	stur	w8, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400db4 <.text+0xb34>
               	ldursw	x8, [x29, #-0x60]
               	add	x27, x8, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x60]
               	b	0x400db4 <.text+0xb34>
               	ldursw	x27, [x29, #-0x48]
               	cbz	x27, 0x400dcc <.text+0xb4c>
               	ldursw	x8, [x29, #-0x40]
               	sub	x17, x29, #0x148
               	str	x8, [x17]
               	b	0x400ddc <.text+0xb5c>
               	mov	x8, #0x0                // =0
               	sub	x17, x29, #0x148
               	str	x8, [x17]
               	b	0x400ddc <.text+0xb5c>
               	sub	x16, x29, #0x148
               	ldr	x8, [x16]
               	stur	w8, [x29, #-0xa0]
               	mov	x27, #0x0               // =0
               	stur	w27, [x29, #-0xa8]
               	ldursw	x8, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400e0c <.text+0xb8c>
               	mov	x26, #0x1               // =1
               	sub	x17, x29, #0x150
               	str	x26, [x17]
               	b	0x400e1c <.text+0xb9c>
               	mov	x26, #0x0               // =0
               	sub	x17, x29, #0x150
               	str	x26, [x17]
               	b	0x400e1c <.text+0xb9c>
               	sub	x16, x29, #0x150
               	ldr	x26, [x16]
               	sub	x27, x8, x26
               	sxtw	x27, w27
               	ldursw	x26, [x29, #-0xa0]
               	cmp	x27, x26
               	b.ge	0x400e4c <.text+0xbcc>
               	ldursw	x26, [x29, #-0xa0]
               	ldursw	x8, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400e70 <.text+0xbf0>
               	b	0x400e60 <.text+0xbe0>
               	ldursw	x26, [x29, #-0x38]
               	ldursw	x23, [x29, #-0x60]
               	cmp	x26, x23
               	b.le	0x400ed0 <.text+0xc50>
               	b	0x400eb4 <.text+0xc34>
               	mov	x23, #0x1               // =1
               	sub	x17, x29, #0x158
               	str	x23, [x17]
               	b	0x400e80 <.text+0xc00>
               	mov	x23, #0x0               // =0
               	sub	x17, x29, #0x158
               	str	x23, [x17]
               	b	0x400e80 <.text+0xc00>
               	sub	x16, x29, #0x158
               	ldr	x23, [x16]
               	sub	x27, x8, x23
               	sxtw	x27, w27
               	sub	x23, x26, x27
               	sxtw	x23, w23
               	stur	w23, [x29, #-0xa8]
               	ldursw	x27, [x29, #-0x60]
               	ldursw	x23, [x29, #-0xa8]
               	add	x26, x27, x23
               	sxtw	x26, w26
               	stur	w26, [x29, #-0x60]
               	b	0x400e4c <.text+0xbcc>
               	ldursw	x23, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x26, x23, x27
               	sxtw	x26, w26
               	sub	x17, x29, #0x160
               	str	x26, [x17]
               	b	0x400ee0 <.text+0xc60>
               	mov	x26, #0x0               // =0
               	sub	x17, x29, #0x160
               	str	x26, [x17]
               	b	0x400ee0 <.text+0xc60>
               	sub	x16, x29, #0x160
               	ldr	x26, [x16]
               	stur	w26, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x58]
               	sub	x17, x29, #0x170
               	str	x27, [x17]
               	cbz	x27, 0x400f14 <.text+0xc94>
               	ldursw	x26, [x29, #-0x48]
               	cmp	x26, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x170
               	str	x27, [x17]
               	b	0x400f14 <.text+0xc94>
               	sub	x16, x29, #0x170
               	ldr	x27, [x16]
               	sub	x17, x29, #0x168
               	str	x27, [x17]
               	cbz	x27, 0x400f40 <.text+0xcc0>
               	ldursw	x26, [x29, #-0x50]
               	cmp	x26, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x168
               	str	x27, [x17]
               	b	0x400f40 <.text+0xcc0>
               	sub	x16, x29, #0x168
               	ldr	x27, [x16]
               	cbz	x27, 0x400f5c <.text+0xcdc>
               	mov	x26, #0x30              // =48
               	sub	x17, x29, #0x178
               	str	x26, [x17]
               	b	0x400f6c <.text+0xcec>
               	mov	x26, #0x20              // =32
               	sub	x17, x29, #0x178
               	str	x26, [x17]
               	b	0x400f6c <.text+0xcec>
               	sub	x16, x29, #0x178
               	ldr	x26, [x16]
               	sturb	w26, [x29, #-0xb0]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	0x400f88 <.text+0xd08>
               	b	0x400f94 <.text+0xd14>
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400ffc <.text+0xd7c>
               	b	0x400fd8 <.text+0xd58>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	0x400fd4 <.text+0xd54>
               	sub	x24, x29, #0x8
               	ldurb	w27, [x29, #-0xb0]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x23, x0
               	ldursw	x23, [x29, #-0x68]
               	sub	x27, x23, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x68]
               	b	0x400f94 <.text+0xd14>
               	b	0x400f88 <.text+0xd08>
               	sub	x26, x29, #0x8
               	mov	x23, #0x2d              // =45
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x24, x0
               	b	0x400ffc <.text+0xd7c>
               	b	0x401000 <.text+0xd80>
               	ldursw	x23, [x29, #-0xa8]
               	cmp	x23, #0x0
               	b.le	0x401040 <.text+0xdc0>
               	sub	x27, x29, #0x8
               	mov	x23, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0xa8]
               	sub	x23, x26, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0xa8]
               	b	0x401000 <.text+0xd80>
               	b	0x401044 <.text+0xdc4>
               	ldursw	x23, [x29, #-0x18]
               	cmp	x23, #0x1f
               	b.ge	0x401090 <.text+0xe10>
               	sub	x24, x29, #0x8
               	sub	x26, x29, #0x90
               	ldursw	x27, [x29, #-0x18]
               	add	x8, x26, x27
               	ldrb	w23, [x8]
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x8, x0
               	ldursw	x8, [x29, #-0x18]
               	add	x23, x8, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x18]
               	b	0x401044 <.text+0xdc4>
               	ldursw	x23, [x29, #-0x50]
               	cbz	x23, 0x40109c <.text+0xe1c>
               	b	0x4010b0 <.text+0xe30>
               	ldursw	x28, [x29, #-0x10]
               	add	x24, x28, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x400d00 <.text+0xa80>
               	ldursw	x8, [x29, #-0x68]
               	cmp	x8, #0x0
               	b.le	0x4010f0 <.text+0xe70>
               	sub	x27, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x68]
               	sub	x28, x24, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x4010b0 <.text+0xe30>
               	b	0x40109c <.text+0xe1c>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x78              // =120
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	cset	x28, eq
               	sub	x17, x29, #0x188
               	str	x28, [x17]
               	b	0x401120 <.text+0xea0>
               	sub	x16, x29, #0x188
               	ldr	x28, [x16]
               	sub	x17, x29, #0x180
               	str	x28, [x17]
               	cbnz	x28, 0x401160 <.text+0xee0>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x58              // =88
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	cset	x28, eq
               	sub	x17, x29, #0x180
               	str	x28, [x17]
               	b	0x401160 <.text+0xee0>
               	sub	x16, x29, #0x180
               	ldr	x28, [x16]
               	cbz	x28, 0x4011b8 <.text+0xf38>
               	add	x24, x29, #0x40
               	ldr	x28, [x24]
               	add	x17, x28, #0x10
               	str	x17, [x24]
               	ldrsw	x24, [x28]
               	stur	w24, [x29, #-0x20]
               	sub	x23, x29, #0x90
               	mov	x28, #0x1f              // =31
               	ldursw	x24, [x29, #-0x20]
               	ldurb	w26, [x29, #-0x70]
               	mov	x17, #0x75              // =117
               	eor	x25, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x25, x17
               	cmp	x26, #0x0
               	b.ne	0x4011ec <.text+0xf6c>
               	b	0x4011dc <.text+0xf5c>
               	b	0x400d00 <.text+0xa80>
               	ldurb	w25, [x29, #-0x70]
               	mov	x17, #0x70              // =112
               	eor	x28, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x28, x17
               	cmp	x25, #0x0
               	b.ne	0x401530 <.text+0x12b0>
               	b	0x4014c8 <.text+0x1248>
               	mov	x26, #0xa               // =10
               	sub	x17, x29, #0x190
               	str	x26, [x17]
               	b	0x4011fc <.text+0xf7c>
               	mov	x26, #0x10              // =16
               	sub	x17, x29, #0x190
               	str	x26, [x17]
               	b	0x4011fc <.text+0xf7c>
               	sub	x16, x29, #0x190
               	ldr	x27, [x16]
               	mov	x0, x23
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x28
               	bl	0x4003d0 <.text+0x150>
               	mov	x25, x0
               	stur	w25, [x29, #-0x18]
               	mov	x27, #0x1f              // =31
               	ldursw	x25, [x29, #-0x18]
               	sub	x24, x27, x25
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	ldursw	x25, [x29, #-0x48]
               	cbz	x25, 0x40124c <.text+0xfcc>
               	ldursw	x24, [x29, #-0x40]
               	sub	x17, x29, #0x198
               	str	x24, [x17]
               	b	0x40125c <.text+0xfdc>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x198
               	str	x24, [x17]
               	b	0x40125c <.text+0xfdc>
               	sub	x16, x29, #0x198
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0xb8]
               	mov	x25, #0x0               // =0
               	stur	w25, [x29, #-0xc0]
               	ldursw	x24, [x29, #-0x60]
               	ldursw	x25, [x29, #-0xb8]
               	cmp	x24, x25
               	b.ge	0x4012a8 <.text+0x1028>
               	ldursw	x25, [x29, #-0xb8]
               	ldursw	x27, [x29, #-0x60]
               	sub	x24, x25, x27
               	sxtw	x24, w24
               	stur	w24, [x29, #-0xc0]
               	ldursw	x25, [x29, #-0xc0]
               	add	x24, x27, x25
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	b	0x4012a8 <.text+0x1028>
               	ldursw	x24, [x29, #-0x38]
               	ldursw	x25, [x29, #-0x60]
               	cmp	x24, x25
               	b.le	0x4012d4 <.text+0x1054>
               	ldursw	x25, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x24, x25, x27
               	sxtw	x24, w24
               	sub	x17, x29, #0x1a0
               	str	x24, [x17]
               	b	0x4012e4 <.text+0x1064>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x1a0
               	str	x24, [x17]
               	b	0x4012e4 <.text+0x1064>
               	sub	x16, x29, #0x1a0
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x58]
               	sub	x17, x29, #0x1b0
               	str	x27, [x17]
               	cbz	x27, 0x401318 <.text+0x1098>
               	ldursw	x24, [x29, #-0x48]
               	cmp	x24, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x1b0
               	str	x27, [x17]
               	b	0x401318 <.text+0x1098>
               	sub	x16, x29, #0x1b0
               	ldr	x27, [x16]
               	sub	x17, x29, #0x1a8
               	str	x27, [x17]
               	cbz	x27, 0x401344 <.text+0x10c4>
               	ldursw	x24, [x29, #-0x50]
               	cmp	x24, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x1a8
               	str	x27, [x17]
               	b	0x401344 <.text+0x10c4>
               	sub	x16, x29, #0x1a8
               	ldr	x27, [x16]
               	cbz	x27, 0x401360 <.text+0x10e0>
               	mov	x24, #0x30              // =48
               	sub	x17, x29, #0x1b8
               	str	x24, [x17]
               	b	0x401370 <.text+0x10f0>
               	mov	x24, #0x20              // =32
               	sub	x17, x29, #0x1b8
               	str	x24, [x17]
               	b	0x401370 <.text+0x10f0>
               	sub	x16, x29, #0x1b8
               	ldr	x24, [x16]
               	sturb	w24, [x29, #-0xc8]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	0x40138c <.text+0x110c>
               	b	0x401390 <.text+0x1110>
               	b	0x4013d4 <.text+0x1154>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	0x4013d0 <.text+0x1150>
               	sub	x26, x29, #0x8
               	ldurb	w27, [x29, #-0xc8]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x68]
               	sub	x27, x25, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x68]
               	b	0x401390 <.text+0x1110>
               	b	0x40138c <.text+0x110c>
               	ldursw	x27, [x29, #-0xc0]
               	cmp	x27, #0x0
               	b.le	0x401414 <.text+0x1194>
               	sub	x24, x29, #0x8
               	mov	x27, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0xc0]
               	sub	x27, x26, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0xc0]
               	b	0x4013d4 <.text+0x1154>
               	b	0x401418 <.text+0x1198>
               	ldursw	x27, [x29, #-0x18]
               	cmp	x27, #0x1f
               	b.ge	0x401464 <.text+0x11e4>
               	sub	x25, x29, #0x8
               	sub	x26, x29, #0x90
               	ldursw	x24, [x29, #-0x18]
               	add	x28, x26, x24
               	ldrb	w27, [x28]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x28, x0
               	ldursw	x28, [x29, #-0x18]
               	add	x27, x28, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x18]
               	b	0x401418 <.text+0x1198>
               	ldursw	x27, [x29, #-0x50]
               	cbz	x27, 0x401470 <.text+0x11f0>
               	b	0x401484 <.text+0x1204>
               	ldursw	x28, [x29, #-0x10]
               	add	x25, x28, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x4011b4 <.text+0xf34>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	0x4014c4 <.text+0x1244>
               	sub	x24, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x68]
               	sub	x28, x25, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x401484 <.text+0x1204>
               	b	0x401470 <.text+0x11f0>
               	add	x25, x29, #0x40
               	ldr	x28, [x25]
               	add	x17, x28, #0x10
               	str	x17, [x25]
               	ldrsw	x25, [x28]
               	stur	w25, [x29, #-0x20]
               	sub	x27, x29, #0x8
               	mov	x28, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x24, x0
               	sub	x25, x29, #0x8
               	mov	x24, #0x78              // =120
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x27, x0
               	mov	x27, #0xf               // =15
               	stur	w27, [x29, #-0x18]
               	b	0x401554 <.text+0x12d4>
               	b	0x4011b4 <.text+0xf34>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x63              // =99
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	b.ne	0x401644 <.text+0x13c4>
               	b	0x401618 <.text+0x1398>
               	ldursw	x27, [x29, #-0x18]
               	cmp	x27, #0x0
               	b.lt	0x401590 <.text+0x1310>
               	ldursw	x27, [x29, #-0x20]
               	ldursw	x24, [x29, #-0x18]
               	lsl	x25, x24, #2
               	sxtw	x25, w25
               	asr	x24, x27, x25
               	mov	x17, #0xf               // =15
               	and	x25, x24, x17
               	stur	w25, [x29, #-0x30]
               	ldursw	x24, [x29, #-0x30]
               	cmp	x24, #0xa
               	b.ge	0x4015e4 <.text+0x1364>
               	b	0x4015a4 <.text+0x1324>
               	ldursw	x28, [x29, #-0x10]
               	add	x24, x28, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x40152c <.text+0x12ac>
               	sub	x28, x29, #0x8
               	ldursw	x25, [x29, #-0x30]
               	add	x27, x25, #0x30
               	sxtw	x24, w27
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x28
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x25, x0
               	b	0x4015d0 <.text+0x1350>
               	ldursw	x24, [x29, #-0x18]
               	sub	x28, x24, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x18]
               	b	0x401554 <.text+0x12d4>
               	sub	x27, x29, #0x8
               	ldursw	x25, [x29, #-0x30]
               	add	x28, x25, #0x61
               	sxtw	x28, w28
               	sub	x25, x28, #0xa
               	sxtw	x24, w25
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x28, x0
               	b	0x4015d0 <.text+0x1350>
               	add	x24, x29, #0x40
               	ldr	x28, [x24]
               	add	x17, x28, #0x10
               	str	x17, [x24]
               	ldrsw	x24, [x28]
               	stur	w24, [x29, #-0xd0]
               	ldursw	x28, [x29, #-0x38]
               	cmp	x28, #0x1
               	b.le	0x401680 <.text+0x1400>
               	b	0x401668 <.text+0x13e8>
               	b	0x40152c <.text+0x12ac>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x73              // =115
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	b.ne	0x4017a4 <.text+0x1524>
               	b	0x401778 <.text+0x14f8>
               	ldursw	x28, [x29, #-0x38]
               	sub	x24, x28, #0x1
               	sxtw	x24, w24
               	sub	x17, x29, #0x1c0
               	str	x24, [x17]
               	b	0x401690 <.text+0x1410>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x1c0
               	str	x24, [x17]
               	b	0x401690 <.text+0x1410>
               	sub	x16, x29, #0x1c0
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0x68]
               	ldursw	x28, [x29, #-0x50]
               	cmp	x28, #0x0
               	b.ne	0x4016ac <.text+0x142c>
               	b	0x4016d8 <.text+0x1458>
               	sub	x24, x29, #0x8
               	ldursw	x28, [x29, #-0xd0]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x50]
               	cbz	x25, 0x401720 <.text+0x14a0>
               	b	0x40171c <.text+0x149c>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	0x401718 <.text+0x1498>
               	sub	x25, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x27, x0
               	ldursw	x27, [x29, #-0x68]
               	sub	x28, x27, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x4016d8 <.text+0x1458>
               	b	0x4016ac <.text+0x142c>
               	b	0x401734 <.text+0x14b4>
               	ldursw	x28, [x29, #-0x10]
               	add	x24, x28, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x401640 <.text+0x13c0>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	0x401774 <.text+0x14f4>
               	sub	x27, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x68]
               	sub	x28, x24, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x401734 <.text+0x14b4>
               	b	0x401720 <.text+0x14a0>
               	add	x24, x29, #0x40
               	ldr	x28, [x24]
               	add	x17, x28, #0x10
               	str	x17, [x24]
               	ldr	x24, [x28]
               	stur	x24, [x29, #-0x98]
               	ldur	x28, [x29, #-0x98]
               	cmp	x28, #0x0
               	b.ne	0x4017dc <.text+0x155c>
               	b	0x4017c8 <.text+0x1548>
               	b	0x401640 <.text+0x13c0>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x25              // =37
               	eor	x26, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	cmp	x24, #0x0
               	b.ne	0x4019f8 <.text+0x1778>
               	b	0x4019c0 <.text+0x1740>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x141
               	mov	x28, x19
               	stur	x28, [x29, #-0x98]
               	b	0x4017dc <.text+0x155c>
               	mov	x28, #0x0               // =0
               	stur	w28, [x29, #-0x60]
               	b	0x4017e8 <.text+0x1568>
               	ldur	x28, [x29, #-0x98]
               	ldursw	x24, [x29, #-0x60]
               	add	x27, x28, x24
               	ldrb	w24, [x27]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	cmp	x27, #0x0
               	b.eq	0x401820 <.text+0x15a0>
               	ldursw	x27, [x29, #-0x60]
               	add	x24, x27, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	b	0x4017e8 <.text+0x1568>
               	ldursw	x24, [x29, #-0x48]
               	sub	x17, x29, #0x1c8
               	str	x24, [x17]
               	cbz	x24, 0x40184c <.text+0x15cc>
               	ldursw	x27, [x29, #-0x40]
               	ldursw	x24, [x29, #-0x60]
               	cmp	x27, x24
               	cset	x28, lt
               	sub	x17, x29, #0x1c8
               	str	x28, [x17]
               	b	0x40184c <.text+0x15cc>
               	sub	x16, x29, #0x1c8
               	ldr	x28, [x16]
               	cbz	x28, 0x401864 <.text+0x15e4>
               	ldursw	x24, [x29, #-0x40]
               	stur	w24, [x29, #-0x60]
               	b	0x401864 <.text+0x15e4>
               	ldursw	x24, [x29, #-0x38]
               	ldursw	x28, [x29, #-0x60]
               	cmp	x24, x28
               	b.le	0x401890 <.text+0x1610>
               	ldursw	x28, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x24, x28, x27
               	sxtw	x24, w24
               	sub	x17, x29, #0x1d0
               	str	x24, [x17]
               	b	0x4018a0 <.text+0x1620>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x1d0
               	str	x24, [x17]
               	b	0x4018a0 <.text+0x1620>
               	sub	x16, x29, #0x1d0
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	0x4018bc <.text+0x163c>
               	b	0x4018c8 <.text+0x1648>
               	mov	x27, #0x0               // =0
               	stur	w27, [x29, #-0x18]
               	b	0x40190c <.text+0x168c>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	0x401908 <.text+0x1688>
               	sub	x25, x29, #0x8
               	mov	x27, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x28, x0
               	ldursw	x28, [x29, #-0x68]
               	sub	x27, x28, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x68]
               	b	0x4018c8 <.text+0x1648>
               	b	0x4018bc <.text+0x163c>
               	ldursw	x27, [x29, #-0x18]
               	ldursw	x28, [x29, #-0x60]
               	cmp	x27, x28
               	b.ge	0x40195c <.text+0x16dc>
               	sub	x24, x29, #0x8
               	ldur	x25, [x29, #-0x98]
               	ldursw	x27, [x29, #-0x18]
               	add	x26, x25, x27
               	ldrb	w28, [x26]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0x18]
               	add	x28, x26, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x18]
               	b	0x40190c <.text+0x168c>
               	ldursw	x28, [x29, #-0x50]
               	cbz	x28, 0x401968 <.text+0x16e8>
               	b	0x40197c <.text+0x16fc>
               	ldursw	x26, [x29, #-0x10]
               	add	x24, x26, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x4017a0 <.text+0x1520>
               	ldursw	x26, [x29, #-0x68]
               	cmp	x26, #0x0
               	b.le	0x4019bc <.text+0x173c>
               	sub	x27, x29, #0x8
               	mov	x26, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x68]
               	sub	x26, x24, #0x1
               	sxtw	x26, w26
               	stur	w26, [x29, #-0x68]
               	b	0x40197c <.text+0x16fc>
               	b	0x401968 <.text+0x16e8>
               	sub	x28, x29, #0x8
               	mov	x24, #0x25              // =37
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x28
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x27, x0
               	ldursw	x27, [x29, #-0x10]
               	add	x24, x27, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x4019f4 <.text+0x1774>
               	b	0x4017a0 <.text+0x1520>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	cmp	x27, #0x0
               	b.ne	0x401a18 <.text+0x1798>
               	b	0x401a14 <.text+0x1794>
               	b	0x4019f4 <.text+0x1774>
               	sub	x26, x29, #0x8
               	mov	x27, #0x25              // =37
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x28, x0
               	sub	x24, x29, #0x8
               	ldurb	w28, [x29, #-0x70]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x400538 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0x10]
               	add	x28, x26, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x10]
               	b	0x401a14 <.text+0x1794>
               	ldursw	x26, [x29, #-0x8]
               	cmp	x26, x21
               	b.ge	0x401ad4 <.text+0x1854>
               	b	0x401abc <.text+0x183c>
               	ldursw	x26, [x29, #-0x8]
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldursw	x26, [x29, #-0x8]
               	add	x28, x20, x26
               	mov	x26, #0x0               // =0
               	strb	w26, [x28]
               	b	0x401ad0 <.text+0x1850>
               	b	0x401a7c <.text+0x17fc>
               	sub	x26, x21, #0x1
               	sxtw	x26, w26
               	add	x21, x20, x26
               	mov	x26, #0x0               // =0
               	strb	w26, [x21]
               	b	0x401ad0 <.text+0x1850>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x30
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	ldur	x20, [x29, #0x10]
               	ldursw	x21, [x29, #0x20]
               	ldur	x22, [x29, #0x30]
               	ldur	x23, [x29, #-0x8]
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4005c0 <.text+0x340>
               	mov	x11, x0
               	sub	x23, x29, #0x8
               	sxtw	x22, w11
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	sub	x20, x29, #0x40
               	mov	x21, #0x40              // =64
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x14e
               	mov	x23, x19
               	mov	x24, #0x1               // =1
               	str	x24, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	0x401aec <.text+0x186c>
               	add	sp, sp, #0x50
               	mov	x10, x0
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
