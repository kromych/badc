
compound_literal_block.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<first4>:
               	mov	x3, #0x0                // =0
               	ldrsw	x1, [x0]
               	cmp	x1, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x2
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x3
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x4
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, x3
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<two_strings>:
               	mov	x3, #0x0                // =0
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	mov	x17, #0x73              // =115
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x2]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldr	x0, [x0, #0x8]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	mov	x0, x3
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x45               // =69
               	sub	x1, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldrb	w10, [x2, #0x10]
               	strb	w10, [x1, #0x10]
               	ldrb	w10, [x2, #0x11]
               	strb	w10, [x1, #0x11]
               	ldrb	w10, [x2, #0x12]
               	strb	w10, [x1, #0x12]
               	ldrb	w10, [x2, #0x13]
               	strb	w10, [x1, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x1                // =1
               	sub	x2, x29, #0x28
               	str	w1, [x2]
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x4]
               	mov	x1, #0x3                // =3
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0x8]
               	mov	x1, #0x4                // =4
               	sub	x2, x29, #0x28
               	str	w1, [x2, #0xc]
               	sub	x1, x29, #0x28
               	str	w0, [x1, #0x10]
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x45
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	ldrsw	x1, [x0]
               	cmp	x1, #0x7
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x8
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	mov	x2, #0x1                // =1
               	cbnz	x3, <addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x58
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x58
               	str	w0, [x1]
               	mov	x0, #0x5                // =5
               	sub	x1, x29, #0x58
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x58
               	ldrsw	x1, [x0]
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	stur	w0, [x29, #-0x50]
               	ldursw	x0, [x29, #-0x50]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
