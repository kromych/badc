
array_field_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	adrp	x0, <page>
               	add	x0, x0, #0xd0
               	ldrsw	x1, [x0]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
