
deferred_libc_vfprintf_va_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x401bf0 <.text+0x18f0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
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
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x126
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x401e58 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	b.ne	0x4004d0 <.text+0x1d0>
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
               	b	0x4004d4 <.text+0x1d4>
               	ldursw	x11, [x29, #0x30]
               	cmp	x11, #0x0
               	b.eq	0x4004ec <.text+0x1ec>
               	cmp	x12, #0xa
               	b.ne	0x400544 <.text+0x244>
               	b	0x400504 <.text+0x204>
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
               	b	0x400524 <.text+0x224>
               	ldursw	x10, [x29, #-0x8]
               	sub	x0, x10, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x10, [x29, #-0x10]
               	cmp	x10, #0xa
               	b.ge	0x400594 <.text+0x294>
               	b	0x400574 <.text+0x274>
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
               	b	0x400524 <.text+0x224>
               	ldursw	x10, [x29, #-0x8]
               	add	x0, x15, x10
               	ldursw	x10, [x29, #-0x10]
               	add	x11, x10, #0x30
               	sxtw	x11, w11
               	strb	w11, [x0]
               	b	0x400590 <.text+0x290>
               	b	0x4004d4 <.text+0x1d4>
               	ldursw	x11, [x29, #-0x8]
               	add	x10, x15, x11
               	ldursw	x11, [x29, #-0x10]
               	add	x0, x11, #0x61
               	sxtw	x0, w0
               	sub	x11, x0, #0xa
               	sxtw	x11, w11
               	strb	w11, [x10]
               	b	0x400590 <.text+0x290>
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
               	cbz	x11, 0x400600 <.text+0x300>
               	ldrsw	x10, [x13]
               	add	x11, x10, #0x1
               	sxtw	x11, w11
               	cmp	x11, x14
               	cset	x10, lt
               	stur	x10, [x29, #-0x8]
               	b	0x400600 <.text+0x300>
               	ldur	x10, [x29, #-0x8]
               	cbz	x10, 0x400620 <.text+0x320>
               	ldrsw	x11, [x13]
               	add	x10, x15, x11
               	mov	x17, #0xff              // =255
               	and	x11, x12, x17
               	strb	w11, [x10]
               	b	0x400620 <.text+0x320>
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
               	b	0x4006a0 <.text+0x3a0>
               	ldursw	x11, [x29, #-0x10]
               	add	x12, x22, x11
               	ldrb	w11, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x11, x17
               	cmp	x12, #0x0
               	b.eq	0x4006f4 <.text+0x3f4>
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
               	b.eq	0x400734 <.text+0x434>
               	b	0x400700 <.text+0x400>
               	cmp	x21, #0x0
               	b.le	0x401afc <.text+0x17fc>
               	b	0x401aec <.text+0x17ec>
               	sub	x23, x29, #0x8
               	ldurb	w24, [x29, #-0x70]
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x10, x0
               	ldursw	x10, [x29, #-0x10]
               	add	x24, x10, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x4006a0 <.text+0x3a0>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x24, #0x1
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x10]
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x50]
               	stur	w24, [x29, #-0x58]
               	b	0x400754 <.text+0x454>
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
               	cbnz	x10, 0x400820 <.text+0x520>
               	b	0x4007ec <.text+0x4ec>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x2d              // =45
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	b.ne	0x400910 <.text+0x610>
               	b	0x4008f0 <.text+0x5f0>
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
               	b.ne	0x4009a8 <.text+0x6a8>
               	b	0x400948 <.text+0x648>
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
               	b	0x400820 <.text+0x520>
               	sub	x16, x29, #0x110
               	ldr	x10, [x16]
               	sub	x17, x29, #0x108
               	str	x10, [x17]
               	cbnz	x10, 0x400868 <.text+0x568>
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
               	b	0x400868 <.text+0x568>
               	sub	x16, x29, #0x108
               	ldr	x10, [x16]
               	stur	x10, [x29, #-0x100]
               	cbnz	x10, 0x4008a8 <.text+0x5a8>
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
               	b	0x4008a8 <.text+0x5a8>
               	ldur	x10, [x29, #-0x100]
               	stur	x10, [x29, #-0xf8]
               	cbnz	x10, 0x4008e4 <.text+0x5e4>
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
               	b	0x4008e4 <.text+0x5e4>
               	ldur	x10, [x29, #-0xf8]
               	cbz	x10, 0x4007b8 <.text+0x4b8>
               	b	0x40078c <.text+0x48c>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x50]
               	b	0x4008fc <.text+0x5fc>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x24, #0x1
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x10]
               	b	0x400754 <.text+0x454>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	mov	x17, #0x30              // =48
               	eor	x10, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x10, x17
               	cmp	x24, #0x0
               	b.ne	0x400944 <.text+0x644>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x58]
               	b	0x400944 <.text+0x644>
               	b	0x4008fc <.text+0x5fc>
               	add	x24, x29, #0x40
               	ldr	x10, [x24]
               	add	x17, x10, #0x10
               	str	x17, [x24]
               	ldrsw	x24, [x10]
               	stur	w24, [x29, #-0x38]
               	ldursw	x10, [x29, #-0x38]
               	cmp	x10, #0x0
               	b.ge	0x4009d4 <.text+0x6d4>
               	b	0x4009ac <.text+0x6ac>
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
               	b.ne	0x400ac4 <.text+0x7c4>
               	b	0x400a80 <.text+0x780>
               	b	0x4009e8 <.text+0x6e8>
               	mov	x10, #0x1               // =1
               	stur	w10, [x29, #-0x50]
               	ldursw	x24, [x29, #-0x38]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x10, x24, x17
               	stur	w10, [x29, #-0x38]
               	b	0x4009d4 <.text+0x6d4>
               	ldursw	x10, [x29, #-0x10]
               	add	x24, x10, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x400970 <.text+0x670>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	cmp	x24, #0x30
               	cset	x10, ge
               	sub	x17, x29, #0x118
               	str	x10, [x17]
               	cbz	x10, 0x400a70 <.text+0x770>
               	b	0x400a50 <.text+0x750>
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
               	b	0x4009e8 <.text+0x6e8>
               	b	0x400970 <.text+0x670>
               	ldursw	x24, [x29, #-0x10]
               	add	x10, x22, x24
               	ldrb	w24, [x10]
               	cmp	x24, #0x39
               	cset	x10, le
               	sub	x17, x29, #0x118
               	str	x10, [x17]
               	b	0x400a70 <.text+0x770>
               	sub	x16, x29, #0x118
               	ldr	x10, [x16]
               	cbz	x10, 0x400a4c <.text+0x74c>
               	b	0x400a0c <.text+0x70c>
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
               	b.ne	0x400af4 <.text+0x7f4>
               	b	0x400ac8 <.text+0x7c8>
               	b	0x400bb4 <.text+0x8b4>
               	add	x23, x29, #0x40
               	ldr	x24, [x23]
               	add	x17, x24, #0x10
               	str	x17, [x23]
               	ldrsw	x23, [x24]
               	stur	w23, [x29, #-0x40]
               	ldursw	x24, [x29, #-0x40]
               	cmp	x24, #0x0
               	b.ge	0x400b08 <.text+0x808>
               	b	0x400af8 <.text+0x7f8>
               	b	0x400ac4 <.text+0x7c4>
               	b	0x400b1c <.text+0x81c>
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x48]
               	stur	w24, [x29, #-0x40]
               	b	0x400b08 <.text+0x808>
               	ldursw	x24, [x29, #-0x10]
               	add	x23, x24, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400af0 <.text+0x7f0>
               	ldursw	x23, [x29, #-0x10]
               	add	x24, x22, x23
               	ldrb	w23, [x24]
               	cmp	x23, #0x30
               	cset	x24, ge
               	sub	x17, x29, #0x120
               	str	x24, [x17]
               	cbz	x24, 0x400ba4 <.text+0x8a4>
               	b	0x400b84 <.text+0x884>
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
               	b	0x400b1c <.text+0x81c>
               	b	0x400af0 <.text+0x7f0>
               	ldursw	x23, [x29, #-0x10]
               	add	x24, x22, x23
               	ldrb	w23, [x24]
               	cmp	x23, #0x39
               	cset	x24, le
               	sub	x17, x29, #0x120
               	str	x24, [x17]
               	b	0x400ba4 <.text+0x8a4>
               	sub	x16, x29, #0x120
               	ldr	x24, [x16]
               	cbz	x24, 0x400b80 <.text+0x880>
               	b	0x400b40 <.text+0x840>
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
               	cbnz	x23, 0x400c68 <.text+0x968>
               	b	0x400c34 <.text+0x934>
               	ldursw	x9, [x29, #-0x10]
               	add	x23, x9, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x10]
               	b	0x400bb4 <.text+0x8b4>
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
               	b.ne	0x400d84 <.text+0xa84>
               	b	0x400d50 <.text+0xa50>
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
               	b	0x400c68 <.text+0x968>
               	sub	x16, x29, #0x140
               	ldr	x23, [x16]
               	sub	x17, x29, #0x138
               	str	x23, [x17]
               	cbnz	x23, 0x400cb0 <.text+0x9b0>
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
               	b	0x400cb0 <.text+0x9b0>
               	sub	x16, x29, #0x138
               	ldr	x23, [x16]
               	sub	x17, x29, #0x130
               	str	x23, [x17]
               	cbnz	x23, 0x400cf8 <.text+0x9f8>
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
               	b	0x400cf8 <.text+0x9f8>
               	sub	x16, x29, #0x130
               	ldr	x23, [x16]
               	sub	x17, x29, #0x128
               	str	x23, [x17]
               	cbnz	x23, 0x400d40 <.text+0xa40>
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
               	b	0x400d40 <.text+0xa40>
               	sub	x16, x29, #0x128
               	ldr	x23, [x16]
               	cbz	x23, 0x400c00 <.text+0x900>
               	b	0x400bec <.text+0x8ec>
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
               	b.ge	0x400ddc <.text+0xadc>
               	b	0x400db4 <.text+0xab4>
               	b	0x4006a0 <.text+0x3a0>
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
               	cbnz	x28, 0x4011a0 <.text+0xea0>
               	b	0x401174 <.text+0xe74>
               	mov	x9, #0x1                // =1
               	stur	w9, [x29, #-0x28]
               	ldursw	x23, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x9, x23, x17
               	stur	w9, [x29, #-0x20]
               	b	0x400ddc <.text+0xadc>
               	sub	x25, x29, #0x90
               	mov	x26, #0x1f              // =31
               	ldursw	x23, [x29, #-0x20]
               	mov	x27, #0xa               // =10
               	mov	x0, x25
               	mov	x3, x27
               	mov	x2, x23
               	mov	x1, x26
               	bl	0x400450 <.text+0x150>
               	mov	x8, x0
               	stur	w8, [x29, #-0x18]
               	ldursw	x27, [x29, #-0x18]
               	sub	x8, x26, x27
               	sxtw	x8, w8
               	stur	w8, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400e34 <.text+0xb34>
               	ldursw	x8, [x29, #-0x60]
               	add	x27, x8, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x60]
               	b	0x400e34 <.text+0xb34>
               	ldursw	x27, [x29, #-0x48]
               	cbz	x27, 0x400e4c <.text+0xb4c>
               	ldursw	x8, [x29, #-0x40]
               	sub	x17, x29, #0x148
               	str	x8, [x17]
               	b	0x400e5c <.text+0xb5c>
               	mov	x8, #0x0                // =0
               	sub	x17, x29, #0x148
               	str	x8, [x17]
               	b	0x400e5c <.text+0xb5c>
               	sub	x16, x29, #0x148
               	ldr	x8, [x16]
               	stur	w8, [x29, #-0xa0]
               	mov	x27, #0x0               // =0
               	stur	w27, [x29, #-0xa8]
               	ldursw	x8, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400e8c <.text+0xb8c>
               	mov	x26, #0x1               // =1
               	sub	x17, x29, #0x150
               	str	x26, [x17]
               	b	0x400e9c <.text+0xb9c>
               	mov	x26, #0x0               // =0
               	sub	x17, x29, #0x150
               	str	x26, [x17]
               	b	0x400e9c <.text+0xb9c>
               	sub	x16, x29, #0x150
               	ldr	x26, [x16]
               	sub	x27, x8, x26
               	sxtw	x27, w27
               	ldursw	x26, [x29, #-0xa0]
               	cmp	x27, x26
               	b.ge	0x400ecc <.text+0xbcc>
               	ldursw	x26, [x29, #-0xa0]
               	ldursw	x8, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x400ef0 <.text+0xbf0>
               	b	0x400ee0 <.text+0xbe0>
               	ldursw	x26, [x29, #-0x38]
               	ldursw	x23, [x29, #-0x60]
               	cmp	x26, x23
               	b.le	0x400f50 <.text+0xc50>
               	b	0x400f34 <.text+0xc34>
               	mov	x23, #0x1               // =1
               	sub	x17, x29, #0x158
               	str	x23, [x17]
               	b	0x400f00 <.text+0xc00>
               	mov	x23, #0x0               // =0
               	sub	x17, x29, #0x158
               	str	x23, [x17]
               	b	0x400f00 <.text+0xc00>
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
               	b	0x400ecc <.text+0xbcc>
               	ldursw	x23, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x26, x23, x27
               	sxtw	x26, w26
               	sub	x17, x29, #0x160
               	str	x26, [x17]
               	b	0x400f60 <.text+0xc60>
               	mov	x26, #0x0               // =0
               	sub	x17, x29, #0x160
               	str	x26, [x17]
               	b	0x400f60 <.text+0xc60>
               	sub	x16, x29, #0x160
               	ldr	x26, [x16]
               	stur	w26, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x58]
               	sub	x17, x29, #0x170
               	str	x27, [x17]
               	cbz	x27, 0x400f94 <.text+0xc94>
               	ldursw	x26, [x29, #-0x48]
               	cmp	x26, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x170
               	str	x27, [x17]
               	b	0x400f94 <.text+0xc94>
               	sub	x16, x29, #0x170
               	ldr	x27, [x16]
               	sub	x17, x29, #0x168
               	str	x27, [x17]
               	cbz	x27, 0x400fc0 <.text+0xcc0>
               	ldursw	x26, [x29, #-0x50]
               	cmp	x26, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x168
               	str	x27, [x17]
               	b	0x400fc0 <.text+0xcc0>
               	sub	x16, x29, #0x168
               	ldr	x27, [x16]
               	cbz	x27, 0x400fdc <.text+0xcdc>
               	mov	x26, #0x30              // =48
               	sub	x17, x29, #0x178
               	str	x26, [x17]
               	b	0x400fec <.text+0xcec>
               	mov	x26, #0x20              // =32
               	sub	x17, x29, #0x178
               	str	x26, [x17]
               	b	0x400fec <.text+0xcec>
               	sub	x16, x29, #0x178
               	ldr	x26, [x16]
               	sturb	w26, [x29, #-0xb0]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	0x401008 <.text+0xd08>
               	b	0x401014 <.text+0xd14>
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, 0x40107c <.text+0xd7c>
               	b	0x401058 <.text+0xd58>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	0x401054 <.text+0xd54>
               	sub	x24, x29, #0x8
               	ldurb	w27, [x29, #-0xb0]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x23, x0
               	ldursw	x23, [x29, #-0x68]
               	sub	x27, x23, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x68]
               	b	0x401014 <.text+0xd14>
               	b	0x401008 <.text+0xd08>
               	sub	x26, x29, #0x8
               	mov	x23, #0x2d              // =45
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x24, x0
               	b	0x40107c <.text+0xd7c>
               	b	0x401080 <.text+0xd80>
               	ldursw	x23, [x29, #-0xa8]
               	cmp	x23, #0x0
               	b.le	0x4010c0 <.text+0xdc0>
               	sub	x27, x29, #0x8
               	mov	x23, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0xa8]
               	sub	x23, x26, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0xa8]
               	b	0x401080 <.text+0xd80>
               	b	0x4010c4 <.text+0xdc4>
               	ldursw	x23, [x29, #-0x18]
               	cmp	x23, #0x1f
               	b.ge	0x401110 <.text+0xe10>
               	sub	x24, x29, #0x8
               	sub	x26, x29, #0x90
               	ldursw	x27, [x29, #-0x18]
               	add	x8, x26, x27
               	ldrb	w23, [x8]
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x8, x0
               	ldursw	x8, [x29, #-0x18]
               	add	x23, x8, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x18]
               	b	0x4010c4 <.text+0xdc4>
               	ldursw	x23, [x29, #-0x50]
               	cbz	x23, 0x40111c <.text+0xe1c>
               	b	0x401130 <.text+0xe30>
               	ldursw	x28, [x29, #-0x10]
               	add	x24, x28, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x400d80 <.text+0xa80>
               	ldursw	x8, [x29, #-0x68]
               	cmp	x8, #0x0
               	b.le	0x401170 <.text+0xe70>
               	sub	x27, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x68]
               	sub	x28, x24, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x401130 <.text+0xe30>
               	b	0x40111c <.text+0xe1c>
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
               	b	0x4011a0 <.text+0xea0>
               	sub	x16, x29, #0x188
               	ldr	x28, [x16]
               	sub	x17, x29, #0x180
               	str	x28, [x17]
               	cbnz	x28, 0x4011e0 <.text+0xee0>
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
               	b	0x4011e0 <.text+0xee0>
               	sub	x16, x29, #0x180
               	ldr	x28, [x16]
               	cbz	x28, 0x401238 <.text+0xf38>
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
               	b.ne	0x40126c <.text+0xf6c>
               	b	0x40125c <.text+0xf5c>
               	b	0x400d80 <.text+0xa80>
               	ldurb	w25, [x29, #-0x70]
               	mov	x17, #0x70              // =112
               	eor	x28, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x28, x17
               	cmp	x25, #0x0
               	b.ne	0x4015b0 <.text+0x12b0>
               	b	0x401548 <.text+0x1248>
               	mov	x26, #0xa               // =10
               	sub	x17, x29, #0x190
               	str	x26, [x17]
               	b	0x40127c <.text+0xf7c>
               	mov	x26, #0x10              // =16
               	sub	x17, x29, #0x190
               	str	x26, [x17]
               	b	0x40127c <.text+0xf7c>
               	sub	x16, x29, #0x190
               	ldr	x27, [x16]
               	mov	x0, x23
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x28
               	bl	0x400450 <.text+0x150>
               	mov	x25, x0
               	stur	w25, [x29, #-0x18]
               	mov	x27, #0x1f              // =31
               	ldursw	x25, [x29, #-0x18]
               	sub	x24, x27, x25
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	ldursw	x25, [x29, #-0x48]
               	cbz	x25, 0x4012cc <.text+0xfcc>
               	ldursw	x24, [x29, #-0x40]
               	sub	x17, x29, #0x198
               	str	x24, [x17]
               	b	0x4012dc <.text+0xfdc>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x198
               	str	x24, [x17]
               	b	0x4012dc <.text+0xfdc>
               	sub	x16, x29, #0x198
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0xb8]
               	mov	x25, #0x0               // =0
               	stur	w25, [x29, #-0xc0]
               	ldursw	x24, [x29, #-0x60]
               	ldursw	x25, [x29, #-0xb8]
               	cmp	x24, x25
               	b.ge	0x401328 <.text+0x1028>
               	ldursw	x25, [x29, #-0xb8]
               	ldursw	x27, [x29, #-0x60]
               	sub	x24, x25, x27
               	sxtw	x24, w24
               	stur	w24, [x29, #-0xc0]
               	ldursw	x25, [x29, #-0xc0]
               	add	x24, x27, x25
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	b	0x401328 <.text+0x1028>
               	ldursw	x24, [x29, #-0x38]
               	ldursw	x25, [x29, #-0x60]
               	cmp	x24, x25
               	b.le	0x401354 <.text+0x1054>
               	ldursw	x25, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x24, x25, x27
               	sxtw	x24, w24
               	sub	x17, x29, #0x1a0
               	str	x24, [x17]
               	b	0x401364 <.text+0x1064>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x1a0
               	str	x24, [x17]
               	b	0x401364 <.text+0x1064>
               	sub	x16, x29, #0x1a0
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x58]
               	sub	x17, x29, #0x1b0
               	str	x27, [x17]
               	cbz	x27, 0x401398 <.text+0x1098>
               	ldursw	x24, [x29, #-0x48]
               	cmp	x24, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x1b0
               	str	x27, [x17]
               	b	0x401398 <.text+0x1098>
               	sub	x16, x29, #0x1b0
               	ldr	x27, [x16]
               	sub	x17, x29, #0x1a8
               	str	x27, [x17]
               	cbz	x27, 0x4013c4 <.text+0x10c4>
               	ldursw	x24, [x29, #-0x50]
               	cmp	x24, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x1a8
               	str	x27, [x17]
               	b	0x4013c4 <.text+0x10c4>
               	sub	x16, x29, #0x1a8
               	ldr	x27, [x16]
               	cbz	x27, 0x4013e0 <.text+0x10e0>
               	mov	x24, #0x30              // =48
               	sub	x17, x29, #0x1b8
               	str	x24, [x17]
               	b	0x4013f0 <.text+0x10f0>
               	mov	x24, #0x20              // =32
               	sub	x17, x29, #0x1b8
               	str	x24, [x17]
               	b	0x4013f0 <.text+0x10f0>
               	sub	x16, x29, #0x1b8
               	ldr	x24, [x16]
               	sturb	w24, [x29, #-0xc8]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	0x40140c <.text+0x110c>
               	b	0x401410 <.text+0x1110>
               	b	0x401454 <.text+0x1154>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	0x401450 <.text+0x1150>
               	sub	x26, x29, #0x8
               	ldurb	w27, [x29, #-0xc8]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x68]
               	sub	x27, x25, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x68]
               	b	0x401410 <.text+0x1110>
               	b	0x40140c <.text+0x110c>
               	ldursw	x27, [x29, #-0xc0]
               	cmp	x27, #0x0
               	b.le	0x401494 <.text+0x1194>
               	sub	x24, x29, #0x8
               	mov	x27, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0xc0]
               	sub	x27, x26, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0xc0]
               	b	0x401454 <.text+0x1154>
               	b	0x401498 <.text+0x1198>
               	ldursw	x27, [x29, #-0x18]
               	cmp	x27, #0x1f
               	b.ge	0x4014e4 <.text+0x11e4>
               	sub	x25, x29, #0x8
               	sub	x26, x29, #0x90
               	ldursw	x24, [x29, #-0x18]
               	add	x28, x26, x24
               	ldrb	w27, [x28]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x28, x0
               	ldursw	x28, [x29, #-0x18]
               	add	x27, x28, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x18]
               	b	0x401498 <.text+0x1198>
               	ldursw	x27, [x29, #-0x50]
               	cbz	x27, 0x4014f0 <.text+0x11f0>
               	b	0x401504 <.text+0x1204>
               	ldursw	x28, [x29, #-0x10]
               	add	x25, x28, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	0x401234 <.text+0xf34>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	0x401544 <.text+0x1244>
               	sub	x24, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x68]
               	sub	x28, x25, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x401504 <.text+0x1204>
               	b	0x4014f0 <.text+0x11f0>
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
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x24, x0
               	sub	x25, x29, #0x8
               	mov	x24, #0x78              // =120
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x27, x0
               	mov	x27, #0xf               // =15
               	stur	w27, [x29, #-0x18]
               	b	0x4015d4 <.text+0x12d4>
               	b	0x401234 <.text+0xf34>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x63              // =99
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	b.ne	0x4016c4 <.text+0x13c4>
               	b	0x401698 <.text+0x1398>
               	ldursw	x27, [x29, #-0x18]
               	cmp	x27, #0x0
               	b.lt	0x401610 <.text+0x1310>
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
               	b.ge	0x401664 <.text+0x1364>
               	b	0x401624 <.text+0x1324>
               	ldursw	x28, [x29, #-0x10]
               	add	x24, x28, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x4015ac <.text+0x12ac>
               	sub	x28, x29, #0x8
               	ldursw	x25, [x29, #-0x30]
               	add	x27, x25, #0x30
               	sxtw	x24, w27
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x28
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x25, x0
               	b	0x401650 <.text+0x1350>
               	ldursw	x24, [x29, #-0x18]
               	sub	x28, x24, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x18]
               	b	0x4015d4 <.text+0x12d4>
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
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x28, x0
               	b	0x401650 <.text+0x1350>
               	add	x24, x29, #0x40
               	ldr	x28, [x24]
               	add	x17, x28, #0x10
               	str	x17, [x24]
               	ldrsw	x24, [x28]
               	stur	w24, [x29, #-0xd0]
               	ldursw	x28, [x29, #-0x38]
               	cmp	x28, #0x1
               	b.le	0x401700 <.text+0x1400>
               	b	0x4016e8 <.text+0x13e8>
               	b	0x4015ac <.text+0x12ac>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x73              // =115
               	eor	x28, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x28, x17
               	cmp	x24, #0x0
               	b.ne	0x401824 <.text+0x1524>
               	b	0x4017f8 <.text+0x14f8>
               	ldursw	x28, [x29, #-0x38]
               	sub	x24, x28, #0x1
               	sxtw	x24, w24
               	sub	x17, x29, #0x1c0
               	str	x24, [x17]
               	b	0x401710 <.text+0x1410>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x1c0
               	str	x24, [x17]
               	b	0x401710 <.text+0x1410>
               	sub	x16, x29, #0x1c0
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0x68]
               	ldursw	x28, [x29, #-0x50]
               	cmp	x28, #0x0
               	b.ne	0x40172c <.text+0x142c>
               	b	0x401758 <.text+0x1458>
               	sub	x24, x29, #0x8
               	ldursw	x28, [x29, #-0xd0]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x25, x0
               	ldursw	x25, [x29, #-0x50]
               	cbz	x25, 0x4017a0 <.text+0x14a0>
               	b	0x40179c <.text+0x149c>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	0x401798 <.text+0x1498>
               	sub	x25, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x27, x0
               	ldursw	x27, [x29, #-0x68]
               	sub	x28, x27, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x401758 <.text+0x1458>
               	b	0x40172c <.text+0x142c>
               	b	0x4017b4 <.text+0x14b4>
               	ldursw	x28, [x29, #-0x10]
               	add	x24, x28, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x4016c0 <.text+0x13c0>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	0x4017f4 <.text+0x14f4>
               	sub	x27, x29, #0x8
               	mov	x28, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x68]
               	sub	x28, x24, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x68]
               	b	0x4017b4 <.text+0x14b4>
               	b	0x4017a0 <.text+0x14a0>
               	add	x24, x29, #0x40
               	ldr	x28, [x24]
               	add	x17, x28, #0x10
               	str	x17, [x24]
               	ldr	x24, [x28]
               	stur	x24, [x29, #-0x98]
               	ldur	x28, [x29, #-0x98]
               	cmp	x28, #0x0
               	b.ne	0x40185c <.text+0x155c>
               	b	0x401848 <.text+0x1548>
               	b	0x4016c0 <.text+0x13c0>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0x25              // =37
               	eor	x26, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	cmp	x24, #0x0
               	b.ne	0x401a78 <.text+0x1778>
               	b	0x401a40 <.text+0x1740>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x151
               	mov	x28, x19
               	stur	x28, [x29, #-0x98]
               	b	0x40185c <.text+0x155c>
               	mov	x28, #0x0               // =0
               	stur	w28, [x29, #-0x60]
               	b	0x401868 <.text+0x1568>
               	ldur	x28, [x29, #-0x98]
               	ldursw	x24, [x29, #-0x60]
               	add	x27, x28, x24
               	ldrb	w24, [x27]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	cmp	x27, #0x0
               	b.eq	0x4018a0 <.text+0x15a0>
               	ldursw	x27, [x29, #-0x60]
               	add	x24, x27, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	b	0x401868 <.text+0x1568>
               	ldursw	x24, [x29, #-0x48]
               	sub	x17, x29, #0x1c8
               	str	x24, [x17]
               	cbz	x24, 0x4018cc <.text+0x15cc>
               	ldursw	x27, [x29, #-0x40]
               	ldursw	x24, [x29, #-0x60]
               	cmp	x27, x24
               	cset	x28, lt
               	sub	x17, x29, #0x1c8
               	str	x28, [x17]
               	b	0x4018cc <.text+0x15cc>
               	sub	x16, x29, #0x1c8
               	ldr	x28, [x16]
               	cbz	x28, 0x4018e4 <.text+0x15e4>
               	ldursw	x24, [x29, #-0x40]
               	stur	w24, [x29, #-0x60]
               	b	0x4018e4 <.text+0x15e4>
               	ldursw	x24, [x29, #-0x38]
               	ldursw	x28, [x29, #-0x60]
               	cmp	x24, x28
               	b.le	0x401910 <.text+0x1610>
               	ldursw	x28, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x24, x28, x27
               	sxtw	x24, w24
               	sub	x17, x29, #0x1d0
               	str	x24, [x17]
               	b	0x401920 <.text+0x1620>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x1d0
               	str	x24, [x17]
               	b	0x401920 <.text+0x1620>
               	sub	x16, x29, #0x1d0
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	0x40193c <.text+0x163c>
               	b	0x401948 <.text+0x1648>
               	mov	x27, #0x0               // =0
               	stur	w27, [x29, #-0x18]
               	b	0x40198c <.text+0x168c>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	0x401988 <.text+0x1688>
               	sub	x25, x29, #0x8
               	mov	x27, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x28, x0
               	ldursw	x28, [x29, #-0x68]
               	sub	x27, x28, #0x1
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x68]
               	b	0x401948 <.text+0x1648>
               	b	0x40193c <.text+0x163c>
               	ldursw	x27, [x29, #-0x18]
               	ldursw	x28, [x29, #-0x60]
               	cmp	x27, x28
               	b.ge	0x4019dc <.text+0x16dc>
               	sub	x24, x29, #0x8
               	ldur	x25, [x29, #-0x98]
               	ldursw	x27, [x29, #-0x18]
               	add	x26, x25, x27
               	ldrb	w28, [x26]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0x18]
               	add	x28, x26, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x18]
               	b	0x40198c <.text+0x168c>
               	ldursw	x28, [x29, #-0x50]
               	cbz	x28, 0x4019e8 <.text+0x16e8>
               	b	0x4019fc <.text+0x16fc>
               	ldursw	x26, [x29, #-0x10]
               	add	x24, x26, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x401820 <.text+0x1520>
               	ldursw	x26, [x29, #-0x68]
               	cmp	x26, #0x0
               	b.le	0x401a3c <.text+0x173c>
               	sub	x27, x29, #0x8
               	mov	x26, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x24, x0
               	ldursw	x24, [x29, #-0x68]
               	sub	x26, x24, #0x1
               	sxtw	x26, w26
               	stur	w26, [x29, #-0x68]
               	b	0x4019fc <.text+0x16fc>
               	b	0x4019e8 <.text+0x16e8>
               	sub	x28, x29, #0x8
               	mov	x24, #0x25              // =37
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x28
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x27, x0
               	ldursw	x27, [x29, #-0x10]
               	add	x24, x27, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	0x401a74 <.text+0x1774>
               	b	0x401820 <.text+0x1520>
               	ldurb	w24, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x24, x17
               	cmp	x27, #0x0
               	b.ne	0x401a98 <.text+0x1798>
               	b	0x401a94 <.text+0x1794>
               	b	0x401a74 <.text+0x1774>
               	sub	x26, x29, #0x8
               	mov	x27, #0x25              // =37
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x28, x0
               	sub	x24, x29, #0x8
               	ldurb	w28, [x29, #-0x70]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x4005b8 <.text+0x2b8>
               	mov	x26, x0
               	ldursw	x26, [x29, #-0x10]
               	add	x28, x26, #0x1
               	sxtw	x28, w28
               	stur	w28, [x29, #-0x10]
               	b	0x401a94 <.text+0x1794>
               	ldursw	x26, [x29, #-0x8]
               	cmp	x26, x21
               	b.ge	0x401b54 <.text+0x1854>
               	b	0x401b3c <.text+0x183c>
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
               	b	0x401b50 <.text+0x1850>
               	b	0x401afc <.text+0x17fc>
               	sub	x26, x21, #0x1
               	sxtw	x26, w26
               	add	x21, x20, x26
               	mov	x26, #0x0               // =0
               	strb	w26, [x21]
               	b	0x401b50 <.text+0x1850>
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
               	bl	0x400640 <.text+0x340>
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
               	sub	sp, sp, #0xc0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	sub	x20, x29, #0x40
               	mov	x21, #0x40              // =64
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x23, #0x2a              // =42
               	mov	x24, #0x63              // =99
               	str	x24, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	0x401b6c <.text+0x186c>
               	add	sp, sp, #0x50
               	mov	x10, x0
               	sub	x25, x29, #0x40
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15e
               	mov	x26, x19
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x401e64 <strcmp>
               	sxtw	x0, w0
               	mov	x23, x0
               	cmp	x23, #0x0
               	b.eq	0x401cdc <.text+0x19dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x164
               	mov	x24, x19
               	sub	x23, x29, #0x40
               	mov	x0, x24
               	mov	x1, x23
               	bl	0x401e70 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ede35
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x408368 <exit+0x64ec>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3fa3f8
               	tbz	w21, #0x6, 0x4003bc <.text+0xbc>
               	<unknown>
               	cbnz	w16, 0x470364
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x401970 <.text+0x1670>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x401e7c <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4edf01
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x408434 <exit+0x65b8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3fa4c4
               	tbz	w21, #0x6, 0x400488 <.text+0x188>
               	<unknown>
               	cbnz	w16, 0x470430
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x401a3c <.text+0x173c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<dlsym>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<strcmp>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
               	br	x16
