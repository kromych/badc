
block_comment_star_newline_slash.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x18]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x20]
               	add	x0, x0, x1
               	sub	x0, x0, #0x7
               	ret
