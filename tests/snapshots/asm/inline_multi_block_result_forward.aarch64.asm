
inline_multi_block_result_forward.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x0
               	sxtw	x0, w0
               	ret

<helper_two>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<test>:
               	sxtw	x0, w0
               	b	<addr>
               	add	x2, x0, x0
               	cmp	x0, #0x3
               	b.le	<addr>
               	sxtw	x0, w1
               	ret
               	add	x0, x1, x2
               	sxtw	x0, w0
               	ret
               	sxtw	x1, w0
               	lsl	x1, x1, #1
               	sxtw	x1, w1
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
