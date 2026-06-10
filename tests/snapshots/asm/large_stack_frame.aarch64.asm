
large_stack_frame.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret

<main>:
               	mov	x0, #0x28               // =40
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
