
indexed_swap_shared_addr.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	sxtw	x2, w2
               	ldr	x3, [x0, x1, lsl #3]
               	ldr	x4, [x0, x2, lsl #3]
               	str	x4, [x0, x1, lsl #3]
               	str	x3, [x0, x2, lsl #3]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	str	x20, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x1, #0x0                // =0
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
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x28
               	ldr	x0, [x0, #0x20]
               	cmp	x0, #0x1
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x20, [sp], #0x90
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
