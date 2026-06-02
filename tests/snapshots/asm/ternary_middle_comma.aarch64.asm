
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
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x21, <page>
               	add	x21, x21, #0x100
               	lsl	x13, x20, #3
               	add	x13, x21, x13
               	ldr	x13, [x13]
               	cbz	x13, <addr>
               	lsl	x12, x20, #3
               	add	x12, x21, x12
               	ldr	x12, [x12]
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x11, <page>
               	add	x11, x11, #0x118
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	add	x10, x10, #0x8
               	adrp	x11, <page>
               	add	x11, x11, #0x11e
               	str	x11, [x10]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x10
               	adrp	x11, <page>
               	add	x11, x11, #0x125
               	str	x11, [x13]
               	sub	x10, x29, #0x18
               	lsl	x11, x20, #3
               	add	x10, x10, x11
               	ldr	x1, [x10]
               	bl	<addr>
               	mov	x10, x0
               	cbz	x10, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x10, [x10]
               	str	x10, [x1]
               	b	<addr>
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x21, [x21]
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
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
               	mov	x12, x0
               	mov	x12, #0x1               // =1
               	mov	x0, x12
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x20
               	adrp	x12, <page>
               	add	x12, x12, #0x16a
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x12]
               	strb	w10, [x2]
               	ldrb	w10, [x12, #0x1]
               	strb	w10, [x2, #0x1]
               	ldrb	w10, [x12, #0x2]
               	strb	w10, [x2, #0x2]
               	ldrb	w10, [x12, #0x3]
               	strb	w10, [x2, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x20, x17
               	cmp	x2, #0x80
               	b.hs	<addr>
               	sub	x12, x29, #0x20
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	strb	w2, [x12]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x98]
               	b	<addr>
               	mov	x1, #0x63               // =99
               	stur	x1, [x29, #-0x98]
               	b	<addr>
               	ldur	x1, [x29, #-0x98]
               	sxtw	x2, w1
               	cmp	x2, #0x1
               	cset	x2, ne
               	stur	x2, [x29, #-0xa0]
               	cbnz	x2, <addr>
               	sub	x12, x29, #0x20
               	ldrb	w12, [x12]
               	mov	x17, #0x2a              // =42
               	eor	x12, x12, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x12, x12, x17
               	cmp	x12, #0x0
               	cset	x12, ne
               	stur	x12, [x29, #-0xa0]
               	b	<addr>
               	ldur	x12, [x29, #-0xa0]
               	cbz	x12, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x16e
               	sxtw	x12, w1
               	sub	x1, x29, #0x20
               	ldrb	w2, [x1]
               	mov	x1, x12
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, x0
               	mov	x1, #0x2                // =2
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, #0x184
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x2]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x2, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x2, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x2, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x2, x20, x17
               	cmp	x2, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x30
               	mov	x17, #0xff              // =255
               	and	x2, x20, x17
               	strb	w2, [x1]
               	mov	x12, #0x1               // =1
               	stur	x12, [x29, #-0xa8]
               	b	<addr>
               	mov	x12, #0x63              // =99
               	stur	x12, [x29, #-0xa8]
               	b	<addr>
               	ldur	x12, [x29, #-0xa8]
               	sxtw	x2, w12
               	cmp	x2, #0x1
               	cset	x2, ne
               	stur	x2, [x29, #-0xb0]
               	cbnz	x2, <addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x1, x17
               	cmp	x1, #0x0
               	cset	x1, ne
               	stur	x1, [x29, #-0xb0]
               	b	<addr>
               	ldur	x1, [x29, #-0xb0]
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	sxtw	x1, w12
               	sub	x12, x29, #0x30
               	ldrb	w2, [x12]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x12, x0
               	mov	x12, #0x3               // =3
               	mov	x0, x12
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
               	mov	x12, #0x1               // =1
               	stur	w12, [x29, #-0x40]
               	mov	x20, #0x2               // =2
               	stur	w20, [x29, #-0x48]
               	mov	x12, #0x3               // =3
               	stur	w12, [x29, #-0x50]
               	ldursw	x20, [x29, #-0x40]
               	ldursw	x12, [x29, #-0x48]
               	add	x20, x20, x12
               	sxtw	x20, w20
               	ldursw	x12, [x29, #-0x50]
               	add	x20, x20, x12
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
               	sxtw	x12, w20
               	cmp	x12, #0x6
               	cset	x12, ne
               	stur	x12, [x29, #-0xd0]
               	cbnz	x12, <addr>
               	ldursw	x2, [x29, #-0x40]
               	cmp	x2, #0x1
               	cset	x2, ne
               	stur	x2, [x29, #-0xd0]
               	b	<addr>
               	ldur	x2, [x29, #-0xd0]
               	stur	x2, [x29, #-0xc8]
               	cbnz	x2, <addr>
               	ldursw	x12, [x29, #-0x48]
               	cmp	x12, #0x2
               	cset	x12, ne
               	stur	x12, [x29, #-0xc8]
               	b	<addr>
               	ldur	x12, [x29, #-0xc8]
               	stur	x12, [x29, #-0xc0]
               	cbnz	x12, <addr>
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
               	mov	x10, x0
               	mov	x10, #0x4               // =4
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x60
               	adrp	x10, <page>
               	add	x10, x10, #0x1bb
               	str	x11, [sp, #-0x10]!
               	ldrb	w11, [x10]
               	strb	w11, [x4]
               	ldrb	w11, [x10, #0x1]
               	strb	w11, [x4, #0x1]
               	ldrb	w11, [x10, #0x2]
               	strb	w11, [x4, #0x2]
               	ldrb	w11, [x10, #0x3]
               	strb	w11, [x4, #0x3]
               	ldr	x11, [sp], #0x10
               	mov	x4, #0xc8               // =200
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x10, x4, x17
               	cmp	x10, #0x80
               	b.hs	<addr>
               	sub	x3, x29, #0x60
               	mov	x17, #0xff              // =255
               	and	x4, x4, x17
               	strb	w4, [x3]
               	mov	x10, #0x1               // =1
               	stur	x10, [x29, #-0xd8]
               	b	<addr>
               	mov	x10, #0x63              // =99
               	stur	x10, [x29, #-0xd8]
               	b	<addr>
               	ldur	x10, [x29, #-0xd8]
               	sxtw	x4, w10
               	cmp	x4, #0x63
               	cset	x4, ne
               	stur	x4, [x29, #-0xe0]
               	cbnz	x4, <addr>
               	sub	x3, x29, #0x60
               	ldrb	w3, [x3]
               	cmp	x3, #0x0
               	cset	x3, ne
               	stur	x3, [x29, #-0xe0]
               	b	<addr>
               	ldur	x3, [x29, #-0xe0]
               	cbz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1bf
               	sxtw	x1, w10
               	sub	x10, x29, #0x60
               	ldrb	w2, [x10]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x10, x0
               	mov	x10, #0x5               // =5
               	mov	x0, x10
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
