
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
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
               	mov	x0, #0x2a               // =42
               	mov	w1, w0
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x2, x0, x17
               	strb	w2, [x1]
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0x63               // =99
               	sxtw	x1, w2
               	cmp	x1, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	sub	x2, x29, #0x8
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	w1, w0
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x20
               	mov	x17, #0xff              // =255
               	and	x2, x0, x17
               	strb	w2, [x1]
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0x63               // =99
               	sxtw	x1, w2
               	cmp	x1, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x20
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	sub	x2, x29, #0x20
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x2]
               	strb	w10, [x1]
               	ldrb	w10, [x2, #0x1]
               	strb	w10, [x1, #0x1]
               	ldrb	w10, [x2, #0x2]
               	strb	w10, [x1, #0x2]
               	ldrb	w10, [x2, #0x3]
               	strb	w10, [x1, #0x3]
               	ldr	x10, [sp], #0x10
               	mov	w1, w0
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x30
               	mov	x17, #0xff              // =255
               	and	x2, x0, x17
               	strb	w2, [x1]
               	mov	x2, #0x1                // =1
               	b	<addr>
               	mov	x2, #0x63               // =99
               	sxtw	x1, w2
               	cmp	x1, #0x1
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w2
               	sub	x2, x29, #0x30
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	b.le	<addr>
               	mov	x4, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x2, #0x3                // =3
               	add	x0, x4, x3
               	add	x0, x0, x2
               	sxtw	x1, w0
               	b	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	x3, x2
               	mov	x4, x2
               	sxtw	x0, w1
               	cmp	x0, #0x6
               	cset	x0, ne
               	mov	x6, #0x1                // =1
               	cbnz	x0, <addr>
               	sxtw	x0, w4
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x6, ne
               	mov	x5, #0x1                // =1
               	cbnz	x6, <addr>
               	sxtw	x0, w3
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x5, ne
               	cbnz	x5, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	cset	x5, ne
               	cbz	x5, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w1
               	sxtw	x4, w4
               	sxtw	x3, w3
               	sxtw	x2, w2
               	mov	x16, x4
               	mov	x4, x2
               	mov	x2, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
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
               	mov	w1, w0
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x60
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x1]
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x63               // =99
               	sxtw	x0, w1
               	cmp	x0, #0x63
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x60
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w1
               	sub	x2, x29, #0x60
               	ldrb	w2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
