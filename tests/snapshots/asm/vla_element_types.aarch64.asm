
vla_element_types.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x21, [x0]
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	sxtw	x12, w1
               	ldrsw	x0, [x0]
               	sub	x0, x0, #0x1
               	sxtw	x3, w0
               	lsl	x14, x12, #2
               	mul	x22, x21, x14
               	add	x17, x22, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x13, sp
               	sub	x13, x13, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x13
               	mov	x1, #0x0                // =0
               	mov	x2, #0xa                // =10
               	cmp	w1, w21
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, w12
               	b.ge	<addr>
               	madd	x4, x1, x14, x13
               	mul	x5, x1, x2
               	add	x5, x5, x0
               	str	w5, [x4, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, w12
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w21
               	b.lt	<addr>
               	lsl	x20, x12, #2
               	mov	x17, #0x3               // =3
               	mul	x23, x20, x17
               	add	x17, x23, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x15, sp
               	sub	x15, x15, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x15
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cmp	w0, w12
               	b.ge	<addr>
               	madd	x4, x1, x20, x15
               	lsl	x2, x0, #2
               	add	x4, x4, x2
               	madd	x5, x1, x14, x13
               	add	x2, x5, x2
               	ldrsw	x2, [x2]
               	lsl	x2, x2, #1
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, w12
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	lsl	x4, x3, #3
               	mul	x5, x12, x4
               	mul	x24, x21, x5
               	add	x17, x24, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x6, sp
               	sub	x6, x6, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x6
               	mov	x2, #0x0                // =0
               	mov	x7, #0xa                // =10
               	mov	x8, #0x64               // =100
               	cmp	w2, w21
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, w12
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, w3
               	b.ge	<addr>
               	madd	x9, x2, x5, x6
               	madd	x9, x1, x4, x9
               	mul	x10, x2, x8
               	mul	x11, x1, x7
               	add	x10, x10, x11
               	add	x10, x10, x0
               	sxtw	x10, w10
               	str	x10, [x9, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w12
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w21
               	b.lt	<addr>
               	lsl	x2, x12, #2
               	mul	x0, x21, x2
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x8, sp
               	sub	x8, x8, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x8
               	lsl	x25, x2, #1
               	add	x17, x25, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x27, sp
               	sub	x27, x27, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x27
               	mov	x17, #0x3               // =3
               	mul	x0, x2, x17
               	udiv	x0, x0, x2
               	mul	x26, x0, x2
               	add	x17, x26, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x9, sp
               	sub	x9, x9, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x9
               	mov	x1, #0x0                // =0
               	cmp	w1, w21
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, w12
               	b.ge	<addr>
               	madd	x10, x1, x2, x8
               	lsl	x7, x0, #2
               	add	x10, x10, x7
               	madd	x11, x1, x14, x13
               	add	x7, x11, x7
               	ldrsw	x7, [x7]
               	neg	x7, x7
               	str	w7, [x10]
               	add	x0, x0, #0x1
               	cmp	w0, w12
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w21
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cmp	w0, w12
               	b.ge	<addr>
               	madd	x10, x1, x2, x9
               	lsl	x7, x0, #2
               	add	x10, x10, x7
               	madd	x11, x1, x14, x13
               	add	x7, x11, x7
               	ldrsw	x7, [x7]
               	add	x7, x7, #0x1
               	str	w7, [x10]
               	add	x0, x0, #0x1
               	cmp	w0, w12
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	add	x0, x27, x2
               	sub	x1, x12, #0x1
               	mov	x7, #0x4d               // =77
               	str	w7, [x0, w1, sxtw #2]
               	lsl	x0, x12, #2
               	add	x10, x13, x0
               	mul	x1, x21, x12
               	lsl	x7, x1, #2
               	cmp	x22, x7
               	b.ne	<addr>
               	cmp	x14, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x17, #0x3               // =3
               	mul	x7, x12, x17
               	sxtw	x7, w7
               	lsl	x11, x7, #2
               	cmp	x23, x11
               	b.ne	<addr>
               	mul	x1, x1, x3
               	lsl	x1, x1, #3
               	cmp	x24, x1
               	b.ne	<addr>
               	lsl	x1, x3, #3
               	cmp	x4, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	lsl	x1, x12, #1
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	cmp	x25, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	lsl	x1, x7, #2
               	cmp	x26, x1
               	b.ne	<addr>
               	add	x1, x13, x14, lsl #1
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x17
               	b.ne	<addr>
               	add	x1, x15, x20, lsl #1
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	add	x1, x6, x5, lsl #1
               	mov	x17, #0x3               // =3
               	mul	x4, x4, x17
               	add	x1, x1, x4
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0xe7
               	b.ne	<addr>
               	add	x0, x10, x0
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	add	x0, x8, x2
               	ldrsw	x0, [x0, #0x4]
               	mov	x17, #-0xb              // =-11
               	cmp	w0, w17
               	b.ne	<addr>
               	add	x0, x9, x2, lsl #1
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	add	x0, x13, x14
               	add	x0, x0, #0x8
               	sub	x0, x0, x13
               	asr	x1, x0, #63
               	add	x0, x0, x1, lsr #62
               	asr	x0, x0, #2
               	add	x1, x12, #0x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x0, x6, x5
               	sub	x0, x0, x6
               	asr	x1, x0, #63
               	add	x0, x0, x1, lsr #61
               	asr	x0, x0, #3
               	mul	x1, x12, x3
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	lsl	x3, x12, #2
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	cmp	w2, w21
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, w12
               	b.ge	<addr>
               	madd	x4, x2, x3, x13
               	ldrsw	x4, [x4, x0, lsl #2]
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, w12
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w21
               	b.lt	<addr>
               	cmp	w1, #0x8a
               	b.ne	<addr>
               	lsl	x3, x12, #2
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, #0x0                // =0
               	cmp	w0, w12
               	b.ge	<addr>
               	madd	x4, x2, x3, x15
               	ldrsw	x4, [x4, x0, lsl #2]
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, w12
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x114
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
