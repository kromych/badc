
designated_initializers.aarch64:	file format elf64-littleaarch64

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
               	bl	0x400b48 <dlsym>
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
               	cset	x14, ne
               	stur	x14, [x29, #-0x90]
               	cbnz	x14, 0x400434 <.text+0x1b4>
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldrsw	x14, [x13]
               	cmp	x14, #0x2
               	cset	x14, ne
               	stur	x14, [x29, #-0x90]
               	b	0x400434 <.text+0x1b4>
               	ldur	x14, [x29, #-0x90]
               	cbz	x14, 0x400450 <.text+0x1d0>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x150
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldr	x10, [sp], #0x10
               	mov	x15, x14
               	sub	x15, x29, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0xa
               	cset	x0, ne
               	stur	x0, [x29, #-0x98]
               	cbnz	x0, 0x4004a8 <.text+0x228>
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x14
               	cset	x0, ne
               	stur	x0, [x29, #-0x98]
               	b	0x4004a8 <.text+0x228>
               	ldur	x0, [x29, #-0x98]
               	cbz	x0, 0x4004c8 <.text+0x248>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x158
               	mov	x15, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x14, x0
               	sub	x14, x29, #0x18
               	ldrsw	x15, [x14]
               	cmp	x15, #0x0
               	cset	x15, ne
               	stur	x15, [x29, #-0xa0]
               	cbnz	x15, 0x400520 <.text+0x2a0>
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x4
               	ldrsw	x15, [x14]
               	cmp	x15, #0x63
               	cset	x15, ne
               	stur	x15, [x29, #-0xa0]
               	b	0x400520 <.text+0x2a0>
               	ldur	x15, [x29, #-0xa0]
               	cbz	x15, 0x40053c <.text+0x2bc>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x160
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x15]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x15, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x15, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x15, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x15, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x14, x15
               	sub	x14, x29, #0x28
               	ldrsw	x0, [x14]
               	cmp	x0, #0x1
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	cbnz	x0, 0x4005b4 <.text+0x334>
               	sub	x14, x29, #0x28
               	add	x14, x14, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x2
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	b	0x4005b4 <.text+0x334>
               	ldur	x0, [x29, #-0xb0]
               	stur	x0, [x29, #-0xa8]
               	cbnz	x0, 0x4005dc <.text+0x35c>
               	sub	x14, x29, #0x28
               	add	x14, x14, #0x8
               	ldrsw	x0, [x14]
               	cmp	x0, #0x3
               	cset	x0, ne
               	stur	x0, [x29, #-0xa8]
               	b	0x4005dc <.text+0x35c>
               	ldur	x0, [x29, #-0xa8]
               	cbz	x0, 0x4005fc <.text+0x37c>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x19, 0x410000
               	add	x19, x19, #0x16c
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x15, x0
               	sub	x15, x29, #0x30
               	ldrsw	x14, [x15]
               	cmp	x14, #0x7
               	cset	x14, ne
               	stur	x14, [x29, #-0xb8]
               	cbnz	x14, 0x400654 <.text+0x3d4>
               	sub	x15, x29, #0x30
               	add	x15, x15, #0x4
               	ldrsw	x14, [x15]
               	cmp	x14, #0xe
               	cset	x14, ne
               	stur	x14, [x29, #-0xb8]
               	b	0x400654 <.text+0x3d4>
               	ldur	x14, [x29, #-0xb8]
               	cbz	x14, 0x400670 <.text+0x3f0>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x48
               	adrp	x19, 0x410000
               	add	x19, x19, #0x174
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x14]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x14, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x14, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x14, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x14, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x14, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x15, x14
               	sub	x15, x29, #0x48
               	ldrsw	x0, [x15]
               	cmp	x0, #0xa
               	b.eq	0x4006e4 <.text+0x464>
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0x4
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x40070c <.text+0x48c>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x48
               	add	x15, x15, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x400738 <.text+0x4b8>
               	mov	x15, #0xd               // =13
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	add	x0, x0, #0xc
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400760 <.text+0x4e0>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x48
               	add	x15, x15, #0x10
               	ldrsw	x0, [x15]
               	cmp	x0, #0x32
               	b.eq	0x40078c <.text+0x50c>
               	mov	x15, #0xf               // =15
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	adrp	x19, 0x410000
               	add	x19, x19, #0x188
               	mov	x15, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x0]
               	ldr	x10, [x15, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x15, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x15, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x15, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [sp], #0x10
               	mov	x14, x0
               	sub	x14, x29, #0x70
               	ldrsw	x15, [x14]
               	cmp	x15, #0x0
               	b.eq	0x4007f4 <.text+0x574>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0xc8
               	b.eq	0x400820 <.text+0x5a0>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x14
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400848 <.text+0x5c8>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x1c
               	ldrsw	x0, [x15]
               	cmp	x0, #0x2bc
               	b.eq	0x400874 <.text+0x5f4>
               	mov	x15, #0x18              // =24
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x40089c <.text+0x61c>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x24
               	ldrsw	x0, [x15]
               	cmp	x0, #0x384
               	b.eq	0x4008c8 <.text+0x648>
               	mov	x15, #0x1a              // =26
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	adrp	x19, 0x410000
               	add	x19, x19, #0x1b0
               	mov	x15, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x0]
               	ldr	x10, [x15, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x15, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x14, x0
               	sub	x14, x29, #0x88
               	ldrsw	x15, [x14]
               	cmp	x15, #0x1
               	b.eq	0x400920 <.text+0x6a0>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x88
               	add	x15, x15, #0x4
               	ldrsw	x0, [x15]
               	cmp	x0, #0x2
               	b.eq	0x40094c <.text+0x6cc>
               	mov	x15, #0x20              // =32
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x0
               	b.eq	0x400974 <.text+0x6f4>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x88
               	add	x15, x15, #0xc
               	ldrsw	x0, [x15]
               	cmp	x0, #0x0
               	b.eq	0x4009a0 <.text+0x720>
               	mov	x15, #0x22              // =34
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	add	x0, x0, #0x10
               	ldrsw	x15, [x0]
               	cmp	x15, #0x32
               	b.eq	0x4009c8 <.text+0x748>
               	mov	x0, #0x23               // =35
               	ldr	x19, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x88
               	add	x15, x15, #0x14
               	ldrsw	x0, [x15]
               	cmp	x0, #0x3c
               	b.eq	0x4009f4 <.text+0x774>
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
