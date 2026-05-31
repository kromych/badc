
variable_shadowing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0xa               // =10
               	mov	x14, #0x1               // =1
               	cbz	x14, 0x400248 <.text+0x28>
               	b	0x400248 <.text+0x28>
               	sxtw	x0, w15
               	ret
