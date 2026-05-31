
struct_2d_array_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x38]
               	b	0x400260 <.text+0x30>
               	ldursw	x15, [x29, #-0x38]
               	cmp	x15, #0x3
               	b.ge	0x400290 <.text+0x60>
               	b	0x400284 <.text+0x54>
               	sub	x15, x29, #0x38
               	ldrsw	x14, [x15]
               	add	x13, x14, #0x1
               	str	w13, [x15]
               	b	0x400260 <.text+0x30>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x40]
               	b	0x4002a4 <.text+0x74>
               	sub	x14, x29, #0x30
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x50]
               	stur	w15, [x29, #-0x38]
               	b	0x400304 <.text+0xd4>
               	ldursw	x13, [x29, #-0x40]
               	cmp	x13, #0x4
               	b.ge	0x400300 <.text+0xd0>
               	b	0x4002c8 <.text+0x98>
               	sub	x13, x29, #0x40
               	ldrsw	x14, [x13]
               	add	x15, x14, #0x1
               	str	w15, [x13]
               	b	0x4002a4 <.text+0x74>
               	sub	x15, x29, #0x30
               	ldursw	x14, [x29, #-0x38]
               	lsl	x13, x14, #4
               	add	x12, x15, x13
               	ldursw	x13, [x29, #-0x40]
               	lsl	x15, x13, #2
               	add	x11, x12, x15
               	mov	x17, #0xa               // =10
               	mul	x15, x14, x17
               	sxtw	x15, w15
               	add	x14, x15, x13
               	sxtw	x14, w14
               	str	w14, [x11]
               	b	0x4002b4 <.text+0x84>
               	b	0x400270 <.text+0x40>
               	ldursw	x15, [x29, #-0x38]
               	cmp	x15, #0x3
               	b.ge	0x400334 <.text+0x104>
               	b	0x400328 <.text+0xf8>
               	sub	x15, x29, #0x38
               	ldrsw	x11, [x15]
               	add	x13, x11, #0x1
               	str	w13, [x15]
               	b	0x400304 <.text+0xd4>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x40]
               	b	0x40034c <.text+0x11c>
               	ldursw	x12, [x29, #-0x50]
               	sub	x10, x12, #0x6f
               	sxtw	x0, w10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x13, [x29, #-0x40]
               	cmp	x13, #0x4
               	b.ge	0x4003a0 <.text+0x170>
               	b	0x400370 <.text+0x140>
               	sub	x13, x29, #0x40
               	ldrsw	x11, [x13]
               	add	x15, x11, #0x1
               	str	w15, [x13]
               	b	0x40034c <.text+0x11c>
               	sub	x15, x29, #0x50
               	ldrsw	x11, [x15]
               	ldursw	x13, [x29, #-0x38]
               	lsl	x12, x13, #4
               	add	x13, x14, x12
               	ldursw	x12, [x29, #-0x40]
               	lsl	x10, x12, #2
               	add	x12, x13, x10
               	ldrsw	x10, [x12]
               	add	x12, x11, x10
               	str	w12, [x15]
               	b	0x40035c <.text+0x12c>
               	b	0x400314 <.text+0xe4>
               	<unknown>
               	adr	x10, 0x4ec4c9
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069fc <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a8c
               	tbz	w21, #0x6, 0x3fea50
               	<unknown>
               	cbnz	w16, 0x46e9f8
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400004
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
               	bl	0x4004e8 <exit>
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
               	adr	x10, 0x4ec591
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ac4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b54
               	tbz	w21, #0x6, 0x3feb18
               	<unknown>
               	cbnz	w16, 0x46eac0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4000cc
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
               	ldr	x16, [x16, #0xd0]
               	br	x16
