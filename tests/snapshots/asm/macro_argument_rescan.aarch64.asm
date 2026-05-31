
macro_argument_rescan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x7               // =7
               	sxtw	x15, w15
               	cmp	x15, #0x7
               	b.eq	0x400250 <.text+0x30>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x14, #0x4               // =4
               	sxtw	x14, w14
               	cmp	x14, #0x4
               	b.eq	0x40026c <.text+0x4c>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ret
               	mov	x0, #0x7b               // =123
               	sxtw	x0, w0
               	cmp	x0, #0x7b
               	b.eq	0x400284 <.text+0x64>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ret
