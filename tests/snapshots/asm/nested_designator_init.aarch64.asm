
nested_designator_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0xc
               	ldrsw	x15, [x15]
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xa               // =10
               	sub	x0, x29, #0x18
               	adrp	x13, <page>
               	add	x13, x13, #0xe0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x13]
               	str	x10, [x0]
               	ldr	x10, [x13, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	str	w15, [x0]
               	mov	x13, #0x14              // =20
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x4
               	str	w13, [x0]
               	mov	x15, #0x1e              // =30
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	str	w15, [x0]
               	mov	x13, #0x28              // =40
               	sub	x0, x29, #0x18
               	add	x0, x0, #0xc
               	str	w13, [x0]
               	sub	x15, x29, #0x18
               	ldrsw	x15, [x15]
               	cmp	x15, #0xa
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	add	x15, x15, #0xc
               	ldrsw	x15, [x15]
               	cmp	x15, #0x28
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
