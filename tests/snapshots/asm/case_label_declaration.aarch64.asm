
case_label_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x0, #0xa                // =10
               	mov	x0, #0x14               // =20
               	mov	x0, #0x1e               // =30
               	mov	x0, #0x0                // =0
               	ret
