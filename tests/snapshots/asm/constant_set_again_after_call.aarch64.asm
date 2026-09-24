
constant_set_again_after_call.aarch64:	file format elf64-littleaarch64

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

<note>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x2, x2, x0
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	ret

<scale>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	fcvtzs	x2, d0
               	add	x1, x1, x2
               	str	x1, [x0]
               	fmov	d1, #0.50000000
               	fmul	d0, d0, d1
               	ret

<fma_constant>:
               	stp	d8, d9, [sp, #-0x30]!
               	str	d10, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	fmov	d8, d0
               	fmov	d9, d1
               	fmov	d0, d8
               	bl	<addr>
               	fmov	d10, d0
               	fmov	d0, d9
               	bl	<addr>
               	fadd	d0, d10, d0
               	fmov	d1, #2.00000000
               	fmadd	d0, d8, d1, d0
               	fcvtzs	x0, d0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret

<promoted_constant>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	add	x0, x0, x21
               	mov	x1, #0x5                // =5
               	madd	x0, x1, x20, x0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<phi_income>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x3
               	b.le	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>

<returned_constant>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret

<wide_constant>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	bl	<addr>
               	mov	x17, #0x89ab            // =35243
               	movk	x17, #0x4567, lsl #16
               	movk	x17, #0x123, lsl #32
               	eor	x0, x0, x17
               	mov	x17, #0x789a            // =30874
               	movk	x17, #0x3456, lsl #16
               	movk	x17, #0x12, lsl #32
               	add	x0, x0, x17
               	ldp	x29, x30, [sp], #0x10
               	ret

<f32_constant>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	fcvt	d0, s0
               	bl	<addr>
               	fcvt	s1, d0
               	fmov	s0, #2.50000000
               	fmadd	s0, s1, s0, s0
               	ldp	x29, x30, [sp], #0x10
               	ret

<address_constant>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, x20
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x8
               	ldr	x2, [x1]
               	ldr	x3, [x1, #0x8]
               	add	x2, x2, x3
               	add	x2, x2, x20
               	add	x0, x2, x0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x8
               	cmp	x1, x2
               	cset	x1, eq
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<function_address>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<in_loop>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x22, x0
               	mov	x20, #0x0               // =0
               	mov	x21, x20
               	cmp	x20, x22
               	b.ge	<addr>
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x3
               	add	x21, x21, x0
               	add	x20, x20, #0x1
               	cmp	x20, x22
               	b.lt	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<two_runs>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, #0x9
               	bl	<addr>
               	add	x0, x0, #0x9
               	bl	<addr>
               	add	x0, x0, #0x9
               	bl	<addr>
               	add	x0, x0, #0x9
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	scvtf	d0, x1
               	ldr	x0, [x0, #0x8]
               	scvtf	d1, x0
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x1f
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x20]
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x28]
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	bl	<addr>
               	mov	x17, #0x242             // =578
               	movk	x17, #0x79be, lsl #16
               	movk	x17, #0x135, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x38]
               	scvtf	s0, x0
               	bl	<addr>
               	fmov	s1, #7.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x40]
               	bl	<addr>
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x48]
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x50]
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x58]
               	bl	<addr>
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x74
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
