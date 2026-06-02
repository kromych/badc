
sizeof_with_write.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	str	w0, [x1]
               	add	x12, x1, #0x4
               	mov	x11, #0x2               // =2
               	str	w11, [x12]
               	add	x10, x1, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0xf8
               	str	x11, [x10]
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
