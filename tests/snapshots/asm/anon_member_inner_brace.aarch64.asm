
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	x2, x3
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	x2, x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w2, [x0, #0x10]
               	cmp	x1, x2
               	cset	x3, eq
               	sxtw	x1, w3
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	x2, x3
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	x2, x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w2, [x0, #0x10]
               	cmp	x1, x2
               	cset	x3, eq
               	sxtw	x1, w3
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	cmp	x3, x4
               	mov	x3, #0x0                // =0
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	cmp	x3, x4
               	cset	x3, eq
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	cmp	x3, x4
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrsw	x3, [x1, #0xc]
               	ldrsw	x4, [x2, #0xc]
               	cmp	x3, x4
               	cset	x3, eq
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x3, [x1, #0x10]
               	ldrsw	x4, [x2, #0x10]
               	cmp	x3, x4
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrsw	x1, [x1, #0x14]
               	ldrsw	x2, [x2, #0x14]
               	cmp	x1, x2
               	cset	x3, eq
               	sxtw	x1, w3
               	cbnz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x1]
               	ldrsw	x4, [x2]
               	cmp	x3, x4
               	mov	x3, #0x0                // =0
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x4]
               	ldrsw	x4, [x2, #0x4]
               	cmp	x3, x4
               	cset	x3, eq
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x3, [x1, #0x8]
               	ldrsw	x4, [x2, #0x8]
               	cmp	x3, x4
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrsw	x3, [x1, #0xc]
               	ldrsw	x4, [x2, #0xc]
               	cmp	x3, x4
               	cset	x3, eq
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x3, [x1, #0x10]
               	ldrsw	x4, [x2, #0x10]
               	cmp	x3, x4
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrsw	x1, [x1, #0x14]
               	ldrsw	x2, [x2, #0x14]
               	cmp	x1, x2
               	cset	x3, eq
               	sxtw	x1, w3
               	cbnz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	x1, #0x1
               	mov	x1, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xc]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w2, w1
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0x9]
               	mov	x17, #0x8               // =8
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1, #0xa]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldrb	w1, [x0]
               	cmp	x1, #0x1
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x4]
               	cmp	x1, #0x2
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x8]
               	cmp	x1, #0x3
               	cset	x2, eq
               	mov	x1, #0x0                // =0
               	cbz	x2, <addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	x1, #0x4
               	cset	x1, eq
               	mov	x2, #0x0                // =0
               	cbz	x1, <addr>
               	ldrb	w1, [x0, #0x10]
               	cmp	x1, #0x5
               	cset	x2, eq
               	sxtw	x1, w2
               	cbnz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldrb	w2, [x0]
               	cmp	x2, #0x1
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w2, [x0, #0x4]
               	cmp	x2, #0x2
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w2, [x0, #0x8]
               	cmp	x2, #0x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x0, #0xc]
               	cmp	x2, #0x4
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x0, #0x10]
               	cmp	x1, #0x5
               	cset	x3, eq
               	sxtw	x1, w3
               	cbnz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	x2, x3
               	mov	x2, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	x2, x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	x2, x3
               	cset	x2, eq
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w1, [x1, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	x1, x0
               	cset	x3, eq
               	sxtw	x0, w3
               	cbnz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
