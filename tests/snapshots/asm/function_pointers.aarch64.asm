
function_pointers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x1, w0
               	mov	x0, x1
               	ret
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x0, x0, x1
               	sxtw	x1, w0
               	mov	x0, x1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, <page>
               	add	x19, x19, #0x238
               	mov	x15, x19
               	mov	x20, #0xa               // =10
               	mov	x1, #0x14               // =20
               	mov	x9, x15
               	str	x1, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	mov	x21, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x250
               	mov	x1, x19
               	mov	x15, #0x5               // =5
               	mov	x9, x1
               	str	x15, [sp, #-0x10]!
               	str	x20, [sp, #-0x10]!
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x10]
               	blr	x9
               	add	sp, sp, #0x20
               	sxtw	x21, w21
               	sxtw	x0, w0
               	mul	x21, x21, x0
               	sxtw	x0, w21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
