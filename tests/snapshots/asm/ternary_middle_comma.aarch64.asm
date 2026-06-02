
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0x100
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0x100
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x118
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x11e
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x125
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x100
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x15, x29, #0x8
               	adrp	x14, <page>
               	add	x14, x14, #0x150
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x14]
               	strb	w10, [x15]
               	ldrb	w10, [x14, #0x1]
               	strb	w10, [x15, #0x1]
               	ldrb	w10, [x14, #0x2]
               	strb	w10, [x15, #0x2]
               	ldrb	w10, [x14, #0x3]
               	strb	w10, [x15, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x20, #0x2a              // =42
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x20, x17
               	cmp	x14, #0x80
               	b.hs	<addr>
               	sub	x13, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x14, x20, x17
               	strb	w14, [x13]
               	mov	x12, #0x1               // =1
               	stur	x12, [x29, #-0x88]
               	b	<addr>
               	mov	x12, #0x63              // =99
               	stur	x12, [x29, #-0x88]
               	b	<addr>
               	ldur	x12, [x29, #-0x88]
               	sxtw	x14, w12
               	cmp	x14, #0x1
               	cset	x14, ne
               	stur	x14, [x29, #-0x90]
               	cbnz	x14, <addr>
               	sub	x13, x29, #0x8
               	ldrb	w13, [x13]
               	mov	x17, #0x2a              // =42
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	cset	x13, ne
               	stur	x13, [x29, #-0x90]
               	b	<addr>
               	ldur	x13, [x29, #-0x90]
               	cbz	x13, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x154
               	sxtw	x1, w12
               	sub	x12, x29, #0x8
               	ldrb	w2, [x12]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	adrp	x0, <page>
               	add	x0, x0, #0x16a
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x1]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x20, x17
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x98]
               	b	<addr>
               	mov	x2, #0x63               // =99
               	stur	x2, [x29, #-0x98]
               	b	<addr>
               	ldur	x2, [x29, #-0x98]
               	sxtw	x1, w2
               	cmp	x1, #0x1
               	cset	x1, ne
               	stur	x1, [x29, #-0xa0]
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xa0]
               	b	<addr>
               	ldur	x0, [x29, #-0xa0]
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x16e
               	sxtw	x0, w2
               	sub	x2, x29, #0x20
               	ldrb	w12, [x2]
               	mov	x2, x12
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x12, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, #0x184
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x12]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x12, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x12, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x12, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x20, x17
               	cmp	x12, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x30
               	mov	x17, #0xff              // =255
               	and	x12, x20, x17
               	strb	w12, [x0]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0xa8]
               	b	<addr>
               	mov	x1, #0x63               // =99
               	stur	x1, [x29, #-0xa8]
               	b	<addr>
               	ldur	x1, [x29, #-0xa8]
               	sxtw	x12, w1
               	cmp	x12, #0x1
               	cset	x12, ne
               	stur	x12, [x29, #-0xb0]
               	cbnz	x12, <addr>
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, ne
               	stur	x0, [x29, #-0xb0]
               	b	<addr>
               	ldur	x0, [x29, #-0xb0]
               	cbz	x0, <addr>
               	adrp	x12, <page>
               	add	x12, x12, #0x188
               	sxtw	x0, w1
               	sub	x1, x29, #0x30
               	ldrb	w2, [x1]
               	mov	x1, x0
               	mov	x0, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	stur	w2, [x29, #-0x40]
               	stur	w2, [x29, #-0x48]
               	stur	w2, [x29, #-0x50]
               	cmp	x20, #0x0
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x40]
               	mov	x20, #0x2               // =2
               	stur	w20, [x29, #-0x48]
               	mov	x0, #0x3                // =3
               	stur	w0, [x29, #-0x50]
               	ldursw	x20, [x29, #-0x40]
               	ldursw	x0, [x29, #-0x48]
               	add	x20, x20, x0
               	sxtw	x20, w20
               	ldursw	x0, [x29, #-0x50]
               	add	x20, x20, x0
               	sxtw	x20, w20
               	stur	x20, [x29, #-0xb8]
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	stur	x20, [x29, #-0xb8]
               	b	<addr>
               	ldur	x20, [x29, #-0xb8]
               	sxtw	x0, w20
               	cmp	x0, #0x6
               	cset	x0, ne
               	stur	x0, [x29, #-0xd0]
               	cbnz	x0, <addr>
               	ldursw	x2, [x29, #-0x40]
               	cmp	x2, #0x1
               	cset	x2, ne
               	stur	x2, [x29, #-0xd0]
               	b	<addr>
               	ldur	x2, [x29, #-0xd0]
               	stur	x2, [x29, #-0xc8]
               	cbnz	x2, <addr>
               	ldursw	x0, [x29, #-0x48]
               	cmp	x0, #0x2
               	cset	x0, ne
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xc0]
               	cbnz	x0, <addr>
               	ldursw	x2, [x29, #-0x50]
               	cmp	x2, #0x3
               	cset	x2, ne
               	stur	x2, [x29, #-0xc0]
               	b	<addr>
               	ldur	x2, [x29, #-0xc0]
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x19e
               	sxtw	x1, w20
               	ldursw	x2, [x29, #-0x40]
               	ldursw	x3, [x29, #-0x48]
               	ldursw	x4, [x29, #-0x50]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	adrp	x0, <page>
               	add	x0, x0, #0x1bb
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x3]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x3, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x3, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x3, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x3, #0xc8               // =200
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x3, x17
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x2, x29, #0x60
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x2]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	mov	x0, #0x63               // =99
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	ldur	x0, [x29, #-0xd8]
               	sxtw	x3, w0
               	cmp	x3, #0x63
               	cset	x3, ne
               	stur	x3, [x29, #-0xe0]
               	cbnz	x3, <addr>
               	sub	x2, x29, #0x60
               	ldrb	w2, [x2]
               	cmp	x2, #0x0
               	cset	x2, ne
               	stur	x2, [x29, #-0xe0]
               	b	<addr>
               	ldur	x2, [x29, #-0xe0]
               	cbz	x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, #0x1bf
               	sxtw	x1, w0
               	sub	x0, x29, #0x60
               	ldrb	w2, [x0]
               	mov	x0, x3
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
