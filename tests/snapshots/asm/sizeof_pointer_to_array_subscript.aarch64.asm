
sizeof_pointer_to_array_subscript.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0xa0
               	str	x19, [sp]
               	sub	x15, x29, #0x70
               	adrp	x19, 0x410000
               	add	x19, x19, #0x553
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x560
               	mov	x13, x19
               	str	x13, [x14]
               	sub	x15, x29, #0x70
               	add	x13, x15, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x570
               	mov	x15, x19
               	str	x15, [x13]
               	sub	x14, x29, #0x70
               	add	x15, x14, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x590
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5d0
               	mov	x13, x19
               	str	x13, [x14]
               	sub	x15, x29, #0x70
               	add	x13, x15, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x610
               	mov	x15, x19
               	str	x15, [x13]
               	sub	x14, x29, #0x70
               	ldr	x15, [x14]
               	add	x14, x15, #0x8
               	sub	x15, x29, #0x70
               	ldr	x13, [x15]
               	sub	x15, x14, x13
               	cmp	x15, #0x8
               	b.eq	0x400308 <.text+0xe8>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x8
               	ldr	x13, [x0]
               	add	x0, x13, #0x10
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x8
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x10
               	b.eq	0x400344 <.text+0x124>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x10
               	ldr	x13, [x0]
               	add	x0, x13, #0x20
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x10
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x20
               	b.eq	0x400380 <.text+0x160>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x18
               	ldr	x13, [x0]
               	add	x0, x13, #0x40
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x18
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x40
               	b.eq	0x4003bc <.text+0x19c>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x20
               	ldr	x13, [x0]
               	add	x0, x13, #0x3c
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x20
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x3c
               	b.eq	0x4003f8 <.text+0x1d8>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x20
               	ldr	x13, [x0]
               	add	x0, x13, #0x14
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x20
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x14
               	b.eq	0x400434 <.text+0x214>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x28
               	ldr	x13, [x0]
               	add	x0, x13, #0x18
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x28
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x18
               	b.eq	0x400470 <.text+0x250>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x28
               	ldr	x13, [x0]
               	add	x0, x13, #0xc
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x28
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0xc
               	b.eq	0x4004ac <.text+0x28c>
               	mov	x0, #0x12               // =18
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x28
               	ldr	x13, [x0]
               	add	x0, x13, #0x4
               	sub	x13, x29, #0x70
               	add	x14, x13, #0x28
               	ldr	x13, [x14]
               	sub	x14, x0, x13
               	cmp	x14, #0x4
               	b.eq	0x4004e8 <.text+0x2c8>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	0x4004f4 <.text+0x2d4>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x8
               	b.ge	0x400544 <.text+0x324>
               	b	0x400518 <.text+0x2f8>
               	sub	x13, x29, #0x78
               	ldrsw	x0, [x13]
               	add	x14, x0, #0x1
               	str	w14, [x13]
               	b	0x4004f4 <.text+0x2d4>
               	sub	x14, x29, #0x70
               	add	x0, x14, #0x8
               	ldr	x14, [x0]
               	ldursw	x0, [x29, #-0x78]
               	lsl	x13, x0, #1
               	add	x12, x14, x13
               	add	x13, x0, #0x3e8
               	sxtw	x13, w13
               	sxth	x13, w13
               	strh	w13, [x12]
               	b	0x400504 <.text+0x2e4>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	0x400550 <.text+0x330>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x8
               	b.ge	0x4005a8 <.text+0x388>
               	b	0x400574 <.text+0x354>
               	sub	x13, x29, #0x78
               	ldrsw	x0, [x13]
               	add	x12, x0, #0x1
               	str	w12, [x13]
               	b	0x400550 <.text+0x330>
               	sub	x12, x29, #0x70
               	add	x0, x12, #0x8
               	ldr	x12, [x0]
               	ldursw	x0, [x29, #-0x78]
               	lsl	x13, x0, #1
               	add	x14, x12, x13
               	ldrsh	x13, [x14]
               	add	x14, x0, #0x3e8
               	sxtw	x14, w14
               	sxth	x14, w14
               	cmp	x13, x14
               	b.eq	0x4005d0 <.text+0x3b0>
               	b	0x4005b4 <.text+0x394>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x4005d4 <.text+0x3b4>
               	ldursw	x14, [x29, #-0x78]
               	add	x0, x14, #0x14
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400560 <.text+0x340>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	0x40062c <.text+0x40c>
               	b	0x4005f8 <.text+0x3d8>
               	sub	x14, x29, #0x78
               	ldrsw	x0, [x14]
               	add	x13, x0, #0x1
               	str	w13, [x14]
               	b	0x4005d4 <.text+0x3b4>
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x8
               	ldr	x13, [x0]
               	ldursw	x0, [x29, #-0x78]
               	lsl	x14, x0, #1
               	add	x12, x13, x14
               	ldrsh	x14, [x12]
               	add	x12, x0, #0x3e8
               	sxtw	x12, w12
               	sxth	x12, w12
               	cmp	x14, x12
               	b.eq	0x400654 <.text+0x434>
               	b	0x400638 <.text+0x418>
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x78]
               	b	0x400658 <.text+0x438>
               	ldursw	x12, [x29, #-0x78]
               	add	x0, x12, #0x1c
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4005e4 <.text+0x3c4>
               	ldursw	x12, [x29, #-0x78]
               	cmp	x12, #0x3
               	b.ge	0x400688 <.text+0x468>
               	b	0x40067c <.text+0x45c>
               	sub	x12, x29, #0x78
               	ldrsw	x0, [x12]
               	add	x14, x0, #0x1
               	str	w14, [x12]
               	b	0x400658 <.text+0x438>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x400694 <.text+0x474>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x78]
               	b	0x400700 <.text+0x4e0>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	0x4006fc <.text+0x4dc>
               	b	0x4006b8 <.text+0x498>
               	sub	x14, x29, #0x80
               	ldrsw	x0, [x14]
               	add	x12, x0, #0x1
               	str	w12, [x14]
               	b	0x400694 <.text+0x474>
               	sub	x12, x29, #0x70
               	add	x0, x12, #0x20
               	ldr	x12, [x0]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x14, x0, x17
               	add	x13, x12, x14
               	ldursw	x14, [x29, #-0x80]
               	lsl	x12, x14, #2
               	add	x11, x13, x12
               	mov	x17, #0x64              // =100
               	mul	x12, x0, x17
               	sxtw	x12, w12
               	add	x0, x12, x14
               	sxtw	x0, w0
               	str	w0, [x11]
               	b	0x4006a4 <.text+0x484>
               	b	0x400668 <.text+0x448>
               	ldursw	x0, [x29, #-0x78]
               	cmp	x0, #0x3
               	b.ge	0x400730 <.text+0x510>
               	b	0x400724 <.text+0x504>
               	sub	x0, x29, #0x78
               	ldrsw	x12, [x0]
               	add	x11, x12, #0x1
               	str	w11, [x0]
               	b	0x400700 <.text+0x4e0>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x80]
               	b	0x40073c <.text+0x51c>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	0x4007e8 <.text+0x5c8>
               	ldursw	x11, [x29, #-0x80]
               	cmp	x11, #0x5
               	b.ge	0x4007ac <.text+0x58c>
               	b	0x400760 <.text+0x540>
               	sub	x11, x29, #0x80
               	ldrsw	x12, [x11]
               	add	x0, x12, #0x1
               	str	w0, [x11]
               	b	0x40073c <.text+0x51c>
               	sub	x0, x29, #0x70
               	add	x12, x0, #0x20
               	ldr	x0, [x12]
               	ldursw	x12, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x11, x12, x17
               	add	x14, x0, x11
               	ldursw	x11, [x29, #-0x80]
               	lsl	x0, x11, #2
               	add	x13, x14, x0
               	ldrsw	x0, [x13]
               	mov	x17, #0x64              // =100
               	mul	x13, x12, x17
               	sxtw	x13, w13
               	add	x12, x13, x11
               	sxtw	x12, w12
               	cmp	x0, x12
               	b.eq	0x4007e4 <.text+0x5c4>
               	b	0x4007b0 <.text+0x590>
               	b	0x400710 <.text+0x4f0>
               	ldursw	x12, [x29, #-0x78]
               	mov	x17, #0x5               // =5
               	mul	x13, x12, x17
               	sxtw	x13, w13
               	add	x12, x13, #0x28
               	sxtw	x12, w12
               	ldursw	x13, [x29, #-0x80]
               	add	x0, x12, x13
               	sxtw	x0, w0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40074c <.text+0x52c>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x3
               	b.ge	0x400818 <.text+0x5f8>
               	b	0x40080c <.text+0x5ec>
               	sub	x13, x29, #0x78
               	ldrsw	x0, [x13]
               	add	x12, x0, #0x1
               	str	w12, [x13]
               	b	0x4007e8 <.text+0x5c8>
               	mov	x12, #0x0               // =0
               	stur	w12, [x29, #-0x80]
               	b	0x400824 <.text+0x604>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x4008d0 <.text+0x6b0>
               	ldursw	x12, [x29, #-0x80]
               	cmp	x12, #0x5
               	b.ge	0x400894 <.text+0x674>
               	b	0x400848 <.text+0x628>
               	sub	x12, x29, #0x80
               	ldrsw	x0, [x12]
               	add	x13, x0, #0x1
               	str	w13, [x12]
               	b	0x400824 <.text+0x604>
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x20
               	ldr	x13, [x0]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x12, x0, x17
               	add	x11, x13, x12
               	ldursw	x12, [x29, #-0x80]
               	lsl	x13, x12, #2
               	add	x14, x11, x13
               	ldrsw	x13, [x14]
               	mov	x17, #0x64              // =100
               	mul	x14, x0, x17
               	sxtw	x14, w14
               	add	x0, x14, x12
               	sxtw	x0, w0
               	cmp	x13, x0
               	b.eq	0x4008cc <.text+0x6ac>
               	b	0x400898 <.text+0x678>
               	b	0x4007f8 <.text+0x5d8>
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0x5               // =5
               	mul	x14, x0, x17
               	sxtw	x14, w14
               	add	x0, x14, #0x3c
               	sxtw	x0, w0
               	ldursw	x14, [x29, #-0x80]
               	add	x13, x0, x14
               	sxtw	x0, w13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400834 <.text+0x614>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	0x400900 <.text+0x6e0>
               	b	0x4008f4 <.text+0x6d4>
               	sub	x14, x29, #0x78
               	ldrsw	x0, [x14]
               	add	x13, x0, #0x1
               	str	w13, [x14]
               	b	0x4008d0 <.text+0x6b0>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x80]
               	b	0x40090c <.text+0x6ec>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	0x4009c0 <.text+0x7a0>
               	ldursw	x13, [x29, #-0x80]
               	cmp	x13, #0x3
               	b.ge	0x40093c <.text+0x71c>
               	b	0x400930 <.text+0x710>
               	sub	x13, x29, #0x80
               	ldrsw	x0, [x13]
               	add	x14, x0, #0x1
               	str	w14, [x13]
               	b	0x40090c <.text+0x6ec>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	0x400940 <.text+0x720>
               	b	0x4008e0 <.text+0x6c0>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	0x4009bc <.text+0x79c>
               	b	0x400964 <.text+0x744>
               	sub	x14, x29, #0x88
               	ldrsw	x0, [x14]
               	add	x13, x0, #0x1
               	str	w13, [x14]
               	b	0x400940 <.text+0x720>
               	sub	x13, x29, #0x70
               	add	x0, x13, #0x28
               	ldr	x13, [x0]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x14, x0, x17
               	add	x0, x13, x14
               	ldursw	x13, [x29, #-0x80]
               	lsl	x12, x13, #2
               	add	x13, x0, x12
               	ldursw	x0, [x29, #-0x88]
               	add	x11, x13, x0
               	sxtw	x14, w14
               	sxtw	x12, w12
               	add	x13, x14, x12
               	sxtw	x13, w13
               	add	x12, x13, x0
               	sxtw	x12, w12
               	mov	x17, #0xff              // =255
               	and	x13, x12, x17
               	strb	w13, [x11]
               	b	0x400950 <.text+0x730>
               	b	0x40091c <.text+0x6fc>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x2
               	b.ge	0x4009f0 <.text+0x7d0>
               	b	0x4009e4 <.text+0x7c4>
               	sub	x13, x29, #0x78
               	ldrsw	x12, [x13]
               	add	x11, x12, #0x1
               	str	w11, [x13]
               	b	0x4009c0 <.text+0x7a0>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x80]
               	b	0x4009fc <.text+0x7dc>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x78]
               	b	0x400b04 <.text+0x8e4>
               	ldursw	x11, [x29, #-0x80]
               	cmp	x11, #0x3
               	b.ge	0x400a2c <.text+0x80c>
               	b	0x400a20 <.text+0x800>
               	sub	x11, x29, #0x80
               	ldrsw	x12, [x11]
               	add	x13, x12, #0x1
               	str	w13, [x11]
               	b	0x4009fc <.text+0x7dc>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x88]
               	b	0x400a30 <.text+0x810>
               	b	0x4009d0 <.text+0x7b0>
               	ldursw	x13, [x29, #-0x88]
               	cmp	x13, #0x4
               	b.ge	0x400ab4 <.text+0x894>
               	b	0x400a54 <.text+0x834>
               	sub	x13, x29, #0x88
               	ldrsw	x12, [x13]
               	add	x11, x12, #0x1
               	str	w11, [x13]
               	b	0x400a30 <.text+0x810>
               	sub	x11, x29, #0x70
               	add	x12, x11, #0x28
               	ldr	x11, [x12]
               	ldursw	x12, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x13, x12, x17
               	add	x12, x11, x13
               	ldursw	x11, [x29, #-0x80]
               	lsl	x0, x11, #2
               	add	x11, x12, x0
               	ldursw	x12, [x29, #-0x88]
               	add	x14, x11, x12
               	ldrb	w11, [x14]
               	sxtw	x13, w13
               	sxtw	x0, w0
               	add	x14, x13, x0
               	sxtw	x14, w14
               	add	x0, x14, x12
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x14, x0, x17
               	cmp	x11, x14
               	b.eq	0x400b00 <.text+0x8e0>
               	b	0x400ab8 <.text+0x898>
               	b	0x400a0c <.text+0x7ec>
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x0, x14, x17
               	sxtw	x0, w0
               	add	x14, x0, #0x50
               	sxtw	x14, w14
               	ldursw	x0, [x29, #-0x80]
               	lsl	x11, x0, #2
               	sxtw	x11, w11
               	add	x0, x14, x11
               	sxtw	x0, w0
               	ldursw	x11, [x29, #-0x88]
               	add	x14, x0, x11
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400a40 <.text+0x820>
               	ldursw	x11, [x29, #-0x78]
               	cmp	x11, #0x2
               	b.ge	0x400b34 <.text+0x914>
               	b	0x400b28 <.text+0x908>
               	sub	x11, x29, #0x78
               	ldrsw	x0, [x11]
               	add	x14, x0, #0x1
               	str	w14, [x11]
               	b	0x400b04 <.text+0x8e4>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x400b4c <.text+0x92c>
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	0x400b7c <.text+0x95c>
               	b	0x400b70 <.text+0x950>
               	sub	x14, x29, #0x80
               	ldrsw	x0, [x14]
               	add	x11, x0, #0x1
               	str	w11, [x14]
               	b	0x400b4c <.text+0x92c>
               	mov	x11, #0x0               // =0
               	stur	w11, [x29, #-0x88]
               	b	0x400b80 <.text+0x960>
               	b	0x400b14 <.text+0x8f4>
               	ldursw	x11, [x29, #-0x88]
               	cmp	x11, #0x4
               	b.ge	0x400c04 <.text+0x9e4>
               	b	0x400ba4 <.text+0x984>
               	sub	x11, x29, #0x88
               	ldrsw	x0, [x11]
               	add	x14, x0, #0x1
               	str	w14, [x11]
               	b	0x400b80 <.text+0x960>
               	sub	x14, x29, #0x70
               	add	x0, x14, #0x28
               	ldr	x14, [x0]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x11, x0, x17
               	add	x0, x14, x11
               	ldursw	x14, [x29, #-0x80]
               	lsl	x12, x14, #2
               	add	x14, x0, x12
               	ldursw	x0, [x29, #-0x88]
               	add	x13, x14, x0
               	ldrb	w14, [x13]
               	sxtw	x11, w11
               	sxtw	x12, w12
               	add	x13, x11, x12
               	sxtw	x13, w13
               	add	x12, x13, x0
               	sxtw	x12, w12
               	mov	x17, #0xff              // =255
               	and	x13, x12, x17
               	cmp	x14, x13
               	b.eq	0x400c50 <.text+0xa30>
               	b	0x400c08 <.text+0x9e8>
               	b	0x400b5c <.text+0x93c>
               	ldursw	x13, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x12, x13, x17
               	sxtw	x12, w12
               	add	x13, x12, #0x6e
               	sxtw	x13, w13
               	ldursw	x12, [x29, #-0x80]
               	lsl	x14, x12, #2
               	sxtw	x14, w14
               	add	x12, x13, x14
               	sxtw	x12, w12
               	ldursw	x14, [x29, #-0x88]
               	add	x13, x12, x14
               	sxtw	x0, w13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400b90 <.text+0x970>
               	<unknown>
               	adr	x10, 0x4ecd79
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x4072ac <exit+0x6514>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f933c
               	tbz	w21, #0x6, 0x3ff300
               	<unknown>
               	cbnz	w16, 0x46f2a8
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x4008b4 <.text+0x694>
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
               	bl	0x400d98 <exit>
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
               	adr	x10, 0x4ece41
               	ldsetb	w14, w14, [x1]
               	mla	v10.8h, v8.8h, v3.h[6]
               	<unknown>
               	tbz	w0, #0x6, 0x407374 <exit+0x65dc>
               	<unknown>
               	<unknown>
               	<unknown>
               	tbz	w18, #0xc, 0x3f9404
               	tbz	w21, #0x6, 0x3ff3c8
               	<unknown>
               	cbnz	w16, 0x46f370
               	<unknown>
               	adds	w3, w19, #0x84c, lsl #12 // =0x84c000
               	<unknown>
               	<unknown>
               	<unknown>
               	<unknown>
               	ands	w1, w19, #0x3800000
               	<unknown>
               	cbhs	w5, w8, 0x40097c <.text+0x75c>
               	<unknown>
               	ldpsw	x15, x11, [x25, #-0xc8]
               	<unknown>
               	ldp	d14, d24, [x25, #-0x110]
               	umlsl2	v15.4s, v25.8h, v2.h[7]
               	<unknown>
               	<unknown>
               	ldpsw	x3, x11, [x19, #-0xc8]
               	udf	#0x74

<exit>:
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	br	x16
