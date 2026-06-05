
cast_to_struct_pointer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, #0x2a               // =42
               	str	w1, [x0]
               	add	x1, x0, #0x8
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	ldrsw	x0, [x0]
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
