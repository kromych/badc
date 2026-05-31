
queens.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40044c <.text+0x22c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x15, x0
               	sxtw	x14, w1
               	sxtw	x13, w2
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x8]
               	b	0x40025c <.text+0x3c>
               	ldursw	x12, [x29, #-0x8]
               	cmp	x12, x14
               	b.ge	0x4002b8 <.text+0x98>
               	b	0x400280 <.text+0x60>
               	ldursw	x12, [x29, #-0x8]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x8]
               	b	0x40025c <.text+0x3c>
               	ldursw	x11, [x29, #-0x8]
               	sub	x12, x14, x11
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	lsl	x10, x11, #2
               	add	x11, x15, x10
               	ldrsw	x10, [x11]
               	sub	x11, x13, x10
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x18]
               	ldursw	x10, [x29, #-0x18]
               	cmp	x10, #0x0
               	b.ge	0x4002ec <.text+0xcc>
               	b	0x4002cc <.text+0xac>
               	mov	x12, #0x0               // =0
               	mov	x0, x12
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x10, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x11, x10, x17
               	stur	w11, [x29, #-0x18]
               	b	0x4002ec <.text+0xcc>
               	ldursw	x11, [x29, #-0x8]
               	lsl	x10, x11, #2
               	add	x11, x15, x10
               	ldrsw	x10, [x11]
               	cmp	x10, x13
               	b.ne	0x400314 <.text+0xf4>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x11, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x18]
               	cmp	x11, x0
               	b.ne	0x400334 <.text+0x114>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40026c <.text+0x4c>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, x0
               	sxtw	x21, w1
               	cmp	x21, #0x8
               	b.ne	0x400390 <.text+0x170>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	0x4003a0 <.text+0x180>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, #0x8
               	b.ge	0x4003e4 <.text+0x1c4>
               	b	0x4003c4 <.text+0x1a4>
               	ldursw	x13, [x29, #-0x10]
               	add	x12, x13, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x10]
               	b	0x4003a0 <.text+0x180>
               	ldursw	x22, [x29, #-0x10]
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x13, x0
               	cbz	x13, 0x400410 <.text+0x1f0>
               	b	0x40040c <.text+0x1ec>
               	ldursw	x24, [x29, #-0x8]
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4003b0 <.text+0x190>
               	lsl	x22, x21, #2
               	add	x13, x20, x22
               	ldursw	x22, [x29, #-0x10]
               	str	w22, [x13]
               	ldursw	x23, [x29, #-0x8]
               	add	x22, x21, #0x1
               	sxtw	x24, w22
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x400338 <.text+0x118>
               	mov	x13, x0
               	add	x24, x23, x13
               	sxtw	x24, w24
               	stur	w24, [x29, #-0x8]
               	b	0x4003b0 <.text+0x190>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x20, x29, #0x20
               	mov	x21, #0x0               // =0
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400338 <.text+0x118>
               	mov	x13, x0
               	sxtw	x21, w13
               	cmp	x21, #0x5c
               	b.eq	0x4004a0 <.text+0x280>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec5e1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b14 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ba4
               	tbz	w21, #0x6, 0x3feb68
               	<unknown>
               	cbnz	w16, 0x46eb10
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40011c
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x4005f8 <exit>
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
               	adr	x10, 0x4ec6a1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406bd4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8c64
               	tbz	w21, #0x6, 0x3fec28
               	<unknown>
               	cbnz	w16, 0x46ebd0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4001dc
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16
