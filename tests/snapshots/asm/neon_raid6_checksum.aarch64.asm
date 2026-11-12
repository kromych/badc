
neon_raid6_checksum.aarch64:	file format elf64-littleaarch64

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

<neon8_gen_syndrome>:
               	stp	d8, d9, [sp, #-0x90]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	ldr	x12, [x2, #0x28]
               	ldr	x13, [x2, #0x30]
               	mov	x0, #0x1d               // =29
               	dup	v0.16b, w0
               	mov	x1, #0x0                // =0
               	ldr	x0, [x2, #0x20]
               	add	x0, x0, x1
               	ldr	q19, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x4, x1, #0x10
               	add	x0, x0, x4
               	ldr	q7, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x5, x1, #0x20
               	add	x0, x0, x5
               	ldr	q6, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x6, x1, #0x30
               	add	x0, x0, x6
               	ldr	q5, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x7, x1, #0x40
               	add	x0, x0, x7
               	ldr	q4, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x8, x1, #0x50
               	add	x0, x0, x8
               	ldr	q3, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x9, x1, #0x60
               	add	x0, x0, x9
               	ldr	q2, [x0]
               	ldr	x0, [x2, #0x20]
               	add	x10, x1, #0x70
               	add	x0, x0, x10
               	ldr	q1, [x0]
               	mov	x0, #0x3                // =3
               	mov	v20.16b, v1.16b
               	mov	v27.16b, v19.16b
               	mov	v26.16b, v7.16b
               	mov	v25.16b, v6.16b
               	mov	v24.16b, v5.16b
               	mov	v23.16b, v4.16b
               	mov	v22.16b, v3.16b
               	mov	v21.16b, v2.16b
               	ldr	x3, [x2, x0, lsl #3]
               	add	x11, x3, x1
               	ldr	q28, [x11]
               	add	x3, x3, x4
               	ldr	q29, [x3]
               	ldr	x3, [x2, x0, lsl #3]
               	add	x3, x3, x5
               	ldr	q30, [x3]
               	ldr	x3, [x2, x0, lsl #3]
               	add	x3, x3, x6
               	ldr	q31, [x3]
               	ldr	x3, [x2, x0, lsl #3]
               	add	x3, x3, x7
               	ldr	q8, [x3]
               	ldr	x3, [x2, x0, lsl #3]
               	add	x3, x3, x8
               	ldr	q9, [x3]
               	ldr	x3, [x2, x0, lsl #3]
               	add	x3, x3, x9
               	ldr	q10, [x3]
               	ldr	x3, [x2, x0, lsl #3]
               	add	x3, x3, x10
               	ldr	q11, [x3]
               	eor	v27.16b, v27.16b, v28.16b
               	eor	v26.16b, v26.16b, v29.16b
               	eor	v25.16b, v25.16b, v30.16b
               	eor	v24.16b, v24.16b, v31.16b
               	eor	v23.16b, v23.16b, v8.16b
               	eor	v22.16b, v22.16b, v9.16b
               	eor	v21.16b, v21.16b, v10.16b
               	eor	v20.16b, v20.16b, v11.16b
               	sshr	v12.16b, v19.16b, #0x7
               	sshr	v13.16b, v7.16b, #0x7
               	sshr	v14.16b, v6.16b, #0x7
               	sshr	v15.16b, v5.16b, #0x7
               	sshr	v16.16b, v4.16b, #0x7
               	str	q16, [sp, #0x70]
               	sshr	v16.16b, v3.16b, #0x7
               	str	q16, [sp, #0x60]
               	sshr	v16.16b, v2.16b, #0x7
               	str	q16, [sp, #0x50]
               	sshr	v16.16b, v1.16b, #0x7
               	str	q16, [sp, #0x40]
               	shl	v19.16b, v19.16b, #0x1
               	shl	v7.16b, v7.16b, #0x1
               	shl	v6.16b, v6.16b, #0x1
               	shl	v5.16b, v5.16b, #0x1
               	shl	v4.16b, v4.16b, #0x1
               	shl	v3.16b, v3.16b, #0x1
               	shl	v2.16b, v2.16b, #0x1
               	shl	v1.16b, v1.16b, #0x1
               	and	v12.16b, v12.16b, v0.16b
               	and	v13.16b, v13.16b, v0.16b
               	and	v14.16b, v14.16b, v0.16b
               	and	v15.16b, v15.16b, v0.16b
               	ldr	q16, [sp, #0x70]
               	and	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x70]
               	ldr	q16, [sp, #0x60]
               	and	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x60]
               	ldr	q16, [sp, #0x50]
               	and	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x50]
               	ldr	q16, [sp, #0x40]
               	and	v16.16b, v16.16b, v0.16b
               	str	q16, [sp, #0x40]
               	eor	v19.16b, v19.16b, v12.16b
               	eor	v7.16b, v7.16b, v13.16b
               	eor	v6.16b, v6.16b, v14.16b
               	eor	v5.16b, v5.16b, v15.16b
               	ldr	q17, [sp, #0x70]
               	eor	v4.16b, v4.16b, v17.16b
               	ldr	q17, [sp, #0x60]
               	eor	v3.16b, v3.16b, v17.16b
               	ldr	q17, [sp, #0x50]
               	eor	v2.16b, v2.16b, v17.16b
               	ldr	q17, [sp, #0x40]
               	eor	v1.16b, v1.16b, v17.16b
               	eor	v19.16b, v19.16b, v28.16b
               	eor	v7.16b, v7.16b, v29.16b
               	eor	v6.16b, v6.16b, v30.16b
               	eor	v5.16b, v5.16b, v31.16b
               	eor	v4.16b, v4.16b, v8.16b
               	eor	v3.16b, v3.16b, v9.16b
               	eor	v2.16b, v2.16b, v10.16b
               	eor	v1.16b, v1.16b, v11.16b
               	sub	x0, x0, #0x1
               	cmp	w0, #0x0
               	b.ge	<addr>
               	add	x0, x12, x1
               	str	q27, [x0]
               	add	x0, x1, #0x10
               	add	x3, x12, x0
               	str	q26, [x3]
               	add	x3, x1, #0x20
               	add	x4, x12, x3
               	str	q25, [x4]
               	add	x4, x1, #0x30
               	add	x5, x12, x4
               	str	q24, [x5]
               	add	x5, x1, #0x40
               	add	x6, x12, x5
               	str	q23, [x6]
               	add	x6, x1, #0x50
               	add	x7, x12, x6
               	str	q22, [x7]
               	add	x7, x1, #0x60
               	add	x8, x12, x7
               	str	q21, [x8]
               	add	x8, x1, #0x70
               	add	x9, x12, x8
               	str	q20, [x9]
               	add	x9, x13, x1
               	str	q19, [x9]
               	add	x0, x13, x0
               	str	q7, [x0]
               	add	x0, x13, x3
               	str	q6, [x0]
               	add	x0, x13, x4
               	str	q5, [x0]
               	add	x0, x13, x5
               	str	q4, [x0]
               	add	x0, x13, x6
               	str	q3, [x0]
               	add	x0, x13, x7
               	str	q2, [x0]
               	add	x0, x13, x8
               	str	q1, [x0]
               	add	x1, x1, #0x80
               	cmp	w1, #0x200
               	b.lo	<addr>
               	ldp	x29, x30, [sp, #0x80]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x90
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x1, #0x0                // =0
               	mov	x3, #0x7                // =7
               	mov	x4, #0xd                // =13
               	mov	x9, #0x43               // =67
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mul	x5, x1, x9
               	add	x6, x2, x1, lsl #9
               	mul	x7, x0, x4
               	add	x7, x5, x7
               	asr	x8, x0, #3
               	mul	x8, x8, x3
               	add	x7, x7, x8
               	add	x7, x7, #0x1
               	and	x7, x7, #0xff
               	strb	w7, [x6, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	sub	x0, x29, #0x38
               	add	x5, x2, x1, lsl #9
               	str	x5, [x0, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, #0x7
               	b.lt	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	add	x8, x5, #0x800
               	add	x9, x5, #0x600
               	add	x10, x5, #0x400
               	add	x11, x5, #0x200
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldrb	w2, [x8, x0]
               	mov	x3, #0x1d               // =29
               	tst	x2, #0x80
               	csel	x3, x3, x1, ne
               	eor	x3, x3, x2, lsl #1
               	and	x4, x3, #0xff
               	ldrb	w3, [x9, x0]
               	eor	x4, x4, x3
               	eor	x12, x2, x3
               	mov	x2, #0x1d               // =29
               	tst	x4, #0x80
               	csel	x2, x2, x1, ne
               	eor	x2, x2, x4, lsl #1
               	and	x3, x2, #0xff
               	ldrb	w2, [x10, x0]
               	eor	x3, x3, x2
               	eor	x4, x12, x2
               	mov	x2, #0x1d               // =29
               	tst	x3, #0x80
               	csel	x2, x2, x1, ne
               	eor	x2, x2, x3, lsl #1
               	and	x3, x2, #0xff
               	ldrb	w2, [x11, x0]
               	eor	x3, x3, x2
               	eor	x4, x4, x2
               	mov	x2, #0x1d               // =29
               	tst	x3, #0x80
               	csel	x2, x2, x1, ne
               	eor	x2, x2, x3, lsl #1
               	and	x3, x2, #0xff
               	ldrb	w2, [x5, x0]
               	eor	x3, x3, x2
               	eor	x2, x4, x2
               	strb	w2, [x6, x0]
               	strb	w3, [x7, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x20, #0x2325            // =8997
               	movk	x20, #0x8422, lsl #16
               	movk	x20, #0x9ce4, lsl #32
               	movk	x20, #0xcbf2, lsl #48
               	mov	x1, #0x1b3              // =435
               	movk	x1, #0x100, lsl #32
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x22, x0]
               	eor	x2, x20, x2
               	mul	x20, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x1, #0x1b3              // =435
               	movk	x1, #0x100, lsl #32
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x21, x0]
               	eor	x2, x20, x2
               	mul	x20, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0x200              // =512
               	sub	x2, x29, #0x38
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x1, x2, #0xa00
               	add	x2, x2, #0xc00
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x22, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrb	w3, [x2, x0]
               	ldrb	w4, [x21, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x200
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x2, x0, #0xc00
               	add	x3, x0, #0xa00
               	mov	x0, #0x2325             // =8997
               	movk	x0, #0x8422, lsl #16
               	movk	x0, #0x9ce4, lsl #32
               	movk	x0, #0xcbf2, lsl #48
               	mov	x4, #0x1b3              // =435
               	movk	x4, #0x100, lsl #32
               	mov	x1, #0x0                // =0
               	ldrb	w5, [x3, x1]
               	eor	x0, x0, x5
               	mul	x0, x0, x4
               	add	x1, x1, #0x1
               	cmp	w1, #0x200
               	b.lt	<addr>
               	mov	x3, #0x1b3              // =435
               	movk	x3, #0x100, lsl #32
               	mov	x1, #0x0                // =0
               	ldrb	w4, [x2, x1]
               	eor	x0, x0, x4
               	mul	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, #0x200
               	b.lt	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	ldr	q0, [x16]
               	stur	q0, [x29, #-0x58]
               	sub	x1, x29, #0x58
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	mov	x17, #0x10              // =16
               	add	x16, x16, x17
               	ldr	q0, [x16]
               	stur	q0, [x29, #-0x48]
               	mov	x0, #0x0                // =0
               	ldrb	w3, [x1, x0]
               	ldrb	w4, [x2, x0]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x20
               	b.lt	<addr>
               	and	x0, x20, #0xffff
               	ucvtf	d0, x0
               	fmov	d1, #0.50000000
               	fadd	d0, d0, d1
               	stur	xzr, [x29, #-0x40]
               	stur	d0, [x29, #-0x40]
               	fmov	x0, d0
               	ldur	x1, [x29, #-0x40]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x16, #0x4567            // =17767
               	movk	x16, #0x123, lsl #16
               	add	x0, x20, x16
               	mov	x17, #0x4567            // =17767
               	movk	x17, #0x123, lsl #16
               	add	x1, x20, x17
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x0                // =0
               	cmp	x20, #0x0
               	csel	x0, x1, x0, ne
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
