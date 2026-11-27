
zero_stored_through_an_index.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<index_double>:
               	str	xzr, [x0, x1, lsl #3]
               	ret

<index_float>:
               	str	wzr, [x0, x1, lsl #2]
               	ret

<index_long>:
               	str	xzr, [x0, x1, lsl #3]
               	ret

<index_int>:
               	str	wzr, [x0, x1, lsl #2]
               	ret

<through_double>:
               	str	xzr, [x0]
               	ret

<through_float>:
               	str	wzr, [x0]
               	ret

<fields>:
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	str	xzr, [x0, #0x10]
               	str	wzr, [x0, #0x18]
               	strh	wzr, [x0, #0x1c]
               	strb	wzr, [x0, #0x1e]
               	ret

<frame_array>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x20
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	stur	x2, [x29, #-0x20]
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	stur	x2, [x29, #-0x18]
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	stur	x2, [x29, #-0x10]
               	mov	x2, #0x4010000000000000 // =4616189618054758400
               	stur	x2, [x29, #-0x8]
               	add	x0, x1, x0, lsl #3
               	str	xzr, [x0]
               	ldr	d0, [x0]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<spread>:
               	add	x0, x0, x1
               	add	x0, x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	sub	x0, x29, #0x70
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x4045000000000000 // =4631107791820423168
               	bl	<addr>
               	sub	x0, x29, #0x60
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	ldur	d0, [x29, #-0x50]
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x42280000         // =1109917696
               	bl	<addr>
               	sub	x0, x29, #0x80
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	ldur	s0, [x29, #-0x7c]
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	sub	x0, x29, #0x40
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	ldur	x0, [x29, #-0x28]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	sub	x0, x29, #0x70
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	ldursw	x0, [x29, #-0x70]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x60
               	bl	<addr>
               	movi	d0, #0000000000000000
               	ldur	d1, [x29, #-0x60]
               	fcmp	d1, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x42280000         // =1109917696
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x80
               	bl	<addr>
               	ldur	s0, [x29, #-0x80]
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4045000000000000 // =4631107791820423168
               	mov	x1, #0x2                // =2
               	mov	x2, #0x4d               // =77
               	bl	<addr>
               	sub	x0, x29, #0x20
               	bl	<addr>
               	ldur	d0, [x29, #-0x20]
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x18]
               	movi	d1, #0000000000000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x8]
               	cbnz	w0, <addr>
               	ldursh	x0, [x29, #-0x4]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x2]
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x4045000000000000 // =4631107791820423168
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
