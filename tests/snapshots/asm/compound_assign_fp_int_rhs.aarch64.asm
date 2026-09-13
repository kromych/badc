
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
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	mov	x1, #-0x4010000000000000 // =-4616189618054758400
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x2
               	fmul	d0, d0, d17
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	fmov	d16, x2
               	fneg	d2, d16
               	fcmp	d0, d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d17, x1
               	fsub	d0, d0, d17
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d17, x0
               	fdiv	d0, d0, d17
               	fmov	d16, x1
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x11               // =17
               	ret
