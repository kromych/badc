
typedef_array_comma_list.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x220
               	str	x19, [sp]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	ldr	x14, [x15]
               	cmp	x14, #0x0
               	b.eq	0x400274 <.text+0x54>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x15, x19
               	add	x0, x15, #0x78
               	ldr	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	ldr	x15, [x0]
               	cmp	x15, #0x1
               	b.eq	0x4002d8 <.text+0xb8>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	add	x15, x0, #0x8
               	ldr	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x400308 <.text+0xe8>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x15, x19
               	add	x0, x15, #0x78
               	ldr	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x40033c <.text+0x11c>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	ldr	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x40036c <.text+0x14c>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x0, x19
               	add	x15, x0, #0x10
               	ldr	x0, [x15]
               	cmp	x0, #0x7
               	b.eq	0x40039c <.text+0x17c>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x15, x19
               	add	x0, x15, #0x78
               	ldr	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x4003d0 <.text+0x1b0>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	sxtw	x0, w0
               	lsl	x15, x0, #3
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	0x400400 <.text+0x1e0>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	sxtw	x0, w0
               	lsl	x15, x0, #3
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	0x400430 <.text+0x210>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x250
               	mov	x0, x19
               	add	x15, x0, #0x138
               	mov	x0, #0x2a               // =42
               	str	x0, [x15]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x450
               	mov	x13, x19
               	add	x0, x13, #0x1f8
               	mov	x13, #0xffff            // =65535
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	str	x13, [x0]
               	ldr	x12, [x15]
               	cmp	x12, #0x2a
               	b.eq	0x40048c <.text+0x26c>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x450
               	mov	x15, x19
               	add	x0, x15, #0x1f8
               	ldr	x15, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	0x4004d0 <.text+0x2b0>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x250
               	mov	x0, x19
               	ldr	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400500 <.text+0x2e0>
               	mov	x15, #0xd               // =13
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x450
               	mov	x0, x19
               	ldr	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400530 <.text+0x310>
               	mov	x15, #0xe               // =14
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x208
               	add	x15, x0, #0x200
               	mov	x0, #0x63               // =99
               	str	w0, [x15]
               	sub	x13, x29, #0x208
               	add	x0, x13, #0x200
               	ldrsw	x13, [x0]
               	cmp	x13, #0x63
               	b.eq	0x40056c <.text+0x34c>
               	mov	x13, #0xf               // =15
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x40               // =64
               	lsl	x13, x0, #3
               	sxtw	x13, w13
               	add	x0, x13, #0x4
               	sxtw	x0, w0
               	cmp	x0, #0x208
               	b.le	0x40059c <.text+0x37c>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec6d9
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406c0c <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8c9c
               	tbz	w21, #0x6, 0x3fec60
               	<unknown>
               	cbnz	w16, 0x46ec08
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400214
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
               	bl	0x4006f8 <exit>
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
               	adr	x10, 0x4ec7a1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406cd4 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8d64
               	tbz	w21, #0x6, 0x3fed28
               	<unknown>
               	cbnz	w16, 0x46ecd0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4002dc <.text+0xbc>
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
