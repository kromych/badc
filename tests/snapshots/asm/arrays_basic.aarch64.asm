
arrays_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002a8 <.text+0x88>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x15, x0
               	sxtw	x14, w1
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x8]
               	stur	w13, [x29, #-0x10]
               	b	0x40025c <.text+0x3c>
               	ldursw	x13, [x29, #-0x10]
               	cmp	x13, x14
               	b.ge	0x400298 <.text+0x78>
               	ldursw	x13, [x29, #-0x8]
               	ldursw	x12, [x29, #-0x10]
               	lsl	x11, x12, #2
               	add	x10, x15, x11
               	ldrsw	x11, [x10]
               	add	x10, x13, x11
               	sxtw	x10, w10
               	stur	w10, [x29, #-0x8]
               	add	x11, x12, #0x1
               	sxtw	x11, w11
               	stur	w11, [x29, #-0x10]
               	b	0x40025c <.text+0x3c>
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x20]
               	b	0x4002cc <.text+0xac>
               	ldursw	x15, [x29, #-0x20]
               	cmp	x15, #0x5
               	b.ge	0x400308 <.text+0xe8>
               	sub	x15, x29, #0x18
               	ldursw	x14, [x29, #-0x20]
               	lsl	x13, x14, #2
               	add	x12, x15, x13
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	str	w13, [x12]
               	ldursw	x14, [x29, #-0x20]
               	add	x13, x14, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x20]
               	b	0x4002cc <.text+0xac>
               	sub	x20, x29, #0x18
               	mov	x21, #0x5               // =5
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x12, x0
               	cmp	x12, #0xf
               	b.eq	0x400348 <.text+0x128>
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	cbz	x21, 0x400370 <.text+0x150>
               	mov	x12, #0x2               // =2
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x20]
               	b	0x40037c <.text+0x15c>
               	ldursw	x21, [x29, #-0x20]
               	cmp	x21, #0x5
               	b.ge	0x4003c4 <.text+0x1a4>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x21, x19
               	ldursw	x12, [x29, #-0x20]
               	lsl	x20, x12, #2
               	add	x15, x21, x20
               	mov	x17, #0xa               // =10
               	mul	x20, x12, x17
               	sxtw	x20, w20
               	str	w20, [x15]
               	ldursw	x12, [x29, #-0x20]
               	add	x20, x12, #0x1
               	sxtw	x20, w20
               	stur	w20, [x29, #-0x20]
               	b	0x40037c <.text+0x15c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x20, x19
               	ldrsw	x12, [x20]
               	add	x15, x20, #0x4
               	ldrsw	x21, [x15]
               	add	x15, x12, x21
               	sxtw	x15, w15
               	add	x21, x20, #0x8
               	ldrsw	x12, [x21]
               	add	x21, x15, x12
               	sxtw	x21, w21
               	add	x12, x20, #0xc
               	ldrsw	x15, [x12]
               	add	x12, x21, x15
               	sxtw	x12, w12
               	add	x15, x20, #0x10
               	ldrsw	x20, [x15]
               	add	x15, x12, x20
               	sxtw	x15, w15
               	cmp	x15, #0x64
               	b.eq	0x40043c <.text+0x21c>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	cbz	x20, 0x400464 <.text+0x244>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	cbz	x20, 0x40048c <.text+0x26c>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x20, x19
               	mov	x15, #0x0               // =0
               	mov	x12, #0x68              // =104
               	strb	w12, [x20]
               	add	x21, x20, #0x1
               	mov	x12, #0x69              // =105
               	strb	w12, [x21]
               	add	x11, x20, #0x2
               	strb	w15, [x11]
               	ldrb	w12, [x20]
               	mov	x17, #0x68              // =104
               	eor	x20, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x20, x17
               	cmp	x12, #0x0
               	b.eq	0x4004f8 <.text+0x2d8>
               	mov	x12, #0x6               // =6
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x20, x19
               	add	x12, x20, #0x1
               	ldrb	w20, [x12]
               	mov	x17, #0x69              // =105
               	eor	x12, x20, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x12, x17
               	cmp	x20, #0x0
               	b.eq	0x400548 <.text+0x328>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x12, x19
               	add	x20, x12, #0x2
               	ldrb	w12, [x20]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x20, x12, x17
               	cmp	x20, #0x0
               	b.eq	0x400590 <.text+0x370>
               	mov	x20, #0x8               // =8
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x20]
               	b	0x40059c <.text+0x37c>
               	ldursw	x12, [x29, #-0x20]
               	cmp	x12, #0x3
               	b.ge	0x4005f4 <.text+0x3d4>
               	sub	x12, x29, #0x40
               	ldursw	x20, [x29, #-0x20]
               	lsl	x11, x20, #3
               	add	x15, x12, x11
               	str	w20, [x15]
               	sub	x11, x29, #0x40
               	ldursw	x15, [x29, #-0x20]
               	lsl	x20, x15, #3
               	add	x12, x11, x20
               	add	x20, x12, #0x4
               	mov	x17, #0x64              // =100
               	mul	x12, x15, x17
               	sxtw	x12, w12
               	str	w12, [x20]
               	ldursw	x15, [x29, #-0x20]
               	add	x12, x15, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x20]
               	b	0x40059c <.text+0x37c>
               	sub	x12, x29, #0x40
               	ldrsw	x15, [x12]
               	cmp	x15, #0x0
               	b.eq	0x400624 <.text+0x404>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x40
               	add	x15, x12, #0x8
               	ldrsw	x12, [x15]
               	cmp	x12, #0x1
               	b.eq	0x400658 <.text+0x438>
               	mov	x12, #0xa               // =10
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x40
               	add	x12, x15, #0x14
               	ldrsw	x15, [x12]
               	cmp	x15, #0xc8
               	b.eq	0x40068c <.text+0x46c>
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x12, #0x0               // =0
               	cbz	x12, 0x4006b4 <.text+0x494>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x68
               	add	x15, x12, #0x20
               	mov	x12, #0x0               // =0
               	str	w12, [x15]
               	stur	w12, [x29, #-0x20]
               	b	0x4006cc <.text+0x4ac>
               	ldursw	x12, [x29, #-0x20]
               	cmp	x12, #0x8
               	b.ge	0x40073c <.text+0x51c>
               	sub	x12, x29, #0x68
               	ldursw	x20, [x29, #-0x20]
               	lsl	x15, x20, #2
               	add	x11, x12, x15
               	add	x15, x20, #0x1
               	sxtw	x15, w15
               	str	w15, [x11]
               	sub	x20, x29, #0x68
               	add	x15, x20, #0x20
               	sub	x20, x29, #0x68
               	add	x11, x20, #0x20
               	ldrsw	x20, [x11]
               	sub	x11, x29, #0x68
               	ldursw	x12, [x29, #-0x20]
               	lsl	x21, x12, #2
               	add	x12, x11, x21
               	ldrsw	x21, [x12]
               	add	x12, x20, x21
               	sxtw	x12, w12
               	str	w12, [x15]
               	ldursw	x21, [x29, #-0x20]
               	add	x12, x21, #0x1
               	sxtw	x12, w12
               	stur	w12, [x29, #-0x20]
               	b	0x4006cc <.text+0x4ac>
               	sub	x12, x29, #0x68
               	add	x21, x12, #0x20
               	ldrsw	x12, [x21]
               	cmp	x12, #0x24
               	b.eq	0x400770 <.text+0x550>
               	mov	x12, #0xd               // =13
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x20]
               	b	0x40077c <.text+0x55c>
               	ldursw	x21, [x29, #-0x20]
               	cmp	x21, #0x8
               	b.ge	0x4007b4 <.text+0x594>
               	sub	x21, x29, #0x70
               	ldursw	x12, [x29, #-0x20]
               	add	x15, x21, x12
               	add	x21, x12, #0x41
               	sxtw	x21, w21
               	strb	w21, [x15]
               	ldursw	x12, [x29, #-0x20]
               	add	x21, x12, #0x1
               	sxtw	x21, w21
               	stur	w21, [x29, #-0x20]
               	b	0x40077c <.text+0x55c>
               	sub	x21, x29, #0x70
               	ldrb	w12, [x21]
               	mov	x17, #0x41              // =65
               	eor	x21, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x21, x17
               	cmp	x12, #0x0
               	b.eq	0x4007f8 <.text+0x5d8>
               	mov	x12, #0xe               // =14
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x70
               	add	x12, x21, #0x7
               	ldrb	w21, [x12]
               	mov	x17, #0x48              // =72
               	eor	x12, x21, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x12, x17
               	cmp	x21, #0x0
               	b.eq	0x400840 <.text+0x620>
               	mov	x21, #0xf               // =15
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x18
               	add	x21, x12, #0x8
               	ldrsw	x12, [x21]
               	add	x15, x21, #0x4
               	ldrsw	x20, [x15]
               	add	x15, x12, x20
               	sxtw	x15, w15
               	add	x20, x21, #0x8
               	ldrsw	x21, [x20]
               	add	x20, x15, x21
               	sxtw	x20, w20
               	sxtw	x21, w20
               	cmp	x21, #0xc
               	b.eq	0x400898 <.text+0x678>
               	mov	x21, #0x10              // =16
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
