
call_conv_of_derived_types.aarch64:	file format elf64-littleaarch64

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

<msf>:
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<svf>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sub	x0, x0, x1
               	ret

<get_svf>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ret

<via_typeof>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x23, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	mov	x17, #0x2710            // =10000
               	mul	x0, x0, x17
               	add	x22, x23, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x22, x22, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<via_auto>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x22, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x23, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	add	x0, x23, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<via_old_style>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x4, x0
               	mov	x21, x3
               	mov	x20, x2
               	mov	x22, x1
               	mov	x0, x20
               	mov	x1, x21
               	blr	x4
               	mov	x17, #0x64              // =100
               	mul	x23, x0, x17
               	mov	x0, x20
               	mov	x1, x21
               	blr	x22
               	add	x0, x23, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<via_va_arg>:
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
               	str	x20, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	sub	x0, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x0
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
               	sub	x0, x29, #0x20
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
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x2, [x0]
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x20, x0, x17
               	sub	x0, x29, #0x20
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
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldr	x2, [x0]
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	blr	x2
               	add	x0, x20, x0
               	sub	x1, x29, #0x20
               	ldrsw	x1, [x29, #0x10]
               	add	x0, x0, x1
               	sub	x0, x0, #0x2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x20, [sp], #0x40
               	add	sp, sp, #0xc0
               	ret

<via_cast>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<via_expression_forms>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	sxtw	x2, w2
               	mov	x21, x1
               	cbz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	bl	<addr>
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	mov	x17, #0x64              // =100
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	b	<addr>

<via_objects>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, w2, sxtw #3]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x2710            // =10000
               	mul	x22, x0, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x22, x22, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x22, x22, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	sub	x0, x0, #0x17
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x56eb            // =22251
               	movk	x17, #0x160, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	mov	x17, #0x64              // =100
               	mul	x20, x0, x17
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	add	x0, x20, x0
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2                // =2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	bl	<addr>
               	cmp	x0, #0x905
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x39b
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	mov	x17, #0xc155            // =49493
               	movk	x17, #0xc416, lsl #16
               	movk	x17, #0x35, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x1, #0x3                // =3
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	mov	x17, #0x6895            // =26773
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
