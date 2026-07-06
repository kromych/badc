
struct_array_elided_runtime.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sxtw	x0, w0
               	sub	x1, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	add	x1, x0, #0x1
               	sub	x2, x29, #0x10
               	str	w1, [x2, #0x4]
               	add	x1, x0, #0x2
               	sub	x2, x29, #0x10
               	str	w1, [x2, #0x8]
               	add	x1, x0, #0x3
               	sub	x2, x29, #0x10
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1]
               	cmp	x1, x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x4]
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	cmp	x1, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0x8]
               	add	x2, x0, #0x2
               	sxtw	x2, w2
               	cmp	x1, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0xc]
               	add	x2, x0, #0x3
               	sxtw	x2, w2
               	cmp	x1, x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x28
               	str	w0, [x1]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x4]
               	add	x1, x0, #0x3
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x8]
               	add	x1, x0, #0x4
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0xc]
               	mov	x1, #0x7                // =7
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x10]
               	mov	x1, #0x8                // =8
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x14]
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1]
               	cmp	x1, x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0x8]
               	add	x2, x0, #0x3
               	sxtw	x2, w2
               	cmp	x1, x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x28
               	ldrsw	x1, [x1, #0xc]
               	add	x0, x0, #0x4
               	sxtw	x0, w0
               	cmp	x1, x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, #0x0               // =0
               	sxtw	x0, w20
               	cmp	x0, #0x14
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	sxtw	x0, w20
               	bl	<addr>
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
