
preinc_narrow_lvalue_wraps.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
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
               	add	x21, x21, #0x100
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
               	add	x2, x2, #0x118
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x11e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x125
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
               	sub	sp, sp, #0x20
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	add	x1, x1, #0x1
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xffff             // =65535
               	sturh	w0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldrh	w1, [x0]
               	add	x1, x1, #0x1
               	strh	w1, [x0]
               	ldrh	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurh	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldr	w1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldr	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldur	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xf0               // =240
               	sturb	w0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldrb	w1, [x0]
               	add	x1, x1, #0x10
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xfff0             // =65520
               	sturh	w0, [x29, #-0x8]
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	ldrh	w1, [x0]
               	add	x1, x1, #0x10
               	strh	w1, [x0]
               	ldrh	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurh	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x2, #0x0                // =0
               	ldrb	w1, [x0]
               	add	x1, x1, #0x1
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x0, x21, x0
               	str	w0, [x20]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x0, x21, x0
               	str	w0, [x20]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x0, x21, x0
               	str	w0, [x20]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x0, x21, x0
               	str	w0, [x20]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x0, x21, x0
               	str	w0, [x20]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x0, x21, x0
               	str	w0, [x20]
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
