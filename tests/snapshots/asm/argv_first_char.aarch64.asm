
argv_first_char.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x15, w0
               	mov	x14, x1
               	cmp	x15, #0x2
               	b.ge	0x400250 <.text+0x30>
               	mov	x0, #0x0                // =0
               	ret
               	add	x13, x14, #0x8
               	ldr	x14, [x13]
               	ldrb	w0, [x14]
               	ret
