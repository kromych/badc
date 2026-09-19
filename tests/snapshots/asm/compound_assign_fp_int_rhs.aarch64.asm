
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
               	fmov	d0, #1.50000000
               	fmov	d1, #-1.00000000
               	fmul	d1, d0, d1
               	fneg	d0, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d2, #2.00000000
               	fmul	d1, d1, d2
               	fmov	d3, #3.00000000
               	fneg	d4, d3
               	fcmp	d1, d4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d0, #1.00000000
               	fadd	d1, d1, d0
               	fneg	d2, d2
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fsub	d1, d1, d0
               	fcmp	d1, d4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fdiv	d1, d1, d3
               	fneg	d0, d0
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x11               // =17
               	ret
