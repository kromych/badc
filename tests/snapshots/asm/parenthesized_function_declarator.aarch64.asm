
parenthesized_function_declarator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, #0xd0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	str	w0, [x1]
               	mov	x0, x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x1, w20
               	cmp	x1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	b	<addr>
               	cbz	x3, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
