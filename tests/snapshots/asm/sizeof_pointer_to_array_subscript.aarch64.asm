
sizeof_pointer_to_array_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x19, [sp]
               	sub	x15, x29, #0x70
               	adrp	x19, <page>
               	add	x19, x19, #0x553
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x560
               	mov	x14, x19
               	str	x14, [x13]
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x570
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x18
               	adrp	x19, <page>
               	add	x19, x19, #0x590
               	mov	x14, x19
               	str	x14, [x13]
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x20
               	adrp	x19, <page>
               	add	x19, x19, #0x5d0
               	mov	x14, x19
               	str	x14, [x15]
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x28
               	adrp	x19, <page>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
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
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
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
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
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
               	b.eq	<addr>
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	add	x14, x14, #0x14
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
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
               	b.eq	<addr>
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	add	x14, x14, #0x1c
               	sxtw	x0, w14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x80
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
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
               	b	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x78
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
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
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
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
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x80
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	<addr>
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
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
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
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x80
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x88
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
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
               	b	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x78
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x78]
               	b	<addr>
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x80
               	ldrsw	x14, [x12]
               	add	x14, x14, #0x1
               	str	w14, [x12]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x88
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	str	w14, [x15]
               	b	<addr>
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
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
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
               	b	<addr>
               	ldursw	x14, [x29, #-0x78]
               	cmp	x14, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x80]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x14, [x29, #-0x80]
               	cmp	x14, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x11, x29, #0x80
               	ldrsw	x14, [x11]
               	add	x14, x14, #0x1
               	str	w14, [x11]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x88]
               	b	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x88]
               	cmp	x14, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x88
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	str	w14, [x0]
               	b	<addr>
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
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
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
               	b	<addr>
