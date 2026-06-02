
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
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
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x2               // =2
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	cmp	x13, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x13, #0x64              // =100
               	stur	w13, [x29, #-0x18]
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	ldursw	x15, [x29, #-0x18]
               	add	x13, x13, x15
               	str	w13, [x14]
               	ldursw	x14, [x29, #-0x18]
               	cmp	x14, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	sub	x14, x29, #0x8
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x2
               	str	w15, [x14]
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x4
               	str	w13, [x14]
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	mov	x17, #0x4000            // =16384
               	orr	x14, x14, x17
               	str	w14, [x15]
               	b	<addr>
               	cmp	x14, #0x1
               	b.eq	<addr>
               	cmp	x14, #0x2
               	b.eq	<addr>
               	cmp	x14, #0x3
               	b.eq	<addr>
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	mov	x17, #0x1000            // =4096
               	orr	x14, x14, x17
               	str	w14, [x15]
               	b	<addr>
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldrsw	x15, [x13]
               	mov	x17, #0x2000            // =8192
               	orr	x15, x15, x17
               	str	w15, [x13]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x150
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	mov	x17, #0x106b            // =4203
               	cmp	x14, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x14, #0x64              // =100
               	stur	w14, [x29, #-0x20]
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	ldursw	x1, [x29, #-0x20]
               	add	x14, x14, x1
               	str	w14, [x0]
               	ldursw	x0, [x29, #-0x20]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x2
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x4
               	str	w14, [x0]
               	b	<addr>
               	sub	x1, x29, #0x8
               	ldrsw	x0, [x1]
               	mov	x17, #0x4000            // =16384
               	orr	x0, x0, x17
               	str	w0, [x1]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	sub	x1, x29, #0x8
               	ldrsw	x0, [x1]
               	mov	x17, #0x1000            // =4096
               	orr	x0, x0, x17
               	str	w0, [x1]
               	b	<addr>
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x1, [x14]
               	mov	x17, #0x2000            // =8192
               	orr	x1, x1, x17
               	str	w1, [x14]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x165
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
