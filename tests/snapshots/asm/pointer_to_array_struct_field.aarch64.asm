
pointer_to_array_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0x100]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x13, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x128
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x12e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x135
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x1, x19
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x11, x19
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x20, x29, #0x8
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	mov	x13, x0
               	str	x13, [x20]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x10
               	ldrsw	x0, [x13]
               	add	x0, x0, #0x1
               	str	w0, [x13]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x20, x29, #0x18
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	ldursw	x13, [x29, #-0x10]
               	lsl	x20, x13, #4
               	add	x0, x0, x20
               	ldursw	x20, [x29, #-0x18]
               	lsl	x12, x20, #1
               	add	x0, x0, x12
               	mov	x17, #0x64              // =100
               	mul	x13, x13, x17
               	sxtw	x13, w13
               	add	x13, x13, x20
               	sxtw	x13, w13
               	sxth	x13, w13
               	strh	w13, [x0]
               	b	<addr>
               	b	<addr>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x20, x29, #0x10
               	ldrsw	x13, [x20]
               	add	x13, x13, #0x1
               	str	w13, [x20]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x18]
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldr	x13, [x13]
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	strh	w20, [x13]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	ldrsh	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x13, [x29, #-0x18]
               	cmp	x13, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x18
               	ldrsw	x13, [x0]
               	add	x13, x13, #0x1
               	str	w13, [x0]
               	b	<addr>
               	sub	x13, x29, #0x8
               	ldr	x13, [x13]
               	ldursw	x20, [x29, #-0x10]
               	lsl	x0, x20, #4
               	add	x13, x13, x0
               	ldursw	x0, [x29, #-0x18]
               	lsl	x12, x0, #1
               	add	x13, x13, x12
               	ldrsh	x13, [x13]
               	mov	x17, #0x64              // =100
               	mul	x20, x20, x17
               	sxtw	x20, w20
               	add	x20, x20, x0
               	sxtw	x20, w20
               	sxth	x20, w20
               	cmp	x13, x20
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x20, [x29, #-0x10]
               	lsl	x20, x20, #3
               	sxtw	x20, w20
               	add	x20, x20, #0xa
               	sxtw	x20, w20
               	ldursw	x13, [x29, #-0x18]
               	add	x20, x20, x13
               	sxtw	x20, w20
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x20, #0x63              // =99
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x20, [x0]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x0, x19
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
