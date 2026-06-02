
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
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	lsl	x15, x15, #1
               	sxtw	x15, w15
               	str	w15, [x0]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	mov	x15, #0xa               // =10
               	add	x15, x15, #0x1
               	sxtw	x20, w15
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x13, x0
               	sxtw	x20, w20
               	cmp	x20, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x13, #0x0
               	cset	x20, eq
               	stur	x20, [x29, #-0x20]
               	cbnz	x20, <addr>
               	ldrsw	x13, [x13]
               	cmp	x13, #0xa
               	cset	x13, ne
               	stur	x13, [x29, #-0x20]
               	b	<addr>
               	ldur	x13, [x29, #-0x20]
               	cbz	x13, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
