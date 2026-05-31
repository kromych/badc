
local_array_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40070c <.text+0x48c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400b78 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sxtw	x15, w0
               	sub	x14, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x548
               	mov	x13, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x13]
               	strb	w10, [x14]
               	ldrb	w10, [x13, #0x1]
               	strb	w10, [x14, #0x1]
               	ldrb	w10, [x13, #0x2]
               	strb	w10, [x14, #0x2]
               	ldrb	w10, [x13, #0x3]
               	strb	w10, [x14, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x12, x14
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x12, x19
               	lsl	x13, x15, #1
               	add	x14, x12, x13
               	ldrh	w13, [x14]
               	sub	x14, x29, #0x8
               	strh	w13, [x14]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x348
               	mov	x12, x19
               	lsl	x14, x15, #1
               	add	x15, x12, x14
               	ldrh	w14, [x15]
               	sub	x15, x29, #0x8
               	add	x12, x15, #0x2
               	strh	w14, [x12]
               	sub	x15, x29, #0x8
               	ldrh	w12, [x15]
               	mov	x17, #0x3e8             // =1000
               	mul	x15, x12, x17
               	sxtw	x15, w15
               	sub	x12, x29, #0x8
               	add	x14, x12, #0x2
               	ldrh	w12, [x14]
               	add	x14, x15, x12
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sxtw	x15, w0
               	sxtw	x14, w1
               	sub	x13, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x54c
               	mov	x12, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldrb	w10, [x12, #0x8]
               	strb	w10, [x13, #0x8]
               	ldrb	w10, [x12, #0x9]
               	strb	w10, [x13, #0x9]
               	ldrb	w10, [x12, #0xa]
               	strb	w10, [x13, #0xa]
               	ldrb	w10, [x12, #0xb]
               	strb	w10, [x13, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x11, x13
               	add	x11, x15, x14
               	sxtw	x11, w11
               	sub	x12, x29, #0x10
               	str	w11, [x12]
               	sub	x13, x15, x14
               	sxtw	x13, w13
               	sub	x12, x29, #0x10
               	add	x11, x12, #0x4
               	str	w13, [x11]
               	mul	x12, x15, x14
               	sxtw	x12, w12
               	sub	x14, x29, #0x10
               	add	x15, x14, #0x8
               	str	w12, [x15]
               	sub	x14, x29, #0x10
               	ldrsw	x15, [x14]
               	sub	x14, x29, #0x10
               	add	x12, x14, #0x4
               	ldrsw	x14, [x12]
               	add	x12, x15, x14
               	sxtw	x12, w12
               	sub	x14, x29, #0x10
               	add	x15, x14, #0x8
               	ldrsw	x14, [x15]
               	add	x15, x12, x14
               	sxtw	x0, w15
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	mov	x15, x0
               	mov	x14, x1
               	sub	x13, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x558
               	mov	x12, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x12]
               	str	x10, [x13]
               	ldr	x10, [x12, #0x8]
               	str	x10, [x13, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x11, x13
               	add	x11, x15, x14
               	sub	x12, x29, #0x10
               	str	x11, [x12]
               	sub	x13, x15, x14
               	sub	x14, x29, #0x10
               	add	x15, x14, #0x8
               	str	x13, [x15]
               	sub	x14, x29, #0x10
               	ldr	x15, [x14]
               	sub	x14, x29, #0x10
               	add	x13, x14, #0x8
               	ldr	x14, [x13]
               	add	x13, x15, x14
               	sxtw	x0, w13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sxtw	x15, w0
               	sub	x14, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x568
               	mov	x13, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x13]
               	strb	w10, [x14]
               	ldrb	w10, [x13, #0x1]
               	strb	w10, [x14, #0x1]
               	ldrb	w10, [x13, #0x2]
               	strb	w10, [x14, #0x2]
               	ldrb	w10, [x13, #0x3]
               	strb	w10, [x14, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x12, x14
               	add	x12, x15, #0x61
               	sxtw	x12, w12
               	mov	x17, #0xff              // =255
               	and	x13, x12, x17
               	sub	x12, x29, #0x8
               	strb	w13, [x12]
               	mov	x14, #0x62              // =98
               	sub	x12, x29, #0x8
               	add	x13, x12, #0x1
               	strb	w14, [x13]
               	add	x12, x15, #0x1
               	sxtw	x12, w12
               	mov	x17, #0xff              // =255
               	and	x15, x12, x17
               	sub	x12, x29, #0x8
               	add	x13, x12, #0x2
               	strb	w15, [x13]
               	mov	x12, #0x64              // =100
               	sub	x13, x29, #0x8
               	add	x15, x13, #0x3
               	strb	w12, [x15]
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x10]
               	stur	w13, [x29, #-0x18]
               	b	0x4006b0 <.text+0x430>
               	ldursw	x13, [x29, #-0x18]
               	cmp	x13, #0x4
               	b.ge	0x4006f8 <.text+0x478>
               	b	0x4006d4 <.text+0x454>
               	sub	x13, x29, #0x18
               	ldrsw	x15, [x13]
               	add	x12, x15, #0x1
               	str	w12, [x13]
               	b	0x4006b0 <.text+0x430>
               	sub	x12, x29, #0x10
               	ldrsw	x15, [x12]
               	sub	x13, x29, #0x8
               	ldursw	x14, [x29, #-0x18]
               	add	x11, x13, x14
               	ldrb	w14, [x11]
               	add	x11, x15, x14
               	str	w11, [x12]
               	b	0x4006c0 <.text+0x440>
               	ldursw	x0, [x29, #-0x10]
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x15, x19
               	add	x14, x15, #0xa
               	mov	x15, #0x1234            // =4660
               	strh	w15, [x14]
               	adrp	x19, 0x410000
               	add	x19, x19, #0x348
               	mov	x13, x19
               	add	x15, x13, #0xa
               	mov	x13, #0x5678            // =22136
               	strh	w13, [x15]
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	0x4003d0 <.text+0x150>
               	mov	x13, x0
               	mov	x20, #0x1b20            // =6944
               	movk	x20, #0x47, lsl #16
               	sxtw	x20, w20
               	mov	x17, #0x5678            // =22136
               	add	x15, x20, x17
               	sxtw	x15, w15
               	cmp	x13, x15
               	b.eq	0x4007b4 <.text+0x534>
               	mov	x15, #0x1               // =1
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x3               // =3
               	mov	x20, #0x4               // =4
               	mov	x0, x21
               	mov	x1, x20
               	bl	0x40049c <.text+0x21c>
               	mov	x13, x0
               	cmp	x13, #0x12
               	b.eq	0x4007fc <.text+0x57c>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0xa               // =10
               	mov	x20, #0x4               // =4
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x400570 <.text+0x2f0>
               	mov	x21, x0
               	cmp	x21, #0x14
               	b.eq	0x400844 <.text+0x5c4>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x4005fc <.text+0x37c>
               	mov	x21, x0
               	cmp	x21, #0x12c
               	b.eq	0x400884 <.text+0x604>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x56c
               	mov	x21, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x23]
               	ldrb	w10, [x21, #0x8]
               	strb	w10, [x23, #0x8]
               	ldrb	w10, [x21, #0x9]
               	strb	w10, [x23, #0x9]
               	ldrb	w10, [x21, #0xa]
               	strb	w10, [x23, #0xa]
               	ldrb	w10, [x21, #0xb]
               	strb	w10, [x23, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x22, x23
               	sub	x22, x29, #0x10
               	ldrsw	x21, [x22]
               	sub	x22, x29, #0x10
               	add	x23, x22, #0x4
               	ldrsw	x22, [x23]
               	add	x23, x21, x22
               	sxtw	x23, w23
               	sub	x22, x29, #0x10
               	add	x21, x22, #0x8
               	ldrsw	x22, [x21]
               	add	x21, x23, x22
               	sxtw	x21, w21
               	cmp	x21, #0x6
               	b.eq	0x400928 <.text+0x6a8>
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x22, x29, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57e
               	mov	x21, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x22]
               	ldr	x10, [sp], #0x10
               	mov	x23, x22
               	sub	x23, x29, #0x18
               	ldrb	w21, [x23]
               	mov	x17, #0x68              // =104
               	eor	x23, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x23, x17
               	cmp	x21, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0x28]
               	cbnz	x23, 0x4009a8 <.text+0x728>
               	sub	x21, x29, #0x18
               	add	x23, x21, #0x4
               	ldrb	w21, [x23]
               	mov	x17, #0x6f              // =111
               	eor	x23, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x23, x17
               	cmp	x21, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0x28]
               	b	0x4009a8 <.text+0x728>
               	ldur	x23, [x29, #-0x28]
               	stur	x23, [x29, #-0x20]
               	cbnz	x23, 0x4009dc <.text+0x75c>
               	sub	x21, x29, #0x18
               	add	x23, x21, #0x5
               	ldrb	w21, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x23, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0x20]
               	b	0x4009dc <.text+0x75c>
               	ldur	x21, [x29, #-0x20]
               	cbz	x21, 0x400a0c <.text+0x78c>
               	mov	x23, #0x6               // =6
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ecb59
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x40708c <exit+0x6508>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f911c
               	tbz	w21, #0x6, 0x3ff0e0
               	<unknown>
               	cbnz	w16, 0x46f088
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400694 <.text+0x414>
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
               	bl	0x400b84 <exit>
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
               	adr	x10, 0x4ecc21
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407154 <exit+0x65d0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f91e4
               	tbz	w21, #0x6, 0x3ff1a8
               	<unknown>
               	cbnz	w16, 0x46f150
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40075c <.text+0x4dc>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<dlsym>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16
