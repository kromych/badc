
zero_sign_extension_32bit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400490 <.text+0x150>
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
               	bl	0x4013e8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x400458 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400458 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
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
               	b	0x4004dc <.text+0x19c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	0x400560 <.text+0x220>
               	b	0x40050c <.text+0x1cc>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4004dc <.text+0x19c>
               	b	0x400564 <.text+0x224>
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
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x9, x0
               	b	0x400560 <.text+0x220>
               	b	0x400500 <.text+0x1c0>
               	sxtw	x9, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x9, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4005fc <.text+0x2bc>
               	b	0x4005ac <.text+0x26c>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400564 <.text+0x224>
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	b	0x400600 <.text+0x2c0>
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
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x4005fc <.text+0x2bc>
               	b	0x40058c <.text+0x24c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x40067c <.text+0x33c>
               	b	0x400628 <.text+0x2e8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400600 <.text+0x2c0>
               	b	0x400680 <.text+0x340>
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
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x40067c <.text+0x33c>
               	b	0x40061c <.text+0x2dc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x22, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400728 <.text+0x3e8>
               	b	0x4006d4 <.text+0x394>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400680 <.text+0x340>
               	mov	x20, #0xfff9            // =65529
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	sxtw	x22, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x22, x17
               	b	0x40072c <.text+0x3ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x26, #0x4               // =4
               	str	w26, [x21]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1aa
               	mov	x21, x19
               	mov	x22, #0x21              // =33
               	mov	x0, x24
               	mov	x3, x26
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x27, x0
               	b	0x400728 <.text+0x3e8>
               	b	0x4006a8 <.text+0x368>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x27, x17
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x22, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x4007c4 <.text+0x484>
               	b	0x400770 <.text+0x430>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40072c <.text+0x3ec>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x27, x17
               	sxtw	x26, w23
               	b	0x4007c8 <.text+0x488>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x25, #0xa               // =10
               	str	w25, [x21]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c0
               	mov	x21, x19
               	mov	x22, #0x28              // =40
               	mov	x0, x24
               	mov	x3, x25
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4007c4 <.text+0x484>
               	b	0x400754 <.text+0x414>
               	sxtw	x22, w26
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x400860 <.text+0x520>
               	b	0x40080c <.text+0x4cc>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4007c8 <.text+0x488>
               	sxtw	x25, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	b	0x400864 <.text+0x524>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x23, #0xb               // =11
               	str	w23, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d6
               	mov	x27, x19
               	mov	x22, #0x2a              // =42
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400860 <.text+0x520>
               	b	0x4007f0 <.text+0x4b0>
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4008fc <.text+0x5bc>
               	b	0x4008a8 <.text+0x568>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400864 <.text+0x524>
               	mov	x21, #0x4240            // =16960
               	movk	x21, #0xf, lsl #16
               	mov	x26, #0xbb8             // =3000
               	sxtw	x24, w21
               	sxtw	x21, w26
               	mul	x26, x24, x21
               	sxtw	x27, w26
               	b	0x400900 <.text+0x5c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x25, x19
               	mov	x22, #0xc               // =12
               	str	w22, [x25]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ec
               	mov	x25, x19
               	mov	x26, #0x30              // =48
               	mov	x0, x20
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x25
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x4008fc <.text+0x5bc>
               	b	0x400880 <.text+0x540>
               	sxtw	x21, w27
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400988 <.text+0x648>
               	b	0x400934 <.text+0x5f4>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400900 <.text+0x5c0>
               	b	0x40098c <.text+0x64c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x26, #0x14              // =20
               	str	w26, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x24, x19
               	mov	x21, #0x3a              // =58
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x400988 <.text+0x648>
               	b	0x400928 <.text+0x5e8>
               	sxtw	x22, w27
               	mov	x17, #0x5e00            // =24064
               	movk	x17, #0xb2d0, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400a40 <.text+0x700>
               	b	0x4009ec <.text+0x6ac>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40098c <.text+0x64c>
               	mov	x26, #0x10000           // =65536
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x26, x17
               	mul	x26, x22, x27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x26, x17
               	b	0x400a44 <.text+0x704>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x20, #0x15              // =21
               	str	w20, [x21]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x218
               	mov	x21, x19
               	mov	x22, #0x3b              // =59
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x400a40 <.text+0x700>
               	b	0x4009b4 <.text+0x674>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x25, x17
               	cmp	x26, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400ac4 <.text+0x784>
               	b	0x400a70 <.text+0x730>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400a44 <.text+0x704>
               	b	0x400ac8 <.text+0x788>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x27, #0x16              // =22
               	str	w27, [x22]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400358 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22e
               	mov	x22, x19
               	mov	x26, #0x40              // =64
               	mov	x0, x21
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x400ac4 <.text+0x784>
               	b	0x400a64 <.text+0x724>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x25, x17
               	cmp	x20, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400b5c <.text+0x81c>
               	b	0x400b08 <.text+0x7c8>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400ac8 <.text+0x788>
               	mov	x27, #0x80000000        // =2147483648
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x27, x17
               	lsr	x21, x20, #1
               	b	0x400b60 <.text+0x820>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	mov	x24, #0x17              // =23
               	str	w24, [x26]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x244
               	mov	x26, x19
               	mov	x20, #0x41              // =65
               	mov	x0, x22
               	mov	x3, x24
               	mov	x2, x20
               	mov	x1, x26
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x27, x0
               	b	0x400b5c <.text+0x81c>
               	b	0x400ae8 <.text+0x7a8>
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x21, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400bfc <.text+0x8bc>
               	b	0x400ba8 <.text+0x868>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400b60 <.text+0x820>
               	mov	x24, #0x5678            // =22136
               	movk	x24, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x24, x17
               	lsl	x24, x25, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	b	0x400c00 <.text+0x8c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x27, #0x1e              // =30
               	str	w27, [x20]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x25a
               	mov	x20, x19
               	mov	x25, #0x4a              // =74
               	mov	x0, x26
               	mov	x3, x27
               	mov	x2, x25
               	mov	x1, x20
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x400bfc <.text+0x8bc>
               	b	0x400b78 <.text+0x838>
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	cmp	x22, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400cac <.text+0x96c>
               	b	0x400c58 <.text+0x918>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400c00 <.text+0x8c0>
               	mov	x27, #0x0               // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x27, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x27, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x27, x17
               	b	0x400cb0 <.text+0x970>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x24, x19
               	mov	x25, #0x1f              // =31
               	str	w25, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x270
               	mov	x24, x19
               	mov	x21, #0x4f              // =79
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x27, x0
               	b	0x400cac <.text+0x96c>
               	b	0x400c1c <.text+0x8dc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x26, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x400d48 <.text+0xa08>
               	b	0x400cf4 <.text+0x9b4>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400cb0 <.text+0x970>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29c
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x401400 <atoi>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400d4c <.text+0xa0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x27, x19
               	mov	x21, #0x20              // =32
               	str	w21, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x286
               	mov	x27, x19
               	mov	x22, #0x54              // =84
               	mov	x0, x24
               	mov	x3, x21
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400d48 <.text+0xa08>
               	b	0x400ccc <.text+0x98c>
               	sxtw	x20, w25
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400dd4 <.text+0xa94>
               	b	0x400d80 <.text+0xa40>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400d4c <.text+0xa0c>
               	b	0x400dd8 <.text+0xa98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	mov	x22, #0x28              // =40
               	str	w22, [x26]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400358 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a8
               	mov	x26, x19
               	mov	x20, #0x5d              // =93
               	mov	x0, x27
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x26
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x400dd4 <.text+0xa94>
               	b	0x400d74 <.text+0xa34>
               	sxtw	x21, w25
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400e94 <.text+0xb54>
               	b	0x400e40 <.text+0xb00>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400dd8 <.text+0xa98>
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	mov	x22, #0x1               // =1
               	sxtw	x25, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x22, x17
               	add	x26, x25, x20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x26, x17
               	b	0x400e98 <.text+0xb58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x20, x19
               	mov	x24, #0x29              // =41
               	str	w24, [x20]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2be
               	mov	x20, x19
               	mov	x21, #0x5e              // =94
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x400e94 <.text+0xb54>
               	b	0x400e00 <.text+0xac0>
               	cmp	x21, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400f2c <.text+0xbec>
               	b	0x400ed8 <.text+0xb98>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400e98 <.text+0xb58>
               	sxtw	x8, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x22, x17
               	sub	x22, x8, x25
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x22, x17
               	b	0x400f30 <.text+0xbf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x26, x19
               	mov	x20, #0x32              // =50
               	str	w20, [x26]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400358 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d4
               	mov	x26, x19
               	mov	x25, #0x68              // =104
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x25
               	mov	x1, x26
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x8, x0
               	b	0x400f2c <.text+0xbec>
               	b	0x400eac <.text+0xb6c>
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x23, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400fb4 <.text+0xc74>
               	b	0x400f60 <.text+0xc20>
               	mov	x28, #0x0               // =0
               	cbnz	x28, 0x400f30 <.text+0xbf0>
               	mov	x27, #0x5678            // =22136
               	movk	x27, #0x1234, lsl #16
               	b	0x400fb8 <.text+0xc78>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x22, x19
               	mov	x25, #0x33              // =51
               	str	w25, [x22]
               	mov	x28, #0x2               // =2
               	mov	x0, x28
               	bl	0x400358 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2ea
               	mov	x22, x19
               	mov	x28, #0x6c              // =108
               	mov	x0, x21
               	mov	x3, x25
               	mov	x2, x28
               	mov	x1, x22
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x400fb4 <.text+0xc74>
               	b	0x400f4c <.text+0xc0c>
               	sxtw	x28, w27
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x28, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x40103c <.text+0xcfc>
               	b	0x400fe8 <.text+0xca8>
               	mov	x28, #0x0               // =0
               	cbnz	x28, 0x400fb8 <.text+0xc78>
               	sxtw	x21, w27
               	b	0x401040 <.text+0xd00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x23, x19
               	mov	x26, #0x3c              // =60
               	str	w26, [x23]
               	mov	x28, #0x2               // =2
               	mov	x0, x28
               	bl	0x400358 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x300
               	mov	x23, x19
               	mov	x28, #0x73              // =115
               	mov	x0, x22
               	mov	x3, x26
               	mov	x2, x28
               	mov	x1, x23
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x40103c <.text+0xcfc>
               	b	0x400fd8 <.text+0xc98>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	cmp	x21, x17
               	cset	x28, eq
               	cmp	x28, #0x0
               	b.ne	0x4010d0 <.text+0xd90>
               	b	0x40107c <.text+0xd3c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401040 <.text+0xd00>
               	mov	x22, #0x6c00            // =27648
               	movk	x22, #0x88ca, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	sxtw	x26, w22
               	b	0x4010d4 <.text+0xd94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x28, x19
               	mov	x25, #0x3d              // =61
               	str	w25, [x28]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400358 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x316
               	mov	x28, x19
               	mov	x27, #0x75              // =117
               	mov	x0, x23
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x28
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x4010d0 <.text+0xd90>
               	b	0x40105c <.text+0xd1c>
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x401158 <.text+0xe18>
               	b	0x401104 <.text+0xdc4>
               	mov	x28, #0x0               // =0
               	cbnz	x28, 0x4010d4 <.text+0xd94>
               	b	0x40115c <.text+0xe1c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x21, x19
               	mov	x27, #0x3e              // =62
               	str	w27, [x21]
               	mov	x28, #0x2               // =2
               	mov	x0, x28
               	bl	0x400358 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32c
               	mov	x21, x19
               	mov	x28, #0x7a              // =122
               	mov	x0, x23
               	mov	x3, x27
               	mov	x2, x28
               	mov	x1, x21
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x401158 <.text+0xe18>
               	b	0x4010f8 <.text+0xdb8>
               	sxtw	x24, w22
               	mov	x17, #0x6c00            // =27648
               	movk	x17, #0x88ca, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x28, eq
               	cmp	x28, #0x0
               	b.ne	0x4011fc <.text+0xebc>
               	b	0x4011a8 <.text+0xe68>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x40115c <.text+0xe1c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x23, x19
               	ldrsw	x24, [x23]
               	cmp	x24, #0x0
               	b.ne	0x401258 <.text+0xf18>
               	b	0x401200 <.text+0xec0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x28, x19
               	mov	x25, #0x3f              // =63
               	str	w25, [x28]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400358 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x342
               	mov	x28, x19
               	mov	x24, #0x7b              // =123
               	mov	x0, x26
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x28
               	bl	0x4013f4 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4011fc <.text+0xebc>
               	b	0x401184 <.text+0xe44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x358
               	mov	x21, x19
               	mov	x0, x21
               	bl	0x40140c <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x0               // =0
               	mov	x0, x23
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
               	mov	x21, x19
               	ldrsw	x23, [x21]
               	mov	x0, x23
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
               	<unknown>
               	adr	x10, 0x4ed3c5
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4078f8 <exit+0x64e0>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9988
               	tbz	w21, #0x6, 0x3ff94c
               	<unknown>
               	cbnz	w16, 0x46f8f4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400f00 <.text+0xbc0>
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
               	bl	0x401418 <exit>
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
               	adr	x10, 0x4ed491
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4079c4 <exit+0x65ac>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9a54
               	tbz	w21, #0x6, 0x3ffa18
               	<unknown>
               	cbnz	w16, 0x46f9c0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x400fcc <.text+0xc8c>
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

<atoi>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0x100]
               	br	x16
