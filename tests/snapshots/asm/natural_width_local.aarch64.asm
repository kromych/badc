
natural_width_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x15, #0x12c             // =300
               	mov	x14, #0xc8              // =200
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x20]
               	stur	w13, [x29, #-0x28]
               	b	0x40025c <.text+0x3c>
               	ldursw	x13, [x29, #-0x20]
               	cmp	x13, #0x4
               	b.ge	0x400290 <.text+0x70>
               	ldursw	x13, [x29, #-0x28]
               	sxtb	x12, w15
               	add	x11, x13, x12
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x28]
               	ldursw	x12, [x29, #-0x20]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x20]
               	b	0x40025c <.text+0x3c>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x30]
               	sxtb	x12, w15
               	cmp	x12, #0x2c
               	b.eq	0x4002b8 <.text+0x98>
               	ldursw	x12, [x29, #-0x30]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x30]
               	b	0x4002b8 <.text+0x98>
               	mov	x17, #0xff              // =255
               	and	x11, x15, x17
               	mov	x17, #0x2c              // =44
               	eor	x12, x11, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x11, x12, x17
               	cmp	x11, #0x0
               	b.eq	0x4002f0 <.text+0xd0>
               	ldursw	x11, [x29, #-0x30]
               	add	x12, x11, #0x2
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x30]
               	b	0x4002f0 <.text+0xd0>
               	sxtb	x12, w14
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x12, x17
               	b.eq	0x400320 <.text+0x100>
               	ldursw	x12, [x29, #-0x30]
               	add	x11, x12, #0x4
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x30]
               	b	0x400320 <.text+0x100>
               	ldursw	x11, [x29, #-0x28]
               	cmp	x11, #0xb0
               	b.eq	0x400340 <.text+0x120>
               	ldursw	x11, [x29, #-0x30]
               	add	x12, x11, #0x8
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x30]
               	b	0x400340 <.text+0x120>
               	ldursw	x0, [x29, #-0x30]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec475
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069a8 <exit+0x6510>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a38
               	tbz	w21, #0x6, 0x3fe9fc
               	<unknown>
               	cbnz	w16, 0x46e9a4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fffb0
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
               	bl	0x400498 <exit>
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
               	adr	x10, 0x4ec541
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a74 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b04
               	tbz	w21, #0x6, 0x3feac8
               	<unknown>
               	cbnz	w16, 0x46ea70
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40007c
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
