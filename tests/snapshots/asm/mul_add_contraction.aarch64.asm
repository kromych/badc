
mul_add_contraction.aarch64:	file format elf64-littleaarch64

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
               	mov	x4, #0x0                // =0
               	mov	x10, #0x18              // =24
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	b	<addr>
               	mul	x8, x6, x10
               	add	x7, x5, x8
               	ldrsw	x0, [x7]
               	ldrsw	x1, [x7, #0x4]
               	ldrsw	x2, [x7, #0x8]
               	mul	x3, x0, x1
               	add	x9, x2, x3
               	ldrsw	x7, [x7, #0xc]
               	cmp	w9, w7
               	b.ne	<addr>
               	add	x7, x5, x8
               	ldrsw	x7, [x7, #0xc]
               	cmp	w9, w7
               	b.ne	<addr>
               	sub	x7, x2, x3
               	add	x9, x5, x8
               	ldrsw	x9, [x9, #0x10]
               	cmp	w7, w9
               	b.ne	<addr>
               	sub	x9, x3, x2
               	add	x11, x5, x8
               	ldrsw	x11, [x11, #0x14]
               	cmp	w9, w11
               	b.ne	<addr>
               	eor	x7, x7, x3
               	sxtw	x7, w7
               	add	x6, x5, x8
               	ldrsw	x6, [x6, #0x10]
               	sxtw	x3, w3
               	eor	x3, x6, x3
               	cmp	x7, x3
               	b.ne	<addr>
               	msub	x3, x0, x1, x2
               	sxtw	x3, w3
               	mov	w6, w4
               	mul	x6, x6, x10
               	add	x6, x5, x6
               	ldrsw	x6, [x6, #0x10]
               	cmp	x3, x6
               	b.ne	<addr>
               	mov	x0, x2
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	w0, w4
               	add	x4, x0, #0x1
               	mov	w6, w4
               	cmp	w6, #0x7
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mul	x4, x4, x5
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x33
               	b.eq	<addr>
               	mov	x0, #0x46               // =70
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mul	x4, x4, x5
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	mov	x0, #0x47               // =71
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0xffff             // =65535
               	movk	x5, #0xffff, lsl #16
               	movk	x5, #0xffff, lsl #32
               	movk	x5, #0xffff, lsl #48
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mul	x4, x4, x5
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x48               // =72
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x5, #0x7                // =7
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mul	x4, x4, x5
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x10               // =16
               	ret
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0xd                // =13
               	ret
               	mov	x0, #0xc                // =12
               	ret
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0xa                // =10
               	ret
