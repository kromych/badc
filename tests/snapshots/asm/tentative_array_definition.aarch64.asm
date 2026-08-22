
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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2]
               	mov	x17, #0x68              // =104
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbz	x2, <addr>
               	mov	x17, #0x4               // =4
               	orr	x0, x0, x17
               	mov	x4, #0x8                // =8
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	b	<addr>
               	add	x3, x7, x2
               	ldrb	w3, [x3]
               	add	x8, x6, x2
               	ldrsb	x8, [x8]
               	eor	x3, x3, x8
               	mov	w3, w3
               	cbz	x3, <addr>
               	orr	x0, x0, x4
               	b	<addr>
               	b	<addr>
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	add	x3, x5, x2
               	ldrsb	x3, [x3]
               	cbnz	x3, <addr>
               	sxtw	x1, w0
               	cbz	x1, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
