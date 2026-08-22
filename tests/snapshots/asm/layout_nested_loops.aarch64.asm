
layout_nested_loops.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x0                // =0
               	mov	x5, #0x3                // =3
               	mov	x6, #0x5556             // =21846
               	movk	x6, #0x5555, lsl #16
               	mov	x1, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x0
               	sxtw	x3, w3
               	mul	x4, x3, x6
               	asr	x4, x4, #32
               	lsr	x7, x4, #63
               	add	x4, x4, x7
               	mul	x4, x4, x5
               	sub	x3, x3, x4
               	cbnz	x3, <addr>
               	b	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	b	<addr>
               	add	x1, x1, x0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	x0, x2
               	b.lt	<addr>
               	add	x1, x1, x2
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	cmp	x2, #0x6
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
