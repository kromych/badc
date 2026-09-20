
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	add	x3, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldrsw	x4, [x2, #0x4]
               	add	x4, x4, #0xa
               	str	w4, [x2, #0x4]
               	ldr	x0, [x0]
               	ldrsw	x0, [x0]
               	add	x2, x3, x0
               	ldr	x0, [x1]
               	ldrsw	x1, [x0]
               	add	x1, x2, x1
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sub	x0, x0, #0x64
               	ret
