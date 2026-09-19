
ternary_arith_conversion.aarch64:	file format elf64-littleaarch64

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
               	fmov	d1, #1.00000000
               	fmov	d0, #1.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d0, #2.00000000
               	fmov	d2, #2.00000000
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d2, #1.00000000
               	fcmp	d2, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fmov	d2, #2.00000000
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	fmov	s2, #1.00000000
               	fcvt	d3, s2
               	fcmp	d3, d1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fmov	d1, #2.00000000
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	fmov	s0, #1.00000000
               	fcmp	s0, s2
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	fmov	s0, #2.00000000
               	fmov	s1, #2.00000000
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	mov	x0, #0x0                // =0
               	ret
