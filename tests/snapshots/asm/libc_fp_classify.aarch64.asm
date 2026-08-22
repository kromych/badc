
libc_fp_classify.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x2
               	fneg	d0, d16
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	ldur	x3, [x29, #-0x10]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x3, x3, x17
               	ldr	x4, [x0]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x4, x4, x17
               	orr	x3, x3, x4
               	stur	x3, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	ldr	d2, [x16]
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x10
               	str	d1, [x17]
               	fmov	d16, x2
               	str	d16, [x0]
               	ldur	x3, [x29, #-0x10]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x3, x3, x17
               	ldr	x4, [x0]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x4, x4, x17
               	orr	x3, x3, x4
               	stur	x3, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fmov	d17, x1
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x40000000         // =1073741824
               	mov	x3, #0x40a00000         // =1084227584
               	fmov	s16, w3
               	fneg	s1, s16
               	fmov	s16, w1
               	fcvt	d2, s16
               	fcvt	d1, s1
               	sub	x17, x29, #0x10
               	str	d2, [x17]
               	str	d1, [x0]
               	ldur	x3, [x29, #-0x10]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	and	x3, x3, x17
               	ldr	x0, [x0]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	and	x0, x0, x17
               	orr	x0, x3, x0
               	stur	x0, [x29, #-0x10]
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fcvt	s1, d1
               	fmov	s16, w1
               	fneg	s2, s16
               	fcmp	s1, s2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	ldur	x0, [x29, #-0x10]
               	lsr	x0, x0, #63
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x2
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	ldur	x0, [x29, #-0x10]
               	lsr	x0, x0, #63
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fneg	d0, d16
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	ldur	x1, [x29, #-0x10]
               	lsr	x1, x1, #63
               	sxtw	x1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d16, x0
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	sxtw	x1, w1
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc8a0             // =51360
               	movk	x0, #0x85eb, lsl #16
               	movk	x0, #0xccf3, lsl #32
               	movk	x0, #0x7fe1, lsl #48
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	ldur	x0, [x29, #-0x10]
               	lsr	x1, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x1, x1, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x0, x0, x17
               	cbnz	x1, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	sub	x17, x29, #0x10
               	str	d0, [x17]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x2                // =2
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0xe62b             // =58923
               	movk	x1, #0x8b70, lsl #16
               	movk	x1, #0x1268, lsl #32
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	ldur	x1, [x29, #-0x10]
               	lsr	x2, x1, #52
               	mov	x17, #0x7ff             // =2047
               	and	x2, x2, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cbnz	x2, <addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x7ff
               	b.ne	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x2, #0x7ff
               	b.ne	<addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	sxtw	x1, w1
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
