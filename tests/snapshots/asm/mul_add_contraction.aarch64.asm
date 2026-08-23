
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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x4, #0x0                // =0
               	b	<addr>
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x7, x5, x17
               	add	x6, x9, x7
               	ldrsw	x0, [x6]
               	ldrsw	x1, [x6, #0x4]
               	ldrsw	x2, [x6, #0x8]
               	mul	x3, x0, x1
               	add	x8, x2, x3
               	ldrsw	x6, [x6, #0xc]
               	cmp	w8, w6
               	b.ne	<addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	add	x6, x6, x7
               	ldrsw	x6, [x6, #0xc]
               	cmp	w8, w6
               	b.ne	<addr>
               	sub	x6, x2, x3
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	add	x8, x8, x7
               	ldrsw	x8, [x8, #0x10]
               	cmp	w6, w8
               	b.ne	<addr>
               	sub	x8, x3, x2
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	add	x9, x9, x7
               	ldrsw	x9, [x9, #0x14]
               	cmp	w8, w9
               	b.ne	<addr>
               	eor	x6, x6, x3
               	sxtw	x6, w6
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	add	x5, x8, x7
               	ldrsw	x5, [x5, #0x10]
               	sxtw	x3, w3
               	eor	x3, x5, x3
               	cmp	x6, x3
               	b.ne	<addr>
               	msub	x3, x0, x1, x2
               	sxtw	x3, w3
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	w6, w4
               	mov	x17, #0x18              // =24
               	mul	x6, x6, x17
               	add	x5, x5, x6
               	ldrsw	x5, [x5, #0x10]
               	cmp	x3, x5
               	b.ne	<addr>
               	mov	x0, x2
               	cmp	x0, x2
               	b.ne	<addr>
               	mov	w0, w4
               	add	x4, x0, #0x1
               	mov	w5, w4
               	cmp	w5, #0x7
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x17, #0x28              // =40
               	mul	x3, x2, x17
               	add	x1, x4, x3
               	ldr	x5, [x1]
               	ldr	x6, [x1, #0x8]
               	ldr	x7, [x1, #0x10]
               	mul	x8, x5, x6
               	add	x9, x7, x8
               	ldr	x1, [x1, #0x18]
               	cmp	x9, x1
               	b.ne	<addr>
               	sub	x4, x7, x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldr	x1, [x1, #0x20]
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	mov	w2, w0
               	cmp	w2, #0x4
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x17, #0x14              // =20
               	mul	x3, x2, x17
               	add	x1, x4, x3
               	ldr	w5, [x1]
               	ldr	w6, [x1, #0x4]
               	ldr	w7, [x1, #0x8]
               	mov	w8, w5
               	mov	w9, w6
               	mov	w10, w7
               	mov	w11, w10
               	mov	w12, w8
               	mov	w13, w9
               	mul	x14, x12, x13
               	mov	w15, w14
               	add	x20, x11, x15
               	mov	w20, w20
               	ldr	w1, [x1, #0xc]
               	cmp	w20, w1
               	b.ne	<addr>
               	sub	x1, x11, x15
               	mov	w4, w1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldr	w1, [x1, #0x10]
               	cmp	w4, w1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	mov	w2, w0
               	cmp	w2, #0x4
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x17, #0x28              // =40
               	mul	x3, x2, x17
               	add	x1, x4, x3
               	ldr	x5, [x1]
               	ldr	x6, [x1, #0x8]
               	ldr	x7, [x1, #0x10]
               	mul	x8, x5, x6
               	add	x9, x7, x8
               	ldr	x1, [x1, #0x18]
               	cmp	x9, x1
               	b.ne	<addr>
               	sub	x4, x7, x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldr	x1, [x1, #0x20]
               	cmp	x4, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	mov	w2, w0
               	cmp	w2, #0x3
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mov	x17, #0xc               // =12
               	mul	x7, x2, x17
               	add	x1, x6, x7
               	ldrsw	x4, [x1]
               	ldrsw	x3, [x1, #0x4]
               	sdiv	x5, x4, x3
               	msub	x3, x5, x3, x4
               	add	x3, x5, x3
               	ldrsw	x1, [x1, #0x8]
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	mov	w2, w0
               	cmp	w2, #0x6
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x6, x2, x17
               	add	x1, x5, x6
               	ldr	x7, [x1]
               	ldr	x3, [x1, #0x8]
               	sdiv	x4, x7, x3
               	msub	x3, x4, x3, x7
               	add	x3, x4, x3
               	ldr	x1, [x1, #0x10]
               	cmp	x3, x1
               	b.ne	<addr>
               	add	x0, x2, #0x1
               	mov	w2, w0
               	cmp	w2, #0x3
               	b.lo	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	lsl	x8, x4, #5
               	add	x0, x7, x8
               	ldr	x3, [x0]
               	ldr	x1, [x0, #0x8]
               	ldr	x5, [x0, #0x10]
               	add	x10, x3, #0x1
               	add	x11, x1, #0x2
               	add	x12, x5, #0x3
               	eor	x13, x3, x1
               	eor	x14, x1, x5
               	add	x9, x3, x1
               	add	x6, x1, x5
               	add	x5, x3, x5
               	msub	x15, x6, x5, x9
               	add	x10, x15, x10
               	add	x10, x10, x11
               	add	x10, x10, x12
               	add	x10, x10, x13
               	add	x10, x10, x14
               	add	x9, x10, x9
               	add	x6, x9, x6
               	add	x5, x6, x5
               	madd	x1, x3, x1, x5
               	ldr	x0, [x0, #0x18]
               	cmp	x1, x0
               	b.ne	<addr>
               	add	x2, x4, #0x1
               	mov	w4, w2
               	cmp	w4, #0x3
               	b.lo	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x33
               	b.eq	<addr>
               	mov	x0, #0x46               // =70
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x0
               	b.lt	<addr>
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	mov	x0, #0x47               // =71
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x4, x4, x17
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x2, w0
               	ldrsw	x4, [x3, x2, lsl #2]
               	mov	x17, #0x7               // =7
               	mul	x4, x4, x17
               	add	x1, x1, x4
               	sxtw	x1, w1
               	add	x0, x2, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sxtw	x0, w1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x3c               // =60
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x33               // =51
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x32               // =50
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x29               // =41
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x28               // =40
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
