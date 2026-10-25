
vla_pointer_block_scope.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x40
               	add	x0, x1, #0x1
               	sub	x0, x0, x1
               	cmp	x0, #0x1
               	cset	x0, ne
               	orr	x5, x0, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	add	x4, x3, #0x1
               	sub	x3, x4, x3
               	cmp	x3, #0x1
               	cset	x4, ne
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x3, [x0]
               	orr	x5, x5, x4
               	add	x4, x1, #0x2
               	sub	x4, x4, x1
               	cmp	x4, #0x2
               	cset	x4, ne
               	orr	x4, x4, x4
               	orr	x5, x5, x4
               	ldr	x4, [x0]
               	cbz	x4, <addr>
               	ldr	x4, [x0]
               	add	x6, x4, #0x2
               	sub	x4, x6, x4
               	cmp	x4, #0x2
               	cset	x4, ne
               	str	x3, [x0]
               	orr	x5, x5, x4
               	add	x4, x1, #0x4
               	sub	x4, x4, x1
               	cmp	x4, #0x4
               	cset	x4, ne
               	orr	x4, x4, x4
               	orr	x4, x5, x4
               	ldr	x5, [x0]
               	cbz	x5, <addr>
               	ldr	x2, [x0]
               	add	x5, x2, #0x4
               	sub	x2, x5, x2
               	cmp	x2, #0x4
               	cset	x2, ne
               	str	x3, [x0]
               	orr	x2, x4, x2
               	add	x0, x1, #0x8
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	cset	x0, ne
               	orr	x0, x0, x0
               	orr	x4, x2, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldr	x2, [x0]
               	add	x3, x2, #0x8
               	sub	x2, x3, x2
               	cmp	x2, #0x8
               	cset	x2, ne
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x3, [x0]
               	orr	x4, x4, x2
               	sub	x2, x29, #0x40
               	add	x5, x2, #0x10
               	sub	x2, x5, x2
               	cmp	x2, #0x10
               	cset	x2, ne
               	orr	x2, x2, x2
               	orr	x2, x4, x2
               	ldr	x4, [x0]
               	cbz	x4, <addr>
               	ldr	x1, [x0]
               	add	x4, x1, #0x10
               	sub	x1, x4, x1
               	cmp	x1, #0x10
               	cset	x1, ne
               	str	x3, [x0]
               	orr	x0, x2, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x1
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
