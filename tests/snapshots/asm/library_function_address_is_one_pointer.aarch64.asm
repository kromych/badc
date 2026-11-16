
library_function_address_is_one_pointer.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	blr	x1
               	str	x0, [sp, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	blr	x1
               	ldr	x16, [sp, #0x8]
               	add	x16, x16, x0
               	str	x16, [sp, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	blr	x1
               	ldr	x16, [sp, #0x8]
               	add	x0, x16, x0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x2                // =2
               	cmp	x0, #0x6
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
