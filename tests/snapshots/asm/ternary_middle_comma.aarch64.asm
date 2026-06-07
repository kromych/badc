
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
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
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, #0x11c
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x20, #0x2a              // =42
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x21, #0x1               // =1
               	b	<addr>
               	mov	x21, #0x63              // =99
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x1
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x8
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x22, ne
               	b	<addr>
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x120
               	sxtw	x1, w21
               	sub	x2, x29, #0x8
               	ldrb	w2, [x2]
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
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, #0x136
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x21, #0x1               // =1
               	b	<addr>
               	mov	x21, #0x63              // =99
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x1
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x20
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x22, ne
               	b	<addr>
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x13a
               	sxtw	x1, w21
               	sub	x2, x29, #0x20
               	ldrb	w2, [x2]
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
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, #0x150
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x20, x17
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x30
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x21, #0x1               // =1
               	b	<addr>
               	mov	x21, #0x63              // =99
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x1
               	cset	x22, ne
               	cbnz	x22, <addr>
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0]
               	mov	x17, #0x2a              // =42
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x22, ne
               	b	<addr>
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x154
               	sxtw	x1, w21
               	sub	x2, x29, #0x30
               	ldrb	w2, [x2]
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
               	cmp	x20, #0x0
               	b.le	<addr>
               	mov	x23, #0x1               // =1
               	mov	x22, #0x2               // =2
               	mov	x21, #0x3               // =3
               	add	x0, x23, x22
               	sxtw	x0, w0
               	add	x0, x0, x21
               	sxtw	x20, w0
               	b	<addr>
               	mov	x20, #0xffff            // =65535
               	movk	x20, #0xffff, lsl #16
               	movk	x20, #0xffff, lsl #32
               	movk	x20, #0xffff, lsl #48
               	mov	x22, x21
               	mov	x23, x21
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x6
               	cset	x0, ne
               	mov	x24, #0x1               // =1
               	cbnz	x0, <addr>
               	sxtw	x0, w23
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x24, ne
               	b	<addr>
               	mov	x25, #0x1               // =1
               	cbnz	x24, <addr>
               	sxtw	x0, w22
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x25, ne
               	b	<addr>
               	cbnz	x25, <addr>
               	sxtw	x0, w21
               	cmp	x0, #0x3
               	cset	x25, ne
               	b	<addr>
               	cbz	x25, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x16a
               	sxtw	x1, w20
               	sxtw	x2, w23
               	sxtw	x3, w22
               	sxtw	x4, w21
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
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, #0x187
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldrb	w10, [x1, #0x3]
               	strb	w10, [x0, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0xc8               // =200
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x1, x0, x17
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x60
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x1]
               	mov	x20, #0x1               // =1
               	b	<addr>
               	mov	x20, #0x63              // =99
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x63
               	cset	x21, ne
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x60
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cbz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x18b
               	sxtw	x1, w20
               	sub	x2, x29, #0x60
               	ldrb	w2, [x2]
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
               	mov	x0, #0x0                // =0
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
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
