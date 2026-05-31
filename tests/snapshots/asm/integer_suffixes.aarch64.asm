
integer_suffixes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	mov	x15, #0x1               // =1
               	mov	x14, #0x2               // =2
               	mov	x13, #0x3               // =3
               	mov	x12, #0x4               // =4
               	mov	x11, #0x5               // =5
               	mov	x10, #0x6               // =6
               	mov	x9, #0x7                // =7
               	mov	x8, #0x8                // =8
               	mov	x7, #0x9                // =9
               	mov	x6, #0xa                // =10
               	mov	x5, #0xff               // =255
               	mov	x4, #0xcafe             // =51966
               	mov	x3, #0x1000             // =4096
               	movk	x3, #0xd4a5, lsl #16
               	movk	x3, #0xe8, lsl #32
               	mov	x2, #0x100000000        // =4294967296
               	sxtw	x1, w15
               	cmp	x1, #0x1
               	b.eq	0x4002a0 <.text+0x80>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w14
               	cmp	x15, #0x2
               	b.eq	0x4002c0 <.text+0xa0>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w13
               	cmp	x0, #0x3
               	b.eq	0x4002dc <.text+0xbc>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w12
               	cmp	x15, #0x4
               	b.eq	0x4002fc <.text+0xdc>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w11
               	cmp	x0, #0x5
               	b.eq	0x400318 <.text+0xf8>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w10
               	cmp	x15, #0x6
               	b.eq	0x400338 <.text+0x118>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w9
               	cmp	x0, #0x7
               	b.eq	0x400354 <.text+0x134>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w8
               	cmp	x15, #0x8
               	b.eq	0x400374 <.text+0x154>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w7
               	cmp	x0, #0x9
               	b.eq	0x400390 <.text+0x170>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w6
               	cmp	x15, #0xa
               	b.eq	0x4003b0 <.text+0x190>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w5
               	cmp	x0, #0xff
               	b.eq	0x4003cc <.text+0x1ac>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x15, w4
               	mov	x17, #0xcafe            // =51966
               	cmp	x15, x17
               	b.eq	0x4003f0 <.text+0x1d0>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	cmp	x3, x17
               	b.eq	0x400418 <.text+0x1f8>
               	mov	x3, #0xd                // =13
               	mov	x0, x3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0x100000000       // =4294967296
               	cmp	x2, x17
               	b.eq	0x400438 <.text+0x218>
               	mov	x2, #0xe                // =14
               	mov	x0, x2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	x2, x0, #0x7
               	sxtw	x0, w2
               	cmp	x0, #0xa
               	b.eq	0x40045c <.text+0x23c>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec595
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406ac8 <exit+0x6510>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b58
               	tbz	w21, #0x6, 0x3feb1c
               	<unknown>
               	cbnz	w16, 0x46eac4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4000d0
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
               	bl	0x4005b8 <exit>
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
               	adr	x10, 0x4ec661
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b94 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8c24
               	tbz	w21, #0x6, 0x3febe8
               	<unknown>
               	cbnz	w16, 0x46eb90
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40019c
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
