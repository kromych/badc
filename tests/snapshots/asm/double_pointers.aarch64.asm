
double_pointers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0xa               // =10
               	stur	w15, [x29, #-0x8]
               	sub	x14, x29, #0x8
               	stur	x14, [x29, #-0x10]
               	sub	x15, x29, #0x10
               	ldr	x15, [x15]
               	mov	x14, #0x2a              // =42
               	str	w14, [x15]
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, #0x2a
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x13, [x29, #-0x10]
               	ldrsw	x13, [x13]
               	cmp	x13, #0x2a
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	mov	x15, x0
               	str	x15, [x20]
               	ldr	x0, [x20]
               	mov	x15, #0x7b              // =123
               	str	w15, [x0]
               	ldr	x12, [x20]
               	ldrsw	x12, [x12]
               	cmp	x12, #0x7b
               	b.eq	<addr>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x20, [x20]
               	ldrsw	x20, [x20]
               	cmp	x20, #0x7b
               	b.eq	<addr>
               	mov	x12, #0x4               // =4
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
