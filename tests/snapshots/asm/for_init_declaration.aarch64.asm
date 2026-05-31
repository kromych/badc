
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
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
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
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
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
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
               	sub	sp, sp, #0x10
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	<addr>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	ldursw	x14, [x29, #-0x10]
               	add	x13, x13, x14
               	str	w13, [x15]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0xa               // =10
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	ldursw	x15, [x29, #-0x18]
               	cmp	x14, x15
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	sub	x13, x29, #0x18
               	ldrsw	x14, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x14, x14, x17
               	str	w14, [x13]
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	ldursw	x13, [x29, #-0x10]
               	ldursw	x12, [x29, #-0x18]
               	add	x13, x13, x12
               	sxtw	x13, w13
               	add	x15, x15, x13
               	str	w15, [x14]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x2a               // =42
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x10
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	<addr>
               	b	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	<addr>
               	ldursw	x15, [x29, #-0x10]
               	cmp	x15, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	ldursw	x14, [x29, #-0x10]
               	add	x13, x13, x14
               	str	w13, [x15]
               	b	<addr>
               	mov	x14, #0xa               // =10
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, #0xd
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x18
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	ldursw	x15, [x29, #-0x18]
               	add	x13, x13, x15
               	str	w13, [x14]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x15, x19
               	mov	x14, #0x0               // =0
               	mov	x13, #0x1               // =1
               	str	w13, [x15]
               	mov	x12, #0x4               // =4
               	add	x13, x15, #0x4
               	mov	x11, #0x2               // =2
               	str	w11, [x13]
               	add	x10, x15, #0x8
               	str	w12, [x10]
               	stur	w14, [x29, #-0x8]
               	stur	x15, [x29, #-0x10]
               	b	<addr>
               	ldur	x15, [x29, #-0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x11, x19
               	add	x11, x11, #0xc
               	cmp	x15, x11
               	b.ge	<addr>
               	b	<addr>
               	sub	x11, x29, #0x10
               	ldr	x15, [x11]
               	add	x15, x15, #0x4
               	str	x15, [x11]
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	ldur	x11, [x29, #-0x10]
               	ldrsw	x11, [x11]
               	add	x14, x14, x11
               	str	w14, [x15]
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	<addr>
               	cmp	x0, #0x2d
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x20, x19
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x32
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x175
               	mov	x21, x19
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x18a
               	mov	x22, x19
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, x22
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2b
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x19e
               	mov	x20, x19
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x22, #0x4               // =4
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1b6
               	mov	x21, x19
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
