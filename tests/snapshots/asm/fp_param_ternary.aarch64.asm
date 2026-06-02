
fp_param_ternary.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x11, x20, #3
               	add	x1, x1, x11
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	ldur	x14, [x29, #0x20]
               	sub	x13, x29, #0x8
               	fmov	d0, x14
               	fcvt	s0, d0
               	str	s0, [x13]
               	mov	x17, #0x1               // =1
               	and	x15, x15, x17
               	cbz	x15, <addr>
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	sub	x15, x29, #0x10
               	fcvt	s0, d7
               	str	s0, [x15]
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fneg	d7, d7
               	sub	x15, x29, #0x10
               	fcvt	s0, d7
               	str	s0, [x15]
               	b	<addr>
               	sub	x16, x29, #0x10
               	ldr	s0, [x16]
               	fcvt	d0, s0
               	fmov	x0, d0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret
               	str	x2, [sp, #-0x10]!
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sxtw	x15, w0
               	ldur	x14, [x29, #0x20]
               	sub	x13, x29, #0x8
               	fmov	d0, x14
               	fcvt	s0, d0
               	str	s0, [x13]
               	ldur	x13, [x29, #0x30]
               	sub	x14, x29, #0x10
               	fmov	d0, x13
               	fcvt	s0, d0
               	str	s0, [x14]
               	mov	x17, #0x1               // =1
               	and	x14, x15, x17
               	cbz	x14, <addr>
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	sub	x14, x29, #0x28
               	fcvt	s0, d7
               	str	s0, [x14]
               	b	<addr>
               	sub	x16, x29, #0x8
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	fneg	d7, d7
               	sub	x14, x29, #0x28
               	fcvt	s0, d7
               	str	s0, [x14]
               	b	<addr>
               	sub	x16, x29, #0x28
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	sub	x14, x29, #0x18
               	fcvt	s0, d7
               	str	s0, [x14]
               	mov	x17, #0x2               // =2
               	and	x15, x15, x17
               	cbz	x15, <addr>
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	sub	x15, x29, #0x30
               	fcvt	s0, d6
               	str	s0, [x15]
               	b	<addr>
               	sub	x16, x29, #0x10
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fneg	d6, d6
               	sub	x15, x29, #0x30
               	fcvt	s0, d6
               	str	s0, [x15]
               	b	<addr>
               	sub	x16, x29, #0x30
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	sub	x15, x29, #0x20
               	fcvt	s0, d6
               	str	s0, [x15]
               	sub	x16, x29, #0x18
               	ldr	s7, [x16]
               	fcvt	d7, s7
               	sub	x16, x29, #0x20
               	ldr	s6, [x16]
               	fcvt	d6, s6
               	fadd	d0, d7, d6
               	fmov	x0, d0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	mov	x1, x20
               	bl	<addr>
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x21, #0x4014000000000000 // =4617315517961601024
               	mov	x1, x21
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x2               // =2
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x20, #0x4014000000000000 // =4617315517961601024
               	mov	x1, x20
               	bl	<addr>
               	fmov	d0, x20
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x3               // =3
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x21, #0x4014000000000000 // =4617315517961601024
               	mov	x1, x21
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x21
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x20, #0x3ff8000000000000 // =4609434218613702656
               	mov	x21, #0x4004000000000000 // =4612811918334230528
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	fmov	d0, x21
               	fneg	d7, d0
               	fmov	d0, x20
               	fadd	d6, d0, d7
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x22, #0x401d000000000000 // =4619848792751996928
               	mov	x20, #0x3fc0000000000000 // =4593671619917905920
               	mov	x1, x22
               	mov	x2, x20
               	bl	<addr>
               	fmov	d0, x22
               	fneg	d6, d0
               	fmov	d1, x20
               	fadd	d6, d6, d1
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x6               // =6
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x21, #0x4008000000000000 // =4613937818241073152
               	mov	x20, #0x4010000000000000 // =4616189618054758400
               	mov	x1, x21
               	mov	x2, x20
               	bl	<addr>
               	fmov	d0, x21
               	fmov	d1, x20
               	fadd	d6, d0, d1
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
