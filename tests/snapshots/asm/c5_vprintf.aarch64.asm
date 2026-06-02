
c5_vprintf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
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
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	sxtw	x14, w1
               	stur	w14, [x29, #0x20]
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	ldursw	x12, [x29, #0x20]
               	cmp	x12, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x18]
               	ldursw	x12, [x29, #0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x12, x12, x17
               	stur	w12, [x29, #0x20]
               	b	<addr>
               	mov	x1, #0x1f               // =31
               	ldursw	x2, [x29, #0x20]
               	mov	x3, #0xa                // =10
               	mov	x0, x21
               	bl	<addr>
               	stur	w0, [x29, #-0x10]
               	ldursw	x3, [x29, #-0x18]
               	cbz	x3, <addr>
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	ldursw	x3, [x29, #-0x10]
               	add	x3, x21, x3
               	mov	x0, #0x2d               // =45
               	strb	w0, [x3]
               	b	<addr>
               	mov	x0, #0x1f               // =31
               	ldursw	x2, [x29, #-0x10]
               	sub	x0, x0, x2
               	sxtw	x22, w0
               	add	x1, x21, x2
               	sxtw	x2, w22
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x22, w22
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	sxtw	x21, w1
               	mov	x0, #0x20               // =32
               	bl	<addr>
               	mov	x22, x0
               	mov	x23, #0x1f              // =31
               	mov	x3, #0x10               // =16
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x23, x23, x0
               	sxtw	x23, w23
               	add	x1, x22, x0
               	sxtw	x2, w23
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	sxtw	x14, w1
               	stur	w14, [x29, #0x20]
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	mov	x2, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	mov	x21, x0
               	add	x0, x21, #0x10
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	mov	x11, #0xf               // =15
               	stur	w11, [x29, #-0x10]
               	b	<addr>
               	ldursw	x11, [x29, #-0x10]
               	cmp	x11, #0x0
               	b.lt	<addr>
               	ldursw	x1, [x29, #0x20]
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	stur	w1, [x29, #-0x18]
               	ldursw	x11, [x29, #-0x18]
               	cmp	x11, #0xa
               	b.ge	<addr>
               	b	<addr>
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	ldursw	x1, [x29, #-0x10]
               	add	x1, x21, x1
               	ldursw	x11, [x29, #-0x18]
               	add	x11, x11, #0x30
               	sxtw	x11, w11
               	strb	w11, [x1]
               	b	<addr>
               	ldursw	x0, [x29, #0x20]
               	asr	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xfff, lsl #48
               	and	x0, x0, x17
               	stur	w0, [x29, #0x20]
               	ldursw	x1, [x29, #-0x10]
               	sub	x1, x1, #0x1
               	sxtw	x1, w1
               	stur	w1, [x29, #-0x10]
               	b	<addr>
               	ldursw	x11, [x29, #-0x10]
               	add	x11, x21, x11
               	ldursw	x0, [x29, #-0x18]
               	add	x0, x0, #0x61
               	sxtw	x0, w0
               	sub	x0, x0, #0xa
               	sxtw	x0, w0
               	strb	w0, [x11]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	mov	x21, x1
               	cmp	x21, #0x0
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x103
               	mov	x22, #0x6               // =6
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x21, x0
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	ldursw	x22, [x29, #-0x8]
               	add	x22, x22, #0x1
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	b	<addr>
               	ldursw	x2, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x2, [sp, #-0x10]!
               	sub	sp, sp, #0x20
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	mov	x21, x1
               	mov	x13, x2
               	stur	x13, [x29, #0x30]
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x8]
               	stur	w12, [x29, #-0x10]
               	b	<addr>
               	ldursw	x12, [x29, #-0x10]
               	add	x12, x21, x12
               	ldrb	w12, [x12]
               	cmp	x12, #0x0
               	b.eq	<addr>
               	ldursw	x13, [x29, #-0x10]
               	add	x13, x21, x13
               	ldrb	w13, [x13]
               	sturb	w13, [x29, #-0x18]
               	ldurb	w12, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x1, [x29, #-0x8]
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	ldurb	w13, [x29, #-0x18]
               	sturb	w13, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	stur	w2, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	stur	w2, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x21, x0
               	ldrb	w0, [x0]
               	sturb	w0, [x29, #-0x18]
               	ldurb	w2, [x29, #-0x18]
               	mov	x17, #0x64              // =100
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	ldursw	x22, [x29, #-0x8]
               	add	x2, x29, #0x30
               	ldr	x1, [x2]
               	add	x17, x1, #0x10
               	str	x17, [x2]
               	ldrsw	x2, [x1]
               	mov	x0, x20
               	mov	x1, x2
               	bl	<addr>
               	add	x22, x22, x0
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x75              // =117
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	ldursw	x23, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x2, [x0]
               	add	x17, x2, #0x10
               	str	x17, [x0]
               	ldrsw	x1, [x2]
               	mov	x0, x20
               	bl	<addr>
               	add	x23, x23, x0
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	ldursw	x22, [x29, #-0x8]
               	add	x0, x29, #0x30
               	ldr	x1, [x0]
               	add	x17, x1, #0x10
               	str	x17, [x0]
               	ldrsw	x0, [x1]
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	add	x22, x22, x1
               	sxtw	x22, w22
               	stur	w22, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x10]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	stur	w1, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w1, [x29, #-0x18]
               	mov	x17, #0x70              // =112
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	b.ne	<addr>
               	ldursw	x23, [x29, #-0x8]
               	add	x1, x29, #0x30
               	ldr	x0, [x1]
               	add	x17, x0, #0x10
               	str	x17, [x1]
               	ldrsw	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	add	x23, x23, x0
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	add	x23, x29, #0x30
               	ldr	x0, [x23]
               	add	x17, x0, #0x10
               	str	x17, [x23]
               	ldrsw	x0, [x0]
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	stur	w2, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w2, [x29, #-0x18]
               	mov	x17, #0x73              // =115
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	b.ne	<addr>
               	ldursw	x23, [x29, #-0x8]
               	add	x2, x29, #0x30
               	ldr	x1, [x2]
               	add	x17, x1, #0x10
               	str	x17, [x2]
               	ldr	x2, [x1]
               	mov	x0, x20
               	mov	x1, x2
               	bl	<addr>
               	add	x23, x23, x0
               	sxtw	x23, w23
               	stur	w23, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x18]
               	mov	x17, #0x25              // =37
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x23, #0x25              // =37
               	sturb	w23, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x2, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x10]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	stur	w2, [x29, #-0x10]
               	b	<addr>
               	b	<addr>
               	ldurb	w2, [x29, #-0x18]
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x25               // =37
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x23, #0x1               // =1
               	mov	x0, x20
               	mov	x2, x23
               	bl	<addr>
               	sxtw	x0, w0
               	ldurb	w0, [x29, #-0x18]
               	sturb	w0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	mov	x0, x20
               	mov	x2, x23
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x10]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	stur	w1, [x29, #-0x10]
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x15, x0
               	mov	x14, x1
               	mov	x0, #0x1                // =1
               	mov	x1, x15
               	mov	x2, x14
               	bl	<addr>
               	mov	x12, x0
               	mov	x0, x12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	add	x14, x29, #0x10
               	add	x17, x14, #0x10
               	str	x17, [x15]
               	ldur	x0, [x29, #0x10]
               	ldur	x1, [x29, #-0x8]
               	bl	<addr>
               	mov	x15, x0
               	sub	x1, x29, #0x8
               	sxtw	x0, w15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x0, <page>
               	add	x0, x0, #0x118
               	adrp	x1, <page>
               	add	x1, x1, #0x149
               	mov	x2, #0x2a               // =42
               	mov	x3, #0x41               // =65
               	mov	x4, #0xff               // =255
               	str	x4, [sp, #-0x10]!
               	str	x3, [sp, #-0x10]!
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x50
               	mov	x10, x0
               	sxtw	x10, w10
               	cmp	x10, #0x0
               	b.gt	<addr>
               	mov	x4, #0x1                // =1
               	mov	x0, x4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x14f
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x4, x0
               	sxtw	x4, w4
               	cmp	x4, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x4, <page>
               	add	x4, x4, #0x150
               	str	x4, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x4, #0x3                // =3
               	mov	x0, x4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x152
               	str	x0, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x4, x0
               	sxtw	x4, w4
               	cmp	x4, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x4, <page>
               	add	x4, x4, #0x156
               	mov	x1, #0x0                // =0
               	str	x1, [sp, #-0x10]!
               	str	x4, [sp, #-0x10]!
               	bl	<addr>
               	add	sp, sp, #0x20
               	sxtw	x0, w0
               	cmp	x0, #0x13
               	b.eq	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
