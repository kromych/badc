
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, #0x1               // =1
               	str	w22, [x21]
               	add	x12, x21, #0x4
               	mov	x11, #0x2               // =2
               	str	w11, [x12]
               	add	x10, x21, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x11, x19
               	str	x11, [x10]
               	mov	x0, x22
               	mov	x2, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
