
paren_string_char_array_init.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w0, [x1, #0x8]
               	cmp	w0, #0x6e
               	b.ne	<addr>
               	ldrb	w0, [x1, #0x9]
               	cmp	w0, #0x5f
               	b.ne	<addr>
               	ldrb	w0, [x1, #0xf]
               	cmp	w0, #0x73
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w0, [x1, #0x10]
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrb	w4, [x2, x0]
               	cbz	x4, <addr>
               	add	x4, x1, #0x8
               	ldrb	w4, [x4, x0]
               	ldrb	w5, [x3, x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrb	w4, [x2, x0]
               	cbnz	x4, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x68
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x6f
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x5]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x77
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x4]
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x70
               	b.ne	<addr>
               	ldrb	w0, [x0, #0x4]
               	cmp	w0, #0x6e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
