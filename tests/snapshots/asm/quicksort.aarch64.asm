
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	mov	x15, x0
               	mov	x14, x1
               	ldrsw	x13, [x15]
               	ldrsw	x12, [x14]
               	str	w12, [x15]
               	sxtw	x13, w13
               	str	w13, [x14]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x14, w1
               	sxtw	x21, w2
               	lsl	x12, x21, #2
               	add	x12, x20, x12
               	ldrsw	x22, [x12]
               	sub	x12, x14, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	stur	w14, [x29, #-0x18]
               	b	<addr>
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, x21
               	b.ge	<addr>
               	b	<addr>
               	sub	x10, x29, #0x18
               	ldrsw	x14, [x10]
               	add	x14, x14, #0x1
               	str	w14, [x10]
               	b	<addr>
               	ldursw	x14, [x29, #-0x18]
               	lsl	x14, x14, #2
               	add	x14, x20, x14
               	ldrsw	x14, [x14]
               	sxtw	x12, w22
               	cmp	x14, x12
               	b.gt	<addr>
               	b	<addr>
               	ldursw	x1, [x29, #-0x10]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x20, x1
               	lsl	x21, x21, #2
               	add	x1, x20, x21
               	bl	<addr>
               	mov	x21, x0
               	ldursw	x21, [x29, #-0x10]
               	add	x21, x21, #0x1
               	sxtw	x21, w21
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x10
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	ldursw	x10, [x29, #-0x10]
               	lsl	x10, x10, #2
               	add	x0, x20, x10
               	ldursw	x10, [x29, #-0x18]
               	lsl	x10, x10, #2
               	add	x1, x20, x10
               	bl	<addr>
               	mov	x10, x0
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x21, w1
               	sxtw	x22, w2
               	cmp	x21, x22
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	stur	w0, [x29, #-0x8]
               	ldursw	x12, [x29, #-0x8]
               	sub	x12, x12, #0x1
               	sxtw	x2, w12
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, #0x0                // =0
               	mov	x13, #0xc               // =12
               	str	w13, [x20]
               	mov	x2, #0x4                // =4
               	add	x13, x20, #0x4
               	mov	x11, #0x7               // =7
               	str	w11, [x13]
               	add	x10, x20, #0x8
               	mov	x11, #0xf               // =15
               	str	w11, [x10]
               	add	x13, x20, #0xc
               	mov	x11, #0x5               // =5
               	str	w11, [x13]
               	add	x10, x20, #0x10
               	mov	x11, #0xa               // =10
               	str	w11, [x10]
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x2, #0x2                // =2
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x2, #0x3                // =3
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x2, #0x4                // =4
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x20, #0x10
               	ldrsw	x20, [x20]
               	cmp	x20, #0xf
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
