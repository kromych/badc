
fnptr_typedef_return_proto.aarch64:	file format elf64-littleaarch64

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

<add>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<pick>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ret
