
float_literal_f_suffix.aarch64:	file format elf64-littleaarch64

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

<vsum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x20
               	add	x0, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	ldrsw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x4b800000        // =1266679808
               	fmov	s0, w16
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	mov	x16, #0x4170000000000000 // =4715268809856909312
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x18]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcvt	d1, s0
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x10]
               	fcmp	d1, d2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fneg	s0, s0
               	fneg	d1, d2
               	fcvt	d0, s0
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	fmov	s0, #1.50000000
               	fcvt	d0, s0
               	fmov	s1, #0.25000000
               	fcvt	d1, s1
               	bl	<addr>
               	fmov	d1, #1.75000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x18]
               	fcvt	d0, s0
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x1c]
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
