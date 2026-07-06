
layout_nested_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x0
               	sxtw	x4, w4
               	mov	x6, #0x3                // =3
               	sdiv	x17, x4, x6
               	msub	x4, x17, x6, x4
               	cmp	x4, #0x0
               	b.ne	<addr>
               	b	<addr>
               	cmp	x3, #0x4
               	b.ne	<addr>
               	b	<addr>
               	add	x1, x1, x0
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, x5
               	b.lt	<addr>
               	add	x1, x1, x2
               	add	x2, x5, #0x1
               	sxtw	x5, w2
               	cmp	x5, #0x6
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
