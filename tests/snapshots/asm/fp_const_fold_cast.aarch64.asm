
fp_const_fold_cast.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ret

<use_d>:
               	ret

<main>:
               	mov	x0, #0x40c00000         // =1086324736
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0xc0400000         // =3225419776
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s16, w1
               	fneg	s0, s16
               	fmov	s16, w0
               	fcmp	s16, s0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x42c80000         // =1120403456
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #-0x3ff8000000000000 // =-4609434218613702656
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x1
               	fneg	d0, d16
               	fmov	d16, x0
               	fcmp	d16, d0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x4b800000         // =1266679808
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x2                // =2
               	movk	x0, #0x4b80, lsl #16
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0xccd9             // =52441
               	movk	x0, #0x5f79, lsl #16
               	fmov	s16, w0
               	fmov	s17, w0
               	fcmp	s16, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x1, #0x40400000         // =1077936128
               	fmov	s16, w1
               	fmov	s17, w0
               	fmul	s0, s16, s17
               	mov	x1, #0x40a00000         // =1084227584
               	fmov	s16, w1
               	fmov	s17, w0
               	fmul	s1, s16, s17
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s1
               	mov	x0, #0x40e00000         // =1088421888
               	fmov	s17, w0
               	fadd	s0, s0, s17
               	mov	x0, #0x41e80000         // =1105723392
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
