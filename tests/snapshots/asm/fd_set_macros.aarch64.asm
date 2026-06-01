
fd_set_macros.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
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
               	adrp	x19, <page>
               	add	x19, x19, #0x118
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x11e
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x125
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x110
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	b	<addr>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0x88]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x90]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	cbnz	x13, <addr>
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x98]
               	b	<addr>
               	ldursw	x14, [x29, #-0x90]
               	cmp	x14, #0x80
               	b.ge	<addr>
               	ldur	x15, [x29, #-0x88]
               	ldursw	x14, [x29, #-0x90]
               	add	x15, x15, x14
               	mov	x14, #0x0               // =0
               	strb	w14, [x15]
               	ldursw	x13, [x29, #-0x90]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x90]
               	b	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x98]
               	cmp	x14, #0x80
               	b.ge	<addr>
               	sub	x13, x29, #0x80
               	ldursw	x14, [x29, #-0x98]
               	add	x13, x13, x14
               	ldrb	w13, [x13]
               	cmp	x13, #0x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x13, [x29, #-0x98]
               	add	x13, x13, #0x1
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x98]
               	b	<addr>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xa0]
               	ldur	x14, [x29, #-0xa0]
               	mov	x13, #0x0               // =0
               	mov	x15, #0x8               // =8
               	sdiv	x13, x13, x15
               	add	x14, x14, x13
               	ldrb	w13, [x14]
               	mov	x17, #0x1               // =1
               	orr	x13, x13, x17
               	strb	w13, [x14]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	cbnz	x13, <addr>
               	b	<addr>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xa8]
               	ldur	x13, [x29, #-0xa8]
               	mov	x15, #0x7               // =7
               	mov	x14, #0x8               // =8
               	sdiv	x15, x15, x14
               	add	x13, x13, x15
               	ldrb	w15, [x13]
               	mov	x17, #0x80              // =128
               	orr	x15, x15, x17
               	strb	w15, [x13]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	cbnz	x15, <addr>
               	b	<addr>
               	sub	x14, x29, #0x80
               	stur	x14, [x29, #-0xb0]
               	ldur	x15, [x29, #-0xb0]
               	mov	x14, #0x8               // =8
               	sdiv	x14, x14, x14
               	add	x15, x15, x14
               	ldrb	w14, [x15]
               	mov	x17, #0x1               // =1
               	orr	x14, x14, x17
               	strb	w14, [x15]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	cbnz	x14, <addr>
               	b	<addr>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xb8]
               	ldur	x14, [x29, #-0xb8]
               	mov	x13, #0x64              // =100
               	mov	x15, #0x8               // =8
               	sdiv	x13, x13, x15
               	add	x14, x14, x13
               	ldrb	w13, [x14]
               	mov	x17, #0x10              // =16
               	orr	x13, x13, x17
               	strb	w13, [x14]
               	b	<addr>
               	mov	x13, #0x0               // =0
               	cbnz	x13, <addr>
               	sub	x15, x29, #0x80
               	mov	x13, #0x0               // =0
               	mov	x14, #0x8               // =8
               	sdiv	x13, x13, x14
               	add	x15, x15, x13
               	ldrb	w15, [x15]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x13, #0x7               // =7
               	mov	x14, #0x8               // =8
               	sdiv	x13, x13, x14
               	add	x15, x15, x13
               	ldrb	w15, [x15]
               	mov	x17, #0x80              // =128
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x13, #0x8               // =8
               	sdiv	x13, x13, x13
               	add	x15, x15, x13
               	ldrb	w15, [x15]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x13, #0x64              // =100
               	mov	x14, #0x8               // =8
               	sdiv	x13, x13, x14
               	add	x15, x15, x13
               	ldrb	w15, [x15]
               	mov	x17, #0x10              // =16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.ne	<addr>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x13, #0x1               // =1
               	mov	x14, #0x8               // =8
               	sdiv	x13, x13, x14
               	add	x15, x15, x13
               	ldrb	w15, [x15]
               	mov	x17, #0x2               // =2
               	and	x15, x15, x17
               	cbz	x15, <addr>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	mov	x13, #0x32              // =50
               	mov	x14, #0x8               // =8
               	sdiv	x13, x13, x14
               	add	x15, x15, x13
               	ldrb	w15, [x15]
               	mov	x17, #0x4               // =4
               	and	x15, x15, x17
               	cbz	x15, <addr>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x80
               	ldrb	w13, [x15]
               	mov	x17, #0x81              // =129
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x13, x15, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x1               // =1
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x14, #0xc               // =12
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x15, x15, #0xc
               	ldrb	w15, [x15]
               	mov	x17, #0x10              // =16
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x13, #0xd               // =13
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x15, x29, #0x80
               	stur	x15, [x29, #-0xc8]
               	ldur	x13, [x29, #-0xc8]
               	mov	x15, #0x7               // =7
               	mov	x14, #0x8               // =8
               	sdiv	x15, x15, x14
               	add	x13, x13, x15
               	ldrb	w15, [x13]
               	mov	x17, #0xff7f            // =65407
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x15, x15, x17
               	strb	w15, [x13]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	cbnz	x15, <addr>
               	sub	x14, x29, #0x80
               	mov	x15, #0x7               // =7
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w14, [x14]
               	mov	x17, #0x80              // =128
               	and	x14, x14, x17
               	cbz	x14, <addr>
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	mov	x15, #0x0               // =0
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w14, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.ne	<addr>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	mov	x15, #0x8               // =8
               	sdiv	x15, x15, x15
               	add	x14, x14, x15
               	ldrb	w14, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.ne	<addr>
               	mov	x15, #0x17              // =23
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x14, x29, #0x80
               	stur	x14, [x29, #-0xd0]
               	ldur	x15, [x29, #-0xd0]
               	mov	x14, #0x0               // =0
               	mov	x13, #0x8               // =8
               	sdiv	x14, x14, x13
               	add	x15, x15, x14
               	ldrb	w14, [x15]
               	mov	x17, #0x1               // =1
               	orr	x14, x14, x17
               	strb	w14, [x15]
               	b	<addr>
               	mov	x14, #0x0               // =0
               	cbnz	x14, <addr>
               	sub	x13, x29, #0x80
               	mov	x14, #0x0               // =0
               	mov	x15, #0x8               // =8
               	sdiv	x14, x14, x15
               	add	x13, x13, x14
               	ldrb	w13, [x13]
               	mov	x17, #0x1               // =1
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.ne	<addr>
               	mov	x14, #0x18              // =24
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x13, x29, #0x80
               	stur	x13, [x29, #-0xd8]
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0xe0]
               	b	<addr>
               	mov	x15, #0x0               // =0
               	cbnz	x15, <addr>
               	sub	x14, x29, #0x80
               	mov	x15, #0x0               // =0
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w14, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x14, x17
               	cbz	x14, <addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0xe0]
               	cmp	x14, #0x80
               	b.ge	<addr>
               	ldur	x13, [x29, #-0xd8]
               	ldursw	x14, [x29, #-0xe0]
               	add	x13, x13, x14
               	mov	x14, #0x0               // =0
               	strb	w14, [x13]
               	ldursw	x15, [x29, #-0xe0]
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	stur	w15, [x29, #-0xe0]
               	b	<addr>
               	b	<addr>
               	mov	x15, #0x19              // =25
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x80
               	mov	x15, #0x64              // =100
               	mov	x13, #0x8               // =8
               	sdiv	x15, x15, x13
               	add	x14, x14, x15
               	ldrb	w14, [x14]
               	mov	x17, #0x10              // =16
               	and	x14, x14, x17
               	cbz	x14, <addr>
               	mov	x15, #0x1a              // =26
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0x150
               	mov	x20, x19
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x110
               	ldp	x29, x30, [sp], #0x10
               	ret
