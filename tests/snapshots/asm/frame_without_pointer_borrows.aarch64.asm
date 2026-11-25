
frame_without_pointer_borrows.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<divs>:
               	add	x6, x0, x0, lsl #1
               	add	x6, x6, x1
               	add	x7, x2, x2, lsl #2
               	add	x7, x7, x3
               	mov	x17, #0x7               // =7
               	mul	x8, x4, x17
               	add	x8, x8, x5
               	eor	x9, x0, x2
               	eor	x0, x1, x3
               	eor	x3, x4, x5
               	add	x2, x6, x7
               	orr	x1, x8, #0x1
               	sdiv	x4, x2, x1
               	mul	x2, x6, x7
               	sdiv	x17, x2, x1
               	msub	x1, x17, x1, x2
               	mov	x17, #0x3d1             // =977
               	mul	x2, x2, x17
               	orr	x5, x0, #0x1
               	udiv	x2, x2, x5
               	add	x5, x6, x6, lsl #16
               	mov	x17, #0x3001            // =12289
               	mul	x10, x7, x17
               	mul	x5, x5, x10
               	add	x1, x4, x1
               	add	x1, x1, x2
               	ubfx	x2, x5, #7, #16
               	add	x1, x1, x2
               	add	x1, x1, x6
               	add	x1, x1, x7
               	add	x1, x1, x8
               	add	x1, x1, x9
               	add	x0, x1, x0
               	add	x0, x0, x3
               	ret

<shifts>:
               	add	x4, x0, x0, lsl #2
               	add	x5, x1, x1, lsl #3
               	eor	x6, x0, x1
               	add	x0, x0, x1
               	and	x1, x2, #0x3f
               	lsl	x1, x4, x1
               	and	x7, x3, #0x3f
               	lsr	x7, x5, x7
               	add	x2, x2, x3
               	and	x2, x2, #0x3f
               	lsl	x2, x6, x2
               	orr	x8, x0, #0x8000000000000000
               	and	x3, x3, #0x1f
               	asr	x3, x8, x3
               	eor	x1, x1, x7
               	eor	x1, x1, x2
               	eor	x1, x1, x3
               	eor	x1, x1, x4
               	eor	x1, x1, x5
               	eor	x1, x1, x6
               	eor	x0, x1, x0
               	ret

<divq>:
               	mov	x3, #0x0                // =0
               	orr	x7, x3, x1
               	cbz	x0, <addr>
               	cmp	x0, x2
               	b.lo	<addr>
               	udiv	x17, x0, x2
               	msub	x3, x17, x2, x0
               	clz	x1, x2
               	lsl	x11, x2, x1
               	lsr	x5, x11, #32
               	mov	w6, w11
               	eor	x4, x1, #0x3f
               	lsr	x8, x7, #1
               	lsr	x4, x8, x4
               	lsl	x3, x3, x1
               	orr	x12, x3, x4
               	lsl	x1, x7, x1
               	lsr	x8, x1, #32
               	mov	w9, w1
               	udiv	x1, x12, x5
               	msub	x3, x1, x5, x12
               	lsr	x4, x1, #32
               	cbnz	x4, <addr>
               	mul	x4, x1, x6
               	orr	x10, x8, x3, lsl #32
               	cmp	x4, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x3, x3, x5
               	lsr	x4, x3, #32
               	cbz	x4, <addr>
               	orr	x3, x8, x12, lsl #32
               	msub	x4, x1, x11, x3
               	udiv	x3, x4, x5
               	msub	x4, x3, x5, x4
               	lsr	x8, x3, #32
               	cbnz	x8, <addr>
               	mul	x8, x3, x6
               	orr	x10, x9, x4, lsl #32
               	cmp	x8, x10
               	b.ls	<addr>
               	sub	x3, x3, #0x1
               	add	x4, x4, x5
               	lsr	x8, x4, #32
               	cbz	x8, <addr>
               	orr	x8, x3, x1, lsl #32
               	cbz	x0, <addr>
               	cmp	x0, x2
               	b.lo	<addr>
               	udiv	x17, x0, x2
               	msub	x0, x17, x2, x0
               	clz	x1, x2
               	lsl	x11, x2, x1
               	lsr	x4, x11, #32
               	mov	w5, w11
               	eor	x3, x1, #0x3f
               	lsr	x6, x7, #1
               	lsr	x3, x6, x3
               	lsl	x0, x0, x1
               	orr	x12, x0, x3
               	lsl	x0, x7, x1
               	lsr	x6, x0, #32
               	mov	w9, w0
               	udiv	x0, x12, x4
               	msub	x1, x0, x4, x12
               	lsr	x3, x0, #32
               	cbnz	x3, <addr>
               	mul	x3, x0, x5
               	orr	x10, x6, x1, lsl #32
               	cmp	x3, x10
               	b.ls	<addr>
               	sub	x0, x0, #0x1
               	add	x1, x1, x4
               	lsr	x3, x1, #32
               	cbz	x3, <addr>
               	orr	x1, x6, x12, lsl #32
               	msub	x3, x0, x11, x1
               	udiv	x1, x3, x4
               	msub	x3, x1, x4, x3
               	lsr	x6, x1, #32
               	cbnz	x6, <addr>
               	mul	x6, x1, x5
               	orr	x10, x9, x3, lsl #32
               	cmp	x6, x10
               	b.ls	<addr>
               	sub	x1, x1, #0x1
               	add	x3, x3, x4
               	lsr	x6, x3, #32
               	cbz	x6, <addr>
               	orr	x1, x1, x0, lsl #32
               	msub	x0, x1, x2, x7
               	eor	x0, x8, x0
               	ret
               	udiv	x17, x7, x2
               	msub	x0, x17, x2, x7
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	udiv	x8, x7, x2
               	b	<addr>

<add6>:
               	add	x0, x0, x1, lsl #1
               	add	x1, x2, x2, lsl #1
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	add	x1, x4, x4, lsl #2
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	ret

<sub6>:
               	sub	x0, x0, x1
               	add	x0, x0, x2
               	sub	x0, x0, x3
               	add	x0, x0, x4
               	sub	x0, x0, x5
               	ret

<indirect>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	mov	x22, x1
               	mov	x26, x5
               	mov	x25, x4
               	mov	x24, x3
               	mov	x23, x2
               	stur	x0, [x29, #-0x70]
               	mov	x20, #0x0               // =0
               	lsl	x27, x6, #1
               	mov	x21, x20
               	ldur	x0, [x29, #-0x70]
               	and	x1, x20, #0x1
               	add	x0, x0, x1, lsl #3
               	ldr	x6, [x0]
               	add	x0, x22, x20
               	mul	x1, x23, x20
               	sub	x2, x24, x20
               	add	x3, x25, x21
               	eor	x4, x26, x20
               	mov	x5, x27
               	blr	x6
               	madd	x0, x22, x23, x0
               	add	x21, x21, x0
               	add	x20, x20, #0x1
               	cmp	w20, #0x4
               	b.lt	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0xb0]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret

<atomics>:
               	add	x7, x1, x2
               	add	x6, x3, x4
               	mul	x4, x1, x4
               	mov	x3, #0x0                // =0
               	add	x5, x1, x3
               	ldaddal	x5, x5, [x0]
               	add	x7, x7, x5
               	mov	x5, #0x1                // =1
               	lsl	x5, x5, x3
               	ldsetal	x5, x5, [x0]
               	eor	x6, x6, x5
               	ldr	x5, [x0]
               	add	x9, x2, x5, lsl #1
               	mov	x8, x5
               	casal	x8, x9, [x0]
               	cmp	x8, x5
               	cset	x9, eq
               	cmp	x9, #0x0
               	csel	x5, x5, x8, ne
               	add	x5, x4, x5
               	cmp	x9, #0x0
               	csel	x4, x5, x4, ne
               	add	x3, x3, #0x1
               	cmp	w3, #0x5
               	b.lt	<addr>
               	add	x1, x7, x6
               	add	x1, x1, x4
               	ldr	x0, [x0]
               	add	x0, x1, x0
               	ret

<copies>:
               	mov	x8, x0
               	add	x0, x3, x4
               	add	x0, x0, x5
               	mov	x6, #0x0                // =0
               	mov	x7, #0x28               // =40
               	mov	x9, #0x6667             // =26215
               	movk	x9, #0x6666, lsl #16
               	sub	x10, x2, #0x1
               	mul	x5, x4, x5
               	cmp	w6, w2
               	b.ge	<addr>
               	mul	x4, x6, x7
               	add	x4, x8, x4
               	sub	x11, x10, x6
               	sxtw	x11, w11
               	mul	x11, x11, x7
               	add	x11, x1, x11
               	ldp	x16, x17, [x11]
               	stp	x16, x17, [x4]
               	ldp	x16, x17, [x11, #0x10]
               	stp	x16, x17, [x4, #0x10]
               	ldr	x16, [x11, #0x20]
               	str	x16, [x4, #0x20]
               	mul	x11, x6, x9
               	lsr	x11, x11, #33
               	add	x11, x11, x11, lsl #2
               	sub	x11, x6, x11
               	ldr	x4, [x4, x11, lsl #3]
               	madd	x4, x4, x3, x5
               	add	x0, x0, x4
               	add	x6, x6, #0x1
               	cmp	w6, w2
               	b.lt	<addr>
               	ret

<x87>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	movi	d1, #0000000000000000
               	scvtf	d2, x2
               	fmov	d0, #4.00000000
               	fdiv	d2, d2, d0
               	add	x16, x0, #0x0
               	fmov	x17, d2
               	bl	<addr>
               	add	x16, x0, #0x30
               	bl	<addr>
               	fmov	d2, x16
               	fadd	d1, d1, d2
               	add	x3, x1, x2
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	add	x16, x0, #0x10
               	fmov	x17, d2
               	bl	<addr>
               	add	x16, x0, #0x0
               	bl	<addr>
               	fmov	d2, x16
               	fadd	d1, d1, d2
               	add	x3, x2, x1, lsl #1
               	scvtf	d2, x3
               	fdiv	d2, d2, d0
               	add	x16, x0, #0x20
               	fmov	x17, d2
               	bl	<addr>
               	add	x16, x0, #0x10
               	bl	<addr>
               	fmov	d2, x16
               	fadd	d1, d1, d2
               	add	x1, x1, x1, lsl #1
               	add	x1, x1, x2
               	scvtf	d2, x1
               	fdiv	d0, d2, d0
               	add	x16, x0, #0x30
               	fmov	x17, d0
               	bl	<addr>
               	add	x16, x0, #0x20
               	bl	<addr>
               	fmov	d0, x16
               	fadd	d0, d1, d0
               	fmov	d1, #8.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldp	x9, x10, [x16]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	and	x10, x10, #0xffffffffffff
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	orr	x13, x13, x9, lsr #60
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	orr	x10, x10, x9, lsr #49
               	cmp	x12, #0x0
               	cset	x13, ne
               	orr	x10, x10, x13, lsl #63
               	and	x9, x9, #0x1ffffffffffff
               	cmp	x9, #0x0
               	cset	x9, ne
               	cmp	x12, #0x0
               	cset	x13, eq
               	add	x12, x12, x13
               	cbz	x10, <addr>
               	clz	x13, x10
               	lsl	x10, x10, x13
               	sub	x12, x12, x13
               	sub	x12, x12, #0x3, lsl #12 // =0x3000
               	sub	x12, x12, #0xc00
               	mov	x13, #0x7ff             // =2047
               	cmp	x12, x13
               	b.ge	<addr>
               	mov	x13, #0x1               // =1
               	sub	x13, x13, x12
               	bic	x13, x13, x13, asr #63
               	add	x13, x13, #0xa
               	mov	x15, #0x3f              // =63
               	cmp	x13, x15
               	b.gt	<addr>
               	lsr	x14, x10, #1
               	lsr	x14, x14, x13
               	lsr	x15, x10, x13
               	neg	x13, x13
               	lsl	x10, x10, x13
               	cmp	x10, #0x0
               	cset	x10, ne
               	orr	x9, x9, x10
               	and	x10, x14, #0x1
               	orr	x9, x9, x10
               	and	x15, x15, #0x1
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	bic	x12, x10, x10, asr #63
               	add	x14, x14, x12, lsl #52
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	orr	x14, x11, #0x7ff0000000000000
               	b	<addr>
               	mov	x14, x11
               	mov	x16, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	ret
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	mov	x9, x17
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	and	x12, x9, #0xfffffffffffff
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, x11, lsl #48
               	b	<addr>
               	lsl	x9, x12, #60
               	orr	x10, x10, x12, lsr #4
               	orr	x10, x10, #0x7fff000000000000
               	cbz	x12, <addr>
               	orr	x10, x10, #0x800000000000
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	and	x12, x12, #0xfffffffffffff
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	stp	x9, x10, [x16]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	ret

<eight>:
               	add	x0, x0, x1, lsl #1
               	add	x1, x2, x2, lsl #1
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	add	x1, x4, x4, lsl #2
               	add	x0, x0, x1
               	mov	x17, #0x6               // =6
               	mul	x1, x5, x17
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x6, x17
               	add	x0, x0, x1
               	add	x0, x0, x7, lsl #3
               	ret

<eight_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x8, x29, #0x30
               	stur	x0, [x29, #-0x30]
               	stur	x1, [x29, #-0x28]
               	stur	x2, [x29, #-0x20]
               	stur	x3, [x29, #-0x18]
               	stur	x4, [x29, #-0x10]
               	stur	x5, [x29, #-0x8]
               	sxtw	x0, w6
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #32
               	add	x1, x1, x1, lsr #63
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	x2, [x8, x0, lsl #3]
               	add	x0, x6, #0x1
               	sxtw	x0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #32
               	add	x1, x1, x1, lsr #63
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	x0, [x8, x0, lsl #3]
               	add	x1, x7, #0x1
               	mul	x0, x0, x1
               	madd	x2, x2, x7, x0
               	add	x0, x6, #0x2
               	sxtw	x0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #32
               	add	x1, x1, x1, lsr #63
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	x0, [x8, x0, lsl #3]
               	add	x1, x7, #0x2
               	madd	x2, x0, x1, x2
               	add	x0, x6, #0x3
               	sxtw	x0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #32
               	add	x1, x1, x1, lsr #63
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	x0, [x8, x0, lsl #3]
               	add	x1, x7, #0x3
               	madd	x2, x0, x1, x2
               	add	x0, x6, #0x4
               	sxtw	x0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #32
               	add	x1, x1, x1, lsr #63
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	x0, [x8, x0, lsl #3]
               	add	x1, x7, #0x4
               	madd	x2, x0, x1, x2
               	add	x0, x6, #0x5
               	sxtw	x0, w0
               	mov	x17, #0xaaab            // =43691
               	movk	x17, #0x2aaa, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #32
               	add	x1, x1, x1, lsr #63
               	mov	x17, #0x6               // =6
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ldr	x0, [x8, x0, lsl #3]
               	add	x1, x7, #0x5
               	madd	x0, x0, x1, x2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<tail>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, x1
               	add	x2, x20, #0x1
               	add	x3, x21, #0x1
               	add	x4, x20, #0x2
               	add	x5, x21, #0x2
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x0, x20
               	add	x2, x0, x21
               	sub	x0, x0, x20
               	add	x0, x0, x21
               	sub	x0, x0, x1
               	add	x0, x0, x2
               	msub	x0, x20, x21, x0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<leaf6>:
               	eor	x0, x0, x1
               	eor	x0, x0, x2
               	eor	x0, x0, x3
               	eor	x0, x0, x4
               	eor	x0, x0, x5
               	ret

<mid6>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x25, x5
               	mov	x24, x4
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mov	x0, x25
               	mov	x5, x20
               	mov	x4, x21
               	mov	x3, x22
               	mov	x2, x23
               	mov	x1, x24
               	bl	<addr>
               	add	x1, x20, x20, lsl #1
               	add	x0, x0, x1
               	add	x1, x21, x21, lsl #2
               	add	x0, x0, x1
               	mov	x17, #0x7               // =7
               	mul	x1, x22, x17
               	add	x0, x0, x1
               	mov	x17, #0xb               // =11
               	mul	x1, x23, x17
               	add	x0, x0, x1
               	mov	x17, #0xd               // =13
               	mul	x1, x24, x17
               	add	x0, x0, x1
               	add	x1, x25, x25, lsl #4
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<top6>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	mov	x25, x5
               	mov	x24, x4
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	add	x0, x20, #0x1
               	add	x1, x21, #0x1
               	add	x2, x22, #0x1
               	add	x3, x23, #0x1
               	add	x4, x24, #0x1
               	add	x5, x25, #0x1
               	bl	<addr>
               	mov	x26, x0
               	mov	x0, x21
               	mov	x5, x20
               	mov	x4, x25
               	mov	x3, x24
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x26, x0
               	madd	x0, x20, x21, x0
               	madd	x0, x22, x23, x0
               	madd	x0, x24, x25, x0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	ldr	x21, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x23, [x0, #0x18]
               	ldr	x24, [x0, #0x20]
               	ldr	x25, [x0, #0x28]
               	ldr	x26, [x0, #0x30]
               	ldr	x27, [x0, #0x38]
               	mov	x0, x20
               	mov	x5, x25
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x92e7            // =37607
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x17, #0x6789            // =26505
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	mul	x0, x20, x17
               	mov	x17, #0x4321            // =17185
               	movk	x17, #0x8765, lsl #16
               	movk	x17, #0x9, lsl #32
               	mul	x1, x21, x17
               	mov	x2, x22
               	mov	x3, x23
               	bl	<addr>
               	mov	x17, #0x2012            // =8210
               	movk	x17, #0x6301, lsl #16
               	movk	x17, #0x9e25, lsl #32
               	movk	x17, #0xbe26, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x17, #0x1111111111111111 // =1229782938247303441
               	mul	x1, x21, x17
               	mov	x0, x20
               	mov	x2, #0x3211             // =12817
               	movk	x2, #0x7654, lsl #16
               	movk	x2, #0xba98, lsl #32
               	movk	x2, #0xfedc, lsl #48
               	bl	<addr>
               	mov	x17, #0xe147            // =57671
               	movk	x17, #0x147a, lsl #16
               	movk	x17, #0x47ae, lsl #32
               	movk	x17, #0x7ae1, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x6, x25
               	mov	x5, x24
               	mov	x4, x23
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	cmn	x0, #0x13
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x4, x23
               	mov	x3, x22
               	mov	x2, x21
               	bl	<addr>
               	cmp	x0, #0x994
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, x20
               	mov	x5, x22
               	mov	x4, x21
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x13b
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x20]
               	cmp	x1, #0xf
               	b.ne	<addr>
               	ldr	x0, [x0, #0x50]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	mov	x7, x27
               	mov	x6, x26
               	mov	x5, x25
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x2b6
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	mov	x7, x27
               	mov	x6, x26
               	mov	x5, x25
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x8a9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x9a96            // =39574
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, x20
               	mov	x5, x25
               	mov	x4, x24
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	cmp	x0, #0x2c3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
