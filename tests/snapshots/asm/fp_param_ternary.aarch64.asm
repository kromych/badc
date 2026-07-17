
fp_param_ternary.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	ret
               	fneg	s0, s0
               	b	<addr>

<grad_dot>:
               	sxtw	x0, w0
               	mov	x17, #0x1               // =1
               	and	x1, x0, x17
               	cbz	x1, <addr>
               	mov	x17, #0x2               // =2
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	fadd	s0, s0, s1
               	ret
               	fneg	s1, s1
               	b	<addr>
               	fneg	s0, s0
               	b	<addr>

<main>:
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	s16, w0
               	fneg	s0, s16
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	mov	x17, #0x40a00000        // =1084227584
               	fmov	s0, w17
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	fmov	s16, w0
               	fneg	s0, s16
               	fmov	s16, w0
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x40a00000         // =1084227584
               	mov	x17, #0x40a00000        // =1084227584
               	fmov	s0, w17
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x3fc00000         // =1069547520
               	mov	x1, #0x40200000         // =1075838976
               	mov	x17, #0x3fc00000        // =1069547520
               	fmov	s1, w17
               	fmov	s16, w1
               	fneg	s0, s16
               	fadd	s1, s1, s0
               	fmov	s16, w1
               	fneg	s0, s16
               	fmov	s16, w0
               	fadd	s0, s16, s0
               	fcmp	s1, s0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x40e80000         // =1088946176
               	mov	x1, #0x3e000000         // =1040187392
               	fmov	s16, w0
               	fneg	s0, s16
               	mov	x17, #0x3e000000        // =1040187392
               	fmov	s1, w17
               	fadd	s1, s0, s1
               	fmov	s16, w0
               	fneg	s0, s16
               	fmov	s17, w1
               	fadd	s0, s0, s17
               	fcmp	s1, s0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x40400000         // =1077936128
               	mov	x1, #0x40800000         // =1082130432
               	mov	x17, #0x40400000        // =1077936128
               	fmov	s0, w17
               	mov	x17, #0x40800000        // =1082130432
               	fmov	s1, w17
               	fadd	s1, s0, s1
               	fmov	s16, w0
               	fmov	s17, w1
               	fadd	s0, s16, s17
               	fcmp	s1, s0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
