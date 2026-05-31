
setjmp_basic_stack.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400278 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x20, x29, #0x200
               	mov	x0, x20
               	bl	0x4003f8 <setjmp>
               	sxtw	x0, w0
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
