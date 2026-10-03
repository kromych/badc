
compound_assign_once.aarch64:	file format elf64-littleaarch64

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

<once_through_pointers>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x18
               	ldr	w2, [x0, #0x8]
               	and	x3, x2, #0x7f
               	lsl	x3, x3, #57
               	asr	x3, x3, #57
               	add	x3, x3, #0x1
               	and	x3, x3, #0x7f
               	and	x2, x2, #0xffffffffffffff80
               	orr	x2, x2, x3
               	str	w2, [x0, #0x8]
               	cmp	x1, x1
               	b.ne	<addr>
               	ldr	w2, [x0, #0x8]
               	and	x2, x2, #0x7f
               	lsl	x2, x2, #57
               	asr	x2, x2, #57
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x5
               	str	w2, [x0]
               	cmp	x1, x1
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	w2, [x0, #0x8]
               	and	x2, x2, #0xfffffffffffff07f
               	orr	x2, x2, #0x180
               	str	w2, [x0, #0x8]
               	ldr	w2, [x0, #0x8]
               	asr	x2, x2, #7
               	and	x2, x2, #0x1f
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	and	x2, x2, #0x1f
               	ldr	w3, [x0, #0x8]
               	and	x3, x3, #0xfffffffffffff07f
               	lsl	x2, x2, #7
               	orr	x2, x3, x2
               	str	w2, [x0, #0x8]
               	cmp	x1, x1
               	b.ne	<addr>
               	ldr	w0, [x0, #0x8]
               	asr	x0, x0, #7
               	and	x0, x0, #0x1f
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	str	w0, [x2]
               	mov	x3, x0
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldr	w3, [x1, #0x8]
               	and	x4, x3, #0x7f
               	lsl	x4, x4, #57
               	asr	x4, x4, #57
               	add	x4, x4, #0x1
               	and	x4, x4, #0x7f
               	and	x3, x3, #0xffffffffffffff80
               	orr	x3, x3, x4
               	str	w3, [x1, #0x8]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldr	w3, [x1, #0x8]
               	asr	x4, x3, #7
               	and	x4, x4, #0x1f
               	lsl	x4, x4, #1
               	and	x4, x4, #0x1f
               	and	x3, x3, #0xfffffffffffff07f
               	lsl	x4, x4, #7
               	orr	x3, x3, x4
               	str	w3, [x1, #0x8]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldr	w3, [x1, #0x4]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	str	w3, [x1, #0x4]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldr	x3, [x1, #0x8]
               	asr	x4, x3, #12
               	and	x4, x4, #0xffffffffff
               	lsl	x4, x4, #24
               	asr	x4, x4, #24
               	sub	x4, x4, #0x1
               	and	x4, x4, #0xffffffffff
               	and	x3, x3, #0xfff0000000000fff
               	lsl	x4, x4, #12
               	orr	x3, x3, x4
               	str	x3, [x1, #0x8]
               	ldrsw	x1, [x2]
               	add	x1, x1, #0x1
               	str	w1, [x2]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x18
               	ldr	d0, [x1, #0x10]
               	fmov	d1, #1.00000000
               	fadd	d0, d0, d1
               	str	d0, [x1, #0x10]
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	ldrb	w3, [x1, #0xe]
               	and	x3, x3, #0xffffffffffffffef
               	orr	x3, x3, #0x10
               	strb	w3, [x1, #0xe]
               	ldrsw	x1, [x2]
               	cmp	w1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ret

<common_type>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0xffffffffffffff80
               	mov	x17, #0x7d              // =125
               	orr	x0, x0, x17
               	str	w0, [x1, #0x8]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0x7f
               	lsl	x0, x0, #57
               	asr	x0, x0, #57
               	mov	w0, w0
               	lsr	x0, x0, #1
               	and	x0, x0, #0x7f
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x0, x2, x0
               	str	w0, [x1, #0x8]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0x7f
               	lsl	x0, x0, #57
               	asr	x0, x0, #57
               	mov	x17, #-0x2              // =-2
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0xffffffffffffff80
               	mov	x17, #0x7d              // =125
               	orr	x0, x0, x17
               	str	w0, [x1, #0x8]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0x7f
               	lsl	x0, x0, #57
               	asr	x0, x0, #57
               	mov	w0, w0
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0xcccc, lsl #16
               	mul	x2, x0, x17
               	lsr	x2, x2, #34
               	mov	x17, #0x5               // =5
               	mul	x2, x2, x17
               	sub	x0, x0, x2
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x0, x2, x0
               	str	w0, [x1, #0x8]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0x7f
               	lsl	x0, x0, #57
               	asr	x0, x0, #57
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0xffffffffffffff80
               	orr	x0, x0, #0x3
               	str	w0, [x1, #0x8]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0x7f
               	lsl	x0, x0, #57
               	asr	x0, x0, #57
               	scvtf	d1, x0
               	fmov	d0, #1.50000000
               	fmul	d1, d1, d0
               	fcvtzs	x0, d1
               	and	x0, x0, #0x7f
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x0, x2, x0
               	str	w0, [x1, #0x8]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0x7f
               	lsl	x0, x0, #57
               	asr	x0, x0, #57
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, #0xe]
               	and	x2, x2, #0xffffffffffffffef
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x1, #0xe]
               	asr	x2, x2, #4
               	and	x2, x2, #0x1
               	scvtf	d2, x2
               	fmov	d1, #0.25000000
               	fadd	d2, d2, d1
               	fmov	d17, x0
               	fcmp	d2, d17
               	cset	x2, ne
               	and	x2, x2, #0x1
               	ldrb	w3, [x1, #0xe]
               	and	x3, x3, #0xffffffffffffffef
               	lsl	x2, x2, #4
               	orr	x2, x3, x2
               	strb	w2, [x1, #0xe]
               	ldrb	w2, [x1, #0xe]
               	asr	x2, x2, #4
               	and	x2, x2, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xfffffffffffff07f
               	orr	x2, x2, #0xf00
               	str	w2, [x1, #0x8]
               	ldr	w2, [x1, #0x8]
               	asr	x2, x2, #7
               	and	x2, x2, #0x1f
               	scvtf	d3, x2
               	fmov	d2, #0.50000000
               	fsub	d3, d3, d2
               	fcvtzs	x2, d3
               	and	x2, x2, #0x1f
               	ldr	w3, [x1, #0x8]
               	and	x3, x3, #0xfffffffffffff07f
               	lsl	x2, x2, #7
               	orr	x2, x3, x2
               	str	w2, [x1, #0x8]
               	ldr	w1, [x1, #0x8]
               	asr	x1, x1, #7
               	and	x1, x1, #0x1f
               	cmp	w1, #0x1d
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	movk	x1, #0x100, lsl #16
               	scvtf	s3, x1
               	movi	d4, #0000000000000000
               	fadd	s3, s3, s4
               	fcvtzs	x1, s3
               	mov	x17, #0x1000000         // =16777216
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #-0x4000000000000000 // =-4611686018427387904
               	ucvtf	d4, x1
               	fmov	d3, #2.00000000
               	fdiv	d4, d4, d3
               	fcvtzu	x1, d4
               	mov	x17, #0x6000000000000000 // =6917529027641081856
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	scvtf	d4, x0
               	fadd	d1, d4, d1
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x1, ne
               	and	x1, x1, #0xff
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, #0x3f               // =63
               	mov	x1, #0x1                // =1
               	ucvtf	d1, x1
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	stur	x1, [x29, #-0x8]
               	ldur	d4, [x29, #-0x8]
               	fnmsub	d1, d1, d4, d2
               	stur	d1, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	asr	x1, x2, #63
               	and	x3, x2, #0x7fffffffffffffff
               	lsr	x3, x3, #52
               	sub	x8, x3, #0x3ff
               	and	x2, x2, #0xfffffffffffff
               	orr	x6, x2, #0x10000000000000
               	sub	x3, x3, #0x433
               	asr	x2, x3, #63
               	eor	x3, x3, x2
               	sub	x3, x3, x2
               	and	x4, x3, #0x7f
               	and	x3, x3, #0x3f
               	sub	x9, x5, x3
               	lsr	x4, x4, #6
               	neg	x7, x4
               	mvn	x4, x7
               	lsl	x10, x6, x3
               	lsr	x11, x6, x9
               	lsr	x11, x11, #1
               	lsl	x12, x0, x3
               	orr	x11, x12, x11
               	and	x12, x10, x4
               	and	x11, x11, x4
               	and	x10, x10, x7
               	orr	x11, x11, x10
               	lsr	x10, x0, x3
               	lsl	x9, x0, x9
               	lsl	x9, x9, #1
               	lsr	x3, x6, x3
               	orr	x3, x3, x9
               	and	x3, x3, x4
               	and	x6, x10, x7
               	orr	x6, x3, x6
               	and	x4, x10, x4
               	mvn	x3, x2
               	and	x7, x12, x3
               	and	x6, x6, x2
               	orr	x6, x7, x6
               	and	x3, x11, x3
               	and	x2, x4, x2
               	orr	x3, x3, x2
               	asr	x2, x8, #63
               	mvn	x2, x2
               	and	x4, x6, x2
               	and	x6, x3, x2
               	cmp	w8, #0x80
               	cset	x2, ge
               	neg	x2, x2
               	eor	x3, x4, x1
               	eor	x4, x6, x1
               	cmp	x3, x1
               	cset	x6, lo
               	sub	x3, x3, x1
               	sub	x4, x4, x1
               	sub	x4, x4, x6
               	mvn	x6, x1
               	eor	x7, x1, #0x7fffffffffffffff
               	mvn	x1, x2
               	and	x3, x3, x1
               	and	x6, x6, x2
               	orr	x3, x3, x6
               	and	x1, x4, x1
               	and	x2, x7, x2
               	orr	x1, x1, x2
               	orr	x1, x3, x1
               	cbz	x1, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	ucvtf	d1, x1
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	stur	x1, [x29, #-0x8]
               	ldur	d2, [x29, #-0x8]
               	fmul	d1, d1, d2
               	fdiv	d1, d1, d3
               	stur	d1, [x29, #-0x8]
               	ldur	x2, [x29, #-0x8]
               	asr	x1, x2, #63
               	and	x3, x2, #0x7fffffffffffffff
               	lsr	x3, x3, #52
               	sub	x8, x3, #0x3ff
               	and	x2, x2, #0xfffffffffffff
               	orr	x6, x2, #0x10000000000000
               	sub	x3, x3, #0x433
               	asr	x2, x3, #63
               	eor	x3, x3, x2
               	sub	x3, x3, x2
               	and	x4, x3, #0x7f
               	and	x3, x3, #0x3f
               	sub	x9, x5, x3
               	lsr	x4, x4, #6
               	neg	x7, x4
               	mvn	x4, x7
               	lsl	x10, x6, x3
               	lsr	x11, x6, x9
               	lsr	x11, x11, #1
               	lsl	x12, x0, x3
               	orr	x11, x12, x11
               	and	x12, x10, x4
               	and	x11, x11, x4
               	and	x10, x10, x7
               	orr	x11, x11, x10
               	lsr	x10, x0, x3
               	lsl	x9, x0, x9
               	lsl	x9, x9, #1
               	lsr	x3, x6, x3
               	orr	x3, x3, x9
               	and	x3, x3, x4
               	and	x6, x10, x7
               	orr	x6, x3, x6
               	and	x4, x10, x4
               	mvn	x3, x2
               	and	x7, x12, x3
               	and	x6, x6, x2
               	orr	x6, x7, x6
               	and	x3, x11, x3
               	and	x2, x4, x2
               	orr	x3, x3, x2
               	asr	x2, x8, #63
               	mvn	x2, x2
               	and	x4, x6, x2
               	and	x6, x3, x2
               	cmp	w8, #0x80
               	cset	x2, ge
               	neg	x2, x2
               	eor	x3, x4, x1
               	eor	x4, x6, x1
               	cmp	x3, x1
               	cset	x6, lo
               	sub	x3, x3, x1
               	sub	x4, x4, x1
               	sub	x4, x4, x6
               	mvn	x6, x1
               	eor	x7, x1, #0x7fffffffffffffff
               	mvn	x1, x2
               	and	x3, x3, x1
               	and	x6, x6, x2
               	orr	x3, x3, x6
               	and	x1, x4, x1
               	and	x2, x7, x2
               	orr	x1, x1, x2
               	eor	x2, x3, #0xfffffffffffffffd
               	mvn	x1, x1
               	orr	x1, x2, x1
               	cbz	x1, <addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x1, [x2, #0x8]
               	and	x1, x1, #0xfffffff000000000
               	mov	x3, #0x3                // =3
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	and	x1, x1, #0xfffffffff
               	lsl	x1, x1, #28
               	asr	x3, x1, #28
               	lsl	x1, x1, #36
               	orr	x4, x1, #0x3
               	asr	x1, x3, #63
               	eor	x4, x4, x1
               	eor	x3, x3, x1
               	cmp	x4, x1
               	cset	x7, lo
               	sub	x6, x4, x1
               	sub	x3, x3, x1
               	sub	x3, x3, x7
               	and	x8, x1, #0x8000000000000000
               	cmp	x3, #0x0
               	cset	x7, ne
               	lsr	x1, x3, #32
               	cmp	w1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x9, x1, #0x1
               	lsr	x1, x3, x1
               	lsr	x4, x1, #16
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #4
               	add	x9, x9, x4
               	lsr	x1, x1, x4
               	lsr	x4, x1, #8
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #3
               	add	x9, x9, x4
               	lsr	x1, x1, x4
               	lsr	x4, x1, #4
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #2
               	add	x9, x9, x4
               	lsr	x1, x1, x4
               	lsr	x4, x1, #2
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #1
               	add	x9, x9, x4
               	lsr	x1, x1, x4
               	lsr	x1, x1, #1
               	cmp	x1, #0x0
               	cset	x1, ne
               	add	x1, x9, x1
               	mul	x1, x1, x7
               	mov	x4, #0x40               // =64
               	sub	x4, x4, x1
               	and	x4, x4, #0x3f
               	mov	x7, #-0x1               // =-1
               	lsr	x4, x7, x4
               	cmp	x1, #0x0
               	cset	x7, ne
               	mul	x4, x4, x7
               	and	x4, x6, x4
               	cmp	x4, #0x0
               	cset	x9, ne
               	and	x7, x1, #0x7f
               	and	x4, x1, #0x3f
               	sub	x10, x5, x4
               	lsr	x7, x7, #6
               	neg	x7, x7
               	mvn	x11, x7
               	lsr	x12, x3, x4
               	lsl	x3, x3, x10
               	lsl	x3, x3, #1
               	lsr	x4, x6, x4
               	orr	x3, x4, x3
               	and	x3, x3, x11
               	and	x4, x12, x7
               	orr	x3, x3, x4
               	orr	x3, x3, x9
               	ucvtf	d1, x3
               	add	x1, x1, #0x3ff
               	lsl	x1, x1, #52
               	orr	x1, x1, x8
               	stur	x1, [x29, #-0x8]
               	ldur	d2, [x29, #-0x8]
               	fmul	d1, d1, d2
               	fmul	d0, d1, d0
               	stur	d0, [x29, #-0x8]
               	ldur	x3, [x29, #-0x8]
               	asr	x1, x3, #63
               	and	x4, x3, #0x7fffffffffffffff
               	lsr	x4, x4, #52
               	sub	x8, x4, #0x3ff
               	and	x3, x3, #0xfffffffffffff
               	orr	x6, x3, #0x10000000000000
               	sub	x4, x4, #0x433
               	asr	x3, x4, #63
               	eor	x4, x4, x3
               	sub	x4, x4, x3
               	and	x7, x4, #0x7f
               	and	x4, x4, #0x3f
               	sub	x9, x5, x4
               	lsr	x5, x7, #6
               	neg	x7, x5
               	mvn	x5, x7
               	lsl	x10, x6, x4
               	lsr	x11, x6, x9
               	lsr	x11, x11, #1
               	lsl	x12, x0, x4
               	orr	x11, x12, x11
               	and	x12, x10, x5
               	and	x11, x11, x5
               	and	x10, x10, x7
               	orr	x11, x11, x10
               	lsr	x10, x0, x4
               	lsl	x9, x0, x9
               	lsl	x9, x9, #1
               	lsr	x4, x6, x4
               	orr	x4, x4, x9
               	and	x4, x4, x5
               	and	x6, x10, x7
               	orr	x6, x4, x6
               	and	x5, x10, x5
               	mvn	x4, x3
               	and	x7, x12, x4
               	and	x6, x6, x3
               	orr	x6, x7, x6
               	and	x4, x11, x4
               	and	x3, x5, x3
               	orr	x4, x4, x3
               	asr	x3, x8, #63
               	mvn	x3, x3
               	and	x5, x6, x3
               	and	x6, x4, x3
               	cmp	w8, #0x80
               	cset	x3, ge
               	neg	x3, x3
               	eor	x4, x5, x1
               	eor	x5, x6, x1
               	cmp	x4, x1
               	cset	x6, lo
               	sub	x4, x4, x1
               	sub	x5, x5, x1
               	sub	x5, x5, x6
               	mvn	x6, x1
               	eor	x7, x1, #0x7fffffffffffffff
               	mvn	x1, x3
               	and	x4, x4, x1
               	and	x6, x6, x3
               	orr	x4, x4, x6
               	and	x1, x5, x1
               	and	x3, x7, x3
               	orr	x1, x1, x3
               	and	x3, x1, #0xfffffffff
               	ldr	x1, [x2, #0x8]
               	and	x5, x1, #0xfffffff000000000
               	orr	x1, x0, x4
               	orr	x3, x5, x3
               	str	x1, [x2]
               	str	x3, [x2, #0x8]
               	and	x2, x3, #0xfffffffff
               	lsl	x3, x1, #28
               	lsl	x2, x2, #28
               	lsr	x1, x1, #36
               	orr	x1, x2, x1
               	asr	x2, x1, #28
               	lsr	x3, x3, #28
               	lsl	x1, x1, #36
               	orr	x1, x3, x1
               	eor	x1, x1, #0x4
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<assignment_value>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x38]
               	and	x1, x1, #0xfff0000000000fff
               	orr	x1, x1, #0x7fffffffff000
               	str	x1, [x0, #0x38]
               	asr	x2, x1, #12
               	and	x2, x2, #0xffffffffff
               	lsl	x2, x2, #24
               	asr	x2, x2, #24
               	add	x2, x2, #0x1
               	and	x2, x2, #0xffffffffff
               	and	x1, x1, #0xfff0000000000fff
               	lsl	x3, x2, #12
               	orr	x1, x1, x3
               	str	x1, [x0, #0x38]
               	lsl	x1, x2, #24
               	asr	x1, x1, #24
               	mov	x17, #-0x8000000000     // =-549755813888
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	ldr	x1, [x0, #0x38]
               	asr	x2, x1, #12
               	and	x2, x2, #0xffffffffff
               	lsl	x2, x2, #24
               	asr	x2, x2, #24
               	add	x2, x2, #0x1
               	and	x2, x2, #0xffffffffff
               	and	x1, x1, #0xfff0000000000fff
               	lsl	x3, x2, #12
               	orr	x1, x1, x3
               	str	x1, [x0, #0x38]
               	lsl	x1, x2, #24
               	asr	x1, x1, #24
               	mov	x17, #-0x7fffffffff     // =-549755813887
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	ldr	w1, [x0, #0x38]
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, #0x3f
               	str	w1, [x0, #0x38]
               	ldr	w1, [x0, #0x38]
               	and	x1, x1, #0x7f
               	lsl	x1, x1, #57
               	asr	x1, x1, #57
               	add	x1, x1, #0x1
               	and	x1, x1, #0x7f
               	ldr	w2, [x0, #0x38]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x2, x2, x1
               	str	w2, [x0, #0x38]
               	lsl	x1, x1, #57
               	asr	x1, x1, #57
               	mov	x17, #-0x40             // =-64
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w1, [x0, #0x38]
               	and	x1, x1, #0x7f
               	lsl	x1, x1, #57
               	asr	x1, x1, #57
               	mov	x17, #-0x40             // =-64
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x2, x2, #0x3c
               	str	w2, [x1, #0x8]
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0x7f
               	lsl	x2, x2, #57
               	asr	x2, x2, #57
               	add	x2, x2, #0xa
               	and	x2, x2, #0x7f
               	ldr	w3, [x1, #0x8]
               	and	x3, x3, #0xffffffffffffff80
               	orr	x3, x3, x2
               	str	w3, [x1, #0x8]
               	lsl	x2, x2, #57
               	asr	x2, x2, #57
               	mov	x17, #-0x3a             // =-58
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xfffffffffffff07f
               	orr	x2, x2, #0xf80
               	str	w2, [x1, #0x8]
               	ldr	w2, [x1, #0x8]
               	asr	x2, x2, #7
               	and	x2, x2, #0x1f
               	add	x2, x2, #0x1
               	and	x2, x2, #0x1f
               	ldr	w3, [x1, #0x8]
               	and	x3, x3, #0xfffffffffffff07f
               	lsl	x4, x2, #7
               	orr	x3, x3, x4
               	str	w3, [x1, #0x8]
               	cbnz	w2, <addr>
               	ldr	w1, [x1, #0x8]
               	asr	x1, x1, #7
               	and	x1, x1, #0x1f
               	cbz	w1, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	ldrb	w1, [x0, #0x3e]
               	and	x1, x1, #0xffffffffffffffef
               	orr	x1, x1, #0x10
               	strb	w1, [x0, #0x3e]
               	mov	x0, #0x0                // =0
               	ret

<int128_operand>:
               	mov	x3, #0x0                // =0
               	mov	x4, #0x80000000         // =2147483648
               	mov	x0, x3
               	mov	x2, x3
               	lsr	x1, x2, #32
               	cbnz	x1, <addr>
               	mul	x1, x2, x3
               	lsl	x5, x0, #32
               	cmp	x1, x5
               	b.ls	<addr>
               	sub	x2, x2, #0x1
               	add	x0, x0, x4
               	lsr	x1, x0, #32
               	cbz	x1, <addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	mul	x0, x2, x17
               	neg	x1, x0
               	lsr	x0, x1, #31
               	lsl	x5, x0, #31
               	sub	x1, x1, x5
               	mov	x5, #0x19               // =25
               	lsr	x6, x0, #32
               	cbnz	x6, <addr>
               	mul	x6, x0, x3
               	lsl	x7, x1, #32
               	orr	x7, x7, x5
               	cmp	x6, x7
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x6, x1, #32
               	cbz	x6, <addr>
               	lsl	x1, x2, #32
               	orr	x0, x1, x0
               	cmp	x0, #0x0
               	cset	x1, ne
               	sub	x0, x0, x1
               	umulh	x1, x0, x3
               	mul	x2, x0, x3
               	add	x1, x1, x0
               	cmp	x2, #0x32
               	cset	x2, hi
               	neg	x1, x1
               	sub	x1, x1, x2
               	cmp	x1, #0x1
               	cset	x1, lo
               	eor	x1, x1, #0x1
               	add	x0, x0, x1
               	cbz	w0, <addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x50]
               	and	x1, x1, #0xffffffffffffff80
               	mov	x17, #0x7d              // =125
               	orr	x1, x1, x17
               	str	w1, [x0, #0x50]
               	ldr	w1, [x0, #0x50]
               	and	x1, x1, #0x7f
               	lsl	x1, x1, #57
               	asr	x1, x1, #57
               	mov	x2, #0x3                // =3
               	mul	x1, x1, x2
               	and	x1, x1, #0x7f
               	ldr	w2, [x0, #0x50]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x1, x2, x1
               	str	w1, [x0, #0x50]
               	ldr	w1, [x0, #0x50]
               	and	x1, x1, #0x7f
               	lsl	x1, x1, #57
               	asr	x1, x1, #57
               	mov	x17, #-0x9              // =-9
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	ldrb	w1, [x0, #0x56]
               	and	x1, x1, #0xffffffffffffffef
               	strb	w1, [x0, #0x56]
               	ldrb	w1, [x0, #0x56]
               	and	x1, x1, #0xffffffffffffffef
               	orr	x1, x1, #0x10
               	strb	w1, [x0, #0x56]
               	ldrb	w0, [x0, #0x56]
               	asr	x0, x0, #4
               	and	x0, x0, #0x1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
