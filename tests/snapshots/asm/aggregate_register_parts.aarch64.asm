
aggregate_register_parts.aarch64:	file format elf64-littleaarch64

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

<by_value>:
               	add	x0, x0, #0x1
               	ret

<make_pair>:
               	ret

<swapq>:
               	lsr	x1, x0, #32
               	orr	x0, x1, x0, lsl #32
               	ret

<tail>:
               	sxtw	x2, w1
               	add	x0, x0, x2
               	lsl	x1, x1, #1
               	mov	w1, w1
               	ret

<bytes>:
               	and	x1, x0, #0xff
               	add	x1, x1, #0x1
               	ubfx	x2, x0, #8, #8
               	add	x2, x2, #0x2
               	ubfx	x0, x0, #16, #8
               	add	x0, x0, #0x3
               	and	x1, x1, #0xff
               	and	x2, x2, #0xff
               	orr	x1, x1, x2, lsl #8
               	and	x0, x0, #0xff
               	orr	x0, x1, x0, lsl #16
               	ret

<mixed>:
               	lsr	x3, x0, #16
               	lsr	x2, x0, #32
               	and	x0, x0, #0xff
               	add	x4, x0, #0x1
               	and	x4, x4, #0xff
               	sxth	x3, w3
               	add	x0, x3, x0
               	sxth	x0, w0
               	add	x3, x2, x3
               	sxtw	x2, w2
               	add	x1, x1, x2
               	and	x0, x0, #0xffff
               	orr	x0, x4, x0, lsl #16
               	orr	x0, x0, x3, lsl #32
               	ret

<dsum>:
               	fadd	d2, d0, d1
               	fsub	d1, d0, d1
               	fmov	d0, d2
               	ret

<rot3>:
               	fmov	d3, d0
               	fmov	d0, d1
               	fmov	d1, d2
               	fmov	d2, d3
               	ret

<twice>:
               	fmov	s1, #2.00000000
               	fmul	s0, s0, s1
               	ret

<dl>:
               	fmov	d0, x0
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	fmov	x0, d0
               	add	x1, x1, #0x1
               	ret

<fi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	fmov	s1, #1.00000000
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x4]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x4]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<ubump>:
               	add	x0, x0, #0x1
               	ret

<w1>:
               	and	x0, x0, #0xff
               	add	x0, x0, #0x1
               	and	x0, x0, #0xff
               	ret

<w2>:
               	sxth	x0, w0
               	add	x0, x0, #0x1
               	and	x0, x0, #0xffff
               	ret

<w4>:
               	add	x0, x0, #0x1
               	mov	w0, w0
               	ret

<w8>:
               	add	x0, x0, #0x1
               	ret

<nested>:
               	lsr	x2, x0, #32
               	sxtw	x3, w0
               	add	x1, x1, x3
               	orr	x0, x2, x0, lsl #32
               	ret

<pp>:
               	add	x0, x0, #0x4
               	sub	x1, x1, #0x1
               	ret

<big>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x8, [x29, #-0x8]
               	ldr	x1, [x0, #0x10]
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x8]
               	add	x2, x2, x3
               	add	x1, x1, x2
               	str	x1, [x0, #0x10]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_via_ptr>:
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ret

<bump_via_ptr>:
               	ldr	x1, [x0]
               	add	x1, x1, #0xa
               	str	x1, [x0]
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0x14
               	str	x1, [x0, #0x8]
               	ret

<escape>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<escape_ret>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<forward>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	cbz	w2, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<live>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	add	x20, x2, x2, lsl #1
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	x0, x20, x0
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<ret_global>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	ret

<lit>:
               	add	x1, x0, #0x1
               	ret

<rec>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x2, w2
               	stur	x0, [x29, #-0x10]
               	sub	x3, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	cbnz	w2, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, x2
               	stur	x0, [x29, #-0x10]
               	sub	x2, x2, #0x1
               	mov	x0, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<loop>:
               	add	x2, x0, x1
               	add	x3, x0, x2
               	add	x0, x2, x1
               	add	x2, x3, x0
               	add	x0, x0, x1
               	add	x0, x2, x0
               	ret

<spill>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	stur	x1, [x29, #-0x8]
               	mul	x20, x2, x3
               	mul	x21, x4, x5
               	mul	x22, x6, x7
               	add	x1, x2, x4
               	add	x23, x1, x6
               	add	x1, x3, x5
               	add	x24, x1, x7
               	eor	x25, x20, x21
               	eor	x26, x22, x23
               	mov	x17, #0x7               // =7
               	mul	x27, x24, x17
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	x2, x20, x21
               	add	x2, x2, x22
               	add	x2, x2, x23
               	add	x2, x2, x24
               	add	x2, x2, x25
               	add	x2, x2, x26
               	add	x2, x2, x27
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<self_assign>:
               	sub	x1, x1, x0
               	ret

<lo128>:
               	add	x0, x0, x2
               	ret

<bump128>:
               	add	x2, x0, #0x1
               	cmp	x2, x0
               	cset	x0, lo
               	add	x1, x1, x0
               	mov	x0, x2
               	ret

<named_va>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x1, [x29, #-0x10]
               	stur	x2, [x29, #-0x8]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x28             // =-40
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x30
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x0, [x0]
               	sub	x1, x29, #0x30
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x3e8             // =1000
               	mul	x1, x1, x17
               	ldur	x2, [x29, #-0x10]
               	add	x1, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ldr	x1, [x29, #0x10]
               	add	x0, x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<sink>:
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	add	x0, x0, #0x1
               	ret

<const_across>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret

<keep_across>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, x2
               	mov	x21, x1
               	bl	<addr>
               	mov	x0, x20
               	mov	x1, x21
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<va_ret>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x0, [x0]
               	ldrsw	x1, [x29, #0x10]
               	sub	x2, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	mov	x1, #0x7                // =7
               	mov	x2, #0xb                // =11
               	sub	x0, x29, #0x88
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrh	w16, [x3]
               	strh	w16, [x0]
               	ldrb	w16, [x3, #0x2]
               	strb	w16, [x0, #0x2]
               	sub	x0, x29, #0x70
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	ldr	w16, [x3, #0x8]
               	str	w16, [x0, #0x8]
               	sub	x0, x29, #0x80
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w16, [x3]
               	str	w16, [x0]
               	sub	x0, x29, #0x50
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x78
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x16, [x3]
               	str	x16, [x0]
               	sub	x0, x29, #0x40
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x28
               	stur	x1, [x29, #-0x28]
               	stur	x2, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x8
               	b.ne	<addr>
               	cmp	x1, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x15               // =21
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x15
               	b.ne	<addr>
               	cmp	x1, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x3                // =3
               	movk	x1, #0x4, lsl #32
               	stur	x1, [x29, #-0x20]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	ldur	w0, [x29, #-0x20]
               	ldur	w1, [x29, #-0x1c]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	ldur	w1, [x29, #-0x20]
               	cmp	x0, #0xb
               	b.ne	<addr>
               	cmp	w1, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	ldrh	w16, [x0]
               	ldrb	w17, [x0, #0x2]
               	orr	x16, x16, x17, lsl #16
               	mov	x0, x16
               	bl	<addr>
               	sturh	w0, [x29, #-0x20]
               	lsr	x0, x0, #16
               	sub	x1, x29, #0x20
               	sturb	w0, [x29, #-0x1e]
               	sub	x0, x29, #0x88
               	ldrh	w16, [x1]
               	strh	w16, [x0]
               	ldrb	w16, [x1, #0x2]
               	strb	w16, [x0, #0x2]
               	ldurb	w0, [x29, #-0x88]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x87]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0x86]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x1                // =1
               	movk	x1, #0x2, lsl #16
               	movk	x1, #0x3, lsl #32
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	ldurb	w0, [x29, #-0x28]
               	ldurh	w2, [x29, #-0x26]
               	ldur	w3, [x29, #-0x24]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	sxth	x0, w2
               	cmp	w0, #0x3
               	b.ne	<addr>
               	cmp	w3, #0x5
               	b.ne	<addr>
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x70
               	ldr	d0, [x7]
               	ldr	d1, [x7, #0x8]
               	bl	<addr>
               	stur	d0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	stur	d1, [x29, #-0x20]
               	sub	x1, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0x70]
               	fmov	d1, #1.75000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x68]
               	fmov	d1, #1.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x60
               	ldr	s0, [x7]
               	ldr	s1, [x7, #0x4]
               	ldr	s2, [x7, #0x8]
               	bl	<addr>
               	stur	s0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	stur	s1, [x29, #-0x24]
               	stur	s2, [x29, #-0x20]
               	sub	x1, x29, #0x60
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	w16, [x0, #0x8]
               	str	w16, [x1, #0x8]
               	ldur	s0, [x29, #-0x60]
               	fmov	s1, #2.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x5c]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x58]
               	fmov	s1, #1.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x80
               	ldr	s0, [x7]
               	bl	<addr>
               	stur	s0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x80
               	ldr	w16, [x0]
               	str	w16, [x1]
               	ldur	s0, [x29, #-0x80]
               	fmov	s1, #3.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	sub	x1, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldur	d0, [x29, #-0x50]
               	fmov	d1, #5.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x78
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	s0, [x29, #-0x78]
               	fmov	s1, #1.50000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x74]
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x29               // =41
               	stur	x1, [x29, #-0x20]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	sub	x1, x29, #0x20
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0x20]
               	mov	x0, x1
               	ldrb	w0, [x0]
               	bl	<addr>
               	sturb	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	ldurb	w17, [x29, #-0x20]
               	str	x17, [sp, #0x48]
               	mov	x1, #0x258              // =600
               	sturh	w1, [x29, #-0x20]
               	ldrh	w0, [x0]
               	bl	<addr>
               	sturh	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	ldurh	w17, [x29, #-0x20]
               	str	x17, [sp, #0x40]
               	mov	x1, #0x1170             // =4464
               	movk	x1, #0x1, lsl #16
               	stur	w1, [x29, #-0x20]
               	ldr	w0, [x0]
               	bl	<addr>
               	stur	w0, [x29, #-0x20]
               	sub	x0, x29, #0x20
               	ldur	w17, [x29, #-0x20]
               	str	x17, [sp, #0x38]
               	mov	x1, #0x5000             // =20480
               	movk	x1, #0xdcd6, lsl #16
               	movk	x1, #0x1, lsl #32
               	stur	x1, [x29, #-0x20]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x20]
               	ldr	x16, [sp, #0x48]
               	cmp	w16, #0x6
               	b.ne	<addr>
               	ldr	x16, [sp, #0x40]
               	sxth	x1, w16
               	cmp	w1, #0x259
               	b.ne	<addr>
               	ldr	x16, [sp, #0x38]
               	mov	x17, #0x1171            // =4465
               	movk	x17, #0x1, lsl #16
               	cmp	w16, w17
               	b.ne	<addr>
               	mov	x17, #0x5001            // =20481
               	movk	x17, #0xdcd6, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x1                // =1
               	movk	x1, #0x2, lsl #32
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0x1e               // =30
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x0, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	ldur	w2, [x29, #-0x28]
               	ldur	w3, [x29, #-0x24]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	cmp	w3, #0x1
               	b.ne	<addr>
               	cmp	x1, #0x1f
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x40
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	sub	x2, x29, #0x40
               	add	x2, x2, #0x4
               	cmp	x0, x2
               	b.ne	<addr>
               	cmp	x1, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x2                // =2
               	stur	x1, [x29, #-0x10]
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x8]
               	sub	x8, x29, #0x30
               	bl	<addr>
               	ldur	x0, [x29, #-0x30]
               	ldur	x1, [x29, #-0x28]
               	ldur	x2, [x29, #-0x20]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	cmp	x1, #0x2
               	b.ne	<addr>
               	cmp	x2, #0x6
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x7                // =7
               	mov	x2, #0xb                // =11
               	sub	x0, x29, #0x28
               	stur	x1, [x29, #-0x28]
               	stur	x2, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x7                // =7
               	stur	x1, [x29, #-0x28]
               	mov	x1, #0xb                // =11
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x2, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x11
               	b.ne	<addr>
               	cmp	x1, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x2
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x3, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x12
               	b.ne	<addr>
               	cmp	x1, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x3, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x12
               	b.ne	<addr>
               	cmp	x1, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x3, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x1f
               	b.ne	<addr>
               	cmp	x1, #0x12
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x2                // =2
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	cmp	x1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x3, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x4                // =4
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x2, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0xf
               	b.ne	<addr>
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x28]
               	mov	x0, x2
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x2, x0
               	ldr	x0, [sp, #0x30]
               	ldr	x1, [sp, #0x28]
               	cmp	x2, #0x60
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x4, #0x3                // =3
               	mov	x5, #0x4                // =4
               	mov	x6, #0x5                // =5
               	mov	x7, #0x6                // =6
               	sub	x8, x29, #0x28
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	str	x0, [sp, #0x30]
               	str	x1, [sp, #0x28]
               	mov	x0, x8
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x2, x0
               	ldr	x0, [sp, #0x30]
               	ldr	x1, [sp, #0x28]
               	mov	x17, #0x3f40            // =16192
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x28
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x2
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	mov	x16, x0
               	str	x16, [sp, #0x48]
               	mov	x16, x1
               	str	x16, [sp, #0x40]
               	ldr	x0, [sp, #0x48]
               	stur	x0, [x29, #-0x28]
               	ldr	x1, [sp, #0x40]
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0xf
               	b.ne	<addr>
               	cmn	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	mov	x2, #0xb                // =11
               	sub	x0, x29, #0xe0
               	stur	x2, [x29, #-0xe0]
               	stur	x1, [x29, #-0xd8]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0xd0]
               	sub	x0, x29, #0xd0
               	stur	x1, [x29, #-0xc8]
               	sub	x1, x29, #0xe0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0xe0
               	mov	x2, #0x3                // =3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	cmp	x0, #0xf
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xd8]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x3, #0x3                // =3
               	sub	x1, x29, #0x28
               	ldr	x16, [sp, #0x48]
               	stur	x16, [x29, #-0x28]
               	ldr	x16, [sp, #0x40]
               	stur	x16, [x29, #-0x20]
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x17, #-0x2303           // =-8963
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	sub	x3, x29, #0x28
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	cmp	x1, #0x8
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x28               // =40
               	mov	x2, #0x5                // =5
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	mov	x0, x3
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x28]
               	stur	x1, [x29, #-0x20]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	cmp	x1, #0x8
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
