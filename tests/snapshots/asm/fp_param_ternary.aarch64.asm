
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
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
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x20, #0x0               // =0
               	mov	x21, #0x4014000000000000 // =4617315517961601024
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	fmov	d0, x21
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x1               // =1
               	mov	x23, #0x4014000000000000 // =4617315517961601024
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x2               // =2
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x2               // =2
               	mov	x21, #0x4014000000000000 // =4617315517961601024
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	fmov	d0, x21
               	fneg	d7, d0
               	fmov	d0, x0
               	fcmp	d0, d7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x3               // =3
               	mov	x23, #0x4014000000000000 // =4617315517961601024
               	mov	x0, x22
               	mov	x1, x23
               	bl	<addr>
               	fmov	d0, x0
               	fmov	d1, x23
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x23, #0x4               // =4
               	mov	x0, x23
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x1               // =1
               	mov	x21, #0x3ff8000000000000 // =4609434218613702656
               	mov	x23, #0x4004000000000000 // =4612811918334230528
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x21
               	bl	<addr>
               	fmov	d0, x23
               	fneg	d7, d0
               	fmov	d0, x21
               	fadd	d6, d0, d7
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x2               // =2
               	mov	x24, #0x401d000000000000 // =4619848792751996928
               	mov	x21, #0x3fc0000000000000 // =4593671619917905920
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x24
               	bl	<addr>
               	fmov	d0, x24
               	fneg	d6, d0
               	fmov	d1, x21
               	fadd	d6, d6, d1
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x6               // =6
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x3               // =3
               	mov	x23, #0x4008000000000000 // =4613937818241073152
               	mov	x21, #0x4010000000000000 // =4616189618054758400
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x23
               	bl	<addr>
               	fmov	d0, x23
               	fmov	d1, x21
               	fadd	d6, d0, d1
               	fmov	d0, x0
               	fcmp	d0, d6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
