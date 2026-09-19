
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
               	mov	w6, w4
               	cmp	w6, #0x7
               	b.hs	<addr>
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
               	mov	w6, w4
               	mul	x6, x6, x10
               	add	x6, x5, x6
               	ldrsw	x6, [x6, #0x10]
               	cmp	w3, w6
               	b.ne	<addr>
               	cmp	w2, w2
               	b.ne	<addr>
               	mov	w0, w4
               	add	x4, x0, #0x1
               	mov	w6, w4
               	cmp	w6, #0x7
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x5
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	mul	x3, x3, x4
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	w1, #0x33
               	b.eq	<addr>
               	mov	x0, #0x46               // =70
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	mul	x3, x3, x4
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	cmp	w1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x47               // =71
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #-0x1               // =-1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x5
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	mul	x3, x3, x4
               	add	x1, x1, x3
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
               	mov	x4, #0x7                // =7
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x3
               	b.ge	<addr>
               	sxtw	x3, w0
               	ldrsw	x3, [x2, x3, lsl #2]
               	mul	x3, x3, x4
               	add	x1, x1, x3
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
