
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
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x11, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x370
               	mov	x0, x19
               	mov	x14, #0x20              // =32
               	mov	x13, #0x4               // =4
               	sdiv	x1, x14, x13
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	mov	x13, #0x18              // =24
               	mov	x1, #0x4                // =4
               	sdiv	x13, x13, x1
               	cmp	x13, #0x6
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x383
               	mov	x0, x19
               	mov	x13, #0x18              // =24
               	mov	x1, #0x4                // =4
               	sdiv	x14, x13, x1
               	mov	x1, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	mov	x1, #0x40               // =64
               	mov	x14, #0x4               // =4
               	sdiv	x1, x1, x14
               	cmp	x1, #0x10
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x396
               	mov	x0, x19
               	mov	x1, #0x40               // =64
               	mov	x14, #0x4               // =4
               	sdiv	x13, x1, x14
               	mov	x1, x13
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x3               // =3
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0x40              // =64
               	mov	x13, #0x4               // =4
               	sdiv	x14, x14, x13
               	cmp	x14, #0x10
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3a9
               	mov	x0, x19
               	mov	x14, #0x40              // =64
               	mov	x20, #0x4               // =4
               	sdiv	x1, x14, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	mov	x20, #0x18              // =24
               	mov	x14, #0x4               // =4
               	sdiv	x20, x20, x14
               	cmp	x20, #0x6
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3bc
               	mov	x0, x19
               	mov	x20, #0x18              // =24
               	mov	x1, #0x4                // =4
               	sdiv	x14, x20, x1
               	mov	x1, x14
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x8]
               	b	<addr>
               	mov	x1, #0x20               // =32
               	mov	x14, #0x4               // =4
               	sdiv	x1, x1, x14
               	cmp	x1, #0x8
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3cf
               	mov	x0, x19
               	mov	x1, #0x20               // =32
               	mov	x14, #0x4               // =4
               	sdiv	x20, x1, x14
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	mov	x14, #0x6               // =6
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0x18              // =24
               	mov	x20, #0x4               // =4
               	sdiv	x14, x14, x20
               	cmp	x14, #0x6
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x3e6
               	mov	x0, x19
               	mov	x14, #0x18              // =24
               	mov	x20, #0x4               // =4
               	sdiv	x1, x14, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x7               // =7
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	ldursw	x20, [x29, #-0x8]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
