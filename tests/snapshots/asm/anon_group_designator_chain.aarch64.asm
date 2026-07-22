
anon_group_designator_chain.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sub	x2, x29, #0x30
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [x3, #0x20]
               	str	x10, [x2, #0x20]
               	ldr	x10, [x3, #0x28]
               	str	x10, [x2, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x1                // =1
               	sub	x3, x29, #0x30
               	str	w2, [x3]
               	sub	x2, x29, #0x30
               	str	w0, [x2, #0x8]
               	sub	x2, x29, #0x30
               	str	w1, [x2, #0xc]
               	sub	x2, x29, #0x68
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [x3, #0x20]
               	str	x10, [x2, #0x20]
               	ldr	x10, [x3, #0x28]
               	str	x10, [x2, #0x28]
               	ldrb	w10, [x3, #0x30]
               	strb	w10, [x2, #0x30]
               	ldrb	w10, [x3, #0x31]
               	strb	w10, [x2, #0x31]
               	ldrb	w10, [x3, #0x32]
               	strb	w10, [x2, #0x32]
               	ldrb	w10, [x3, #0x33]
               	strb	w10, [x2, #0x33]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x2                // =2
               	sub	x3, x29, #0x68
               	str	w2, [x3]
               	sub	x2, x29, #0x68
               	str	w0, [x2, #0xc]
               	sub	x2, x29, #0x68
               	str	w1, [x2, #0x10]
               	sub	x2, x29, #0x68
               	str	w0, [x2, #0x2c]
               	sub	x2, x29, #0x30
               	ldr	w2, [x2]
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	sub	x2, x29, #0x30
               	ldrsw	x2, [x2, #0x8]
               	cmp	x2, x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x2, x29, #0x30
               	ldr	w2, [x2, #0xc]
               	eor	x2, x2, x1
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x3, ne
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x30
               	ldrsw	x2, [x2, #0x10]
               	cmp	x2, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x68
               	ldr	w2, [x2]
               	mov	x17, #0x2               // =2
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	x2, #0x0
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	sub	x2, x29, #0x68
               	ldrsw	x2, [x2, #0xc]
               	cmp	x2, x0
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	sub	x2, x29, #0x68
               	ldr	w2, [x2, #0x10]
               	eor	x1, x2, x1
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	cset	x3, ne
               	cmp	x3, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x68
               	mov	x1, #0x0                // =0
               	ldrsw	x2, [x2, #0x4]
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	sub	x1, x29, #0x68
               	ldrsw	x1, [x1, #0x2c]
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	w0, [x0, #0xc]
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x68
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldrb	w10, [x1, #0x30]
               	strb	w10, [x0, #0x30]
               	ldrb	w10, [x1, #0x31]
               	strb	w10, [x0, #0x31]
               	ldrb	w10, [x1, #0x32]
               	strb	w10, [x0, #0x32]
               	ldrb	w10, [x1, #0x33]
               	strb	w10, [x0, #0x33]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x68
               	ldr	w0, [x0]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x7
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x68
               	ldr	w0, [x0, #0x10]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x68
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x0, x29, #0x68
               	ldrsw	x0, [x0, #0x2c]
               	cmp	x0, #0xb
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
