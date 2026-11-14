
inline_nested_aggregate_return.aarch64:	file format elf64-littleaarch64

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

<make_pair>:
               	add	x1, x0, x0, lsl #1
               	add	x1, x1, #0x1
               	adrp	x2, <page>
               	ldrsw	x3, [x2, #0x20]
               	add	x3, x3, #0x1
               	str	w3, [x2, #0x20]
               	ret

<make_wide>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	x8, [x29, #-0x8]
               	sub	x2, x29, #0x38
               	stur	x0, [x29, #-0x38]
               	add	x1, x0, #0x1
               	stur	x1, [x29, #-0x30]
               	add	x1, x0, #0x2
               	stur	x1, [x29, #-0x28]
               	add	x1, x0, #0x3
               	stur	x1, [x29, #-0x20]
               	add	x1, x0, #0x4
               	stur	x1, [x29, #-0x18]
               	add	x0, x0, #0x5
               	stur	x0, [x29, #-0x10]
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0x20]
               	add	x0, x0, #0x1
               	str	w0, [x1, #0x20]
               	mov	x16, x2
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	ldp	x0, x1, [x16, #0x20]
               	stp	x0, x1, [x17, #0x20]
               	mov	x0, x17
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x20, x0
               	mov	x21, x1
               	mov	x0, #0x4                // =4
               	sub	x8, x29, #0x30
               	bl	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x28]
               	ldur	x2, [x29, #-0x20]
               	ldur	x3, [x29, #-0x18]
               	ldur	x4, [x29, #-0x10]
               	ldur	x5, [x29, #-0x8]
               	add	x6, x20, x21
               	add	x0, x6, x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	mov	x1, #0x1                // =1
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x38
               	csel	x20, x1, x2, ne
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, x1
               	mov	x0, #0x0                // =0
               	sub	x8, x29, #0x30
               	bl	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x28]
               	ldur	x2, [x29, #-0x20]
               	ldur	x3, [x29, #-0x18]
               	ldur	x4, [x29, #-0x10]
               	ldur	x5, [x29, #-0x8]
               	add	x6, x21, x22
               	add	x0, x6, x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	orr	x1, x20, #0x2
               	cmp	x0, #0x10
               	csel	x20, x1, x20, ne
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x21, x1
               	stur	x0, [x29, #-0x10]
               	stur	x21, [x29, #-0x8]
               	sub	x8, x29, #0x30
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x21, x0
               	orr	x1, x20, #0x4
               	cmp	x0, #0x16
               	csel	x20, x1, x20, ne
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x21, x1
               	sub	x8, x29, #0x30
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	x0, x21, x0
               	orr	x1, x20, #0x8
               	cmp	x0, #0x1a
               	csel	x20, x1, x20, ne
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	add	x0, x1, x0, lsl #1
               	orr	x1, x20, #0x10
               	cmp	x0, #0x1a
               	csel	x20, x1, x20, ne
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0x30
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	orr	x1, x20, #0x40
               	cmp	x0, #0xd
               	csel	x0, x1, x20, ne
               	adrp	x1, <page>
               	orr	x2, x0, #0x80
               	ldrsw	x1, [x1, #0x20]
               	cmp	w1, #0xa
               	csel	x0, x2, x0, ne
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
