
overaligned_bss_placement.aarch64:	file format elf64-littleaarch64

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
               	mov	x17, #0x3f              // =63
               	and	x0, x1, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x7f              // =127
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x1                // =1
               	strb	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x2                // =2
               	strb	w0, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x3                // =3
               	strb	w0, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x4                // =4
               	str	w0, [x4]
               	ldrb	w1, [x1]
               	ldrb	w2, [x2]
               	add	x1, x1, x2
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	sxtw	x2, w0
               	add	x1, x1, x2
               	cmp	w1, #0xa
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	b	<addr>
