
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

<common_type>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xffffffffffffff80
               	mov	x17, #0x7d              // =125
               	orr	x1, x1, x17
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	sbfx	x2, x1, #0, #7
               	mov	w2, w2
               	ubfx	x2, x2, #1, #7
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	sbfx	x2, x1, #0, #7
               	mov	x17, #-0x2              // =-2
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	and	x1, x1, #0xffffffffffffff80
               	mov	x17, #0x7d              // =125
               	orr	x1, x1, x17
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	sbfx	x2, x1, #0, #7
               	mov	w2, w2
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0xcccc, lsl #16
               	mul	x3, x2, x17
               	lsr	x3, x3, #34
               	add	x3, x3, x3, lsl #2
               	sub	x2, x2, x3
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	sbfx	x2, x1, #0, #7
               	cmp	w2, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, #0x3
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	sbfx	x2, x1, #0, #7
               	scvtf	d0, x2
               	fmov	d1, #1.50000000
               	fmul	d0, d0, d1
               	fcvtzs	x2, d0
               	and	x2, x2, #0x7f
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, x2
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	sbfx	x1, x1, #0, #7
               	cmp	w1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	movi	d0, #0000000000000000
               	ldrb	w1, [x0, #0xe]
               	and	x1, x1, #0xffffffffffffffef
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x0, #0xe]
               	ubfx	x2, x1, #4, #1
               	scvtf	d1, x2
               	fmov	d2, #0.25000000
               	fadd	d1, d1, d2
               	fcmp	d1, d0
               	cset	x2, ne
               	and	x2, x2, #0x1
               	and	x1, x1, #0xffffffffffffffef
               	orr	x1, x1, x2, lsl #4
               	strb	w1, [x0, #0xe]
               	ldrb	w1, [x0, #0xe]
               	ubfx	x1, x1, #4, #1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xfffffffffffff07f
               	orr	x1, x1, #0xf00
               	str	w1, [x0, #0x8]
               	ldr	w1, [x0, #0x8]
               	ubfx	x2, x1, #7, #5
               	scvtf	d0, x2
               	fmov	d1, #0.50000000
               	fsub	d0, d0, d1
               	fcvtzs	x2, d0
               	and	x2, x2, #0x1f
               	and	x1, x1, #0xfffffffffffff07f
               	orr	x1, x1, x2, lsl #7
               	str	w1, [x0, #0x8]
               	ldr	w0, [x0, #0x8]
               	ubfx	x0, x0, #7, #5
               	cmp	w0, #0x1d
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	ldr	x1, [x2, #0x8]
               	and	x1, x1, #0xfffffff000000000
               	mov	x3, #0x3                // =3
               	str	x3, [x2]
               	str	x1, [x2, #0x8]
               	lsl	x1, x1, #28
               	asr	x3, x1, #28
               	lsl	x1, x1, #36
               	orr	x4, x1, #0x3
               	asr	x1, x3, #63
               	eor	x4, x4, x1
               	eor	x3, x3, x1
               	cmp	x4, x1
               	cset	x6, lo
               	sub	x5, x4, x1
               	sub	x3, x3, x1
               	sub	x3, x3, x6
               	and	x8, x1, #0x8000000000000000
               	cmp	x3, #0x0
               	cset	x6, ne
               	lsr	x1, x3, #32
               	cmp	w1, #0x0
               	cset	x1, ne
               	lsl	x1, x1, #5
               	add	x7, x1, #0x1
               	lsr	x1, x3, x1
               	lsr	x4, x1, #16
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #4
               	add	x7, x7, x4
               	lsr	x1, x1, x4
               	lsr	x4, x1, #8
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #3
               	add	x7, x7, x4
               	lsr	x1, x1, x4
               	lsr	x4, x1, #4
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #2
               	add	x7, x7, x4
               	lsr	x1, x1, x4
               	lsr	x4, x1, #2
               	cmp	x4, #0x0
               	cset	x4, ne
               	lsl	x4, x4, #1
               	add	x7, x7, x4
               	lsr	x1, x1, x4
               	lsr	x1, x1, #1
               	cmp	x1, #0x0
               	cset	x1, ne
               	add	x1, x7, x1
               	mul	x1, x1, x6
               	mov	x4, #0x40               // =64
               	sub	x4, x4, x1
               	and	x4, x4, #0x3f
               	mov	x6, #-0x1               // =-1
               	lsr	x4, x6, x4
               	cmp	x1, #0x0
               	cset	x6, ne
               	mul	x4, x4, x6
               	and	x4, x5, x4
               	cmp	x4, #0x0
               	cset	x9, ne
               	and	x6, x1, #0x7f
               	and	x4, x1, #0x3f
               	mov	x7, #0x3f               // =63
               	sub	x10, x7, x4
               	lsr	x6, x6, #6
               	neg	x6, x6
               	mvn	x11, x6
               	lsr	x12, x3, x4
               	lsl	x3, x3, x10
               	lsr	x4, x5, x4
               	orr	x3, x4, x3, lsl #1
               	and	x3, x3, x11
               	and	x4, x12, x6
               	orr	x3, x3, x4
               	orr	x3, x3, x9
               	ucvtf	d0, x3
               	add	x1, x1, #0x3ff
               	orr	x1, x8, x1, lsl #52
               	fmov	d1, x1
               	fmul	d0, d0, d1
               	fmov	d1, #1.50000000
               	fmul	d0, d0, d1
               	fmov	x3, d0
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
               	and	x5, x4, #0x7f
               	and	x4, x4, #0x3f
               	sub	x9, x7, x4
               	lsr	x5, x5, #6
               	neg	x7, x5
               	mvn	x5, x7
               	lsl	x10, x6, x4
               	lsr	x11, x6, x9
               	lsl	x12, x0, x4
               	orr	x11, x12, x11, lsr #1
               	and	x12, x10, x5
               	and	x11, x11, x5
               	and	x10, x10, x7
               	orr	x11, x11, x10
               	lsr	x10, x0, x4
               	lsl	x9, x0, x9
               	lsr	x4, x6, x4
               	orr	x4, x4, x9, lsl #1
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
               	lsl	x2, x3, #28
               	orr	x2, x2, x1, lsr #36
               	ubfx	x1, x1, #0, #36
               	orr	x1, x1, x2, lsl #36
               	eor	x1, x1, #0x4
               	orr	x1, x1, x2, asr #28
               	cbz	x1, <addr>
               	mov	x0, #0xf                // =15
               	ret
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x18
               	ldr	w2, [x0, #0x8]
               	sbfx	x3, x2, #0, #7
               	add	x3, x3, #0x1
               	and	x3, x3, #0x7f
               	and	x2, x2, #0xffffffffffffff80
               	orr	x2, x2, x3
               	str	w2, [x0, #0x8]
               	ldr	w2, [x0, #0x8]
               	sbfx	x3, x2, #0, #7
               	cmp	w3, #0x1
               	b.eq	<addr>
               	mov	x2, #0x1                // =1
               	cbz	x2, <addr>
               	mov	x0, x2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x38]
               	and	x1, x1, #0xfff0000000000fff
               	orr	x1, x1, #0x7fffffffff000
               	str	x1, [x0, #0x38]
               	sbfx	x2, x1, #12, #40
               	add	x2, x2, #0x1
               	and	x3, x2, #0xffffffffff
               	and	x1, x1, #0xfff0000000000fff
               	orr	x1, x1, x3, lsl #12
               	str	x1, [x0, #0x38]
               	sbfx	x2, x2, #0, #40
               	mov	x17, #-0x8000000000     // =-549755813888
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
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
               	sub	x1, x1, x0, lsl #31
               	lsr	x5, x0, #32
               	cbnz	x5, <addr>
               	mul	x5, x0, x3
               	mov	x6, #0x19               // =25
               	orr	x6, x6, x1, lsl #32
               	cmp	x5, x6
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x5, x1, #32
               	cbz	x5, <addr>
               	orr	x0, x0, x2, lsl #32
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
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0, #0x50]
               	and	x1, x1, #0xffffffffffffff80
               	mov	x17, #0x7d              // =125
               	orr	x1, x1, x17
               	str	w1, [x0, #0x50]
               	ldr	w1, [x0, #0x50]
               	sbfx	x2, x1, #0, #7
               	add	x2, x2, x2, lsl #1
               	and	x2, x2, #0x7f
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, x2
               	str	w1, [x0, #0x50]
               	ldr	w1, [x0, #0x50]
               	sbfx	x1, x1, #0, #7
               	mov	x17, #-0x9              // =-9
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	b	<addr>
               	ldrb	w1, [x0, #0x56]
               	and	x1, x1, #0xffffffffffffffef
               	strb	w1, [x0, #0x56]
               	ldrb	w1, [x0, #0x56]
               	and	x1, x1, #0xffffffffffffffef
               	orr	x1, x1, #0x10
               	strb	w1, [x0, #0x56]
               	ldrb	w0, [x0, #0x56]
               	ubfx	x0, x0, #4, #1
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sbfx	x2, x1, #12, #40
               	add	x2, x2, #0x1
               	and	x3, x2, #0xffffffffff
               	and	x1, x1, #0xfff0000000000fff
               	orr	x1, x1, x3, lsl #12
               	str	x1, [x0, #0x38]
               	sbfx	x1, x2, #0, #40
               	mov	x17, #-0x7fffffffff     // =-549755813887
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	b	<addr>
               	ldr	w1, [x0, #0x38]
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, #0x3f
               	str	w1, [x0, #0x38]
               	ldr	w1, [x0, #0x38]
               	sbfx	x2, x1, #0, #7
               	add	x2, x2, #0x1
               	and	x3, x2, #0x7f
               	and	x1, x1, #0xffffffffffffff80
               	orr	x1, x1, x3
               	str	w1, [x0, #0x38]
               	sbfx	x1, x2, #0, #7
               	mov	x17, #-0x40             // =-64
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w1, [x0, #0x38]
               	sbfx	x1, x1, #0, #7
               	mov	x17, #-0x40             // =-64
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xffffffffffffff80
               	orr	x2, x2, #0x3c
               	str	w2, [x1, #0x8]
               	ldr	w2, [x1, #0x8]
               	sbfx	x2, x2, #0, #7
               	add	x2, x2, #0xa
               	and	x3, x2, #0x7f
               	ldr	w4, [x1, #0x8]
               	and	x4, x4, #0xffffffffffffff80
               	orr	x3, x4, x3
               	str	w3, [x1, #0x8]
               	sbfx	x2, x2, #0, #7
               	mov	x17, #-0x3a             // =-58
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	b	<addr>
               	ldr	w2, [x1, #0x8]
               	and	x2, x2, #0xfffffffffffff07f
               	orr	x2, x2, #0xf80
               	str	w2, [x1, #0x8]
               	ldr	w2, [x1, #0x8]
               	ubfx	x2, x2, #7, #5
               	add	x2, x2, #0x1
               	and	x2, x2, #0x1f
               	ldr	w3, [x1, #0x8]
               	and	x3, x3, #0xfffffffffffff07f
               	orr	x3, x3, x2, lsl #7
               	str	w3, [x1, #0x8]
               	cbnz	w2, <addr>
               	ldr	w1, [x1, #0x8]
               	ubfx	x1, x1, #7, #5
               	cbz	w1, <addr>
               	mov	x0, #0x14               // =20
               	b	<addr>
               	ldrb	w1, [x0, #0x3e]
               	and	x1, x1, #0xffffffffffffffef
               	orr	x1, x1, #0x10
               	strb	w1, [x0, #0x3e]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldrsw	x3, [x0]
               	add	x3, x3, #0x5
               	str	w3, [x0]
               	cmp	w3, #0x5
               	b.eq	<addr>
               	mov	x2, #0x2                // =2
               	b	<addr>
               	and	x2, x2, #0xfffffffffffff07f
               	orr	x2, x2, #0x180
               	str	w2, [x0, #0x8]
               	ldr	w2, [x0, #0x8]
               	ubfx	x3, x2, #7, #5
               	add	x3, x3, x3, lsl #1
               	and	x3, x3, #0x1f
               	and	x2, x2, #0xfffffffffffff07f
               	orr	x2, x2, x3, lsl #7
               	str	w2, [x0, #0x8]
               	ldr	w0, [x0, #0x8]
               	ubfx	x0, x0, #7, #5
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	adrp	x0, <page>
               	mov	x2, #0x0                // =0
               	str	w2, [x0, #0xa8]
               	mov	x3, #0x1                // =1
               	str	w3, [x0, #0xa8]
               	ldr	w3, [x1, #0x8]
               	sbfx	x4, x3, #0, #7
               	add	x4, x4, #0x1
               	and	x4, x4, #0x7f
               	and	x3, x3, #0xffffffffffffff80
               	orr	x3, x3, x4
               	str	w3, [x1, #0x8]
               	ldrsw	x3, [x0, #0xa8]
               	add	x3, x3, #0x1
               	str	w3, [x0, #0xa8]
               	ldr	w3, [x1, #0x8]
               	ubfx	x4, x3, #7, #5
               	lsl	x4, x4, #1
               	and	x4, x4, #0x1f
               	and	x3, x3, #0xfffffffffffff07f
               	orr	x3, x3, x4, lsl #7
               	str	w3, [x1, #0x8]
               	ldrsw	x3, [x0, #0xa8]
               	add	x3, x3, #0x1
               	str	w3, [x0, #0xa8]
               	ldr	w3, [x1, #0x4]
               	add	x3, x3, x3, lsl #1
               	str	w3, [x1, #0x4]
               	ldrsw	x3, [x0, #0xa8]
               	add	x3, x3, #0x1
               	str	w3, [x0, #0xa8]
               	ldr	x3, [x1, #0x8]
               	sbfx	x4, x3, #12, #40
               	sub	x4, x4, #0x1
               	and	x4, x4, #0xffffffffff
               	and	x3, x3, #0xfff0000000000fff
               	orr	x3, x3, x4, lsl #12
               	str	x3, [x1, #0x8]
               	ldrsw	x1, [x0, #0xa8]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0xa8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x18
               	ldr	d0, [x1, #0x10]
               	fmov	d1, #1.00000000
               	fadd	d0, d0, d1
               	str	d0, [x1, #0x10]
               	ldrsw	x3, [x0, #0xa8]
               	add	x3, x3, #0x1
               	str	w3, [x0, #0xa8]
               	ldrb	w3, [x1, #0xe]
               	and	x3, x3, #0xffffffffffffffef
               	orr	x3, x3, #0x10
               	strb	w3, [x1, #0xe]
               	ldrsw	x0, [x0, #0xa8]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x2, #0x4                // =4
               	b	<addr>
