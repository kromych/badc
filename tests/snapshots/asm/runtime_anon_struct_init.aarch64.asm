
runtime_anon_struct_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x2, x0
               	sub	x0, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x0]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0x20
               	str	w3, [x0]
               	sub	x0, x29, #0x20
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x20
               	str	x1, [x0, #0x10]
               	mov	x4, #0x7                // =7
               	sub	x0, x29, #0x20
               	str	w4, [x0, #0x18]
               	sub	x0, x29, #0x40
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x0]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x4, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x4, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x2                // =2
               	sub	x4, x29, #0x40
               	str	w0, [x4]
               	sub	x0, x29, #0x40
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x10]
               	mov	x4, #0x8                // =8
               	sub	x0, x29, #0x40
               	str	w4, [x0, #0x18]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	cmp	x0, x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0]
               	cmp	x0, #0x2
               	cset	x0, ne
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x10]
               	cmp	x0, x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_anon_union>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x3                // =3
               	sub	x2, x29, #0x10
               	str	w0, [x2]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>

<check_nested>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x2, x0
               	mov	x3, x1
               	sub	x0, x29, #0x28
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x9                // =9
               	sub	x1, x29, #0x28
               	str	w0, [x1]
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x28
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x28
               	str	x3, [x0, #0x18]
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x20]
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x4
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x10]
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x18]
               	cmp	x0, x3
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x20]
               	cmp	x0, #0x5
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x18               // =24
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
