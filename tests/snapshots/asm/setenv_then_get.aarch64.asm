
setenv_then_get.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	adrp	x1, <page>
               	add	x1, x1, #0x101
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, #0x103
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
