
c99_arith_common_width.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400448 <.text+0x148>
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
               	bl	0x400ba8 <dlsym>
               	cbz	x0, 0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	b	0x4004a0 <.text+0x1a0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x20, x17
               	cmp	x15, #0x0
               	cset	x13, eq
               	cmp	x13, #0x0
               	b.ne	0x40053c <.text+0x23c>
               	b	0x4004ec <.text+0x1ec>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4004a0 <.text+0x1a0>
               	mov	x0, #0x0                // =0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x0, x17
               	sub	x0, x22, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	b	0x400540 <.text+0x240>
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
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x40053c <.text+0x23c>
               	b	0x4004c0 <.text+0x1c0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x4005f4 <.text+0x2f4>
               	b	0x4005a8 <.text+0x2a8>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400540 <.text+0x240>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	sxtw	x25, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	sub	x20, x25, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x20, x17
               	b	0x4005f8 <.text+0x2f8>
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
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x4005f4 <.text+0x2f4>
               	b	0x400568 <.text+0x268>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x21, x17
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4006b0 <.text+0x3b0>
               	b	0x400660 <.text+0x360>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4005f8 <.text+0x2f8>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x20, #0x1               // =1
               	sxtw	x21, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	mul	x20, x21, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x20, x17
               	b	0x4006b4 <.text+0x3b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x23, #0x3               // =3
               	str	w23, [x25]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x18c
               	mov	x25, x19
               	mov	x20, #0x29              // =41
               	mov	x0, x24
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x25
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x4006b0 <.text+0x3b0>
               	b	0x400620 <.text+0x320>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x40074c <.text+0x44c>
               	b	0x4006fc <.text+0x3fc>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4006b4 <.text+0x3b4>
               	mov	x0, #0xc350             // =50000
               	mov	x17, #0xffff            // =65535
               	and	x20, x0, x17
               	mul	x0, x20, x20
               	sxtw	x23, w0
               	b	0x400750 <.text+0x450>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x26, #0x4               // =4
               	str	w26, [x21]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1a2
               	mov	x21, x19
               	mov	x20, #0x31              // =49
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x20
               	mov	x1, x21
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x40074c <.text+0x44c>
               	b	0x4006dc <.text+0x3dc>
               	mov	x17, #0xf900            // =63744
               	movk	x17, #0x9502, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x23, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x400804 <.text+0x504>
               	b	0x4007b4 <.text+0x4b4>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400750 <.text+0x450>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x22, #0x1               // =1
               	sxtw	x23, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x22, x17
               	add	x22, x23, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	b	0x400808 <.text+0x508>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x24, #0x5               // =5
               	str	w24, [x20]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b8
               	mov	x20, x19
               	mov	x22, #0x3e              // =62
               	mov	x0, x21
               	mov	x3, x24
               	mov	x2, x22
               	mov	x1, x20
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x400804 <.text+0x504>
               	b	0x400774 <.text+0x474>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x26, x17
               	cmp	x22, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x400898 <.text+0x598>
               	b	0x400848 <.text+0x548>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400808 <.text+0x508>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	mov	x21, #0x1               // =1
               	b	0x40089c <.text+0x59c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0x64              // =100
               	str	w25, [x23]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1ce
               	mov	x23, x19
               	mov	x22, #0x4b              // =75
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x22
               	mov	x1, x23
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x400898 <.text+0x598>
               	b	0x400828 <.text+0x528>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x21, x17
               	cmp	x24, x26
               	cset	x23, lt
               	cmp	x23, #0x0
               	b.ne	0x400930 <.text+0x630>
               	b	0x4008e0 <.text+0x5e0>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40089c <.text+0x59c>
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	b	0x400934 <.text+0x634>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x22, #0x65              // =101
               	str	w22, [x23]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e4
               	mov	x23, x19
               	mov	x26, #0x54              // =84
               	mov	x0, x20
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x23
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x400930 <.text+0x630>
               	b	0x4008bc <.text+0x5bc>
               	sxtw	x21, w25
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x27, x17
               	eor	x23, x21, x24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x23, x17
               	cmp	x24, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4009dc <.text+0x6dc>
               	b	0x40098c <.text+0x68c>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400934 <.text+0x634>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldrsw	x24, [x0]
               	cmp	x24, #0x0
               	b.ne	0x400a2c <.text+0x72c>
               	b	0x4009e0 <.text+0x6e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x26, #0x66              // =102
               	str	w26, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1fa
               	mov	x23, x19
               	mov	x24, #0x5d              // =93
               	mov	x0, x21
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x400bb4 <fprintf>
               	sxtw	x0, w0
               	b	0x4009dc <.text+0x6dc>
               	b	0x400968 <.text+0x668>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x210
               	mov	x22, x19
               	mov	x0, x22
               	bl	0x400bc0 <printf>
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
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
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
