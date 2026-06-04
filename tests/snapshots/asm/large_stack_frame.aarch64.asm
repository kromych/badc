
large_stack_frame.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ret
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
