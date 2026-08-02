
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x0, x29, #0x20
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
               	bl	<addr>
               	mov	x20, x0
               	sxtw	x2, w20
               	mov	w0, w2
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x20
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	sub	x2, x29, #0x20
               	ldrb	w2, [x2]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x18
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
               	mov	w0, w2
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x18
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x18
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	sub	x2, x29, #0x18
               	ldrb	w2, [x2]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x10
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
               	mov	w0, w2
               	cmp	x0, #0x80
               	b.hs	<addr>
               	sub	x0, x29, #0x10
               	mov	x17, #0xff              // =255
               	and	x1, x20, x17
               	strb	w1, [x0]
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x10
               	ldrb	w1, [x1]
               	mov	x17, #0x2a              // =42
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	sub	x2, x29, #0x10
               	ldrb	w2, [x2]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x23, #0x0               // =0
               	mov	x0, x23
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x23
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x23
               	bl	<addr>
               	mov	x2, x0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.le	<addr>
               	mov	x22, #0x1               // =1
               	mov	x21, #0x2               // =2
               	mov	x2, #0x3                // =3
               	mov	x1, #0x6                // =6
               	sxtw	x0, w1
               	cmp	x0, #0x6
               	cset	x0, ne
               	mov	x3, #0x1                // =1
               	cbnz	x0, <addr>
               	sxtw	x0, w22
               	cmp	x0, #0x1
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, #0x1                // =1
               	cbnz	x3, <addr>
               	sxtw	x0, w21
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w1
               	sxtw	x3, w22
               	sxtw	x4, w21
               	sxtw	x2, w2
               	mov	x16, x3
               	mov	x3, x4
               	mov	x4, x2
               	mov	x2, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
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
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	sxtw	x1, w0
               	mov	w1, w1
               	cmp	x1, #0x80
               	b.hs	<addr>
               	sub	x1, x29, #0x8
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	strb	w0, [x1]
               	mov	x0, #0x1                // =1
               	sxtw	x1, w0
               	cmp	x1, #0x63
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x1, x29, #0x8
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	sub	x2, x29, #0x8
               	ldrb	w2, [x2]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x63               // =99
               	b	<addr>
