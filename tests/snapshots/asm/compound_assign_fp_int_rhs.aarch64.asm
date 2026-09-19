
compound_assign_fp_int_rhs.aarch64:	file format elf64-littleaarch64

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
               	fmov	d1, #1.50000000
               	fmov	d0, #-1.00000000
               	fmul	d1, d1, d0
               	fmov	d2, #-1.50000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d2, #2.00000000
               	fmul	d1, d1, d2
               	fmov	d2, #-3.00000000
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d3, #1.00000000
               	fadd	d1, d1, d3
               	fmov	d4, #-2.00000000
               	fcmp	d1, d4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fsub	d1, d1, d3
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d2, #3.00000000
               	fdiv	d1, d1, d2
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x11               // =17
               	ret
