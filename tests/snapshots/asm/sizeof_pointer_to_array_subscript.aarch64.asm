
sizeof_pointer_to_array_subscript.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, #0x553
               	str	x1, [x0]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, #0x560
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, #0x570
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, #0x590
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, #0x5d0
               	str	x1, [x0, #0x20]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, #0x610
               	str	x1, [x0, #0x28]
               	sub	x0, x29, #0x70
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x70
               	ldr	x1, [x1]
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x8]
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x8]
               	sub	x0, x0, x1
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x10]
               	add	x0, x0, #0x20
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x10]
               	sub	x0, x0, x1
               	cmp	x0, #0x20
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x18]
               	add	x0, x0, #0x40
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x18]
               	sub	x0, x0, x1
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x20]
               	add	x0, x0, #0x3c
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x20]
               	sub	x0, x0, x1
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x20]
               	add	x0, x0, #0x14
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x20]
               	sub	x0, x0, x1
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x28]
               	add	x0, x0, #0x18
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x28]
               	sub	x0, x0, x1
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x28]
               	add	x0, x0, #0xc
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x28]
               	sub	x0, x0, x1
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x28]
               	add	x0, x0, #0x4
               	sub	x1, x29, #0x70
               	ldr	x1, [x1, #0x28]
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x8]
               	sxtw	x2, w1
               	add	x3, x2, #0x3e8
               	sxtw	x3, w3
               	strh	w3, [x0, x2, lsl #1]
               	b	<addr>
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x8]
               	sxtw	x2, w1
               	ldrsh	x0, [x0, x2, lsl #1]
               	add	x2, x2, #0x3e8
               	sxtw	x2, w2
               	sxth	x2, w2
               	cmp	x0, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	add	x0, x0, #0x14
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x8]
               	sxtw	x2, w1
               	ldrsh	x0, [x0, x2, lsl #1]
               	add	x2, x2, #0x3e8
               	sxtw	x2, w2
               	sxth	x2, w2
               	cmp	x0, x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	add	x0, x0, #0x1c
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x20]
               	sxtw	x3, w1
               	mov	x17, #0x14              // =20
               	mul	x4, x3, x17
               	add	x0, x0, x4
               	sxtw	x4, w2
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	sxtw	x3, w3
               	add	x3, x3, x4
               	str	w3, [x0, x4, lsl #2]
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x20]
               	sxtw	x3, w1
               	mov	x17, #0x14              // =20
               	mul	x4, x3, x17
               	add	x0, x0, x4
               	sxtw	x4, w2
               	ldrsw	x0, [x0, x4, lsl #2]
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	sxtw	x3, w3
               	add	x3, x3, x4
               	sxtw	x3, w3
               	cmp	x0, x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x28
               	sxtw	x0, w0
               	sxtw	x1, w2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x20]
               	sxtw	x3, w1
               	mov	x17, #0x14              // =20
               	mul	x4, x3, x17
               	add	x0, x0, x4
               	sxtw	x4, w2
               	ldrsw	x0, [x0, x4, lsl #2]
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	sxtw	x3, w3
               	add	x3, x3, x4
               	sxtw	x3, w3
               	cmp	x0, x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x3c
               	sxtw	x0, w0
               	sxtw	x1, w2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x28]
               	sxtw	x4, w1
               	mov	x17, #0xc               // =12
               	mul	x4, x4, x17
               	add	x0, x0, x4
               	sxtw	x5, w2
               	lsl	x5, x5, #2
               	add	x0, x0, x5
               	sxtw	x6, w3
               	add	x0, x0, x6
               	sxtw	x4, w4
               	sxtw	x5, w5
               	add	x4, x4, x5
               	sxtw	x4, w4
               	add	x4, x4, x6
               	sxtw	x4, w4
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x0]
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x28]
               	sxtw	x4, w1
               	mov	x17, #0xc               // =12
               	mul	x4, x4, x17
               	add	x0, x0, x4
               	sxtw	x5, w2
               	lsl	x5, x5, #2
               	add	x0, x0, x5
               	sxtw	x6, w3
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	sxtw	x4, w4
               	sxtw	x5, w5
               	add	x4, x4, x5
               	sxtw	x4, w4
               	add	x4, x4, x6
               	sxtw	x4, w4
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	cmp	x0, x4
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x50
               	sxtw	x0, w0
               	sxtw	x1, w2
               	lsl	x1, x1, #2
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sxtw	x1, w3
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w3
               	add	x3, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	ldr	x0, [x0, #0x28]
               	sxtw	x4, w1
               	mov	x17, #0xc               // =12
               	mul	x4, x4, x17
               	add	x0, x0, x4
               	sxtw	x5, w2
               	lsl	x5, x5, #2
               	add	x0, x0, x5
               	sxtw	x6, w3
               	add	x0, x0, x6
               	ldrb	w0, [x0]
               	sxtw	x4, w4
               	sxtw	x5, w5
               	add	x4, x4, x5
               	sxtw	x4, w4
               	add	x4, x4, x6
               	sxtw	x4, w4
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	cmp	x0, x4
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	mov	x17, #0xc               // =12
               	mul	x0, x0, x17
               	sxtw	x0, w0
               	add	x0, x0, #0x6e
               	sxtw	x0, w0
               	sxtw	x1, w2
               	lsl	x1, x1, #2
               	sxtw	x1, w1
               	add	x0, x0, x1
               	sxtw	x0, w0
               	sxtw	x1, w3
               	add	x0, x0, x1
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
