
sizeof_typedef_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x200             // =512
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	0x400250 <.text+0x30>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x14, #0x28              // =40
               	sxtw	x14, w14
               	cmp	x14, #0x28
               	b.eq	0x40026c <.text+0x4c>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400280 <.text+0x60>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400294 <.text+0x74>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4002a8 <.text+0x88>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4002bc <.text+0x9c>
               	mov	x14, #0x6               // =6
               	mov	x0, x14
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	<unknown>
               	adr	x10, 0x4ec3e9
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x40691c <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f89ac
               	tbz	w21, #0x6, 0x3fe970
               	<unknown>
               	cbnz	w16, 0x46e918
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fff24
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
               	bl	0x400408 <exit>
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
               	adr	x10, 0x4ec4b1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4069e4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8a74
               	tbz	w21, #0x6, 0x3fea38
               	<unknown>
               	cbnz	w16, 0x46e9e0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x3fffec
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
