
syslimits_path_max.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	cbz	x2, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>
