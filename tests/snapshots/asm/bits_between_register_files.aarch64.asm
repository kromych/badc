
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
               	ldr	d1, [x0, x2, lsl #3]
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1a0
               	str	d8, [sp]
               	stp	x20, x21, [sp, #0x10]
               	str	x22, [sp, #0x20]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x38]
               	stur	d0, [x29, #-0xf8]
               	ldur	d8, [x29, #-0xf8]
               	sub	x20, x29, #0x158
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x20]
               	sub	x21, x29, #0x150
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x21]
               	sub	x22, x29, #0x130
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
               	sub	x4, x29, #0x150
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
               	stur	d0, [x29, #-0xf0]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0xf0
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x100]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	stur	d8, [x29, #-0xe8]
               	sub	x1, x29, #0x100
               	sub	x2, x29, #0xe8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x100]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x3fffffffffffffff // =-4611686018427387903
               	bl	<addr>
               	stur	d0, [x29, #-0xe0]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0xe0
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x100]
               	mov	x17, #-0x3fffffffffffffff // =-4611686018427387903
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x148
               	mov	x1, #0x123              // =291
               	movk	x1, #0x7ff8, lsl #48
               	bl	<addr>
               	ldr	d0, [sp, #0x58]
               	stur	d0, [x29, #-0xd8]
               	sub	x0, x29, #0x100
               	sub	x1, x29, #0xd8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x100]
               	mov	x17, #0x123             // =291
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x140
               	fmov	d0, d8
               	bl	<addr>
               	ldr	x0, [sp, #0x60]
               	stur	d8, [x29, #-0xd0]
               	sub	x1, x29, #0x100
               	sub	x2, x29, #0xd0
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x100]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	stur	d8, [x29, #-0xc8]
               	sub	x1, x29, #0x100
               	sub	x2, x29, #0xc8
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldur	x1, [x29, #-0x100]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x120
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x16, [x1, #0x20]
               	str	x16, [x0, #0x20]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	stur	x0, [x29, #-0xc0]
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0xc0
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	stur	d0, [x29, #-0xb8]
               	sub	x1, x29, #0xb8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	fmov	d0, x1
               	ldr	d1, [sp, #0x80]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0xb0]
               	sub	x1, x29, #0xb0
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	stur	x1, [x29, #-0xa8]
               	sub	x1, x29, #0xa8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	fmov	x1, d0
               	eor	x1, x1, #0x10000000000
               	stur	x1, [x29, #-0xa0]
               	sub	x1, x29, #0xa0
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	stur	d0, [x29, #-0x98]
               	sub	x1, x29, #0x98
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	fmov	d0, x1
               	ldr	d1, [sp, #0x88]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x90]
               	sub	x1, x29, #0x90
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	stur	x1, [x29, #-0x88]
               	sub	x1, x29, #0x88
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	fmov	x1, d0
               	eor	x1, x1, #0x20000000000
               	stur	x1, [x29, #-0x80]
               	sub	x1, x29, #0x80
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	stur	d0, [x29, #-0x78]
               	sub	x1, x29, #0x78
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	fmov	d0, x1
               	ldr	d1, [sp, #0x90]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x70]
               	sub	x1, x29, #0x70
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	stur	x1, [x29, #-0x68]
               	sub	x1, x29, #0x68
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	fmov	x1, d0
               	eor	x1, x1, #0x30000000000
               	stur	x1, [x29, #-0x60]
               	sub	x1, x29, #0x60
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	stur	d0, [x29, #-0x58]
               	sub	x1, x29, #0x58
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	fmov	d0, x1
               	ldr	d1, [sp, #0x98]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x50]
               	sub	x1, x29, #0x50
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	stur	x1, [x29, #-0x48]
               	sub	x1, x29, #0x48
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	d0, [sp, #0x68]
               	fmov	x0, d0
               	eor	x0, x0, #0x40000000000
               	stur	x0, [x29, #-0x40]
               	sub	x1, x29, #0x138
               	sub	x0, x29, #0x40
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	d0, [sp, #0x68]
               	stur	d0, [x29, #-0x38]
               	sub	x0, x29, #0x38
               	ldr	x16, [x0]
               	str	x16, [x1]
               	ldr	x0, [sp, #0x68]
               	fmov	d0, x0
               	sub	x0, x29, #0x120
               	ldur	d1, [x29, #-0x100]
               	fadd	d0, d0, d1
               	stur	d0, [x29, #-0x30]
               	sub	x2, x29, #0x30
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x2, [sp, #0x68]
               	stur	x2, [x29, #-0x28]
               	sub	x2, x29, #0x28
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	d16, [sp, #0x68]
               	str	d16, [sp, #0x38]
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	stur	d0, [x29, #-0x20]
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x20
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x1, [sp, #0x68]
               	ldr	d16, [sp, #0x38]
               	stur	d16, [x29, #-0x18]
               	sub	x2, x29, #0x18
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldr	x0, [sp, #0x68]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	stur	d8, [x29, #-0x10]
               	sub	x1, x29, #0x138
               	sub	x2, x29, #0x10
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldr	x1, [sp, #0x68]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x7fffffffffffffff // =-9223372036854775807
               	bl	<addr>
               	stur	d0, [x29, #-0x8]
               	sub	x0, x29, #0x138
               	sub	x1, x29, #0x8
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	x0, [sp, #0x68]
               	mov	x17, #-0x7fffffffffffffff // =-9223372036854775807
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #-1.50000000
               	bl	<addr>
               	mov	x17, #0xbfc00000        // =3217031168
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x22, [sp, #0x20]
               	ldp	x20, x21, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x1a0
               	ldp	x29, x30, [sp], #0x10
               	ret
