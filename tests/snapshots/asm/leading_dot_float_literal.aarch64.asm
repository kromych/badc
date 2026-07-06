
leading_dot_float_literal.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s16, w0
               	sub	x17, x29, #0x8
               	str	s16, [x17]
               	mov	x1, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d16, x1
               	sub	x17, x29, #0x10
               	str	d16, [x17]
               	mov	x1, #0x4039000000000000 // =4627730092099895296
               	fmov	d16, x1
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x1
               	fcvt	s0, d16
               	mov	x2, #0x1                // =1
               	sub	x16, x29, #0x8
               	ldr	s1, [x16]
               	fmov	s17, w0
               	fcmp	s1, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	sub	x16, x29, #0x10
               	ldr	d1, [x16]
               	mov	x0, #0x3fd0000000000000 // =4598175219545276416
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	sub	x16, x29, #0x18
               	ldr	d1, [x16]
               	mov	x0, #0x4039000000000000 // =4627730092099895296
               	fmov	d17, x0
               	fcmp	d1, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	mov	x0, #0x3f000000         // =1056964608
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x2, #0x0                // =0
               	sxtw	x0, w2
               	cbz	x0, <addr>
               	mov	x1, #0x7                // =7
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
