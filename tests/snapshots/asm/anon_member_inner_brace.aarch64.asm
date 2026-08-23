
anon_member_inner_brace.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x2]
               	ldrb	w3, [x0]
               	cmp	w1, w3
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x2, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w2, [x2, #0x10]
               	ldrb	w3, [x0, #0x10]
               	cmp	w2, w3
               	cset	x2, eq
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x2, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w1, [x2, #0x10]
               	ldrb	w2, [x0, #0x10]
               	cmp	w1, w2
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	cmp	w3, w4
               	mov	x3, #0x0                // =0
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0x4]
               	ldrsw	x5, [x2, #0x4]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x4, [x1, #0x8]
               	ldrsw	x5, [x2, #0x8]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x4, [x1, #0xc]
               	ldrsw	x5, [x2, #0xc]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x4, [x1, #0x10]
               	ldrsw	x5, [x2, #0x10]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x1, [x1, #0x14]
               	ldrsw	x2, [x2, #0x14]
               	cmp	w1, w2
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x4, [x1]
               	ldrsw	x5, [x2]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrsw	x4, [x1, #0x4]
               	ldrsw	x5, [x2, #0x4]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x4, [x1, #0x8]
               	ldrsw	x5, [x2, #0x8]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x3, [x1, #0xc]
               	ldrsw	x4, [x2, #0xc]
               	cmp	w3, w4
               	cset	x3, eq
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x3, [x1, #0x10]
               	ldrsw	x5, [x2, #0x10]
               	cmp	w3, w5
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x1, [x1, #0x14]
               	ldrsw	x2, [x2, #0x14]
               	cmp	w1, w2
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0xc]
               	cmp	w2, #0x3
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w2, [x2, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x9]
               	mov	x17, #0x8               // =8
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0xa]
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	w1, #0x2
               	cset	x4, eq
               	mov	x1, #0x0                // =0
               	cbz	x4, <addr>
               	ldrb	w2, [x0, #0x8]
               	cmp	w2, #0x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrsw	x2, [x0, #0xc]
               	cmp	w2, #0x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	ldrb	w2, [x0, #0x10]
               	cmp	w2, #0x5
               	cset	x2, eq
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldrb	w3, [x0]
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldrb	w3, [x0, #0x4]
               	cmp	w3, #0x2
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x0, #0x8]
               	cmp	w3, #0x3
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x0, #0xc]
               	cmp	w3, #0x4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w1, [x0, #0x10]
               	cmp	w1, #0x5
               	cset	x1, eq
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	w2, w3
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w3, [x1, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x1, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrsw	x3, [x1, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	w1, w0
               	cset	x2, eq
               	sxtw	x0, w2
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x1, x4
               	b	<addr>
               	mov	x3, x4
               	b	<addr>
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x1, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
