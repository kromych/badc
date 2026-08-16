
compound_literal_block.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x1                // =1
               	mov	x1, #0x1                // =1
               	mov	x0, #0x1                // =1
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	ldr	x2, [x0]
               	ldrb	w2, [x2]
               	mov	x17, #0x73              // =115
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x2]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldr	x0, [x0, #0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	sxtw	x0, w1
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
