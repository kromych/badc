
declarator_list_forms.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<sub>:
               	sub	x0, x0, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	str	x20, [sp, #-0xb0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	sub	x4, x29, #0x8
               	sub	x1, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x5, #0x2                // =2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x3, [x2]
               	str	w5, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x3, [x3]
               	cmp	x3, #0x4
               	cset	x3, ne
               	cbnz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	x0, [x2]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x2, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x2, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	sxtw	x0, w0
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	ldursw	x0, [x29, #-0x8]
               	ldrsw	x2, [x4]
               	add	x0, x0, x2
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	sub	x2, x29, #0x18
               	ldrsw	x2, [x2, #0x4]
               	add	x0, x0, x2
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	mov	x0, #0x14               // =20
               	mov	x2, #0x3                // =3
               	mov	x9, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x14               // =20
               	mov	x1, #0x3                // =3
               	mov	x9, x20
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x11
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
