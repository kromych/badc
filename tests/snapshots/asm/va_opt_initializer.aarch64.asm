
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
               	add	x0, x1, #0x1
               	add	x2, x3, #0x8
               	sxtw	x1, w0
               	ldr	x2, [x2, x1, lsl #3]
               	cbnz	x2, <addr>
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	add	x2, x4, #0x8
               	sxtw	x1, w0
               	ldr	x2, [x2, x1, lsl #3]
               	cbnz	x2, <addr>
               	cmp	x1, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	add	x2, x4, #0x8
               	sxtw	x1, w0
               	ldr	x2, [x2, x1, lsl #3]
               	cbnz	x2, <addr>
               	cmp	x1, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x2, [x3]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	cbnz	x3, <addr>
               	add	x0, x1, #0x27
               	sub	x0, x0, #0x2
               	sxtw	x0, w0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
