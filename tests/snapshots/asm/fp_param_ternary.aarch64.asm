
fp_param_ternary.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	fmov	d1, d0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	b	<addr>
               	fneg	s1, s1
               	fmov	d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<grad_dot>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x0, w0
               	fmov	d2, d0
               	mov	x17, #0x1               // =1
               	and	x1, x0, x17
               	cbz	x1, <addr>
               	b	<addr>
               	fneg	s2, s2
               	mov	x17, #0x2               // =2
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	b	<addr>
               	fneg	s1, s1
               	fadd	s0, s2, s1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
