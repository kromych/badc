
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
               	mov	x1, #0x0                // =0
               	mov	x5, #0x18               // =24
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mul	x6, x1, x5
               	add	x0, x4, x6
               	ldrsw	x7, [x0]
               	ldrsw	x8, [x0, #0x4]
               	ldrsw	x2, [x0, #0x8]
               	mul	x3, x7, x8
               	add	x9, x2, x3
               	ldrsw	x10, [x0, #0xc]
               	cmp	w9, w10
               	b.ne	<addr>
               	ldrsw	x10, [x0, #0xc]
               	cmp	w9, w10
               	b.ne	<addr>
               	sub	x9, x2, x3
               	ldrsw	x10, [x0, #0x10]
               	cmp	w9, w10
               	b.ne	<addr>
               	sub	x10, x3, x2
               	ldrsw	x0, [x0, #0x14]
               	cmp	w10, w0
               	b.ne	<addr>
               	eor	x0, x9, x3
               	sxtw	x3, w0
               	add	x0, x4, x6
               	ldrsw	x6, [x0, #0x10]
               	mul	x0, x7, x8
               	sxtw	x7, w0
               	eor	x6, x6, x7
               	cmp	x3, x6
               	b.ne	<addr>
               	sub	x0, x2, x0
               	mul	x3, x1, x5
               	add	x3, x4, x3
               	ldrsw	x3, [x3, #0x10]
               	cmp	w0, w3
               	b.ne	<addr>
               	cmp	w2, w2
               	b.ne	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x7
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x4, [x2, x0, lsl #2]
               	mul	x4, x4, x3
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	w1, #0x33
               	b.eq	<addr>
               	mov	x0, #0x46               // =70
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #-0x1               // =-1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x4, [x2, x0, lsl #2]
               	mul	x4, x4, x3
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x17, #-0x11             // =-17
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x48               // =72
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x7                // =7
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldrsw	x4, [x2, x0, lsl #2]
               	mul	x4, x4, x3
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x2a
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
