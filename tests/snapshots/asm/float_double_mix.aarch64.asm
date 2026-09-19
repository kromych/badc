
float_double_mix.aarch64:	file format elf64-littleaarch64

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
               	mov	x2, #0xcccd             // =52429
               	movk	x2, #0x3dcc, lsl #16
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x3fc9, lsl #48
               	fmov	s16, w2
               	fcvt	d1, s16
               	fmov	d17, x0
               	fadd	d0, d1, d17
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0x34cc, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x3fd3, lsl #48
               	fmov	d17, x0
               	fsub	d0, d0, d17
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x1, #0x5616             // =22038
               	movk	x1, #0x9ee7, lsl #16
               	movk	x1, #0x3af, lsl #32
               	movk	x1, #0x3cd2, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, x1
               	ret
               	mov	x1, #0xa0000000         // =2684354560
               	movk	x1, #0x9999, lsl #32
               	movk	x1, #0x3fb9, lsl #48
               	fmov	d17, x1
               	fsub	d0, d1, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x1, #0xd497             // =54423
               	movk	x1, #0x4646, lsl #16
               	movk	x1, #0xef5, lsl #32
               	movk	x1, #0x3c67, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x1, #0x2                // =2
               	cbz	w1, <addr>
               	mov	x0, x1
               	ret
               	mov	x1, #0xf62e             // =63022
               	movk	x1, #0x3746, lsl #16
               	movk	x1, #0x9add, lsl #32
               	movk	x1, #0x3fbf, lsl #48
               	fmov	d16, x1
               	fcvt	s1, d16
               	mov	x2, #0xd6ea             // =55018
               	movk	x2, #0x3dfc, lsl #16
               	fmov	s17, w2
               	fsub	s0, s1, s17
               	mov	x2, #0x0                // =0
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.pl	<addr>
               	fneg	s0, s0
               	mov	x3, #0xcc77             // =52343
               	movk	x3, #0x322b, lsl #16
               	fmov	s17, w3
               	fcmp	s0, s17
               	b.le	<addr>
               	mov	x0, #0x3                // =3
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fmov	d17, x1
               	fdiv	d0, d16, d17
               	fcvt	s0, d0
               	mov	x0, #0xaaab             // =43691
               	movk	x0, #0x3eaa, lsl #16
               	fmov	s17, w0
               	fsub	s0, s0, s17
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.pl	<addr>
               	fneg	s0, s0
               	mov	x0, #0xbf95             // =49045
               	movk	x0, #0x33d6, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.le	<addr>
               	mov	x0, #0x5                // =5
               	cbz	w0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	fcvt	d0, s1
               	fmov	d17, x1
               	fsub	d0, d0, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.pl	<addr>
               	fneg	d0, d0
               	mov	x1, #0xd695             // =54933
               	movk	x1, #0xe826, lsl #16
               	movk	x1, #0x2e0b, lsl #32
               	movk	x1, #0x3e11, lsl #48
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.pl	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
