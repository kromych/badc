
compound_literal_static_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	add	x1, x1, x2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	ldrsw	x3, [x2, #0x4]
               	add	x3, x3, #0xa
               	str	w3, [x2, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x1, [x2]
               	ldrsw	x3, [x1]
               	add	x0, x0, x3
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x0, x0, #0x64
               	sxtw	x0, w0
               	ret
