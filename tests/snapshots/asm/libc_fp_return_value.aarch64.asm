
libc_fp_return_value.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x1               // =1
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x21
               	fsqrt	d0, d16
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x1, #0x999a             // =39322
               	movk	x1, #0x9999, lsl #16
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x4005, lsl #48
               	fmov	d16, x1
               	frintm	d0, d16
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x6666             // =26214
               	movk	x0, #0x6666, lsl #16
               	movk	x0, #0x6666, lsl #32
               	movk	x0, #0x4002, lsl #48
               	fmov	d16, x0
               	frintp	d0, d16
               	mov	x22, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x22
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x0
               	fneg	d0, d16
               	fabs	d0, d0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d0, x0
               	fmov	d1, x21
               	bl	<addr>
               	fmov	d17, x22
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s16, w0
               	fsqrt	s0, s16
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x2, #0x40600000         // =1080033280
               	fmov	s16, w2
               	fneg	s0, s16
               	fabs	s0, s0
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x2, #0x41800000         // =1098907648
               	fmov	s16, w2
               	fsqrt	s0, s16
               	fcvt	d0, s0
               	fmov	d17, x21
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x2, #0xcccd             // =52429
               	movk	x2, #0x402c, lsl #16
               	fmov	s16, w2
               	frintm	s0, s16
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x1, #0x3333             // =13107
               	movk	x1, #0x4013, lsl #16
               	fmov	s16, w1
               	frintp	s0, s16
               	mov	x21, #0x40400000        // =1077936128
               	fmov	s17, w21
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	mov	x1, #0x40e00000         // =1088421888
               	fmov	d0, x1
               	fmov	d1, x0
               	bl	<addr>
               	fmov	s17, w21
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x20, #0x0               // =0
               	sxtw	x0, w20
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
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
               	b	<addr>
