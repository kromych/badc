
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
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x0, x19
               	adrp	x19, <page>
               	add	x19, x19, #0x101
               	mov	x1, x19
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	adrp	x19, <page>
               	add	x19, x19, #0x103
               	mov	x0, x19
               	bl	<addr>
               	mov	x2, x0
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x2]
               	mov	x0, x2
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
