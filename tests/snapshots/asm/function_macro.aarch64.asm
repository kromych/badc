
function_macro.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x3
               	ldrb	w2, [x1]
               	cbz	x2, <addr>
               	ldrb	w4, [x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	ldrb	w2, [x1]
               	cbnz	x2, <addr>
               	ldrb	w1, [x1]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x15               // =21
               	cbz	w0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x5
               	ldrb	w2, [x1]
               	cbz	x2, <addr>
               	ldrb	w4, [x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	ldrb	w2, [x1]
               	cbnz	x2, <addr>
               	ldrb	w1, [x1]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x6
               	ldrb	w2, [x1]
               	cbz	x2, <addr>
               	ldrb	w4, [x0]
               	cmp	w2, w4
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	ldrb	w2, [x1]
               	cbnz	x2, <addr>
               	ldrb	w1, [x1]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x0, x3
               	ldrb	w1, [x0]
               	cbz	x1, <addr>
               	ldrb	w2, [x5]
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	add	x5, x5, #0x1
               	ldrb	w1, [x0]
               	cbnz	x1, <addr>
               	ldrb	w0, [x0]
               	cbnz	w0, <addr>
               	ldrb	w0, [x5]
               	cbz	w0, <addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	ldrb	w1, [x6]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	add	x6, x6, #0x1
               	ldrb	w0, [x3]
               	cbnz	x0, <addr>
               	ldrb	w0, [x3]
               	cbnz	w0, <addr>
               	ldrb	w0, [x6]
               	cbz	w0, <addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
