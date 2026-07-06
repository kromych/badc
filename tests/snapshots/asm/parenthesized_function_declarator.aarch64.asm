
parenthesized_function_declarator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<two>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	lsl	x0, x0, #1
               	str	w0, [x1]
               	mov	x0, x1
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0xa                // =10
               	add	x0, x0, #0x1
               	sxtw	x20, w0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x1, w20
               	cmp	x1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	b	<addr>
