
struct_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400288 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	stur	x15, [x29, #-0x8]
               	stur	w15, [x29, #-0x20]
               	b	0x4002ac <.text+0x3c>
               	ldursw	x15, [x29, #-0x20]
               	cmp	x15, #0x5
               	b.ge	0x40030c <.text+0x9c>
               	b	0x4002d0 <.text+0x60>
               	sub	x15, x29, #0x20
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x4002ac <.text+0x3c>
               	mov	x20, #0x10              // =16
               	mov	x0, x20
               	bl	0x4004b8 <malloc>
               	mov	x14, x0
               	stur	x14, [x29, #-0x10]
               	ldur	x20, [x29, #-0x10]
               	ldursw	x14, [x29, #-0x20]
               	str	w14, [x20]
               	ldur	x15, [x29, #-0x10]
               	add	x14, x15, #0x8
               	ldur	x15, [x29, #-0x8]
               	str	x15, [x14]
               	ldur	x20, [x29, #-0x10]
               	stur	x20, [x29, #-0x8]
               	b	0x4002bc <.text+0x4c>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x18]
               	ldur	x15, [x29, #-0x8]
               	stur	x15, [x29, #-0x10]
               	b	0x400320 <.text+0xb0>
               	ldur	x15, [x29, #-0x10]
               	cmp	x15, #0x0
               	b.eq	0x400354 <.text+0xe4>
               	ldursw	x15, [x29, #-0x18]
               	ldur	x20, [x29, #-0x10]
               	ldrsw	x14, [x20]
               	add	x12, x15, x14
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x18]
               	add	x14, x20, #0x8
               	ldr	x20, [x14]
               	stur	x20, [x29, #-0x10]
               	b	0x400320 <.text+0xb0>
               	ldursw	x20, [x29, #-0x18]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec495
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069c8 <exit+0x6504>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a58
               	tbz	w21, #0x6, 0x3fea1c
               	<unknown>
               	cbnz	w16, 0x46e9c4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fffd0
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
               	bl	0x4004c4 <exit>
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
               	adr	x10, 0x4ec561
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a94 <exit+0x65d0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b24
               	tbz	w21, #0x6, 0x3feae8
               	<unknown>
               	cbnz	w16, 0x46ea90
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40009c
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

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd8]
               	br	x16
