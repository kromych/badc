
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x7                // =7
               	mov	x0, #0x1064             // =4196
               	mov	x0, #0x106b             // =4203
               	mov	x0, #0x0                // =0
               	ret
