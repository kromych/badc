
zero_sign_extension_32bit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40048c <.text+0x14c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x100]
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
               	add	x19, x19, #0x110
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x4003cc <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	add	x19, x19, #0x128
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x135
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x401378 <dlsym>
               	cbz	x0, 0x400454 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400454 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	sub	sp, sp, #0x160
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	sxtw	x21, w20
               	b	0x4004d8 <.text+0x198>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	0x400558 <.text+0x218>
               	b	0x400508 <.text+0x1c8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4004d8 <.text+0x198>
               	b	0x40055c <.text+0x21c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x12, x19
               	mov	x22, #0x1               // =1
               	str	w22, [x12]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x168
               	mov	x25, x19
               	mov	x23, #0x1b              // =27
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400558 <.text+0x218>
               	b	0x4004fc <.text+0x1bc>
               	sxtw	x0, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4005f0 <.text+0x2b0>
               	b	0x4005a4 <.text+0x264>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40055c <.text+0x21c>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x24, x17
               	b	0x4005f4 <.text+0x2b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x23, x19
               	mov	x26, #0x2               // =2
               	str	w26, [x23]
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x17e
               	mov	x21, x19
               	mov	x23, #0x1c              // =28
               	mov	x0, x27
               	mov	x3, x26
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4005f0 <.text+0x2b0>
               	b	0x400584 <.text+0x244>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x25, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x40066c <.text+0x32c>
               	b	0x40061c <.text+0x2dc>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4005f4 <.text+0x2b4>
               	b	0x400670 <.text+0x330>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x23, #0x3               // =3
               	str	w23, [x21]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x194
               	mov	x21, x19
               	mov	x20, #0x20              // =32
               	mov	x0, x27
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x21
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x40066c <.text+0x32c>
               	b	0x400610 <.text+0x2d0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400714 <.text+0x3d4>
               	b	0x4006c4 <.text+0x384>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400670 <.text+0x330>
               	mov	x27, #0xfff9            // =65529
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	sxtw	x26, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	b	0x400718 <.text+0x3d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x22, #0x4               // =4
               	str	w22, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1aa
               	mov	x20, x19
               	mov	x26, #0x21              // =33
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400714 <.text+0x3d4>
               	b	0x400698 <.text+0x358>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4007ac <.text+0x46c>
               	b	0x40075c <.text+0x41c>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400718 <.text+0x3d8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	sxtw	x26, w26
               	b	0x4007b0 <.text+0x470>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x21, #0xa               // =10
               	str	w21, [x20]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x20, x19
               	mov	x24, #0x28              // =40
               	mov	x0, x25
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4007ac <.text+0x46c>
               	b	0x400740 <.text+0x400>
               	sxtw	x24, w26
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400844 <.text+0x504>
               	b	0x4007f4 <.text+0x4b4>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x4007b0 <.text+0x470>
               	sxtw	x27, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	b	0x400848 <.text+0x508>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	mov	x23, #0xb               // =11
               	str	w23, [x0]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d6
               	mov	x22, x19
               	mov	x24, #0x2a              // =42
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x22
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400844 <.text+0x504>
               	b	0x4007d8 <.text+0x498>
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x27, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4008dc <.text+0x59c>
               	b	0x40088c <.text+0x54c>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400848 <.text+0x508>
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	mov	x24, #0xbb8             // =3000
               	sxtw	x0, w0
               	sxtw	x24, w24
               	mul	x0, x0, x24
               	sxtw	x20, w0
               	b	0x4008e0 <.text+0x5a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	mov	x21, #0xc               // =12
               	str	w21, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ec
               	mov	x26, x19
               	mov	x24, #0x30              // =48
               	mov	x0, x25
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4008dc <.text+0x59c>
               	b	0x400864 <.text+0x524>
               	sxtw	x0, w20
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400964 <.text+0x624>
               	b	0x400914 <.text+0x5d4>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4008e0 <.text+0x5a0>
               	b	0x400968 <.text+0x628>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x24, #0x14              // =20
               	str	w24, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x27, x19
               	mov	x22, #0x3a              // =58
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400964 <.text+0x624>
               	b	0x400908 <.text+0x5c8>
               	sxtw	x0, w20
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400a18 <.text+0x6d8>
               	b	0x4009c8 <.text+0x688>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400968 <.text+0x628>
               	mov	x0, #0x10000            // =65536
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mul	x25, x25, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	b	0x400a1c <.text+0x6dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x21, #0x15              // =21
               	str	w21, [x22]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x218
               	mov	x22, x19
               	mov	x25, #0x3b              // =59
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x22
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400a18 <.text+0x6d8>
               	b	0x400990 <.text+0x650>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400a98 <.text+0x758>
               	b	0x400a48 <.text+0x708>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400a1c <.text+0x6dc>
               	b	0x400a9c <.text+0x75c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x24, #0x16              // =22
               	str	w24, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22e
               	mov	x20, x19
               	mov	x26, #0x40              // =64
               	mov	x0, x22
               	mov	x3, x24
               	mov	x2, x26
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400a98 <.text+0x758>
               	b	0x400a3c <.text+0x6fc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400b2c <.text+0x7ec>
               	b	0x400adc <.text+0x79c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x400a9c <.text+0x75c>
               	mov	x0, #0x80000000         // =2147483648
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsr	x24, x0, #1
               	b	0x400b30 <.text+0x7f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	mov	x21, #0x17              // =23
               	str	w21, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x244
               	mov	x26, x19
               	mov	x27, #0x41              // =65
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400b2c <.text+0x7ec>
               	b	0x400abc <.text+0x77c>
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x24, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400bc8 <.text+0x888>
               	b	0x400b78 <.text+0x838>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400b30 <.text+0x7f0>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	lsl	x0, x0, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	b	0x400bcc <.text+0x88c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x25, x19
               	mov	x27, #0x1e              // =30
               	str	w27, [x25]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x25a
               	mov	x25, x19
               	mov	x22, #0x4a              // =74
               	mov	x0, x26
               	mov	x3, x27
               	mov	x2, x22
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400bc8 <.text+0x888>
               	b	0x400b48 <.text+0x808>
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	cmp	x21, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400c74 <.text+0x934>
               	b	0x400c24 <.text+0x8e4>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400bcc <.text+0x88c>
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x0, x17
               	b	0x400c78 <.text+0x938>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x22, #0x1f              // =31
               	str	w22, [x24]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x270
               	mov	x24, x19
               	mov	x20, #0x4f              // =79
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x24
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400c74 <.text+0x934>
               	b	0x400be8 <.text+0x8a8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x27, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400d0c <.text+0x9cc>
               	b	0x400cbc <.text+0x97c>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400c78 <.text+0x938>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29c
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x401390 <atoi>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400d10 <.text+0x9d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x20, #0x20              // =32
               	str	w20, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x286
               	mov	x21, x19
               	mov	x26, #0x54              // =84
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400d0c <.text+0x9cc>
               	b	0x400c94 <.text+0x954>
               	sxtw	x22, w25
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400d94 <.text+0xa54>
               	b	0x400d44 <.text+0xa04>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400d10 <.text+0x9d0>
               	b	0x400d98 <.text+0xa58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x26, #0x28              // =40
               	str	w26, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a8
               	mov	x27, x19
               	mov	x22, #0x5d              // =93
               	mov	x0, x21
               	mov	x3, x26
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400d94 <.text+0xa54>
               	b	0x400d38 <.text+0x9f8>
               	sxtw	x0, w25
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400e50 <.text+0xb10>
               	b	0x400e00 <.text+0xac0>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400d98 <.text+0xa58>
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	sxtw	x25, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	add	x25, x25, x22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	b	0x400e54 <.text+0xb14>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x20, #0x29              // =41
               	str	w20, [x22]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2be
               	mov	x22, x19
               	mov	x24, #0x5e              // =94
               	mov	x0, x27
               	mov	x3, x20
               	mov	x2, x24
               	mov	x1, x22
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400e50 <.text+0xb10>
               	b	0x400dc0 <.text+0xa80>
               	cmp	x25, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400ee4 <.text+0xba4>
               	b	0x400e94 <.text+0xb54>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400e54 <.text+0xb14>
               	sxtw	x26, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	sub	x26, x26, x21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	b	0x400ee8 <.text+0xba8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x24, #0x32              // =50
               	str	w24, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d4
               	mov	x27, x19
               	mov	x22, #0x68              // =104
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400ee4 <.text+0xba4>
               	b	0x400e68 <.text+0xb28>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x26, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400f68 <.text+0xc28>
               	b	0x400f18 <.text+0xbd8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400ee8 <.text+0xba8>
               	mov	x27, #0x5678            // =22136
               	movk	x27, #0x1234, lsl #16
               	b	0x400f6c <.text+0xc2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x23, #0x33              // =51
               	str	w23, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2ea
               	mov	x22, x19
               	mov	x21, #0x6c              // =108
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400f68 <.text+0xc28>
               	b	0x400f04 <.text+0xbc4>
               	sxtw	x21, w27
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400fec <.text+0xcac>
               	b	0x400f9c <.text+0xc5c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400f6c <.text+0xc2c>
               	sxtw	x27, w27
               	b	0x400ff0 <.text+0xcb0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	mov	x28, #0x3c              // =60
               	str	w28, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x300
               	mov	x26, x19
               	mov	x21, #0x73              // =115
               	mov	x0, x22
               	mov	x3, x28
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400fec <.text+0xcac>
               	b	0x400f8c <.text+0xc4c>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x27, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x40107c <.text+0xd3c>
               	b	0x40102c <.text+0xcec>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400ff0 <.text+0xcb0>
               	mov	x28, #0x6c00            // =27648
               	movk	x28, #0x88ca, lsl #16
               	movk	x28, #0xffff, lsl #32
               	movk	x28, #0xffff, lsl #48
               	sxtw	x22, w28
               	b	0x401080 <.text+0xd40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	mov	x23, #0x3d              // =61
               	str	w23, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x316
               	mov	x25, x19
               	mov	x21, #0x75              // =117
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x40107c <.text+0xd3c>
               	b	0x40100c <.text+0xccc>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401100 <.text+0xdc0>
               	b	0x4010b0 <.text+0xd70>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401080 <.text+0xd40>
               	b	0x401104 <.text+0xdc4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x25, x19
               	mov	x21, #0x3e              // =62
               	str	w21, [x25]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32c
               	mov	x25, x19
               	mov	x27, #0x7a              // =122
               	mov	x0, x26
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x401100 <.text+0xdc0>
               	b	0x4010a4 <.text+0xd64>
               	sxtw	x0, w28
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4011a0 <.text+0xe60>
               	b	0x401150 <.text+0xe10>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401104 <.text+0xdc4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	ldrsw	x23, [x0]
               	cmp	x23, #0x0
               	b.ne	0x4011f4 <.text+0xeb4>
               	b	0x4011a4 <.text+0xe64>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x20, #0x3f              // =63
               	str	w20, [x27]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x342
               	mov	x27, x19
               	mov	x23, #0x7b              // =123
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x27
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4011a0 <.text+0xe60>
               	b	0x40112c <.text+0xdec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x358
               	mov	x26, x19
               	mov	x0, x26
               	bl	0x40139c <printf>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	ldrsw	x0, [x26]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	ldr	x19, [sp, #0x50]
               	add	sp, sp, #0x160
               	ldp	x29, x30, [sp], #0x10
               	ret
