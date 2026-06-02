
comma_operator_in_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0xf8
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0xa
               	str	w14, [x15]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x20, [x0]
               	add	x20, x20, #0x64
               	str	w20, [x0]
               	b	<addr>
               	mov	x14, #0x7               // =7
               	mov	x0, x14
               	bl	<addr>
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	sub	x14, x29, #0x10
               	ldrsw	x0, [x14]
               	add	x0, x0, #0x1
               	str	w0, [x14]
               	b	<addr>
               	sub	x20, x29, #0x10
               	ldrsw	x14, [x20]
               	add	x14, x14, #0x3e8
               	str	w14, [x20]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x20, [x0]
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	add	x20, x20, x17
               	str	w20, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x0, [x14]
               	add	x0, x0, #0x1
               	str	w0, [x14]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x20, [x0]
               	add	x20, x20, #0x1
               	str	w20, [x0]
               	b	<addr>
               	adrp	x14, <page>
               	add	x14, x14, #0x148
               	ldrsw	x14, [x14]
               	cmp	x14, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x10]
               	sub	x14, x14, #0x456
               	sxtw	x14, w14
               	mov	x0, x14
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
