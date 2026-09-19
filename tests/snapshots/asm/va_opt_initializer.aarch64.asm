
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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	add	x1, x2, #0x8
               	ldr	x1, [x1, w0, sxtw #3]
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x1, x2, #0x8
               	ldr	x1, [x1, w0, sxtw #3]
               	cbnz	x1, <addr>
               	cbnz	w0, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	add	x1, x2, #0x8
               	ldr	x1, [x1, w0, sxtw #3]
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x1, x2, #0x8
               	ldr	x1, [x1, w0, sxtw #3]
               	cbnz	x1, <addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	add	x1, x2, #0x8
               	ldr	x1, [x1, w0, sxtw #3]
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x1, x2, #0x8
               	ldr	x1, [x1, w0, sxtw #3]
               	cbnz	x1, <addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, w0, sxtw]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, w0, sxtw]
               	cbnz	x2, <addr>
               	add	x0, x0, #0x27
               	sub	x0, x0, #0x2
               	sxtw	x0, w0
               	ret
