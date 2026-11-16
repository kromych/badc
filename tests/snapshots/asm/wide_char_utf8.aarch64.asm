
wide_char_utf8.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w1, [x0]
               	cmp	w1, #0xc3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrb	w1, [x0, #0x1]
               	cmp	w1, #0xa1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrb	w0, [x0, #0x2]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	cmp	w1, #0x61
               	b.ne	<addr>
               	ldr	w1, [x0, #0x4]
               	cmp	w1, #0xe1
               	b.ne	<addr>
               	ldr	w1, [x0, #0x8]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldr	w0, [x0, #0xc]
               	cbz	w0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
