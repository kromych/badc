
global_initializer_int.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0xe0
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xe8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x63
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xe0
               	ldrsw	x15, [x15]
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	ldrsw	x0, [x0]
               	add	x15, x15, x0
               	sxtw	x0, w15
               	ret
