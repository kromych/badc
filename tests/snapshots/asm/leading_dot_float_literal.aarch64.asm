
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
               	fmov	s0, #0.50000000
               	fmov	d1, #0.25000000
               	fmov	d2, #25.00000000
               	fmov	d3, #0.50000000
               	fcvt	s3, d3
               	mov	x0, #0x1                // =1
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	fcmp	d2, d2
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	fcmp	s3, s0
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	b	<addr>
