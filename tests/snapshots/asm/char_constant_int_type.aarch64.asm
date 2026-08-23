
char_constant_int_type.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	mov	x0, #0x2                // =2
               	mov	x0, #0x3                // =3
               	mov	x0, #0x0                // =0
               	ret
