
large_stack_frame.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40026c <.text+0x3c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	sxtw	x15, w0
               	sxtw	x14, w15
               	add	x15, x14, #0x1
               	sxtw	x15, w15
               	sxtw	x14, w15
               	add	x15, x14, #0x1
               	sxtw	x15, w15
               	sxtw	x0, w15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, #0x28              // =40
               	mov	x0, x20
               	bl	0x400248 <.text+0x18>
               	mov	x14, x0
               	sxtw	x20, w14
               	mov	x0, x20
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
