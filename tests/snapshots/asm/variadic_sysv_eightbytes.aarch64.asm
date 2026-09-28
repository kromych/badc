
variadic_sysv_eightbytes.aarch64:	file format elf64-littleaarch64

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

<sum_ld>:
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
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x2
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
               	mov	x3, #0xa                // =10
               	movi	d0, #0000000000000000
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.ge	<addr>
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x4, x16
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x1]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	ldr	x4, [x1]
               	mul	x4, x4, x3
               	scvtf	d2, x4
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x1, #0x8]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x1, [x29, #0x10]
               	cmp	w0, w1
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<mixed>:
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
               	sub	sp, sp, #0x80
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
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	sub	x1, x29, #0x40
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	w1, [x0]
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	sub	x2, x29, #0x70
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	sub	x0, x29, #0x20
               	sub	x2, x29, #0x60
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	ldr	x17, [x9]
               	str	x17, [x2]
               	ldr	x17, [x9, #0x8]
               	str	x17, [x2, #0x8]
               	mov	x16, x2
               	b	<addr>
               	ldr	x16, [x17]
               	add	x16, x16, #0xf
               	and	x16, x16, #0xfffffffffffffff0
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	sub	x2, x29, #0x50
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
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
               	ldr	x2, [x0]
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x29, #0x10]
               	scvtf	d0, x0
               	sub	x0, x29, #0x40
               	ldr	d1, [x0]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xd0]
               	fmadd	d0, d1, d2, d0
               	ldr	x0, [x0, #0x8]
               	scvtf	d1, x0
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xd8]
               	fmadd	d0, d1, d2, d0
               	sub	x0, x29, #0x30
               	ldr	s1, [x0]
               	ldr	s2, [x0, #0x4]
               	fadd	s1, s1, s2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xe0]
               	fcvt	d1, s1
               	fmadd	d0, d1, d2, d0
               	ldr	x0, [x0, #0x8]
               	scvtf	d1, x0
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xe8]
               	fmadd	d0, d1, d2, d0
               	ldur	d1, [x29, #-0x80]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xf0]
               	fmadd	d0, d1, d2, d0
               	sxtw	x0, w1
               	scvtf	d1, x0
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xf8]
               	fmadd	d0, d1, d2, d0
               	sub	x0, x29, #0x70
               	ldr	s1, [x0, #0xc]
               	mov	x16, #0x42c80000        // =1120403456
               	fmov	s2, w16
               	fmul	s1, s1, s2
               	fcvt	d1, s1
               	fadd	d0, d0, d1
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldur	x9, [x29, #-0x50]
               	ldur	x10, [x29, #-0x48]
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
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	orr	x13, x13, #0x7ff8000000000000
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
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
               	asr	x15, x13, #63
               	bic	x13, x13, x15
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
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
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
               	add	sp, sp, #0x40
               	fmov	d2, #10.00000000
               	fmadd	d0, d1, d2, d0
               	scvtf	d1, x2
               	fadd	d0, d0, d1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<after_fp>:
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
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
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
               	movi	d0, #0000000000000000
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x10
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
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
               	ldr	x1, [x0]
               	sub	x0, x29, #0x20
               	adrp	x16, <page>
               	ldr	d1, [x16, #0xf8]
               	sub	x0, x29, #0x30
               	ldr	x2, [x0]
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	scvtf	d2, x2
               	fmadd	d0, d0, d1, d2
               	ldr	d1, [x0, #0x8]
               	fmov	d2, #10.00000000
               	fmadd	d0, d1, d2, d0
               	scvtf	d1, x1
               	fadd	d0, d0, d1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	sub	x1, x29, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x0, x29, #0x80
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x70
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x60
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xe0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xd0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0xb0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x0]
               	sub	x2, x29, #0xc0
               	sub	x0, x29, #0xa0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x1                // =1
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	fmov	d1, #12.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	sub	x1, x29, #0x90
               	sub	x3, x29, #0x80
               	sub	x5, x29, #0x70
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	ldr	x4, [x3, #0x8]
               	ldr	x3, [x3]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x100]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x90
               	sub	x3, x29, #0x80
               	sub	x5, x29, #0x70
               	sub	x7, x29, #0x60
               	sub	x2, x29, #0x50
               	sub	x4, x29, #0x40
               	sub	x6, x29, #0x30
               	sub	sp, sp, #0x40
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	mov	x16, x4
               	ldr	x17, [x16]
               	str	x17, [sp, #0x20]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x28]
               	mov	x16, x6
               	ldr	x17, [x16]
               	str	x17, [sp, #0x30]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x38]
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	ldr	x4, [x3, #0x8]
               	ldr	x3, [x3]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	add	sp, sp, #0x40
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x108]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	sub	x1, x29, #0x20
               	sub	x3, x29, #0x10
               	sub	x5, x29, #0xe0
               	sub	x7, x29, #0xd0
               	sub	x2, x29, #0xc0
               	sub	x4, x29, #0xb0
               	mov	x6, #0x3                // =3
               	sub	sp, sp, #0x30
               	str	x6, [sp, #0x20]
               	mov	x16, x7
               	ldr	x17, [x16]
               	str	x17, [sp]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x8]
               	mov	x16, x2
               	ldr	x17, [x16]
               	str	x17, [sp, #0x10]
               	ldr	x17, [x16, #0x8]
               	str	x17, [sp, #0x18]
               	ldr	q0, [x4]
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	ldr	x4, [x3, #0x8]
               	ldr	x3, [x3]
               	ldr	x6, [x5, #0x8]
               	ldr	x5, [x5]
               	bl	<addr>
               	add	sp, sp, #0x30
               	fmov	d1, #9.00000000
               	adrp	x16, <page>
               	ldr	d2, [x16, #0xd0]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x110]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x118]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x120]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x128]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x130]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x138]
               	fadd	d1, d1, d2
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x140]
               	fadd	d1, d1, d2
               	fmov	d2, #3.00000000
               	fadd	d1, d1, d2
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x8                // =8
               	fmov	d0, #1.00000000
               	sub	x1, x29, #0x90
               	mov	x3, #0x3                // =3
               	fmov	d1, d0
               	fmov	d7, d0
               	fmov	d6, d0
               	fmov	d5, d0
               	fmov	d4, d0
               	fmov	d3, d0
               	fmov	d2, d0
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x148]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
