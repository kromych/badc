
fp_param_ternary.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<pick>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	b	<addr>
               	fneg	s0, s0
               	sub	x0, x29, #0x10
               	str	s0, [x0]
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<grad_dot>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x0, w0
               	mov	x17, #0x1               // =1
               	and	x1, x0, x17
               	cbz	x1, <addr>
               	sub	x1, x29, #0x28
               	str	s0, [x1]
               	b	<addr>
               	fneg	s0, s0
               	sub	x1, x29, #0x28
               	str	s0, [x1]
               	sub	x16, x29, #0x28
               	ldr	s0, [x16]
               	mov	x17, #0x2               // =2
               	and	x0, x0, x17
               	cbz	x0, <addr>
               	sub	x0, x29, #0x30
               	str	s1, [x0]
               	b	<addr>
               	fneg	s1, s1
               	sub	x0, x29, #0x30
               	str	s1, [x0]
               	sub	x16, x29, #0x30
               	ldr	s1, [x16]
               	fadd	s0, s0, s1
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
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x20
               	fcvt	s0, d16
               	bl	<addr>
               	fmov	d16, x20
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x20
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x20
               	fcvt	s0, d16
               	bl	<addr>
               	fmov	d16, x20
               	fneg	d1, d16
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	fmov	d16, x20
               	fcvt	s0, d16
               	bl	<addr>
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x21
               	fcvt	s1, d16
               	bl	<addr>
               	fmov	d16, x21
               	fneg	d1, d16
               	fmov	d16, x20
               	fadd	d1, d16, d1
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x20, #0x401d000000000000 // =4619848792751996928
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x21, #0x3fc0000000000000 // =4593671619917905920
               	fmov	d16, x21
               	fcvt	s1, d16
               	bl	<addr>
               	fmov	d16, x20
               	fneg	d1, d16
               	fmov	d17, x21
               	fadd	d1, d1, d17
               	fcvt	d0, s0
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x20, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x20
               	fcvt	s0, d16
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x21
               	fcvt	s1, d16
               	bl	<addr>
               	fmov	d16, x20
               	fmov	d17, x21
               	fadd	d1, d16, d17
               	fcvt	d0, s0
               	fcmp	d0, d1
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
