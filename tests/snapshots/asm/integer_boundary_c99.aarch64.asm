
integer_boundary_c99.aarch64:	file format elf64-littleaarch64

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
               	adrp	x14, <page>
               	add	x14, x14, #0x108
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x108
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
               	adrp	x12, <page>
               	add	x12, x12, #0x120
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x126
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x12d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x108
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x14, <page>
               	add	x14, x14, #0x158
               	mov	x20, #0x64              // =100
               	str	w20, [x14]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x160
               	mov	x2, #0x36               // =54
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x65              // =101
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x17b
               	mov	x2, #0x37               // =55
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x66              // =102
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x196
               	mov	x2, #0x38               // =56
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x67              // =103
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b1
               	mov	x2, #0x39               // =57
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x68              // =104
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1cc
               	mov	x2, #0x3a               // =58
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x69              // =105
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1e7
               	mov	x2, #0x3b               // =59
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x6a              // =106
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x202
               	mov	x2, #0x3c               // =60
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x6b              // =107
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x21d
               	mov	x2, #0x3d               // =61
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurb	w0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w2, [x0]
               	add	x2, x2, #0x1
               	strb	w2, [x0]
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x6e              // =110
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x238
               	mov	x2, #0x42               // =66
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurb	w2, [x29, #-0x8]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w2, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x21, #0x6f              // =111
               	str	w21, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x253
               	mov	x2, #0x44               // =68
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurb	w2, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x7f               // =127
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x20, #0x70              // =112
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x26e
               	mov	x2, #0x46               // =70
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x0, #0x7f
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xff80             // =65408
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sturb	w0, [x29, #-0x18]
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x71              // =113
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x289
               	mov	x2, #0x49               // =73
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldursb	x0, [x29, #-0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsb	x2, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x72              // =114
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2a4
               	mov	x2, #0x4b               // =75
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldursb	x2, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	mov	x17, #0x7f              // =127
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	sturh	w0, [x29, #-0x20]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x21, #0x73              // =115
               	str	w21, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2bf
               	mov	x2, #0x4d               // =77
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurh	w0, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x20
               	ldrh	w2, [x0]
               	add	x2, x2, #0x1
               	strh	w2, [x0]
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x78              // =120
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2da
               	mov	x2, #0x53               // =83
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurh	w2, [x29, #-0x20]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x20]
               	sub	x2, x29, #0x20
               	ldrh	w0, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	strh	w0, [x2]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x21, #0x79              // =121
               	str	w21, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2f5
               	mov	x2, #0x55               // =85
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurh	w0, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x7fff             // =32767
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x20, #0x7a              // =122
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x310
               	mov	x2, #0x58               // =88
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x7fff            // =32767
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0x8000            // =32768
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x7b              // =123
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x32b
               	mov	x2, #0x5b               // =91
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x22, #0x7c              // =124
               	str	w22, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x346
               	mov	x2, #0x5d               // =93
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x20, x20, x17
               	mov	x17, #0x8000            // =32768
               	eor	x20, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxth	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x7d              // =125
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x361
               	mov	x2, #0x5f               // =95
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w0
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x7e              // =126
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x37c
               	mov	x2, #0x64               // =100
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x7f              // =127
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x397
               	mov	x2, #0x69               // =105
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x20, x17
               	mov	x17, #0xffff            // =65535
               	eor	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x2, x17
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x23, #0x80              // =128
               	str	w23, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x3b2
               	mov	x2, #0x6e               // =110
               	mov	x3, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	cmp	x20, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x70]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x81              // =129
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x3cd
               	mov	x2, #0x70               // =112
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	w0, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	w2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x82              // =130
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x3e8
               	mov	x2, #0x76               // =118
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	w2, [x29, #-0x70]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x70]
               	sub	x2, x29, #0x70
               	ldr	w0, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	w0, [x2]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x21, #0x83              // =131
               	str	w21, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x403
               	mov	x2, #0x78               // =120
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	w0, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x7fff, lsl #16
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x20, #0x84              // =132
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x41e
               	mov	x2, #0x7b               // =123
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x20, #0x80000000        // =2147483648
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x85              // =133
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x439
               	mov	x2, #0x7e               // =126
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x22, #0x86              // =134
               	str	w22, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x454
               	mov	x2, #0x80               // =128
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x87              // =135
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x46f
               	mov	x2, #0x86               // =134
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x20, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x22, #0x88              // =136
               	str	w22, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x48a
               	mov	x2, x22
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x98
               	ldr	x2, [x0]
               	add	x2, x2, #0x1
               	str	x2, [x0]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x20, #0x8c              // =140
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4a5
               	mov	x2, #0x8e               // =142
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x2, [x29, #-0x98]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x98
               	ldr	x2, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x2, x17
               	str	x2, [x0]
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x22, #0x8d              // =141
               	str	w22, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4c0
               	mov	x2, #0x90               // =144
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x2, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x20, #0x8e              // =142
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4db
               	mov	x2, #0x92               // =146
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x22, #0x8f              // =143
               	str	w22, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4f6
               	mov	x2, #0x95               // =149
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	asr	x0, x0, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x90              // =144
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x511
               	mov	x2, #0x9a               // =154
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsr	x0, x0, #1
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x22, #0x91              // =145
               	str	w22, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x52c
               	mov	x2, #0x9d               // =157
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsr	x0, x0, #32
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x22, #0xfed4            // =65236
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	sxtb	x23, w22
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x92              // =146
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x547
               	mov	x2, #0xa0               // =160
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtb	x2, w23
               	mov	x17, #0xffd4            // =65492
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	cset	x2, eq
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x158
               	mov	x24, #0x96              // =150
               	str	w24, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x562
               	mov	x2, #0xa9               // =169
               	mov	x3, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtb	x23, w23
               	mov	x17, #0xffd4            // =65492
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x23, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x22, x22, x17
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x97              // =151
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x57d
               	mov	x2, #0xaa               // =170
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x22, x17
               	mov	x17, #0xd4              // =212
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x23, #0x98              // =152
               	str	w23, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x598
               	mov	x2, #0xaf               // =175
               	mov	x3, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x22, x22, x17
               	cmp	x22, #0xd4
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxth	x22, w0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0x99              // =153
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x5b3
               	mov	x2, #0xb0               // =176
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w22
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x20, #0x9a              // =154
               	str	w20, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x5ce
               	mov	x2, #0xb5               // =181
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x22, w22
               	mov	x17, #0x2345            // =9029
               	cmp	x22, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1, lsl #16
               	sxth	x22, w0
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x23, #0x9b              // =155
               	str	w23, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x5e9
               	mov	x2, #0xb6               // =182
               	mov	x3, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x158
               	mov	x21, #0x9c              // =156
               	str	w21, [x1]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x604
               	mov	x2, #0xba               // =186
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x22, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	mov	x23, #0x1               // =1
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x20, #0x9d              // =157
               	str	w20, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x61f
               	mov	x2, #0xbb               // =187
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x22, x23
               	cset	x1, hi
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x22, w22
               	sxtw	x23, w23
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x158
               	mov	x25, #0xa0              // =160
               	str	w25, [x20]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x63a
               	mov	x2, #0xc2               // =194
               	mov	x3, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x22, w22
               	sxtw	x23, w23
               	cmp	x22, x23
               	cset	x22, lt
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, #0x158
               	mov	x21, #0xa1              // =161
               	str	w21, [x23]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x655
               	mov	x2, #0xc5               // =197
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsl	x0, x0, #30
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x22, #0xaa              // =170
               	str	w22, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x670
               	mov	x2, #0xcd               // =205
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsl	x0, x0, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0xab              // =171
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x68b
               	mov	x2, #0xcf               // =207
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x22, #0xac              // =172
               	str	w22, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x6a6
               	mov	x2, #0xd3               // =211
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	mov	x21, #0xad              // =173
               	str	w21, [x2]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x6c1
               	mov	x2, #0xd5               // =213
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x2, <page>
               	add	x2, x2, #0x6dc
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, #0x158
               	ldrsw	x2, [x2]
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
