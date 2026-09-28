
variadic_hidden_result_pointer.aarch64:	file format elf64-littleaarch64

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

<vpair>:
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
               	sub	sp, sp, #0x60
               	stur	x8, [x29, #-0x18]
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	sub	x0, x29, #0x58
               	add	x1, x29, #0x20
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x28             // =-40
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x70             // =-112
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x38
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	sub	x1, x29, #0x10
               	ldr	x2, [x1]
               	str	x2, [x0]
               	ldr	x1, [x1, #0x8]
               	str	x1, [x0, #0x8]
               	str	xzr, [x0, #0x10]
               	ldrsw	x0, [x29, #0x20]
               	sub	x1, x29, #0x58
               	mov	x2, #0x8                // =8
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x1, x16
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	add	x1, x0, #0x3e8
               	sub	x0, x29, #0x38
               	str	x1, [x0, #0x18]
               	add	x0, x0, #0x10
               	add	x1, x29, #0x50
               	bl	<addr>
               	sub	x0, x29, #0x58
               	sub	x0, x29, #0x38
               	mov	x16, x0
               	ldur	x17, [x29, #-0x18]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<vquad>:
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
               	sub	sp, sp, #0x50
               	stur	x8, [x29, #-0x8]
               	ldr	x0, [x29, #0x10]
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	sub	x0, x29, #0x48
               	add	x5, x29, #0x18
               	mov	x16, x0
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x30             // =-48
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	sub	x0, x29, #0x48
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x16, [x16]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x5, [x0]
               	ldr	x6, [x0, #0x8]
               	ldr	x7, [x0, #0x10]
               	ldr	x8, [x0, #0x18]
               	sub	x0, x29, #0x48
               	sub	x0, x29, #0x28
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	add	x1, x1, x5
               	str	x1, [x0]
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x1, x1, x6
               	str	x1, [x0, #0x8]
               	mov	x17, #0xa               // =10
               	mul	x1, x3, x17
               	add	x1, x1, x7
               	str	x1, [x0, #0x10]
               	mov	x17, #0xa               // =10
               	mul	x1, x4, x17
               	add	x1, x1, x8
               	ldrsw	x2, [x29, #0x18]
               	add	x1, x1, x2
               	str	x1, [x0, #0x18]
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldp	x0, x1, [x16, #0x10]
               	stp	x0, x1, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	sub	x0, x29, #0x90
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	fmov	d0, #2.50000000
               	mov	x2, #0x3                // =3
               	mov	x3, #0x28               // =40
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x98
               	sub	x1, x29, #0x80
               	add	x1, x1, #0x10
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x80
               	ldr	x1, [x0]
               	cmp	x1, #0xb
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x16
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x98]
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x413
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
               	fmov	d0, #4.50000000
               	mov	x2, #0x5                // =5
               	mov	x3, #0x32               // =50
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	sub	x8, x29, #0x60
               	bl	<addr>
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x98
               	sub	x1, x29, #0x80
               	add	x1, x1, #0x10
               	mov	x2, #0x8                // =8
               	bl	<addr>
               	sub	x0, x29, #0x80
               	ldr	x1, [x0]
               	cmp	x1, #0xb
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x16
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x98]
               	fmov	d1, #4.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x41f
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x1                // =1
               	mov	x3, #0x2                // =2
               	mov	x4, #0x3                // =3
               	mov	x5, #0x4                // =4
               	mov	x6, #0x5                // =5
               	mov	x7, #0x6                // =6
               	mov	x8, #0x7                // =7
               	mov	x9, #0x8                // =8
               	mov	x1, #0x9                // =9
               	sub	x0, x29, #0x40
               	str	x2, [x0]
               	str	x3, [x0, #0x8]
               	str	x4, [x0, #0x10]
               	str	x5, [x0, #0x18]
               	sub	x2, x29, #0x20
               	str	x6, [x2]
               	str	x7, [x2, #0x8]
               	str	x8, [x2, #0x10]
               	str	x9, [x2, #0x18]
               	sub	x8, x29, #0x60
               	bl	<addr>
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x80
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x0, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	sub	x0, x29, #0x80
               	ldr	x1, [x0]
               	cmp	x1, #0xf
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x1a
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, #0x25
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x39
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
