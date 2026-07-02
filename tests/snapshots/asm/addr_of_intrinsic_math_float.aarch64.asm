
addr_of_intrinsic_math_float.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x370              // =880
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	d8, [sp]
               	str	d9, [sp, #0x8]
               	str	x20, [sp, #0x10]
               	str	x21, [sp, #0x18]
               	str	x22, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x1, #0x4030000000000000 // =4625196817309499392
               	fmov	d16, x1
               	fcvt	s0, d16
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4005, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x20
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0x4000, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x21
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x4007, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x22
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x400c000000000000 // =4615063718147915776
               	fmov	d16, x20
               	fneg	d0, d16
               	fcvt	s0, d0
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	fcvt	d0, s0
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x400000000000     // =70368744177664
               	movk	x0, #0x4054, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	mov	x0, #0x999a             // =39322
               	movk	x0, #0x9999, lsl #16
               	movk	x0, #0x9999, lsl #32
               	movk	x0, #0x4017, lsl #48
               	fmov	d16, x0
               	fcvt	s8, d16
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0x4000, lsl #48
               	fmov	d16, x0
               	fcvt	s9, d16
               	sub	x0, x29, #0x40
               	ldr	x0, [x0]
               	fmov	x16, d0
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4022000000000000 // =4621256167635550208
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	fmov	x16, d8
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4014000000000000 // =4617315517961601024
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x10]
               	fmov	x16, d9
               	str	x16, [sp, #-0x10]!
               	mov	x9, x0
               	ldr	d0, [sp]
               	blr	x9
               	add	sp, sp, #0x10
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fmov	d16, x0
               	fneg	d0, d16
               	fcvt	s0, d0
               	fabs	s0, s0
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4048, lsl #48
               	fmov	d16, x0
               	fcvt	s0, d16
               	fsqrt	s0, s0
               	mov	x0, #0x401c000000000000 // =4619567317775286272
               	fcvt	d0, s0
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	x21, [sp, #0x18]
               	ldr	x22, [sp, #0x20]
               	ldr	d8, [sp]
               	ldr	d9, [sp, #0x8]
               	ldr	x19, [sp, #0x30]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_sqrtf>:
               	b	<addr>

<__c5_sys_floorf>:
               	b	<addr>

<__c5_sys_ceilf>:
               	b	<addr>
