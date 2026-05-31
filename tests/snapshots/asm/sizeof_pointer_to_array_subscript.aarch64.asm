
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
               	add	x13, x13, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x560
               	mov	x14, x19
               	str	x14, [x13]
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x570
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x18
               	adrp	x19, 0x410000
               	add	x19, x19, #0x590
               	mov	x14, x19
               	str	x14, [x13]
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x20
               	adrp	x19, 0x410000
               	add	x19, x19, #0x5d0
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x28
               	adrp	x19, 0x410000
               	add	x19, x19, #0x610
               	mov	x14, x19
               	str	x14, [x13]
               	sub	x15, x29, #0x70
               	ldr	x14, [x15]
               	add	x14, x14, #0x8
               	sub	x15, x29, #0x70
               	ldr	x13, [x15]
               	sub	x14, x14, x13
               	cmp	x14, #0x8
               	b.eq	0x400308 <.text+0xe8>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x8
               	ldr	x0, [x14]
               	add	x0, x0, #0x10
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x8
               	ldr	x15, [x14]
               	sub	x0, x0, x15
               	cmp	x0, #0x10
               	b.eq	0x400348 <.text+0x128>
               	mov	x15, #0xc               // =12
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x10
               	ldr	x15, [x0]
               	add	x15, x15, #0x20
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x10
               	ldr	x14, [x0]
               	sub	x15, x15, x14
               	cmp	x15, #0x20
               	b.eq	0x400384 <.text+0x164>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x18
               	ldr	x0, [x15]
               	add	x0, x0, #0x40
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x18
               	ldr	x14, [x15]
               	sub	x0, x0, x14
               	cmp	x0, #0x40
               	b.eq	0x4003c4 <.text+0x1a4>
               	mov	x14, #0xe               // =14
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldr	x14, [x0]
               	add	x14, x14, #0x3c
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldr	x15, [x0]
               	sub	x14, x14, x15
               	cmp	x14, #0x3c
               	b.eq	0x400400 <.text+0x1e0>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x20
               	ldr	x0, [x14]
               	add	x0, x0, #0x14
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x20
               	ldr	x15, [x14]
               	sub	x0, x0, x15
               	cmp	x0, #0x14
               	b.eq	0x400440 <.text+0x220>
               	mov	x15, #0x10              // =16
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x15, [x0]
               	add	x15, x15, #0x18
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x14, [x0]
               	sub	x15, x15, x14
               	cmp	x15, #0x18
               	b.eq	0x40047c <.text+0x25c>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x28
               	ldr	x0, [x15]
               	add	x0, x0, #0xc
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x28
               	ldr	x14, [x15]
               	sub	x0, x0, x14
               	cmp	x0, #0xc
               	b.eq	0x4004bc <.text+0x29c>
               	mov	x14, #0x12              // =18
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x14, [x0]
               	add	x14, x14, #0x4
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x15, [x0]
               	sub	x14, x14, x15
               	cmp	x14, #0x4
               	b.eq	0x4004f8 <.text+0x2d8>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x400504 <.text+0x2e4>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	0x400554 <.text+0x334>
               	b	0x400528 <.text+0x308>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x400504 <.text+0x2e4>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x8
               	ldr	x15, [x14]
               	ldursw	x14, [x29, #-0x78]
               	lsl	x0, x14, #1
               	add	x15, x15, x0
               	add	x14, x14, #0x3e8
               	sxtw	x14, w14
               	sxth	x14, w14
               	strh	w14, [x15]
               	b	0x400514 <.text+0x2f4>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x400560 <.text+0x340>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	0x4005b8 <.text+0x398>
               	b	0x400584 <.text+0x364>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x400560 <.text+0x340>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x8
               	ldr	x15, [x14]
               	ldursw	x14, [x29, #-0x78]
               	lsl	x0, x14, #1
               	add	x15, x15, x0
               	ldrsh	x0, [x15]
               	add	x14, x14, #0x3e8
               	sxtw	x14, w14
               	sxth	x14, w14
               	cmp	x0, x14
               	b.eq	0x4005e0 <.text+0x3c0>
               	b	0x4005c4 <.text+0x3a4>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x4005e4 <.text+0x3c4>
               	ldursw	x14, [x29, #-0x78]
               	add	x14, x14, #0x14
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400570 <.text+0x350>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	0x40063c <.text+0x41c>
               	b	0x400608 <.text+0x3e8>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x4005e4 <.text+0x3c4>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x8
               	ldr	x15, [x14]
               	ldursw	x14, [x29, #-0x78]
               	lsl	x0, x14, #1
               	add	x15, x15, x0
               	ldrsh	x0, [x15]
               	add	x14, x14, #0x3e8
               	sxtw	x14, w14
               	sxth	x14, w14
               	cmp	x0, x14
               	b.eq	0x400664 <.text+0x444>
               	b	0x400648 <.text+0x428>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x400668 <.text+0x448>
               	ldursw	x14, [x29, #-0x78]
               	add	x14, x14, #0x1c
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x4005f4 <.text+0x3d4>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x3
               	b.ge	0x400698 <.text+0x478>
               	b	0x40068c <.text+0x46c>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x400668 <.text+0x448>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x4006a4 <.text+0x484>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x400710 <.text+0x4f0>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	0x40070c <.text+0x4ec>
               	b	0x4006c8 <.text+0x4a8>
               	sub	x15, x29, #0x80
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	0x4006a4 <.text+0x484>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x20
               	ldr	x0, [x14]
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x15, x14, x17
               	add	x0, x0, x15
               	ldursw	x15, [x29, #-0x80]
               	lsl	x12, x15, #2
               	add	x0, x0, x12
               	mov	x17, #0x64              // =100
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, x15
               	sxtw	x14, w14
               	str	w14, [x0]
               	b	0x4006b4 <.text+0x494>
               	b	0x400678 <.text+0x458>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x3
               	b.ge	0x400740 <.text+0x520>
               	b	0x400734 <.text+0x514>
               	sub	x15, x29, #0x78
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	0x400710 <.text+0x4f0>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x40074c <.text+0x52c>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x4007f8 <.text+0x5d8>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	0x4007bc <.text+0x59c>
               	b	0x400770 <.text+0x550>
               	sub	x0, x29, #0x80
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x40074c <.text+0x52c>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x20
               	ldr	x15, [x14]
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x0, x14, x17
               	add	x15, x15, x0
               	ldursw	x0, [x29, #-0x80]
               	lsl	x12, x0, #2
               	add	x15, x15, x12
               	ldrsw	x12, [x15]
               	mov	x17, #0x64              // =100
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, x0
               	sxtw	x14, w14
               	cmp	x12, x14
               	b.eq	0x4007f4 <.text+0x5d4>
               	b	0x4007c0 <.text+0x5a0>
               	b	0x400720 <.text+0x500>
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0x5               // =5
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, #0x28
               	sxtw	x14, w14
               	ldursw	x12, [x29, #-0x80]
               	add	x14, x14, x12
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x40075c <.text+0x53c>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x3
               	b.ge	0x400828 <.text+0x608>
               	b	0x40081c <.text+0x5fc>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x4007f8 <.text+0x5d8>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x400834 <.text+0x614>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x4008e0 <.text+0x6c0>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	0x4008a4 <.text+0x684>
               	b	0x400858 <.text+0x638>
               	sub	x12, x29, #0x80
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	0x400834 <.text+0x614>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x20
               	ldr	x0, [x14]
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x12, x14, x17
               	add	x0, x0, x12
               	ldursw	x12, [x29, #-0x80]
               	lsl	x15, x12, #2
               	add	x0, x0, x15
               	ldrsw	x15, [x0]
               	mov	x17, #0x64              // =100
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, x12
               	sxtw	x14, w14
               	cmp	x15, x14
               	b.eq	0x4008dc <.text+0x6bc>
               	b	0x4008a8 <.text+0x688>
               	b	0x400808 <.text+0x5e8>
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0x5               // =5
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, #0x3c
               	sxtw	x14, w14
               	ldursw	x15, [x29, #-0x80]
               	add	x14, x14, x15
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400844 <.text+0x624>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	0x400910 <.text+0x6f0>
               	b	0x400904 <.text+0x6e4>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x4008e0 <.text+0x6c0>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x40091c <.text+0x6fc>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x4009d0 <.text+0x7b0>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	0x40094c <.text+0x72c>
               	b	0x400940 <.text+0x720>
               	sub	x12, x29, #0x80
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	0x40091c <.text+0x6fc>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	0x400950 <.text+0x730>
               	b	0x4008f0 <.text+0x6d0>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	0x4009cc <.text+0x7ac>
               	b	0x400974 <.text+0x754>
               	sub	x0, x29, #0x88
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x400950 <.text+0x730>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x28
               	ldr	x12, [x14]
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	add	x12, x12, x14
               	ldursw	x0, [x29, #-0x80]
               	lsl	x0, x0, #2
               	add	x12, x12, x0
               	ldursw	x15, [x29, #-0x88]
               	add	x12, x12, x15
               	sxtw	x14, w14
               	sxtw	x0, w0
               	add	x14, x14, x0
               	sxtw	x14, w14
               	add	x14, x14, x15
               	sxtw	x14, w14
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	strb	w14, [x12]
               	b	0x400960 <.text+0x740>
               	b	0x40092c <.text+0x70c>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	0x400a00 <.text+0x7e0>
               	b	0x4009f4 <.text+0x7d4>
               	sub	x15, x29, #0x78
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	0x4009d0 <.text+0x7b0>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x400a0c <.text+0x7ec>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	0x400b14 <.text+0x8f4>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	0x400a3c <.text+0x81c>
               	b	0x400a30 <.text+0x810>
               	sub	x12, x29, #0x80
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	0x400a0c <.text+0x7ec>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	0x400a40 <.text+0x820>
               	b	0x4009e0 <.text+0x7c0>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	0x400ac4 <.text+0x8a4>
               	b	0x400a64 <.text+0x844>
               	sub	x15, x29, #0x88
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	0x400a40 <.text+0x820>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x28
               	ldr	x12, [x14]
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	add	x12, x12, x14
               	ldursw	x15, [x29, #-0x80]
               	lsl	x15, x15, #2
               	add	x12, x12, x15
               	ldursw	x0, [x29, #-0x88]
               	add	x12, x12, x0
               	ldrb	w11, [x12]
               	sxtw	x14, w14
               	sxtw	x15, w15
               	add	x14, x14, x15
               	sxtw	x14, w14
               	add	x14, x14, x0
               	sxtw	x14, w14
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	cmp	x11, x14
               	b.eq	0x400b10 <.text+0x8f0>
               	b	0x400ac8 <.text+0x8a8>
               	b	0x400a1c <.text+0x7fc>
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, #0x50
               	sxtw	x14, w14
               	ldursw	x11, [x29, #-0x80]
               	lsl	x11, x11, #2
               	sxtw	x11, w11
               	add	x14, x14, x11
               	sxtw	x14, w14
               	ldursw	x11, [x29, #-0x88]
               	add	x14, x14, x11
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400a50 <.text+0x830>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	0x400b44 <.text+0x924>
               	b	0x400b38 <.text+0x918>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x400b14 <.text+0x8f4>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	0x400b5c <.text+0x93c>
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	0x400b8c <.text+0x96c>
               	b	0x400b80 <.text+0x960>
               	sub	x11, x29, #0x80
               	ldrsw	x14, [x11]
               	add	x14, x14, #0x1
               	str	w14, [x11]
               	b	0x400b5c <.text+0x93c>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	0x400b90 <.text+0x970>
               	b	0x400b24 <.text+0x904>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	0x400c14 <.text+0x9f4>
               	b	0x400bb4 <.text+0x994>
               	sub	x0, x29, #0x88
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	0x400b90 <.text+0x970>
               	sub	x14, x29, #0x70
               	add	x14, x14, #0x28
               	ldr	x11, [x14]
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	add	x11, x11, x14
               	ldursw	x0, [x29, #-0x80]
               	lsl	x0, x0, #2
               	add	x11, x11, x0
               	ldursw	x15, [x29, #-0x88]
               	add	x11, x11, x15
               	ldrb	w12, [x11]
               	sxtw	x14, w14
               	sxtw	x0, w0
               	add	x14, x14, x0
               	sxtw	x14, w14
               	add	x14, x14, x15
               	sxtw	x14, w14
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	cmp	x12, x14
               	b.eq	0x400c60 <.text+0xa40>
               	b	0x400c18 <.text+0x9f8>
               	b	0x400b6c <.text+0x94c>
               	ldursw	x14, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x14, x14, x17
               	sxtw	x14, w14
               	add	x14, x14, #0x6e
               	sxtw	x14, w14
               	ldursw	x12, [x29, #-0x80]
               	lsl	x12, x12, #2
               	sxtw	x12, w12
               	add	x14, x14, x12
               	sxtw	x14, w14
               	ldursw	x12, [x29, #-0x88]
               	add	x14, x14, x12
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	0x400ba0 <.text+0x980>
