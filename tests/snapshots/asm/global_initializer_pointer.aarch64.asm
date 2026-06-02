
global_initializer_pointer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0xe8
               	ldr	x14, [x15]
               	ldrsw	x14, [x14]
               	cmp	x14, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x14, <page>
               	add	x14, x14, #0xe0
               	mov	x0, #0xb                // =11
               	str	w0, [x14]
               	ldr	x15, [x15]
               	ldrsw	x15, [x15]
               	cmp	x15, #0xb
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
