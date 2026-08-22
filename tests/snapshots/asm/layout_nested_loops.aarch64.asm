
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
               	mov	x1, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x4, x2, x0
               	sxtw	x4, w4
               	mov	x17, #0x5556            // =21846
               	movk	x17, #0x5555, lsl #16
               	mul	x5, x4, x17
               	asr	x5, x5, #32
               	lsr	x7, x5, #63
               	add	x5, x5, x7
               	mov	x17, #0x3               // =3
               	mul	x5, x5, x17
               	sub	x4, x4, x5
               	cbnz	x4, <addr>
               	b	<addr>
               	cmp	x3, #0x4
               	b.ne	<addr>
               	b	<addr>
               	add	x1, x1, x0
               	add	x0, x3, #0x1
               	sxtw	x3, w0
               	cmp	x3, x6
               	b.lt	<addr>
               	add	x1, x1, x2
               	add	x2, x6, #0x1
               	sxtw	x6, w2
               	cmp	x6, #0x6
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret
