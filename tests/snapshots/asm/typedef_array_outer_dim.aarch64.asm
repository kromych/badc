
typedef_array_outer_dim.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, x0
               	mov	x14, #0x0               // =0
               	stur	x14, [x29, #-0x18]
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	cmp	x14, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	add	x14, x14, #0x1
               	str	w14, [x13]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x10]
               	b	<addr>
               	ldur	x0, [x29, #-0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x10]
               	cmp	x14, #0x10
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x10
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	lsl	x13, x14, #7
               	add	x13, x15, x13
               	ldursw	x12, [x29, #-0x10]
               	lsl	x11, x12, #3
               	add	x13, x13, x11
               	lsl	x14, x14, #4
               	sxtw	x14, w14
               	add	x14, x14, x12
               	sxtw	x14, w14
               	str	x14, [x13]
               	sub	x12, x29, #0x18
               	ldr	x14, [x12]
               	ldursw	x13, [x29, #-0x8]
               	lsl	x13, x13, #7
               	add	x13, x15, x13
               	ldursw	x11, [x29, #-0x10]
               	lsl	x11, x11, #3
               	add	x13, x13, x11
               	ldr	x11, [x13]
               	add	x14, x14, x11
               	str	x14, [x12]
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	mov	x15, #0x40              // =64
               	sxtw	x15, w15
               	lsl	x15, x15, #3
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	sub	x17, x29, #0x208
               	str	x15, [x17]
               	sub	x17, x29, #0x210
               	str	w15, [x17]
               	b	<addr>
               	sub	x16, x29, #0x210
               	ldrsw	x15, [x16]
               	mov	x14, #0x40              // =64
               	sxtw	x14, w14
               	cmp	x15, x14
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x210
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	<addr>
               	sub	x15, x29, #0x208
               	ldr	x13, [x15]
               	sub	x16, x29, #0x210
               	ldrsw	x14, [x16]
               	add	x13, x13, x14
               	str	x13, [x15]
               	b	<addr>
               	sub	x20, x29, #0x200
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x208
               	ldr	x20, [x16]
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x20, [x0]
               	cmp	x20, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x200
               	add	x20, x20, #0x1f8
               	ldr	x0, [x20]
               	cmp	x0, #0x3f
               	b.eq	<addr>
               	mov	x20, #0x4               // =4
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	add	x0, x0, #0xb8
               	ldr	x20, [x0]
               	cmp	x20, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
