
paren_comma_side_effect.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x20]
               	mov	x2, #0x7                // =7
               	str	w2, [x1, #0x20]
               	mov	x2, #0x1                // =1
               	str	w2, [x1, #0x20]
               	mov	x2, #0xb                // =11
               	str	w2, [x1, #0x20]
               	mov	x2, #0xd                // =13
               	str	w2, [x1, #0x20]
               	ret
