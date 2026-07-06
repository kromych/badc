
layout_nested_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	add	x2, x1, x3
               	sxtw	x2, w2
               	mov	x4, #0x3                // =3
               	sdiv	x17, x2, x4
               	msub	x2, x17, x4, x2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	b	<addr>
               	sxtw	x2, w3
               	cmp	x2, #0x4
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x0, x3
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	sxtw	x4, w1
               	cmp	x2, x4
               	b.lt	<addr>
               	add	x0, x0, x1
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x6
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret
