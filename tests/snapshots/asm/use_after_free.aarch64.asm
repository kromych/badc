
use_after_free.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2a               // =42
               	str	w0, [x20]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldrsw	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
