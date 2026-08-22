
fp_unary_intrinsic.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fsqrt	s0, s16
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x3e800000         // =1048576000
               	fmov	s16, w1
               	fsqrt	s0, s16
               	mov	x1, #0x3f000000         // =1056964608
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x4022000000000000 // =4621256167635550208
               	fmov	d16, x1
               	fsqrt	d0, d16
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x40600000         // =1080033280
               	fmov	s16, w1
               	fneg	s0, s16
               	fabs	s0, s0
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x1
               	fneg	d0, d16
               	fabs	d0, d0
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x3, #0x41800000         // =1098907648
               	fmov	s16, w3
               	fsqrt	s0, s16
               	fcvt	d0, s0
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x4, #0x999a             // =39322
               	movk	x4, #0x9999, lsl #16
               	movk	x4, #0x9999, lsl #32
               	movk	x4, #0x4005, lsl #48
               	fmov	d16, x4
               	frintm	d0, d16
               	mov	x5, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x5
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x3333             // =13107
               	movk	x1, #0x4013, lsl #16
               	fmov	s16, w1
               	fneg	s0, s16
               	frintm	s0, s0
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s16, w1
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x1, #0x6666             // =26214
               	movk	x1, #0x6666, lsl #16
               	movk	x1, #0x6666, lsl #32
               	movk	x1, #0x4002, lsl #48
               	fmov	d16, x1
               	frintp	d0, d16
               	fmov	d17, x2
               	fcmp	d0, d17
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0xcccd             // =52429
               	movk	x1, #0x402c, lsl #16
               	fmov	s16, w1
               	fneg	s0, s16
               	frintp	s0, s0
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	fmov	d16, x4
               	fneg	d0, d16
               	frintz	d0, d0
               	fmov	d16, x5
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mov	x1, #0x999a             // =39322
               	movk	x1, #0x4039, lsl #16
               	fmov	s16, w1
               	frintz	s0, s16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	fmov	s16, w3
               	fneg	s0, s16
               	fabs	s0, s0
               	fsqrt	s0, s0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	sub	x16, x29, #0x8
               	ldr	s0, [x16]
               	fmul	s0, s0, s0
               	fsqrt	s0, s0
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x3f66, lsl #16
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	frintm	s0, s0
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
