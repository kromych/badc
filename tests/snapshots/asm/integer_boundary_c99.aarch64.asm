
integer_boundary_c99.aarch64:	file format elf64-littleaarch64

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
               	bl	0x402408 <dlsym>
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
               	sub	sp, sp, #0x190
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	b	0x400484 <.text+0x184>
               	mov	x15, #0x1               // =1
               	cmp	x15, #0x0
               	b.ne	0x4004f4 <.text+0x1f4>
               	b	0x4004a0 <.text+0x1a0>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400484 <.text+0x184>
               	b	0x4004f8 <.text+0x1f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x15, x19
               	mov	x20, #0x64              // =100
               	str	w20, [x15]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x23, x19
               	mov	x21, #0x36              // =54
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x11, x0
               	b	0x4004f4 <.text+0x1f4>
               	b	0x400494 <.text+0x194>
               	mov	x11, #0x1               // =1
               	cmp	x11, #0x0
               	b.ne	0x400568 <.text+0x268>
               	b	0x400514 <.text+0x214>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4004f8 <.text+0x1f8>
               	b	0x40056c <.text+0x26c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x11, x19
               	mov	x24, #0x65              // =101
               	str	w24, [x11]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x17b
               	mov	x25, x19
               	mov	x21, #0x37              // =55
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x25
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x400568 <.text+0x268>
               	b	0x400508 <.text+0x208>
               	mov	x20, #0x1               // =1
               	cmp	x20, #0x0
               	b.ne	0x4005dc <.text+0x2dc>
               	b	0x400588 <.text+0x288>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40056c <.text+0x26c>
               	b	0x4005e0 <.text+0x2e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x66              // =102
               	str	w22, [x20]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x196
               	mov	x20, x19
               	mov	x21, #0x38              // =56
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x4005dc <.text+0x2dc>
               	b	0x40057c <.text+0x27c>
               	mov	x24, #0x1               // =1
               	cmp	x24, #0x0
               	b.ne	0x400650 <.text+0x350>
               	b	0x4005fc <.text+0x2fc>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4005e0 <.text+0x2e0>
               	b	0x400654 <.text+0x354>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x23, #0x67              // =103
               	str	w23, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b1
               	mov	x24, x19
               	mov	x21, #0x39              // =57
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x400650 <.text+0x350>
               	b	0x4005f0 <.text+0x2f0>
               	mov	x22, #0x1               // =1
               	cmp	x22, #0x0
               	b.ne	0x4006c4 <.text+0x3c4>
               	b	0x400670 <.text+0x370>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400654 <.text+0x354>
               	b	0x4006c8 <.text+0x3c8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x25, #0x68              // =104
               	str	w25, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1cc
               	mov	x22, x19
               	mov	x21, #0x3a              // =58
               	mov	x0, x24
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4006c4 <.text+0x3c4>
               	b	0x400664 <.text+0x364>
               	mov	x23, #0x1               // =1
               	cmp	x23, #0x0
               	b.ne	0x400738 <.text+0x438>
               	b	0x4006e4 <.text+0x3e4>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4006c8 <.text+0x3c8>
               	b	0x40073c <.text+0x43c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x69              // =105
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e7
               	mov	x23, x19
               	mov	x21, #0x3b              // =59
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400738 <.text+0x438>
               	b	0x4006d8 <.text+0x3d8>
               	mov	x25, #0x1               // =1
               	cmp	x25, #0x0
               	b.ne	0x4007ac <.text+0x4ac>
               	b	0x400758 <.text+0x458>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40073c <.text+0x43c>
               	b	0x4007b0 <.text+0x4b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x24, #0x6a              // =106
               	str	w24, [x25]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x25, x19
               	mov	x21, #0x3c              // =60
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x25
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x4007ac <.text+0x4ac>
               	b	0x40074c <.text+0x44c>
               	mov	x20, #0x1               // =1
               	cmp	x20, #0x0
               	b.ne	0x400828 <.text+0x528>
               	b	0x4007d4 <.text+0x4d4>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4007b0 <.text+0x4b0>
               	mov	x24, #0xff              // =255
               	sturb	w24, [x29, #-0x8]
               	b	0x40082c <.text+0x52c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x6b              // =107
               	str	w22, [x20]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x21d
               	mov	x20, x19
               	mov	x21, #0x3d              // =61
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x400828 <.text+0x528>
               	b	0x4007c0 <.text+0x4c0>
               	ldurb	w24, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x21, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x21, x17
               	cmp	x24, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x4008c8 <.text+0x5c8>
               	b	0x400874 <.text+0x574>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x40082c <.text+0x52c>
               	sub	x22, x29, #0x8
               	ldrb	w24, [x22]
               	add	x21, x24, #0x1
               	strb	w21, [x22]
               	b	0x4008cc <.text+0x5cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x23, #0x6e              // =110
               	str	w23, [x21]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x238
               	mov	x21, x19
               	mov	x24, #0x42              // =66
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x4008c8 <.text+0x5c8>
               	b	0x400858 <.text+0x558>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x21, x17
               	cmp	x24, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400970 <.text+0x670>
               	b	0x40091c <.text+0x61c>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x4008cc <.text+0x5cc>
               	sub	x23, x29, #0x8
               	ldrb	w24, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x24, x17
               	strb	w21, [x23]
               	b	0x400974 <.text+0x674>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x25, #0x6f              // =111
               	str	w25, [x21]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x253
               	mov	x21, x19
               	mov	x24, #0x44              // =68
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x400970 <.text+0x670>
               	b	0x4008f0 <.text+0x5f0>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x24, x17
               	cmp	x21, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400a04 <.text+0x704>
               	b	0x4009b0 <.text+0x6b0>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400974 <.text+0x674>
               	mov	x22, #0x7f              // =127
               	b	0x400a08 <.text+0x708>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x20, #0x70              // =112
               	str	w20, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26e
               	mov	x24, x19
               	mov	x21, #0x46              // =70
               	mov	x0, x23
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400a04 <.text+0x704>
               	b	0x4009a0 <.text+0x6a0>
               	sxtb	x21, w22
               	cmp	x21, #0x7f
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400a94 <.text+0x794>
               	b	0x400a40 <.text+0x740>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400a08 <.text+0x708>
               	mov	x10, #0xff80            // =65408
               	movk	x10, #0xffff, lsl #16
               	movk	x10, #0xffff, lsl #32
               	movk	x10, #0xffff, lsl #48
               	sturb	w10, [x29, #-0x18]
               	b	0x400a98 <.text+0x798>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x25, #0x71              // =113
               	str	w25, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x289
               	mov	x24, x19
               	mov	x21, #0x49              // =73
               	mov	x0, x23
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x10, x0
               	b	0x400a94 <.text+0x794>
               	b	0x400a20 <.text+0x720>
               	ldursb	x10, [x29, #-0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x10, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400b40 <.text+0x840>
               	b	0x400aec <.text+0x7ec>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400a98 <.text+0x798>
               	sub	x23, x29, #0x18
               	ldrsb	x26, [x23]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x26, x17
               	strb	w21, [x23]
               	b	0x400b44 <.text+0x844>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x20, #0x72              // =114
               	str	w20, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a4
               	mov	x21, x19
               	mov	x26, #0x4b              // =75
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x400b40 <.text+0x840>
               	b	0x400ac0 <.text+0x7c0>
               	ldursb	x21, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x26, x21, x17
               	mov	x17, #0x7f              // =127
               	eor	x21, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x21, x17
               	cmp	x26, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400be0 <.text+0x8e0>
               	b	0x400b8c <.text+0x88c>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400b44 <.text+0x844>
               	mov	x20, #0xffff            // =65535
               	sturh	w20, [x29, #-0x20]
               	b	0x400be4 <.text+0x8e4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x73              // =115
               	str	w24, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bf
               	mov	x21, x19
               	mov	x26, #0x4d              // =77
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x400be0 <.text+0x8e0>
               	b	0x400b78 <.text+0x878>
               	ldurh	w20, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x26, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x26, x17
               	cmp	x20, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400c80 <.text+0x980>
               	b	0x400c2c <.text+0x92c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400be4 <.text+0x8e4>
               	sub	x24, x29, #0x20
               	ldrh	w20, [x24]
               	add	x26, x20, #0x1
               	strh	w26, [x24]
               	b	0x400c84 <.text+0x984>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x22, #0x78              // =120
               	str	w22, [x26]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2da
               	mov	x26, x19
               	mov	x20, #0x53              // =83
               	mov	x0, x21
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x400c80 <.text+0x980>
               	b	0x400c10 <.text+0x910>
               	ldurh	w26, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x26, x17
               	cmp	x20, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400d30 <.text+0xa30>
               	b	0x400cdc <.text+0x9dc>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x400c84 <.text+0x984>
               	mov	x22, #0x0               // =0
               	sturh	w22, [x29, #-0x20]
               	sub	x20, x29, #0x20
               	ldrh	w22, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x22, x17
               	strh	w26, [x20]
               	b	0x400d34 <.text+0xa34>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x79              // =121
               	str	w23, [x26]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f5
               	mov	x26, x19
               	mov	x20, #0x55              // =85
               	mov	x0, x24
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x400d30 <.text+0xa30>
               	b	0x400ca8 <.text+0x9a8>
               	ldurh	w26, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x22, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x22, x17
               	cmp	x26, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400dc4 <.text+0xac4>
               	b	0x400d70 <.text+0xa70>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400d34 <.text+0xa34>
               	mov	x24, #0x7fff            // =32767
               	b	0x400dc8 <.text+0xac8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x21, #0x7a              // =122
               	str	w21, [x22]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x310
               	mov	x22, x19
               	mov	x26, #0x58              // =88
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x400dc4 <.text+0xac4>
               	b	0x400d60 <.text+0xa60>
               	sxth	x26, w24
               	mov	x17, #0x7fff            // =32767
               	cmp	x26, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400e54 <.text+0xb54>
               	b	0x400e00 <.text+0xb00>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400dc8 <.text+0xac8>
               	mov	x21, #0x8000            // =32768
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	b	0x400e58 <.text+0xb58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x23, #0x7b              // =123
               	str	w23, [x22]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32b
               	mov	x22, x19
               	mov	x26, #0x5b              // =91
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400e54 <.text+0xb54>
               	b	0x400de4 <.text+0xae4>
               	sxth	x26, w21
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400eec <.text+0xbec>
               	b	0x400e98 <.text+0xb98>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400e58 <.text+0xb58>
               	sxth	x23, w21
               	mov	x17, #0xffff            // =65535
               	and	x20, x23, x17
               	b	0x400ef0 <.text+0xbf0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x25, #0x7c              // =124
               	str	w25, [x24]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x346
               	mov	x24, x19
               	mov	x26, #0x5d              // =93
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x26
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x400eec <.text+0xbec>
               	b	0x400e80 <.text+0xb80>
               	mov	x17, #0xffff            // =65535
               	and	x23, x20, x17
               	mov	x17, #0x8000            // =32768
               	eor	x21, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x21, x17
               	cmp	x23, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400f90 <.text+0xc90>
               	b	0x400f3c <.text+0xc3c>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400ef0 <.text+0xbf0>
               	mov	x25, #0x2345            // =9029
               	movk	x25, #0x1, lsl #16
               	sxtw	x23, w25
               	sxth	x22, w23
               	b	0x400f94 <.text+0xc94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x26, #0x7d              // =125
               	str	w26, [x21]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x361
               	mov	x21, x19
               	mov	x23, #0x5f              // =95
               	mov	x0, x24
               	mov	x3, x26
               	mov	x2, x23
               	mov	x1, x21
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x400f90 <.text+0xc90>
               	b	0x400f20 <.text+0xc20>
               	sxth	x25, w22
               	mov	x17, #0x2345            // =9029
               	cmp	x25, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x401024 <.text+0xd24>
               	b	0x400fd0 <.text+0xcd0>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400f94 <.text+0xc94>
               	mov	x26, #0xffd6            // =65494
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	sxth	x24, w26
               	b	0x401028 <.text+0xd28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x23, #0x7e              // =126
               	str	w23, [x20]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x37c
               	mov	x20, x19
               	mov	x25, #0x64              // =100
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x25
               	mov	x1, x20
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x401024 <.text+0xd24>
               	b	0x400fb0 <.text+0xcb0>
               	sxtw	x26, w24
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x4010bc <.text+0xdbc>
               	b	0x401068 <.text+0xd68>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401028 <.text+0xd28>
               	mov	x21, #0xffff            // =65535
               	mov	x17, #0xffff            // =65535
               	and	x23, x21, x17
               	b	0x4010c0 <.text+0xdc0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x25, #0x7f              // =127
               	str	w25, [x22]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x397
               	mov	x22, x19
               	mov	x26, #0x69              // =105
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x4010bc <.text+0xdbc>
               	b	0x401050 <.text+0xd50>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x23, x17
               	mov	x17, #0xffff            // =65535
               	eor	x22, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	cmp	x24, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401154 <.text+0xe54>
               	b	0x401100 <.text+0xe00>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x4010c0 <.text+0xdc0>
               	b	0x401158 <.text+0xe58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x26, #0x80              // =128
               	str	w26, [x22]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3b2
               	mov	x22, x19
               	mov	x24, #0x6e              // =110
               	mov	x0, x20
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x9, x0
               	b	0x401154 <.text+0xe54>
               	b	0x4010f4 <.text+0xdf4>
               	mov	x17, #0xffff            // =65535
               	and	x9, x21, x17
               	mov	x17, #0xffff            // =65535
               	cmp	x9, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4011e4 <.text+0xee4>
               	b	0x401190 <.text+0xe90>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401158 <.text+0xe58>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	stur	w20, [x29, #-0x70]
               	b	0x4011e8 <.text+0xee8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x25, #0x81              // =129
               	str	w25, [x24]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cd
               	mov	x24, x19
               	mov	x27, #0x70              // =112
               	mov	x0, x23
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x4011e4 <.text+0xee4>
               	b	0x401178 <.text+0xe78>
               	ldur	w20, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x20, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401278 <.text+0xf78>
               	b	0x401224 <.text+0xf24>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x4011e8 <.text+0xee8>
               	sub	x23, x29, #0x70
               	ldr	w20, [x23]
               	add	x27, x20, #0x1
               	str	w27, [x23]
               	b	0x40127c <.text+0xf7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x22, #0x82              // =130
               	str	w22, [x27]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e8
               	mov	x27, x19
               	mov	x20, #0x76              // =118
               	mov	x0, x21
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x401278 <.text+0xf78>
               	b	0x401208 <.text+0xf08>
               	ldur	w27, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x27, x17
               	cmp	x20, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401328 <.text+0x1028>
               	b	0x4012d4 <.text+0xfd4>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x40127c <.text+0xf7c>
               	mov	x22, #0x0               // =0
               	stur	w22, [x29, #-0x70]
               	sub	x20, x29, #0x70
               	ldr	w22, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x27, x22, x17
               	str	w27, [x20]
               	b	0x40132c <.text+0x102c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x24, #0x83              // =131
               	str	w24, [x27]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x403
               	mov	x27, x19
               	mov	x20, #0x78              // =120
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x401328 <.text+0x1028>
               	b	0x4012a0 <.text+0xfa0>
               	ldur	w27, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x27, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x4013b4 <.text+0x10b4>
               	b	0x401360 <.text+0x1060>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x40132c <.text+0x102c>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0x7fff, lsl #16
               	b	0x4013b8 <.text+0x10b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x21, #0x84              // =132
               	str	w21, [x22]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x41e
               	mov	x22, x19
               	mov	x27, #0x7b              // =123
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x4013b4 <.text+0x10b4>
               	b	0x40134c <.text+0x104c>
               	sxtw	x27, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x27, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401448 <.text+0x1148>
               	b	0x4013f4 <.text+0x10f4>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4013b8 <.text+0x10b8>
               	mov	x25, #0x80000000        // =2147483648
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	sxtw	x21, w25
               	b	0x40144c <.text+0x114c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x85              // =133
               	str	w24, [x22]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x439
               	mov	x22, x19
               	mov	x27, #0x7e              // =126
               	mov	x0, x20
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x22
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x401448 <.text+0x1148>
               	b	0x4013d8 <.text+0x10d8>
               	sxtw	x27, w21
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x27, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4014d4 <.text+0x11d4>
               	b	0x401480 <.text+0x1180>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x40144c <.text+0x114c>
               	sxtw	x20, w21
               	b	0x4014d8 <.text+0x11d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0x86              // =134
               	str	w25, [x23]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x454
               	mov	x23, x19
               	mov	x27, #0x80              // =128
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x4014d4 <.text+0x11d4>
               	b	0x401470 <.text+0x1170>
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x20, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401568 <.text+0x1268>
               	b	0x401514 <.text+0x1214>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4014d8 <.text+0x11d8>
               	sxtw	x26, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x26, x17
               	b	0x40156c <.text+0x126c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x24, #0x87              // =135
               	str	w24, [x27]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46f
               	mov	x27, x19
               	mov	x23, #0x86              // =134
               	mov	x0, x22
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x401568 <.text+0x1268>
               	b	0x4014f8 <.text+0x11f8>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x25, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4015f4 <.text+0x12f4>
               	b	0x4015a4 <.text+0x12a4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x40156c <.text+0x126c>
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	stur	x27, [x29, #-0x98]
               	b	0x4015f8 <.text+0x12f8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x88              // =136
               	str	w23, [x26]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x48a
               	mov	x26, x19
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x23
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x27, x0
               	b	0x4015f4 <.text+0x12f4>
               	b	0x401584 <.text+0x1284>
               	ldur	x27, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x27, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401690 <.text+0x1390>
               	b	0x40163c <.text+0x133c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4015f8 <.text+0x12f8>
               	sub	x23, x29, #0x98
               	ldr	x27, [x23]
               	add	x26, x27, #0x1
               	str	x26, [x23]
               	b	0x401694 <.text+0x1394>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x8c              // =140
               	str	w20, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4a5
               	mov	x26, x19
               	mov	x27, #0x8e              // =142
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x23, x0
               	b	0x401690 <.text+0x1390>
               	b	0x401620 <.text+0x1320>
               	ldur	x26, [x29, #-0x98]
               	cmp	x26, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x40172c <.text+0x142c>
               	b	0x4016d8 <.text+0x13d8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401694 <.text+0x1394>
               	sub	x20, x29, #0x98
               	ldr	x26, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x27, x26, x17
               	str	x27, [x20]
               	b	0x401730 <.text+0x1430>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x21, #0x8d              // =141
               	str	w21, [x27]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4c0
               	mov	x27, x19
               	mov	x26, #0x90              // =144
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x40172c <.text+0x142c>
               	b	0x4016ac <.text+0x13ac>
               	ldur	x27, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x27, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4017c8 <.text+0x14c8>
               	b	0x401774 <.text+0x1474>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401730 <.text+0x1430>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0x7fff, lsl #48
               	b	0x4017cc <.text+0x14cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x25, #0x8e              // =142
               	str	w25, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4db
               	mov	x26, x19
               	mov	x27, #0x92              // =146
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x4017c8 <.text+0x14c8>
               	b	0x401758 <.text+0x1458>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x23, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401860 <.text+0x1560>
               	b	0x40180c <.text+0x150c>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x4017cc <.text+0x14cc>
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	b	0x401864 <.text+0x1564>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x21, #0x8f              // =143
               	str	w21, [x27]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4f6
               	mov	x27, x19
               	mov	x26, #0x95              // =149
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x401860 <.text+0x1560>
               	b	0x4017f0 <.text+0x14f0>
               	asr	x26, x25, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4018f0 <.text+0x15f0>
               	b	0x40189c <.text+0x159c>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401864 <.text+0x1564>
               	mov	x20, #-0x8000000000000000 // =-9223372036854775808
               	b	0x4018f4 <.text+0x15f4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x22, #0x90              // =144
               	str	w22, [x23]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x511
               	mov	x23, x19
               	mov	x26, #0x9a              // =154
               	mov	x0, x27
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x4018f0 <.text+0x15f0>
               	b	0x40188c <.text+0x158c>
               	lsr	x26, x20, #1
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x26, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401980 <.text+0x1680>
               	b	0x40192c <.text+0x162c>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x4018f4 <.text+0x15f4>
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	b	0x401984 <.text+0x1684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x21, #0x91              // =145
               	str	w21, [x25]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x52c
               	mov	x25, x19
               	mov	x26, #0x9d              // =157
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x25
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x401980 <.text+0x1680>
               	b	0x401910 <.text+0x1610>
               	lsr	x26, x27, #32
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x26, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x401a1c <.text+0x171c>
               	b	0x4019c8 <.text+0x16c8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401984 <.text+0x1684>
               	mov	x23, #0xfed4            // =65236
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	sxtw	x26, w23
               	sxtb	x21, w26
               	b	0x401a20 <.text+0x1720>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x92              // =146
               	str	w22, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x547
               	mov	x20, x19
               	mov	x26, #0xa0              // =160
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x20
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x401a1c <.text+0x171c>
               	b	0x4019a4 <.text+0x16a4>
               	sxtb	x27, w21
               	mov	x20, #0xd4              // =212
               	sxtb	x20, w20
               	cmp	x27, x20
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401aa0 <.text+0x17a0>
               	b	0x401a4c <.text+0x174c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401a20 <.text+0x1720>
               	b	0x401aa4 <.text+0x17a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x26, #0x96              // =150
               	str	w26, [x25]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x562
               	mov	x25, x19
               	mov	x20, #0xa9              // =169
               	mov	x0, x27
               	mov	x3, x26
               	mov	x2, x20
               	mov	x1, x25
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x401aa0 <.text+0x17a0>
               	b	0x401a40 <.text+0x1740>
               	sxtb	x24, w21
               	mov	x17, #0xffd4            // =65492
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x401b38 <.text+0x1838>
               	b	0x401ae4 <.text+0x17e4>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401aa4 <.text+0x17a4>
               	sxtw	x26, w23
               	mov	x17, #0xff              // =255
               	and	x27, x26, x17
               	b	0x401b3c <.text+0x183c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x97              // =151
               	str	w22, [x20]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57d
               	mov	x20, x19
               	mov	x24, #0xaa              // =170
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x24
               	mov	x1, x20
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x26, x0
               	b	0x401b38 <.text+0x1838>
               	b	0x401acc <.text+0x17cc>
               	mov	x17, #0xff              // =255
               	and	x26, x27, x17
               	mov	x17, #0xd4              // =212
               	eor	x21, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x21, x17
               	cmp	x26, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x401bcc <.text+0x18cc>
               	b	0x401b78 <.text+0x1878>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401b3c <.text+0x183c>
               	b	0x401bd0 <.text+0x18d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x98              // =152
               	str	w24, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x598
               	mov	x21, x19
               	mov	x26, #0xaf              // =175
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x401bcc <.text+0x18cc>
               	b	0x401b6c <.text+0x186c>
               	mov	x17, #0xff              // =255
               	and	x25, x27, x17
               	cmp	x25, #0xd4
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401c5c <.text+0x195c>
               	b	0x401c08 <.text+0x1908>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401bd0 <.text+0x18d0>
               	mov	x24, #0x2345            // =9029
               	movk	x24, #0x1, lsl #16
               	sxtw	x25, w24
               	sxth	x23, w25
               	b	0x401c60 <.text+0x1960>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x99              // =153
               	str	w20, [x26]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5b3
               	mov	x26, x19
               	mov	x25, #0xb0              // =176
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x25
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x24, x0
               	b	0x401c5c <.text+0x195c>
               	b	0x401bec <.text+0x18ec>
               	sxth	x24, w23
               	mov	x17, #0x2345            // =9029
               	cmp	x24, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401cdc <.text+0x19dc>
               	b	0x401c88 <.text+0x1988>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401c60 <.text+0x1960>
               	b	0x401ce0 <.text+0x19e0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x25, #0x9a              // =154
               	str	w25, [x27]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ce
               	mov	x27, x19
               	mov	x24, #0xb5              // =181
               	mov	x0, x26
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x401cdc <.text+0x19dc>
               	b	0x401c7c <.text+0x197c>
               	sxth	x20, w23
               	mov	x17, #0x2345            // =9029
               	cmp	x20, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401d6c <.text+0x1a6c>
               	b	0x401d18 <.text+0x1a18>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401ce0 <.text+0x19e0>
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0x1, lsl #16
               	sxtw	x20, w25
               	sxth	x26, w20
               	b	0x401d70 <.text+0x1a70>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x21, #0x9b              // =155
               	str	w21, [x24]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5e9
               	mov	x24, x19
               	mov	x20, #0xb6              // =182
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x20
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x25, x0
               	b	0x401d6c <.text+0x1a6c>
               	b	0x401cfc <.text+0x19fc>
               	sxth	x25, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x25, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401df8 <.text+0x1af8>
               	b	0x401da4 <.text+0x1aa4>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401d70 <.text+0x1a70>
               	b	0x401dfc <.text+0x1afc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x9c              // =156
               	str	w20, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x604
               	mov	x23, x19
               	mov	x25, #0xba              // =186
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x401df8 <.text+0x1af8>
               	b	0x401d98 <.text+0x1a98>
               	sxth	x21, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401e90 <.text+0x1b90>
               	b	0x401e3c <.text+0x1b3c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401dfc <.text+0x1afc>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	mov	x20, #0x1               // =1
               	b	0x401e94 <.text+0x1b94>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x27, #0x9d              // =157
               	str	w27, [x25]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x61f
               	mov	x25, x19
               	mov	x21, #0xbb              // =187
               	mov	x0, x23
               	mov	x3, x27
               	mov	x2, x21
               	mov	x1, x25
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x401e90 <.text+0x1b90>
               	b	0x401e24 <.text+0x1b24>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x20, x17
               	cmp	x26, x25
               	cset	x23, hi
               	cmp	x23, #0x0
               	b.ne	0x401f40 <.text+0x1c40>
               	b	0x401eec <.text+0x1bec>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401e94 <.text+0x1b94>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	sxtw	x27, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x20, x17
               	sxtw	x22, w25
               	b	0x401f44 <.text+0x1c44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0xa0              // =160
               	str	w21, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x63a
               	mov	x23, x19
               	mov	x25, #0xc2              // =194
               	mov	x0, x26
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x22, x0
               	b	0x401f40 <.text+0x1c40>
               	b	0x401ec0 <.text+0x1bc0>
               	sxtw	x20, w27
               	sxtw	x24, w22
               	cmp	x20, x24
               	cset	x23, lt
               	cmp	x23, #0x0
               	b.ne	0x401fc4 <.text+0x1cc4>
               	b	0x401f70 <.text+0x1c70>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401f44 <.text+0x1c44>
               	mov	x26, #0x1               // =1
               	b	0x401fc8 <.text+0x1cc8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0xa1              // =161
               	str	w25, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x655
               	mov	x23, x19
               	mov	x24, #0xc5              // =197
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x401fc4 <.text+0x1cc4>
               	b	0x401f60 <.text+0x1c60>
               	sxtw	x24, w26
               	lsl	x22, x24, #30
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x22, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x40204c <.text+0x1d4c>
               	b	0x401ff8 <.text+0x1cf8>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x401fc8 <.text+0x1cc8>
               	mov	x23, #0x1               // =1
               	b	0x402050 <.text+0x1d50>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x21, #0xaa              // =170
               	str	w21, [x24]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x670
               	mov	x24, x19
               	mov	x22, #0xcd              // =205
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x40204c <.text+0x1d4c>
               	b	0x401fe8 <.text+0x1ce8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x23, x17
               	lsl	x26, x22, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x26, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x22, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4020f4 <.text+0x1df4>
               	b	0x4020a0 <.text+0x1da0>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x402050 <.text+0x1d50>
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	b	0x4020f8 <.text+0x1df8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0xab              // =171
               	str	w20, [x26]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x68b
               	mov	x26, x19
               	mov	x22, #0xcf              // =207
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x4020f4 <.text+0x1df4>
               	b	0x402084 <.text+0x1d84>
               	sxtw	x22, w27
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x402188 <.text+0x1e88>
               	b	0x402134 <.text+0x1e34>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4020f8 <.text+0x1df8>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	b	0x40218c <.text+0x1e8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0xac              // =172
               	str	w21, [x23]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6a6
               	mov	x23, x19
               	mov	x22, #0xd3              // =211
               	mov	x0, x26
               	mov	x3, x21
               	mov	x2, x22
               	mov	x1, x23
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x20, x0
               	b	0x402188 <.text+0x1e88>
               	b	0x402120 <.text+0x1e20>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x24, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x22, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x40222c <.text+0x1f2c>
               	b	0x4021d8 <.text+0x1ed8>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40218c <.text+0x1e8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	ldrsw	x22, [x21]
               	cmp	x22, #0x0
               	b.ne	0x402284 <.text+0x1f84>
               	b	0x402230 <.text+0x1f30>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x20, #0xad              // =173
               	str	w20, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6c1
               	mov	x27, x19
               	mov	x22, #0xd5              // =213
               	mov	x0, x23
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x402414 <fprintf>
               	sxtw	x0, w0
               	mov	x21, x0
               	b	0x40222c <.text+0x1f2c>
               	b	0x4021b4 <.text+0x1eb4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6dc
               	mov	x26, x19
               	mov	x0, x26
               	bl	0x402420 <printf>
               	sxtw	x0, w0
               	mov	x21, x0
               	mov	x21, #0x0               // =0
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	ldrsw	x21, [x26]
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	<unknown>
               	adr	x10, 0x4ee3ed
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x408920 <exit+0x64f4>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3fa9b0
               	tbz	w21, #0x6, 0x400974 <.text+0x674>
               	<unknown>
               	cbnz	w16, 0x47091c
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x401f28 <.text+0x1c28>
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
               	bl	0x40242c <exit>
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
               	adr	x10, 0x4ee4b1
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4089e4 <exit+0x65b8>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3faa74
               	tbz	w21, #0x6, 0x400a38 <.text+0x738>
               	<unknown>
               	cbnz	w16, 0x4709e0
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x401fec <.text+0x1cec>
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
