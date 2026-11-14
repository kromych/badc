
function_macro.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x4, x0
               	ldrb	w5, [x4]
               	cbz	x5, <addr>
               	ldrb	w6, [x3]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x4, x4, #0x1
               	add	x3, x3, #0x1
               	ldrb	w5, [x4]
               	cbnz	x5, <addr>
               	ldrb	w4, [x4]
               	cbnz	w4, <addr>
               	ldrb	w3, [x3]
               	cbz	w3, <addr>
               	mov	x0, #0x15               // =21
               	cbz	w0, <addr>
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	ldrb	w0, [x1]
               	cbz	w0, <addr>
               	mov	x0, #0x1f               // =31
               	cbz	w0, <addr>
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	ldrb	w0, [x1]
               	cbz	w0, <addr>
               	mov	x0, #0x29               // =41
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x4, x1
               	ldrb	w5, [x4]
               	cbz	x5, <addr>
               	ldrb	w6, [x3]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x4, x4, #0x1
               	add	x3, x3, #0x1
               	ldrb	w5, [x4]
               	cbnz	x5, <addr>
               	ldrb	w4, [x4]
               	cbnz	w4, <addr>
               	ldrb	w3, [x3]
               	cbz	w3, <addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x4, x2
               	ldrb	w5, [x4]
               	cbz	x5, <addr>
               	ldrb	w6, [x3]
               	cmp	w5, w6
               	b.ne	<addr>
               	add	x4, x4, #0x1
               	add	x3, x3, #0x1
               	ldrb	w5, [x4]
               	cbnz	x5, <addr>
               	ldrb	w4, [x4]
               	cbnz	w4, <addr>
               	ldrb	w3, [x3]
               	cbz	w3, <addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x3, x0
               	ldrb	w4, [x3]
               	cbz	x4, <addr>
               	ldrb	w5, [x1]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	add	x1, x1, #0x1
               	ldrb	w4, [x3]
               	cbnz	x4, <addr>
               	ldrb	w3, [x3]
               	cbnz	w3, <addr>
               	ldrb	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	ldrb	w3, [x2]
               	cmp	w1, w3
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	ldrb	w1, [x0]
               	cbnz	x1, <addr>
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	ldrb	w0, [x2]
               	cbz	w0, <addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
