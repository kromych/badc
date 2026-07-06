
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
               	mov	x4, #0x0                // =0
               	b	<addr>
               	add	x5, x1, x4
               	sxtw	x5, w5
               	mov	x6, #0x3                // =3
               	sdiv	x17, x5, x6
               	msub	x5, x17, x6, x5
               	cmp	x5, #0x0
               	b.ne	<addr>
               	b	<addr>
               	cmp	x3, #0x4
               	b.ne	<addr>
               	b	<addr>
               	add	x0, x0, x4
               	add	x4, x3, #0x1
               	sxtw	x3, w4
               	cmp	x3, x2
               	b.lt	<addr>
               	add	x0, x0, x1
               	add	x1, x2, #0x1
               	sxtw	x2, w1
               	cmp	x2, #0x6
               	b.lt	<addr>
               	sxtw	x0, w0
               	ret
