
inline_multi_block_only_caller.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x0
               	mov	x3, x1
               	mov	x17, #0x64              // =100
               	mul	x0, x2, x17
               	add	x0, x0, x3
               	sxtw	x1, w2
               	add	x1, x1, x1
               	sxtw	x2, w1
               	sxtw	x1, w2
               	add	x0, x0, x1
               	add	x0, x0, x3
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<main>:
               	mov	x0, #0x2a               // =42
               	ret
