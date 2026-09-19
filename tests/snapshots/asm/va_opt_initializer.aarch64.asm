
va_opt_initializer.aarch64:	file format elf64-littleaarch64

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
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x0, #0x1
               	add	x1, x3, #0x8
               	sxtw	x2, w0
               	ldr	x1, [x1, x2, lsl #3]
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x0, #0x1
               	add	x1, x3, #0x8
               	sxtw	x2, w0
               	ldr	x1, [x1, x2, lsl #3]
               	cbnz	x1, <addr>
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x0, #0x1
               	add	x1, x3, #0x8
               	sxtw	x2, w0
               	ldr	x1, [x1, x2, lsl #3]
               	cbnz	x1, <addr>
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	add	x0, x0, #0x1
               	sxtw	x2, w0
               	ldrb	w2, [x1, x2]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x27
               	sub	x0, x0, #0x2
               	sxtw	x0, w0
               	ret
