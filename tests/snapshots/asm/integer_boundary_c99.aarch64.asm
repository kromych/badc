
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x108
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x120
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x126
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x12d
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x170
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x64              // =100
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x65              // =101
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x17b
               	mov	x2, #0x37               // =55
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x66              // =102
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x67              // =103
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b1
               	mov	x2, #0x39               // =57
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x68              // =104
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x69              // =105
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1e7
               	mov	x2, #0x3b               // =59
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x6a              // =106
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x6b              // =107
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x21d
               	mov	x2, #0x3d               // =61
               	mov	x3, x20
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
               	ldrb	w1, [x0]
               	add	x1, x1, #0x1
               	strb	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x6e              // =110
               	str	w20, [x0]
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
               	ldurb	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x6f              // =111
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x253
               	mov	x2, #0x44               // =68
               	mov	x3, x20
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
               	mov	x0, #0x7f               // =127
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x70              // =112
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x71              // =113
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x289
               	mov	x2, #0x49               // =73
               	mov	x3, x20
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
               	ldrsb	x1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	strb	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x72              // =114
               	str	w20, [x0]
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
               	ldursb	x0, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	mov	x17, #0x7f              // =127
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
               	mov	x0, #0xffff             // =65535
               	sturh	w0, [x29, #-0x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x73              // =115
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2bf
               	mov	x2, #0x4d               // =77
               	mov	x3, x20
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
               	ldrh	w1, [x0]
               	add	x1, x1, #0x1
               	strh	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x78              // =120
               	str	w20, [x0]
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
               	ldurh	w0, [x29, #-0x20]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	ldrh	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	strh	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x79              // =121
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x2f5
               	mov	x2, #0x55               // =85
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x7a              // =122
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x7b              // =123
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x32b
               	mov	x2, #0x5b               // =91
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x7c              // =124
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x346
               	mov	x2, #0x5d               // =93
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x8000            // =32768
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
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxth	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x7d              // =125
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x361
               	mov	x2, #0x5f               // =95
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x7e              // =126
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x7f              // =127
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x397
               	mov	x2, #0x69               // =105
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
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
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x80              // =128
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x3b2
               	mov	x2, #0x6e               // =110
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x70]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x81              // =129
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x3cd
               	mov	x2, #0x70               // =112
               	mov	x3, x20
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
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x82              // =130
               	str	w20, [x0]
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
               	ldur	w0, [x29, #-0x70]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x70]
               	sub	x0, x29, #0x70
               	ldr	w1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x83              // =131
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x403
               	mov	x2, #0x78               // =120
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x84              // =132
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x85              // =133
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x439
               	mov	x2, #0x7e               // =126
               	mov	x3, x20
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
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x86              // =134
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x454
               	mov	x2, #0x80               // =128
               	mov	x3, x21
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
               	and	x0, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x87              // =135
               	str	w21, [x0]
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
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x88              // =136
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x48a
               	mov	x2, x20
               	mov	x3, x20
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
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x8c              // =140
               	str	w20, [x0]
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
               	ldur	x0, [x29, #-0x98]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x98
               	ldr	x1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x8d              // =141
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4c0
               	mov	x2, #0x90               // =144
               	mov	x3, x20
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
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x8e              // =142
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x8f              // =143
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x4f6
               	mov	x2, #0x95               // =149
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x90              // =144
               	str	w20, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x91              // =145
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x52c
               	mov	x2, #0x9d               // =157
               	mov	x3, x20
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
               	mov	x20, #0xfed4            // =65236
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	sxtb	x21, w20
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x92              // =146
               	str	w20, [x0]
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
               	sxtb	x0, w21
               	mov	x17, #0xffd4            // =65492
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x22, #0x96              // =150
               	str	w22, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x562
               	mov	x2, #0xa9               // =169
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtb	x0, w21
               	mov	x17, #0xffd4            // =65492
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x20, x20, x17
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x97              // =151
               	str	w21, [x0]
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
               	and	x0, x20, x17
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x98              // =152
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x598
               	mov	x2, #0xaf               // =175
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x20, x17
               	cmp	x0, #0xd4
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxth	x20, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x99              // =153
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x5b3
               	mov	x2, #0xb0               // =176
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w20
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x9a              // =154
               	str	w21, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x5ce
               	mov	x2, #0xb5               // =181
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w20
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1, lsl #16
               	sxth	x20, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x9b              // =155
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x5e9
               	mov	x2, #0xb6               // =182
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x21, #0x9c              // =156
               	str	w21, [x0]
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
               	sxth	x0, w20
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
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0x9d              // =157
               	str	w20, [x0]
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
               	cmp	x20, x21
               	cset	x0, hi
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	sxtw	x1, w21
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x22, #0xa0              // =160
               	str	w22, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x63a
               	mov	x2, #0xc2               // =194
               	mov	x3, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w0
               	sxtw	x1, w1
               	cmp	x0, x1
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0xa1              // =161
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x655
               	mov	x2, #0xc5               // =197
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0xaa              // =170
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x670
               	mov	x2, #0xcd               // =205
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0xab              // =171
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x68b
               	mov	x2, #0xcf               // =207
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0xac              // =172
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x6a6
               	mov	x2, #0xd3               // =211
               	mov	x3, x20
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
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	mov	x20, #0xad              // =173
               	str	w20, [x0]
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x6c1
               	mov	x2, #0xd5               // =213
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x6dc
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x158
               	ldrsw	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
