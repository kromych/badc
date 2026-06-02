
multi_declarator_prototypes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x0, w0
               	ret
               	sxtw	x15, w0
               	lsl	x15, x15, #1
               	sxtw	x0, w15
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	mov	x14, #0xa               // =10
               	str	w14, [x15]
               	mov	x13, #0x3               // =3
               	cmp	x13, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x13, #0x3               // =3
               	lsl	x13, x13, #1
               	sxtw	x13, w13
               	cmp	x13, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x15, [x15]
               	cmp	x15, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
