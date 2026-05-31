
nested_struct_array_initializer.aarch64:	file format elf64-littleaarch64

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
               	cmp	x15, #0x64
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
               	cmp	x15, #0x1
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
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0xc
               	ldrsw	x15, [x15]
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x14
               	ldrsw	x15, [x15]
               	cmp	x15, #0x5
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x18
               	ldrsw	x15, [x15]
               	cmp	x15, #0x6
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x15, x15, #0x1c
               	ldrsw	x15, [x15]
               	cmp	x15, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0xa
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	add	x15, x15, #0xc
               	ldrsw	x15, [x15]
               	cmp	x15, #0x28
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	ldrsw	x15, [x15]
               	cmp	x15, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x9
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x15, x15, #0xc
               	ldrsw	x15, [x15]
               	cmp	x15, #0xb
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x15, x15, #0x10
               	ldrsw	x15, [x15]
               	cmp	x15, #0xd
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x15, x15, #0x14
               	ldrsw	x15, [x15]
               	cmp	x15, #0x11
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
               	add	x15, x15, #0x18
               	ldrsw	x15, [x15]
               	cmp	x15, #0x13
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
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
