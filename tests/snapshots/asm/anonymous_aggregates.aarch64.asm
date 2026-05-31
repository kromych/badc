
anonymous_aggregates.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003d0 <.text+0x150>
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
               	bl	0x400bc8 <dlsym>
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
               	sub	sp, sp, #0x60
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4003f4 <.text+0x174>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x90ab, lsl #16
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	str	x0, [x15]
               	sub	x13, x29, #0x8
               	ldr	w0, [x13]
               	mov	x13, #0xcdef            // =52719
               	movk	x13, #0x90ab, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x13, x17
               	cmp	x0, x15
               	b.eq	0x400440 <.text+0x1c0>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	add	x0, x13, #0x4
               	ldrsw	x13, [x0]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	0x400470 <.text+0x1f0>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	w13, [x0]
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x90ab, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x13, x15
               	b.eq	0x4004a8 <.text+0x228>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x15, x0, #0x4
               	ldrsw	x0, [x15]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	0x4004d4 <.text+0x254>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	mov	x0, #0xbabe             // =47806
               	movk	x0, #0xcafe, lsl #16
               	str	w0, [x15]
               	sub	x13, x29, #0x8
               	add	x15, x13, #0x4
               	mov	x13, #0xf00d            // =61453
               	movk	x13, #0xbad, lsl #16
               	str	w13, [x15]
               	sub	x12, x29, #0x8
               	ldr	w13, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x0, x17
               	cmp	x13, x12
               	b.eq	0x400528 <.text+0x2a8>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x12, x0, #0x4
               	ldrsw	x0, [x12]
               	mov	x17, #0xf00d            // =61453
               	movk	x17, #0xbad, lsl #16
               	cmp	x0, x17
               	b.eq	0x400554 <.text+0x2d4>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x8
               	ldr	x0, [x12]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	movk	x17, #0xf00d, lsl #32
               	movk	x17, #0xbad, lsl #48
               	cmp	x0, x17
               	b.eq	0x400584 <.text+0x304>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x20
               	mov	x0, #0x1                // =1
               	str	w0, [x12]
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x8
               	mov	x13, #0x2a              // =42
               	str	w13, [x0]
               	sub	x12, x29, #0x20
               	add	x13, x12, #0x10
               	mov	x12, #0x63              // =99
               	str	w12, [x13]
               	sub	x0, x29, #0x20
               	ldrsw	x12, [x0]
               	cmp	x12, #0x1
               	b.eq	0x4005d4 <.text+0x354>
               	mov	x12, #0xa               // =10
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x12, x0, #0x8
               	ldrsw	x0, [x12]
               	cmp	x0, #0x2a
               	b.eq	0x4005f8 <.text+0x378>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x20
               	add	x0, x12, #0x10
               	ldrsw	x12, [x0]
               	cmp	x12, #0x63
               	b.eq	0x400620 <.text+0x3a0>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x12, x0, #0x8
               	mov	x0, #0x851f             // =34079
               	movk	x0, #0x51eb, lsl #16
               	movk	x0, #0x1eb8, lsl #32
               	movk	x0, #0x4009, lsl #48
               	str	x0, [x12]
               	sub	x13, x29, #0x20
               	ldrsw	x0, [x13]
               	cmp	x0, #0x1
               	b.eq	0x40065c <.text+0x3dc>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x10
               	ldrsw	x13, [x0]
               	cmp	x13, #0x63
               	b.eq	0x400684 <.text+0x404>
               	mov	x13, #0xe               // =14
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4006a0 <.text+0x420>
               	mov	x13, #0x14              // =20
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x13, #0xa               // =10
               	str	w13, [x0]
               	sub	x12, x29, #0x30
               	add	x13, x12, #0x4
               	mov	x12, #0x14              // =20
               	str	w12, [x13]
               	sub	x0, x29, #0x30
               	add	x12, x0, #0x8
               	mov	x0, #0x1e               // =30
               	str	w0, [x12]
               	sub	x13, x29, #0x30
               	add	x0, x13, #0xc
               	mov	x13, #0x28              // =40
               	str	w13, [x0]
               	sub	x12, x29, #0x30
               	ldrsw	x13, [x12]
               	cmp	x13, #0xa
               	b.eq	0x4006fc <.text+0x47c>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x30
               	add	x0, x12, #0x4
               	ldrsw	x12, [x0]
               	cmp	x12, #0x14
               	b.eq	0x400724 <.text+0x4a4>
               	mov	x12, #0x16              // =22
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	add	x12, x0, #0x8
               	ldrsw	x0, [x12]
               	cmp	x0, #0x1e
               	b.eq	0x400748 <.text+0x4c8>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x30
               	add	x0, x12, #0xc
               	ldrsw	x12, [x0]
               	cmp	x12, #0x28
               	b.eq	0x400770 <.text+0x4f0>
               	mov	x12, #0x18              // =24
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x12, #0x7               // =7
               	str	w12, [x0]
               	sub	x13, x29, #0x40
               	add	x12, x13, #0x4
               	mov	x13, #0x1234            // =4660
               	strh	w13, [x12]
               	sub	x0, x29, #0x40
               	add	x13, x0, #0x6
               	mov	x0, #0x5678             // =22136
               	sxth	x0, w0
               	strh	w0, [x13]
               	sub	x12, x29, #0x40
               	add	x0, x12, #0x8
               	mov	x12, #0x9               // =9
               	str	w12, [x0]
               	sub	x13, x29, #0x40
               	ldrsw	x12, [x13]
               	cmp	x12, #0x7
               	b.eq	0x4007d0 <.text+0x550>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x40
               	add	x0, x13, #0x4
               	ldrsh	x13, [x0]
               	mov	x17, #0x1234            // =4660
               	cmp	x13, x17
               	b.eq	0x4007fc <.text+0x57c>
               	mov	x13, #0x1f              // =31
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	add	x13, x0, #0x6
               	ldrsh	x0, [x13]
               	mov	x13, #0x5678            // =22136
               	sxth	x13, w13
               	cmp	x0, x13
               	b.eq	0x400828 <.text+0x5a8>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x40
               	add	x0, x12, #0x8
               	ldrsw	x12, [x0]
               	cmp	x12, #0x9
               	b.eq	0x400850 <.text+0x5d0>
               	mov	x12, #0x21              // =33
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	mov	x17, #0xffff            // =65535
               	and	x12, x0, x17
               	mov	x0, #0x5678             // =22136
               	mov	x17, #0xffff            // =65535
               	and	x13, x0, x17
               	lsl	x0, x13, #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	orr	x0, x12, x13
               	sub	x13, x29, #0x40
               	add	x12, x13, #0x4
               	ldrsw	x13, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x12, x13
               	b.eq	0x4008bc <.text+0x63c>
               	mov	x13, #0x22              // =34
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	mov	x13, #0x58              // =88
               	strb	w13, [x0]
               	sub	x12, x29, #0x58
               	add	x13, x12, #0x1
               	mov	x12, #0x61              // =97
               	strb	w12, [x13]
               	sub	x0, x29, #0x58
               	add	x12, x0, #0x2
               	mov	x0, #0x62               // =98
               	strb	w0, [x12]
               	sub	x13, x29, #0x58
               	add	x0, x13, #0x3
               	mov	x13, #0x63              // =99
               	strb	w13, [x0]
               	sub	x12, x29, #0x58
               	add	x13, x12, #0x4
               	mov	x12, #0x64              // =100
               	strb	w12, [x13]
               	sub	x0, x29, #0x58
               	add	x12, x0, #0x8
               	mov	x0, #0xdef0             // =57072
               	movk	x0, #0x9abc, lsl #16
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	str	x0, [x12]
               	sub	x13, x29, #0x58
               	ldrb	w0, [x13]
               	mov	x17, #0x58              // =88
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400958 <.text+0x6d8>
               	mov	x0, #0x28               // =40
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x58
               	add	x0, x13, #0x1
               	ldrb	w13, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x400994 <.text+0x714>
               	mov	x13, #0x29              // =41
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x13, x0, #0x2
               	ldrb	w0, [x13]
               	mov	x17, #0x62              // =98
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x4009cc <.text+0x74c>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x58
               	add	x0, x13, #0x3
               	ldrb	w13, [x0]
               	mov	x17, #0x63              // =99
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x400a08 <.text+0x788>
               	mov	x13, #0x2b              // =43
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x13, x0, #0x4
               	ldrb	w0, [x13]
               	mov	x17, #0x64              // =100
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400a40 <.text+0x7c0>
               	mov	x0, #0x2c               // =44
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x58
               	add	x0, x13, #0x8
               	ldr	x13, [x0]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	movk	x17, #0x5678, lsl #32
               	movk	x17, #0x1234, lsl #48
               	cmp	x13, x17
               	b.eq	0x400a78 <.text+0x7f8>
               	mov	x13, #0x2d              // =45
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ecbad
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4070e0 <exit+0x650c>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9170
               	tbz	w21, #0x6, 0x3ff134
               	<unknown>
               	cbnz	w16, 0x46f0dc
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4006e8 <.text+0x468>
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
               	bl	0x400bd4 <exit>
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
               	adr	x10, 0x4ecc71
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4071a4 <exit+0x65d0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9234
               	tbz	w21, #0x6, 0x3ff1f8
               	<unknown>
               	cbnz	w16, 0x46f1a0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4007ac <.text+0x52c>
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
