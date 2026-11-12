
atomic_operators_two_threads.aarch64:	file format elf64-littleaarch64

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

<worker>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	stp	x20, x21, [sp, #0x40]
               	stp	x22, x23, [sp, #0x50]
               	and	x0, x0, #0xff
               	sturb	w0, [x29, #-0x40]
               	sturb	w0, [x29, #-0x3f]
               	sturb	w0, [x29, #-0x3e]
               	mov	x20, #0x0               // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	ldaddal	w0, w16, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	neg	x16, x0
               	ldaddal	x16, x17, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldaddalb	w0, w16, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	ldaddal	x1, x16, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldar	w0, [x2]
               	b	<addr>
               	mov	x0, x1
               	add	x3, x0, x0, lsl #1
               	mov	x1, x0
               	casal	w1, w3, [x2]
               	cmp	w1, w0
               	b.ne	<addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	fmov	d1, #0.50000000
               	ldar	x0, [x2]
               	b	<addr>
               	mov	x0, x1
               	stur	x0, [x29, #-0x38]
               	fmov	d0, x0
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x30]
               	fmov	x3, d0
               	mov	x1, x0
               	casal	x1, x3, [x2]
               	cmp	x1, x0
               	b.ne	<addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	fmov	d0, #0.25000000
               	ldr	x1, [x2]
               	ldr	x3, [x2, #0x8]
               	sub	x0, x29, #0x28
               	stur	x1, [x29, #-0x28]
               	stur	x3, [x29, #-0x20]
               	sub	x1, x29, #0x60
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x28]
               	ldur	x10, [x29, #-0x20]
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
               	fmov	d1, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	fadd	d1, d1, d0
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d1
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
               	stur	x9, [x29, #-0x60]
               	stur	x10, [x29, #-0x58]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x2
               	mov	x14, x0
               	mov	x15, x1
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x3, x16
               	cbz	x3, <addr>
               	adrp	x4, <addr>
               	add	x4, x4, <lo12>
               	ldr	x1, [x4]
               	ldr	x2, [x4, #0x8]
               	sub	x0, x29, #0x18
               	stur	x1, [x29, #-0x18]
               	stur	x2, [x29, #-0x10]
               	sub	x1, x29, #0x50
               	ldur	x2, [x29, #-0x18]
               	ldur	x5, [x29, #-0x10]
               	add	x3, x2, #0x1
               	cmp	x3, x2
               	cset	x2, lo
               	add	x5, x5, #0x1
               	add	x2, x5, x2
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	stur	x3, [x29, #-0x50]
               	stur	x2, [x29, #-0x48]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x4
               	mov	x14, x0
               	mov	x15, x1
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	mov	x2, x16
               	cbz	x2, <addr>
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	ldarb	w0, [x2]
               	b	<addr>
               	mov	x0, x1
               	sxtb	x1, w0
               	cmp	x1, #0x1
               	cset	x3, ne
               	mov	x1, x0
               	casalb	w1, w3, [x2]
               	cmp	w1, w0
               	b.ne	<addr>
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	sub	x2, x29, #0x40
               	mov	x22, #0x3               // =3
               	mov	x23, #0x5               // =5
               	mov	x0, x22
               	mov	x3, x23
               	mov	x1, x21
               	bl	<addr>
               	sub	x2, x29, #0x8
               	mov	x0, x22
               	mov	x3, x23
               	mov	x1, x21
               	bl	<addr>
               	ldurb	w1, [x29, #-0x8]
               	ldurb	w0, [x29, #-0x7]
               	ldurb	w2, [x29, #-0x6]
               	cmp	w1, w0
               	b.ne	<addr>
               	cmp	w0, w2
               	b.eq	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	ldaddal	w1, w16, [x0]
               	add	x20, x20, #0x1
               	mov	x17, #0x4e20            // =20000
               	cmp	w20, w17
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x22, x23, [sp, #0x50]
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	stp	x20, x21, [sp, #0x40]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stlr	x1, [x0]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x20, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	cbz	x20, <addr>
               	cbnz	x21, <addr>
               	mov	x0, #0x70               // =112
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1                // =1
               	blr	x20
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x50
               	add	x0, x0, #0x8
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x2                // =2
               	blr	x20
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x50]
               	mov	x1, #0x0                // =0
               	blr	x21
               	ldur	x0, [x29, #-0x48]
               	mov	x1, #0x0                // =0
               	blr	x21
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldar	w0, [x0]
               	mov	x17, #0x9c40            // =40000
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x71               // =113
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldar	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x72               // =114
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldarb	w0, [x0]
               	cmp	w0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x73               // =115
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldar	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xe200            // =57856
               	movk	x17, #0x4, lsl #16
               	add	x1, x1, x17
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x74               // =116
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #0x9c40             // =40000
               	mov	x1, #0x1                // =1
               	add	x1, x1, x1, lsl #1
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldar	w0, [x0]
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x77               // =119
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldar	x0, [x0]
               	stur	x0, [x29, #-0x48]
               	fmov	d0, x0
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x20]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x78               // =120
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x0, [x29, #-0x38]
               	sub	x3, x29, #0x30
               	stur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x28]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x40]
               	ldur	x10, [x29, #-0x38]
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
               	fmov	d0, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x28]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x79               // =121
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x20
               	stur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	sub	x3, x29, #0x10
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x1
               	mov	x14, x2
               	mov	x15, x3
               	ldp	x10, x11, [x14]
               	ldp	x12, x13, [x15]
               	caspal	x10, x11, x12, x13, [x9]
               	ldp	x12, x13, [x14]
               	cmp	x10, x12
               	ccmp	x11, x13, #0x0, eq
               	cset	x16, eq
               	b.eq	<addr>
               	stp	x10, x11, [x14]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldur	x1, [x29, #-0x20]
               	ldur	x2, [x29, #-0x18]
               	mov	x17, #0x9c40            // =40000
               	eor	x1, x1, x17
               	mov	x17, #0x9c40            // =40000
               	eor	x2, x2, x17
               	orr	x1, x1, x2
               	cbz	x1, <addr>
               	mov	x0, #0x7b               // =123
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldarb	w1, [x1]
               	sxtb	x1, w1
               	cbz	w1, <addr>
               	mov	x0, #0x7d               // =125
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	ldar	w1, [x1]
               	cbz	w1, <addr>
               	mov	x0, #0x7e               // =126
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldp	x20, x21, [sp, #0x40]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
