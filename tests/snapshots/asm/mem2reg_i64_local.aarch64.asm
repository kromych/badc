
mem2reg_i64_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x1, x0, #0x0
               	add	x1, x1, x0
               	add	x1, x1, x0
               	add	x0, x1, x0
               	ret

<main>:
               	mov	x0, #0x54               // =84
               	ret
