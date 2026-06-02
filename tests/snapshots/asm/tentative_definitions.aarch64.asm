
tentative_definitions.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrsw	x15, [x15]
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd8
               	ldrsw	x0, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x0, x0, x15
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	ret
