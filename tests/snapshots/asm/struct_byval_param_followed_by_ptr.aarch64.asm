
struct_byval_param_followed_by_ptr.aarch64:	file format elf64-littleaarch64

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
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
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
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
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
               	sub	sp, sp, #0x10
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	mov	x14, x2
               	sub	x13, x29, #0x10
               	ldur	x12, [x29, #0x20]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldr	x10, [x12, #0x8]
               	str	x10, [x13, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x11, x13
               	sub	x11, x29, #0x10
               	add	x11, x11, #0x8
               	ldr	w12, [x11]
               	cmp	x12, #0x7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	cmp	x14, #0x0
               	b.ne	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	ldrsw	x12, [x14]
               	cmp	x12, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	mov	x12, #0x1               // =1
               	str	w12, [x15]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x19, [sp, #0x40]
               	sub	x15, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x158
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	mov	x14, #0x7               // =7
               	str	w14, [x13]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x18]
               	sub	x20, x29, #0x18
               	sub	x21, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x22, x19
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x23, x0
               	sxtw	x22, w23
               	cmp	x22, #0x0
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x15c
               	mov	x24, x19
               	sxtw	x21, w23
               	ldursw	x22, [x29, #-0x18]
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x11, x19
               	ldrsw	x20, [x11]
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x23, [x29, #-0x18]
               	cmp	x23, #0x1
               	b.eq	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x17c
               	mov	x25, x19
               	ldursw	x26, [x29, #-0x18]
               	mov	x0, x25
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x196
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
