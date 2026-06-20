
libc_fp_return_value.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x20, #0x1               // =1
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fsqrt	d0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	frintm	d0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x6666, lsl #16
               	movk	x0, #0x6666, lsl #32
               	movk	x0, #0x4002, lsl #48
               	fmov	d16, x0
               	frintp	d0, d16
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fneg	d0, d16
               	fabs	d0, d0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s0, d16
               	fsqrt	s0, s0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	fabs	s0, s0
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x0
               	fcvt	s0, d16
               	fsqrt	s0, s0
               	fcvt	d0, s0
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	frintm	s0, s0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x6666, lsl #16
               	movk	x0, #0x6666, lsl #32
               	movk	x0, #0x4002, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	frintp	s0, s0
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fcvt	s1, d16
               	bl	<addr>
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x0               // =0
               	sxtw	x0, w20
               	cbz	x0, <addr>
               	mov	x1, #0xb                // =11
               	b	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
