
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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x0                // =0
               	mov	x20, #0x40a00000        // =1084227584
               	fmov	d0, x20
               	bl	<addr>
               	fmov	s16, w20
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, #0x40a00000        // =1084227584
               	fmov	d0, x20
               	bl	<addr>
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	mov	x20, #0x40a00000        // =1084227584
               	fmov	d0, x20
               	bl	<addr>
               	fmov	s16, w20
               	fneg	s1, s16
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x3                // =3
               	mov	x20, #0x40a00000        // =1084227584
               	fmov	d0, x20
               	bl	<addr>
               	fmov	s17, w20
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, #0x3fc00000        // =1069547520
               	mov	x21, #0x40200000        // =1075838976
               	fmov	d0, x20
               	fmov	d1, x21
               	bl	<addr>
               	fmov	s16, w21
               	fneg	s1, s16
               	fmov	s16, w20
               	fadd	s1, s16, s1
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	mov	x20, #0x40e80000        // =1088946176
               	mov	x21, #0x3e000000        // =1040187392
               	fmov	d0, x20
               	fmov	d1, x21
               	bl	<addr>
               	fmov	s16, w20
               	fneg	s1, s16
               	fmov	s17, w21
               	fadd	s1, s1, s17
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x3                // =3
               	mov	x20, #0x40400000        // =1077936128
               	mov	x21, #0x40800000        // =1082130432
               	fmov	d0, x20
               	fmov	d1, x21
               	bl	<addr>
               	fmov	s16, w20
               	fmov	s17, w21
               	fadd	s1, s16, s17
               	fcmp	s0, s1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
