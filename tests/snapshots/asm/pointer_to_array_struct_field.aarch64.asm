
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
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
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x20, x29, #0x8
               	mov	x14, #0x40              // =64
               	sxtw	x21, w14
               	mov	x0, x21
               	bl	<addr>
               	str	x0, [x20]
               	sub	x21, x29, #0x8
               	ldr	x0, [x21]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x21, x29, #0x10
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x1
               	str	w0, [x21]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x10]
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
               	ldr	x21, [x0]
               	ldursw	x0, [x29, #-0x10]
               	lsl	x20, x0, #4
               	add	x21, x21, x20
               	ldursw	x20, [x29, #-0x18]
               	lsl	x12, x20, #1
               	add	x21, x21, x12
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, x20
               	sxtw	x0, w0
               	sxth	x0, w0
               	strh	w0, [x21]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x20, x29, #0x10
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x18]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x12, [x0]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	strh	w0, [x12]
               	sub	x21, x29, #0x8
               	ldr	x0, [x21]
               	ldrsh	x21, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x18]
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x21, x29, #0x18
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x1
               	str	w0, [x21]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x20, [x0]
               	ldursw	x0, [x29, #-0x10]
               	lsl	x21, x0, #4
               	add	x20, x20, x21
               	ldursw	x21, [x29, #-0x18]
               	lsl	x12, x21, #1
               	add	x20, x20, x12
               	ldrsh	x12, [x20]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, x21
               	sxtw	x0, w0
               	sxth	x0, w0
               	cmp	x12, x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x10]
               	lsl	x0, x0, #3
               	sxtw	x0, w0
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldursw	x12, [x29, #-0x18]
               	add	x0, x0, x12
               	sxtw	x12, w0
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x63               // =99
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x8
               	ldr	x22, [x21]
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
