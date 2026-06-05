
array_init_constant_expression.aarch64:	file format elf64-littleaarch64

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
               	cmp	x1, #0x10
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	add	x1, x0, #0x4
               	ldrsw	x1, [x1]
               	cmp	x1, #0x80
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x90
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x94
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	ldrsw	x0, [x0]
               	cmp	x0, #0x100
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x11
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x70
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x30
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	ldrsw	x0, [x0]
               	cmp	x0, #0x90
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x108
               	add	x0, x0, #0xc
               	ldrsw	x0, [x0]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	mov	x0, #0x0                // =0
               	ret
