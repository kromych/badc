
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
               	ldr	x15, [x15]
               	add	x15, x15, #0x8
               	sub	x14, x29, #0x70
               	ldr	x14, [x14]
               	sub	x15, x15, x14
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	add	x15, x15, #0x10
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x10
               	ldr	x15, [x15]
               	add	x15, x15, #0x20
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x10
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x18
               	ldr	x15, [x15]
               	add	x15, x15, #0x40
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x20
               	ldr	x15, [x15]
               	add	x15, x15, #0x3c
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x20
               	ldr	x15, [x15]
               	add	x15, x15, #0x14
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x28
               	ldr	x15, [x15]
               	add	x15, x15, #0x18
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x28
               	ldr	x15, [x15]
               	add	x15, x15, #0xc
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x28
               	ldr	x15, [x15]
               	add	x15, x15, #0x4
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	sub	x15, x15, x0
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x78]
               	b	<addr>
               	ldursw	x15, [x29, #-0x78]
               	cmp	x15, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x15, [x0]
               	add	x15, x15, #0x1
               	str	w15, [x0]
               	b	<addr>
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	ldursw	x13, [x29, #-0x78]
               	lsl	x0, x13, #1
               	add	x15, x15, x0
               	add	x13, x13, #0x3e8
               	sxtw	x13, w13
               	sxth	x13, w13
               	strh	w13, [x15]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	<addr>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x13, [x0]
               	add	x13, x13, #0x1
               	str	w13, [x0]
               	b	<addr>
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x8
               	ldr	x13, [x13]
               	ldursw	x15, [x29, #-0x78]
               	lsl	x0, x15, #1
               	add	x13, x13, x0
               	ldrsh	x13, [x13]
               	add	x15, x15, #0x3e8
               	sxtw	x15, w15
               	sxth	x15, w15
               	cmp	x13, x15
               	b.eq	<addr>
               	b	<addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x78]
               	b	<addr>
               	ldursw	x15, [x29, #-0x78]
               	add	x15, x15, #0x14
               	sxtw	x0, w15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x15, [x29, #-0x78]
               	cmp	x15, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x15, [x0]
               	add	x15, x15, #0x1
               	str	w15, [x0]
               	b	<addr>
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	ldursw	x13, [x29, #-0x78]
               	lsl	x0, x13, #1
               	add	x15, x15, x0
               	ldrsh	x15, [x15]
               	add	x13, x13, #0x3e8
               	sxtw	x13, w13
               	sxth	x13, w13
               	cmp	x15, x13
               	b.eq	<addr>
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	<addr>
               	ldursw	x13, [x29, #-0x78]
               	add	x13, x13, #0x1c
               	sxtw	x0, w13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x13, [x0]
               	add	x13, x13, #0x1
               	str	w13, [x0]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x80]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x78]
               	b	<addr>
               	ldursw	x13, [x29, #-0x80]
               	cmp	x13, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x80
               	ldrsw	x13, [x15]
               	add	x13, x13, #0x1
               	str	w13, [x15]
               	b	<addr>
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x20
               	ldr	x13, [x13]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x15, x0, x17
               	add	x13, x13, x15
               	ldursw	x15, [x29, #-0x80]
               	lsl	x12, x15, #2
               	add	x13, x13, x12
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, x15
               	sxtw	x0, w0
               	str	w0, [x13]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x78]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x78
               	ldrsw	x0, [x15]
               	add	x0, x0, #0x1
               	str	w0, [x15]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x80]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x78]
               	b	<addr>
               	ldursw	x0, [x29, #-0x80]
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x80
               	ldrsw	x0, [x13]
               	add	x0, x0, #0x1
               	str	w0, [x13]
               	b	<addr>
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	ldursw	x15, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x13, x15, x17
               	add	x0, x0, x13
               	ldursw	x13, [x29, #-0x80]
               	lsl	x12, x13, #2
               	add	x0, x0, x12
               	ldrsw	x0, [x0]
               	mov	x17, #0x64              // =100
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x15, x15, x13
               	sxtw	x15, w15
               	cmp	x0, x15
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x15, [x29, #-0x78]
               	mov	x17, #0x5               // =5
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x15, x15, #0x28
               	sxtw	x15, w15
               	ldursw	x0, [x29, #-0x80]
               	add	x15, x15, x0
               	sxtw	x0, w15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x15, [x29, #-0x78]
               	cmp	x15, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x78
               	ldrsw	x15, [x0]
               	add	x15, x15, #0x1
               	str	w15, [x0]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x80]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x78]
               	b	<addr>
               	ldursw	x15, [x29, #-0x80]
               	cmp	x15, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x80
               	ldrsw	x15, [x13]
               	add	x15, x15, #0x1
               	str	w15, [x13]
               	b	<addr>
               	sub	x15, x29, #0x70
               	add	x15, x15, #0x20
               	ldr	x15, [x15]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0x14              // =20
               	mul	x13, x0, x17
               	add	x15, x15, x13
               	ldursw	x13, [x29, #-0x80]
               	lsl	x12, x13, #2
               	add	x15, x15, x12
               	ldrsw	x15, [x15]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, x13
               	sxtw	x0, w0
               	cmp	x15, x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x3c
               	sxtw	x0, w0
               	ldursw	x15, [x29, #-0x80]
               	add	x0, x0, x15
               	sxtw	x15, w0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x0, [x29, #-0x78]
               	cmp	x0, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x78
               	ldrsw	x0, [x15]
               	add	x0, x0, #0x1
               	str	w0, [x15]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x80]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x78]
               	b	<addr>
               	ldursw	x0, [x29, #-0x80]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x80
               	ldrsw	x0, [x13]
               	add	x0, x0, #0x1
               	str	w0, [x13]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x88]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x88]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x88
               	ldrsw	x0, [x15]
               	add	x0, x0, #0x1
               	str	w0, [x15]
               	b	<addr>
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	ldursw	x13, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x13, x13, x17
               	add	x0, x0, x13
               	ldursw	x15, [x29, #-0x80]
               	lsl	x15, x15, #2
               	add	x0, x0, x15
               	ldursw	x12, [x29, #-0x88]
               	add	x0, x0, x12
               	sxtw	x13, w13
               	sxtw	x15, w15
               	add	x13, x13, x15
               	sxtw	x13, w13
               	add	x13, x13, x12
               	sxtw	x13, w13
               	mov	x17, #0xff              // =255
               	and	x13, x13, x17
               	strb	w13, [x0]
               	b	<addr>
               	b	<addr>
               	ldursw	x13, [x29, #-0x78]
               	cmp	x13, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x78
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x80]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x78]
               	b	<addr>
               	ldursw	x13, [x29, #-0x80]
               	cmp	x13, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x80
               	ldrsw	x13, [x0]
               	add	x13, x13, #0x1
               	str	w13, [x0]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	stur	w13, [x29, #-0x88]
               	b	<addr>
               	b	<addr>
               	ldursw	x13, [x29, #-0x88]
               	cmp	x13, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x12, x29, #0x88
               	ldrsw	x13, [x12]
               	add	x13, x13, #0x1
               	str	w13, [x12]
               	b	<addr>
               	sub	x13, x29, #0x70
               	add	x13, x13, #0x28
               	ldr	x13, [x13]
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	add	x13, x13, x0
               	ldursw	x12, [x29, #-0x80]
               	lsl	x12, x12, #2
               	add	x13, x13, x12
               	ldursw	x15, [x29, #-0x88]
               	add	x13, x13, x15
               	ldrb	w13, [x13]
               	sxtw	x0, w0
               	sxtw	x12, w12
               	add	x0, x0, x12
               	sxtw	x0, w0
               	add	x0, x0, x15
               	sxtw	x0, w0
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	cmp	x13, x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x50
               	sxtw	x0, w0
               	ldursw	x13, [x29, #-0x80]
               	lsl	x13, x13, #2
               	sxtw	x13, w13
               	add	x0, x0, x13
               	sxtw	x0, w0
               	ldursw	x13, [x29, #-0x88]
               	add	x0, x0, x13
               	sxtw	x13, w0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	ldursw	x0, [x29, #-0x78]
               	cmp	x0, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x78
               	ldrsw	x0, [x13]
               	add	x0, x0, #0x1
               	str	w0, [x13]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x80]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x80]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x15, x29, #0x80
               	ldrsw	x0, [x15]
               	add	x0, x0, #0x1
               	str	w0, [x15]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x88]
               	b	<addr>
               	b	<addr>
               	ldursw	x0, [x29, #-0x88]
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sub	x13, x29, #0x88
               	ldrsw	x0, [x13]
               	add	x0, x0, #0x1
               	str	w0, [x13]
               	b	<addr>
               	sub	x0, x29, #0x70
               	add	x0, x0, #0x28
               	ldr	x0, [x0]
               	ldursw	x15, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x15, x15, x17
               	add	x0, x0, x15
               	ldursw	x13, [x29, #-0x80]
               	lsl	x13, x13, #2
               	add	x0, x0, x13
               	ldursw	x12, [x29, #-0x88]
               	add	x0, x0, x12
               	ldrb	w0, [x0]
               	sxtw	x15, w15
               	sxtw	x13, w13
               	add	x15, x15, x13
               	sxtw	x15, w15
               	add	x15, x15, x12
               	sxtw	x15, w15
               	mov	x17, #0xff              // =255
               	and	x15, x15, x17
               	cmp	x0, x15
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldursw	x15, [x29, #-0x78]
               	mov	x17, #0xc               // =12
               	mul	x15, x15, x17
               	sxtw	x15, w15
               	add	x15, x15, #0x6e
               	sxtw	x15, w15
               	ldursw	x0, [x29, #-0x80]
               	lsl	x0, x0, #2
               	sxtw	x0, w0
               	add	x15, x15, x0
               	sxtw	x15, w15
               	ldursw	x0, [x29, #-0x88]
               	add	x15, x15, x0
               	sxtw	x0, w15
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
