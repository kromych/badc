
float_single_precision.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0x3f800000         // =1065353216
               	mov	x0, #0x40400000         // =1077936128
               	fmov	s16, w2
               	fmov	s17, w0
               	fdiv	s0, s16, s17
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0x3eaa, lsl #16
               	fmov	s17, w0
               	fsub	s0, s0, s17
               	mov	x1, #0x0                // =0
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.pl	<addr>
               	fneg	s0, s0
               	mov	x0, #0xbf95             // =49045
               	movk	x0, #0x33d6, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3dcc, lsl #16
               	fmov	s16, w1
               	fmov	s17, w0
               	fadd	s0, s16, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	fmov	s17, w0
               	fadd	s1, s0, s17
               	mov	x0, #0x1                // =1
               	movk	x0, #0x3f80, lsl #16
               	fmov	s17, w0
               	fsub	s0, s1, s17
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.pl	<addr>
               	fneg	s0, s0
               	mov	x0, #0x37bd             // =14269
               	movk	x0, #0x3586, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x3f8c, lsl #16
               	fmov	s16, w0
               	fmov	s17, w0
               	fmul	s0, s16, s17
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x2, #0x67a2             // =26530
               	movk	x2, #0x3fbb, lsl #16
               	fmov	s17, w0
               	fmov	s18, w2
               	fnmsub	s0, s0, s17, s18
               	fmov	s17, w1
               	fcmp	s0, s17
               	b.pl	<addr>
               	fneg	s0, s0
               	mov	x0, #0xc5ac             // =50604
               	movk	x0, #0x3727, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	fmov	s17, w2
               	fcmp	s1, s17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
