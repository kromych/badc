
vsnprintf_underscore_alias.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
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
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
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
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
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
               	add	x13, x15, x13
               	mov	x14, #0x0               // =0
               	strb	w14, [x13]
               	ldursw	x11, [x29, #0x30]
               	cmp	x11, #0x0
               	b.ne	<addr>
               	ldursw	x14, [x29, #-0x8]
               	sub	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x8]
               	ldursw	x11, [x29, #-0x8]
               	add	x11, x15, x11
               	mov	x14, #0x30              // =48
               	strb	w14, [x11]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	b	<addr>
               	ldursw	x14, [x29, #0x30]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	cmp	x12, #0xa
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldursw	x14, [x29, #0x30]
               	mov	x0, #0xa                // =10
               	sdiv	x17, x14, x0
               	msub	x11, x17, x0, x14
               	stur	w11, [x29, #-0x10]
               	sdiv	x14, x14, x0
               	stur	w14, [x29, #0x30]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	sub	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x8]
               	ldursw	x10, [x29, #-0x10]
               	cmp	x10, #0xa
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #0x30]
               	mov	x17, #0xf               // =15
               	and	x0, x14, x17
               	stur	w0, [x29, #-0x10]
               	asr	x14, x14, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x14, x14, x17
               	stur	w14, [x29, #0x30]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	add	x14, x15, x14
               	ldursw	x10, [x29, #-0x10]
               	add	x10, x10, #0x30
               	sxtw	x10, w10
               	strb	w10, [x14]
               	b	<addr>
               	b	<addr>
               	ldursw	x10, [x29, #-0x8]
               	add	x10, x15, x10
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x61
               	sxtw	x0, w0
               	sub	x0, x0, #0xa
               	sxtw	x0, w0
               	strb	w0, [x10]
               	b	<addr>
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
               	cbz	x11, <addr>
               	ldrsw	x10, [x13]
               	add	x10, x10, #0x1
               	sxtw	x10, w10
               	cmp	x10, x14
               	cset	x10, lt
               	stur	x10, [x29, #-0x8]
               	b	<addr>
               	ldur	x10, [x29, #-0x8]
               	cbz	x10, <addr>
               	ldrsw	x14, [x13]
               	add	x15, x15, x14
               	mov	x17, #0xff              // =255
               	and	x12, x12, x17
               	strb	w12, [x15]
               	b	<addr>
               	ldrsw	x12, [x13]
               	add	x12, x12, #0x1
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
               	b	<addr>
               	ldursw	x11, [x29, #-0x10]
               	add	x11, x22, x11
               	ldrb	w12, [x11]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	ldursw	x11, [x29, #-0x10]
               	add	x11, x22, x11
               	ldrb	w12, [x11]
               	sturb	w12, [x29, #-0x70]
               	ldurb	w11, [x29, #-0x70]
               	mov	x17, #0x25              // =37
               	eor	x11, x11, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x11, x17
               	cmp	x11, #0x0
               	b.eq	<addr>
               	b	<addr>
               	cmp	x21, #0x0
               	b.le	<addr>
               	b	<addr>
               	sub	x23, x29, #0x8
               	ldurb	w24, [x29, #-0x70]
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x50]
               	stur	w24, [x29, #-0x58]
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x110
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	stur	w24, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w24, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x24, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x30              // =48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x110
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x110
               	ldr	x0, [x16]
               	sub	x17, x29, #0x108
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x2b              // =43
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x108
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldr	x0, [x16]
               	stur	x0, [x29, #-0x100]
               	cbnz	x0, <addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x20              // =32
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0x100]
               	b	<addr>
               	ldur	x0, [x29, #-0x100]
               	stur	x0, [x29, #-0xf8]
               	cbnz	x0, <addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x23              // =35
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	stur	x0, [x29, #-0xf8]
               	b	<addr>
               	ldur	x0, [x29, #-0xf8]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x50]
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x24, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	mov	x17, #0x30              // =48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x24, #0x1               // =1
               	stur	w24, [x29, #-0x58]
               	b	<addr>
               	b	<addr>
               	add	x0, x29, #0x40
               	ldr	x24, [x0]
               	add	x17, x24, #0x10
               	str	x17, [x0]
               	ldrsw	x0, [x24]
               	stur	w0, [x29, #-0x38]
               	ldursw	x24, [x29, #-0x38]
               	cmp	x24, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x40]
               	stur	w0, [x29, #-0x48]
               	ldursw	x9, [x29, #-0x10]
               	add	x9, x22, x9
               	ldrb	w0, [x9]
               	mov	x17, #0x2e              // =46
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x50]
               	ldursw	x24, [x29, #-0x38]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x24, x24, x17
               	stur	w24, [x29, #-0x38]
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x24, #0x1
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x10]
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	cmp	x0, #0x30
               	cset	x0, ge
               	sub	x17, x29, #0x118
               	str	x0, [x17]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x24, [x29, #-0x38]
               	mov	x17, #0xa               // =10
               	mul	x24, x24, x17
               	sxtw	x24, w24
               	ldursw	x0, [x29, #-0x10]
               	add	x23, x22, x0
               	ldrb	w9, [x23]
               	sub	x9, x9, #0x30
               	sxtw	x9, w9
               	add	x24, x24, x9
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x38]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldursw	x24, [x29, #-0x10]
               	add	x24, x22, x24
               	ldrb	w0, [x24]
               	cmp	x0, #0x39
               	cset	x0, le
               	sub	x17, x29, #0x118
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x118
               	ldr	x0, [x16]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x9, #0x1                // =1
               	stur	w9, [x29, #-0x48]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	ldursw	x9, [x29, #-0x10]
               	add	x9, x22, x9
               	ldrb	w0, [x9]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	add	x9, x29, #0x40
               	ldr	x0, [x9]
               	add	x17, x0, #0x10
               	str	x17, [x9]
               	ldrsw	x9, [x0]
               	stur	w9, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x40]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x9, #0x0                // =0
               	stur	w9, [x29, #-0x48]
               	stur	w9, [x29, #-0x40]
               	b	<addr>
               	ldursw	x9, [x29, #-0x10]
               	add	x9, x9, #0x1
               	sxtw	x9, w9
               	stur	w9, [x29, #-0x10]
               	b	<addr>
               	ldursw	x9, [x29, #-0x10]
               	add	x9, x22, x9
               	ldrb	w0, [x9]
               	cmp	x0, #0x30
               	cset	x0, ge
               	sub	x17, x29, #0x120
               	str	x0, [x17]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x9, [x29, #-0x40]
               	mov	x17, #0xa               // =10
               	mul	x9, x9, x17
               	sxtw	x9, w9
               	ldursw	x0, [x29, #-0x10]
               	add	x24, x22, x0
               	ldrb	w23, [x24]
               	sub	x23, x23, #0x30
               	sxtw	x23, w23
               	add	x9, x9, x23
               	sxtw	x9, w9
               	stur	w9, [x29, #-0x40]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldursw	x9, [x29, #-0x10]
               	add	x9, x22, x9
               	ldrb	w0, [x9]
               	cmp	x0, #0x39
               	cset	x0, le
               	sub	x17, x29, #0x120
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x120
               	ldr	x0, [x16]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w23, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x140
               	str	x23, [x17]
               	cbnz	x23, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w23, [x0]
               	sturb	w23, [x29, #-0x70]
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w23, [x0]
               	mov	x17, #0x68              // =104
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x140
               	str	x23, [x17]
               	b	<addr>
               	sub	x16, x29, #0x140
               	ldr	x23, [x16]
               	sub	x17, x29, #0x138
               	str	x23, [x17]
               	cbnz	x23, <addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w23, [x0]
               	mov	x17, #0x7a              // =122
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x138
               	str	x23, [x17]
               	b	<addr>
               	sub	x16, x29, #0x138
               	ldr	x23, [x16]
               	sub	x17, x29, #0x130
               	str	x23, [x17]
               	cbnz	x23, <addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w23, [x0]
               	mov	x17, #0x6a              // =106
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x130
               	str	x23, [x17]
               	b	<addr>
               	sub	x16, x29, #0x130
               	ldr	x23, [x16]
               	sub	x17, x29, #0x128
               	str	x23, [x17]
               	cbnz	x23, <addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w23, [x0]
               	mov	x17, #0x74              // =116
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	sub	x17, x29, #0x128
               	str	x23, [x17]
               	b	<addr>
               	sub	x16, x29, #0x128
               	ldr	x23, [x16]
               	cbz	x23, <addr>
               	b	<addr>
               	add	x23, x29, #0x40
               	ldr	x0, [x23]
               	add	x17, x0, #0x10
               	str	x17, [x23]
               	ldrsw	x23, [x0]
               	stur	w23, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	ldursw	x23, [x29, #-0x20]
               	cmp	x23, #0x0
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0x75              // =117
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x188
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x28]
               	ldursw	x23, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x23, x23, x17
               	stur	w23, [x29, #-0x20]
               	b	<addr>
               	sub	x25, x29, #0x90
               	mov	x23, #0x1f              // =31
               	ldursw	x26, [x29, #-0x20]
               	mov	x27, #0xa               // =10
               	mov	x0, x25
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x23
               	bl	<addr>
               	stur	w0, [x29, #-0x18]
               	ldursw	x27, [x29, #-0x18]
               	sub	x23, x23, x27
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x60]
               	ldursw	x27, [x29, #-0x28]
               	cbz	x27, <addr>
               	ldursw	x23, [x29, #-0x60]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x60]
               	b	<addr>
               	ldursw	x23, [x29, #-0x48]
               	cbz	x23, <addr>
               	ldursw	x27, [x29, #-0x40]
               	sub	x17, x29, #0x148
               	str	x27, [x17]
               	b	<addr>
               	mov	x27, #0x0               // =0
               	sub	x17, x29, #0x148
               	str	x27, [x17]
               	b	<addr>
               	sub	x16, x29, #0x148
               	ldr	x27, [x16]
               	stur	w27, [x29, #-0xa0]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0xa8]
               	ldursw	x27, [x29, #-0x60]
               	ldursw	x23, [x29, #-0x28]
               	cbz	x23, <addr>
               	mov	x0, #0x1                // =1
               	sub	x17, x29, #0x150
               	str	x0, [x17]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x150
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x150
               	ldr	x0, [x16]
               	sub	x27, x27, x0
               	sxtw	x27, w27
               	ldursw	x0, [x29, #-0xa0]
               	cmp	x27, x0
               	b.ge	<addr>
               	ldursw	x0, [x29, #-0xa0]
               	ldursw	x27, [x29, #-0x60]
               	ldursw	x23, [x29, #-0x28]
               	cbz	x23, <addr>
               	b	<addr>
               	ldursw	x27, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x60]
               	cmp	x27, x0
               	b.le	<addr>
               	b	<addr>
               	mov	x26, #0x1               // =1
               	sub	x17, x29, #0x158
               	str	x26, [x17]
               	b	<addr>
               	mov	x26, #0x0               // =0
               	sub	x17, x29, #0x158
               	str	x26, [x17]
               	b	<addr>
               	sub	x16, x29, #0x158
               	ldr	x26, [x16]
               	sub	x27, x27, x26
               	sxtw	x27, w27
               	sub	x0, x0, x27
               	sxtw	x0, w0
               	stur	w0, [x29, #-0xa8]
               	ldursw	x27, [x29, #-0x60]
               	ldursw	x0, [x29, #-0xa8]
               	add	x27, x27, x0
               	sxtw	x27, w27
               	stur	w27, [x29, #-0x60]
               	b	<addr>
               	ldursw	x0, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	sub	x0, x0, x27
               	sxtw	x0, w0
               	sub	x17, x29, #0x160
               	str	x0, [x17]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x160
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x160
               	ldr	x0, [x16]
               	stur	w0, [x29, #-0x68]
               	ldursw	x27, [x29, #-0x58]
               	sub	x17, x29, #0x170
               	str	x27, [x17]
               	cbz	x27, <addr>
               	ldursw	x0, [x29, #-0x48]
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x170
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x170
               	ldr	x0, [x16]
               	sub	x17, x29, #0x168
               	str	x0, [x17]
               	cbz	x0, <addr>
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x168
               	str	x27, [x17]
               	b	<addr>
               	sub	x16, x29, #0x168
               	ldr	x27, [x16]
               	cbz	x27, <addr>
               	mov	x0, #0x30               // =48
               	sub	x17, x29, #0x178
               	str	x0, [x17]
               	b	<addr>
               	mov	x0, #0x20               // =32
               	sub	x17, x29, #0x178
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x178
               	ldr	x0, [x16]
               	sturb	w0, [x29, #-0xb0]
               	ldursw	x27, [x29, #-0x50]
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x24, x29, #0x8
               	ldurb	w27, [x29, #-0xb0]
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	sub	x26, x29, #0x8
               	mov	x27, #0x2d              // =45
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x27, [x29, #-0xa8]
               	cmp	x27, #0x0
               	b.le	<addr>
               	sub	x24, x29, #0x8
               	mov	x28, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x24
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0xa8]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0xa8]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x1f
               	b.ge	<addr>
               	sub	x26, x29, #0x8
               	sub	x0, x29, #0x90
               	ldursw	x24, [x29, #-0x18]
               	add	x0, x0, x24
               	ldrb	w28, [x0]
               	mov	x0, x20
               	mov	x3, x28
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x28, [x29, #-0x68]
               	cmp	x28, #0x0
               	b.le	<addr>
               	sub	x24, x29, #0x8
               	mov	x27, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	ldurb	w27, [x29, #-0x70]
               	mov	x17, #0x78              // =120
               	eor	x27, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	cmp	x27, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x188
               	str	x27, [x17]
               	b	<addr>
               	sub	x16, x29, #0x188
               	ldr	x27, [x16]
               	sub	x17, x29, #0x180
               	str	x27, [x17]
               	cbnz	x27, <addr>
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x180
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x180
               	ldr	x0, [x16]
               	cbz	x0, <addr>
               	add	x27, x29, #0x40
               	ldr	x0, [x27]
               	add	x17, x0, #0x10
               	str	x17, [x27]
               	ldrsw	x27, [x0]
               	stur	w27, [x29, #-0x20]
               	sub	x26, x29, #0x90
               	mov	x28, #0x1f              // =31
               	ldursw	x27, [x29, #-0x20]
               	ldurb	w23, [x29, #-0x70]
               	mov	x17, #0x75              // =117
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0x70              // =112
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0xa               // =10
               	sub	x17, x29, #0x190
               	str	x25, [x17]
               	b	<addr>
               	mov	x25, #0x10              // =16
               	sub	x17, x29, #0x190
               	str	x25, [x17]
               	b	<addr>
               	sub	x16, x29, #0x190
               	ldr	x24, [x16]
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x28
               	bl	<addr>
               	stur	w0, [x29, #-0x18]
               	mov	x24, #0x1f              // =31
               	ldursw	x0, [x29, #-0x18]
               	sub	x24, x24, x0
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	ldursw	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	ldursw	x24, [x29, #-0x40]
               	sub	x17, x29, #0x198
               	str	x24, [x17]
               	b	<addr>
               	mov	x24, #0x0               // =0
               	sub	x17, x29, #0x198
               	str	x24, [x17]
               	b	<addr>
               	sub	x16, x29, #0x198
               	ldr	x24, [x16]
               	stur	w24, [x29, #-0xb8]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0xc0]
               	ldursw	x24, [x29, #-0x60]
               	ldursw	x0, [x29, #-0xb8]
               	cmp	x24, x0
               	b.ge	<addr>
               	ldursw	x0, [x29, #-0xb8]
               	ldursw	x24, [x29, #-0x60]
               	sub	x0, x0, x24
               	sxtw	x0, w0
               	stur	w0, [x29, #-0xc0]
               	ldursw	x27, [x29, #-0xc0]
               	add	x24, x24, x27
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x60]
               	b	<addr>
               	ldursw	x24, [x29, #-0x38]
               	ldursw	x27, [x29, #-0x60]
               	cmp	x24, x27
               	b.le	<addr>
               	ldursw	x27, [x29, #-0x38]
               	ldursw	x24, [x29, #-0x60]
               	sub	x27, x27, x24
               	sxtw	x27, w27
               	sub	x17, x29, #0x1a0
               	str	x27, [x17]
               	b	<addr>
               	mov	x27, #0x0               // =0
               	sub	x17, x29, #0x1a0
               	str	x27, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1a0
               	ldr	x27, [x16]
               	stur	w27, [x29, #-0x68]
               	ldursw	x24, [x29, #-0x58]
               	sub	x17, x29, #0x1b0
               	str	x24, [x17]
               	cbz	x24, <addr>
               	ldursw	x27, [x29, #-0x48]
               	cmp	x27, #0x0
               	cset	x27, eq
               	sub	x17, x29, #0x1b0
               	str	x27, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1b0
               	ldr	x27, [x16]
               	sub	x17, x29, #0x1a8
               	str	x27, [x17]
               	cbz	x27, <addr>
               	ldursw	x24, [x29, #-0x50]
               	cmp	x24, #0x0
               	cset	x24, eq
               	sub	x17, x29, #0x1a8
               	str	x24, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1a8
               	ldr	x24, [x16]
               	cbz	x24, <addr>
               	mov	x27, #0x30              // =48
               	sub	x17, x29, #0x1b8
               	str	x27, [x17]
               	b	<addr>
               	mov	x27, #0x20              // =32
               	sub	x17, x29, #0x1b8
               	str	x27, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1b8
               	ldr	x27, [x16]
               	sturb	w27, [x29, #-0xc8]
               	ldursw	x24, [x29, #-0x50]
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x27, [x29, #-0x68]
               	cmp	x27, #0x0
               	b.le	<addr>
               	sub	x23, x29, #0x8
               	ldurb	w24, [x29, #-0xc8]
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0xc0]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x27, x29, #0x8
               	mov	x24, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0xc0]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0xc0]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x1f
               	b.ge	<addr>
               	sub	x23, x29, #0x8
               	sub	x0, x29, #0x90
               	ldursw	x27, [x29, #-0x18]
               	add	x0, x0, x27
               	ldrb	w24, [x0]
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x24, [x29, #-0x68]
               	cmp	x24, #0x0
               	b.le	<addr>
               	sub	x27, x29, #0x8
               	mov	x25, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	add	x25, x29, #0x40
               	ldr	x0, [x25]
               	add	x17, x0, #0x10
               	str	x17, [x25]
               	ldrsw	x25, [x0]
               	stur	w25, [x29, #-0x20]
               	sub	x23, x29, #0x8
               	mov	x24, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	sub	x27, x29, #0x8
               	mov	x25, #0x78              // =120
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, #0xf                // =15
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	b	<addr>
               	ldurb	w25, [x29, #-0x70]
               	mov	x17, #0x63              // =99
               	eor	x25, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldursw	x25, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x18]
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	asr	x25, x25, x0
               	mov	x17, #0xf               // =15
               	and	x25, x25, x17
               	stur	w25, [x29, #-0x30]
               	ldursw	x0, [x29, #-0x30]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x25, [x29, #-0x10]
               	add	x25, x25, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x10]
               	b	<addr>
               	sub	x23, x29, #0x8
               	ldursw	x0, [x29, #-0x30]
               	add	x0, x0, #0x30
               	sxtw	x25, w0
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	ldursw	x25, [x29, #-0x18]
               	sub	x25, x25, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x18]
               	b	<addr>
               	sub	x27, x29, #0x8
               	ldursw	x0, [x29, #-0x30]
               	add	x0, x0, #0x61
               	sxtw	x0, w0
               	sub	x0, x0, #0xa
               	sxtw	x25, w0
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	add	x0, x29, #0x40
               	ldr	x25, [x0]
               	add	x17, x25, #0x10
               	str	x17, [x0]
               	ldrsw	x0, [x25]
               	stur	w0, [x29, #-0xd0]
               	ldursw	x25, [x29, #-0x38]
               	cmp	x25, #0x1
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0x73              // =115
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x38]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	sub	x17, x29, #0x1c0
               	str	x0, [x17]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x1c0
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1c0
               	ldr	x0, [x16]
               	stur	w0, [x29, #-0x68]
               	ldursw	x25, [x29, #-0x50]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sub	x27, x29, #0x8
               	ldursw	x24, [x29, #-0xd0]
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x23, x29, #0x8
               	mov	x25, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x24, [x29, #-0x68]
               	cmp	x24, #0x0
               	b.le	<addr>
               	sub	x23, x29, #0x8
               	mov	x25, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	add	x25, x29, #0x40
               	ldr	x0, [x25]
               	add	x17, x0, #0x10
               	str	x17, [x25]
               	ldr	x25, [x0]
               	stur	x25, [x29, #-0x98]
               	ldur	x0, [x29, #-0x98]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x141
               	mov	x25, x19
               	stur	x25, [x29, #-0x98]
               	b	<addr>
               	mov	x25, #0x0               // =0
               	stur	w25, [x29, #-0x60]
               	b	<addr>
               	ldur	x25, [x29, #-0x98]
               	ldursw	x0, [x29, #-0x60]
               	add	x25, x25, x0
               	ldrb	w0, [x25]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldursw	x25, [x29, #-0x60]
               	add	x25, x25, #0x1
               	sxtw	x25, w25
               	stur	w25, [x29, #-0x60]
               	b	<addr>
               	ldursw	x25, [x29, #-0x48]
               	sub	x17, x29, #0x1c8
               	str	x25, [x17]
               	cbz	x25, <addr>
               	ldursw	x0, [x29, #-0x40]
               	ldursw	x25, [x29, #-0x60]
               	cmp	x0, x25
               	cset	x0, lt
               	sub	x17, x29, #0x1c8
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1c8
               	ldr	x0, [x16]
               	cbz	x0, <addr>
               	ldursw	x25, [x29, #-0x40]
               	stur	w25, [x29, #-0x60]
               	b	<addr>
               	ldursw	x25, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x60]
               	cmp	x25, x0
               	b.le	<addr>
               	ldursw	x0, [x29, #-0x38]
               	ldursw	x25, [x29, #-0x60]
               	sub	x0, x0, x25
               	sxtw	x0, w0
               	sub	x17, x29, #0x1d0
               	str	x0, [x17]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sub	x17, x29, #0x1d0
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1d0
               	ldr	x0, [x16]
               	stur	w0, [x29, #-0x68]
               	ldursw	x25, [x29, #-0x50]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x27, x29, #0x8
               	mov	x25, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x25, [x29, #-0x60]
               	cmp	x0, x25
               	b.ge	<addr>
               	sub	x23, x29, #0x8
               	ldur	x0, [x29, #-0x98]
               	ldursw	x27, [x29, #-0x18]
               	add	x0, x0, x27
               	ldrb	w25, [x0]
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x25, [x29, #-0x68]
               	cmp	x25, #0x0
               	b.le	<addr>
               	sub	x27, x29, #0x8
               	mov	x24, #0x20              // =32
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	sub	x23, x29, #0x8
               	mov	x24, #0x25              // =37
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x27, x29, #0x8
               	mov	x24, #0x25              // =37
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	sub	x23, x29, #0x8
               	ldurb	w25, [x29, #-0x70]
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x25, [x29, #-0x8]
               	cmp	x25, x21
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x21, [x29, #-0x8]
               	mov	x0, x21
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
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x20, x0
               	mov	x25, #0x0               // =0
               	strb	w25, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x21, x21, #0x1
               	sxtw	x21, w21
               	add	x20, x20, x21
               	mov	x21, #0x0               // =0
               	strb	w21, [x20]
               	b	<addr>
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
               	bl	<addr>
               	sub	x23, x29, #0x8
               	sxtw	x0, w0
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
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x22, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x14e
               	mov	x23, x19
               	mov	x24, #0x1               // =1
               	str	x24, [sp, #-0x10]!
               	str	x23, [sp, #-0x10]!
               	str	x22, [sp, #-0x10]!
               	str	x21, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xb0
               	ldp	x29, x30, [sp], #0x10
               	ret
