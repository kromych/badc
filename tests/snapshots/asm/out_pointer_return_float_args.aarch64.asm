
out_pointer_return_float_args.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #1.00000000
               	fmov	s1, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	s3, #4.00000000
               	fcmp	s0, s0
               	b.ne	<addr>
               	fcmp	s1, s1
               	b.ne	<addr>
               	fcmp	s2, s2
               	b.ne	<addr>
               	fcmp	s3, s3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s0, #1.50000000
               	fmov	s1, #2.50000000
               	fmov	s2, #3.50000000
               	fmov	s3, #4.50000000
               	fmov	s4, #5.50000000
               	fcmp	s0, s0
               	b.ne	<addr>
               	fcmp	s1, s1
               	b.ne	<addr>
               	fcmp	s2, s2
               	b.ne	<addr>
               	fcmp	s3, s3
               	b.ne	<addr>
               	fcmp	s4, s4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d0, #10.00000000
               	fmov	d1, #20.00000000
               	fmov	d2, #30.00000000
               	fcmp	d0, d0
               	b.ne	<addr>
               	fcmp	d1, d1
               	b.ne	<addr>
               	fcmp	d2, d2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
