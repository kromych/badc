
char_limits_consistency.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0x0                // =0
               	mov	x1, #0x0                // =0
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	b	<addr>
               	b	<addr>
