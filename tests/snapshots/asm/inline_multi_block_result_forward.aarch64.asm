
inline_multi_block_result_forward.aarch64:	file format elf64-littleaarch64

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

<test>:
               	mov	x1, x0
               	lsl	x0, x1, #1
               	sxtw	x0, w0
               	add	x2, x1, x1
               	cmp	w1, #0x3
               	b.le	<addr>
               	ret
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0xa                // =10
               	ret
