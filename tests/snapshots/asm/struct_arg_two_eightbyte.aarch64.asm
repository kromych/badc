
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
               	add	x1, x1, #0xf0
               	ldrsw	x0, [x0]
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	sub	x1, x29, #0x10
               	ldr	w1, [x1, #0x8]
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xd8
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	sub	x1, x29, #0x20
               	ldr	w1, [x1, #0x8]
               	str	w1, [x0]
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
               	add	x0, x0, #0xf8
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	sub	x1, x29, #0x10
               	ldr	w1, [x1, #0x8]
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x110
               	sub	x1, x29, #0x20
               	ldr	w1, [x1, #0x8]
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
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
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x20, ne
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldr	w0, [x0]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xd8
               	ldr	x0, [x0]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	cset	x20, ne
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	ldr	w0, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x70
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
               	add	x0, x0, #0xf8
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	ldr	w0, [x0]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	ldr	x0, [x0]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x110
               	ldr	w0, [x0]
               	mov	x17, #0x6               // =6
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
