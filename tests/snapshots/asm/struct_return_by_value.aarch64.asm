
struct_return_by_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x1, x29, #0x8
               	str	w0, [x1]
               	sub	x1, x29, #0x8
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_big>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x8, [x16]
               	sub	x1, x29, #0x18
               	str	x0, [x1]
               	sub	x1, x29, #0x18
               	add	x2, x0, #0x1
               	str	x2, [x1, #0x8]
               	sub	x1, x29, #0x18
               	add	x0, x0, #0x2
               	str	x0, [x1, #0x10]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	sub	x17, x29, #0x20
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_small>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x1, x29, #0x8
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sum_big>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	sub	x1, x29, #0x18
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x18
               	ldr	x1, [x1, #0x10]
               	add	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<small_round>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x20
               	str	w0, [x1]
               	sub	x1, x29, #0x20
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x20
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<big_round>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<echo_small>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x90
               	str	w0, [x1]
               	sub	x1, x29, #0x90
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x90
               	sub	x1, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0xb0
               	bl	<addr>
               	sub	x0, x29, #0xb0
               	sub	x1, x29, #0x28
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x28
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0xb
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0xc
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	sub	x1, x29, #0xc8
               	str	w0, [x1]
               	sub	x1, x29, #0xc8
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0xc8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	sub	x8, x29, #0xe0
               	bl	<addr>
               	sub	x0, x29, #0xe0
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x20
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	mov	x1, #0x28               // =40
               	sub	x2, x29, #0xe8
               	str	w1, [x2]
               	sub	x2, x29, #0xe8
               	add	x1, x1, #0x1
               	str	w1, [x2, #0x4]
               	sub	x1, x29, #0xe8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0]
               	cmp	x0, #0x28
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x29
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0xf8
               	str	x0, [x16]
               	sub	x0, x29, #0xf8
               	sub	x1, x29, #0x78
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x78
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
