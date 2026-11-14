
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
               	ldrsw	x21, [x0, #0xc]
               	ldrsw	x1, [x0, #0xc]
               	add	x1, x1, #0x1
               	sxtw	x10, w1
               	ldrsw	x0, [x0, #0xc]
               	sub	x0, x0, #0x1
               	sxtw	x3, w0
               	lsl	x12, x10, #2
               	mul	x23, x21, x12
               	add	x17, x23, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x11, sp
               	sub	x11, x11, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x11
               	mov	x1, #0x0                // =0
               	mov	x6, #0xa                // =10
               	cmp	w1, w21
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	mul	x2, x1, x6
               	cmp	w0, w10
               	b.ge	<addr>
               	madd	x4, x1, x12, x11
               	add	x5, x2, x0
               	str	w5, [x4, x0, lsl #2]
               	add	x0, x0, #0x1
               	cmp	w0, w10
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w21
               	b.lt	<addr>
               	lsl	x14, x10, #2
               	add	x25, x14, x14, lsl #1
               	add	x17, x25, #0xf
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
               	mov	x0, #0x0                // =0
               	cmp	w0, w10
               	b.ge	<addr>
               	madd	x4, x1, x14, x13
               	lsl	x2, x0, #2
               	add	x4, x4, x2
               	madd	x5, x1, x12, x11
               	add	x2, x5, x2
               	ldrsw	x2, [x2]
               	lsl	x2, x2, #1
               	str	w2, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, w10
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	lsl	x4, x3, #3
               	mul	x5, x10, x4
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
               	mov	x15, #0xa               // =10
               	mov	x22, #0x64              // =100
               	cmp	w2, w21
               	b.ge	<addr>
               	mov	x1, #0x0                // =0
               	mul	x20, x2, x22
               	cmp	w1, w10
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	mul	x7, x1, x15
               	add	x7, x20, x7
               	cmp	w0, w3
               	b.ge	<addr>
               	madd	x8, x2, x5, x6
               	madd	x8, x1, x4, x8
               	add	x9, x7, x0
               	sxtw	x9, w9
               	str	x9, [x8, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w10
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w21
               	b.lt	<addr>
               	lsl	x2, x10, #2
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
               	lsl	x22, x2, #1
               	add	x17, x22, #0xf
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
               	add	x0, x2, x2, lsl #1
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
               	cmp	w0, w10
               	b.ge	<addr>
               	madd	x15, x1, x2, x8
               	lsl	x7, x0, #2
               	add	x15, x15, x7
               	madd	x20, x1, x12, x11
               	add	x7, x20, x7
               	ldrsw	x7, [x7]
               	neg	x7, x7
               	str	w7, [x15]
               	add	x0, x0, #0x1
               	cmp	w0, w10
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, w21
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, #0x0                // =0
               	cmp	w0, w10
               	b.ge	<addr>
               	madd	x15, x1, x2, x9
               	lsl	x7, x0, #2
               	add	x15, x15, x7
               	madd	x20, x1, x12, x11
               	add	x7, x20, x7
               	ldrsw	x7, [x7]
               	add	x7, x7, #0x1
               	str	w7, [x15]
               	add	x0, x0, #0x1
               	cmp	w0, w10
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	cmp	w1, #0x3
               	b.lt	<addr>
               	add	x0, x27, x2
               	sub	x1, x10, #0x1
               	mov	x7, #0x4d               // =77
               	str	w7, [x0, w1, sxtw #2]
               	lsl	x0, x10, #2
               	add	x15, x11, x0
               	mul	x1, x21, x10
               	lsl	x7, x1, #2
               	cmp	x23, x7
               	b.ne	<addr>
               	cmp	x12, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	add	x7, x10, x10, lsl #1
               	sxtw	x20, w7
               	lsl	x20, x20, #2
               	cmp	x25, x20
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
               	lsl	x1, x10, #1
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	cmp	x22, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x50
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sxtw	x1, w7
               	lsl	x1, x1, #2
               	cmp	x26, x1
               	b.ne	<addr>
               	add	x1, x11, x12, lsl #1
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0x17
               	b.ne	<addr>
               	add	x1, x13, x14, lsl #1
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x2a
               	b.ne	<addr>
               	add	x1, x6, x5, lsl #1
               	add	x4, x4, x4, lsl #1
               	add	x1, x1, x4
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0xe7
               	b.ne	<addr>
               	add	x0, x15, x0
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
               	cmn	w0, #0xb
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
               	add	x0, x11, x12
               	add	x0, x0, #0x8
               	sub	x0, x0, x11
               	asr	x1, x0, #63
               	add	x0, x0, x1, lsr #62
               	asr	x0, x0, #2
               	add	x1, x10, #0x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x0, x6, x5
               	sub	x0, x0, x6
               	asr	x1, x0, #63
               	add	x0, x0, x1, lsr #61
               	asr	x0, x0, #3
               	mul	x1, x10, x3
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
               	lsl	x4, x10, #2
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	cmp	w2, w21
               	b.ge	<addr>
               	mov	x0, #0x0                // =0
               	cmp	w0, w10
               	b.ge	<addr>
               	madd	x5, x2, x4, x11
               	ldrsw	x5, [x5, x0, lsl #2]
               	add	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, w10
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, w21
               	b.lt	<addr>
               	cmp	w1, #0x8a
               	b.ne	<addr>
               	lsl	x4, x10, #2
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, #0x0                // =0
               	cmp	w0, w10
               	b.ge	<addr>
               	madd	x5, x2, x4, x13
               	ldrsw	x5, [x5, x0, lsl #2]
               	add	x1, x1, x5
               	add	x0, x0, #0x1
               	cmp	w0, w10
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
               	lsl	x0, x10, #2
               	mul	x1, x21, x0
               	cmp	x1, x23
               	b.ne	<addr>
               	add	x0, x11, x0, lsl #1
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x17
               	b.ne	<addr>
               	lsl	x0, x3, #3
               	mul	x0, x10, x0
               	mul	x0, x21, x0
               	cmp	x0, x24
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
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
               	mov	x0, #0xa                // =10
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
