
stringize_whitespace.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x1]
               	mov	x0, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	ldrb	w0, [x1]
               	ldrb	w3, [x2]
               	cmp	w0, w3
               	cset	x0, eq
               	cbz	x0, <addr>
               	add	x1, x1, #0x1
               	add	x2, x2, #0x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x1]
               	mov	x3, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrb	w0, [x2]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldrb	w0, [x0]
               	mov	x3, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldrb	w0, [x0]
               	mov	x3, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldrb	w0, [x0]
               	mov	x3, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldrb	w0, [x0]
               	mov	x3, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldrb	w0, [x0]
               	mov	x3, #0x0                // =0
               	cbnz	x0, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x1]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	w2, w4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x2, x3
               	b	<addr>
               	ldrb	w2, [x0]
               	mov	x0, #0x0                // =0
               	cbnz	x2, <addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
               	mov	x0, x3
               	b	<addr>
