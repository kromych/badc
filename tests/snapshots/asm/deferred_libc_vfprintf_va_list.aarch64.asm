
deferred_libc_vfprintf_va_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x126
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x12d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
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
               	sub	sp, sp, #0x200
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
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
               	ldrb	w11, [x11]
               	cmp	x11, #0x0
               	b.eq	<addr>
               	ldursw	x12, [x29, #-0x10]
               	add	x12, x22, x12
               	ldrb	w12, [x12]
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
               	sub	x2, x29, #0x8
               	ldurb	w3, [x29, #-0x70]
               	mov	x0, x20
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
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x50]
               	stur	w3, [x29, #-0x58]
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	mov	x17, #0x2d              // =45
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	sub	x17, x29, #0x110
               	str	x3, [x17]
               	cbnz	x3, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x38]
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	mov	x17, #0x2a              // =42
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
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
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	mov	x17, #0x2b              // =43
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	sub	x17, x29, #0x108
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x108
               	ldr	x3, [x16]
               	stur	x3, [x29, #-0x100]
               	cbnz	x3, <addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
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
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	mov	x17, #0x23              // =35
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	stur	x3, [x29, #-0xf8]
               	b	<addr>
               	ldur	x3, [x29, #-0xf8]
               	cbz	x3, <addr>
               	b	<addr>
               	mov	x3, #0x1                // =1
               	stur	w3, [x29, #-0x50]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	mov	x17, #0x30              // =48
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x58]
               	b	<addr>
               	b	<addr>
               	add	x0, x29, #0x40
               	ldr	x3, [x0]
               	add	x17, x3, #0x10
               	str	x17, [x0]
               	ldrsw	x3, [x3]
               	stur	w3, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x38]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x40]
               	stur	w3, [x29, #-0x48]
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x22, x2
               	ldrb	w2, [x2]
               	mov	x17, #0x2e              // =46
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x1                // =1
               	stur	w3, [x29, #-0x50]
               	ldursw	x0, [x29, #-0x38]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	stur	w0, [x29, #-0x38]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x0, ge
               	sub	x17, x29, #0x118
               	str	x0, [x17]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x38]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	ldursw	x3, [x29, #-0x10]
               	add	x2, x22, x3
               	ldrb	w2, [x2]
               	sub	x2, x2, #0x30
               	sxtw	x2, w2
               	add	x0, x0, x2
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x38]
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	cmp	x3, #0x39
               	cset	x3, le
               	sub	x17, x29, #0x118
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x118
               	ldr	x3, [x16]
               	cbz	x3, <addr>
               	b	<addr>
               	mov	x3, #0x1                // =1
               	stur	w3, [x29, #-0x48]
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	stur	w2, [x29, #-0x10]
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	mov	x17, #0x2a              // =42
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	add	x2, x29, #0x40
               	ldr	x3, [x2]
               	add	x17, x3, #0x10
               	str	x17, [x2]
               	ldrsw	x3, [x3]
               	stur	w3, [x29, #-0x40]
               	ldursw	x2, [x29, #-0x40]
               	cmp	x2, #0x0
               	b.ge	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, #0x0                // =0
               	stur	w3, [x29, #-0x48]
               	stur	w3, [x29, #-0x40]
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x10]
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x22, x3
               	ldrb	w3, [x3]
               	cmp	x3, #0x30
               	cset	x3, ge
               	sub	x17, x29, #0x120
               	str	x3, [x17]
               	cbz	x3, <addr>
               	b	<addr>
               	ldursw	x3, [x29, #-0x40]
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	sxtw	x3, w3
               	ldursw	x2, [x29, #-0x10]
               	add	x0, x22, x2
               	ldrb	w0, [x0]
               	sub	x0, x0, #0x30
               	sxtw	x0, w0
               	add	x3, x3, x0
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x40]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	stur	w2, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x22, x2
               	ldrb	w2, [x2]
               	cmp	x2, #0x39
               	cset	x2, le
               	sub	x17, x29, #0x120
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x120
               	ldr	x2, [x16]
               	cbz	x2, <addr>
               	b	<addr>
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x22, x2
               	ldrb	w2, [x2]
               	mov	x17, #0x6c              // =108
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	sub	x17, x29, #0x140
               	str	x2, [x17]
               	cbnz	x2, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	sturb	w0, [x29, #-0x70]
               	ldurb	w2, [x29, #-0x70]
               	mov	x17, #0x64              // =100
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x140
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x140
               	ldr	x0, [x16]
               	sub	x17, x29, #0x138
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x22, x2
               	ldrb	w2, [x2]
               	mov	x17, #0x7a              // =122
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	sub	x17, x29, #0x138
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x138
               	ldr	x2, [x16]
               	sub	x17, x29, #0x130
               	str	x2, [x17]
               	cbnz	x2, <addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x22, x0
               	ldrb	w0, [x0]
               	mov	x17, #0x6a              // =106
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	sub	x17, x29, #0x130
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x130
               	ldr	x0, [x16]
               	sub	x17, x29, #0x128
               	str	x0, [x17]
               	cbnz	x0, <addr>
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x22, x2
               	ldrb	w2, [x2]
               	mov	x17, #0x74              // =116
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	sub	x17, x29, #0x128
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x128
               	ldr	x2, [x16]
               	cbz	x2, <addr>
               	b	<addr>
               	add	x0, x29, #0x40
               	ldr	x2, [x0]
               	add	x17, x2, #0x10
               	str	x17, [x0]
               	ldrsw	x2, [x2]
               	stur	w2, [x29, #-0x20]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x28]
               	ldursw	x2, [x29, #-0x20]
               	cmp	x2, #0x0
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
               	ldursw	x2, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x2, x2, x17
               	stur	w2, [x29, #-0x20]
               	b	<addr>
               	sub	x2, x29, #0x90
               	mov	x23, #0x1f              // =31
               	ldursw	x3, [x29, #-0x20]
               	mov	x9, #0xa                // =10
               	mov	x0, x2
               	mov	x1, x23
               	mov	x2, x3
               	mov	x3, x9
               	bl	<addr>
               	stur	w0, [x29, #-0x18]
               	ldursw	x9, [x29, #-0x18]
               	sub	x23, x23, x9
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x60]
               	ldursw	x9, [x29, #-0x28]
               	cbz	x9, <addr>
               	ldursw	x23, [x29, #-0x60]
               	add	x23, x23, #0x1
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x60]
               	b	<addr>
               	ldursw	x23, [x29, #-0x48]
               	cbz	x23, <addr>
               	ldursw	x9, [x29, #-0x40]
               	sub	x17, x29, #0x148
               	str	x9, [x17]
               	b	<addr>
               	mov	x9, #0x0                // =0
               	sub	x17, x29, #0x148
               	str	x9, [x17]
               	b	<addr>
               	sub	x16, x29, #0x148
               	ldr	x9, [x16]
               	stur	w9, [x29, #-0xa0]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0xa8]
               	ldursw	x9, [x29, #-0x60]
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
               	sub	x9, x9, x0
               	sxtw	x9, w9
               	ldursw	x0, [x29, #-0xa0]
               	cmp	x9, x0
               	b.ge	<addr>
               	ldursw	x0, [x29, #-0xa0]
               	ldursw	x9, [x29, #-0x60]
               	ldursw	x23, [x29, #-0x28]
               	cbz	x23, <addr>
               	b	<addr>
               	ldursw	x9, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x60]
               	cmp	x9, x0
               	b.le	<addr>
               	b	<addr>
               	mov	x3, #0x1                // =1
               	sub	x17, x29, #0x158
               	str	x3, [x17]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	sub	x17, x29, #0x158
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x158
               	ldr	x3, [x16]
               	sub	x9, x9, x3
               	sxtw	x9, w9
               	sub	x0, x0, x9
               	sxtw	x0, w0
               	stur	w0, [x29, #-0xa8]
               	ldursw	x9, [x29, #-0x60]
               	ldursw	x0, [x29, #-0xa8]
               	add	x9, x9, x0
               	sxtw	x9, w9
               	stur	w9, [x29, #-0x60]
               	b	<addr>
               	ldursw	x0, [x29, #-0x38]
               	ldursw	x9, [x29, #-0x60]
               	sub	x0, x0, x9
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
               	ldursw	x9, [x29, #-0x58]
               	sub	x17, x29, #0x170
               	str	x9, [x17]
               	cbz	x9, <addr>
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
               	ldursw	x9, [x29, #-0x50]
               	cmp	x9, #0x0
               	cset	x9, eq
               	sub	x17, x29, #0x168
               	str	x9, [x17]
               	b	<addr>
               	sub	x16, x29, #0x168
               	ldr	x9, [x16]
               	cbz	x9, <addr>
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
               	ldursw	x9, [x29, #-0x50]
               	cmp	x9, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	ldurb	w3, [x29, #-0xb0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x2d               // =45
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x3, [x29, #-0xa8]
               	cmp	x3, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x30               // =48
               	mov	x0, x20
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
               	sub	x2, x29, #0x8
               	sub	x0, x29, #0x90
               	ldursw	x3, [x29, #-0x18]
               	add	x0, x0, x3
               	ldrb	w3, [x0]
               	mov	x0, x20
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
               	ldursw	x3, [x29, #-0x68]
               	cmp	x3, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	ldurb	w3, [x29, #-0x70]
               	mov	x17, #0x78              // =120
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	sub	x17, x29, #0x188
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x188
               	ldr	x3, [x16]
               	sub	x17, x29, #0x180
               	str	x3, [x17]
               	cbnz	x3, <addr>
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
               	add	x3, x29, #0x40
               	ldr	x0, [x3]
               	add	x17, x0, #0x10
               	str	x17, [x3]
               	ldrsw	x0, [x0]
               	stur	w0, [x29, #-0x20]
               	sub	x0, x29, #0x90
               	mov	x1, #0x1f               // =31
               	ldursw	x2, [x29, #-0x20]
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
               	mov	x9, #0xa                // =10
               	sub	x17, x29, #0x190
               	str	x9, [x17]
               	b	<addr>
               	mov	x9, #0x10               // =16
               	sub	x17, x29, #0x190
               	str	x9, [x17]
               	b	<addr>
               	sub	x16, x29, #0x190
               	ldr	x3, [x16]
               	bl	<addr>
               	mov	x23, x0
               	stur	w23, [x29, #-0x18]
               	mov	x3, #0x1f               // =31
               	ldursw	x23, [x29, #-0x18]
               	sub	x3, x3, x23
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x60]
               	ldursw	x23, [x29, #-0x48]
               	cbz	x23, <addr>
               	ldursw	x3, [x29, #-0x40]
               	sub	x17, x29, #0x198
               	str	x3, [x17]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	sub	x17, x29, #0x198
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x198
               	ldr	x3, [x16]
               	stur	w3, [x29, #-0xb8]
               	mov	x23, #0x0               // =0
               	stur	w23, [x29, #-0xc0]
               	ldursw	x3, [x29, #-0x60]
               	ldursw	x23, [x29, #-0xb8]
               	cmp	x3, x23
               	b.ge	<addr>
               	ldursw	x23, [x29, #-0xb8]
               	ldursw	x3, [x29, #-0x60]
               	sub	x23, x23, x3
               	sxtw	x23, w23
               	stur	w23, [x29, #-0xc0]
               	ldursw	x2, [x29, #-0xc0]
               	add	x3, x3, x2
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x60]
               	b	<addr>
               	ldursw	x3, [x29, #-0x38]
               	ldursw	x2, [x29, #-0x60]
               	cmp	x3, x2
               	b.le	<addr>
               	ldursw	x2, [x29, #-0x38]
               	ldursw	x3, [x29, #-0x60]
               	sub	x2, x2, x3
               	sxtw	x2, w2
               	sub	x17, x29, #0x1a0
               	str	x2, [x17]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	sub	x17, x29, #0x1a0
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1a0
               	ldr	x2, [x16]
               	stur	w2, [x29, #-0x68]
               	ldursw	x3, [x29, #-0x58]
               	sub	x17, x29, #0x1b0
               	str	x3, [x17]
               	cbz	x3, <addr>
               	ldursw	x2, [x29, #-0x48]
               	cmp	x2, #0x0
               	cset	x2, eq
               	sub	x17, x29, #0x1b0
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1b0
               	ldr	x2, [x16]
               	sub	x17, x29, #0x1a8
               	str	x2, [x17]
               	cbz	x2, <addr>
               	ldursw	x3, [x29, #-0x50]
               	cmp	x3, #0x0
               	cset	x3, eq
               	sub	x17, x29, #0x1a8
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1a8
               	ldr	x3, [x16]
               	cbz	x3, <addr>
               	mov	x2, #0x30               // =48
               	sub	x17, x29, #0x1b8
               	str	x2, [x17]
               	b	<addr>
               	mov	x2, #0x20               // =32
               	sub	x17, x29, #0x1b8
               	str	x2, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1b8
               	ldr	x2, [x16]
               	sturb	w2, [x29, #-0xc8]
               	ldursw	x3, [x29, #-0x50]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x2, [x29, #-0x68]
               	cmp	x2, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	ldurb	w3, [x29, #-0xc8]
               	mov	x0, x20
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
               	sub	x2, x29, #0x8
               	mov	x3, #0x30               // =48
               	mov	x0, x20
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
               	sub	x2, x29, #0x8
               	sub	x0, x29, #0x90
               	ldursw	x3, [x29, #-0x18]
               	add	x0, x0, x3
               	ldrb	w3, [x0]
               	mov	x0, x20
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
               	ldursw	x3, [x29, #-0x68]
               	cmp	x3, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	add	x3, x29, #0x40
               	ldr	x0, [x3]
               	add	x17, x0, #0x10
               	str	x17, [x3]
               	ldrsw	x0, [x0]
               	stur	w0, [x29, #-0x20]
               	sub	x2, x29, #0x8
               	mov	x3, #0x30               // =48
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x78               // =120
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, #0xf                // =15
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	b	<addr>
               	ldurb	w3, [x29, #-0x70]
               	mov	x17, #0x63              // =99
               	eor	x3, x3, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x3, x3, x17
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x0
               	b.lt	<addr>
               	ldursw	x3, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x18]
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	asr	x3, x3, x0
               	mov	x17, #0xf               // =15
               	and	x3, x3, x17
               	stur	w3, [x29, #-0x30]
               	ldursw	x0, [x29, #-0x30]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x10]
               	b	<addr>
               	sub	x2, x29, #0x8
               	ldursw	x0, [x29, #-0x30]
               	add	x0, x0, #0x30
               	sxtw	x3, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	ldursw	x3, [x29, #-0x18]
               	sub	x3, x3, #0x1
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x18]
               	b	<addr>
               	sub	x2, x29, #0x8
               	ldursw	x0, [x29, #-0x30]
               	add	x0, x0, #0x61
               	sxtw	x0, w0
               	sub	x0, x0, #0xa
               	sxtw	x3, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	b	<addr>
               	add	x0, x29, #0x40
               	ldr	x3, [x0]
               	add	x17, x3, #0x10
               	str	x17, [x0]
               	ldrsw	x3, [x3]
               	stur	w3, [x29, #-0xd0]
               	ldursw	x0, [x29, #-0x38]
               	cmp	x0, #0x1
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
               	ldursw	x3, [x29, #-0x38]
               	sub	x3, x3, #0x1
               	sxtw	x3, w3
               	sub	x17, x29, #0x1c0
               	str	x3, [x17]
               	b	<addr>
               	mov	x3, #0x0                // =0
               	sub	x17, x29, #0x1c0
               	str	x3, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1c0
               	ldr	x3, [x16]
               	stur	w3, [x29, #-0x68]
               	ldursw	x0, [x29, #-0x50]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	ldursw	x3, [x29, #-0xd0]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x50]
               	cbz	x0, <addr>
               	b	<addr>
               	ldursw	x3, [x29, #-0x68]
               	cmp	x3, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
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
               	ldursw	x3, [x29, #-0x68]
               	cmp	x3, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	add	x3, x29, #0x40
               	ldr	x0, [x3]
               	add	x17, x0, #0x10
               	str	x17, [x3]
               	ldr	x0, [x0]
               	stur	x0, [x29, #-0x98]
               	ldur	x3, [x29, #-0x98]
               	cmp	x3, #0x0
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
               	add	x19, x19, #0x151
               	mov	x0, x19
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x60]
               	b	<addr>
               	ldur	x0, [x29, #-0x98]
               	ldursw	x3, [x29, #-0x60]
               	add	x0, x0, x3
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldursw	x3, [x29, #-0x60]
               	add	x3, x3, #0x1
               	sxtw	x3, w3
               	stur	w3, [x29, #-0x60]
               	b	<addr>
               	ldursw	x3, [x29, #-0x48]
               	sub	x17, x29, #0x1c8
               	str	x3, [x17]
               	cbz	x3, <addr>
               	ldursw	x0, [x29, #-0x40]
               	ldursw	x3, [x29, #-0x60]
               	cmp	x0, x3
               	cset	x0, lt
               	sub	x17, x29, #0x1c8
               	str	x0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x1c8
               	ldr	x0, [x16]
               	cbz	x0, <addr>
               	ldursw	x3, [x29, #-0x40]
               	stur	w3, [x29, #-0x60]
               	b	<addr>
               	ldursw	x3, [x29, #-0x38]
               	ldursw	x0, [x29, #-0x60]
               	cmp	x3, x0
               	b.le	<addr>
               	ldursw	x0, [x29, #-0x38]
               	ldursw	x3, [x29, #-0x60]
               	sub	x0, x0, x3
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
               	ldursw	x3, [x29, #-0x50]
               	cmp	x3, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x68]
               	cmp	x0, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	ldursw	x3, [x29, #-0x60]
               	cmp	x0, x3
               	b.ge	<addr>
               	sub	x2, x29, #0x8
               	ldur	x0, [x29, #-0x98]
               	ldursw	x3, [x29, #-0x18]
               	add	x0, x0, x3
               	ldrb	w3, [x0]
               	mov	x0, x20
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
               	ldursw	x3, [x29, #-0x68]
               	cmp	x3, #0x0
               	b.le	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x20               // =32
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x68]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x68]
               	b	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x25               // =37
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x70]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x2, x29, #0x8
               	mov	x3, #0x25               // =37
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sub	x2, x29, #0x8
               	ldurb	w3, [x29, #-0x70]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x3, [x29, #-0x8]
               	cmp	x3, x21
               	b.ge	<addr>
               	b	<addr>
               	ldursw	x21, [x29, #-0x8]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x40
               	ret
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x20, x0
               	mov	x3, #0x0                // =0
               	strb	w3, [x0]
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
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x30
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	ldur	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x20]
               	ldur	x2, [x29, #0x30]
               	ldur	x3, [x29, #-0x8]
               	bl	<addr>
               	mov	x11, x0
               	sub	x3, x29, #0x8
               	sxtw	x0, w11
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x19, [sp]
               	sub	x0, x29, #0x40
               	mov	x1, #0x40               // =64
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x2, x19
               	mov	x3, #0x2a               // =42
               	mov	x4, #0x63               // =99
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	mov	x10, x0
               	sub	x0, x29, #0x40
               	adrp	x19, <page>
               	add	x19, x19, #0x15e
               	mov	x1, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	cmp	x3, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x164
               	mov	x0, x19
               	sub	x1, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x3, x0
               	mov	x3, #0x1                // =1
               	mov	x0, x3
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
