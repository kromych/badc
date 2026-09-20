
perf_loop_shapes.aarch64:	file format elf64-littleaarch64

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

<count_zero>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrb	w4, [x3, x0]
               	cbnz	w4, <addr>
               	add	x2, x2, #0x1
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<partition>:
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	b	<addr>
               	add	x1, x1, #0x1
               	ldrsw	x3, [x0, w1, sxtw #2]
               	cmp	w3, #0x4
               	b.lt	<addr>
               	ldrsw	x3, [x0, w2, sxtw #2]
               	cmp	w3, #0x4
               	b.le	<addr>
               	sub	x2, x2, #0x1
               	ldrsw	x3, [x0, w2, sxtw #2]
               	cmp	w3, #0x4
               	b.gt	<addr>
               	cmp	w1, w2
               	b.gt	<addr>
               	ldrsw	x3, [x0, w1, sxtw #2]
               	ldrsw	x4, [x0, w2, sxtw #2]
               	str	w4, [x0, w1, sxtw #2]
               	str	w3, [x0, w2, sxtw #2]
               	add	x1, x1, #0x1
               	sub	x2, x2, #0x1
               	cmp	w1, w2
               	b.le	<addr>
               	ret

<fib>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	sxtw	x20, w0
               	mov	x21, #0x0               // =0
               	cmp	w20, #0x2
               	b.lt	<addr>
               	sub	x0, x20, #0x1
               	bl	<addr>
               	sub	x20, x20, #0x2
               	add	x21, x21, x0
               	cmp	w20, #0x2
               	b.ge	<addr>
               	add	x0, x21, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<digit_power_sums>:
               	mov	x3, #0x0                // =0
               	mov	x5, #0xa                // =10
               	mov	x6, #0x999a             // =39322
               	movk	x6, #0x1999, lsl #16
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mov	x9, x3
               	mov	x2, #0x0                // =0
               	mov	x0, x3
               	cmp	w0, #0x0
               	b.le	<addr>
               	mul	x4, x0, x6
               	lsr	x4, x4, #32
               	mul	x8, x4, x5
               	sub	x8, x0, x8
               	ldrsw	x8, [x7, x8, lsl #2]
               	add	x2, x2, x8
               	cmp	w2, w3
               	b.gt	<addr>
               	mov	x0, x4
               	cmp	w0, #0x0
               	b.gt	<addr>
               	cmp	w2, w3
               	b.ne	<addr>
               	add	x9, x9, #0x1
               	ldr	x0, [x1]
               	add	x0, x0, x3
               	str	x0, [x1]
               	add	x3, x3, #0x1
               	cmp	w3, #0xfa0
               	b.lt	<addr>
               	mov	x0, x9
               	ret

<lcg>:
               	mov	x0, #0x3039             // =12345
               	mov	x2, #0x0                // =0
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	cmp	w2, w1
               	b.ge	<addr>
               	mul	x0, x0, x4
               	add	x0, x0, x3
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	ret

<lcg_wide>:
               	mov	x0, #0x3039             // =12345
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3039             // =12345
               	mov	x3, #0x4e6d             // =20077
               	movk	x3, #0x41c6, lsl #16
               	mul	x0, x0, x3
               	add	x0, x0, x2
               	mov	w0, w0
               	add	x1, x1, #0x1
               	cmp	w1, #0x3e8
               	b.lt	<addr>
               	ret

<sieve>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, #0x2                // =2
               	sxtw	x1, w2
               	ldrb	w1, [x0, x1]
               	cbnz	w1, <addr>
               	mul	x1, x2, x2
               	cmp	w1, #0x3e8
               	b.ge	<addr>
               	mov	x3, #0x1                // =1
               	strb	w3, [x0, w1, sxtw]
               	add	x1, x1, x2
               	cmp	w1, #0x3e8
               	b.lt	<addr>
               	add	x2, x2, #0x1
               	sxtw	x1, w2
               	mul	x3, x1, x1
               	cmp	x3, #0x3e8
               	b.lt	<addr>
               	add	x0, x0, #0x2
               	mov	x1, #0x3e6              // =998
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<tenth>:
               	sxtw	x0, w0
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x0, x0, x17
               	asr	x0, x0, #34
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	ret

<last_digit>:
               	sxtw	x0, w0
               	mov	x17, #0x6667            // =26215
               	movk	x17, #0x6666, lsl #16
               	mul	x1, x0, x17
               	asr	x1, x1, #34
               	lsr	x2, x1, #63
               	add	x1, x1, x2
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	sub	x0, x0, x1
               	ret

<mid>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	ret

<both>:
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w1, #0x7
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<square_at>:
               	sxtw	x1, w1
               	ldrsw	x0, [x0, w1, sxtw #2]
               	mul	x0, x0, x0
               	ret

<negi>:
               	neg	x0, x0
               	ret

<negl>:
               	neg	x0, x0
               	ret

<negu>:
               	neg	x0, x0
               	ret

<negneg>:
               	neg	x0, x0
               	neg	x0, x0
               	ret

<sub_of_neg>:
               	mov	x0, #0x7                // =7
               	ret

<add_of_neg>:
               	mov	x0, #-0x1               // =-1
               	ret

<neg_minus_one>:
               	mvn	x0, x0
               	ret

<zero_minus>:
               	neg	x0, x0
               	ret

<times_minus_one>:
               	neg	x0, x0
               	ret

<pos>:
               	ret

<guarded_negate>:
               	cmp	x0, #0x0
               	neg	x0, x1
               	b.le	<addr>
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	sub	x20, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x20, #0x18]
               	ldrb	w10, [x0, #0x20]
               	strb	w10, [x20, #0x20]
               	ldrb	w10, [x0, #0x21]
               	strb	w10, [x20, #0x21]
               	ldrb	w10, [x0, #0x22]
               	strb	w10, [x20, #0x22]
               	ldrb	w10, [x0, #0x23]
               	strb	w10, [x20, #0x23]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	mov	x2, #0x8                // =8
               	mov	x3, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldrsw	x1, [x20, x0, lsl #2]
               	cmp	w1, #0x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.lt	<addr>
               	cmp	w0, #0x9
               	b.ge	<addr>
               	ldrsw	x1, [x20, x0, lsl #2]
               	cmp	w1, #0x4
               	b.lt	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.lt	<addr>
               	mov	x0, #0xf                // =15
               	bl	<addr>
               	cmp	x0, #0x262
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	stur	xzr, [x29, #-0x8]
               	mov	x0, #0xfa0              // =4000
               	sub	x1, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xd6c
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3039             // =12345
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0x3039            // =12345
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3039             // =12345
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x3039             // =12345
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	cmp	w20, w0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	cmp	x0, #0xa8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x25              // =-37
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	cmp	w0, #0x9
               	b.ne	<addr>
               	mov	x0, #-0x80000000        // =-2147483648
               	bl	<addr>
               	mov	x17, #-0xcccc           // =-52428
               	movk	x17, #0xf333, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x25              // =-37
               	bl	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x28               // =40
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x3               // =-3
               	mov	x1, #-0x4               // =-4
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x7fffffff         // =2147483647
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	mov	x17, #0x3fffffff        // =1073741823
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x2, x0
               	sub	x0, x29, #0x30
               	ldrsw	x1, [x0]
               	mul	x1, x1, x1
               	cmp	x2, x1
               	b.ne	<addr>
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sub	x1, x29, #0x30
               	ldrsw	x1, [x1, #0x20]
               	mul	x1, x1, x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #-0x7               // =-7
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #-0x7               // =-7
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x17, #0xffffffff        // =4294967295
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x80000000         // =2147483648
               	bl	<addr>
               	mov	x17, #0x80000000        // =2147483648
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x80000000        // =-2147483648
               	bl	<addr>
               	mov	x17, #-0x80000000       // =-2147483648
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x17, #-0x6              // =-6
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #-0x1               // =-1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x17, #-0x5              // =-5
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x17, #-0x5              // =-5
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #-0x7               // =-7
               	bl	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #-0x1               // =-1
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #-0x5               // =-5
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
