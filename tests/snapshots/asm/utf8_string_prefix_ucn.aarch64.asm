
utf8_string_prefix_ucn.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	mov	x0, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x3
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x5
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x5
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x5
               	b.lo	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, x1
               	mov	x2, x1
               	mov	x0, x1
               	mov	x2, x1
               	mov	x2, x1
               	mov	x0, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x2
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrb	w4, [x2, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ret
               	mov	x0, #0x18               // =24
               	ret
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x14               // =20
               	ret
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x5                // =5
               	ret
