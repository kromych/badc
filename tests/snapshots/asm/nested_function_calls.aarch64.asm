
nested_function_calls.aarch64:	file format elf64-littleaarch64

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
               	mov	x15, #0xa               // =10
               	mov	x14, #0x14              // =20
               	add	x15, x15, x14
               	sxtw	x15, w15
               	mov	x14, #0x1e              // =30
               	mov	x13, #0x28              // =40
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, x14
               	sxtw	x0, w15
               	ret
