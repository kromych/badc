
getopt_long_permutes_operands.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1a0
               	sub	x0, x29, #0x1a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldrb	w16, [x1, #0x4]
               	strb	w16, [x0, #0x4]
               	sub	x1, x29, #0x198
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w16, [x2]
               	str	w16, [x1]
               	sub	x2, x29, #0x190
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w16, [x3]
               	str	w16, [x2]
               	sub	x3, x29, #0x188
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	w16, [x4]
               	str	w16, [x3]
               	ldrb	w16, [x4, #0x4]
               	strb	w16, [x3, #0x4]
               	sub	x4, x29, #0x180
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	w16, [x5]
               	str	w16, [x4]
               	ldrb	w16, [x5, #0x4]
               	strb	w16, [x4, #0x4]
               	sub	x5, x29, #0x178
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldr	w16, [x6]
               	str	w16, [x5]
               	sub	x6, x29, #0xe8
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldr	x16, [x7]
               	str	x16, [x6]
               	ldrh	w16, [x7, #0x8]
               	strh	w16, [x6, #0x8]
               	sub	x7, x29, #0x170
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	ldr	w16, [x8]
               	str	w16, [x7]
               	ldrh	w16, [x8, #0x4]
               	strh	w16, [x7, #0x4]
               	ldrb	w16, [x8, #0x6]
               	strb	w16, [x7, #0x6]
               	sub	x8, x29, #0x168
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	ldr	w16, [x9]
               	str	w16, [x8]
               	ldrh	w16, [x9, #0x4]
               	strh	w16, [x8, #0x4]
               	ldrb	w16, [x9, #0x6]
               	strb	w16, [x8, #0x6]
               	sub	x9, x29, #0x160
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	ldrh	w16, [x10]
               	strh	w16, [x9]
               	ldrb	w16, [x10, #0x2]
               	strb	w16, [x9, #0x2]
               	sub	x10, x29, #0x158
               	adrp	x11, <page>
               	add	x11, x11, <lo12>
               	ldrh	w16, [x11]
               	strh	w16, [x10]
               	ldrb	w16, [x11, #0x2]
               	strb	w16, [x10, #0x2]
               	sub	x10, x29, #0x60
               	stp	xzr, xzr, [x10]
               	stp	xzr, xzr, [x10, #0x10]
               	stp	xzr, xzr, [x10, #0x20]
               	stp	xzr, xzr, [x10, #0x30]
               	stp	xzr, xzr, [x10, #0x40]
               	stp	xzr, xzr, [x10, #0x50]
               	stur	x0, [x29, #-0x60]
               	stur	x1, [x29, #-0x58]
               	stur	x2, [x29, #-0x50]
               	stur	x3, [x29, #-0x48]
               	stur	x4, [x29, #-0x40]
               	stur	x5, [x29, #-0x38]
               	stur	x6, [x29, #-0x30]
               	stur	x7, [x29, #-0x28]
               	stur	x8, [x29, #-0x20]
               	stur	x9, [x29, #-0x18]
               	sub	x0, x29, #0x158
               	sub	x1, x29, #0x60
               	stur	x0, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	sub	x2, x29, #0x150
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w16, [x3]
               	str	w16, [x2]
               	ldrb	w16, [x3, #0x4]
               	strb	w16, [x2, #0x4]
               	sub	x3, x29, #0x148
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrh	w16, [x4]
               	strh	w16, [x3]
               	ldrb	w16, [x4, #0x2]
               	strb	w16, [x3, #0x2]
               	sub	x4, x29, #0x140
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrh	w16, [x5]
               	strh	w16, [x4]
               	ldrb	w16, [x5, #0x2]
               	strb	w16, [x4, #0x2]
               	sub	x5, x29, #0xd8
               	stp	xzr, xzr, [x5]
               	stp	xzr, xzr, [x5, #0x10]
               	stur	x2, [x29, #-0xd8]
               	stur	x3, [x29, #-0xd0]
               	stur	x4, [x29, #-0xc8]
               	stur	xzr, [x29, #-0xc0]
               	sub	x2, x29, #0x138
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w16, [x3]
               	str	w16, [x2]
               	ldrb	w16, [x3, #0x4]
               	strb	w16, [x2, #0x4]
               	sub	x3, x29, #0x130
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	w16, [x4]
               	str	w16, [x3]
               	ldrh	w16, [x4, #0x4]
               	strh	w16, [x3, #0x4]
               	ldrb	w16, [x4, #0x6]
               	strb	w16, [x3, #0x6]
               	sub	x4, x29, #0x128
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	x16, [x5]
               	str	x16, [x4]
               	sub	x5, x29, #0x120
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrh	w16, [x6]
               	strh	w16, [x5]
               	ldrb	w16, [x6, #0x2]
               	strb	w16, [x5, #0x2]
               	sub	x6, x29, #0xb8
               	stp	xzr, xzr, [x6]
               	stp	xzr, xzr, [x6, #0x10]
               	str	xzr, [x6, #0x20]
               	stur	x2, [x29, #-0xb8]
               	stur	x3, [x29, #-0xb0]
               	stur	x4, [x29, #-0xa8]
               	stur	x5, [x29, #-0xa0]
               	stur	xzr, [x29, #-0x98]
               	sub	x2, x29, #0x118
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w16, [x3]
               	str	w16, [x2]
               	ldrb	w16, [x3, #0x4]
               	strb	w16, [x2, #0x4]
               	sub	x3, x29, #0x110
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrh	w16, [x4]
               	strh	w16, [x3]
               	ldrb	w16, [x4, #0x2]
               	strb	w16, [x3, #0x2]
               	sub	x4, x29, #0x108
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldr	w16, [x5]
               	str	w16, [x4]
               	sub	x5, x29, #0x100
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	ldrh	w16, [x6]
               	strh	w16, [x5]
               	ldrb	w16, [x6, #0x2]
               	strb	w16, [x5, #0x2]
               	sub	x6, x29, #0xf8
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	ldrh	w16, [x7]
               	strh	w16, [x6]
               	ldrb	w16, [x7, #0x2]
               	strb	w16, [x6, #0x2]
               	sub	x7, x29, #0x90
               	stp	xzr, xzr, [x7]
               	stp	xzr, xzr, [x7, #0x10]
               	stp	xzr, xzr, [x7, #0x20]
               	stur	x2, [x29, #-0x90]
               	stur	x3, [x29, #-0x88]
               	stur	x4, [x29, #-0x80]
               	stur	x5, [x29, #-0x78]
               	stur	x6, [x29, #-0x70]
               	stur	xzr, [x29, #-0x68]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #-0x1               // =-1
               	stur	w3, [x29, #-0xf0]
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	str	wzr, [x3]
               	adrp	x3, <page>
               	ldr	x3, [x3, <lo12>]
               	str	wzr, [x3]
               	mov	x0, #0xb                // =11
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x42
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0xf0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x47
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0xf0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x63
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xf0]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	sub	x1, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x4, #0x0                // =0
               	str	w4, [x0]
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0xd8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3f
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x78
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0xd8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	wzr, [x0]
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0xb8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x41
               	b.ne	<addr>
               	ldursw	x0, [x29, #-0xf0]
               	cbz	w0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0xb8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x42
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0xb8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	sub	x1, x29, #0xb8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x4, x29, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x90
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x90
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x90
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x61
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x90
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
