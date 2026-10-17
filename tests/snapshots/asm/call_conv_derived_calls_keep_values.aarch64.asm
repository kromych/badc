
call_conv_derived_calls_keep_values.aarch64:	file format elf64-littleaarch64

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

<svd>:
               	fmul	d0, d0, d1
               	ret

<svi>:
               	mov	x0, #0x3e8              // =1000
               	ret

<through_types>:
               	stp	d8, d9, [sp, #-0x40]!
               	stp	d10, d11, [sp, #0x10]
               	stp	x20, x21, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	fmov	d8, d0
               	fmov	d9, d1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d10, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	fmov	d0, d8
               	fmov	d1, d9
               	blr	x21
               	fmov	d1, #2.00000000
               	fmul	d1, d10, d1
               	fcvtzs	x0, d1
               	add	x0, x20, x0
               	scvtf	d1, x0
               	fadd	d11, d0, d1
               	fmov	d0, d8
               	fmov	d1, d9
               	blr	x21
               	fmov	d1, #2.00000000
               	fmul	d1, d10, d1
               	fcvtzs	x0, d1
               	add	x0, x20, x0
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	fadd	d2, d11, d0
               	fmadd	d0, d8, d9, d1
               	fadd	d1, d2, d0
               	fadd	d11, d1, d0
               	fmov	d0, d8
               	fmov	d1, d9
               	blr	x21
               	fadd	d0, d11, d0
               	fmov	d1, #2.00000000
               	fmul	d1, d10, d1
               	fcvtzs	x0, d1
               	add	x0, x20, x0
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x40
               	ret

<old_style>:
               	str	d8, [sp, #-0x30]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x20, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d8, [x1]
               	blr	x0
               	fmov	d1, #2.00000000
               	fmul	d1, d8, d1
               	fcvtzs	x0, d1
               	add	x0, x20, x0
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret

<through_va_arg>:
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
               	str	d8, [sp, #-0x50]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d8, [x0]
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
               	ldr	x0, [x0]
               	fmov	d0, #0.75000000
               	fmov	d1, #0.50000000
               	blr	x0
               	sub	x0, x29, #0x20
               	fmov	d1, #2.00000000
               	fmul	d1, d8, d1
               	fcvtzs	x0, d1
               	add	x0, x20, x0
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<int_through_types>:
               	str	d8, [sp, #-0x40]!
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d8, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	blr	x21
               	fmov	d0, #2.00000000
               	fmul	d0, d8, d0
               	fcvtzs	x1, d0
               	add	x1, x20, x1
               	add	x22, x0, x1
               	blr	x21
               	add	x0, x22, x0
               	fmov	d0, #2.00000000
               	fmul	d0, d8, d0
               	fcvtzs	x1, d0
               	add	x1, x20, x1
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret

<int_old_style>:
               	str	d8, [sp, #-0x30]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x20, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d8, [x1]
               	blr	x0
               	fmov	d0, #2.00000000
               	fmul	d0, d8, d0
               	fcvtzs	x1, d0
               	add	x1, x20, x1
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x30]!
               	stp	x20, x21, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	fmov	d1, #2.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x1, d0
               	add	x20, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	fmov	d0, #0.37500000
               	scvtf	d1, x20
               	fadd	d8, d0, d1
               	fmov	d0, #0.75000000
               	fmov	d1, #0.50000000
               	bl	<addr>
               	fmov	d1, #5.00000000
               	fmul	d1, d1, d8
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	fmov	d0, #0.75000000
               	fmov	d1, #0.50000000
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x21, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d9, [x1]
               	blr	x0
               	fmov	d1, #2.00000000
               	fmul	d1, d9, d1
               	fcvtzs	x0, d1
               	add	x0, x21, x0
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	fcmp	d0, d8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	bl	<addr>
               	fcmp	d0, d8
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	bl	<addr>
               	add	x1, x20, #0x3e8
               	lsl	x1, x1, #1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x21, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d8, [x1]
               	blr	x0
               	fmov	d0, #2.00000000
               	fmul	d0, d8, d0
               	fcvtzs	x1, d0
               	add	x1, x21, x1
               	add	x0, x0, x1
               	add	x1, x20, #0x3e8
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
