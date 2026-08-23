
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, x0
               	ldrb	w5, [x3]
               	cbz	x5, <addr>
               	ldrb	w5, [x3]
               	ldrb	w6, [x4]
               	cmp	w5, w6
               	cset	x5, eq
               	cbz	x5, <addr>
               	add	x3, x3, #0x1
               	add	x4, x4, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w5, [x3]
               	mov	x3, #0x0                // =0
               	cbnz	x5, <addr>
               	ldrb	w3, [x4]
               	cmp	w3, #0x0
               	cset	x3, eq
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	mov	x0, #0x15               // =21
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w2, [x0]
               	mov	x0, #0x0                // =0
               	cbnz	x2, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w2, [x0]
               	mov	x0, #0x0                // =0
               	cbnz	x2, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x29               // =41
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, x1
               	ldrb	w5, [x3]
               	cbz	x5, <addr>
               	ldrb	w5, [x3]
               	ldrb	w6, [x4]
               	cmp	w5, w6
               	cset	x5, eq
               	cbz	x5, <addr>
               	add	x3, x3, #0x1
               	add	x4, x4, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w5, [x3]
               	mov	x3, #0x0                // =0
               	cbnz	x5, <addr>
               	ldrb	w3, [x4]
               	cmp	w3, #0x0
               	cset	x3, eq
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	mov	x0, #0x16               // =22
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, x2
               	ldrb	w5, [x3]
               	cbz	x5, <addr>
               	ldrb	w5, [x3]
               	ldrb	w6, [x4]
               	cmp	w5, w6
               	cset	x5, eq
               	cbz	x5, <addr>
               	add	x3, x3, #0x1
               	add	x4, x4, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w5, [x3]
               	mov	x3, #0x0                // =0
               	cbnz	x5, <addr>
               	ldrb	w3, [x4]
               	cmp	w3, #0x0
               	cset	x3, eq
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	mov	x0, #0x17               // =23
               	b	<addr>
               	mov	x3, x0
               	ldrb	w4, [x3]
               	cbz	x4, <addr>
               	ldrb	w4, [x3]
               	ldrb	w5, [x1]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	add	x3, x3, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w4, [x3]
               	mov	x3, #0x0                // =0
               	cbnz	x4, <addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0x0
               	cset	x3, eq
               	sxtw	x1, w3
               	cbnz	x1, <addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	ldrb	w1, [x0]
               	cbz	x1, <addr>
               	ldrb	w1, [x0]
               	ldrb	w3, [x2]
               	cmp	w1, w3
               	cset	x1, eq
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w1, [x0]
               	mov	x0, #0x0                // =0
               	cbnz	x1, <addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x19               // =25
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
