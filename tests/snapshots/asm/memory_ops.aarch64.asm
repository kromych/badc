
memory_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400308 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	blr	x16
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
               	str	x19, [sp, #0x40]
               	mov	x20, #0xa               // =10
               	mov	x0, x20
               	bl	0x4005c8 <malloc>
               	mov	x21, x0
               	mov	x0, x20
               	bl	0x4005c8 <malloc>
               	mov	x22, x0
               	mov	x23, #0x41              // =65
               	mov	x24, #0x9               // =9
               	mov	x0, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4005d4 <memset>
               	mov	x10, x0
               	add	x10, x21, #0x9
               	mov	x25, #0x0               // =0
               	strb	w25, [x10]
               	mov	x0, x22
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x4005d4 <memset>
               	mov	x8, x0
               	add	x8, x22, #0x9
               	strb	w25, [x8]
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	0x4005e0 <memcmp>
               	sxtw	x0, w0
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.eq	0x4003e8 <.text+0xf8>
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x20, x22, #0x5
               	mov	x24, #0x42              // =66
               	strb	w24, [x20]
               	mov	x26, #0xa               // =10
               	mov	x0, x21
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x4005e0 <memcmp>
               	sxtw	x0, w0
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.ne	0x40044c <.text+0x15c>
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec5a5
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ad8 <exit+0x64ec>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b68
               	tbz	w21, #0x6, 0x3feb2c
               	<unknown>
               	cbnz	w16, 0x46ead4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4000e0
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
		...
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x4005ec <exit>
               	uxtb	w0, w0
               	mov	x14, x0
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec671
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ba4 <exit+0x65b8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8c34
               	tbz	w21, #0x6, 0x3febf8
               	<unknown>
               	cbnz	w16, 0x46eba0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4001ac
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<malloc>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	br	x16

<memset>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	br	x16

<memcmp>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16
