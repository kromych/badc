
anon_member_brace_nesting.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w2, [x1]
               	ldrb	w3, [x0]
               	cmp	x2, x3
               	cset	x3, eq
               	mov	x2, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w2, [x1, #0x4]
               	ldrb	w3, [x0, #0x4]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	mov	x3, #0x0                // =0
               	cbz	x2, <addr>
               	ldrb	w2, [x1, #0x8]
               	ldrb	w3, [x0, #0x8]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x3, ne
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrsw	x2, [x1, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x4, ne
               	mov	x2, #0x0                // =0
               	cbz	x4, <addr>
               	ldrb	w2, [x1, #0x10]
               	ldrb	w3, [x0, #0x10]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	cmp	x3, x4
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, ne
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x4, ne
               	mov	x5, #0x0                // =0
               	cbz	x4, <addr>
               	ldrsw	x3, [x2, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x5, ne
               	mov	x3, #0x0                // =0
               	cbz	x5, <addr>
               	ldrb	w2, [x2, #0x10]
               	ldrb	w3, [x0, #0x10]
               	cmp	x2, x3
               	cset	x2, eq
               	cmp	x2, #0x0
               	cset	x3, ne
               	sxtw	x2, w3
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrb	w3, [x2]
               	ldrb	w4, [x0]
               	cmp	x3, x4
               	cset	x4, eq
               	mov	x3, #0x0                // =0
               	cbz	x4, <addr>
               	ldrb	w3, [x2, #0x4]
               	ldrb	w4, [x0, #0x4]
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x3, ne
               	mov	x4, #0x0                // =0
               	cbz	x3, <addr>
               	ldrb	w3, [x2, #0x8]
               	ldrb	w4, [x0, #0x8]
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x4, ne
               	mov	x5, #0x0                // =0
               	cbz	x4, <addr>
               	ldrsw	x3, [x2, #0xc]
               	ldrsw	x4, [x0, #0xc]
               	cmp	x3, x4
               	cset	x3, eq
               	cmp	x3, #0x0
               	cset	x5, ne
               	mov	x3, #0x0                // =0
               	cbz	x5, <addr>
               	ldrb	w2, [x2, #0x10]
               	ldrb	w0, [x0, #0x10]
               	cmp	x2, x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x3, ne
               	sxtw	x0, w3
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x1, #0xc]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x10]
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x17, #0x1111            // =4369
               	movk	x17, #0x1111, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0x2222            // =8738
               	movk	x17, #0x2222, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0x8               // =8
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
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
