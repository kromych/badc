
struct_field_assign_from_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x2, w2
               	sxtw	x3, w3
               	sxtw	x4, w4
               	mov	x0, #0x4                // =4
               	str	w0, [x1]
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	mov	x20, x0
               	mov	x21, x1
               	add	x22, x20, #0x8
               	ldr	x23, [x22]
               	ldr	x24, [x20, #0x18]
               	add	x1, x20, #0x14
               	ldrsw	x0, [x20, #0x10]
               	add	x0, x0, #0x1
               	sxtw	x2, w0
               	mov	x25, #0x10              // =16
               	mov	x26, #0x7fff            // =32767
               	mov	x0, x23
               	mov	x5, x21
               	mov	x4, x26
               	mov	x3, x25
               	bl	<addr>
               	str	x0, [x22]
               	add	x22, x20, #0x18
               	ldr	x0, [x22]
               	add	x1, x20, #0x24
               	ldrsw	x2, [x20, #0x20]
               	add	x2, x2, #0x1
               	sxtw	x2, w2
               	mov	x3, x25
               	mov	x5, x21
               	mov	x4, x26
               	bl	<addr>
               	str	x0, [x22]
               	ldr	x0, [x20, #0x8]
               	cmp	x23, x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20, #0x18]
               	cmp	x24, x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20, #0x18]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0x14]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x20, #0x24]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, #0x120
               	adrp	x1, <page>
               	add	x1, x1, #0x148
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x14d
               	sxtw	x0, w0
               	ldr	x2, [x20, #0x8]
               	ldr	x3, [x20, #0x18]
               	ldrsw	x4, [x20, #0x14]
               	ldrsw	x5, [x20, #0x24]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x184
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
