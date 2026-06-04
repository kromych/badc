
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x1]
               	str	w3, [x0]
               	str	w2, [x1]
               	mov	x0, #0x0                // =0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, x0
               	mov	x21, x2
               	mov	x0, x1
               	sxtw	x0, w0
               	sxtw	x21, w21
               	lsl	x1, x21, #2
               	add	x1, x20, x1
               	ldrsw	x22, [x1]
               	sub	x1, x0, #0x1
               	sxtw	x1, w1
               	stur	w1, [x29, #-0x10]
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, x21
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	lsl	x0, x0, #2
               	add	x0, x20, x0
               	ldrsw	x0, [x0]
               	cmp	x0, x22
               	b.gt	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	lsl	x0, x0, #2
               	add	x0, x20, x0
               	lsl	x1, x21, #2
               	add	x1, x20, x1
               	bl	<addr>
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldursw	x0, [x29, #-0x10]
               	lsl	x0, x0, #2
               	add	x0, x20, x0
               	ldursw	x1, [x29, #-0x18]
               	lsl	x1, x1, #2
               	add	x1, x20, x1
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	mov	x22, x2
               	mov	x21, x1
               	sxtw	x21, w21
               	sxtw	x22, w22
               	cmp	x21, x22
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x23, x0
               	sxtw	x0, w23
               	sub	x0, x0, #0x1
               	sxtw	x2, w0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w23
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
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
               	mov	x0, #0xc                // =12
               	str	w0, [x20]
               	mov	x2, #0x4                // =4
               	add	x0, x20, #0x4
               	mov	x3, #0x7                // =7
               	str	w3, [x0]
               	add	x0, x20, #0x8
               	mov	x3, #0xf                // =15
               	str	w3, [x0]
               	add	x0, x20, #0xc
               	mov	x3, #0x5                // =5
               	str	w3, [x0]
               	add	x0, x20, #0x10
               	mov	x3, #0xa                // =10
               	str	w3, [x0]
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x20, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
