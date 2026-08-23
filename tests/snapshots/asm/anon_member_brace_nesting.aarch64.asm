
anon_member_brace_nesting.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w3, [x1, #0x10]
               	ldrb	w4, [x0, #0x10]
               	cmp	w3, w4
               	cset	x3, eq
               	sxtw	x3, w3
               	cbnz	x3, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrb	w4, [x3]
               	ldrb	w5, [x0]
               	cmp	w4, w5
               	b.ne	<addr>
               	ldrb	w4, [x3, #0x4]
               	ldrb	w5, [x0, #0x4]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrb	w4, [x3, #0x8]
               	ldrb	w5, [x0, #0x8]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x4, [x3, #0xc]
               	ldrsw	x5, [x0, #0xc]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrb	w2, [x3, #0x10]
               	ldrb	w3, [x0, #0x10]
               	cmp	w2, w3
               	cset	x2, eq
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	cmp	w3, w4
               	mov	x3, #0x0                // =0
               	b.ne	<addr>
               	ldrb	w4, [x2, #0x4]
               	ldrb	w5, [x0, #0x4]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrb	w4, [x2, #0x8]
               	ldrb	w5, [x0, #0x8]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrsw	x4, [x2, #0xc]
               	ldrsw	x5, [x0, #0xc]
               	cmp	w4, w5
               	cset	x4, eq
               	cbz	x4, <addr>
               	ldrb	w2, [x2, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	w2, w0
               	cset	x3, eq
               	sxtw	x0, w3
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x1, #0xc]
               	cmp	w0, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x10]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	cmp	w0, w17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	cmp	w0, w17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	w1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x10]
               	cmp	w1, #0x4
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x10]
               	cmp	w1, #0x4
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	mov	x4, x3
               	b	<addr>
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
               	mov	x3, x2
               	b	<addr>
