
fp_param_ternary.aarch64:	file format elf64-littleaarch64

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

<pick>:
               	tbz	w0, #0x0, <addr>
               	ret
               	fneg	s0, s0
               	b	<addr>

<grad_dot>:
               	tbz	w0, #0x0, <addr>
               	tbz	w0, #0x1, <addr>
               	fadd	s0, s0, s1
               	ret
               	fneg	s1, s1
               	b	<addr>
               	fneg	s0, s0
               	b	<addr>

<main>:
               	fmov	s0, #1.50000000
               	fmov	s1, #-2.50000000
               	fadd	s0, s0, s1
               	fmov	s1, #-1.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	s0, #-7.25000000
               	fmov	s1, #0.12500000
               	fadd	s0, s0, s1
               	mov	x16, #0xc0e40000        // =3236167680
               	fmov	s1, w16
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	s0, #3.00000000
               	fmov	s1, #4.00000000
               	fadd	s0, s0, s1
               	fmov	s1, #7.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
