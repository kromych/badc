
function_macro.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
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
               	cmp	x5, x6
               	cset	x5, eq
               	cbz	x5, <addr>
               	add	x3, x3, #0x1
               	add	x4, x4, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	cset	x5, eq
               	mov	x3, #0x0                // =0
               	cbz	x5, <addr>
               	ldrb	w3, [x4]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, x1
               	ldrb	w5, [x3]
               	cbz	x5, <addr>
               	ldrb	w5, [x3]
               	ldrb	w6, [x4]
               	cmp	x5, x6
               	cset	x5, eq
               	cbz	x5, <addr>
               	add	x3, x3, #0x1
               	add	x4, x4, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	cset	x5, eq
               	mov	x3, #0x0                // =0
               	cbz	x5, <addr>
               	ldrb	w3, [x4]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x3, x2
               	ldrb	w5, [x3]
               	cbz	x5, <addr>
               	ldrb	w5, [x3]
               	ldrb	w6, [x4]
               	cmp	x5, x6
               	cset	x5, eq
               	cbz	x5, <addr>
               	add	x3, x3, #0x1
               	add	x4, x4, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	cset	x5, eq
               	mov	x3, #0x0                // =0
               	cbz	x5, <addr>
               	ldrb	w3, [x4]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x3, x0
               	ldrb	w4, [x3]
               	cbz	x4, <addr>
               	ldrb	w4, [x3]
               	ldrb	w5, [x1]
               	cmp	x4, x5
               	cset	x4, eq
               	cbz	x4, <addr>
               	add	x3, x3, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	sxtw	x1, w3
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	ldrb	w1, [x0]
               	cbz	x1, <addr>
               	ldrb	w1, [x0]
               	ldrb	w3, [x2]
               	cmp	x1, x3
               	cset	x1, eq
               	cbz	x1, <addr>
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w0, [x2]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<helper_two>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x2, eq
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w0, [x1]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x2, eq
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w0, [x1]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
