
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	cbz	w1, <addr>
               	mov	x0, #0x11               // =17
               	ret
               	ldrsw	x2, [x0]
               	cbz	w2, <addr>
               	mov	x0, #0x12               // =18
               	ret
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	cmp	w2, #0x0
               	cset	x2, ne
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	str	w1, [x0]
               	mov	x3, #0x1                // =1
               	str	w3, [x0]
               	mov	x2, x3
               	cmp	w2, #0x1
               	cset	x2, eq
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	cbnz	x2, <addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	cset	x2, eq
               	cmp	w2, #0x1
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	ldrsw	x2, [x0]
               	sub	x4, x2, #0x1
               	str	w4, [x0]
               	sub	x2, x2, #0x2
               	cbnz	w2, <addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	cset	x0, eq
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	w1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x4, w1
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w3, [x2, x4, lsl #2]
               	mov	x4, #0x2                // =2
               	ldrsw	x3, [x0]
               	add	x5, x3, #0x1
               	str	w5, [x0]
               	str	w4, [x2, x3, lsl #2]
               	mov	x4, #0x3                // =3
               	ldrsw	x3, [x0]
               	add	x5, x3, #0x1
               	str	w5, [x0]
               	str	w4, [x2, x3, lsl #2]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x2]
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0x4]
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0x8]
               	cmp	w3, #0x3
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	str	w1, [x0]
               	sxtw	x3, w1
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w1, [x2, x3, lsl #2]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w1, [x2, x3, lsl #2]
               	mov	x3, #0x4                // =4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x4, x1, #0x1
               	str	w4, [x0]
               	str	w3, [x2, x1, lsl #2]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x2, #0x8]
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ret
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	mov	x3, #0x1                // =1
               	sxtw	x4, w1
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w3, [x2, x4, lsl #2]
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w1, [x2, x4, lsl #2]
               	ldrsw	x4, [x0]
               	cmp	w4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ret
               	str	w1, [x0]
               	sxtw	x4, w1
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w1, [x2, x4, lsl #2]
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w1, [x2, x4, lsl #2]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ret
               	str	w1, [x0]
               	mov	x2, #0x6                // =6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w2, [x1, x4, lsl #2]
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w3, [x1, x4, lsl #2]
               	ldrsw	x3, [x0]
               	cmp	w3, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w2, [x1, x3, lsl #2]
               	mov	x3, #0x3                // =3
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w3, [x1, x4, lsl #2]
               	ldrsw	x4, [x0]
               	cmp	w4, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w2, [x1, x4, lsl #2]
               	ldrsw	x2, [x0]
               	add	x4, x2, #0x1
               	str	w4, [x0]
               	str	w3, [x1, x2, lsl #2]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x2, #0x6                // =6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w2, [x1, x3, lsl #2]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w2, [x1, x3, lsl #2]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x8
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ret
               	mov	x2, #0x0                // =0
               	str	w2, [x0]
               	sxtw	x3, w2
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w2, [x1, x3, lsl #2]
               	ldrsw	x3, [x0]
               	add	x4, x3, #0x1
               	str	w4, [x0]
               	str	w2, [x1, x3, lsl #2]
               	mov	x3, #0x1                // =1
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w3, [x1, x4, lsl #2]
               	ldrsw	x4, [x0]
               	add	x5, x4, #0x1
               	str	w5, [x0]
               	str	w3, [x1, x4, lsl #2]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x22               // =34
               	ret
               	mov	x0, x2
               	ret
