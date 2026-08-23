
leading_dot_float_literal.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3f000000         // =1056964608
               	fmov	s16, w1
               	sub	x17, x29, #0x20
               	str	s16, [x17]
               	mov	x2, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x2
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	mov	x3, #0x4039000000000000 // =4627730092099895296
               	fmov	d16, x3
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x1                // =1
               	sub	x16, x29, #0x20
               	ldr	s1, [x16]
               	fmov	s17, w1
               	fcmp	s1, s17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	fmov	d17, x2
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	fmov	d17, x3
               	fcmp	d1, d17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
