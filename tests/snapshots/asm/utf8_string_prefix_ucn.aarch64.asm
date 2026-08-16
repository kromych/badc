
utf8_string_prefix_ucn.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x2
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x4
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x3
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x5
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x5
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x5
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x4
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x2
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x4, x2, x1
               	ldrb	w4, [x4]
               	add	x1, x3, x1
               	ldrb	w1, [x1]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x4
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
