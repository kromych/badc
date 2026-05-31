
forge_code_pointer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x2a              // =42
               	mov	x21, #0x0               // =0
               	mov	x9, x20
               	str	x21, [sp, #-0x10]!
               	ldr	x0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x13, x0
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
