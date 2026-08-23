
inline_one_word_struct_return.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	mov	x3, #0xa                // =10
               	mov	x1, x0
               	b	<addr>
               	add	x2, x0, #0x1
               	sxtw	x2, w2
               	mul	x2, x2, x3
               	add	x1, x1, x2
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	x1, #0x96
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
