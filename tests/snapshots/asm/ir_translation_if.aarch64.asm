
ir_translation_if.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x1               // =1
               	cbz	x15, 0x400250 <.text+0x30>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ret
