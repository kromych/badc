
object_macro_to_fn_macro_rescan.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400340 <.text+0xa0>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	mov	x21, x1
               	sxtw	x22, w2
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x23, x19
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x400598 <printf>
               	sxtw	x0, w0
               	mov	x11, x0
               	bl	0x4005a4 <abort>
               	sxtw	x0, w0
               	mov	x11, x0
               	mov	x11, #0x0               // =0
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	mov	x20, #0x7               // =7
               	sxtw	x14, w20
               	cmp	x14, #0x7
               	b.ne	0x40038c <.text+0xec>
               	mov	x14, #0x0               // =0
               	mov	x17, #0xff              // =255
               	and	x13, x14, x17
               	stur	x13, [x29, #-0x28]
               	b	0x4003c4 <.text+0x124>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x10f
               	mov	x22, x19
               	mov	x23, #0x13              // =19
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x4002b8 <.text+0x18>
               	mov	x11, x0
               	stur	x11, [x29, #-0x28]
               	b	0x4003c4 <.text+0x124>
               	sxtw	x11, w20
               	add	x20, x11, #0x1
               	sxtw	x20, w20
               	cmp	x20, #0x8
               	b.ne	0x4003ec <.text+0x14c>
               	mov	x20, #0x0               // =0
               	mov	x17, #0xff              // =255
               	and	x11, x20, x17
               	stur	x11, [x29, #-0x30]
               	b	0x400424 <.text+0x184>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15e
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x169
               	mov	x25, x19
               	mov	x20, #0x14              // =20
               	mov	x0, x24
               	mov	x2, x20
               	mov	x1, x25
               	bl	0x4002b8 <.text+0x18>
               	mov	x22, x0
               	stur	x22, [x29, #-0x30]
               	b	0x400424 <.text+0x184>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ec579
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406aac <exit+0x64fc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8b3c
               	tbz	w21, #0x6, 0x3feb00
               	<unknown>
               	cbnz	w16, 0x46eaa8
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4000b4
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
               	bl	0x4005b0 <exit>
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
               	adr	x10, 0x4ec641
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x406b74 <exit+0x65c4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f8c04
               	tbz	w21, #0x6, 0x3febc8
               	<unknown>
               	cbnz	w16, 0x46eb70
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40017c
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16

<abort>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	br	x16
