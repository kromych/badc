
inline_multi_block_result_forward.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	sxtw	x2, w1
               	sxtw	x2, w2
               	add	x1, x0, x0
               	cmp	x0, #0x3
               	b.le	<addr>
               	sxtw	x0, w2
               	sxtw	x0, w0
               	ret
               	add	x0, x2, x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x0, #0xa                // =10
               	mov	x0, #0xa                // =10
               	ret
