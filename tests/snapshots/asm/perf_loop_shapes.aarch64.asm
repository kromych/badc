
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
               	mov	x2, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	sxtw	x3, w0
               	ldrb	w3, [x2, x3]
               	cbnz	x3, <addr>
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<partition>:
               	mov	x2, x0
               	mov	x1, #0x0                // =0
               	mov	x0, #0x8                // =8
               	b	<addr>
               	b	<addr>
               	add	x1, x1, #0x1
               	sxtw	x4, w1
               	ldrsw	x3, [x2, x4, lsl #2]
               	cmp	w3, #0x4
               	b.lt	<addr>
               	b	<addr>
               	sub	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x2, x3, lsl #2]
               	cmp	w5, #0x4
               	b.gt	<addr>
               	cmp	w1, w0
               	b.gt	<addr>
               	ldrsw	x5, [x2, x4, lsl #2]
               	ldrsw	x6, [x2, x3, lsl #2]
               	str	w6, [x2, x4, lsl #2]
               	str	w5, [x2, x3, lsl #2]
               	add	x1, x1, #0x1
               	sub	x0, x0, #0x1
               	b	<addr>
               	cmp	w1, w0
               	b.le	<addr>
               	ret

<fib>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	sxtw	x20, w20
               	mov	x21, #0x0               // =0
               	b	<addr>
               	sub	x0, x20, #0x1
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x20, #0x2
               	sxtw	x20, w0
               	add	x21, x21, x1
               	cmp	x20, #0x2
               	b.ge	<addr>
               	add	x0, x21, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret

<digit_power_sums>:
               	mov	x14, x1
               	mov	x3, #0x0                // =0
               	mov	x10, #0xa               // =10
               	mov	x11, #0x6667            // =26215
               	movk	x11, #0x6666, lsl #16
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x13, x3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x3
               	b	<addr>
               	sxtw	x4, w1
               	mul	x6, x4, x11
               	asr	x2, x6, #34
               	lsr	x7, x2, #63
               	add	x8, x2, x7
               	mul	x9, x8, x10
               	sub	x9, x4, x9
               	sxtw	x9, w9
               	ldrsw	x9, [x5, x9, lsl #2]
               	add	x0, x0, x9
               	cmp	w0, w3
               	b.gt	<addr>
               	mov	x1, x8
               	cmp	w1, #0x0
               	b.gt	<addr>
               	cmp	w0, w3
               	cset	x0, eq
               	cbz	x0, <addr>
               	add	x13, x13, #0x1
               	ldr	x0, [x14]
               	sxtw	x1, w3
               	add	x0, x0, x1
               	str	x0, [x14]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	add	x3, x3, #0x1
               	cmp	w3, #0xfa0
               	b.lt	<addr>
               	mov	x0, x13
               	ret

<lcg>:
               	mov	x2, x1
               	mov	x1, #0x3039             // =12345
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3039             // =12345
               	mov	x4, #0x4e6d             // =20077
               	movk	x4, #0x41c6, lsl #16
               	b	<addr>
               	mul	x1, x1, x4
               	mov	w1, w1
               	add	x1, x1, x3
               	mov	w1, w1
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<lcg_wide>:
               	mov	x1, #0x3039             // =12345
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3039             // =12345
               	mov	x3, #0x4e6d             // =20077
               	movk	x3, #0x41c6, lsl #16
               	b	<addr>
               	mul	x1, x1, x3
               	add	x1, x1, x2
               	mov	w1, w1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3e8
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<sieve>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x2, x0
               	mov	x1, #0x2                // =2
               	b	<addr>
               	ldrb	w0, [x2, x0]
               	cbnz	x0, <addr>
               	mul	x0, x1, x1
               	b	<addr>
               	sxtw	x3, w0
               	mov	x4, #0x1                // =1
               	strb	w4, [x2, x3]
               	add	x0, x0, x1
               	cmp	w0, #0x3e8
               	b.lt	<addr>
               	add	x1, x1, #0x1
               	sxtw	x0, w1
               	mul	x3, x0, x0
               	cmp	x3, #0x3e8
               	b.lt	<addr>
               	add	x0, x2, #0x2
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
               	sxtw	x0, w0
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
               	sxtw	x0, w0
               	ret

<mid>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	lsr	x1, x0, #63
               	add	x0, x0, x1
               	asr	x0, x0, #1
               	sxtw	x0, w0
               	ret

<both>:
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w1, #0x7
               	cset	x0, lt
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<square_at>:
               	sxtw	x1, w1
               	ldrsw	x2, [x0, x1, lsl #2]
               	mul	x0, x2, x2
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
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
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x38
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x21, x29, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x21, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x21, #0x18]
               	ldrb	w10, [x0, #0x20]
               	strb	w10, [x21, #0x20]
               	ldrb	w10, [x0, #0x21]
               	strb	w10, [x21, #0x21]
               	ldrb	w10, [x0, #0x22]
               	strb	w10, [x21, #0x22]
               	ldrb	w10, [x0, #0x23]
               	strb	w10, [x21, #0x23]
               	ldr	x10, [sp], #0x10
               	mov	x20, #0x0               // =0
               	mov	x2, #0x8                // =8
               	mov	x3, #0x4                // =4
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	ldrsw	x0, [x21, x0, lsl #2]
               	cmp	w0, #0x4
               	cset	x0, le
               	cbz	x0, <addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x9
               	b.lt	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	ldrsw	x0, [x21, x0, lsl #2]
               	cmp	w0, #0x4
               	b.lt	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x9
               	b.lt	<addr>
               	mov	x0, #0xf                // =15
               	bl	<addr>
               	cmp	x0, #0x262
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #-0x3               // =-3
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0xfa0              // =4000
               	sub	x1, x29, #0x8
               	bl	<addr>
               	cmp	x0, #0x3
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0xd6c
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x3039             // =12345
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x17, #0x3039            // =12345
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x20, #0x3039            // =12345
               	mov	x21, #0x3e8             // =1000
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	mov	w0, w0
               	cmp	x22, x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3e8              // =1000
               	bl	<addr>
               	cmp	x0, #0xa8
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #-0x25              // =-37
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #-0x80000000        // =-2147483648
               	bl	<addr>
               	mov	x17, #-0xcccc           // =-52428
               	movk	x17, #0xf333, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #-0x25              // =-37
               	bl	<addr>
               	mov	x17, #-0x7              // =-7
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x28               // =40
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #-0x3               // =-3
               	mov	x1, #-0x4               // =-4
               	bl	<addr>
               	mov	x17, #-0x3              // =-3
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x7fffffff         // =2147483647
               	mov	x1, #-0x1               // =-1
               	bl	<addr>
               	mov	x17, #0x3fffffff        // =1073741823
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
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
               	mov	x2, x0
               	sub	x0, x29, #0x30
               	ldrsw	x1, [x0, #0x20]
               	mul	x0, x1, x1
               	cmp	x2, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
