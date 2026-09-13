
mem2reg_value_across_call.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, x0
               	b	<addr>
               	lsl	x2, x0, #1
               	add	x2, x2, #0x1
               	add	x1, x1, x2
               	add	x2, x0, #0x7
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	cmp	x0, #0x3
               	b.lt	<addr>
               	and	x0, x1, #0x7f
               	sxtw	x0, w0
               	ret
