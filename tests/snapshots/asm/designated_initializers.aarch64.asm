
designated_initializers.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400b48 <dlsym>
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
               	sub	sp, sp, #0xd0
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x148
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	cmp	x14, #0x1
               	cset	x13, ne
               	stur	x13, [x29, #-0x90]
               	cbnz	x13, 0x400438 <.text+0x1b8>
               	sub	x14, x29, #0x8
               	add	x13, x14, #0x4
               	ldrsw	x14, [x13]
               	cmp	x14, #0x2
               	cset	x13, ne
               	stur	x13, [x29, #-0x90]
               	b	0x400438 <.text+0x1b8>
               	ldur	x13, [x29, #-0x90]
               	cbz	x13, 0x400454 <.text+0x1d4>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x13]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	sub	x15, x29, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0xa
               	cset	x15, ne
               	stur	x15, [x29, #-0x98]
               	cbnz	x15, 0x4004ac <.text+0x22c>
               	sub	x0, x29, #0x10
               	add	x15, x0, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x14
               	cset	x15, ne
               	stur	x15, [x29, #-0x98]
               	b	0x4004ac <.text+0x22c>
               	ldur	x15, [x29, #-0x98]
               	cbz	x15, 0x4004c8 <.text+0x248>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x18
               	ldrsw	x0, [x13]
               	cmp	x0, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0xa0]
               	cbnz	x13, 0x400520 <.text+0x2a0>
               	sub	x0, x29, #0x18
               	add	x13, x0, #0x4
               	ldrsw	x0, [x13]
               	cmp	x0, #0x63
               	cset	x13, ne
               	stur	x13, [x29, #-0xa0]
               	b	0x400520 <.text+0x2a0>
               	ldur	x13, [x29, #-0xa0]
               	cbz	x13, 0x40053c <.text+0x2bc>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x13]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x13, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x13, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x13, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x13, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	sub	x15, x29, #0x28
               	ldrsw	x0, [x15]
               	cmp	x0, #0x1
               	cset	x15, ne
               	stur	x15, [x29, #-0xb0]
               	cbnz	x15, 0x4005b4 <.text+0x334>
               	sub	x0, x29, #0x28
               	add	x15, x0, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x2
               	cset	x15, ne
               	stur	x15, [x29, #-0xb0]
               	b	0x4005b4 <.text+0x334>
               	ldur	x15, [x29, #-0xb0]
               	stur	x15, [x29, #-0xa8]
               	cbnz	x15, 0x4005dc <.text+0x35c>
               	sub	x0, x29, #0x28
               	add	x15, x0, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x3
               	cset	x15, ne
               	stur	x15, [x29, #-0xa8]
               	b	0x4005dc <.text+0x35c>
               	ldur	x15, [x29, #-0xa8]
               	cbz	x15, 0x4005f8 <.text+0x378>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x30
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16c
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x30
               	ldrsw	x0, [x13]
               	cmp	x0, #0x7
               	cset	x13, ne
               	stur	x13, [x29, #-0xb8]
               	cbnz	x13, 0x400650 <.text+0x3d0>
               	sub	x0, x29, #0x30
               	add	x13, x0, #0x4
               	ldrsw	x0, [x13]
               	cmp	x0, #0xe
               	cset	x13, ne
               	stur	x13, [x29, #-0xb8]
               	b	0x400650 <.text+0x3d0>
               	ldur	x13, [x29, #-0xb8]
               	cbz	x13, 0x40066c <.text+0x3ec>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x48
               	adrp	x19, 0x410000
               	add	x19, x19, #0x174
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x13]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x13, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x13, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x13, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x13, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x13, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	sub	x15, x29, #0x48
               	ldrsw	x0, [x15]
               	cmp	x0, #0xa
               	b.eq	0x4006dc <.text+0x45c>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x48
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400708 <.text+0x488>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x15, x0, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x400730 <.text+0x4b0>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x48
               	add	x0, x15, #0xc
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x40075c <.text+0x4dc>
               	mov	x15, #0xe               // =14
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x15, x0, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0x32
               	b.eq	0x400784 <.text+0x504>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x15]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x15, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x15, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x15, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x15, #0x20]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x70
               	ldrsw	x0, [x13]
               	cmp	x0, #0x0
               	b.eq	0x4007ec <.text+0x56c>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x8
               	ldrsw	x13, [x0]
               	cmp	x13, #0xc8
               	b.eq	0x400818 <.text+0x598>
               	mov	x13, #0x16              // =22
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x13, x0, #0x14
               	ldrsw	x0, [x13]
               	cmp	x0, #0x0
               	b.eq	0x400840 <.text+0x5c0>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x1c
               	ldrsw	x13, [x0]
               	cmp	x13, #0x2bc
               	b.eq	0x40086c <.text+0x5ec>
               	mov	x13, #0x18              // =24
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x13, x0, #0x20
               	ldrsw	x0, [x13]
               	cmp	x0, #0x0
               	b.eq	0x400894 <.text+0x614>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x24
               	ldrsw	x13, [x0]
               	cmp	x13, #0x384
               	b.eq	0x4008c0 <.text+0x640>
               	mov	x13, #0x1a              // =26
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x13, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x13]
               	str	x10, [x0]
               	ldr	x10, [x13, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x13, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x15, x0
               	sub	x15, x29, #0x88
               	ldrsw	x13, [x15]
               	cmp	x13, #0x1
               	b.eq	0x400918 <.text+0x698>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x88
               	add	x0, x15, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x2
               	b.eq	0x400944 <.text+0x6c4>
               	mov	x15, #0x20              // =32
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x15, x0, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x40096c <.text+0x6ec>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x88
               	add	x0, x15, #0xc
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400998 <.text+0x718>
               	mov	x15, #0x22              // =34
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x15, x0, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0x32
               	b.eq	0x4009c0 <.text+0x740>
               	mov	x0, #0x23               // =35
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x88
               	add	x0, x15, #0x14
               	ldrsw	x15, [x0]
               	cmp	x15, #0x3c
               	b.eq	0x4009ec <.text+0x76c>
               	mov	x15, #0x24              // =36
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
