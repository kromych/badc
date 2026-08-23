
parenthesized_function_declarator.aarch64:	file format elf64-littleaarch64

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

<one>:
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	ldrsw	x0, [x0]
               	cmp	w0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
