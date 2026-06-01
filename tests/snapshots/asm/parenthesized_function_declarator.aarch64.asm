
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
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	mov	x15, #0xa               // =10
               	add	x15, x15, #0x1
               	sxtw	x20, w15
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x20, w20
               	cmp	x20, #0xb
               	b.eq	<addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x0
               	cset	x20, eq
               	stur	x20, [x29, #-0x20]
               	cbnz	x20, <addr>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	stur	x0, [x29, #-0x20]
               	b	<addr>
               	ldur	x0, [x29, #-0x20]
               	cbz	x0, <addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
