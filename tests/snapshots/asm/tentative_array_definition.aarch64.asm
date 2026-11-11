
tentative_array_definition.aarch64:	file format elf64-littleaarch64

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

<take_never>:
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	adrp	x1, <addr>
               	ldrb	w1, [x1]
               	mov	x2, #0x1                // =1
               	cmp	w1, #0x0
               	csel	x1, x2, x0, ne
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	orr	x4, x1, #0x4
               	cmp	w3, #0x68
               	csel	x1, x4, x1, ne
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	ldrb	w5, [x3, x0]
               	cbz	x5, <addr>
               	ldrb	w5, [x2, x0]
               	ldrb	w6, [x4, x0]
               	orr	x7, x1, #0x8
               	cmp	w5, w6
               	csel	x1, x7, x1, ne
               	add	x0, x0, #0x1
               	ldrb	w5, [x3, x0]
               	cbnz	x5, <addr>
               	cbz	x1, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
