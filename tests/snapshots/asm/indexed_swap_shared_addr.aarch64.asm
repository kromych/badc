
indexed_swap_shared_addr.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sxtw	x1, w1
               	sxtw	x2, w2
               	ldr	x3, [x0, x1, lsl #3]
               	ldr	x4, [x0, x2, lsl #3]
               	str	x4, [x0, x1, lsl #3]
               	str	x3, [x0, x2, lsl #3]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x28
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	sxtw	x3, w3
               	str	x3, [x0, x2, lsl #3]
               	b	<addr>
               	sub	x0, x29, #0x28
               	mov	x20, #0x0               // =0
               	mov	x2, #0x4                // =4
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x8
               	mov	x2, #0x2                // =2
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x4
               	cset	x1, ne
               	b	<addr>
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x3
               	cset	x1, ne
               	b	<addr>
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x1, ne
               	b	<addr>
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x1
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
