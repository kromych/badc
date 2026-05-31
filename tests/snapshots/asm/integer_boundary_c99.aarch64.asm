
integer_boundary_c99.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x40044c <.text+0x14c>
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
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40038c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	add	x19, x19, #0x120
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x126
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x12d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x402328 <dlsym>
               	cbz	x0, 0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400414 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x108
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
               	b	0x400480 <.text+0x180>
               	mov	x15, #0x1               // =1
               	cmp	x15, #0x0
               	b.ne	0x4004ec <.text+0x1ec>
               	b	0x40049c <.text+0x19c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400480 <.text+0x180>
               	b	0x4004f0 <.text+0x1f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x14, x19
               	mov	x20, #0x64              // =100
               	str	w20, [x14]
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
               	b	0x4004ec <.text+0x1ec>
               	b	0x400490 <.text+0x190>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x40055c <.text+0x25c>
               	b	0x40050c <.text+0x20c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4004f0 <.text+0x1f0>
               	b	0x400560 <.text+0x260>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x65              // =101
               	str	w24, [x21]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x17b
               	mov	x21, x19
               	mov	x25, #0x37              // =55
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40055c <.text+0x25c>
               	b	0x400500 <.text+0x200>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4005cc <.text+0x2cc>
               	b	0x40057c <.text+0x27c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400560 <.text+0x260>
               	b	0x4005d0 <.text+0x2d0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0x66              // =102
               	str	w20, [x25]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x196
               	mov	x25, x19
               	mov	x22, #0x38              // =56
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4005cc <.text+0x2cc>
               	b	0x400570 <.text+0x270>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x40063c <.text+0x33c>
               	b	0x4005ec <.text+0x2ec>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4005d0 <.text+0x2d0>
               	b	0x400640 <.text+0x340>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x67              // =103
               	str	w24, [x22]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b1
               	mov	x22, x19
               	mov	x23, #0x39              // =57
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40063c <.text+0x33c>
               	b	0x4005e0 <.text+0x2e0>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x4006ac <.text+0x3ac>
               	b	0x40065c <.text+0x35c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400640 <.text+0x340>
               	b	0x4006b0 <.text+0x3b0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x68              // =104
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1cc
               	mov	x23, x19
               	mov	x21, #0x3a              // =58
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4006ac <.text+0x3ac>
               	b	0x400650 <.text+0x350>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x40071c <.text+0x41c>
               	b	0x4006cc <.text+0x3cc>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4006b0 <.text+0x3b0>
               	b	0x400720 <.text+0x420>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x24, #0x69              // =105
               	str	w24, [x21]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1e7
               	mov	x21, x19
               	mov	x25, #0x3b              // =59
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40071c <.text+0x41c>
               	b	0x4006c0 <.text+0x3c0>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x40078c <.text+0x48c>
               	b	0x40073c <.text+0x43c>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400720 <.text+0x420>
               	b	0x400790 <.text+0x490>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x20, #0x6a              // =106
               	str	w20, [x25]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x202
               	mov	x25, x19
               	mov	x22, #0x3c              // =60
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40078c <.text+0x48c>
               	b	0x400730 <.text+0x430>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.ne	0x400804 <.text+0x504>
               	b	0x4007b4 <.text+0x4b4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x400790 <.text+0x490>
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	b	0x400808 <.text+0x508>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x6b              // =107
               	str	w24, [x22]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x21d
               	mov	x22, x19
               	mov	x23, #0x3d              // =61
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400804 <.text+0x504>
               	b	0x4007a0 <.text+0x4a0>
               	ldurb	w0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x4008a0 <.text+0x5a0>
               	b	0x400850 <.text+0x550>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400808 <.text+0x508>
               	sub	x0, x29, #0x8
               	ldrb	w21, [x0]
               	add	x21, x21, #0x1
               	strb	w21, [x0]
               	b	0x4008a4 <.text+0x5a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x6e              // =110
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x238
               	mov	x23, x19
               	mov	x21, #0x42              // =66
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4008a0 <.text+0x5a0>
               	b	0x400834 <.text+0x534>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400944 <.text+0x644>
               	b	0x4008f4 <.text+0x5f4>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4008a4 <.text+0x5a4>
               	sub	x0, x29, #0x8
               	ldrb	w21, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	strb	w21, [x0]
               	b	0x400948 <.text+0x648>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x24, #0x6f              // =111
               	str	w24, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x253
               	mov	x23, x19
               	mov	x21, #0x44              // =68
               	mov	x0, x25
               	mov	x3, x24
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400944 <.text+0x644>
               	b	0x4008c8 <.text+0x5c8>
               	ldurb	w21, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x4009d4 <.text+0x6d4>
               	b	0x400984 <.text+0x684>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400948 <.text+0x648>
               	mov	x24, #0x7f              // =127
               	b	0x4009d8 <.text+0x6d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x20, #0x70              // =112
               	str	w20, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x26e
               	mov	x23, x19
               	mov	x21, #0x46              // =70
               	mov	x0, x22
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4009d4 <.text+0x6d4>
               	b	0x400974 <.text+0x674>
               	sxtb	x21, w24
               	cmp	x21, #0x7f
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400a60 <.text+0x760>
               	b	0x400a10 <.text+0x710>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4009d8 <.text+0x6d8>
               	mov	x0, #0xff80             // =65408
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sturb	w0, [x29, #-0x18]
               	b	0x400a64 <.text+0x764>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0x71              // =113
               	str	w25, [x23]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x289
               	mov	x23, x19
               	mov	x21, #0x49              // =73
               	mov	x0, x22
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400a60 <.text+0x760>
               	b	0x4009f0 <.text+0x6f0>
               	ldursb	x0, [x29, #-0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400b08 <.text+0x808>
               	b	0x400ab8 <.text+0x7b8>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400a64 <.text+0x764>
               	sub	x0, x29, #0x18
               	ldrsb	x26, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x26, x26, x17
               	strb	w26, [x0]
               	b	0x400b0c <.text+0x80c>
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
               	b	0x400b08 <.text+0x808>
               	b	0x400a8c <.text+0x78c>
               	ldursb	x26, [x29, #-0x18]
               	mov	x17, #0xff              // =255
               	and	x26, x26, x17
               	mov	x17, #0x7f              // =127
               	eor	x26, x26, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	cmp	x26, #0x0
               	cset	x26, eq
               	cmp	x26, #0x0
               	b.ne	0x400ba4 <.text+0x8a4>
               	b	0x400b54 <.text+0x854>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400b0c <.text+0x80c>
               	mov	x0, #0xffff             // =65535
               	sturh	w0, [x29, #-0x20]
               	b	0x400ba8 <.text+0x8a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x22, #0x73              // =115
               	str	w22, [x21]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2bf
               	mov	x21, x19
               	mov	x26, #0x4d              // =77
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x26
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400ba4 <.text+0x8a4>
               	b	0x400b40 <.text+0x840>
               	ldurh	w0, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400c40 <.text+0x940>
               	b	0x400bf0 <.text+0x8f0>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400ba8 <.text+0x8a8>
               	sub	x0, x29, #0x20
               	ldrh	w24, [x0]
               	add	x24, x24, #0x1
               	strh	w24, [x0]
               	b	0x400c44 <.text+0x944>
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
               	b	0x400c40 <.text+0x940>
               	b	0x400bd4 <.text+0x8d4>
               	ldurh	w24, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	cmp	x24, #0x0
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x400cec <.text+0x9ec>
               	b	0x400c9c <.text+0x99c>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x400c44 <.text+0x944>
               	mov	x0, #0x0                // =0
               	sturh	w0, [x29, #-0x20]
               	sub	x24, x29, #0x20
               	ldrh	w0, [x24]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	strh	w0, [x24]
               	b	0x400cf0 <.text+0x9f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x22, #0x79              // =121
               	str	w22, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x2f5
               	mov	x26, x19
               	mov	x24, #0x55              // =85
               	mov	x0, x23
               	mov	x3, x22
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400cec <.text+0x9ec>
               	b	0x400c68 <.text+0x968>
               	ldurh	w0, [x29, #-0x20]
               	mov	x17, #0xffff            // =65535
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400d7c <.text+0xa7c>
               	b	0x400d2c <.text+0xa2c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400cf0 <.text+0x9f0>
               	mov	x22, #0x7fff            // =32767
               	b	0x400d80 <.text+0xa80>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x20, #0x7a              // =122
               	str	w20, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x310
               	mov	x26, x19
               	mov	x21, #0x58              // =88
               	mov	x0, x24
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400d7c <.text+0xa7c>
               	b	0x400d1c <.text+0xa1c>
               	sxth	x21, w22
               	mov	x17, #0x7fff            // =32767
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400e08 <.text+0xb08>
               	b	0x400db8 <.text+0xab8>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400d80 <.text+0xa80>
               	mov	x25, #0x8000            // =32768
               	movk	x25, #0xffff, lsl #16
               	movk	x25, #0xffff, lsl #32
               	movk	x25, #0xffff, lsl #48
               	b	0x400e0c <.text+0xb0c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x23, #0x7b              // =123
               	str	w23, [x26]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x32b
               	mov	x26, x19
               	mov	x21, #0x5b              // =91
               	mov	x0, x24
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400e08 <.text+0xb08>
               	b	0x400d9c <.text+0xa9c>
               	sxth	x21, w25
               	mov	x17, #0x8000            // =32768
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400e9c <.text+0xb9c>
               	b	0x400e4c <.text+0xb4c>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400e0c <.text+0xb0c>
               	sxth	x25, w25
               	mov	x17, #0xffff            // =65535
               	and	x25, x25, x17
               	b	0x400ea0 <.text+0xba0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x20, #0x7c              // =124
               	str	w20, [x22]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x346
               	mov	x22, x19
               	mov	x21, #0x5d              // =93
               	mov	x0, x26
               	mov	x3, x20
               	mov	x2, x21
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400e9c <.text+0xb9c>
               	b	0x400e34 <.text+0xb34>
               	mov	x17, #0xffff            // =65535
               	and	x21, x25, x17
               	mov	x17, #0x8000            // =32768
               	eor	x21, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x400f3c <.text+0xc3c>
               	b	0x400eec <.text+0xbec>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x400ea0 <.text+0xba0>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxtw	x0, w0
               	sxth	x20, w0
               	b	0x400f40 <.text+0xc40>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x23, #0x7d              // =125
               	str	w23, [x0]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x361
               	mov	x24, x19
               	mov	x21, #0x5f              // =95
               	mov	x0, x22
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400f3c <.text+0xc3c>
               	b	0x400ed0 <.text+0xbd0>
               	sxth	x0, w20
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x400fcc <.text+0xccc>
               	b	0x400f7c <.text+0xc7c>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x400f40 <.text+0xc40>
               	mov	x0, #0xffd6             // =65494
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxth	x23, w0
               	b	0x400fd0 <.text+0xcd0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x21, #0x7e              // =126
               	str	w21, [x25]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x37c
               	mov	x25, x19
               	mov	x26, #0x64              // =100
               	mov	x0, x24
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x400fcc <.text+0xccc>
               	b	0x400f5c <.text+0xc5c>
               	sxtw	x0, w23
               	mov	x17, #0xffd6            // =65494
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401060 <.text+0xd60>
               	b	0x401010 <.text+0xd10>
               	mov	x22, #0x0               // =0
               	cbnz	x22, 0x400fd0 <.text+0xcd0>
               	mov	x21, #0xffff            // =65535
               	mov	x17, #0xffff            // =65535
               	and	x24, x21, x17
               	b	0x401064 <.text+0xd64>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x26, #0x7f              // =127
               	str	w26, [x20]
               	mov	x22, #0x2               // =2
               	mov	x0, x22
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x397
               	mov	x20, x19
               	mov	x22, #0x69              // =105
               	mov	x0, x25
               	mov	x3, x26
               	mov	x2, x22
               	mov	x1, x20
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401060 <.text+0xd60>
               	b	0x400ff8 <.text+0xcf8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x24, x17
               	mov	x17, #0xffff            // =65535
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x4010f4 <.text+0xdf4>
               	b	0x4010a4 <.text+0xda4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401064 <.text+0xd64>
               	b	0x4010f8 <.text+0xdf8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x20, x19
               	mov	x22, #0x80              // =128
               	str	w22, [x20]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3b2
               	mov	x20, x19
               	mov	x23, #0x6e              // =110
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x23
               	mov	x1, x20
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4010f4 <.text+0xdf4>
               	b	0x401098 <.text+0xd98>
               	mov	x17, #0xffff            // =65535
               	and	x0, x21, x17
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401180 <.text+0xe80>
               	b	0x401130 <.text+0xe30>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x4010f8 <.text+0xdf8>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	stur	w0, [x29, #-0x70]
               	b	0x401184 <.text+0xe84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x26, #0x81              // =129
               	str	w26, [x23]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x24, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3cd
               	mov	x23, x19
               	mov	x27, #0x70              // =112
               	mov	x0, x24
               	mov	x3, x26
               	mov	x2, x27
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401180 <.text+0xe80>
               	b	0x401118 <.text+0xe18>
               	ldur	w0, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401210 <.text+0xf10>
               	b	0x4011c0 <.text+0xec0>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401184 <.text+0xe84>
               	sub	x0, x29, #0x70
               	ldr	w20, [x0]
               	add	x20, x20, #0x1
               	str	w20, [x0]
               	b	0x401214 <.text+0xf14>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x25, #0x82              // =130
               	str	w25, [x27]
               	mov	x20, #0x2               // =2
               	mov	x0, x20
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x3e8
               	mov	x27, x19
               	mov	x20, #0x76              // =118
               	mov	x0, x21
               	mov	x3, x25
               	mov	x2, x20
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401210 <.text+0xf10>
               	b	0x4011a4 <.text+0xea4>
               	ldur	w20, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x20, x17
               	cmp	x20, #0x0
               	cset	x20, eq
               	cmp	x20, #0x0
               	b.ne	0x4012bc <.text+0xfbc>
               	b	0x40126c <.text+0xf6c>
               	mov	x20, #0x0               // =0
               	cbnz	x20, 0x401214 <.text+0xf14>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x70]
               	sub	x20, x29, #0x70
               	ldr	w0, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	str	w0, [x20]
               	b	0x4012c0 <.text+0xfc0>
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
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4012bc <.text+0xfbc>
               	b	0x401238 <.text+0xf38>
               	ldur	w0, [x29, #-0x70]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401344 <.text+0x1044>
               	b	0x4012f4 <.text+0xff4>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x4012c0 <.text+0xfc0>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0x7fff, lsl #16
               	b	0x401348 <.text+0x1048>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x25, #0x84              // =132
               	str	w25, [x27]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x41e
               	mov	x27, x19
               	mov	x21, #0x7b              // =123
               	mov	x0, x20
               	mov	x3, x25
               	mov	x2, x21
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401344 <.text+0x1044>
               	b	0x4012e0 <.text+0xfe0>
               	sxtw	x21, w24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0x7fff, lsl #16
               	cmp	x21, x17
               	cset	x21, eq
               	cmp	x21, #0x0
               	b.ne	0x4013d4 <.text+0x10d4>
               	b	0x401384 <.text+0x1084>
               	mov	x21, #0x0               // =0
               	cbnz	x21, 0x401348 <.text+0x1048>
               	mov	x0, #0x80000000         // =2147483648
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	sxtw	x26, w0
               	b	0x4013d8 <.text+0x10d8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x23, #0x85              // =133
               	str	w23, [x27]
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	bl	0x400318 <.text+0x18>
               	mov	x20, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x439
               	mov	x27, x19
               	mov	x21, #0x7e              // =126
               	mov	x0, x20
               	mov	x3, x23
               	mov	x2, x21
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4013d4 <.text+0x10d4>
               	b	0x401368 <.text+0x1068>
               	sxtw	x0, w26
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x40145c <.text+0x115c>
               	b	0x40140c <.text+0x110c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4013d8 <.text+0x10d8>
               	sxtw	x23, w26
               	b	0x401460 <.text+0x1160>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x21, #0x86              // =134
               	str	w21, [x24]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x454
               	mov	x24, x19
               	mov	x25, #0x80              // =128
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40145c <.text+0x115c>
               	b	0x4013fc <.text+0x10fc>
               	mov	x17, #0x80000000        // =2147483648
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x23, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4014ec <.text+0x11ec>
               	b	0x40149c <.text+0x119c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401460 <.text+0x1160>
               	sxtw	x26, w26
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x26, x26, x17
               	b	0x4014f0 <.text+0x11f0>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x20, #0x87              // =135
               	str	w20, [x24]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x46f
               	mov	x24, x19
               	mov	x25, #0x86              // =134
               	mov	x0, x27
               	mov	x3, x20
               	mov	x2, x25
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4014ec <.text+0x11ec>
               	b	0x401480 <.text+0x1180>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x26, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401574 <.text+0x1274>
               	b	0x401528 <.text+0x1228>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x4014f0 <.text+0x11f0>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x98]
               	b	0x401578 <.text+0x1278>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x22, #0x88              // =136
               	str	w22, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x48a
               	mov	x23, x19
               	mov	x0, x21
               	mov	x3, x22
               	mov	x2, x22
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401574 <.text+0x1274>
               	b	0x401508 <.text+0x1208>
               	ldur	x0, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x40160c <.text+0x130c>
               	b	0x4015bc <.text+0x12bc>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401578 <.text+0x1278>
               	sub	x0, x29, #0x98
               	ldr	x25, [x0]
               	add	x25, x25, #0x1
               	str	x25, [x0]
               	b	0x401610 <.text+0x1310>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x24, #0x8c              // =140
               	str	w24, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4a5
               	mov	x23, x19
               	mov	x25, #0x8e              // =142
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40160c <.text+0x130c>
               	b	0x4015a0 <.text+0x12a0>
               	ldur	x25, [x29, #-0x98]
               	cmp	x25, #0x0
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4016a4 <.text+0x13a4>
               	b	0x401654 <.text+0x1354>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401610 <.text+0x1310>
               	sub	x0, x29, #0x98
               	ldr	x25, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x25, x25, x17
               	str	x25, [x0]
               	b	0x4016a8 <.text+0x13a8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x22, #0x8d              // =141
               	str	w22, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4c0
               	mov	x23, x19
               	mov	x25, #0x90              // =144
               	mov	x0, x21
               	mov	x3, x22
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4016a4 <.text+0x13a4>
               	b	0x401628 <.text+0x1328>
               	ldur	x25, [x29, #-0x98]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x25, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x40173c <.text+0x143c>
               	b	0x4016ec <.text+0x13ec>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4016a8 <.text+0x13a8>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0x7fff, lsl #48
               	b	0x401740 <.text+0x1440>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x24, #0x8e              // =142
               	str	w24, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4db
               	mov	x23, x19
               	mov	x25, #0x92              // =146
               	mov	x0, x26
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40173c <.text+0x143c>
               	b	0x4016d0 <.text+0x13d0>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x22, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4017d0 <.text+0x14d0>
               	b	0x401780 <.text+0x1480>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401740 <.text+0x1440>
               	mov	x27, #0xffff            // =65535
               	movk	x27, #0xffff, lsl #16
               	movk	x27, #0xffff, lsl #32
               	movk	x27, #0xffff, lsl #48
               	b	0x4017d4 <.text+0x14d4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0x8f              // =143
               	str	w21, [x23]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x4f6
               	mov	x23, x19
               	mov	x25, #0x95              // =149
               	mov	x0, x26
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4017d0 <.text+0x14d0>
               	b	0x401764 <.text+0x1464>
               	asr	x25, x27, #1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x25, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x40185c <.text+0x155c>
               	b	0x40180c <.text+0x150c>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4017d4 <.text+0x14d4>
               	mov	x21, #-0x8000000000000000 // =-9223372036854775808
               	b	0x401860 <.text+0x1560>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x24, #0x90              // =144
               	str	w24, [x22]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x511
               	mov	x22, x19
               	mov	x25, #0x9a              // =154
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x25
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x40185c <.text+0x155c>
               	b	0x4017fc <.text+0x14fc>
               	lsr	x25, x21, #1
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x25, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x4018e8 <.text+0x15e8>
               	b	0x401898 <.text+0x1598>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401860 <.text+0x1560>
               	mov	x24, #0xffff            // =65535
               	movk	x24, #0xffff, lsl #16
               	movk	x24, #0xffff, lsl #32
               	movk	x24, #0xffff, lsl #48
               	b	0x4018ec <.text+0x15ec>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x26, #0x91              // =145
               	str	w26, [x27]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x52c
               	mov	x27, x19
               	mov	x25, #0x9d              // =157
               	mov	x0, x22
               	mov	x3, x26
               	mov	x2, x25
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4018e8 <.text+0x15e8>
               	b	0x40187c <.text+0x157c>
               	lsr	x25, x24, #32
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x25, x17
               	cset	x25, eq
               	cmp	x25, #0x0
               	b.ne	0x401980 <.text+0x1680>
               	b	0x401930 <.text+0x1630>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x4018ec <.text+0x15ec>
               	mov	x26, #0xfed4            // =65236
               	movk	x26, #0xffff, lsl #16
               	movk	x26, #0xffff, lsl #32
               	movk	x26, #0xffff, lsl #48
               	sxtw	x25, w26
               	sxtb	x25, w25
               	b	0x401984 <.text+0x1684>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x23, #0x92              // =146
               	str	w23, [x21]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x547
               	mov	x21, x19
               	mov	x25, #0xa0              // =160
               	mov	x0, x27
               	mov	x3, x23
               	mov	x2, x25
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401980 <.text+0x1680>
               	b	0x40190c <.text+0x160c>
               	sxtb	x24, w25
               	mov	x21, #0xd4              // =212
               	sxtb	x21, w21
               	cmp	x24, x21
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401a00 <.text+0x1700>
               	b	0x4019b0 <.text+0x16b0>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401984 <.text+0x1684>
               	b	0x401a04 <.text+0x1704>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x21, x19
               	mov	x22, #0x96              // =150
               	str	w22, [x21]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x562
               	mov	x21, x19
               	mov	x24, #0xa9              // =169
               	mov	x0, x27
               	mov	x3, x22
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401a00 <.text+0x1700>
               	b	0x4019a4 <.text+0x16a4>
               	sxtb	x0, w25
               	mov	x17, #0xffd4            // =65492
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401a94 <.text+0x1794>
               	b	0x401a44 <.text+0x1744>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401a04 <.text+0x1704>
               	sxtw	x26, w26
               	mov	x17, #0xff              // =255
               	and	x26, x26, x17
               	b	0x401a98 <.text+0x1798>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x24, x19
               	mov	x20, #0x97              // =151
               	str	w20, [x24]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x21, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x57d
               	mov	x24, x19
               	mov	x23, #0xaa              // =170
               	mov	x0, x21
               	mov	x3, x20
               	mov	x2, x23
               	mov	x1, x24
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401a94 <.text+0x1794>
               	b	0x401a2c <.text+0x172c>
               	mov	x17, #0xff              // =255
               	and	x23, x26, x17
               	mov	x17, #0xd4              // =212
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, eq
               	cmp	x23, #0x0
               	b.ne	0x401b24 <.text+0x1824>
               	b	0x401ad4 <.text+0x17d4>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401a98 <.text+0x1798>
               	b	0x401b28 <.text+0x1828>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x25, x19
               	mov	x22, #0x98              // =152
               	str	w22, [x25]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x598
               	mov	x25, x19
               	mov	x23, #0xaf              // =175
               	mov	x0, x27
               	mov	x3, x22
               	mov	x2, x23
               	mov	x1, x25
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401b24 <.text+0x1824>
               	b	0x401ac8 <.text+0x17c8>
               	mov	x17, #0xff              // =255
               	and	x0, x26, x17
               	cmp	x0, #0xd4
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401bb0 <.text+0x18b0>
               	b	0x401b60 <.text+0x1860>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401b28 <.text+0x1828>
               	mov	x0, #0x2345             // =9029
               	movk	x0, #0x1, lsl #16
               	sxtw	x0, w0
               	sxth	x22, w0
               	b	0x401bb4 <.text+0x18b4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0x99              // =153
               	str	w21, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5b3
               	mov	x23, x19
               	mov	x24, #0xb0              // =176
               	mov	x0, x25
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401bb0 <.text+0x18b0>
               	b	0x401b44 <.text+0x1844>
               	sxth	x0, w22
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401c2c <.text+0x192c>
               	b	0x401bdc <.text+0x18dc>
               	mov	x27, #0x0               // =0
               	cbnz	x27, 0x401bb4 <.text+0x18b4>
               	b	0x401c30 <.text+0x1930>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x24, #0x9a              // =154
               	str	w24, [x26]
               	mov	x27, #0x2               // =2
               	mov	x0, x27
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5ce
               	mov	x26, x19
               	mov	x27, #0xb5              // =181
               	mov	x0, x23
               	mov	x3, x24
               	mov	x2, x27
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401c2c <.text+0x192c>
               	b	0x401bd0 <.text+0x18d0>
               	sxth	x0, w22
               	mov	x17, #0x2345            // =9029
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401cb8 <.text+0x19b8>
               	b	0x401c68 <.text+0x1968>
               	mov	x25, #0x0               // =0
               	cbnz	x25, 0x401c30 <.text+0x1930>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0x1, lsl #16
               	sxtw	x0, w0
               	sxth	x24, w0
               	b	0x401cbc <.text+0x19bc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x21, #0x9b              // =155
               	str	w21, [x27]
               	mov	x25, #0x2               // =2
               	mov	x0, x25
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5e9
               	mov	x27, x19
               	mov	x25, #0xb6              // =182
               	mov	x0, x26
               	mov	x3, x21
               	mov	x2, x25
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401cb8 <.text+0x19b8>
               	b	0x401c4c <.text+0x194c>
               	sxth	x0, w24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401d40 <.text+0x1a40>
               	b	0x401cf0 <.text+0x19f0>
               	mov	x23, #0x0               // =0
               	cbnz	x23, 0x401cbc <.text+0x19bc>
               	b	0x401d44 <.text+0x1a44>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x25, #0x9c              // =156
               	str	w25, [x22]
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x604
               	mov	x22, x19
               	mov	x23, #0xba              // =186
               	mov	x0, x27
               	mov	x3, x25
               	mov	x2, x23
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401d40 <.text+0x1a40>
               	b	0x401ce4 <.text+0x19e4>
               	sxth	x0, w24
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	0x401dd4 <.text+0x1ad4>
               	b	0x401d84 <.text+0x1a84>
               	mov	x26, #0x0               // =0
               	cbnz	x26, 0x401d44 <.text+0x1a44>
               	mov	x25, #0xffff            // =65535
               	movk	x25, #0xffff, lsl #16
               	mov	x27, #0x1               // =1
               	b	0x401dd8 <.text+0x1ad8>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x21, #0x9d              // =157
               	str	w21, [x23]
               	mov	x26, #0x2               // =2
               	mov	x0, x26
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x61f
               	mov	x23, x19
               	mov	x26, #0xbb              // =187
               	mov	x0, x22
               	mov	x3, x21
               	mov	x2, x26
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401dd4 <.text+0x1ad4>
               	b	0x401d6c <.text+0x1a6c>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x25, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x27, x17
               	cmp	x24, x23
               	cset	x24, hi
               	cmp	x24, #0x0
               	b.ne	0x401e80 <.text+0x1b80>
               	b	0x401e30 <.text+0x1b30>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401dd8 <.text+0x1ad8>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x25, x25, x17
               	sxtw	x25, w25
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x27, x27, x17
               	sxtw	x27, w27
               	b	0x401e84 <.text+0x1b84>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x26, #0xa0              // =160
               	str	w26, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x22, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x63a
               	mov	x23, x19
               	mov	x24, #0xc2              // =194
               	mov	x0, x22
               	mov	x3, x26
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401e80 <.text+0x1b80>
               	b	0x401e04 <.text+0x1b04>
               	sxtw	x24, w25
               	sxtw	x0, w27
               	cmp	x24, x0
               	cset	x24, lt
               	cmp	x24, #0x0
               	b.ne	0x401f00 <.text+0x1c00>
               	b	0x401eb0 <.text+0x1bb0>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401e84 <.text+0x1b84>
               	mov	x26, #0x1               // =1
               	b	0x401f04 <.text+0x1c04>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	mov	x20, #0xa1              // =161
               	str	w20, [x0]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x655
               	mov	x21, x19
               	mov	x24, #0xc5              // =197
               	mov	x0, x23
               	mov	x3, x20
               	mov	x2, x24
               	mov	x1, x21
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401f00 <.text+0x1c00>
               	b	0x401ea0 <.text+0x1ba0>
               	sxtw	x24, w26
               	lsl	x24, x24, #30
               	mov	x17, #0x40000000        // =1073741824
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x401f84 <.text+0x1c84>
               	b	0x401f34 <.text+0x1c34>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401f04 <.text+0x1c04>
               	mov	x23, #0x1               // =1
               	b	0x401f88 <.text+0x1c88>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x27, x19
               	mov	x22, #0xaa              // =170
               	str	w22, [x27]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x25, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x670
               	mov	x27, x19
               	mov	x24, #0xcd              // =205
               	mov	x0, x25
               	mov	x3, x22
               	mov	x2, x24
               	mov	x1, x27
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x401f84 <.text+0x1c84>
               	b	0x401f24 <.text+0x1c24>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x23, x17
               	lsl	x24, x24, #31
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x24, x17
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x402028 <.text+0x1d28>
               	b	0x401fd8 <.text+0x1cd8>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x401f88 <.text+0x1c88>
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	b	0x40202c <.text+0x1d2c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x26, x19
               	mov	x21, #0xab              // =171
               	str	w21, [x26]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x27, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x68b
               	mov	x26, x19
               	mov	x24, #0xcf              // =207
               	mov	x0, x27
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x26
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x402028 <.text+0x1d28>
               	b	0x401fbc <.text+0x1cbc>
               	sxtw	x24, w22
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x4020b8 <.text+0x1db8>
               	b	0x402068 <.text+0x1d68>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x40202c <.text+0x1d2c>
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	b	0x4020bc <.text+0x1dbc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x23, x19
               	mov	x25, #0xac              // =172
               	str	w25, [x23]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x26, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6a6
               	mov	x23, x19
               	mov	x24, #0xd3              // =211
               	mov	x0, x26
               	mov	x3, x25
               	mov	x2, x24
               	mov	x1, x23
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x4020b8 <.text+0x1db8>
               	b	0x402054 <.text+0x1d54>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x24, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x24, x17
               	cset	x24, eq
               	cmp	x24, #0x0
               	b.ne	0x402158 <.text+0x1e58>
               	b	0x402108 <.text+0x1e08>
               	mov	x24, #0x0               // =0
               	cbnz	x24, 0x4020bc <.text+0x1dbc>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	ldrsw	x24, [x0]
               	cmp	x24, #0x0
               	b.ne	0x4021a8 <.text+0x1ea8>
               	b	0x40215c <.text+0x1e5c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x22, x19
               	mov	x27, #0xad              // =173
               	str	w27, [x22]
               	mov	x24, #0x2               // =2
               	mov	x0, x24
               	bl	0x400318 <.text+0x18>
               	mov	x23, x0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6c1
               	mov	x22, x19
               	mov	x24, #0xd5              // =213
               	mov	x0, x23
               	mov	x3, x27
               	mov	x2, x24
               	mov	x1, x22
               	bl	0x402334 <fprintf>
               	sxtw	x0, w0
               	b	0x402158 <.text+0x1e58>
               	b	0x4020e4 <.text+0x1de4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0x6dc
               	mov	x25, x19
               	mov	x0, x25
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
               	mov	x25, x19
               	ldrsw	x0, [x25]
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
