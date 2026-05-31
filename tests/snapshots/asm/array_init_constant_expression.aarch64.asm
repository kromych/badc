
array_init_constant_expression.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x80
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0x90
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x94
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x15, x19
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0x100
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x40
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0x11
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x70
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x15, x19
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x30
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0x90
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x15, x19
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x108
               	mov	x15, x19
               	add	x15, x15, #0xc
               	ldrsw	x15, [x15]
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
