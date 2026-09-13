
fp_load_folded_disp.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3fa00000         // =1067450368
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	mov	x2, #0x40980000         // =1083703296
               	fmov	s16, w1
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s16, w2
               	fmov	s17, w2
               	fcmp	s16, s17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x0
               	fmov	d17, x1
               	fadd	d0, d16, d17
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
