
float_arg_single_precision.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x1, #0x3e800000         // =1048576000
               	fmov	s16, w0
               	fmov	s17, w1
               	fmul	s0, s16, s17
               	mov	x0, #0x3ec00000         // =1052770304
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x40200000         // =1075838976
               	fmov	s16, w0
               	fneg	s0, s16
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x41200000         // =1092616192
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3f000000         // =1056964608
               	mov	x1, #0x3e800000         // =1048576000
               	mov	x2, #0x3e000000         // =1040187392
               	fmov	s16, w0
               	fmov	s17, w1
               	fadd	s0, s16, s17
               	fmov	s17, w2
               	fadd	s0, s0, s17
               	mov	x0, #0x3f600000         // =1063256064
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x41000000         // =1090519040
               	fmov	s16, w0
               	fmov	s17, w1
               	fdiv	s0, s16, s17
               	mov	x0, #0x41800000         // =1098907648
               	fmov	s17, w0
               	fmul	s0, s0, s17
               	mov	x0, #0x40000000         // =1073741824
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
