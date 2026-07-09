
integer_literal_suffix.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0x0                // =0
               	ret
