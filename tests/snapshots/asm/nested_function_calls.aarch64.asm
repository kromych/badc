
nested_function_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0xa                // =10
               	mov	x1, #0x14               // =20
               	add	x0, x0, x1
               	mov	x2, #0x1e               // =30
               	mov	x3, #0x28               // =40
               	add	x2, x2, x3
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret
