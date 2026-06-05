
for_init_declaration.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	ldursw	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	ldursw	x1, [x29, #-0x18]
               	cmp	x0, x1
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	ldursw	x2, [x29, #-0x10]
               	ldursw	x3, [x29, #-0x18]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2a               // =42
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x10]
               	b	<addr>
               	ldursw	x1, [x29, #-0x10]
               	cmp	x1, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x10
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	b	<addr>
               	b	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	ldursw	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0xd
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	ldursw	x2, [x29, #-0x18]
               	add	x1, x1, x2
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	str	w2, [x0]
               	mov	x2, #0x4                // =4
               	add	x3, x0, #0x4
               	mov	x4, #0x2                // =2
               	str	w4, [x3]
               	add	x3, x0, #0x8
               	str	w2, [x3]
               	stur	w1, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	b	<addr>
               	ldur	x1, [x29, #-0x10]
               	add	x2, x0, #0xc
               	cmp	x1, x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x10
               	ldr	x2, [x1]
               	add	x2, x2, #0x4
               	str	x2, [x1]
               	b	<addr>
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	ldur	x3, [x29, #-0x10]
               	ldrsw	x3, [x3]
               	add	x2, x2, x3
               	str	w2, [x1]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	bl	<addr>
               	cmp	x0, #0x2d
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x160
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x32
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x175
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x18a
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2b
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x19e
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x1b6
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
