
param_array_qualifier.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	mov	x15, x0
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	sub	x15, x29, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldrb	w10, [x14, #0x8]
               	strb	w10, [x15, #0x8]
               	ldrb	w10, [x14, #0x9]
               	strb	w10, [x15, #0x9]
               	ldrb	w10, [x14, #0xa]
               	strb	w10, [x15, #0xa]
               	ldrb	w10, [x14, #0xb]
               	strb	w10, [x15, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x13, x15, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	add	x14, x14, x15
               	sxtw	x14, w14
               	cmp	x14, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldrsw	x0, [x14]
               	add	x13, x14, #0x4
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	add	x0, x0, x14
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x14, [x0]
               	add	x13, x0, #0x4
               	ldrsw	x13, [x13]
               	add	x14, x14, x13
               	sxtw	x14, w14
               	add	x0, x0, #0x8
               	ldrsw	x0, [x0]
               	add	x14, x14, x0
               	sxtw	x14, w14
               	cmp	x14, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x28
               	adrp	x19, <page>
               	add	x19, x19, #0xdc
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x14, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x14, #0x10]
               	ldr	x10, [sp], #0x10
               	sub	x14, x29, #0x28
               	ldrsw	x0, [x14]
               	add	x13, x14, #0x4
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	add	x14, x14, #0x8
               	ldrsw	x14, [x14]
               	add	x0, x0, x14
               	sxtw	x0, w0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
