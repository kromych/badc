
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
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
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
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
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x108
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x190
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	b	<addr>
               	mov	x15, #0x1               // =1
               	cmp	x15, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x14, x19
               	mov	x20, #0x64              // =100
               	str	w20, [x14]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x23, x19
               	mov	x21, #0x36              // =54
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x65              // =101
               	str	w24, [x21]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x17b
               	mov	x21, x19
               	mov	x25, #0x37              // =55
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0x66              // =102
               	str	w20, [x25]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x196
               	mov	x25, x19
               	mov	x22, #0x38              // =56
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x67              // =103
               	str	w24, [x22]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1b1
               	mov	x22, x19
               	mov	x23, #0x39              // =57
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x68              // =104
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1cc
               	mov	x23, x19
               	mov	x21, #0x3a              // =58
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x69              // =105
               	str	w24, [x21]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x1e7
               	mov	x21, x19
               	mov	x25, #0x3b              // =59
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0x6a              // =106
               	str	w20, [x25]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x202
               	mov	x25, x19
               	mov	x22, #0x3c              // =60
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x6b              // =107
               	str	w24, [x22]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x21d
               	mov	x22, x19
               	mov	x23, #0x3d              // =61
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x22
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
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w21, [x0]
               	add	x21, x21, #0x1
               	strb	w21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x6e              // =110
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x23, x19
               	mov	x21, #0x42              // =66
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurb	w21, [x29, #-0x8]
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w21, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	strb	w21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x24, #0x6f              // =111
               	str	w24, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x253
               	mov	x23, x19
               	mov	x21, #0x44              // =68
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x24, #0x7f              // =127
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x70              // =112
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x26e
               	mov	x23, x19
               	mov	x21, #0x46              // =70
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x24, #0x7f
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x0, #0xff80             // =65408
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sturb	w0, [x29, #-0x18]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0x71              // =113
               	str	w25, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x289
               	mov	x23, x19
               	mov	x21, #0x49              // =73
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x23
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
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	sub	x0, x29, #0x18
               	ldrsb	x26, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x26, x17
               	strb	w26, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x20, #0x72              // =114
               	str	w20, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x2a4
               	mov	x21, x19
               	mov	x26, #0x4b              // =75
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldursb	x26, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x26, x26, x17
               	mov	x17, #0x7f              // =127
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x0, #0xffff             // =65535
               	sturh	w0, [x29, #-0x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x22, #0x73              // =115
               	str	w22, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x2bf
               	mov	x21, x19
               	mov	x26, #0x4d              // =77
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x21
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
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	sub	x0, x29, #0x20
               	ldrh	w24, [x0]
               	add	x24, x24, #0x1
               	strh	w24, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x78              // =120
               	str	w20, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x2da
               	mov	x26, x19
               	mov	x24, #0x53              // =83
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x24
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldurh	w24, [x29, #-0x20]
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	ldrh	w0, [x24]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	strh	w0, [x24]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x22, #0x79              // =121
               	str	w22, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x2f5
               	mov	x26, x19
               	mov	x24, #0x55              // =85
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x24
               	mov	x1, x26
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
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x22, #0x7fff            // =32767
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x7a              // =122
               	str	w20, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x310
               	mov	x26, x19
               	mov	x21, #0x58              // =88
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x7fff            // =32767
               	cmp	x22, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x25, #0x8000            // =32768
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x7b              // =123
               	str	w23, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x32b
               	mov	x26, x19
               	mov	x21, #0x5b              // =91
               	mov	x0, x24
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x25, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x17, #0xffff            // =65535
               	and	x25, x25, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x20, #0x7c              // =124
               	str	w20, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x26, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x346
               	mov	x22, x19
               	mov	x21, #0x5d              // =93
               	mov	x0, x26
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	and	x0, x25, x17
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
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxth	x20, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x23, #0x7d              // =125
               	str	w23, [x21]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x361
               	mov	x21, x19
               	mov	x24, #0x5f              // =95
               	mov	x0, x22
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x21
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
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x23, #0xffd6            // =65494
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x24, #0x7e              // =126
               	str	w24, [x25]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x37c
               	mov	x25, x19
               	mov	x26, #0x64              // =100
               	mov	x0, x21
               	mov	x3, x24
               	mov	x2, x26
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x26, w23
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x24, #0xffff            // =65535
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x7f              // =127
               	str	w22, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x397
               	mov	x20, x19
               	mov	x26, #0x69              // =105
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x24, x17
               	mov	x17, #0xffff            // =65535
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0x80              // =128
               	str	w21, [x23]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x3b2
               	mov	x23, x19
               	mov	x26, #0x6e              // =110
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	cmp	x24, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x70]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x22, #0x81              // =129
               	str	w22, [x26]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	<addr>
               	mov	x23, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x3cd
               	mov	x26, x19
               	mov	x25, #0x70              // =112
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x25
               	mov	x1, x26
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
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x70
               	ldr	w20, [x0]
               	add	x20, x20, #0x1
               	str	w20, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x21, #0x82              // =130
               	str	w21, [x25]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x3e8
               	mov	x25, x19
               	mov	x20, #0x76              // =118
               	mov	x0, x24
               	mov	x3, x21
               	mov	x2, x20
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	w20, [x29, #-0x70]
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x20, #0x0               // =0
               	cbnz	x20, <addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x70]
               	sub	x20, x29, #0x70
               	ldr	w0, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	w0, [x20]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x23, #0x83              // =131
               	str	w23, [x25]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x26, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x403
               	mov	x25, x19
               	mov	x20, #0x78              // =120
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x25
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
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0x7fff, lsl #16
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x21, #0x84              // =132
               	str	w21, [x25]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x41e
               	mov	x25, x19
               	mov	x24, #0x7b              // =123
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x23, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x24, #0x0               // =0
               	cbnz	x24, <addr>
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x22, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x26, #0x85              // =133
               	str	w26, [x25]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	<addr>
               	mov	x20, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x439
               	mov	x25, x19
               	mov	x24, #0x7e              // =126
               	mov	x0, x20
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w22
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	sxtw	x26, w22
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x24, #0x86              // =134
               	str	w24, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x454
               	mov	x23, x19
               	mov	x21, #0x80              // =128
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	sxtw	x22, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x87              // =135
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x46f
               	mov	x23, x19
               	mov	x21, #0x86              // =134
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x22, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x98]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x24, #0x88              // =136
               	str	w24, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x27, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x48a
               	mov	x26, x19
               	mov	x0, x27
               	mov	x3, x24
               	mov	x2, x24
               	mov	x1, x26
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
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x98
               	ldr	x21, [x0]
               	add	x21, x21, #0x1
               	str	x21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x8c              // =140
               	str	w23, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x4a5
               	mov	x26, x19
               	mov	x21, #0x8e              // =142
               	mov	x0, x22
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x98]
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x98
               	ldr	x21, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	str	x21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x24, #0x8d              // =141
               	str	w24, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x27, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x4c0
               	mov	x26, x19
               	mov	x21, #0x90              // =144
               	mov	x0, x27
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldur	x21, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0x7fff, lsl #48
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x8e              // =142
               	str	w23, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x4db
               	mov	x26, x19
               	mov	x21, #0x92              // =146
               	mov	x0, x22
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x24, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x27, #0x8f              // =143
               	str	w27, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x4f6
               	mov	x26, x19
               	mov	x21, #0x95              // =149
               	mov	x0, x22
               	mov	x3, x27
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	asr	x21, x25, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x27, #-0x8000000000000000 // =-9223372036854775808
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x23, #0x90              // =144
               	str	w23, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x26, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x511
               	mov	x24, x19
               	mov	x21, #0x9a              // =154
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsr	x21, x27, #1
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x22, #0x91              // =145
               	str	w22, [x25]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x52c
               	mov	x25, x19
               	mov	x21, #0x9d              // =157
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsr	x21, x23, #32
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	mov	x22, #0xfed4            // =65236
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	sxtb	x21, w22
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x26, #0x92              // =146
               	str	w26, [x27]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x547
               	mov	x27, x19
               	mov	x21, #0xa0              // =160
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x21
               	mov	x1, x27
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtb	x23, w21
               	mov	x27, #0xd4              // =212
               	sxtb	x27, w27
               	cmp	x23, x27
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x24, #0x96              // =150
               	str	w24, [x27]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x562
               	mov	x27, x19
               	mov	x23, #0xa9              // =169
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x27
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
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x17, #0xff              // =255
               	and	x22, x22, x17
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x97              // =151
               	str	w20, [x23]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x27, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x57d
               	mov	x23, x19
               	mov	x26, #0xaa              // =170
               	mov	x0, x27
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x23
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
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x24, #0x98              // =152
               	str	w24, [x26]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x598
               	mov	x26, x19
               	mov	x25, #0xaf              // =175
               	mov	x0, x21
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xff              // =255
               	and	x0, x22, x17
               	cmp	x0, #0xd4
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxth	x24, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x27, #0x99              // =153
               	str	w27, [x25]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x26, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x5b3
               	mov	x25, x19
               	mov	x23, #0xb0              // =176
               	mov	x0, x26
               	mov	x3, x27
               	mov	x2, x23
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w24
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x21, #0x0               // =0
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x23, #0x9a              // =154
               	str	w23, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x5ce
               	mov	x22, x19
               	mov	x21, #0xb5              // =181
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w24
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x26, #0x0               // =0
               	cbnz	x26, <addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1, lsl #16
               	sxth	x23, w0
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x27, #0x9b              // =155
               	str	w27, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x5e9
               	mov	x21, x19
               	mov	x26, #0xb6              // =182
               	mov	x0, x22
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x25, #0x0               // =0
               	cbnz	x25, <addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x26, #0x9c              // =156
               	str	w26, [x24]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x604
               	mov	x24, x19
               	mov	x25, #0xba              // =186
               	mov	x0, x21
               	mov	x3, x26
               	mov	x2, x25
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxth	x0, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	cbnz	x22, <addr>
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x27, #0x9d              // =157
               	str	w27, [x25]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x61f
               	mov	x25, x19
               	mov	x22, #0xbb              // =187
               	mov	x0, x24
               	mov	x3, x27
               	mov	x2, x22
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x26, x21
               	cset	x23, hi
               	cmp	x23, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x23, #0x0               // =0
               	cbnz	x23, <addr>
               	sxtw	x26, w26
               	sxtw	x21, w21
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x22, #0xa0              // =160
               	str	w22, [x25]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	<addr>
               	mov	x24, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x63a
               	mov	x25, x19
               	mov	x23, #0xc2              // =194
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x23
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w26
               	sxtw	x23, w21
               	cmp	x0, x23
               	cset	x0, lt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	mov	x22, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0xa1              // =161
               	str	w20, [x23]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x655
               	mov	x23, x19
               	mov	x27, #0xc5              // =197
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x27
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsl	x27, x22, #30
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x27, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	mov	x25, #0x1               // =1
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0xaa              // =170
               	str	w24, [x21]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	<addr>
               	mov	x26, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x670
               	mov	x21, x19
               	mov	x27, #0xcd              // =205
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	lsl	x27, x25, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x27, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x23, #0xab              // =171
               	str	w23, [x22]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	<addr>
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x68b
               	mov	x22, x19
               	mov	x27, #0xcf              // =207
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x27
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x26, #0xac              // =172
               	str	w26, [x25]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	<addr>
               	mov	x22, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x6a6
               	mov	x25, x19
               	mov	x27, #0xd3              // =211
               	mov	x0, x22
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x23, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	<addr>
               	b	<addr>
               	mov	x27, #0x0               // =0
               	cbnz	x27, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x21, #0xad              // =173
               	str	w21, [x24]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	<addr>
               	mov	x25, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x6c1
               	mov	x24, x19
               	mov	x27, #0xd5              // =213
               	mov	x0, x25
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x24
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x6dc
               	mov	x26, x19
               	mov	x0, x26
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x26, x19
               	ldrsw	x26, [x26]
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
