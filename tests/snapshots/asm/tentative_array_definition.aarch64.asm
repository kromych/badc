
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	cbz	w1, <addr>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	mov	x17, #0x68              // =104
               	eor	x3, x3, x17
               	cbz	w3, <addr>
               	orr	x1, x1, #0x4
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrb	w5, [x3, w0, sxtw]
               	cbz	x5, <addr>
               	ldrb	w5, [x2, w0, sxtw]
               	ldrb	w6, [x4, w0, sxtw]
               	cmp	w5, w6
               	b.eq	<addr>
               	orr	x1, x1, #0x8
               	add	x0, x0, #0x1
               	ldrb	w5, [x3, w0, sxtw]
               	cbnz	x5, <addr>
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
