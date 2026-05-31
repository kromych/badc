
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	mov	x14, #0x2               // =2
               	sxtw	x14, w14
               	b	<addr>
               	ldursw	x15, [x29, #-0x8]
               	cmp	x15, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x13, #0x64              // =100
               	stur	w13, [x29, #-0x18]
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	ldursw	x15, [x29, #-0x18]
               	add	x13, x13, x15
               	str	w13, [x14]
               	ldursw	x15, [x29, #-0x18]
               	cmp	x15, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	sub	x15, x29, #0x8
               	ldrsw	x13, [x15]
               	add	x13, x13, #0x2
               	str	w13, [x15]
               	sub	x14, x29, #0x8
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x4
               	str	w13, [x14]
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldrsw	x15, [x13]
               	mov	x17, #0x4000            // =16384
               	orr	x15, x15, x17
               	str	w15, [x13]
               	b	<addr>
               	cmp	x14, #0x1
               	b.eq	<addr>
               	cmp	x14, #0x2
               	b.eq	<addr>
               	cmp	x14, #0x3
               	b.eq	<addr>
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldrsw	x15, [x13]
               	mov	x17, #0x1000            // =4096
               	orr	x15, x15, x17
               	str	w15, [x13]
               	b	<addr>
               	b	<addr>
               	sub	x15, x29, #0x8
               	ldrsw	x14, [x15]
               	mov	x17, #0x2000            // =8192
               	orr	x14, x14, x17
               	str	w14, [x15]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	ldursw	x21, [x29, #-0x8]
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	ldursw	x21, [x29, #-0x8]
               	mov	x17, #0x106b            // =4203
               	cmp	x21, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x20, #0x64              // =100
               	stur	w20, [x29, #-0x20]
               	sub	x0, x29, #0x8
               	ldrsw	x20, [x0]
               	ldursw	x21, [x29, #-0x20]
               	add	x20, x20, x21
               	str	w20, [x0]
               	ldursw	x21, [x29, #-0x20]
               	cmp	x21, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x20, [x0]
               	add	x20, x20, #0x1
               	str	w20, [x0]
               	sub	x21, x29, #0x8
               	ldrsw	x20, [x21]
               	add	x20, x20, #0x2
               	str	w20, [x21]
               	sub	x0, x29, #0x8
               	ldrsw	x20, [x0]
               	add	x20, x20, #0x4
               	str	w20, [x0]
               	b	<addr>
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	mov	x17, #0x4000            // =16384
               	orr	x21, x21, x17
               	str	w21, [x20]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	sub	x20, x29, #0x8
               	ldrsw	x21, [x20]
               	mov	x17, #0x1000            // =4096
               	orr	x21, x21, x17
               	str	w21, [x20]
               	b	<addr>
               	b	<addr>
               	sub	x21, x29, #0x8
               	ldrsw	x0, [x21]
               	mov	x17, #0x2000            // =8192
               	orr	x0, x0, x17
               	str	w0, [x21]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x165
               	mov	x22, x19
               	ldursw	x23, [x29, #-0x8]
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
