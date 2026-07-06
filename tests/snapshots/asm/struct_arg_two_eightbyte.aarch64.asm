
struct_arg_two_eightbyte.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x3, [x16]
               	str	x4, [x16, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x10
               	ldr	w0, [x0, #0x8]
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x20
               	ldr	w0, [x0, #0x8]
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<pair>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x16, x29, #0x20
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x10
               	ldr	w0, [x0, #0x8]
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x29, #0x20
               	ldr	w0, [x0, #0x8]
               	str	w0, [x1]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x0, x29, #0x8
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x1111             // =4369
               	str	x1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x28
               	mov	x1, #0x2222             // =8738
               	str	x1, [x0]
               	sub	x0, x29, #0x28
               	mov	x1, #0x6                // =6
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x18
               	sub	x2, x29, #0x28
               	mov	x3, x2
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	ldr	x4, [x3, #0x8]
               	ldr	x3, [x3]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x28
               	mov	x2, x1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
