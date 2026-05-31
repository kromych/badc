
function_macro.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400598 <.text+0x378>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	str	x1, [sp, #-0x10]!
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	stur	x15, [x29, #0x10]
               	mov	x14, x1
               	stur	x14, [x29, #0x20]
               	b	0x400260 <.text+0x40>
               	ldur	x14, [x29, #0x10]
               	ldrb	w15, [x14]
               	stur	x15, [x29, #-0x8]
               	cbz	x15, 0x4002e0 <.text+0xc0>
               	b	0x4002c0 <.text+0xa0>
               	add	x13, x29, #0x10
               	ldr	x14, [x13]
               	add	x15, x14, #0x1
               	str	x15, [x13]
               	add	x14, x29, #0x20
               	ldr	x15, [x14]
               	add	x13, x15, #0x1
               	str	x13, [x14]
               	b	0x400260 <.text+0x40>
               	ldur	x13, [x29, #0x10]
               	ldrb	w15, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x10]
               	cbz	x15, 0x400310 <.text+0xf0>
               	b	0x4002ec <.text+0xcc>
               	ldur	x14, [x29, #0x10]
               	ldrb	w15, [x14]
               	ldur	x14, [x29, #0x20]
               	ldrb	w13, [x14]
               	cmp	x15, x13
               	cset	x14, eq
               	stur	x14, [x29, #-0x8]
               	b	0x4002e0 <.text+0xc0>
               	ldur	x14, [x29, #-0x8]
               	cbz	x14, 0x400298 <.text+0x78>
               	b	0x400274 <.text+0x54>
               	ldur	x13, [x29, #0x20]
               	ldrb	w15, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x15, x17
               	cmp	x13, #0x0
               	cset	x15, eq
               	stur	x15, [x29, #-0x10]
               	b	0x400310 <.text+0xf0>
               	ldur	x0, [x29, #-0x10]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xdb
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe6
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf1
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	mov	x11, x0
               	cmp	x11, #0x0
               	b.ne	0x4003bc <.text+0x19c>
               	mov	x11, #0x15              // =21
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xfc
               	mov	x24, x19
               	mov	x0, x21
               	mov	x1, x24
               	bl	0x400238 <.text+0x18>
               	mov	x11, x0
               	cmp	x11, #0x0
               	b.ne	0x40040c <.text+0x1ec>
               	mov	x11, #0x16              // =22
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x107
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	mov	x11, x0
               	cmp	x11, #0x0
               	b.ne	0x40045c <.text+0x23c>
               	mov	x11, #0x17              // =23
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x23, x0
               	cmp	x23, #0x0
               	b.ne	0x4004a0 <.text+0x280>
               	mov	x23, #0x18              // =24
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x400238 <.text+0x18>
               	mov	x21, x0
               	cmp	x21, #0x0
               	b.ne	0x4004e4 <.text+0x2c4>
               	mov	x21, #0x19              // =25
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x112
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x21, x19
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.ne	0x400578 <.text+0x358>
               	mov	x13, #0x1f              // =31
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	bl	0x400324 <.text+0x104>
               	mov	x15, x0
               	sxtw	x14, w15
               	cmp	x14, #0x0
               	b.eq	0x4005ec <.text+0x3cc>
               	sxtw	x20, w15
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	0x400510 <.text+0x2f0>
               	mov	x13, x0
               	sxtw	x20, w13
               	cmp	x20, #0x0
               	b.eq	0x400624 <.text+0x404>
               	sxtw	x20, w13
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x128
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x22, x19
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400238 <.text+0x18>
               	mov	x13, x0
               	cmp	x13, #0x0
               	b.ne	0x400678 <.text+0x458>
               	mov	x13, #0x29              // =41
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec7c1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406cf4 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8d84
               	tbz	w21, #0x6, 0x3fed48
               	<unknown>
               	cbnz	w16, 0x46ecf0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4002fc <.text+0xdc>
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
               	bl	0x4007d8 <exit>
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
               	adr	x10, 0x4ec881
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406db4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8e44
               	tbz	w21, #0x6, 0x3fee08
               	<unknown>
               	cbnz	w16, 0x46edb0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4003bc <.text+0x19c>
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
