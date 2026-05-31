
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
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
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
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x19, [sp, #0x30]
               	sub	x15, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x150
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
               	ldr	x10, [sp], #0x10
               	mov	x13, x15
               	mov	x20, #0x2a              // =42
               	sxtw	x14, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x80
               	b.hs	<addr>
               	sub	x15, x29, #0x8
               	sxtw	x14, w20
               	mov	x17, #0xff              // =255
               	and	x14, x14, x17
               	strb	w14, [x15]
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
               	sub	x15, x29, #0x8
               	ldrb	w14, [x15]
               	mov	x17, #0x2a              // =42
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	cset	x14, ne
               	stur	x14, [x29, #-0x90]
               	b	<addr>
               	ldur	x14, [x29, #-0x90]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x154
               	mov	x21, x19
               	sxtw	x22, w12
               	sub	x12, x29, #0x8
               	ldrb	w23, [x12]
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x23, x29, #0x20
               	adrp	x19, <page>
               	add	x19, x19, #0x16a
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x23]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x23, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x23, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x23, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x22, x23
               	sxtw	x22, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x20
               	sxtw	x22, w20
               	mov	x17, #0xff              // =255
               	and	x22, x22, x17
               	strb	w22, [x0]
               	mov	x23, #0x1               // =1
               	stur	x23, [x29, #-0x98]
               	b	<addr>
               	mov	x23, #0x63              // =99
               	stur	x23, [x29, #-0x98]
               	b	<addr>
               	ldur	x23, [x29, #-0x98]
               	sxtw	x22, w23
               	cmp	x22, #0x1
               	cset	x22, ne
               	stur	x22, [x29, #-0xa0]
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w22, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	cset	x22, ne
               	stur	x22, [x29, #-0xa0]
               	b	<addr>
               	ldur	x22, [x29, #-0xa0]
               	cbz	x22, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x16e
               	mov	x24, x19
               	sxtw	x23, w23
               	sub	x22, x29, #0x20
               	ldrb	w25, [x22]
               	mov	x0, x24
               	mov	x2, x25
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x25, x29, #0x30
               	adrp	x19, <page>
               	add	x19, x19, #0x184
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x25]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x25, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x25, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x25, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x23, x25
               	sxtw	x23, w20
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x30
               	sxtw	x23, w20
               	mov	x17, #0xff              // =255
               	and	x23, x23, x17
               	strb	w23, [x0]
               	mov	x25, #0x1               // =1
               	stur	x25, [x29, #-0xa8]
               	b	<addr>
               	mov	x25, #0x63              // =99
               	stur	x25, [x29, #-0xa8]
               	b	<addr>
               	ldur	x25, [x29, #-0xa8]
               	sxtw	x23, w25
               	cmp	x23, #0x1
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	cbnz	x23, <addr>
               	sub	x0, x29, #0x30
               	ldrb	w23, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x23, x23, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x23, x23, x17
               	cmp	x23, #0x0
               	cset	x23, ne
               	stur	x23, [x29, #-0xb0]
               	b	<addr>
               	ldur	x23, [x29, #-0xb0]
               	cbz	x23, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x188
               	mov	x22, x19
               	sxtw	x25, w25
               	sub	x23, x29, #0x30
               	ldrb	w21, [x23]
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x40]
               	stur	w21, [x29, #-0x48]
               	stur	w21, [x29, #-0x50]
               	sxtw	x20, w20
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
               	ldursw	x21, [x29, #-0x40]
               	cmp	x21, #0x1
               	cset	x21, ne
               	stur	x21, [x29, #-0xd0]
               	b	<addr>
               	ldur	x21, [x29, #-0xd0]
               	stur	x21, [x29, #-0xc8]
               	cbnz	x21, <addr>
               	ldursw	x0, [x29, #-0x48]
               	cmp	x0, #0x2
               	cset	x0, ne
               	stur	x0, [x29, #-0xc8]
               	b	<addr>
               	ldur	x0, [x29, #-0xc8]
               	stur	x0, [x29, #-0xc0]
               	cbnz	x0, <addr>
               	ldursw	x21, [x29, #-0x50]
               	cmp	x21, #0x3
               	cset	x21, ne
               	stur	x21, [x29, #-0xc0]
               	b	<addr>
               	ldur	x21, [x29, #-0xc0]
               	cbz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x19e
               	mov	x23, x19
               	sxtw	x20, w20
               	ldursw	x24, [x29, #-0x40]
               	ldursw	x21, [x29, #-0x48]
               	ldursw	x25, [x29, #-0x50]
               	mov	x0, x23
               	mov	x4, x25
               	mov	x3, x21
               	mov	x2, x24
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x25, x29, #0x60
               	adrp	x19, <page>
               	add	x19, x19, #0x1bb
               	mov	x0, x19
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x0]
               	strb	w10, [x25]
               	ldrb	w10, [x0, #0x1]
               	strb	w10, [x25, #0x1]
               	ldrb	w10, [x0, #0x2]
               	strb	w10, [x25, #0x2]
               	ldrb	w10, [x0, #0x3]
               	strb	w10, [x25, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x21, x25
               	mov	x21, #0xc8              // =200
               	sxtw	x0, w21
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x25, x29, #0x60
               	sxtw	x21, w21
               	mov	x17, #0xff              // =255
               	and	x21, x21, x17
               	strb	w21, [x25]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	mov	x0, #0x63               // =99
               	stur	x0, [x29, #-0xd8]
               	b	<addr>
               	ldur	x0, [x29, #-0xd8]
               	sxtw	x21, w0
               	cmp	x21, #0x63
               	cset	x21, ne
               	stur	x21, [x29, #-0xe0]
               	cbnz	x21, <addr>
               	sub	x25, x29, #0x60
               	ldrb	w21, [x25]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x21, x21, x17
               	cmp	x21, #0x0
               	cset	x21, ne
               	stur	x21, [x29, #-0xe0]
               	b	<addr>
               	ldur	x21, [x29, #-0xe0]
               	cbz	x21, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x1bf
               	mov	x22, x19
               	sxtw	x25, w0
               	sub	x0, x29, #0x60
               	ldrb	w21, [x0]
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x25
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
