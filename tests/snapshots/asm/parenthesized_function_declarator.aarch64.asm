
parenthesized_function_declarator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	add	x15, x15, #0x1
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x15, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	lsl	x15, x15, #1
               	sxtw	x15, w15
               	str	w15, [x0]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x20, #0xa               // =10
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, #0x5               // =5
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x21, w21
               	cmp	x21, #0xb
               	b.eq	<addr>
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x0
               	cset	x21, eq
               	stur	x21, [x29, #-0x20]
               	cbnz	x21, <addr>
               	ldrsw	x22, [x0]
               	cmp	x22, #0xa
               	cset	x22, ne
               	stur	x22, [x29, #-0x20]
               	b	<addr>
               	ldur	x22, [x29, #-0x20]
               	cbz	x22, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
