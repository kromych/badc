
integer_boundary_c99.aarch64:	file format elf64-littleaarch64

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
               	bl	0x402328 <dlsym>
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
               	b	0x40047c <.text+0x17c>
               	mov	x15, #0x1               // =1
               	cmp	x15, #0x0
               	b.ne	0x4004e8 <.text+0x1e8>
               	b	0x400498 <.text+0x198>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40047c <.text+0x17c>
               	b	0x4004ec <.text+0x1ec>
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
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4004e8 <.text+0x1e8>
               	b	0x40048c <.text+0x18c>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x400558 <.text+0x258>
               	b	0x400508 <.text+0x208>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4004ec <.text+0x1ec>
               	b	0x40055c <.text+0x25c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x24, #0x65              // =101
               	str	w24, [x0]
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
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400558 <.text+0x258>
               	b	0x4004fc <.text+0x1fc>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4005c8 <.text+0x2c8>
               	b	0x400578 <.text+0x278>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40055c <.text+0x25c>
               	b	0x4005cc <.text+0x2cc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x20, #0x66              // =102
               	str	w20, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x196
               	mov	x22, x19
               	mov	x21, #0x38              // =56
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4005c8 <.text+0x2c8>
               	b	0x40056c <.text+0x26c>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x400638 <.text+0x338>
               	b	0x4005e8 <.text+0x2e8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4005cc <.text+0x2cc>
               	b	0x40063c <.text+0x33c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x24, #0x67              // =103
               	str	w24, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b1
               	mov	x23, x19
               	mov	x21, #0x39              // =57
               	mov	x0, x22
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400638 <.text+0x338>
               	b	0x4005dc <.text+0x2dc>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4006a8 <.text+0x3a8>
               	b	0x400658 <.text+0x358>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40063c <.text+0x33c>
               	b	0x4006ac <.text+0x3ac>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x20, #0x68              // =104
               	str	w20, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1cc
               	mov	x25, x19
               	mov	x21, #0x3a              // =58
               	mov	x0, x23
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4006a8 <.text+0x3a8>
               	b	0x40064c <.text+0x34c>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x400718 <.text+0x418>
               	b	0x4006c8 <.text+0x3c8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4006ac <.text+0x3ac>
               	b	0x40071c <.text+0x41c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x24, #0x69              // =105
               	str	w24, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e7
               	mov	x22, x19
               	mov	x21, #0x3b              // =59
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400718 <.text+0x418>
               	b	0x4006bc <.text+0x3bc>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x400788 <.text+0x488>
               	b	0x400738 <.text+0x438>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40071c <.text+0x41c>
               	b	0x40078c <.text+0x48c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x20, #0x6a              // =106
               	str	w20, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x23, x19
               	mov	x21, #0x3c              // =60
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400788 <.text+0x488>
               	b	0x40072c <.text+0x42c>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x400800 <.text+0x500>
               	b	0x4007b0 <.text+0x4b0>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x40078c <.text+0x48c>
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	b	0x400804 <.text+0x504>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x24, #0x6b              // =107
               	str	w24, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x21d
               	mov	x25, x19
               	mov	x21, #0x3d              // =61
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400800 <.text+0x500>
               	b	0x40079c <.text+0x49c>
               	ldurb	w0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x21, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x21, x17
               	cmp	x0, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x40089c <.text+0x59c>
               	b	0x40084c <.text+0x54c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400804 <.text+0x504>
               	sub	x0, x29, #0x8
               	ldrb	w22, [x0]
               	add	x21, x22, #0x1
               	strb	w21, [x0]
               	b	0x4008a0 <.text+0x5a0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x20, #0x6e              // =110
               	str	w20, [x21]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x238
               	mov	x21, x19
               	mov	x22, #0x42              // =66
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40089c <.text+0x59c>
               	b	0x400830 <.text+0x530>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x21, x17
               	cmp	x22, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400940 <.text+0x640>
               	b	0x4008f0 <.text+0x5f0>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4008a0 <.text+0x5a0>
               	sub	x0, x29, #0x8
               	ldrb	w22, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x22, x17
               	strb	w21, [x0]
               	b	0x400944 <.text+0x644>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x6f              // =111
               	str	w24, [x21]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x253
               	mov	x21, x19
               	mov	x22, #0x44              // =68
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400940 <.text+0x640>
               	b	0x4008c4 <.text+0x5c4>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x22, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x22, x17
               	cmp	x21, #0x0
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x4009d0 <.text+0x6d0>
               	b	0x400980 <.text+0x680>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400944 <.text+0x644>
               	mov	x24, #0x7f              // =127
               	b	0x4009d4 <.text+0x6d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x20, #0x70              // =112
               	str	w20, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26e
               	mov	x22, x19
               	mov	x21, #0x46              // =70
               	mov	x0, x25
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4009d0 <.text+0x6d0>
               	b	0x400970 <.text+0x670>
               	sxtb	x21, w24
               	cmp	x21, #0x7f
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400a5c <.text+0x75c>
               	b	0x400a0c <.text+0x70c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4009d4 <.text+0x6d4>
               	mov	x0, #0xff80             // =65408
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sturb	w0, [x29, #-0x18]
               	b	0x400a60 <.text+0x760>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x23, #0x71              // =113
               	str	w23, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x289
               	mov	x22, x19
               	mov	x21, #0x49              // =73
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400a5c <.text+0x75c>
               	b	0x4009ec <.text+0x6ec>
               	ldursb	x0, [x29, #-0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400b04 <.text+0x804>
               	b	0x400ab4 <.text+0x7b4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400a60 <.text+0x760>
               	sub	x0, x29, #0x18
               	ldrsb	x26, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x26, x17
               	strb	w21, [x0]
               	b	0x400b08 <.text+0x808>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x20, #0x72              // =114
               	str	w20, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2a4
               	mov	x21, x19
               	mov	x26, #0x4b              // =75
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400b04 <.text+0x804>
               	b	0x400a88 <.text+0x788>
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
               	b.ne	0x400ba0 <.text+0x8a0>
               	b	0x400b50 <.text+0x850>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400b08 <.text+0x808>
               	mov	x0, #0xffff             // =65535
               	sturh	w0, [x29, #-0x20]
               	b	0x400ba4 <.text+0x8a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x25, #0x73              // =115
               	str	w25, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bf
               	mov	x21, x19
               	mov	x26, #0x4d              // =77
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400ba0 <.text+0x8a0>
               	b	0x400b3c <.text+0x83c>
               	ldurh	w0, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x26, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x26, x17
               	cmp	x0, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400c3c <.text+0x93c>
               	b	0x400bec <.text+0x8ec>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400ba4 <.text+0x8a4>
               	sub	x0, x29, #0x20
               	ldrh	w24, [x0]
               	add	x26, x24, #0x1
               	strh	w26, [x0]
               	b	0x400c40 <.text+0x940>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x78              // =120
               	str	w20, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2da
               	mov	x26, x19
               	mov	x24, #0x53              // =83
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400c3c <.text+0x93c>
               	b	0x400bd0 <.text+0x8d0>
               	ldurh	w26, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	cmp	x24, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400ce8 <.text+0x9e8>
               	b	0x400c98 <.text+0x998>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400c40 <.text+0x940>
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	ldrh	w0, [x24]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x0, x17
               	strh	w26, [x24]
               	b	0x400cec <.text+0x9ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x25, #0x79              // =121
               	str	w25, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f5
               	mov	x26, x19
               	mov	x24, #0x55              // =85
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400ce8 <.text+0x9e8>
               	b	0x400c64 <.text+0x964>
               	ldurh	w26, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x0, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x0, x17
               	cmp	x26, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400d78 <.text+0xa78>
               	b	0x400d28 <.text+0xa28>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400cec <.text+0x9ec>
               	mov	x25, #0x7fff            // =32767
               	b	0x400d7c <.text+0xa7c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x20, #0x7a              // =122
               	str	w20, [x0]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x310
               	mov	x21, x19
               	mov	x26, #0x58              // =88
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400d78 <.text+0xa78>
               	b	0x400d18 <.text+0xa18>
               	sxth	x26, w25
               	mov	x17, #0x7fff            // =32767
               	cmp	x26, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400e04 <.text+0xb04>
               	b	0x400db4 <.text+0xab4>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400d7c <.text+0xa7c>
               	mov	x23, #0x8000            // =32768
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0xffff, lsl #48
               	b	0x400e08 <.text+0xb08>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x22, #0x7b              // =123
               	str	w22, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32b
               	mov	x21, x19
               	mov	x26, #0x5b              // =91
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400e04 <.text+0xb04>
               	b	0x400d98 <.text+0xa98>
               	sxth	x26, w23
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x400e98 <.text+0xb98>
               	b	0x400e48 <.text+0xb48>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400e08 <.text+0xb08>
               	sxth	x0, w23
               	mov	x17, #0xffff            // =65535
               	and	x22, x0, x17
               	b	0x400e9c <.text+0xb9c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0x7c              // =124
               	str	w20, [x25]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x346
               	mov	x25, x19
               	mov	x26, #0x5d              // =93
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400e98 <.text+0xb98>
               	b	0x400e30 <.text+0xb30>
               	mov	x17, #0xffff            // =65535
               	and	x0, x22, x17
               	mov	x17, #0x8000            // =32768
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x400f38 <.text+0xc38>
               	b	0x400ee8 <.text+0xbe8>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400e9c <.text+0xb9c>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxtw	x24, w0
               	sxth	x20, w24
               	b	0x400f3c <.text+0xc3c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x26, #0x7d              // =125
               	str	w26, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x361
               	mov	x23, x19
               	mov	x24, #0x5f              // =95
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400f38 <.text+0xc38>
               	b	0x400ecc <.text+0xbcc>
               	sxth	x0, w20
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x400fc8 <.text+0xcc8>
               	b	0x400f78 <.text+0xc78>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400f3c <.text+0xc3c>
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxth	x26, w0
               	b	0x400fcc <.text+0xccc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x7e              // =126
               	str	w24, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x37c
               	mov	x22, x19
               	mov	x21, #0x64              // =100
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400fc8 <.text+0xcc8>
               	b	0x400f58 <.text+0xc58>
               	sxtw	x0, w26
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x40105c <.text+0xd5c>
               	b	0x40100c <.text+0xd0c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x400fcc <.text+0xccc>
               	mov	x24, #0xffff            // =65535
               	mov	x17, #0xffff            // =65535
               	and	x23, x24, x17
               	b	0x401060 <.text+0xd60>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x21, #0x7f              // =127
               	str	w21, [x20]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x397
               	mov	x20, x19
               	mov	x25, #0x69              // =105
               	mov	x0, x22
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x20
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40105c <.text+0xd5c>
               	b	0x400ff4 <.text+0xcf4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x23, x17
               	mov	x17, #0xffff            // =65535
               	eor	x20, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x20, x17
               	cmp	x26, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x4010f0 <.text+0xdf0>
               	b	0x4010a0 <.text+0xda0>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401060 <.text+0xd60>
               	b	0x4010f4 <.text+0xdf4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x25, #0x80              // =128
               	str	w25, [x20]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3b2
               	mov	x20, x19
               	mov	x26, #0x6e              // =110
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x26
               	mov	x1, x20
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4010f0 <.text+0xdf0>
               	b	0x401094 <.text+0xd94>
               	mov	x17, #0xffff            // =65535
               	and	x0, x24, x17
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x40117c <.text+0xe7c>
               	b	0x40112c <.text+0xe2c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4010f4 <.text+0xdf4>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x70]
               	b	0x401180 <.text+0xe80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x21, #0x81              // =129
               	str	w21, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cd
               	mov	x26, x19
               	mov	x27, #0x70              // =112
               	mov	x0, x23
               	mov	x3, x21
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40117c <.text+0xe7c>
               	b	0x401114 <.text+0xe14>
               	ldur	w0, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x40120c <.text+0xf0c>
               	b	0x4011bc <.text+0xebc>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401180 <.text+0xe80>
               	sub	x0, x29, #0x70
               	ldr	w20, [x0]
               	add	x27, x20, #0x1
               	str	w27, [x0]
               	b	0x401210 <.text+0xf10>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x22, #0x82              // =130
               	str	w22, [x27]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e8
               	mov	x27, x19
               	mov	x20, #0x76              // =118
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40120c <.text+0xf0c>
               	b	0x4011a0 <.text+0xea0>
               	ldur	w27, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x27, x17
               	cmp	x20, #0x0
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x4012b8 <.text+0xfb8>
               	b	0x401268 <.text+0xf68>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401210 <.text+0xf10>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x70]
               	sub	x20, x29, #0x70
               	ldr	w0, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x27, x0, x17
               	str	w27, [x20]
               	b	0x4012bc <.text+0xfbc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x23, #0x83              // =131
               	str	w23, [x27]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x403
               	mov	x27, x19
               	mov	x20, #0x78              // =120
               	mov	x0, x26
               	mov	x3, x23
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4012b8 <.text+0xfb8>
               	b	0x401234 <.text+0xf34>
               	ldur	w27, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x27, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401340 <.text+0x1040>
               	b	0x4012f0 <.text+0xff0>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4012bc <.text+0xfbc>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0x7fff, lsl #16
               	b	0x401344 <.text+0x1044>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x22, #0x84              // =132
               	str	w22, [x0]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x41e
               	mov	x24, x19
               	mov	x27, #0x7b              // =123
               	mov	x0, x20
               	mov	x3, x22
               	mov	x2, x27
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401340 <.text+0x1040>
               	b	0x4012dc <.text+0xfdc>
               	sxtw	x27, w23
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x27, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4013d0 <.text+0x10d0>
               	b	0x401380 <.text+0x1080>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401344 <.text+0x1044>
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x21, w0
               	b	0x4013d4 <.text+0x10d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x26, #0x85              // =133
               	str	w26, [x24]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x439
               	mov	x24, x19
               	mov	x27, #0x7e              // =126
               	mov	x0, x20
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4013d0 <.text+0x10d0>
               	b	0x401364 <.text+0x1064>
               	sxtw	x27, w21
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x27, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401458 <.text+0x1158>
               	b	0x401408 <.text+0x1108>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4013d4 <.text+0x10d4>
               	sxtw	x26, w21
               	b	0x40145c <.text+0x115c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x22, #0x86              // =134
               	str	w22, [x23]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x454
               	mov	x23, x19
               	mov	x27, #0x80              // =128
               	mov	x0, x24
               	mov	x3, x22
               	mov	x2, x27
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401458 <.text+0x1158>
               	b	0x4013f8 <.text+0x10f8>
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x4014e8 <.text+0x11e8>
               	b	0x401498 <.text+0x1198>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x40145c <.text+0x115c>
               	sxtw	x0, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x0, x17
               	b	0x4014ec <.text+0x11ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x20, #0x87              // =135
               	str	w20, [x27]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46f
               	mov	x27, x19
               	mov	x23, #0x86              // =134
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4014e8 <.text+0x11e8>
               	b	0x40147c <.text+0x117c>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x25, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401570 <.text+0x1270>
               	b	0x401524 <.text+0x1224>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4014ec <.text+0x11ec>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x98]
               	b	0x401574 <.text+0x1274>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x23, #0x88              // =136
               	str	w23, [x0]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x48a
               	mov	x22, x19
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401570 <.text+0x1270>
               	b	0x401504 <.text+0x1204>
               	ldur	x0, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401608 <.text+0x1308>
               	b	0x4015b8 <.text+0x12b8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401574 <.text+0x1274>
               	sub	x0, x29, #0x98
               	ldr	x26, [x0]
               	add	x22, x26, #0x1
               	str	x22, [x0]
               	b	0x40160c <.text+0x130c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x27, #0x8c              // =140
               	str	w27, [x22]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4a5
               	mov	x22, x19
               	mov	x26, #0x8e              // =142
               	mov	x0, x25
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401608 <.text+0x1308>
               	b	0x40159c <.text+0x129c>
               	ldur	x22, [x29, #-0x98]
               	cmp	x22, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4016a0 <.text+0x13a0>
               	b	0x401650 <.text+0x1350>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40160c <.text+0x130c>
               	sub	x0, x29, #0x98
               	ldr	x22, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x22, x17
               	str	x26, [x0]
               	b	0x4016a4 <.text+0x13a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x8d              // =141
               	str	w23, [x26]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4c0
               	mov	x26, x19
               	mov	x22, #0x90              // =144
               	mov	x0, x21
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4016a0 <.text+0x13a0>
               	b	0x401624 <.text+0x1324>
               	ldur	x26, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x26, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401738 <.text+0x1438>
               	b	0x4016e8 <.text+0x13e8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x4016a4 <.text+0x13a4>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	movk	x23, #0xffff, lsl #32
               	movk	x23, #0x7fff, lsl #48
               	b	0x40173c <.text+0x143c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x27, #0x8e              // =142
               	str	w27, [x22]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4db
               	mov	x22, x19
               	mov	x26, #0x92              // =146
               	mov	x0, x25
               	mov	x3, x27
               	mov	x2, x26
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401738 <.text+0x1438>
               	b	0x4016cc <.text+0x13cc>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x23, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x4017cc <.text+0x14cc>
               	b	0x40177c <.text+0x147c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40173c <.text+0x143c>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	b	0x4017d0 <.text+0x14d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x21, #0x8f              // =143
               	str	w21, [x26]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4f6
               	mov	x26, x19
               	mov	x22, #0x95              // =149
               	mov	x0, x25
               	mov	x3, x21
               	mov	x2, x22
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4017cc <.text+0x14cc>
               	b	0x401760 <.text+0x1460>
               	asr	x22, x24, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x22, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401858 <.text+0x1558>
               	b	0x401808 <.text+0x1508>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4017d0 <.text+0x14d0>
               	mov	x21, #-0x8000000000000000 // =-9223372036854775808
               	b	0x40185c <.text+0x155c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x27, #0x90              // =144
               	str	w27, [x23]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x511
               	mov	x23, x19
               	mov	x22, #0x9a              // =154
               	mov	x0, x26
               	mov	x3, x27
               	mov	x2, x22
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401858 <.text+0x1558>
               	b	0x4017f8 <.text+0x14f8>
               	lsr	x22, x21, #1
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x22, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4018e4 <.text+0x15e4>
               	b	0x401894 <.text+0x1594>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x40185c <.text+0x155c>
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	b	0x4018e8 <.text+0x15e8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x25, #0x91              // =145
               	str	w25, [x24]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x52c
               	mov	x24, x19
               	mov	x22, #0x9d              // =157
               	mov	x0, x23
               	mov	x3, x25
               	mov	x2, x22
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4018e4 <.text+0x15e4>
               	b	0x401878 <.text+0x1578>
               	lsr	x22, x27, #32
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x22, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x40197c <.text+0x167c>
               	b	0x40192c <.text+0x162c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x4018e8 <.text+0x15e8>
               	mov	x25, #0xfed4            // =65236
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	sxtw	x22, w25
               	sxtb	x23, w22
               	b	0x401980 <.text+0x1680>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x26, #0x92              // =146
               	str	w26, [x21]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x547
               	mov	x21, x19
               	mov	x22, #0xa0              // =160
               	mov	x0, x24
               	mov	x3, x26
               	mov	x2, x22
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40197c <.text+0x167c>
               	b	0x401908 <.text+0x1608>
               	sxtb	x27, w23
               	mov	x21, #0xd4              // =212
               	sxtb	x21, w21
               	cmp	x27, x21
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4019fc <.text+0x16fc>
               	b	0x4019ac <.text+0x16ac>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401980 <.text+0x1680>
               	b	0x401a00 <.text+0x1700>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x22, #0x96              // =150
               	str	w22, [x24]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x562
               	mov	x24, x19
               	mov	x21, #0xa9              // =169
               	mov	x0, x27
               	mov	x3, x22
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4019fc <.text+0x16fc>
               	b	0x4019a0 <.text+0x16a0>
               	sxtb	x0, w23
               	mov	x17, #0xffd4            // =65492
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x401a90 <.text+0x1790>
               	b	0x401a40 <.text+0x1740>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401a00 <.text+0x1700>
               	sxtw	x0, w25
               	mov	x17, #0xff              // =255
               	and	x22, x0, x17
               	b	0x401a94 <.text+0x1794>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x20, #0x97              // =151
               	str	w20, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57d
               	mov	x21, x19
               	mov	x26, #0xaa              // =170
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401a90 <.text+0x1790>
               	b	0x401a28 <.text+0x1728>
               	mov	x17, #0xff              // =255
               	and	x0, x22, x17
               	mov	x17, #0xd4              // =212
               	eor	x23, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	cmp	x0, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401b20 <.text+0x1820>
               	b	0x401ad0 <.text+0x17d0>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401a94 <.text+0x1794>
               	b	0x401b24 <.text+0x1824>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x26, #0x98              // =152
               	str	w26, [x23]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x598
               	mov	x23, x19
               	mov	x27, #0xaf              // =175
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401b20 <.text+0x1820>
               	b	0x401ac4 <.text+0x17c4>
               	mov	x17, #0xff              // =255
               	and	x0, x22, x17
               	cmp	x0, #0xd4
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401bac <.text+0x18ac>
               	b	0x401b5c <.text+0x185c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401b24 <.text+0x1824>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxtw	x21, w0
               	sxth	x26, w21
               	b	0x401bb0 <.text+0x18b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x24, #0x99              // =153
               	str	w24, [x27]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5b3
               	mov	x27, x19
               	mov	x21, #0xb0              // =176
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401bac <.text+0x18ac>
               	b	0x401b40 <.text+0x1840>
               	sxth	x0, w26
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x401c28 <.text+0x1928>
               	b	0x401bd8 <.text+0x18d8>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401bb0 <.text+0x18b0>
               	b	0x401c2c <.text+0x192c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x21, #0x9a              // =154
               	str	w21, [x22]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ce
               	mov	x22, x19
               	mov	x25, #0xb5              // =181
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401c28 <.text+0x1928>
               	b	0x401bcc <.text+0x18cc>
               	sxth	x0, w26
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401cb4 <.text+0x19b4>
               	b	0x401c64 <.text+0x1964>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401c2c <.text+0x192c>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1, lsl #16
               	sxtw	x23, w0
               	sxth	x21, w23
               	b	0x401cb8 <.text+0x19b8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x24, #0x9b              // =155
               	str	w24, [x25]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5e9
               	mov	x25, x19
               	mov	x23, #0xb6              // =182
               	mov	x0, x22
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401cb4 <.text+0x19b4>
               	b	0x401c48 <.text+0x1948>
               	sxth	x0, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x401d3c <.text+0x1a3c>
               	b	0x401cec <.text+0x19ec>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401cb8 <.text+0x19b8>
               	b	0x401d40 <.text+0x1a40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x9c              // =156
               	str	w23, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x604
               	mov	x26, x19
               	mov	x27, #0xba              // =186
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401d3c <.text+0x1a3c>
               	b	0x401ce0 <.text+0x19e0>
               	sxth	x0, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x27, eq
               	cmp	x27, #0x0
               	b.ne	0x401dd0 <.text+0x1ad0>
               	b	0x401d80 <.text+0x1a80>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x401d40 <.text+0x1a40>
               	mov	x23, #0xffff            // =65535
               	movk	x23, #0xffff, lsl #16
               	mov	x25, #0x1               // =1
               	b	0x401dd4 <.text+0x1ad4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x24, #0x9d              // =157
               	str	w24, [x27]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x61f
               	mov	x27, x19
               	mov	x22, #0xbb              // =187
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x22
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401dd0 <.text+0x1ad0>
               	b	0x401d68 <.text+0x1a68>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x25, x17
               	cmp	x21, x27
               	cset	x26, hi
               	cmp	x26, #0x0
               	b.ne	0x401e7c <.text+0x1b7c>
               	b	0x401e2c <.text+0x1b2c>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401dd4 <.text+0x1ad4>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x23, x17
               	sxtw	x20, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x25, x17
               	sxtw	x24, w27
               	b	0x401e80 <.text+0x1b80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x22, #0xa0              // =160
               	str	w22, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x63a
               	mov	x26, x19
               	mov	x27, #0xc2              // =194
               	mov	x0, x21
               	mov	x3, x22
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401e7c <.text+0x1b7c>
               	b	0x401e00 <.text+0x1b00>
               	sxtw	x25, w20
               	sxtw	x23, w24
               	cmp	x25, x23
               	cset	x26, lt
               	cmp	x26, #0x0
               	b.ne	0x401efc <.text+0x1bfc>
               	b	0x401eac <.text+0x1bac>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401e80 <.text+0x1b80>
               	mov	x22, #0x1               // =1
               	b	0x401f00 <.text+0x1c00>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x27, #0xa1              // =161
               	str	w27, [x26]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x655
               	mov	x26, x19
               	mov	x23, #0xc5              // =197
               	mov	x0, x25
               	mov	x3, x27
               	mov	x2, x23
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401efc <.text+0x1bfc>
               	b	0x401e9c <.text+0x1b9c>
               	sxtw	x23, w22
               	lsl	x24, x23, #30
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x24, x17
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401f80 <.text+0x1c80>
               	b	0x401f30 <.text+0x1c30>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401f00 <.text+0x1c00>
               	mov	x25, #0x1               // =1
               	b	0x401f84 <.text+0x1c84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0xaa              // =170
               	str	w21, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x670
               	mov	x23, x19
               	mov	x24, #0xcd              // =205
               	mov	x0, x20
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401f80 <.text+0x1c80>
               	b	0x401f20 <.text+0x1c20>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	lsl	x22, x24, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x22, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x24, x17
               	cset	x22, eq
               	cmp	x22, #0x0
               	b.ne	0x402024 <.text+0x1d24>
               	b	0x401fd4 <.text+0x1cd4>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401f84 <.text+0x1c84>
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	b	0x402028 <.text+0x1d28>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x26, #0xab              // =171
               	str	w26, [x22]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x68b
               	mov	x22, x19
               	mov	x24, #0xcf              // =207
               	mov	x0, x23
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x402024 <.text+0x1d24>
               	b	0x401fb8 <.text+0x1cb8>
               	sxtw	x24, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4020b4 <.text+0x1db4>
               	b	0x402064 <.text+0x1d64>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x402028 <.text+0x1d28>
               	mov	x26, #0xffff            // =65535
               	movk	x26, #0xffff, lsl #16
               	b	0x4020b8 <.text+0x1db8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0xac              // =172
               	str	w20, [x25]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6a6
               	mov	x25, x19
               	mov	x24, #0xd3              // =211
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x24
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4020b4 <.text+0x1db4>
               	b	0x402050 <.text+0x1d50>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x402154 <.text+0x1e54>
               	b	0x402104 <.text+0x1e04>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x4020b8 <.text+0x1db8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldrsw	x24, [x0]
               	cmp	x24, #0x0
               	b.ne	0x4021a4 <.text+0x1ea4>
               	b	0x402158 <.text+0x1e58>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x23, #0xad              // =173
               	str	w23, [x21]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6c1
               	mov	x21, x19
               	mov	x24, #0xd5              // =213
               	mov	x0, x25
               	mov	x3, x23
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x402154 <.text+0x1e54>
               	b	0x4020e0 <.text+0x1de0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6dc
               	mov	x20, x19
               	mov	x0, x20
               	bl	0x402340 <printf>
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
               	add	sp, sp, #0x190
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	ldrsw	x0, [x20]
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
