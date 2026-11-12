
bits_between_register_files.aarch64:	file format elf64-littleaarch64

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

<pair>:
               	ldr	d0, [x1]
               	ldr	d1, [x2]
               	add	v2.8b, v0.8b, v1.8b
               	sub	v0.8b, v0.8b, v1.8b
               	str	d2, [x0]
               	str	d0, [x0, #0x8]
               	ret

<flip>:
               	fmov	x0, d0
               	eor	x0, x0, #0x8000000000000000
               	fmov	d0, x0
               	ret

<bits>:
               	fmov	x0, d0
               	ret

<from>:
               	fmov	d0, x0
               	ret

<store_from>:
               	str	x1, [x0]
               	ret

<store_bits>:
               	str	d0, [x0]
               	ret

<cast_bits>:
               	fmov	x0, d0
               	ret

<mix>:
               	mov	x3, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x0                // =0
               	cmp	w2, w1
               	b.ge	<addr>
               	eor	x3, x3, x2, lsl #40
               	fmov	d0, x3
               	add	x3, x0, x2, lsl #3
               	ldr	d1, [x3]
               	fadd	d0, d0, d1
               	fmov	x3, d0
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	fmov	d0, x3
               	ret

<copy_bits>:
               	fmov	x0, d0
               	ret

<copy_from>:
               	fmov	d0, x0
               	ret

<copy_float_bits>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0xb0]!
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x38]
               	stur	d0, [x29, #-0x10]
               	ldur	d8, [x29, #-0x10]
               	sub	x20, x29, #0x70
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x20]
               	sub	x21, x29, #0x68
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x21]
               	sub	x22, x29, #0x48
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	add	x2, x22, #0x8
               	ldrsb	x3, [x22, x0]
               	ldrsb	x1, [x20, x0]
               	ldrsb	x4, [x21, x0]
               	add	x4, x1, x4
               	sxtb	x4, w4
               	cmp	w3, w4
               	b.ne	<addr>
               	ldrsb	x3, [x2, x0]
               	sub	x4, x29, #0x68
               	ldrsb	x4, [x4, x0]
               	sub	x1, x1, x4
               	sxtb	x1, w1
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	fmov	d0, d8
               	bl	<addr>
               	fneg	d1, d8
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	bl	<addr>
               	movi	d1, #0000000000000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	fmov	d0, d1
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	stur	d8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x50]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	mov	x0, #-0x3fffffffffffffff // =-4611686018427387903
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #-0x3fffffffffffffff // =-4611686018427387903
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x123              // =291
               	movk	x1, #0x7ff8, lsl #48
               	bl	<addr>
               	ldur	d0, [x29, #-0x60]
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #0x123             // =291
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x58
               	fmov	d0, d8
               	bl	<addr>
               	ldur	x0, [x29, #-0x58]
               	stur	d8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x50]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	stur	d8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x3, [x29, #-0x50]
               	cmp	x0, x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x38
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x16, [x3, #0x20]
               	str	x16, [x0, #0x20]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	stur	x0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x50]
               	fmov	d0, x0
               	ldur	d1, [x29, #-0x38]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	fmov	x0, d0
               	eor	x0, x0, #0x10000000000
               	stur	x0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x50]
               	fmov	d0, x0
               	ldur	d1, [x29, #-0x30]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	fmov	x0, d0
               	eor	x0, x0, #0x20000000000
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	stur	d0, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x2, [x29, #-0x50]
               	fmov	d0, x2
               	ldur	d1, [x29, #-0x28]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x2, [x29, #-0x50]
               	stur	x2, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	fmov	x2, d0
               	eor	x2, x2, #0x30000000000
               	stur	x2, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x2, [x29, #-0x50]
               	fmov	d0, x2
               	ldur	d1, [x29, #-0x20]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x2, [x29, #-0x50]
               	stur	x2, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	fmov	x2, d0
               	eor	x2, x2, #0x40000000000
               	stur	x2, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	d0, [x29, #-0x50]
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x2, [x29, #-0x50]
               	fmov	d0, x2
               	ldur	d1, [x29, #-0x18]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x8]
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	d0, [x29, #-0x50]
               	fmov	x20, d0
               	sub	x0, x29, #0x38
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x2, [x29, #-0x50]
               	stur	x20, [x29, #-0x8]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x50]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	stur	d8, [x29, #-0x8]
               	sub	x1, x29, #0x50
               	sub	x2, x29, #0x8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x50]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	mov	x0, #-0x7fffffffffffffff // =-9223372036854775807
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x50
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x50]
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	fmov	s0, #-1.50000000
               	bl	<addr>
               	mov	x17, #0xbfc00000        // =3217031168
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp], #0xb0
               	ret
