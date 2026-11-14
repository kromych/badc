
simd_rows_fold_over_constants.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q16, [x0]
               	str	q16, [sp, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	q16, [x0]
               	str	q16, [sp, #0x20]
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0xc]
               	fmov	s0, w1
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x10]
               	mov	v0.s[1], w1
               	mov	x1, #0x7fff8000         // =2147450880
               	mov	v0.s[2], w1
               	mov	x1, #-0x1               // =-1
               	mov	v16.16b, v0.16b
               	mov	v16.s[3], w1
               	str	q16, [sp, #0x50]
               	ldrsw	x0, [x0, #0xc]
               	mov	x17, #0x5677            // =22135
               	movk	x17, #0x1234, lsl #16
               	sub	x0, x0, x17
               	sxth	x0, w0
               	mov	v0.h[0], w0
               	mov	x0, #-0x2               // =-2
               	mov	v0.h[1], w0
               	mov	x0, #0x3                // =3
               	mov	v0.h[2], w0
               	mov	x0, #0x7fff             // =32767
               	mov	v0.h[3], w0
               	mov	x0, #-0x8000            // =-32768
               	mov	v0.h[4], w0
               	mov	x0, #0x6                // =6
               	mov	v0.h[5], w0
               	mov	x0, #-0x7               // =-7
               	mov	v0.h[6], w0
               	mov	x0, #0x8                // =8
               	mov	v16.16b, v0.16b
               	mov	v16.h[7], w0
               	str	q16, [sp, #0x40]
               	ldr	q16, [sp, #0x30]
               	ldr	q17, [sp, #0x20]
               	sqadd	v0.8h, v16.8h, v17.8h
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	sqadd	v0.8h, v16.8h, v17.8h
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	mov	x17, #0x5679            // =22137
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0x7899            // =30873
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x30]
               	ldr	q17, [sp, #0x20]
               	sqdmulh	v0.8h, v16.8h, v17.8h
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	sqdmulh	v0.8h, v16.8h, v17.8h
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	cbnz	x0, <addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0xf89a            // =63642
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0x7fff            // =32767
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x30]
               	shl	v0.4s, v16.4s, #0x9
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	shl	v0.4s, v16.4s, #0x9
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	mov	x17, #0xf000            // =61440
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0x3579            // =13689
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	cbnz	x0, <addr>
               	umov	w0, v0.h[7]
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x20]
               	abs	v0.8h, v16.8h
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x40]
               	abs	v0.8h, v16.8h
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0x7fff            // =32767
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x30]
               	ldr	q17, [sp, #0x20]
               	zip1	v0.8h, v16.8h, v17.8h
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	zip1	v0.8h, v16.8h, v17.8h
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	mov	x17, #0x5678            // =22136
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0xfffe            // =65534
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0xbcdf            // =48351
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	mov	x17, #0x7fff            // =32767
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x30]
               	ldr	q17, [sp, #0x20]
               	srhadd	v0.8h, v16.8h, v17.8h
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	srhadd	v0.8h, v16.8h, v17.8h
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	mov	x17, #0x2b3d            // =11069
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0x3c4d            // =15437
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0x8000            // =32768
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x30]
               	ldr	q17, [sp, #0x20]
               	cmgt	v0.8h, v16.8h, v17.8h
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	cmgt	v0.8h, v16.8h, v17.8h
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	cbnz	x0, <addr>
               	umov	w0, v0.h[4]
               	cbnz	x0, <addr>
               	umov	w0, v0.h[7]
               	cbz	x0, <addr>
               	mov	x0, #0x6b               // =107
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x30]
               	ldr	q17, [sp, #0x20]
               	ext	v0.16b, v16.16b, v17.16b, #0x6
               	sub	x0, x29, #0x60
               	stur	q0, [x29, #-0x60]
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	ext	v0.16b, v16.16b, v17.16b, #0x6
               	sub	x1, x29, #0x50
               	stur	q0, [x29, #-0x50]
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	q0, [x29, #-0x50]
               	umov	w0, v0.h[0]
               	mov	x17, #0xf89a            // =63642
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[3]
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[4]
               	mov	x17, #0xffff            // =65535
               	cmp	x0, x17
               	b.ne	<addr>
               	umov	w0, v0.h[7]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	q16, [sp, #0x50]
               	ldr	q17, [sp, #0x40]
               	sqsub	v0.8h, v16.8h, v17.8h
               	smov	x0, v0.h[5]
               	mov	x17, #0x7ff9            // =32761
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
