
const_expr_arithmetic.aarch64:	file format elf64-littleaarch64

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
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x20              // =32
               	mov	x15, #0x4               // =4
               	sdiv	x14, x14, x15
               	cmp	x14, #0x8
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x370
               	mov	x14, #0x20              // =32
               	mov	x13, #0x4               // =4
               	sdiv	x1, x14, x13
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x18               // =24
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x383
               	mov	x0, #0x18               // =24
               	mov	x13, #0x4               // =4
               	sdiv	x14, x0, x13
               	mov	x0, x1
               	mov	x1, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x40               // =64
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x396
               	mov	x0, #0x40               // =64
               	mov	x13, #0x4               // =4
               	sdiv	x14, x0, x13
               	mov	x0, x1
               	mov	x1, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x40               // =64
               	mov	x1, #0x4                // =4
               	sdiv	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x3a9
               	mov	x0, #0x40               // =64
               	mov	x20, #0x4               // =4
               	sdiv	x14, x0, x20
               	mov	x0, x1
               	mov	x1, x14
               	bl	<addr>
               	sxtw	x0, w0
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	mov	x20, #0x18              // =24
               	mov	x0, #0x4                // =4
               	sdiv	x20, x20, x0
               	cmp	x20, #0x6
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3bc
               	mov	x20, #0x18              // =24
               	mov	x1, #0x4                // =4
               	sdiv	x14, x20, x1
               	mov	x1, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x20               // =32
               	mov	x14, #0x4               // =4
               	sdiv	x0, x0, x14
               	cmp	x0, #0x8
               	b.eq	<addr>
               	adrp	x14, <page>
               	add	x14, x14, #0x3cf
               	mov	x0, #0x20               // =32
               	mov	x1, #0x4                // =4
               	sdiv	x20, x0, x1
               	mov	x0, x14
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x18               // =24
               	mov	x14, #0x4               // =4
               	sdiv	x0, x0, x14
               	cmp	x0, #0x6
               	b.eq	<addr>
               	adrp	x14, <page>
               	add	x14, x14, #0x3e6
               	mov	x0, #0x18               // =24
               	mov	x1, #0x4                // =4
               	sdiv	x20, x0, x1
               	mov	x0, x14
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
