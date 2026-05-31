
bitop_common_type.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x15, #0xf000            // =61440
               	movk	x15, #0x4006, lsl #16
               	movk	x15, #0x1, lsl #32
               	mov	x14, #0x0               // =0
               	orr	x13, x15, x14
               	add	x12, x13, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x12, x17
               	b.eq	0x400280 <.text+0x60>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x13, x14, x17
               	and	x0, x15, x13
               	add	x13, x0, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	0x4002c4 <.text+0xa4>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x15, x14
               	add	x13, x0, #0x1
               	mov	x17, #0xf001            // =61441
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	0x4002f4 <.text+0xd4>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xf001             // =61441
               	movk	x0, #0x4006, lsl #16
               	movk	x0, #0x1, lsl #32
               	sub	x13, x0, #0x1
               	mov	x0, #0xf                // =15
               	sxtw	x0, w0
               	orr	x11, x13, x0
               	add	x0, x11, #0x1
               	mov	x17, #0xf010            // =61456
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x400338 <.text+0x118>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x11, x15, x14
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x11, x17
               	b.eq	0x400364 <.text+0x144>
               	mov	x11, #0x5               // =5
               	mov	x0, x11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x0, x15, x14
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0x4006, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x40038c <.text+0x16c>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	orr	x11, x15, x14
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x11, x17
               	cset	x14, hi
               	cmp	x14, #0x0
               	b.ne	0x4003b4 <.text+0x194>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec4ed
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406a20 <exit+0x6518>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8ab0
               	tbz	w21, #0x6, 0x3fea74
               	<unknown>
               	cbnz	w16, 0x46ea1c
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400028
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74
               	udf	#0x0
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	mov	x0, x20
               	bl	0x400508 <exit>
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
               	adr	x10, 0x4ec5b1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ae4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b74
               	tbz	w21, #0x6, 0x3feb38
               	<unknown>
               	cbnz	w16, 0x46eae0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4000ec
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
