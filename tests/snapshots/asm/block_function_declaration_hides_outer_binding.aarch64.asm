
block_function_declaration_hides_outer_binding.aarch64:	file format elf64-littleaarch64

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

<hides_local>:
               	mov	x0, #0x70               // =112
               	ret

<hides_parameter>:
               	mov	x0, #0x8                // =8
               	ret

<hides_static>:
               	mov	x0, #0x3c               // =60
               	ret

<hides_block_local>:
               	mov	x0, #0x46               // =70
               	ret

<hides_enumerator>:
               	mov	x0, #0x10               // =16
               	ret

<hides_typedef>:
               	mov	x0, #0x5a               // =90
               	ret

<hides_library>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #-0x5               // =-5
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<composite_prototype>:
               	fmov	d0, #2.00000000
               	fmov	d1, #10.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x0, d0
               	add	x0, x0, #0x64
               	ret

<hides_with_variadic>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x3                // =3
               	fmov	d0, #1.50000000
               	fmov	d1, #2.25000000
               	fmov	d2, #4.00000000
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	ldp	x29, x30, [sp], #0x10
               	ret

<declared_in_an_outer_block>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	add	x0, x0, #0x3
               	ret

<outer_block_double>:
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	scvtf	d0, x1
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	scvtf	d1, x0
               	fadd	d0, d0, d1
               	ret

<outer_block_pointer>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	sub	x0, x0, #0x4
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, x0
               	ret

<add100>:
               	add	x0, x0, #0x64
               	ret

<twice>:
               	lsl	x0, x0, #1
               	ret

<later>:
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	ret

<unproto>:
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	fmov	d1, #10.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	ret

<big>:
               	sxtw	x0, w0
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	ret

<half>:
               	sxtw	x0, w0
               	scvtf	d0, x0
               	fmov	d1, #2.00000000
               	fdiv	d0, d0, d1
               	ret

<at>:
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, x0
               	ret

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	cmp	w0, #0x70
               	cset	x20, ne
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x8
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #1
               	bl	<addr>
               	cmp	w0, #0x3c
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #2
               	bl	<addr>
               	cmp	w0, #0x46
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #3
               	bl	<addr>
               	cmp	w0, #0x10
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #4
               	bl	<addr>
               	cmp	w0, #0x5a
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #5
               	bl	<addr>
               	cmp	w0, #0x5
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #6
               	bl	<addr>
               	cmp	w0, #0x78
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #7
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #8
               	bl	<addr>
               	mov	x17, #0x138b            // =5003
               	cmp	x0, x17
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #9
               	bl	<addr>
               	fmov	d1, #3.50000000
               	fcmp	d0, d1
               	cset	x0, ne
               	orr	x20, x20, x0, lsl #10
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	cset	x0, ne
               	orr	x0, x20, x0, lsl #11
               	cmp	w0, #0x0
               	cset	x0, ne
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
