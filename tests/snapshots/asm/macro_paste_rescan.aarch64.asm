
macro_paste_rescan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x3               // =3
               	cmp	x15, #0x3
               	b.eq	0x40024c <.text+0x2c>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x14, #0x3               // =3
               	cmp	x14, #0x3
               	b.eq	0x400264 <.text+0x44>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ret
               	mov	x0, #0x32               // =50
               	sxtw	x0, w0
               	cmp	x0, #0x32
               	b.eq	0x40027c <.text+0x5c>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x14, #0x11              // =17
               	sxtw	x14, w14
               	cmp	x14, #0x11
               	b.eq	0x400298 <.text+0x78>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	ret
               	mov	x0, #0x3                // =3
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	0x4002b0 <.text+0x90>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ret
               	<unknown>
               	adr	x10, 0x4ec3e1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406914 <exit+0x651c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f89a4
               	tbz	w21, #0x6, 0x3fe968
               	<unknown>
               	cbnz	w16, 0x46e910
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fff1c
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
               	bl	0x4003f8 <exit>
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
               	adr	x10, 0x4ec4a1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069d4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a64
               	tbz	w21, #0x6, 0x3fea28
               	<unknown>
               	cbnz	w16, 0x46e9d0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fffdc
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
