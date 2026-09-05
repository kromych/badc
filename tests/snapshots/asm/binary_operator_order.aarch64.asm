
binary_operator_order.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x0, x2
               	cmp	w0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x13               // =19
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x0, x2
               	cmp	w0, #0x0
               	cset	x0, ne
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	w1, [x2]
               	mov	x0, #0x1                // =1
               	str	w0, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	cset	x1, eq
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x3, x2, #0x1
               	str	w3, [x1]
               	cbnz	x2, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	cset	x1, eq
               	cmp	x1, #0x1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	sub	x3, x2, #0x1
               	str	w3, [x1]
               	sub	x1, x2, #0x2
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	cset	x1, eq
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x4]
               	add	x5, x2, #0x1
               	str	w5, [x4]
               	str	w0, [x3, x2, lsl #2]
               	mov	x5, #0x2                // =2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x4]
               	add	x6, x2, #0x1
               	str	w6, [x4]
               	str	w5, [x3, x2, lsl #2]
               	mov	x2, x0
               	mov	x5, #0x3                // =3
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x4]
               	add	x6, x2, #0x1
               	str	w6, [x4]
               	str	w5, [x3, x2, lsl #2]
               	mov	x2, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x3
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x1
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x4, x0, #0x1
               	str	w4, [x3]
               	str	w1, [x2, x0, lsl #2]
               	mov	x0, x1
               	mov	x4, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	add	x5, x0, #0x1
               	str	w5, [x3]
               	str	w4, [x2, x0, lsl #2]
               	mov	x2, #0x1                // =1
               	mov	x0, x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x0, [x4]
               	add	x5, x0, #0x1
               	str	w5, [x4]
               	str	w2, [x3, x0, lsl #2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x0, [x4]
               	add	x5, x0, #0x1
               	str	w5, [x4]
               	str	w1, [x3, x0, lsl #2]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1c               // =28
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x1, [x4]
               	add	x5, x1, #0x1
               	str	w5, [x4]
               	str	w0, [x3, x1, lsl #2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x1, [x4]
               	add	x5, x1, #0x1
               	str	w5, [x4]
               	str	w0, [x3, x1, lsl #2]
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1d               // =29
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	mov	x1, #0x6                // =6
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x3, [x5]
               	add	x6, x3, #0x1
               	str	w6, [x5]
               	str	w1, [x4, x3, lsl #2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x3, [x5]
               	add	x6, x3, #0x1
               	str	w6, [x5]
               	str	w2, [x4, x3, lsl #2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x2
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x4]
               	add	x5, x2, #0x1
               	str	w5, [x4]
               	str	w1, [x3, x2, lsl #2]
               	mov	x3, #0x3                // =3
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x2, [x5]
               	add	x6, x2, #0x1
               	str	w6, [x5]
               	str	w3, [x4, x2, lsl #2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x4
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1f               // =31
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x2, [x5]
               	add	x6, x2, #0x1
               	str	w6, [x5]
               	str	w1, [x4, x2, lsl #2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	ldrsw	x2, [x5]
               	add	x6, x2, #0x1
               	str	w6, [x5]
               	str	w3, [x4, x2, lsl #2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x6
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x20               // =32
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x4]
               	add	x5, x2, #0x1
               	str	w5, [x4]
               	str	w1, [x3, x2, lsl #2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsw	x2, [x4]
               	add	x5, x2, #0x1
               	str	w5, [x4]
               	str	w1, [x3, x2, lsl #2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x21               // =33
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x3]
               	add	x4, x1, #0x1
               	str	w4, [x3]
               	str	w0, [x2, x1, lsl #2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x3]
               	add	x4, x1, #0x1
               	str	w4, [x3]
               	str	w0, [x2, x1, lsl #2]
               	mov	x0, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x3]
               	add	x4, x1, #0x1
               	str	w4, [x3]
               	str	w0, [x2, x1, lsl #2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x1, [x3]
               	add	x4, x1, #0x1
               	str	w4, [x3]
               	str	w0, [x2, x1, lsl #2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x22               // =34
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
