
fp_const_forms.aarch64:	file format elf64-littleaarch64

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

<pass>:
               	ret

<passf>:
               	ret

<mix>:
               	fmov	d3, #4.00000000
               	fcvt	d1, s1
               	fmadd	d0, d0, d3, d1
               	fadd	d0, d0, d2
               	ret

<ret_milli>:
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	ret

<ret_hundred>:
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x16
               	ret

<ret_tenth_f>:
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x38]
               	ret

<ret_neg_zero>:
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	ret

<pick>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	fmov	d0, #2.50000000
               	ret
               	adrp	x17, <page>
               	ldr	d0, [x17]
               	b	<addr>

<pickf>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	fmov	s0, #-0.25000000
               	ret
               	adrp	x17, <page>
               	ldr	s0, [x17, #0x3c]
               	b	<addr>

<store_all>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	xzr, [x0]
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	str	d0, [x0, #0x8]
               	fmov	d0, #1.50000000
               	str	d0, [x0, #0x10]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	str	d0, [x0, #0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	wzr, [x0]
               	fmov	s0, #-2.50000000
               	str	s0, [x0, #0x4]
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x40]
               	str	s0, [x0, #0x8]
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x38]
               	str	s0, [x0, #0xc]
               	ret

<loop_calls>:
               	stp	d8, d9, [sp, #-0x30]!
               	str	x20, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	movi	d8, #0000000000000000
               	fmov	d9, #0.50000000
               	fmov	d0, #0.25000000
               	bl	<addr>
               	fmadd	d8, d8, d9, d0
               	fmov	d0, d8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x3
               	b.lt	<addr>
               	fmov	d0, d8
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d0, #-1.00000000
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d8, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s9, [x0]
               	movi	d0, #0000000000000000
               	fmul	d1, d8, d0
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d2, x16
               	fmul	d2, d8, d2
               	stur	d1, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	cbnz	x0, <addr>
               	fmov	d3, #1.00000000
               	fdiv	d1, d3, d1
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	stur	d2, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.ne	<addr>
               	fdiv	d1, d3, d2
               	fcmp	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	bl	<addr>
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x16, #0x80000000        // =2147483648
               	fmov	s0, w16
               	fmul	s0, s9, s0
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d0, #2.50000000
               	fmul	d1, d8, d0
               	fcmp	d1, d0
               	b.ne	<addr>
               	fmov	d0, #-2.50000000
               	fmul	d0, d8, d0
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #-0x3ffc000000000000 // =-4610560118520545280
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d0, #31.00000000
               	fmov	d1, #0.12500000
               	fnmsub	d0, d8, d0, d1
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	s0, #2.50000000
               	fmul	s1, s9, s0
               	fcmp	s1, s0
               	b.ne	<addr>
               	fmov	s0, #-0.25000000
               	fmul	s0, s9, s0
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xbe800000        // =3196059648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	s0, #0.12500000
               	fmov	s1, #1.00000000
               	fmadd	s0, s9, s0, s1
               	fmov	s1, #1.12500000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	bl	<addr>
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmul	d0, d8, d1
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x16, #0x4090000000000000 // =4652218415073722368
               	fmov	d0, x16
               	fmul	d0, d8, d0
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x4090000000000000 // =4652218415073722368
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmul	d0, d8, d1
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x18]
               	bl	<addr>
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x999a            // =39322
               	movk	x17, #0x9999, lsl #16
               	movk	x17, #0x9999, lsl #32
               	movk	x17, #0x3fb9, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	bl	<addr>
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0x3dcc, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x38]
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x38]
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x20]
               	fmul	d0, d8, d0
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x2d18            // =11544
               	movk	x17, #0x5444, lsl #16
               	movk	x17, #0x21fb, lsl #32
               	movk	x17, #0x4009, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x3c]
               	fmul	s0, s9, s0
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xfd0             // =4048
               	movk	x17, #0x4049, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x40]
               	fmul	s0, s9, s0
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x2400            // =9216
               	movk	x17, #0x4974, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x28]
               	fmul	d0, d8, d0
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x848000000000    // =145685290680320
               	movk	x17, #0x412e, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x30]
               	bl	<addr>
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0x3dcc, lsl #16
               	cmp	x0, x17
               	b.ne	<addr>
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x38]
               	bl	<addr>
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0x3dcc, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	bl	<addr>
               	fmov	s1, #-0.25000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x0
               	cset	x0, eq
               	bl	<addr>
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xfd0             // =4048
               	movk	x17, #0x4049, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d0, #0.50000000
               	fmov	s1, #0.75000000
               	adrp	x16, <page>
               	ldr	d2, [x16]
               	bl	<addr>
               	fmov	d9, d0
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	bl	<addr>
               	fmov	d1, #2.75000000
               	fadd	d0, d1, d0
               	fcmp	d9, d0
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d0, #0.50000000
               	fmov	d1, #0.25000000
               	fmadd	d0, d8, d0, d1
               	fmov	d1, #0.12500000
               	fmadd	d0, d0, d8, d1
               	fmul	d0, d0, d8
               	fmov	d1, #0.87500000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x8]
               	stur	d0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x10]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	ldr	d0, [x0, #0x10]
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x18]
               	stur	d0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x3333            // =13107
               	movk	x17, #0x3333, lsl #16
               	movk	x17, #0x3333, lsl #32
               	movk	x17, #0x3fd3, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	cbnz	w1, <addr>
               	ldr	s0, [x0, #0x4]
               	fmov	s1, #-2.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	ldr	s0, [x0, #0x8]
               	stur	s0, [x29, #-0x8]
               	ldur	w1, [x29, #-0x8]
               	mov	x17, #0x2400            // =9216
               	movk	x17, #0x4974, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	s0, [x0, #0xc]
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xcccd            // =52429
               	movk	x17, #0x3dcc, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	fmov	d1, #0.43750000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	d8, d9, [sp], #0x30
               	ret
