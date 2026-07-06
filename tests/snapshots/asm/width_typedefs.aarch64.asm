
width_typedefs.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x64               // =100
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	ret
