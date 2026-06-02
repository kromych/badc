
type_warning_arity.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x1, w0
               	mov	x0, x1
               	ret
               	mov	x0, #0x0                // =0
               	ret
