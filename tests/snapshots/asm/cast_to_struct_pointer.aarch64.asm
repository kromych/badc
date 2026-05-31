
cast_to_struct_pointer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	bl	0x400418 <malloc>
               	mov	x14, x0
               	mov	x20, #0x2a              // =42
               	str	w20, [x14]
               	add	x13, x14, #0x8
               	mov	x20, #0x0               // =0
               	str	x20, [x13]
               	ldrsw	x12, [x14]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
