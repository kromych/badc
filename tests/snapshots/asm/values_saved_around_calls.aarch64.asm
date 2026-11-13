
values_saved_around_calls.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	mov	x17, #0x5a5a            // =23130
               	eor	x0, x0, x17
               	ret

<scale>:
               	fmov	d1, #0.50000000
               	fmov	d2, #1.00000000
               	fmadd	d0, d0, d1, d2
               	ret

<swap>:
               	smov	x0, v0.s[3]
               	fmov	s1, w0
               	smov	x0, v0.s[2]
               	mov	v1.s[1], w0
               	smov	x0, v0.s[1]
               	mov	v1.s[2], w0
               	smov	x0, v0.s[0]
               	mov	v0.16b, v1.16b
               	mov	v0.s[3], w0
               	ret

<ints>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x6, x0
               	str	x1, [sp, #0x78]
               	mov	x20, #0x0               // =0
               	ldr	x0, [x6]
               	ldr	x5, [x6, #0x8]
               	ldr	x4, [x6, #0x10]
               	ldr	x3, [x6, #0x18]
               	ldr	x2, [x6, #0x20]
               	ldr	x28, [x6, #0x28]
               	ldr	x27, [x6, #0x30]
               	ldr	x26, [x6, #0x38]
               	ldr	x25, [x6, #0x40]
               	ldr	x24, [x6, #0x48]
               	ldr	x23, [x6, #0x50]
               	ldr	x22, [x6, #0x58]
               	ldr	x21, [x6, #0x60]
               	ldr	x6, [x6, #0x68]
               	b	<addr>
               	add	x20, x20, #0x1
               	ldr	x17, [sp, #0x78]
               	cmp	w20, w17
               	b.ge	<addr>
               	add	x0, x0, x20
               	eor	x5, x5, x0
               	add	x4, x4, x5
               	eor	x3, x3, x4
               	add	x2, x2, x3
               	eor	x28, x28, x2
               	add	x27, x27, x28
               	eor	x26, x26, x27
               	add	x25, x25, x26
               	eor	x24, x24, x25
               	add	x23, x23, x24
               	eor	x22, x22, x23
               	add	x21, x21, x22
               	eor	x6, x6, x21
               	and	x1, x20, #0x7
               	cbnz	w1, <addr>
               	str	x5, [sp, #0x50]
               	str	x4, [sp, #0x58]
               	str	x3, [sp, #0x60]
               	str	x2, [sp, #0x68]
               	str	x6, [sp, #0x70]
               	bl	<addr>
               	ldr	x5, [sp, #0x50]
               	ldr	x4, [sp, #0x58]
               	ldr	x3, [sp, #0x60]
               	ldr	x2, [sp, #0x68]
               	ldr	x6, [sp, #0x70]
               	b	<addr>
               	add	x0, x0, x5
               	add	x0, x0, x4
               	add	x0, x0, x3
               	add	x0, x0, x2
               	add	x0, x0, x28
               	add	x0, x0, x27
               	add	x0, x0, x26
               	add	x0, x0, x25
               	add	x0, x0, x24
               	add	x0, x0, x23
               	add	x0, x0, x22
               	add	x0, x0, x21
               	add	x0, x0, x6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret

<ints_ref>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x21, x1
               	ldr	x1, [x0]
               	stur	x1, [x29, #-0x70]
               	ldr	x1, [x0, #0x8]
               	stur	x1, [x29, #-0x68]
               	ldr	x1, [x0, #0x10]
               	stur	x1, [x29, #-0x60]
               	ldr	x1, [x0, #0x18]
               	stur	x1, [x29, #-0x58]
               	ldr	x1, [x0, #0x20]
               	stur	x1, [x29, #-0x50]
               	ldr	x1, [x0, #0x28]
               	stur	x1, [x29, #-0x48]
               	ldr	x1, [x0, #0x30]
               	stur	x1, [x29, #-0x40]
               	ldr	x1, [x0, #0x38]
               	stur	x1, [x29, #-0x38]
               	ldr	x1, [x0, #0x40]
               	stur	x1, [x29, #-0x30]
               	ldr	x1, [x0, #0x48]
               	stur	x1, [x29, #-0x28]
               	ldr	x1, [x0, #0x50]
               	stur	x1, [x29, #-0x20]
               	ldr	x1, [x0, #0x58]
               	stur	x1, [x29, #-0x18]
               	ldr	x1, [x0, #0x60]
               	stur	x1, [x29, #-0x10]
               	ldr	x0, [x0, #0x68]
               	stur	x0, [x29, #-0x8]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, w21
               	b.ge	<addr>
               	sub	x2, x29, #0x70
               	ldur	x0, [x29, #-0x70]
               	add	x0, x0, x20
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x1                // =1
               	b	<addr>
               	str	x3, [x2, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0xe
               	b.ge	<addr>
               	tbz	w0, #0x0, <addr>
               	ldr	x3, [x2, x0, lsl #3]
               	sub	x4, x0, #0x1
               	ldr	x4, [x2, x4, lsl #3]
               	eor	x3, x3, x4
               	b	<addr>
               	ldr	x3, [x2, x0, lsl #3]
               	sub	x4, x0, #0x1
               	ldr	x4, [x2, x4, lsl #3]
               	add	x3, x3, x4
               	b	<addr>
               	and	x0, x20, #0x7
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x70]
               	bl	<addr>
               	stur	x0, [x29, #-0x70]
               	b	<addr>
               	ldur	x0, [x29, #-0x70]
               	ldur	x1, [x29, #-0x68]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x60]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x58]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x50]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x48]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x40]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x38]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x30]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x28]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret

<doubles>:
               	stp	d8, d9, [sp, #-0x80]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x20, x21, [sp, #0x40]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x21, x1
               	mov	x20, #0x0               // =0
               	ldr	d0, [x0]
               	ldr	d2, [x0, #0x8]
               	ldr	d1, [x0, #0x10]
               	ldr	d15, [x0, #0x18]
               	ldr	d14, [x0, #0x20]
               	ldr	d13, [x0, #0x28]
               	ldr	d12, [x0, #0x30]
               	ldr	d11, [x0, #0x38]
               	ldr	d10, [x0, #0x40]
               	ldr	d9, [x0, #0x48]
               	ldr	d8, [x0, #0x50]
               	ldr	d3, [x0, #0x58]
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, w21
               	b.ge	<addr>
               	fmov	d4, #1.00000000
               	fadd	d0, d0, d4
               	fadd	d2, d2, d0
               	fadd	d1, d1, d2
               	fadd	d15, d15, d1
               	fadd	d14, d14, d15
               	fadd	d13, d13, d14
               	fadd	d12, d12, d13
               	fadd	d11, d11, d12
               	fadd	d10, d10, d11
               	fadd	d9, d9, d10
               	fadd	d8, d8, d9
               	fadd	d3, d3, d8
               	and	x0, x20, #0x3
               	cbnz	w0, <addr>
               	str	d2, [sp, #0x58]
               	str	d1, [sp, #0x60]
               	str	d3, [sp, #0x68]
               	bl	<addr>
               	ldr	d2, [sp, #0x58]
               	ldr	d1, [sp, #0x60]
               	ldr	d3, [sp, #0x68]
               	b	<addr>
               	fadd	d0, d0, d2
               	fadd	d0, d0, d1
               	fadd	d0, d0, d15
               	fadd	d0, d0, d14
               	fadd	d0, d0, d13
               	fadd	d0, d0, d12
               	fadd	d0, d0, d11
               	fadd	d0, d0, d10
               	fadd	d0, d0, d9
               	fadd	d0, d0, d8
               	fadd	d0, d0, d3
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp, #0x40]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x80
               	ret

<doubles_ref>:
               	stp	d8, d9, [sp, #-0x80]!
               	stp	d10, d11, [sp, #0x10]
               	stp	d12, d13, [sp, #0x20]
               	stp	d14, d15, [sp, #0x30]
               	stp	x20, x21, [sp, #0x40]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x21, x1
               	ldr	d0, [x0]
               	ldr	d8, [x0, #0x8]
               	ldr	d9, [x0, #0x10]
               	ldr	d10, [x0, #0x18]
               	ldr	d11, [x0, #0x20]
               	ldr	d12, [x0, #0x28]
               	ldr	d13, [x0, #0x30]
               	ldr	d14, [x0, #0x38]
               	ldr	d15, [x0, #0x40]
               	ldr	d1, [x0, #0x48]
               	ldr	d2, [x0, #0x50]
               	ldr	d3, [x0, #0x58]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, w21
               	b.ge	<addr>
               	fmov	d4, #1.00000000
               	fadd	d0, d0, d4
               	fadd	d8, d8, d0
               	fadd	d9, d9, d8
               	fadd	d10, d10, d9
               	fadd	d11, d11, d10
               	fadd	d12, d12, d11
               	fadd	d13, d13, d12
               	fadd	d14, d14, d13
               	fadd	d15, d15, d14
               	fadd	d1, d1, d15
               	fadd	d2, d2, d1
               	fadd	d3, d3, d2
               	and	x0, x20, #0x3
               	cbnz	w0, <addr>
               	str	d1, [sp, #0x68]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x58]
               	bl	<addr>
               	ldr	d1, [sp, #0x68]
               	ldr	d2, [sp, #0x60]
               	ldr	d3, [sp, #0x58]
               	b	<addr>
               	movi	d4, #0000000000000000
               	fadd	d0, d4, d0
               	fadd	d0, d0, d8
               	fadd	d0, d0, d9
               	fadd	d0, d0, d10
               	fadd	d0, d0, d11
               	fadd	d0, d0, d12
               	fadd	d0, d0, d13
               	fadd	d0, d0, d14
               	fadd	d0, d0, d15
               	fadd	d0, d0, d1
               	fadd	d0, d0, d2
               	fadd	d0, d0, d3
               	ldp	x29, x30, [sp, #0x70]
               	ldp	x20, x21, [sp, #0x40]
               	ldp	d14, d15, [sp, #0x30]
               	ldp	d12, d13, [sp, #0x20]
               	ldp	d10, d11, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x80
               	ret

<vectors>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x21, x0
               	stur	q0, [x29, #-0x30]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, w21
               	b.ge	<addr>
               	sub	x7, x29, #0x30
               	fmov	s0, w20
               	mov	x0, #0x1                // =1
               	mov	v0.s[1], w0
               	mov	x0, #0x2                // =2
               	mov	v0.s[2], w0
               	mov	x0, #0x3                // =3
               	mov	v0.s[3], w0
               	ldur	q3, [x29, #-0x30]
               	add	v0.4s, v3.4s, v0.4s
               	stur	q0, [x29, #-0x30]
               	eor	v1.16b, v1.16b, v0.16b
               	add	v2.4s, v2.4s, v1.4s
               	tbnz	w20, #0x0, <addr>
               	str	q1, [sp, #0x20]
               	str	q2, [sp, #0x30]
               	ldr	q0, [x7]
               	bl	<addr>
               	ldr	q1, [sp, #0x20]
               	ldr	q2, [sp, #0x30]
               	stur	q0, [x29, #-0x30]
               	b	<addr>
               	ldur	q0, [x29, #-0x30]
               	add	v0.4s, v0.4s, v1.4s
               	add	v0.4s, v0.4s, v2.4s
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	d8, [sp]
               	str	x20, [sp, #0x10]
               	mov	x0, #0x3e8              // =1000
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x40d              // =1037
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x432              // =1074
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x457              // =1111
               	stur	x0, [x29, #-0x60]
               	mov	x0, #0x47c              // =1148
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x4a1              // =1185
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x4c6              // =1222
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x4eb              // =1259
               	stur	x0, [x29, #-0x40]
               	mov	x0, #0x510              // =1296
               	stur	x0, [x29, #-0x38]
               	mov	x0, #0x535              // =1333
               	stur	x0, [x29, #-0x30]
               	mov	x0, #0x55a              // =1370
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0x57f              // =1407
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0x5a4              // =1444
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x5c9              // =1481
               	stur	x0, [x29, #-0x10]
               	stur	xzr, [x29, #-0xd8]
               	fmov	d0, #0.25000000
               	stur	d0, [x29, #-0xd0]
               	fmov	d0, #0.50000000
               	stur	d0, [x29, #-0xc8]
               	fmov	d0, #0.75000000
               	stur	d0, [x29, #-0xc0]
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0xb8]
               	fmov	d0, #1.25000000
               	stur	d0, [x29, #-0xb0]
               	fmov	d0, #1.50000000
               	stur	d0, [x29, #-0xa8]
               	fmov	d0, #1.75000000
               	stur	d0, [x29, #-0xa0]
               	fmov	d0, #2.00000000
               	stur	d0, [x29, #-0x98]
               	fmov	d0, #2.25000000
               	stur	d0, [x29, #-0x90]
               	fmov	d0, #2.50000000
               	stur	d0, [x29, #-0x88]
               	fmov	d0, #2.75000000
               	stur	d0, [x29, #-0x80]
               	mov	x0, #0x64               // =100
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x78
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x78
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xd8
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	fmov	d8, d0
               	sub	x0, x29, #0xd8
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	fcmp	d8, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x7, x29, #0x110
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x7]
               	sub	x1, x29, #0x100
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	sub	x2, x29, #0xf0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldursw	x0, [x29, #-0x8]
               	ldr	q0, [x7]
               	ldr	q1, [x1]
               	ldr	q2, [x2]
               	bl	<addr>
               	ldr	q1, [sp, #0x20]
               	ldur	q3, [x29, #-0x100]
               	ldur	q2, [x29, #-0xf0]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x0, x0, #0x1
               	ldursw	x1, [x29, #-0x8]
               	cmp	w0, w1
               	b.ge	<addr>
               	smov	x1, v1.s[0]
               	add	x1, x1, x0
               	mov	v4.16b, v1.16b
               	mov	v4.s[0], w1
               	smov	x2, v1.s[1]
               	add	x2, x2, #0x1
               	mov	v4.s[1], w2
               	smov	x3, v1.s[2]
               	add	x3, x3, #0x2
               	mov	v4.s[2], w3
               	smov	x4, v1.s[3]
               	add	x4, x4, #0x3
               	mov	v1.16b, v4.16b
               	mov	v1.s[3], w4
               	smov	x5, v3.s[0]
               	eor	x5, x5, x1
               	mov	v4.16b, v3.16b
               	mov	v4.s[0], w5
               	smov	x6, v3.s[1]
               	eor	x6, x6, x2
               	mov	v4.s[1], w6
               	smov	x7, v3.s[2]
               	eor	x7, x7, x3
               	mov	v4.s[2], w7
               	smov	x8, v3.s[3]
               	eor	x8, x8, x4
               	mov	v3.16b, v4.16b
               	mov	v3.s[3], w8
               	smov	x9, v2.s[0]
               	add	x5, x9, x5
               	mov	v4.16b, v2.16b
               	mov	v4.s[0], w5
               	smov	x5, v2.s[1]
               	add	x5, x5, x6
               	mov	v4.s[1], w5
               	smov	x5, v2.s[2]
               	add	x5, x5, x7
               	mov	v4.s[2], w5
               	smov	x5, v2.s[3]
               	add	x5, x5, x8
               	mov	v2.16b, v4.16b
               	mov	v2.s[3], w5
               	tbnz	w0, #0x0, <addr>
               	fmov	s1, w4
               	mov	v1.s[1], w3
               	mov	v1.s[2], w2
               	mov	v1.s[3], w1
               	b	<addr>
               	smov	x0, v0.s[0]
               	smov	x1, v1.s[0]
               	smov	x2, v3.s[0]
               	add	x1, x1, x2
               	smov	x2, v2.s[0]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	smov	x0, v0.s[1]
               	smov	x1, v1.s[1]
               	smov	x2, v3.s[1]
               	add	x1, x1, x2
               	smov	x2, v2.s[1]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	smov	x0, v0.s[2]
               	smov	x1, v1.s[2]
               	smov	x2, v3.s[2]
               	add	x1, x1, x2
               	smov	x2, v2.s[2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	smov	x0, v0.s[3]
               	smov	x1, v1.s[3]
               	smov	x2, v3.s[3]
               	add	x1, x1, x2
               	smov	x2, v2.s[3]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
