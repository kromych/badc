
array_field_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x1, [x0]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x1, x0, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x1, x0, #0x8
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	add	x1, x0, #0xc
               	ldrsw	x1, [x1]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
