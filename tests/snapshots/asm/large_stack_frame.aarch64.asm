
large_stack_frame.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	sxtw	x0, w15
               	ret
               	mov	x15, #0x28              // =40
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	sxtw	x15, w15
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	sxtw	x15, w15
               	sxtw	x0, w15
               	ret
