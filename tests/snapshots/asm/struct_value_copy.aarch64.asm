
struct_value_copy.aarch64:	file format elf64-littleaarch64

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
               	sub	x15, x29, #0x8
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x14, x13, #0x4
               	mov	x13, #0x2               // =2
               	str	w13, [x14]
               	sub	x15, x29, #0x10
               	mov	x13, #0x63              // =99
               	str	w13, [x15]
               	sub	x14, x29, #0x10
               	add	x15, x14, #0x4
               	str	w13, [x15]
               	sub	x14, x29, #0x10
               	sub	x15, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x14]
               	ldr	x10, [sp], #0x10
               	mov	x13, x14
               	sub	x13, x29, #0x10
               	ldrsw	x15, [x13]
               	cmp	x15, #0x1
               	b.eq	0x4002b4 <.text+0x94>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	add	x0, x13, #0x4
               	ldrsw	x13, [x0]
               	cmp	x13, #0x2
               	b.eq	0x4002dc <.text+0xbc>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x13, #0x3e8             // =1000
               	str	w13, [x0]
               	sub	x14, x29, #0x8
               	add	x13, x14, #0x4
               	mov	x14, #0x7d0             // =2000
               	str	w14, [x13]
               	sub	x0, x29, #0x10
               	ldrsw	x14, [x0]
               	cmp	x14, #0x1
               	b.eq	0x40031c <.text+0xfc>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x2
               	b.eq	0x400340 <.text+0x120>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x20
               	mov	x0, #0x7                // =7
               	str	w0, [x14]
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x4
               	mov	x13, #0xe               // =14
               	str	w13, [x0]
               	sub	x14, x29, #0x20
               	add	x13, x14, #0x8
               	mov	x14, #0x15              // =21
               	str	w14, [x13]
               	sub	x0, x29, #0x30
               	sub	x14, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldrb	w10, [x14, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x14, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x14, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x14, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x13, x0
               	sub	x13, x29, #0x30
               	ldrsw	x14, [x13]
               	cmp	x14, #0x7
               	b.eq	0x4003c8 <.text+0x1a8>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x0, x13, #0x4
               	ldrsw	x13, [x0]
               	cmp	x13, #0xe
               	b.eq	0x4003f0 <.text+0x1d0>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	add	x13, x0, #0x8
               	ldrsw	x0, [x13]
               	cmp	x0, #0x15
               	b.eq	0x400414 <.text+0x1f4>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	mov	x0, #0x32               // =50
               	str	w0, [x13]
               	sub	x14, x29, #0x8
               	add	x0, x14, #0x4
               	mov	x14, #0x3c              // =60
               	str	w14, [x0]
               	sub	x13, x29, #0x8
               	sub	x14, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x13
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x32
               	b.eq	0x400470 <.text+0x250>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x3c
               	b.eq	0x400494 <.text+0x274>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec5cd
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b00 <exit+0x6518>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b90
               	tbz	w21, #0x6, 0x3feb54
               	<unknown>
               	cbnz	w16, 0x46eafc
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400108
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
               	bl	0x4005e8 <exit>
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
               	adr	x10, 0x4ec691
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406bc4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8c54
               	tbz	w21, #0x6, 0x3fec18
               	<unknown>
               	cbnz	w16, 0x46ebc0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4001cc
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
