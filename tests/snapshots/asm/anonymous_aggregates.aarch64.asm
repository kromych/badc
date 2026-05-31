
anonymous_aggregates.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003cc <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
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
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400bc8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
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
               	cbz	x15, 0x4003f0 <.text+0x170>
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
               	and	x13, x13, x17
               	cmp	x0, x13
               	b.eq	0x400440 <.text+0x1c0>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x4
               	ldrsw	x13, [x0]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	0x40046c <.text+0x1ec>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldr	w0, [x13]
               	mov	x13, #0xcdef            // =52719
               	movk	x13, #0x90ab, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x0, x13
               	b.eq	0x4004a4 <.text+0x224>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x4
               	ldrsw	x13, [x0]
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x13, x17
               	b.eq	0x4004d0 <.text+0x250>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	mov	x0, #0xbabe             // =47806
               	movk	x0, #0xcafe, lsl #16
               	str	w0, [x13]
               	sub	x15, x29, #0x8
               	add	x15, x15, #0x4
               	mov	x13, #0xf00d            // =61453
               	movk	x13, #0xbad, lsl #16
               	str	w13, [x15]
               	sub	x12, x29, #0x8
               	ldr	w13, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x13, x0
               	b.eq	0x400520 <.text+0x2a0>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldrsw	x0, [x13]
               	mov	x17, #0xf00d            // =61453
               	movk	x17, #0xbad, lsl #16
               	cmp	x0, x17
               	b.eq	0x400550 <.text+0x2d0>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x13, [x0]
               	mov	x17, #0xbabe            // =47806
               	movk	x17, #0xcafe, lsl #16
               	movk	x17, #0xf00d, lsl #32
               	movk	x17, #0xbad, lsl #48
               	cmp	x13, x17
               	b.eq	0x400580 <.text+0x300>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	mov	x0, #0x1                // =1
               	str	w0, [x13]
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x8
               	mov	x0, #0x2a               // =42
               	str	w0, [x12]
               	sub	x13, x29, #0x20
               	add	x13, x13, #0x10
               	mov	x0, #0x63               // =99
               	str	w0, [x13]
               	sub	x12, x29, #0x20
               	ldrsw	x0, [x12]
               	cmp	x0, #0x1
               	b.eq	0x4005d0 <.text+0x350>
               	mov	x12, #0xa               // =10
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	ldrsw	x12, [x0]
               	cmp	x12, #0x2a
               	b.eq	0x4005f4 <.text+0x374>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x10
               	ldrsw	x0, [x12]
               	cmp	x0, #0x63
               	b.eq	0x40061c <.text+0x39c>
               	mov	x12, #0xc               // =12
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	mov	x12, #0x851f            // =34079
               	movk	x12, #0x51eb, lsl #16
               	movk	x12, #0x1eb8, lsl #32
               	movk	x12, #0x4009, lsl #48
               	str	x12, [x0]
               	sub	x13, x29, #0x20
               	ldrsw	x12, [x13]
               	cmp	x12, #0x1
               	b.eq	0x400658 <.text+0x3d8>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x20
               	add	x12, x12, #0x10
               	ldrsw	x0, [x12]
               	cmp	x0, #0x63
               	b.eq	0x400680 <.text+0x400>
               	mov	x12, #0xe               // =14
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x40069c <.text+0x41c>
               	mov	x12, #0x14              // =20
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x12, #0xa               // =10
               	str	w12, [x0]
               	sub	x13, x29, #0x30
               	add	x13, x13, #0x4
               	mov	x12, #0x14              // =20
               	str	w12, [x13]
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x8
               	mov	x12, #0x1e              // =30
               	str	w12, [x0]
               	sub	x13, x29, #0x30
               	add	x13, x13, #0xc
               	mov	x12, #0x28              // =40
               	str	w12, [x13]
               	sub	x0, x29, #0x30
               	ldrsw	x12, [x0]
               	cmp	x12, #0xa
               	b.eq	0x4006f8 <.text+0x478>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x30
               	add	x12, x12, #0x4
               	ldrsw	x0, [x12]
               	cmp	x0, #0x14
               	b.eq	0x400720 <.text+0x4a0>
               	mov	x12, #0x16              // =22
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	add	x0, x0, #0x8
               	ldrsw	x12, [x0]
               	cmp	x12, #0x1e
               	b.eq	0x400744 <.text+0x4c4>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x30
               	add	x12, x12, #0xc
               	ldrsw	x0, [x12]
               	cmp	x0, #0x28
               	b.eq	0x40076c <.text+0x4ec>
               	mov	x12, #0x18              // =24
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	mov	x12, #0x7               // =7
               	str	w12, [x0]
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x4
               	mov	x12, #0x1234            // =4660
               	strh	w12, [x13]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x6
               	mov	x12, #0x5678            // =22136
               	sxth	x12, w12
               	strh	w12, [x0]
               	sub	x13, x29, #0x40
               	add	x13, x13, #0x8
               	mov	x12, #0x9               // =9
               	str	w12, [x13]
               	sub	x0, x29, #0x40
               	ldrsw	x12, [x0]
               	cmp	x12, #0x7
               	b.eq	0x4007cc <.text+0x54c>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x40
               	add	x12, x12, #0x4
               	ldrsh	x0, [x12]
               	mov	x17, #0x1234            // =4660
               	cmp	x0, x17
               	b.eq	0x4007f8 <.text+0x578>
               	mov	x12, #0x1f              // =31
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x6
               	ldrsh	x12, [x0]
               	mov	x0, #0x5678             // =22136
               	sxth	x0, w0
               	cmp	x12, x0
               	b.eq	0x400824 <.text+0x5a4>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x40
               	add	x12, x12, #0x8
               	ldrsw	x0, [x12]
               	cmp	x0, #0x9
               	b.eq	0x40084c <.text+0x5cc>
               	mov	x12, #0x21              // =33
               	mov	x0, x12
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x12, #0x5678            // =22136
               	mov	x17, #0xffff            // =65535
               	and	x12, x12, x17
               	lsl	x12, x12, #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	orr	x0, x0, x12
               	sub	x12, x29, #0x40
               	add	x12, x12, #0x4
               	ldrsw	x13, [x12]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x13, x0
               	b.eq	0x4008b4 <.text+0x634>
               	mov	x0, #0x22               // =34
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x58
               	mov	x0, #0x58               // =88
               	strb	w0, [x13]
               	sub	x12, x29, #0x58
               	add	x12, x12, #0x1
               	mov	x0, #0x61               // =97
               	strb	w0, [x12]
               	sub	x13, x29, #0x58
               	add	x13, x13, #0x2
               	mov	x0, #0x62               // =98
               	strb	w0, [x13]
               	sub	x12, x29, #0x58
               	add	x12, x12, #0x3
               	mov	x0, #0x63               // =99
               	strb	w0, [x12]
               	sub	x13, x29, #0x58
               	add	x13, x13, #0x4
               	mov	x0, #0x64               // =100
               	strb	w0, [x13]
               	sub	x12, x29, #0x58
               	add	x12, x12, #0x8
               	mov	x0, #0xdef0             // =57072
               	movk	x0, #0x9abc, lsl #16
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x1234, lsl #48
               	str	x0, [x12]
               	sub	x13, x29, #0x58
               	ldrb	w0, [x13]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x400954 <.text+0x6d4>
               	mov	x13, #0x28              // =40
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x1
               	ldrb	w13, [x0]
               	mov	x17, #0x61              // =97
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	0x40098c <.text+0x70c>
               	mov	x0, #0x29               // =41
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x58
               	add	x13, x13, #0x2
               	ldrb	w0, [x13]
               	mov	x17, #0x62              // =98
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x4009c8 <.text+0x748>
               	mov	x13, #0x2a              // =42
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x3
               	ldrb	w13, [x0]
               	mov	x17, #0x63              // =99
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	0x400a00 <.text+0x780>
               	mov	x0, #0x2b               // =43
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x58
               	add	x13, x13, #0x4
               	ldrb	w0, [x13]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x400a3c <.text+0x7bc>
               	mov	x13, #0x2c              // =44
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x58
               	add	x0, x0, #0x8
               	ldr	x13, [x0]
               	mov	x17, #0xdef0            // =57072
               	movk	x17, #0x9abc, lsl #16
               	movk	x17, #0x5678, lsl #32
               	movk	x17, #0x1234, lsl #48
               	cmp	x13, x17
               	b.eq	0x400a70 <.text+0x7f0>
               	mov	x0, #0x2d               // =45
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
