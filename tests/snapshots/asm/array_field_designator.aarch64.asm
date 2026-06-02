
array_field_designator.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x14, [x15]
               	cmp	x14, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	add	x14, x15, #0x4
               	ldrsw	x14, [x14]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	add	x14, x15, #0x8
               	ldrsw	x14, [x14]
               	cmp	x14, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	add	x14, x15, #0xc
               	ldrsw	x14, [x14]
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x15, x15, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
