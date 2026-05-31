
zero_sign_extension_32bit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400488 <.text+0x148>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x4003cc <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	add	x19, x19, #0x128
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x135
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x401378 <dlsym>
               	cbz	x0, 0x400454 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400454 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
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
               	b	0x4004d4 <.text+0x194>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	0x400554 <.text+0x214>
               	b	0x400504 <.text+0x1c4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4004d4 <.text+0x194>
               	b	0x400558 <.text+0x218>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x13, x19
               	mov	x22, #0x1               // =1
               	str	w22, [x13]
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
               	b	0x400554 <.text+0x214>
               	b	0x4004f8 <.text+0x1b8>
               	sxtw	x0, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4005ec <.text+0x2ac>
               	b	0x4005a0 <.text+0x260>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400558 <.text+0x218>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x24, x17
               	b	0x4005f0 <.text+0x2b0>
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
               	b	0x4005ec <.text+0x2ac>
               	b	0x400580 <.text+0x240>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x25, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400668 <.text+0x328>
               	b	0x400618 <.text+0x2d8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4005f0 <.text+0x2b0>
               	b	0x40066c <.text+0x32c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x23, #0x3               // =3
               	str	w23, [x20]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x194
               	mov	x20, x19
               	mov	x21, #0x20              // =32
               	mov	x0, x27
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400668 <.text+0x328>
               	b	0x40060c <.text+0x2cc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400710 <.text+0x3d0>
               	b	0x4006c0 <.text+0x380>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40066c <.text+0x32c>
               	mov	x27, #0xfff9            // =65529
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	sxtw	x26, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x26, x17
               	b	0x400714 <.text+0x3d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x22, #0x4               // =4
               	str	w22, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1aa
               	mov	x21, x19
               	mov	x26, #0x21              // =33
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400710 <.text+0x3d0>
               	b	0x400694 <.text+0x354>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x20, x17
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x26, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x4007a8 <.text+0x468>
               	b	0x400758 <.text+0x418>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400714 <.text+0x3d4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	sxtw	x23, w0
               	b	0x4007ac <.text+0x46c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x24, #0xa               // =10
               	str	w24, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x26, #0x28              // =40
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4007a8 <.text+0x468>
               	b	0x40073c <.text+0x3fc>
               	sxtw	x26, w23
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400840 <.text+0x500>
               	b	0x4007f0 <.text+0x4b0>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x4007ac <.text+0x46c>
               	sxtw	x0, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	b	0x400844 <.text+0x504>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x22, #0xb               // =11
               	str	w22, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d6
               	mov	x20, x19
               	mov	x26, #0x2a              // =42
               	mov	x0, x21
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400840 <.text+0x500>
               	b	0x4007d4 <.text+0x494>
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4008d8 <.text+0x598>
               	b	0x400888 <.text+0x548>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400844 <.text+0x504>
               	mov	x0, #0x4240             // =16960
               	movk	x0, #0xf, lsl #16
               	mov	x23, #0xbb8             // =3000
               	sxtw	x24, w0
               	sxtw	x0, w23
               	mul	x23, x24, x0
               	sxtw	x21, w23
               	b	0x4008dc <.text+0x59c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	mov	x26, #0xc               // =12
               	str	w26, [x0]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ec
               	mov	x25, x19
               	mov	x23, #0x30              // =48
               	mov	x0, x27
               	mov	x3, x26
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4008d8 <.text+0x598>
               	b	0x400860 <.text+0x520>
               	sxtw	x0, w21
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400960 <.text+0x620>
               	b	0x400910 <.text+0x5d0>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4008dc <.text+0x59c>
               	b	0x400964 <.text+0x624>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x23, #0x14              // =20
               	str	w23, [x24]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x24, x19
               	mov	x20, #0x3a              // =58
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x24
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400960 <.text+0x620>
               	b	0x400904 <.text+0x5c4>
               	sxtw	x0, w21
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400a14 <.text+0x6d4>
               	b	0x4009c4 <.text+0x684>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x400964 <.text+0x624>
               	mov	x0, #0x10000            // =65536
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	mul	x0, x27, x21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	b	0x400a18 <.text+0x6d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x26, #0x15              // =21
               	str	w26, [x20]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x218
               	mov	x20, x19
               	mov	x27, #0x3b              // =59
               	mov	x0, x24
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400a14 <.text+0x6d4>
               	b	0x40098c <.text+0x64c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x400a94 <.text+0x754>
               	b	0x400a44 <.text+0x704>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400a18 <.text+0x6d8>
               	b	0x400a98 <.text+0x758>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x21, #0x16              // =22
               	str	w21, [x27]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22e
               	mov	x27, x19
               	mov	x25, #0x40              // =64
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x27
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400a94 <.text+0x754>
               	b	0x400a38 <.text+0x6f8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x400b28 <.text+0x7e8>
               	b	0x400ad8 <.text+0x798>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400a98 <.text+0x758>
               	mov	x0, #0x80000000         // =2147483648
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x0, x17
               	lsr	x21, x24, #1
               	b	0x400b2c <.text+0x7ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x25, x19
               	mov	x26, #0x17              // =23
               	str	w26, [x25]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x244
               	mov	x25, x19
               	mov	x24, #0x41              // =65
               	mov	x0, x27
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400b28 <.text+0x7e8>
               	b	0x400ab8 <.text+0x778>
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x21, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400bc4 <.text+0x884>
               	b	0x400b74 <.text+0x834>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400b2c <.text+0x7ec>
               	mov	x0, #0x5678             // =22136
               	movk	x0, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x0, x17
               	lsl	x0, x23, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x0, x17
               	b	0x400bc8 <.text+0x888>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x20, #0x1e              // =30
               	str	w20, [x24]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x25a
               	mov	x24, x19
               	mov	x23, #0x4a              // =74
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400bc4 <.text+0x884>
               	b	0x400b44 <.text+0x804>
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	cmp	x26, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400c70 <.text+0x930>
               	b	0x400c20 <.text+0x8e0>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400bc8 <.text+0x888>
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x0, x17
               	b	0x400c74 <.text+0x934>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	mov	x23, #0x1f              // =31
               	str	w23, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x270
               	mov	x27, x19
               	mov	x21, #0x4f              // =79
               	mov	x0, x24
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x27
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400c70 <.text+0x930>
               	b	0x400be4 <.text+0x8a4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400d08 <.text+0x9c8>
               	b	0x400cb8 <.text+0x978>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400c74 <.text+0x934>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29c
               	mov	x23, x19
               	mov	x0, x23
               	bl	0x401390 <atoi>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x400d0c <.text+0x9cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	mov	x21, #0x20              // =32
               	str	w21, [x0]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x286
               	mov	x25, x19
               	mov	x26, #0x54              // =84
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400d08 <.text+0x9c8>
               	b	0x400c90 <.text+0x950>
               	sxtw	x23, w24
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x23, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400d90 <.text+0xa50>
               	b	0x400d40 <.text+0xa00>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400d0c <.text+0x9cc>
               	b	0x400d94 <.text+0xa54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x26, #0x28              // =40
               	str	w26, [x20]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a8
               	mov	x20, x19
               	mov	x23, #0x5d              // =93
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x23
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400d90 <.text+0xa50>
               	b	0x400d34 <.text+0x9f4>
               	sxtw	x0, w24
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x400e4c <.text+0xb0c>
               	b	0x400dfc <.text+0xabc>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x400d94 <.text+0xa54>
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	sxtw	x24, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x25, x17
               	add	x20, x24, x23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x20, x17
               	b	0x400e50 <.text+0xb10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x23, x19
               	mov	x21, #0x29              // =41
               	str	w21, [x23]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2be
               	mov	x23, x19
               	mov	x27, #0x5e              // =94
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x23
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400e4c <.text+0xb0c>
               	b	0x400dbc <.text+0xa7c>
               	cmp	x27, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400ee0 <.text+0xba0>
               	b	0x400e90 <.text+0xb50>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400e50 <.text+0xb10>
               	sxtw	x0, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	sub	x25, x0, x24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	b	0x400ee4 <.text+0xba4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x23, #0x32              // =50
               	str	w23, [x20]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d4
               	mov	x20, x19
               	mov	x24, #0x68              // =104
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x20
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400ee0 <.text+0xba0>
               	b	0x400e64 <.text+0xb24>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x22, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x400f64 <.text+0xc24>
               	b	0x400f14 <.text+0xbd4>
               	mov	x28, #0x0               // =0
               	cbnz	x28, 0x400ee4 <.text+0xba4>
               	mov	x20, #0x5678            // =22136
               	movk	x20, #0x1234, lsl #16
               	b	0x400f68 <.text+0xc28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x25, x19
               	mov	x24, #0x33              // =51
               	str	w24, [x25]
               	mov	x28, #0x2               // =2
               	mov	x0, x28
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2ea
               	mov	x25, x19
               	mov	x28, #0x6c              // =108
               	mov	x0, x27
               	mov	x3, x24
               	mov	x2, x28
               	mov	x1, x25
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400f64 <.text+0xc24>
               	b	0x400f00 <.text+0xbc0>
               	sxtw	x28, w20
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x28, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400fe8 <.text+0xca8>
               	b	0x400f98 <.text+0xc58>
               	mov	x28, #0x0               // =0
               	cbnz	x28, 0x400f68 <.text+0xc28>
               	sxtw	x24, w20
               	b	0x400fec <.text+0xcac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x26, #0x3c              // =60
               	str	w26, [x22]
               	mov	x28, #0x2               // =2
               	mov	x0, x28
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x300
               	mov	x22, x19
               	mov	x28, #0x73              // =115
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x28
               	mov	x1, x22
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x400fe8 <.text+0xca8>
               	b	0x400f88 <.text+0xc48>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x24, x17
               	cset	x28, eq
               	cmp	x28, #0x0
               	b.ne	0x401078 <.text+0xd38>
               	b	0x401028 <.text+0xce8>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400fec <.text+0xcac>
               	mov	x26, #0x6c00            // =27648
               	movk	x26, #0x88ca, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	sxtw	x25, w26
               	b	0x40107c <.text+0xd3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x28, x19
               	mov	x27, #0x3d              // =61
               	str	w27, [x28]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x316
               	mov	x28, x19
               	mov	x20, #0x75              // =117
               	mov	x0, x22
               	mov	x3, x27
               	mov	x2, x20
               	mov	x1, x28
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x401078 <.text+0xd38>
               	b	0x401008 <.text+0xcc8>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x25, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4010fc <.text+0xdbc>
               	b	0x4010ac <.text+0xd6c>
               	mov	x28, #0x0               // =0
               	cbnz	x28, 0x40107c <.text+0xd3c>
               	b	0x401100 <.text+0xdc0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x20, #0x3e              // =62
               	str	w20, [x24]
               	mov	x28, #0x2               // =2
               	mov	x0, x28
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32c
               	mov	x24, x19
               	mov	x28, #0x7a              // =122
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x28
               	mov	x1, x24
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x4010fc <.text+0xdbc>
               	b	0x4010a0 <.text+0xd60>
               	sxtw	x0, w26
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x28, eq
               	cmp	x28, #0x0
               	b.ne	0x40119c <.text+0xe5c>
               	b	0x40114c <.text+0xe0c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401100 <.text+0xdc0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	ldrsw	x27, [x0]
               	cmp	x27, #0x0
               	b.ne	0x4011f0 <.text+0xeb0>
               	b	0x4011a0 <.text+0xe60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x28, x19
               	mov	x21, #0x3f              // =63
               	str	w21, [x28]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x342
               	mov	x28, x19
               	mov	x27, #0x7b              // =123
               	mov	x0, x25
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x28
               	bl	0x401384 <fprintf>
               	sxtw	x0, w0
               	b	0x40119c <.text+0xe5c>
               	b	0x401128 <.text+0xde8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x358
               	mov	x22, x19
               	mov	x0, x22
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
               	mov	x22, x19
               	ldrsw	x0, [x22]
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
