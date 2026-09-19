
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
               	mov	x3, #0x0                // =0
               	mov	x10, #0x18              // =24
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	cmp	w3, #0x7
               	b.hs	<addr>
               	mul	x7, x3, x10
               	add	x4, x6, x7
               	ldrsw	x1, [x4]
               	ldrsw	x2, [x4, #0x4]
               	ldrsw	x0, [x4, #0x8]
               	mul	x5, x1, x2
               	add	x8, x0, x5
               	ldrsw	x9, [x4, #0xc]
               	cmp	w8, w9
               	b.ne	<addr>
               	ldrsw	x9, [x4, #0xc]
               	cmp	w8, w9
               	b.ne	<addr>
               	sub	x8, x0, x5
               	ldrsw	x9, [x4, #0x10]
               	cmp	w8, w9
               	b.ne	<addr>
               	sub	x9, x5, x0
               	ldrsw	x4, [x4, #0x14]
               	cmp	w9, w4
               	b.ne	<addr>
               	eor	x4, x8, x5
               	sxtw	x5, w4
               	add	x4, x6, x7
               	ldrsw	x7, [x4, #0x10]
               	mul	x4, x1, x2
               	sxtw	x8, w4
               	eor	x7, x7, x8
               	cmp	x5, x7
               	b.ne	<addr>
               	sub	x4, x0, x4
               	mul	x5, x3, x10
               	add	x5, x6, x5
               	ldrsw	x5, [x5, #0x10]
               	cmp	w4, w5
               	b.ne	<addr>
               	cmp	w0, w0
               	b.ne	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0x7
               	b.lo	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x3                // =3
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x5
               	b.ge	<addr>
               	ldrsw	x3, [x2, x0, lsl #2]
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
               	mov	x4, #-0x1               // =-1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x5
               	b.ge	<addr>
               	ldrsw	x3, [x2, x0, lsl #2]
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
               	ldrsw	x3, [x2, x0, lsl #2]
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
