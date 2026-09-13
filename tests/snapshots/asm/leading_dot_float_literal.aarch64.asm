
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
               	mov	x1, #0x3f000000         // =1056964608
               	mov	x2, #0x3fd0000000000000 // =4598175219545276416
               	mov	x3, #0x4039000000000000 // =4627730092099895296
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x1                // =1
               	fmov	s16, w1
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x2
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d16, x3
               	fmov	d17, x3
               	fcmp	d16, d17
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
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
