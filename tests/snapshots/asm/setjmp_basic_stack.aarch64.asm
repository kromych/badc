
setjmp_basic_stack.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	str	x19, [sp]
               	sub	x0, x29, #0x200
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	sxtw	x14, w14
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
