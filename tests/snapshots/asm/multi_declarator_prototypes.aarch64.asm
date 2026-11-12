
multi_declarator_prototypes.aarch64:	file format elf64-littleaarch64

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

<f>:
               	ret

<g>:
               	lsl	x0, x0, #1
               	ret

<main>:
               	adrp	x0, <page>
               	mov	x1, #0xa                // =10
               	str	w1, [x0, #0x34]
               	mov	x0, #0x0                // =0
               	ret
