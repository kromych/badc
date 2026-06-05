
global_initializer_int.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, #0xe8
               	ldrsw	x1, [x1]
               	cmp	x1, #0x63
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0xe8
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret
