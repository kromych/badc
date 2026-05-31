
c99_arith_common_width.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400450 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
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
               	add	x19, x19, #0x108
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x126
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400be8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400418 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	add	x15, x14, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x15, x17
               	b	0x4004a8 <.text+0x1a8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x20, x17
               	cmp	x15, #0x0
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	0x400548 <.text+0x248>
               	b	0x4004f4 <.text+0x1f4>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4004a8 <.text+0x1a8>
               	mov	x10, #0x0               // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x10, x17
               	sub	x10, x22, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x10, x17
               	b	0x40054c <.text+0x24c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x13, x19
               	mov	x21, #0x1               // =1
               	str	w21, [x13]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x22, #0x1a              // =26
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x10, x0
               	b	0x400548 <.text+0x248>
               	b	0x4004c8 <.text+0x1c8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x10, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400604 <.text+0x304>
               	b	0x4005b4 <.text+0x2b4>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x40054c <.text+0x24c>
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	sxtw	x25, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x20, x17
               	sub	x20, x25, x21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	b	0x400608 <.text+0x308>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x2               // =2
               	str	w22, [x20]
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x176
               	mov	x24, x19
               	mov	x20, #0x21              // =33
               	mov	x0, x26
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x24
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x400604 <.text+0x304>
               	b	0x400574 <.text+0x274>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x23, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4006c4 <.text+0x3c4>
               	b	0x400670 <.text+0x370>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400608 <.text+0x308>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	sxtw	x23, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x20, x17
               	mul	x20, x23, x22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x20, x17
               	b	0x4006c8 <.text+0x3c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x21, #0x3               // =3
               	str	w21, [x25]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18c
               	mov	x25, x19
               	mov	x20, #0x29              // =41
               	mov	x0, x24
               	mov	x3, x21
               	mov	x2, x20
               	mov	x1, x25
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x4006c4 <.text+0x3c4>
               	b	0x400630 <.text+0x330>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x400764 <.text+0x464>
               	b	0x400710 <.text+0x410>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4006c8 <.text+0x3c8>
               	mov	x21, #0xc350            // =50000
               	mov	x17, #0xffff            // =65535
               	and	x20, x21, x17
               	mul	x21, x20, x20
               	sxtw	x24, w21
               	b	0x400768 <.text+0x468>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x22, #0x4               // =4
               	str	w22, [x23]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a2
               	mov	x23, x19
               	mov	x20, #0x31              // =49
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x23
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x400764 <.text+0x464>
               	b	0x4006f0 <.text+0x3f0>
               	mov	x17, #0xf900            // =63744
               	movk	x17, #0x9502, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400820 <.text+0x520>
               	b	0x4007cc <.text+0x4cc>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400768 <.text+0x468>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x26, #0x1               // =1
               	sxtw	x24, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x26, x17
               	add	x26, x24, x22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x26, x17
               	b	0x400824 <.text+0x524>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x21, #0x5               // =5
               	str	w21, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	mov	x26, #0x3e              // =62
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x20
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x400820 <.text+0x520>
               	b	0x40078c <.text+0x48c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x25, x17
               	cmp	x26, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4008b8 <.text+0x5b8>
               	b	0x400864 <.text+0x564>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400824 <.text+0x524>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	0x4008bc <.text+0x5bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x22, #0x64              // =100
               	str	w22, [x24]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ce
               	mov	x24, x19
               	mov	x26, #0x4b              // =75
               	mov	x0, x20
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x24
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x4008b8 <.text+0x5b8>
               	b	0x400844 <.text+0x544>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x21, x17
               	cmp	x23, x25
               	cset	x24, lt
               	cmp	x24, #0x0
               	b.ne	0x400954 <.text+0x654>
               	b	0x400900 <.text+0x600>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4008bc <.text+0x5bc>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	b	0x400958 <.text+0x658>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x26, #0x65              // =101
               	str	w26, [x24]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e4
               	mov	x24, x19
               	mov	x25, #0x54              // =84
               	mov	x0, x20
               	mov	x3, x26
               	mov	x2, x25
               	mov	x1, x24
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x9, x0
               	b	0x400954 <.text+0x654>
               	b	0x4008dc <.text+0x5dc>
               	sxtw	x21, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x27, x17
               	eor	x24, x21, x23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x24, x17
               	cmp	x23, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400a04 <.text+0x704>
               	b	0x4009b0 <.text+0x6b0>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400958 <.text+0x658>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	ldrsw	x23, [x26]
               	cmp	x23, #0x0
               	b.ne	0x400a5c <.text+0x75c>
               	b	0x400a08 <.text+0x708>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x25, #0x66              // =102
               	str	w25, [x24]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1fa
               	mov	x24, x19
               	mov	x23, #0x5d              // =93
               	mov	x0, x21
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x400bf4 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x400a04 <.text+0x704>
               	b	0x40098c <.text+0x68c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x210
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x400c00 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x0               // =0
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	ldrsw	x26, [x20]
               	mov	x0, x26
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ecbc5
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4070f8 <exit+0x64ec>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9188
               	tbz	w21, #0x6, 0x3ff14c
               	<unknown>
               	cbnz	w16, 0x46f0f4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400700 <.text+0x400>
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
               	bl	0x400c0c <exit>
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
               	adr	x10, 0x4ecc91
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4071c4 <exit+0x65b8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9254
               	tbz	w21, #0x6, 0x3ff218
               	<unknown>
               	cbnz	w16, 0x46f1c0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4007cc <.text+0x4cc>
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

<fprintf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
               	br	x16
