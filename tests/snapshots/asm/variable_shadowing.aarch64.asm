
variable_shadowing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0xa                // =10
               	mov	x14, #0x1               // =1
               	cbz	x14, <addr>
               	b	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
