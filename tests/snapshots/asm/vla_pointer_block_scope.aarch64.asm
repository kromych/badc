
vla_pointer_block_scope.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	x0, x29, #0x40
               	add	x1, x0, #0x1
               	sub	x1, x1, x0
               	cmp	x1, #0x1
               	cset	x5, ne
               	adrp	x3, <page>
               	ldr	x1, [x3, #0x20]
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	add	x4, x1, #0x1
               	sub	x1, x4, x1
               	cmp	x1, #0x1
               	cset	x4, ne
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x3, #0x20]
               	orr	x4, x5, x4
               	add	x5, x0, #0x2
               	sub	x5, x5, x0
               	cmp	x5, #0x2
               	cset	x5, ne
               	orr	x5, x4, x5
               	cbz	x1, <addr>
               	add	x4, x1, #0x2
               	sub	x4, x4, x1
               	cmp	x4, #0x2
               	cset	x4, ne
               	str	x1, [x3, #0x20]
               	orr	x4, x5, x4
               	add	x5, x0, #0x4
               	sub	x5, x5, x0
               	cmp	x5, #0x4
               	cset	x5, ne
               	orr	x4, x4, x5
               	cbz	x1, <addr>
               	add	x2, x1, #0x4
               	sub	x2, x2, x1
               	cmp	x2, #0x4
               	cset	x2, ne
               	str	x1, [x3, #0x20]
               	orr	x1, x4, x2
               	add	x2, x0, #0x8
               	sub	x0, x2, x0
               	cmp	x0, #0x8
               	cset	x0, ne
               	orr	x4, x1, x0
               	adrp	x2, <page>
               	ldr	x0, [x2, #0x20]
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	add	x3, x0, #0x8
               	sub	x0, x3, x0
               	cmp	x0, #0x8
               	cset	x3, ne
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x0, [x2, #0x20]
               	orr	x4, x4, x3
               	sub	x3, x29, #0x40
               	add	x5, x3, #0x10
               	sub	x3, x5, x3
               	cmp	x3, #0x10
               	cset	x3, ne
               	orr	x3, x4, x3
               	cbz	x0, <addr>
               	add	x1, x0, #0x10
               	sub	x1, x1, x0
               	cmp	x1, #0x10
               	cset	x1, ne
               	str	x0, [x2, #0x20]
               	orr	x0, x3, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x1
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
