
array_initializers.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x15e
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldrb	w10, [x14, #0x1]
               	strb	w10, [x15, #0x1]
               	ldrb	w10, [x14, #0x2]
               	strb	w10, [x15, #0x2]
               	ldrb	w10, [x14, #0x3]
               	strb	w10, [x15, #0x3]
               	ldrb	w10, [x14, #0x4]
               	strb	w10, [x15, #0x4]
               	ldrb	w10, [x14, #0x5]
               	strb	w10, [x15, #0x5]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x164
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldrb	w10, [x14, #0x8]
               	strb	w10, [x13, #0x8]
               	ldrb	w10, [x14, #0x9]
               	strb	w10, [x13, #0x9]
               	ldrb	w10, [x14, #0xa]
               	strb	w10, [x13, #0xa]
               	ldrb	w10, [x14, #0xb]
               	strb	w10, [x13, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	sub	x15, x29, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0x173
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x15]
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	sub	x13, x29, #0x38
               	adrp	x19, 0x410000
               	add	x19, x19, #0x17b
               	mov	x14, x19
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldr	x10, [x14, #0x8]
               	str	x10, [x13, #0x8]
               	ldrb	w10, [x14, #0x10]
               	strb	w10, [x13, #0x10]
               	ldrb	w10, [x14, #0x11]
               	strb	w10, [x13, #0x11]
               	ldrb	w10, [x14, #0x12]
               	strb	w10, [x13, #0x12]
               	ldrb	w10, [x14, #0x13]
               	strb	w10, [x13, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x15, x13
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd6
               	mov	x15, x19
               	ldrb	w14, [x15]
               	mov	x17, #0x68              // =104
               	eor	x15, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x15, x17
               	cmp	x14, #0x0
               	b.eq	0x400388 <.text+0x168>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd6
               	mov	x15, x19
               	add	x0, x15, #0x4
               	ldrb	w15, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x0, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x4003d0 <.text+0x1b0>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd6
               	mov	x0, x19
               	add	x15, x0, #0x5
               	ldrb	w0, [x15]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x0, x17
               	cmp	x15, #0x0
               	b.eq	0x400410 <.text+0x1f0>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400430 <.text+0x210>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe0
               	mov	x0, x19
               	ldrsw	x15, [x0]
               	add	x13, x0, #0x4
               	ldrsw	x12, [x13]
               	add	x13, x15, x12
               	sxtw	x13, w13
               	add	x12, x0, #0x8
               	ldrsw	x15, [x12]
               	add	x12, x13, x15
               	sxtw	x12, w12
               	add	x15, x0, #0xc
               	ldrsw	x13, [x15]
               	add	x15, x12, x13
               	sxtw	x15, w15
               	add	x13, x0, #0x10
               	ldrsw	x0, [x13]
               	add	x13, x15, x0
               	sxtw	x13, w13
               	cmp	x13, #0x1c
               	b.eq	0x4004a0 <.text+0x280>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4004c0 <.text+0x2a0>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	ldrb	w13, [x0]
               	mov	x17, #0x68              // =104
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x400504 <.text+0x2e4>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	add	x13, x0, #0x1
               	ldrb	w0, [x13]
               	mov	x17, #0x69              // =105
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400548 <.text+0x328>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	add	x0, x13, #0x2
               	ldrb	w13, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400584 <.text+0x364>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	add	x0, x13, #0xf
               	ldrb	w13, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x4005c0 <.text+0x3a0>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	cbz	x13, 0x4005dc <.text+0x3bc>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x13, x19
               	ldrsw	x0, [x13]
               	cmp	x0, #0x1
               	b.eq	0x400608 <.text+0x3e8>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x13, x19
               	add	x0, x13, #0x8
               	ldrsw	x13, [x0]
               	cmp	x13, #0x3
               	b.eq	0x40063c <.text+0x41c>
               	mov	x13, #0xd               // =13
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x0, x19
               	add	x13, x0, #0xc
               	ldrsw	x0, [x13]
               	cmp	x0, #0x0
               	b.eq	0x40066c <.text+0x44c>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x13, x19
               	add	x0, x13, #0x10
               	ldrsw	x13, [x0]
               	cmp	x13, #0x0
               	b.eq	0x4006a0 <.text+0x480>
               	mov	x13, #0xf               // =15
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x140
               	mov	x0, x19
               	ldr	x13, [x0]
               	ldrb	w0, [x13]
               	mov	x17, #0x61              // =97
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x4006e4 <.text+0x4c4>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x140
               	mov	x13, x19
               	add	x0, x13, #0x8
               	ldr	x13, [x0]
               	ldrb	w0, [x13]
               	mov	x17, #0x62              // =98
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x40072c <.text+0x50c>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0x140
               	mov	x13, x19
               	add	x0, x13, #0x10
               	ldr	x13, [x0]
               	add	x0, x13, #0x4
               	ldrb	w13, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x40077c <.text+0x55c>
               	mov	x13, #0x12              // =18
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrb	w13, [x0]
               	mov	x17, #0x77              // =119
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x4007b8 <.text+0x598>
               	mov	x13, #0x13              // =19
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x13, x0, #0x4
               	ldrb	w0, [x13]
               	mov	x17, #0x64              // =100
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x4007f4 <.text+0x5d4>
               	mov	x0, #0x14               // =20
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	add	x0, x13, #0x5
               	ldrb	w13, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400828 <.text+0x608>
               	mov	x0, #0x15               // =21
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	cbz	x13, 0x400844 <.text+0x624>
               	mov	x0, #0x16               // =22
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	ldrsw	x0, [x13]
               	sub	x13, x29, #0x18
               	add	x15, x13, #0x4
               	ldrsw	x13, [x15]
               	add	x15, x0, x13
               	sxtw	x15, w15
               	sub	x13, x29, #0x18
               	add	x0, x13, #0x8
               	ldrsw	x13, [x0]
               	add	x0, x15, x13
               	sxtw	x0, w0
               	cmp	x0, #0x258
               	b.eq	0x400890 <.text+0x670>
               	mov	x0, #0x17               // =23
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	cbz	x13, 0x4008ac <.text+0x68c>
               	mov	x0, #0x18               // =24
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	ldrb	w0, [x13]
               	mov	x17, #0x6f              // =111
               	eor	x13, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x4008e4 <.text+0x6c4>
               	mov	x0, #0x19               // =25
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x1
               	ldrb	w13, [x0]
               	mov	x17, #0x6b              // =107
               	eor	x0, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x400924 <.text+0x704>
               	mov	x13, #0x1a              // =26
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	add	x13, x0, #0x2
               	ldrb	w0, [x13]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x0, x17
               	cmp	x13, #0x0
               	b.eq	0x40095c <.text+0x73c>
               	mov	x13, #0x1b              // =27
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	ldrsw	x13, [x0]
               	cmp	x13, #0x64
               	b.eq	0x400984 <.text+0x764>
               	mov	x13, #0x1c              // =28
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	add	x13, x0, #0x8
               	ldrsw	x0, [x13]
               	cmp	x0, #0x12c
               	b.eq	0x4009ac <.text+0x78c>
               	mov	x0, #0x1d               // =29
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x38
               	add	x0, x13, #0xc
               	ldrsw	x13, [x0]
               	cmp	x13, #0x0
               	b.eq	0x4009d8 <.text+0x7b8>
               	mov	x13, #0x1e              // =30
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x38
               	add	x13, x0, #0x10
               	ldrsw	x0, [x13]
               	cmp	x0, #0x0
               	b.eq	0x400a00 <.text+0x7e0>
               	mov	x0, #0x1f               // =31
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x3
               	ldrb	w13, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400a34 <.text+0x814>
               	mov	x0, #0x20               // =32
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x7
               	ldrb	w13, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x13, x17
               	cmp	x0, #0x0
               	b.eq	0x400a68 <.text+0x848>
               	mov	x0, #0x21               // =33
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
