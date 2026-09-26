
store_of_constant.aarch64:	file format elf64-littleaarch64

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

<put_fields>:
               	mov	x1, #0x17f              // =383
               	strb	w1, [x0, #0x1]
               	mov	x1, #0x2345             // =9029
               	movk	x1, #0x1, lsl #16
               	strh	w1, [x0, #0x2]
               	mov	x1, #0x1                // =1
               	movk	x1, #0x8000, lsl #16
               	str	w1, [x0, #0x4]
               	mov	x1, #-0x80000000        // =-2147483648
               	str	x1, [x0, #0x8]
               	ret

<put_q>:
               	mov	x2, #0x7fffffff         // =2147483647
               	str	x2, [x0]
               	mov	x2, #0x80000000         // =2147483648
               	str	x2, [x0, #0x8]
               	mov	x2, #-0x80000001        // =-2147483649
               	str	x2, [x0, #0x10]
               	str	xzr, [x0, #0x18]
               	ret

<put_at>:
               	mov	x2, #0xc3               // =195
               	strb	w2, [x0, x1]
               	ret

<put_at32>:
               	mov	x2, #-0x7               // =-7
               	str	w2, [x0, x1, lsl #2]
               	ret

<fill>:
               	mov	x1, #0x0                // =0
               	mov	x2, #-0x12c             // =-300
               	strh	w2, [x0, x1, lsl #1]
               	add	x1, x1, #0x1
               	cmp	w1, #0x5
               	b.lt	<addr>
               	ret

<put_volatile>:
               	mov	x2, #0xbeef             // =48879
               	movk	x2, #0xdead, lsl #16
               	str	w2, [x0]
               	str	wzr, [x0, #0x10]
               	ret

<put_packed>:
               	mov	x1, #-0x3               // =-3
               	stur	x1, [x0, #0x1]
               	mov	x1, #0x3344             // =13124
               	movk	x1, #0x1122, lsl #16
               	stur	w1, [x0, #0x9]
               	ret

<put_float>:
               	fmov	s1, #1.50000000
               	str	s1, [x0]
               	mov	x16, #0x80000000        // =2147483648
               	fmov	s1, w16
               	str	s1, [x0, #0x4]
               	str	xzr, [x1]
               	mov	x16, #-0x8000000000000000 // =-9223372036854775808
               	fmov	d0, x16
               	str	d0, [x1, #0x8]
               	ret

<both>:
               	mov	x2, x0
               	mov	x0, #0x9                // =9
               	str	x0, [x1]
               	str	x0, [x2]
               	ret

<touch>:
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ret

<slot>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #-0x5               // =-5
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<read_then_clear>:
               	ldrb	w2, [x0]
               	mov	x0, #0x0                // =0
               	strb	w0, [x1]
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xe0
               	sub	x0, x29, #0x78
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	sub	x0, x29, #0x78
               	ldrb	w1, [x0, #0x1]
               	eor	x1, x1, #0x7f
               	cbnz	w1, <addr>
               	ldrh	w1, [x0, #0x2]
               	mov	x17, #0x2345            // =9029
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldr	w1, [x0, #0x4]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x8000, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x8]
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldr	x16, [x1, #0x20]
               	str	x16, [x0, #0x20]
               	bl	<addr>
               	sub	x0, x29, #0x30
               	ldr	x1, [x0]
               	mov	x17, #0x7fffffff        // =2147483647
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x10]
               	mov	x17, #-0x80000001       // =-2147483649
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x0, [x0, #0x18]
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xd8
               	mov	x1, #-0x5555555555555556 // =-6148914691236517206
               	str	x1, [x0]
               	mov	x1, #0x3                // =3
               	stur	x1, [x29, #-0x8]
               	ldur	x1, [x29, #-0x8]
               	bl	<addr>
               	sub	x1, x29, #0xd8
               	ldrb	w0, [x1, #0x3]
               	mov	x17, #0xc3              // =195
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0xaa
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0xd8
               	add	x1, x0, #0x4
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cmp	w2, #0xaa
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	sub	x0, x29, #0xb8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	add	x0, x0, #0x8
               	ldur	x1, [x29, #-0x8]
               	neg	x1, x1
               	add	x1, x1, #0x2
               	bl	<addr>
               	ldursw	x0, [x29, #-0xb8]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	sub	x0, x29, #0xb8
               	ldrsw	x1, [x0, #0x4]
               	mov	x17, #-0x7              // =-7
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	sub	x0, x29, #0xa8
               	ldrsh	x1, [x0]
               	mov	x17, #-0x12c            // =-300
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsh	x1, [x0, #0x2]
               	mov	x17, #-0x12c            // =-300
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsh	x1, [x0, #0x4]
               	mov	x17, #-0x12c            // =-300
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsh	x1, [x0, #0x6]
               	mov	x17, #-0x12c            // =-300
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsh	x1, [x0, #0x8]
               	mov	x17, #-0x12c            // =-300
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrsh	x0, [x0, #0xa]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	sub	x0, x29, #0x60
               	ldr	w1, [x0]
               	mov	x17, #0xbeef            // =48879
               	movk	x17, #0xdead, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	w0, [x0, #0x10]
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x98
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldrb	w16, [x1, #0xc]
               	strb	w16, [x0, #0xc]
               	bl	<addr>
               	sub	x0, x29, #0x98
               	ldur	x1, [x0, #0x1]
               	mov	x17, #-0x3              // =-3
               	cmp	x1, x17
               	b.ne	<addr>
               	ldursw	x0, [x0, #0x9]
               	mov	x17, #0x3344            // =13124
               	movk	x17, #0x1122, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x88
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	sub	x1, x29, #0x48
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x1, #0x10]
               	bl	<addr>
               	sub	x0, x29, #0x88
               	ldr	s0, [x0]
               	stur	s0, [x29, #-0xc0]
               	ldur	w1, [x29, #-0xc0]
               	mov	x17, #0x3fc00000        // =1069547520
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	s0, [x0, #0x4]
               	stur	s0, [x29, #-0xc0]
               	ldur	w1, [x29, #-0xc0]
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	s0, [x0, #0x8]
               	fmov	s1, #9.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	d0, [x0]
               	stur	d0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xc0]
               	cbnz	x1, <addr>
               	ldr	d0, [x0, #0x8]
               	stur	d0, [x29, #-0xc0]
               	ldur	x1, [x29, #-0xc0]
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	d0, [x0, #0x10]
               	fmov	d1, #9.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	xzr, [x29, #-0xd0]
               	stur	xzr, [x29, #-0xc8]
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0xc8
               	bl	<addr>
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xd0]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xc8]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x17, #-0x4              // =-4
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	sturb	w0, [x29, #-0xc0]
               	sub	x0, x29, #0xc0
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	ldurb	w0, [x29, #-0xc0]
               	cbz	w0, <addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	mov	x1, x0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xe0
               	ldp	x29, x30, [sp], #0x10
               	ret
