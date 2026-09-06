
section_attr_flexible_array_tail.aarch64:	file format elf64-littleaarch64

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

<pick>:
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1, x0, lsl #3]
               	ret

<main>:
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x4
               	b	<addr>
               	ldrb	w3, [x0]
               	ldrb	w5, [x1]
               	cmp	w3, w5
               	cset	x3, eq
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0xb
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x2
               	b	<addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x16
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x2, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	x0, x2, #0x2b
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	x0, x2, #0x36
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w3, [x0]
               	ldrb	w4, [x1]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w3, [x0]
               	cbnz	x3, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	x0, x2, #0x41
               	cmp	x6, x0
               	b.hs	<addr>
               	cmp	x6, x2
               	cset	x0, hs
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x2b
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	b	<addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	ldrb	w2, [x0]
               	cbnz	x2, <addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	w0, w1
               	cset	x0, eq
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x5                // =5
               	ret
