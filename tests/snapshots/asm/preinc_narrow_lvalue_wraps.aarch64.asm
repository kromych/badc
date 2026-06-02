
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
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0xff              // =255
               	sturb	w15, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sub	x15, x29, #0x8
               	ldrb	w14, [x15]
               	add	x14, x14, #0x1
               	strb	w14, [x15]
               	ldrb	w15, [x15]
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x1
               	cset	x13, eq
               	stur	x13, [x29, #-0x18]
               	cbz	x13, <addr>
               	ldurb	w15, [x29, #-0x8]
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0xffff            // =65535
               	sturh	w15, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	add	x14, x14, #0x1
               	strh	w14, [x15]
               	ldrh	w15, [x15]
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x1
               	cset	x13, eq
               	stur	x13, [x29, #-0x18]
               	cbz	x13, <addr>
               	ldurh	w15, [x29, #-0x8]
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sub	x15, x29, #0x8
               	ldr	w14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	ldr	w15, [x15]
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x1
               	cset	x13, eq
               	stur	x13, [x29, #-0x18]
               	cbz	x13, <addr>
               	ldur	w15, [x29, #-0x8]
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0xf0              // =240
               	sturb	w15, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sub	x15, x29, #0x8
               	ldrb	w14, [x15]
               	add	x14, x14, #0x10
               	strb	w14, [x15]
               	ldrb	w15, [x15]
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x1
               	cset	x13, eq
               	stur	x13, [x29, #-0x18]
               	cbz	x13, <addr>
               	ldurb	w15, [x29, #-0x8]
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0xfff0            // =65520
               	sturh	w15, [x29, #-0x8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	sub	x15, x29, #0x8
               	ldrh	w14, [x15]
               	add	x14, x14, #0x10
               	strh	w14, [x15]
               	ldrh	w15, [x15]
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x1
               	cset	x13, eq
               	stur	x13, [x29, #-0x18]
               	cbz	x13, <addr>
               	ldurh	w15, [x29, #-0x8]
               	cmp	x15, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x18]
               	b	<addr>
               	ldur	x15, [x29, #-0x18]
               	cbz	x15, <addr>
               	mov	x13, #0x0               // =0
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	mov	x13, #0x1               // =1
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0xff              // =255
               	sturb	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x18]
               	ldrb	w13, [x14]
               	add	x13, x13, #0x1
               	strb	w13, [x14]
               	ldrb	w14, [x14]
               	cmp	x14, #0x0
               	b.ne	<addr>
               	mov	x15, #0x1               // =1
               	stur	w15, [x29, #-0x18]
               	b	<addr>
               	ldursw	x15, [x29, #-0x18]
               	cmp	x15, #0x1
               	cset	x15, eq
               	stur	x15, [x29, #-0x20]
               	cbz	x15, <addr>
               	ldurb	w14, [x29, #-0x8]
               	cmp	x14, #0x0
               	cset	x14, eq
               	stur	x14, [x29, #-0x20]
               	b	<addr>
               	ldur	x14, [x29, #-0x20]
               	cbz	x14, <addr>
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x28]
               	b	<addr>
               	mov	x15, #0x1               // =1
               	stur	x15, [x29, #-0x28]
               	b	<addr>
               	ldur	x0, [x29, #-0x28]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x21, x21, x0
               	str	w21, [x20]
               	sub	x22, x29, #0x8
               	ldrsw	x20, [x22]
               	bl	<addr>
               	orr	x20, x20, x0
               	str	w20, [x22]
               	sub	x21, x29, #0x8
               	ldrsw	x22, [x21]
               	bl	<addr>
               	orr	x22, x22, x0
               	str	w22, [x21]
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	bl	<addr>
               	orr	x21, x21, x0
               	str	w21, [x20]
               	sub	x22, x29, #0x8
               	ldrsw	x20, [x22]
               	bl	<addr>
               	orr	x20, x20, x0
               	str	w20, [x22]
               	sub	x21, x29, #0x8
               	ldrsw	x22, [x21]
               	bl	<addr>
               	orr	x22, x22, x0
               	str	w22, [x21]
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, x0
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
