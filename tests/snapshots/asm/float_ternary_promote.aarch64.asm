
float_ternary_promote.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x17, #0x3fc00000        // =1069547520
               	fmov	s0, w17
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fneg	s0, s16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x40500000         // =1078984704
               	mov	x1, #0x0                // =0
               	fmov	s16, w0
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.le	<addr>
               	mov	x17, #0x40500000        // =1078984704
               	fmov	s0, w17
               	fmov	s16, w0
               	fmov	s17, w1
               	fcmp	s16, s17
               	b.pl	<addr>
               	fmov	s16, w0
               	fneg	s1, s16
               	fadd	s0, s0, s1
               	mov	x0, #0x40d00000         // =1087373312
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x41a00000         // =1101004800
               	mov	x17, #0x41a00000        // =1101004800
               	fmov	s0, w17
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x17, #0x40500000        // =1078984704
               	fmov	s1, w17
               	b	<addr>
               	fmov	s16, w0
               	fneg	s0, s16
               	b	<addr>
