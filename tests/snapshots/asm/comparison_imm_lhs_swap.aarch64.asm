
comparison_imm_lhs_swap.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
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
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0x100
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x15, #0x5               // =5
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x18]
               	cmp	x15, #0x0
               	b.le	<addr>
               	ldursw	x14, [x29, #-0x18]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0x0
               	b.lt	<addr>
               	ldursw	x13, [x29, #-0x18]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0xa
               	b.ge	<addr>
               	ldursw	x14, [x29, #-0x18]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0xa
               	b.gt	<addr>
               	ldursw	x13, [x29, #-0x18]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0x0
               	b.ls	<addr>
               	ldursw	x14, [x29, #-0x18]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0x0
               	b.lo	<addr>
               	ldursw	x13, [x29, #-0x18]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0xa
               	b.hs	<addr>
               	ldursw	x14, [x29, #-0x18]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0xa
               	b.hi	<addr>
               	ldursw	x13, [x29, #-0x18]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x18]
               	b	<addr>
               	cmp	x15, #0xa
               	b.le	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x15, #0x0
               	b.ge	<addr>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x18]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, #0x8
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x30]
               	b	<addr>
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x30]
               	b	<addr>
               	ldur	x1, [x29, #-0x30]
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
