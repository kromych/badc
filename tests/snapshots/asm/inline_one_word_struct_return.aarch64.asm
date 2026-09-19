
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
               	mov	x2, x0
               	add	x1, x0, #0x1
               	mul	x4, x1, x3
               	add	x2, x2, x4
               	mov	x0, x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	x2, #0x96
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
