
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0xf8
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x110
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x116
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x11d
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
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
