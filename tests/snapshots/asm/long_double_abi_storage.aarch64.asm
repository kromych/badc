
long_double_abi_storage.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0xa0]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, x21, lsl #3]
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x20
               	mov	x22, #0x8               // =8
               	mov	x2, x22
               	bl	<addr>
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	sub	x17, x29, #0x60
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d0
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	lsl	x12, x9, #12
               	lsr	x12, x12, #12
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	mov	x13, #0x7fff000000000000 // =9223090561878065152
               	orr	x10, x10, x13
               	cbz	x12, <addr>
               	mov	x13, #0x800000000000    // =140737488355328
               	orr	x10, x10, x13
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	lsl	x12, x12, #12
               	lsr	x12, x12, #12
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	x16, x29, #0x60
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	lsl	x10, x10, #16
               	lsr	x10, x10, #16
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	mov	x15, #0x7ff8000000000000 // =9221120237041090560
               	orr	x13, x13, x15
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
               	lsl	x9, x9, #15
               	lsr	x9, x9, #15
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
               	lsl	x10, x14, #63
               	lsr	x10, x10, #63
               	orr	x9, x9, x10
               	lsl	x15, x15, #63
               	lsr	x15, x15, #63
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	mov	x14, #0x7ff0000000000000 // =9218868437227405312
               	orr	x14, x11, x14
               	b	<addr>
               	mov	x14, x11
               	fmov	d0, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	add	sp, sp, #0x40
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x28
               	mov	x2, x22
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x20]
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x20, x21, #0x1
               	mov	w21, w20
               	cmp	w21, #0xc
               	b.lo	<addr>
               	mov	x0, #0x7ff8000000000000 // =9221120237041090560
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x20
               	mov	x20, #0x8               // =8
               	mov	x2, x20
               	bl	<addr>
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	sub	x17, x29, #0x60
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d0
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	lsl	x12, x9, #12
               	lsr	x12, x12, #12
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	mov	x13, #0x7fff000000000000 // =9223090561878065152
               	orr	x10, x10, x13
               	cbz	x12, <addr>
               	mov	x13, #0x800000000000    // =140737488355328
               	orr	x10, x10, x13
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	lsl	x12, x12, #12
               	lsr	x12, x12, #12
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	x16, x29, #0x60
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x16]
               	ldr	x10, [x16, #0x8]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	lsl	x10, x10, #16
               	lsr	x10, x10, #16
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	mov	x15, #0x7ff8000000000000 // =9221120237041090560
               	orr	x13, x13, x15
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
               	lsl	x9, x9, #15
               	lsr	x9, x9, #15
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
               	lsl	x10, x14, #63
               	lsr	x10, x10, #63
               	orr	x9, x9, x10
               	lsl	x15, x15, #63
               	lsr	x15, x15, #63
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	mov	x14, #0x7ff0000000000000 // =9218868437227405312
               	orr	x14, x11, x14
               	b	<addr>
               	mov	x14, x11
               	fmov	d0, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	add	sp, sp, #0x40
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x28
               	mov	x2, x20
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0x7ff0000000000000 // =9218868437227405312
               	and	x0, x0, x17
               	mov	x17, #0x7ff0000000000000 // =9218868437227405312
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	ldur	x0, [x29, #-0x18]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x8340            // =33600
               	add	x1, x0, x17
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x2
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d16
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	lsl	x12, x9, #12
               	lsr	x12, x12, #12
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	mov	x13, #0x7fff000000000000 // =9223090561878065152
               	orr	x10, x10, x13
               	cbz	x12, <addr>
               	mov	x13, #0x800000000000    // =140737488355328
               	orr	x10, x10, x13
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	lsl	x12, x12, #12
               	lsr	x12, x12, #12
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	str	x9, [x1]
               	str	x10, [x1, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	sp, sp, #0x40
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	ldr	x9, [x1]
               	ldr	x10, [x1, #0x8]
               	lsr	x11, x10, #63
               	lsl	x11, x11, #63
               	lsl	x12, x10, #1
               	lsr	x12, x12, #49
               	lsl	x10, x10, #16
               	lsr	x10, x10, #16
               	mov	x13, #0x7fff            // =32767
               	cmp	x12, x13
               	b.ne	<addr>
               	orr	x13, x10, x9
               	cbz	x13, <addr>
               	lsl	x13, x10, #4
               	lsr	x15, x9, #60
               	orr	x13, x13, x15
               	mov	x15, #0x7ff8000000000000 // =9221120237041090560
               	orr	x13, x13, x15
               	orr	x14, x11, x13
               	b	<addr>
               	lsl	x10, x10, #15
               	lsr	x13, x9, #49
               	orr	x10, x10, x13
               	cmp	x12, #0x0
               	cset	x13, ne
               	lsl	x13, x13, #63
               	orr	x10, x10, x13
               	lsl	x9, x9, #15
               	lsr	x9, x9, #15
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
               	lsl	x10, x14, #63
               	lsr	x10, x10, #63
               	orr	x9, x9, x10
               	lsl	x15, x15, #63
               	lsr	x15, x15, #63
               	and	x9, x9, x15
               	sub	x10, x12, #0x1
               	asr	x15, x10, #63
               	bic	x12, x10, x15
               	lsl	x12, x12, #52
               	add	x14, x14, x12
               	add	x14, x14, x9
               	add	x14, x14, x11
               	b	<addr>
               	mov	x14, #0x7ff0000000000000 // =9218868437227405312
               	orr	x14, x11, x14
               	b	<addr>
               	mov	x14, x11
               	fmov	d0, x14
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x13, x14, [sp, #0x20]
               	ldr	x15, [sp, #0x30]
               	add	sp, sp, #0x40
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	sub	x17, x29, #0x60
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d16
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	lsl	x12, x9, #12
               	lsr	x12, x12, #12
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	mov	x13, #0x7fff000000000000 // =9223090561878065152
               	orr	x10, x10, x13
               	cbz	x12, <addr>
               	mov	x13, #0x800000000000    // =140737488355328
               	orr	x10, x10, x13
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	lsl	x12, x12, #12
               	lsr	x12, x12, #12
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	x20, x29, #0x10
               	sub	x1, x29, #0x60
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	bl	<addr>
               	ldrb	w0, [x20, #0xf]
               	mov	x17, #0x3f              // =63
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	w1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x20, #0xe]
               	mov	x17, #0xff              // =255
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x20, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	mov	w1, w0
               	cmp	w1, #0xe
               	b.lo	<addr>
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x20]
               	sub	x0, x29, #0x30
               	sub	x1, x29, #0x20
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x16, x29, #0x30
               	ldr	d0, [x16]
               	sub	x17, x29, #0x60
               	sub	sp, sp, #0x30
               	stp	x9, x10, [sp]
               	stp	x11, x12, [sp, #0x10]
               	str	x13, [sp, #0x20]
               	fmov	x9, d0
               	lsr	x10, x9, #63
               	lsl	x10, x10, #63
               	lsl	x11, x9, #1
               	lsr	x11, x11, #53
               	lsl	x12, x9, #12
               	lsr	x12, x12, #12
               	mov	x13, #0x7ff             // =2047
               	cmp	x11, x13
               	b.eq	<addr>
               	cbz	x11, <addr>
               	add	x11, x11, #0x3, lsl #12 // =0x3000
               	add	x11, x11, #0xc00
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	lsl	x13, x11, #48
               	orr	x10, x10, x13
               	b	<addr>
               	lsl	x9, x12, #60
               	lsr	x13, x12, #4
               	orr	x10, x10, x13
               	mov	x13, #0x7fff000000000000 // =9223090561878065152
               	orr	x10, x10, x13
               	cbz	x12, <addr>
               	mov	x13, #0x800000000000    // =140737488355328
               	orr	x10, x10, x13
               	b	<addr>
               	cbnz	x12, <addr>
               	mov	x9, xzr
               	b	<addr>
               	clz	x13, x12
               	sub	x13, x13, #0xb
               	lsl	x12, x12, x13
               	lsl	x12, x12, #12
               	lsr	x12, x12, #12
               	mov	x11, #0x3c01            // =15361
               	sub	x11, x11, x13
               	b	<addr>
               	str	x9, [x17]
               	str	x10, [x17, #0x8]
               	ldp	x9, x10, [sp]
               	ldp	x11, x12, [sp, #0x10]
               	ldr	x13, [sp, #0x20]
               	add	sp, sp, #0x30
               	sub	x20, x29, #0x10
               	sub	x1, x29, #0x60
               	mov	x2, #0x10               // =16
               	mov	x0, x20
               	bl	<addr>
               	ldrb	w0, [x20, #0xf]
               	mov	x17, #0x3b              // =59
               	eor	x0, x0, x17
               	mov	w1, w0
               	cmp	w1, #0x0
               	cset	x0, ne
               	cbnz	x1, <addr>
               	ldrb	w0, [x20, #0xe]
               	mov	x17, #0xcd              // =205
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x20, x1
               	ldrb	w2, [x2]
               	cbnz	x2, <addr>
               	add	x0, x1, #0x1
               	mov	w1, w0
               	cmp	w1, #0xe
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	b	<addr>
               	mov	w0, w20
               	add	x0, x0, #0xa
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
