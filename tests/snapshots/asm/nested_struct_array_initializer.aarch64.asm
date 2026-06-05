
nested_struct_array_initializer.aarch64:	file format elf64-littleaarch64

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
               	cmp	x1, #0x64
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x1, x0, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	add	x1, x0, #0x8
               	ldrsw	x1, [x1]
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	add	x1, x0, #0xc
               	ldrsw	x1, [x1]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	add	x1, x0, #0x10
               	ldrsw	x1, [x1]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	add	x1, x0, #0x14
               	ldrsw	x1, [x1]
               	cmp	x1, #0x5
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	add	x1, x0, #0x18
               	ldrsw	x1, [x1]
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	add	x0, x0, #0x1c
               	ldrsw	x0, [x0]
               	cmp	x0, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	add	x0, x0, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	add	x0, x0, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	add	x0, x0, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0xd
               	b.eq	<addr>
               	mov	x0, #0x23               // =35
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	add	x0, x0, #0x14
               	ldrsw	x0, [x0]
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x24               // =36
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	add	x0, x0, #0x18
               	ldrsw	x0, [x0]
               	cmp	x0, #0x13
               	b.eq	<addr>
               	mov	x0, #0x25               // =37
               	ret
               	mov	x0, #0x0                // =0
               	ret
