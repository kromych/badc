
const_strlen_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x20, x21, [sp, #-0xd0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xc0]
               	add	x29, sp, #0xc0
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	sub	x0, x29, #0x48
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	sub	x0, x29, #0x48
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x21, sp
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	x1, #0x0                // =0
               	mov	x2, #0x78               // =120
               	strb	w2, [x0]
               	strb	w1, [x0, #0x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x15               // =21
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	mov	sp, x21
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x4
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x1c]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1f               // =31
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x20               // =32
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x20]
               	mov	x17, #0x2               // =2
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x3c]
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x24
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x22               // =34
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x23               // =35
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0xc0
               	ldp	x29, x30, [sp, #0xc0]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xd0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
