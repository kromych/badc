
integer_ops_exhaustive.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400410 <.text+0x150>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
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
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40034c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11e
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x125
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x4025e8 <dlsym>
               	mov	x11, x0
               	cbz	x11, 0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x4003d8 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x100
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
               	sub	sp, sp, #0x150
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	mov	x21, #0x1               // =1
               	b	0x400450 <.text+0x190>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x13, x12
               	cset	x11, hi
               	cmp	x11, #0x0
               	b.ne	0x4004ec <.text+0x22c>
               	b	0x400488 <.text+0x1c8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400450 <.text+0x190>
               	b	0x4004f0 <.text+0x230>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15a
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40047c <.text+0x1bc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x13, x23
               	cset	x22, lo
               	cmp	x22, #0x0
               	b.ne	0x40058c <.text+0x2cc>
               	b	0x400528 <.text+0x268>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4004f0 <.text+0x230>
               	b	0x400590 <.text+0x2d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16d
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x177
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40051c <.text+0x25c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	cmp	x13, x22
               	cset	x24, hs
               	cmp	x24, #0x0
               	b.ne	0x40062c <.text+0x36c>
               	b	0x4005c8 <.text+0x308>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400590 <.text+0x2d0>
               	b	0x400630 <.text+0x370>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18a
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x194
               	mov	x24, x19
               	mov	x0, x23
               	mov	x1, x24
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4005bc <.text+0x2fc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x20, x17
               	cmp	x13, x24
               	cset	x23, ls
               	cmp	x23, #0x0
               	b.ne	0x4006cc <.text+0x40c>
               	b	0x400668 <.text+0x3a8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400630 <.text+0x370>
               	b	0x4006d0 <.text+0x410>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a8
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b2
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40065c <.text+0x39c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x13, x23
               	cset	x22, ne
               	cmp	x22, #0x0
               	b.ne	0x40076c <.text+0x4ac>
               	b	0x400708 <.text+0x448>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4006d0 <.text+0x410>
               	b	0x400770 <.text+0x4b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1c6
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1d0
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4006fc <.text+0x43c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	cmp	x13, x22
               	cset	x24, eq
               	cmp	x24, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400828 <.text+0x568>
               	b	0x4007c4 <.text+0x504>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400770 <.text+0x4b0>
               	mov	x24, #0xfffe            // =65534
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x25, #0x1               // =1
               	b	0x40082c <.text+0x56c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e4
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ee
               	mov	x22, x19
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x13, x0
               	mov	x13, #0x1               // =1
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4007a4 <.text+0x4e4>
               	sxtw	x21, w24
               	sxtw	x20, w25
               	cmp	x21, x20
               	cset	x23, lt
               	cmp	x23, #0x0
               	b.ne	0x4008b8 <.text+0x5f8>
               	b	0x400854 <.text+0x594>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40082c <.text+0x56c>
               	b	0x4008bc <.text+0x5fc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x20c
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400848 <.text+0x588>
               	sxtw	x21, w25
               	sxtw	x23, w24
               	cmp	x21, x23
               	cset	x22, gt
               	cmp	x22, #0x0
               	b.ne	0x400948 <.text+0x688>
               	b	0x4008e4 <.text+0x624>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4008bc <.text+0x5fc>
               	b	0x40094c <.text+0x68c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x217
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x221
               	mov	x22, x19
               	mov	x0, x20
               	mov	x1, x22
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4008d8 <.text+0x618>
               	sxtw	x21, w24
               	sxtw	x22, w25
               	cmp	x21, x22
               	cset	x20, le
               	cmp	x20, #0x0
               	b.ne	0x4009d8 <.text+0x718>
               	b	0x400974 <.text+0x6b4>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x40094c <.text+0x68c>
               	b	0x4009dc <.text+0x71c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x22c
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x236
               	mov	x20, x19
               	mov	x0, x23
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400968 <.text+0x6a8>
               	sxtw	x21, w25
               	sxtw	x20, w24
               	cmp	x21, x20
               	cset	x23, ge
               	cmp	x23, #0x0
               	b.ne	0x400a7c <.text+0x7bc>
               	b	0x400a18 <.text+0x758>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4009dc <.text+0x71c>
               	mov	x20, #0xfffe            // =65534
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	0x400a80 <.text+0x7c0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x242
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x24c
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4009f8 <.text+0x738>
               	cmp	x20, x21
               	cset	x25, hi
               	cmp	x25, #0x0
               	b.ne	0x400b04 <.text+0x844>
               	b	0x400aa0 <.text+0x7e0>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400a80 <.text+0x7c0>
               	b	0x400b08 <.text+0x848>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x258
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x262
               	mov	x25, x19
               	mov	x0, x23
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400a94 <.text+0x7d4>
               	cmp	x20, x21
               	cset	x22, hs
               	cmp	x22, #0x0
               	b.ne	0x400b8c <.text+0x8cc>
               	b	0x400b28 <.text+0x868>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400b08 <.text+0x848>
               	b	0x400b90 <.text+0x8d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26f
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x279
               	mov	x22, x19
               	mov	x0, x24
               	mov	x1, x22
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400b1c <.text+0x85c>
               	cmp	x21, x20
               	cset	x23, lo
               	cmp	x23, #0x0
               	b.ne	0x400c28 <.text+0x968>
               	b	0x400bc4 <.text+0x904>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400b90 <.text+0x8d0>
               	mov	x22, #0xfffe            // =65534
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	mov	x24, #0x1               // =1
               	b	0x400c2c <.text+0x96c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x287
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x291
               	mov	x23, x19
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400ba4 <.text+0x8e4>
               	cmp	x24, x22
               	cset	x21, gt
               	cmp	x21, #0x0
               	b.ne	0x400cb0 <.text+0x9f0>
               	b	0x400c4c <.text+0x98c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400c2c <.text+0x96c>
               	b	0x400cb4 <.text+0x9f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x29e
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a8
               	mov	x21, x19
               	mov	x0, x23
               	mov	x1, x21
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400c40 <.text+0x980>
               	cmp	x22, #0x0
               	cset	x25, lt
               	cmp	x25, #0x0
               	b.ne	0x400d40 <.text+0xa80>
               	b	0x400cdc <.text+0xa1c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400cb4 <.text+0x9f4>
               	mov	x21, #0xfe              // =254
               	mov	x24, #0x1               // =1
               	b	0x400d44 <.text+0xa84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2b3
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bd
               	mov	x25, x19
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400cc8 <.text+0xa08>
               	mov	x17, #0xff              // =255
               	and	x22, x21, x17
               	mov	x17, #0xff              // =255
               	and	x20, x24, x17
               	cmp	x22, x20
               	cset	x23, gt
               	cmp	x23, #0x0
               	b.ne	0x400dd8 <.text+0xb18>
               	b	0x400d74 <.text+0xab4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400d44 <.text+0xa84>
               	b	0x400ddc <.text+0xb1c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2c8
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2d2
               	mov	x23, x19
               	mov	x0, x25
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400d68 <.text+0xaa8>
               	mov	x17, #0xff              // =255
               	and	x22, x24, x17
               	mov	x17, #0xff              // =255
               	and	x23, x21, x17
               	cmp	x22, x23
               	cset	x25, lt
               	cmp	x25, #0x0
               	b.ne	0x400e84 <.text+0xbc4>
               	b	0x400e20 <.text+0xb60>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400ddc <.text+0xb1c>
               	mov	x23, #0xfffe            // =65534
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x22, #0x1               // =1
               	b	0x400e88 <.text+0xbc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2de
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2e8
               	mov	x25, x19
               	mov	x0, x20
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400e00 <.text+0xb40>
               	sxtb	x24, w23
               	sxtb	x21, w22
               	cmp	x24, x21
               	cset	x20, lt
               	cmp	x20, #0x0
               	b.ne	0x400f14 <.text+0xc54>
               	b	0x400eb0 <.text+0xbf0>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400e88 <.text+0xbc8>
               	b	0x400f18 <.text+0xc58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f4
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2fe
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400ea4 <.text+0xbe4>
               	sxtb	x24, w22
               	sxtb	x20, w23
               	cmp	x24, x20
               	cset	x25, gt
               	cmp	x25, #0x0
               	b.ne	0x400fbc <.text+0xcfc>
               	b	0x400f58 <.text+0xc98>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400f18 <.text+0xc58>
               	mov	x24, #0x64              // =100
               	stur	w24, [x29, #-0x68]
               	sub	x25, x29, #0x68
               	ldr	w24, [x25]
               	add	x22, x24, #0x5
               	str	w22, [x25]
               	b	0x400fc0 <.text+0xd00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x308
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x312
               	mov	x25, x19
               	mov	x0, x21
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x24, x0
               	mov	x24, #0x1               // =1
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400f34 <.text+0xc74>
               	ldur	w22, [x29, #-0x68]
               	mov	x17, #0x69              // =105
               	eor	x24, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	cmp	x22, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x40106c <.text+0xdac>
               	b	0x401008 <.text+0xd48>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400fc0 <.text+0xd00>
               	sub	x25, x29, #0x68
               	ldr	w24, [x25]
               	sub	x20, x24, #0xa
               	str	w20, [x25]
               	b	0x401070 <.text+0xdb0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x31c
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x326
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400fec <.text+0xd2c>
               	ldur	w20, [x29, #-0x68]
               	mov	x17, #0x5f              // =95
               	eor	x24, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x24, x17
               	cmp	x20, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x40111c <.text+0xe5c>
               	b	0x4010b8 <.text+0xdf8>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401070 <.text+0xdb0>
               	sub	x25, x29, #0x68
               	ldr	w24, [x25]
               	lsl	x22, x24, #1
               	str	w22, [x25]
               	b	0x401120 <.text+0xe60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32f
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x339
               	mov	x24, x19
               	mov	x0, x22
               	mov	x1, x24
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40109c <.text+0xddc>
               	ldur	w22, [x29, #-0x68]
               	mov	x17, #0xbe              // =190
               	eor	x24, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	cmp	x22, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4011d0 <.text+0xf10>
               	b	0x40116c <.text+0xeac>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401120 <.text+0xe60>
               	sub	x25, x29, #0x68
               	ldr	w24, [x25]
               	mov	x20, #0x5               // =5
               	udiv	x23, x24, x20
               	str	w23, [x25]
               	b	0x4011d4 <.text+0xf14>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x343
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x34d
               	mov	x24, x19
               	mov	x0, x20
               	mov	x1, x24
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40114c <.text+0xe8c>
               	ldur	w23, [x29, #-0x68]
               	mov	x17, #0x26              // =38
               	eor	x20, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	cmp	x23, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x401288 <.text+0xfc8>
               	b	0x401224 <.text+0xf64>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4011d4 <.text+0xf14>
               	sub	x25, x29, #0x68
               	ldr	w20, [x25]
               	mov	x22, #0x7               // =7
               	udiv	x17, x20, x22
               	msub	x24, x17, x22, x20
               	str	w24, [x25]
               	b	0x40128c <.text+0xfcc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x356
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x360
               	mov	x20, x19
               	mov	x0, x22
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401200 <.text+0xf40>
               	ldur	w24, [x29, #-0x68]
               	mov	x17, #0x3               // =3
               	eor	x22, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	cmp	x24, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401348 <.text+0x1088>
               	b	0x4012e4 <.text+0x1024>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40128c <.text+0xfcc>
               	mov	x25, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	sub	x25, x22, #0x2
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	b	0x40134c <.text+0x108c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x369
               	mov	x23, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x373
               	mov	x22, x19
               	mov	x0, x23
               	mov	x1, x22
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4012b8 <.text+0xff8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x25, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4013fc <.text+0x113c>
               	b	0x401398 <.text+0x10d8>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40134c <.text+0x108c>
               	mov	x20, #0x3e8             // =1000
               	stur	x20, [x29, #-0x78]
               	sub	x23, x29, #0x78
               	ldr	x20, [x23]
               	add	x24, x20, #0x19f
               	str	x24, [x23]
               	b	0x401400 <.text+0x1140>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x37c
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x386
               	mov	x23, x19
               	mov	x0, x22
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401374 <.text+0x10b4>
               	ldur	x24, [x29, #-0x78]
               	cmp	x24, #0x587
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x40149c <.text+0x11dc>
               	b	0x401438 <.text+0x1178>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401400 <.text+0x1140>
               	sub	x23, x29, #0x78
               	ldr	x20, [x23]
               	mov	x17, #0x3               // =3
               	mul	x25, x20, x17
               	str	x25, [x23]
               	b	0x4014a0 <.text+0x11e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x394
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x39e
               	mov	x20, x19
               	mov	x0, x25
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401418 <.text+0x1158>
               	ldur	x25, [x29, #-0x78]
               	mov	x17, #0x1095            // =4245
               	cmp	x25, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x401540 <.text+0x1280>
               	b	0x4014dc <.text+0x121c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4014a0 <.text+0x11e0>
               	sub	x23, x29, #0x78
               	ldr	x20, [x23]
               	mov	x24, #0x5               // =5
               	udiv	x22, x20, x24
               	str	x22, [x23]
               	b	0x401544 <.text+0x1284>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3a9
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3b3
               	mov	x20, x19
               	mov	x0, x24
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4014bc <.text+0x11fc>
               	ldur	x22, [x29, #-0x78]
               	cmp	x22, #0x351
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401624 <.text+0x1364>
               	b	0x4015c0 <.text+0x1300>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401544 <.text+0x1284>
               	mov	x23, #0xff00            // =65280
               	movk	x23, #0xff00, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x23, x17
               	mov	x17, #0xf0f             // =3855
               	movk	x17, #0xf0f, lsl #16
               	and	x22, x24, x17
               	mov	x17, #0xf000            // =61440
               	movk	x17, #0xf, lsl #16
               	orr	x23, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	eor	x25, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x21, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x21, x17
               	b	0x401628 <.text+0x1368>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3bc
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3c6
               	mov	x24, x19
               	mov	x0, x25
               	mov	x1, x24
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40155c <.text+0x129c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x22, x17
               	mov	x17, #0xf00             // =3840
               	movk	x17, #0xf00, lsl #16
               	eor	x10, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x10, x17
               	cmp	x21, #0x0
               	cset	x10, eq
               	cmp	x10, #0x0
               	b.ne	0x4016d0 <.text+0x1410>
               	b	0x40166c <.text+0x13ac>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401628 <.text+0x1368>
               	b	0x4016d4 <.text+0x1414>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cf
               	mov	x24, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3d9
               	mov	x26, x19
               	mov	x0, x24
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x9, x0
               	mov	x9, #0x1                // =1
               	mov	x0, x9
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401660 <.text+0x13a0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x9, x23, x17
               	mov	x17, #0xff00            // =65280
               	movk	x17, #0xff0f, lsl #16
               	cmp	x9, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x40176c <.text+0x14ac>
               	b	0x401708 <.text+0x1448>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x4016d4 <.text+0x1414>
               	b	0x401770 <.text+0x14b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3df
               	mov	x21, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e9
               	mov	x26, x19
               	mov	x0, x21
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4016fc <.text+0x143c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x26, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x26, x17
               	cmp	x22, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401818 <.text+0x1558>
               	b	0x4017b4 <.text+0x14f4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401770 <.text+0x14b0>
               	b	0x40181c <.text+0x155c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3ef
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3f9
               	mov	x26, x19
               	mov	x0, x27
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x23, x0
               	mov	x23, #0x1               // =1
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4017a8 <.text+0x14e8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x20, x17
               	mov	x17, #0xff              // =255
               	movk	x17, #0xff, lsl #16
               	eor	x26, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x26, x17
               	cmp	x23, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4018e8 <.text+0x1628>
               	b	0x401884 <.text+0x15c4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40181c <.text+0x155c>
               	mov	x25, #0x5678            // =22136
               	movk	x25, #0x1234, lsl #16
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x25, x17
               	lsl	x25, x26, #4
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x25, x17
               	b	0x4018ec <.text+0x162c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3ff
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x409
               	mov	x26, x19
               	mov	x0, x22
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401854 <.text+0x1594>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x23, x17
               	mov	x17, #0x6780            // =26496
               	movk	x17, #0x2345, lsl #16
               	eor	x20, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x20, x17
               	cmp	x25, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x4019b4 <.text+0x16f4>
               	b	0x401950 <.text+0x1690>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4018ec <.text+0x162c>
               	mov	x22, #0x1               // =1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x22, x17
               	lsl	x22, x20, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x22, x17
               	b	0x4019b8 <.text+0x16f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x40f
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x419
               	mov	x20, x19
               	mov	x0, x26
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x22, x0
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401924 <.text+0x1664>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x25, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x22, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401a50 <.text+0x1790>
               	b	0x4019ec <.text+0x172c>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4019b8 <.text+0x16f8>
               	mov	x22, #0x1               // =1
               	b	0x401a54 <.text+0x1794>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x422
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x42c
               	mov	x23, x19
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4019dc <.text+0x171c>
               	lsl	x23, x22, #63
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x23, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401af4 <.text+0x1834>
               	b	0x401a90 <.text+0x17d0>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401a54 <.text+0x1794>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	b	0x401af8 <.text+0x1838>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x436
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x440
               	mov	x25, x19
               	mov	x0, x26
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401a70 <.text+0x17b0>
               	sxtw	x22, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x20, x17
               	cmp	x26, x22
               	cset	x27, hi
               	cmp	x27, #0x0
               	b.ne	0x401b98 <.text+0x18d8>
               	b	0x401b34 <.text+0x1874>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401af8 <.text+0x1838>
               	b	0x401b9c <.text+0x18dc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x44a
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x454
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401b28 <.text+0x1868>
               	sxtw	x26, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x20, x17
               	sxtw	x27, w27
               	cmp	x26, x27
               	cset	x25, lt
               	cmp	x25, #0x0
               	b.ne	0x401c50 <.text+0x1990>
               	b	0x401bec <.text+0x192c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401b9c <.text+0x18dc>
               	mov	x26, #0xfffe            // =65534
               	movk	x26, #0xffff, lsl #16
               	stur	w26, [x29, #-0xe0]
               	sub	x25, x29, #0xe0
               	ldr	w26, [x25]
               	add	x20, x26, #0x1
               	str	w20, [x25]
               	b	0x401c54 <.text+0x1994>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x460
               	mov	x22, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46a
               	mov	x25, x19
               	mov	x0, x22
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401bc4 <.text+0x1904>
               	ldur	w20, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401cf4 <.text+0x1a34>
               	b	0x401c90 <.text+0x19d0>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401c54 <.text+0x1994>
               	sub	x25, x29, #0xe0
               	ldr	w26, [x25]
               	add	x27, x26, #0x1
               	str	w27, [x25]
               	b	0x401cf8 <.text+0x1a38>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x475
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x47f
               	mov	x26, x19
               	mov	x0, x27
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401c74 <.text+0x19b4>
               	ldur	w27, [x29, #-0xe0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x27, x17
               	cmp	x26, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401da4 <.text+0x1ae4>
               	b	0x401d40 <.text+0x1a80>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401cf8 <.text+0x1a38>
               	mov	x25, #0xfe              // =254
               	sturb	w25, [x29, #-0xe8]
               	sub	x27, x29, #0xe8
               	ldrb	w25, [x27]
               	add	x20, x25, #0x1
               	strb	w20, [x27]
               	b	0x401da8 <.text+0x1ae8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x48e
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x498
               	mov	x27, x19
               	mov	x0, x20
               	mov	x1, x27
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401d1c <.text+0x1a5c>
               	ldurb	w20, [x29, #-0xe8]
               	mov	x17, #0xff              // =255
               	eor	x25, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x25, x17
               	cmp	x20, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401e54 <.text+0x1b94>
               	b	0x401df0 <.text+0x1b30>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401da8 <.text+0x1ae8>
               	sub	x27, x29, #0xe8
               	ldrb	w25, [x27]
               	add	x26, x25, #0x1
               	strb	w26, [x27]
               	b	0x401e58 <.text+0x1b98>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4aa
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4b4
               	mov	x25, x19
               	mov	x0, x26
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x27, x0
               	mov	x27, #0x1               // =1
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401dd4 <.text+0x1b14>
               	ldurb	w26, [x29, #-0xe8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x26, x17
               	cmp	x25, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401f10 <.text+0x1c50>
               	b	0x401eac <.text+0x1bec>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401e58 <.text+0x1b98>
               	mov	x27, #0xfffe            // =65534
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	stur	x27, [x29, #-0xf0]
               	sub	x26, x29, #0xf0
               	ldr	x27, [x26]
               	add	x20, x27, #0x1
               	str	x20, [x26]
               	b	0x401f14 <.text+0x1c54>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4c7
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4d1
               	mov	x26, x19
               	mov	x0, x20
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x27, x0
               	mov	x27, #0x1               // =1
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401e7c <.text+0x1bbc>
               	ldur	x20, [x29, #-0xf0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401fbc <.text+0x1cfc>
               	b	0x401f58 <.text+0x1c98>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401f14 <.text+0x1c54>
               	sub	x26, x29, #0xf0
               	ldr	x27, [x26]
               	add	x25, x27, #0x1
               	str	x25, [x26]
               	b	0x401fc0 <.text+0x1d00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4e2
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4ec
               	mov	x27, x19
               	mov	x0, x25
               	mov	x1, x27
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401f3c <.text+0x1c7c>
               	ldur	x25, [x29, #-0xf0]
               	cmp	x25, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x402048 <.text+0x1d88>
               	b	0x401fe4 <.text+0x1d24>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401fc0 <.text+0x1d00>
               	b	0x40204c <.text+0x1d8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4fb
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x505
               	mov	x27, x19
               	mov	x0, x20
               	mov	x1, x27
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x401fd8 <.text+0x1d18>
               	mov	x26, #0x1               // =1
               	cmp	x26, #0x0
               	b.ne	0x4020cc <.text+0x1e0c>
               	b	0x402068 <.text+0x1da8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40204c <.text+0x1d8c>
               	b	0x4020d0 <.text+0x1e10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x517
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x521
               	mov	x26, x19
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40205c <.text+0x1d9c>
               	mov	x20, #0x1               // =1
               	cmp	x20, #0x0
               	b.ne	0x402150 <.text+0x1e90>
               	b	0x4020ec <.text+0x1e2c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4020d0 <.text+0x1e10>
               	b	0x402154 <.text+0x1e94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x52c
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x536
               	mov	x20, x19
               	mov	x0, x27
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4020e0 <.text+0x1e20>
               	mov	x25, #0x1               // =1
               	cmp	x25, #0x0
               	b.ne	0x4021d4 <.text+0x1f14>
               	b	0x402170 <.text+0x1eb0>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x402154 <.text+0x1e94>
               	b	0x4021d8 <.text+0x1f18>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x544
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x54e
               	mov	x25, x19
               	mov	x0, x26
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x27, x0
               	mov	x27, #0x1               // =1
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x402164 <.text+0x1ea4>
               	mov	x27, #0x1               // =1
               	cmp	x27, #0x0
               	b.ne	0x402258 <.text+0x1f98>
               	b	0x4021f4 <.text+0x1f34>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4021d8 <.text+0x1f18>
               	b	0x40225c <.text+0x1f9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x55a
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x564
               	mov	x27, x19
               	mov	x0, x20
               	mov	x1, x27
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4021e8 <.text+0x1f28>
               	mov	x26, #0x1               // =1
               	cmp	x26, #0x0
               	b.ne	0x4022dc <.text+0x201c>
               	b	0x402278 <.text+0x1fb8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40225c <.text+0x1f9c>
               	b	0x4022e0 <.text+0x2020>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x570
               	mov	x25, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57a
               	mov	x26, x19
               	mov	x0, x25
               	mov	x1, x26
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x20, x0
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40226c <.text+0x1fac>
               	mov	x20, #0x1               // =1
               	cmp	x20, #0x0
               	b.ne	0x402360 <.text+0x20a0>
               	b	0x4022fc <.text+0x203c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4022e0 <.text+0x2020>
               	b	0x402364 <.text+0x20a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x586
               	mov	x27, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x590
               	mov	x20, x19
               	mov	x0, x27
               	mov	x1, x20
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x25, x0
               	mov	x25, #0x1               // =1
               	mov	x0, x25
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4022f0 <.text+0x2030>
               	mov	x25, #0x1               // =1
               	cmp	x25, #0x0
               	b.ne	0x4023e4 <.text+0x2124>
               	b	0x402380 <.text+0x20c0>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x402364 <.text+0x20a4>
               	b	0x4023e8 <.text+0x2128>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5a4
               	mov	x26, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ae
               	mov	x25, x19
               	mov	x0, x26
               	mov	x1, x25
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x27, x0
               	mov	x27, #0x1               // =1
               	mov	x0, x27
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x402374 <.text+0x20b4>
               	mov	x27, #0x1               // =1
               	cmp	x27, #0x0
               	b.ne	0x40249c <.text+0x21dc>
               	b	0x402438 <.text+0x2178>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4023e8 <.text+0x2128>
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ba
               	mov	x20, x19
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5c4
               	mov	x27, x19
               	mov	x0, x20
               	mov	x1, x27
               	bl	0x4025f4 <printf>
               	sxtw	x0, w0
               	mov	x26, x0
               	mov	x26, #0x1               // =1
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
               	add	sp, sp, #0x150
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4023f8 <.text+0x2138>
               	<unknown>
               	adr	x10, 0x4ee5c5
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x408af8 <exit+0x64f8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3fab88
               	tbz	w21, #0x6, 0x400b4c <.text+0x88c>
               	<unknown>
               	cbnz	w16, 0x470af4
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x402100 <.text+0x1e40>
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
               	bl	0x402600 <exit>
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
               	adr	x10, 0x4ee691
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x408bc4 <exit+0x65c4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3fac54
               	tbz	w21, #0x6, 0x400c18 <.text+0x958>
               	<unknown>
               	cbnz	w16, 0x470bc0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4021cc <.text+0x1f0c>
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

<printf>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	br	x16

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xf0]
               	br	x16
