
ir_translation_while.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	b	0x40023c <.text+0x1c>
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40024c <.text+0x2c>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
