
trivial_auto_var_init.aarch64:	file format elf64-littleaarch64

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

<dirty>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	x2, x29, #0x2, lsl #12  // =0x2000
               	add	x1, x2, #0x2, lsl #12   // =0x2000
               	mov	x0, x2
               	b	<addr>
               	mov	x3, #0x0                // =0
               	str	x3, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x1
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x2000             // =8192
               	b	<addr>
               	add	x4, x2, x1
               	mov	x5, #0xaa               // =170
               	strb	w5, [x4]
               	add	x0, x1, #0x1
               	mov	w1, w0
               	cmp	w1, w3
               	b.lo	<addr>
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	ldp	x29, x30, [sp], #0x10
               	ret

<mismatches>:
               	mov	x3, x0
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	add	x2, x3, x1
               	ldrb	w2, [x2]
               	cbz	x2, <addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	b	<addr>
               	b	<addr>
               	add	x1, x1, #0x1
               	cmp	x1, x4
               	b.lo	<addr>
               	sxtw	x0, w0
               	ret

<scalar_int>:
               	mov	x0, #0x0                // =0
               	ret

<scalar_short>:
               	mov	x0, #0x0                // =0
               	ret

<scalar_char>:
               	mov	x0, #0x0                // =0
               	ret

<scalar_long>:
               	mov	x0, #0x0                // =0
               	ret

<scalar_ptr>:
               	mov	x0, #0x0                // =0
               	ret

<scalar_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x8]
               	fmov	d16, x0
               	stur	d16, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalar_float>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x0                // =0
               	fmov	s16, w1
               	stur	s16, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalar_long_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalar_int128>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<array_sum>:
               	mov	x0, #0x0                // =0
               	ret

<array_bytes>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x1, #0x20               // =32
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<struct_bytes>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x4
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	add	x20, x20, x0
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	add	x0, x20, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<union_bytes>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<big_array>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	x0, x29, #0x1, lsl #12  // =0x1000
               	mov	x16, x0
               	mov	x17, #0x1000            // =4096
               	add	x17, x16, x17
               	stp	xzr, xzr, [x16, #0x10]
               	stp	xzr, xzr, [x16], #0x20
               	cmp	x16, x17
               	b.ne	<addr>
               	mov	x1, #0x1000             // =4096
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_bytes>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	lsl	x4, x0, #3
               	add	x17, x4, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	add	x0, x4, #0x7
               	and	x0, x0, #0xfffffffffffffff8
               	add	x2, x1, x0
               	mov	x0, x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	str	x3, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x0, x1
               	mov	x1, x4
               	bl	<addr>
               	sxtw	x0, w0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x4, #0x5                // =5
               	add	x17, x4, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	add	x2, x1, #0x8
               	mov	x0, x1
               	b	<addr>
               	mov	x3, #0x0                // =0
               	str	x3, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x0, x1
               	mov	x1, x4
               	bl	<addr>
               	sxtw	x0, w0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<loop_block>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x0, x2
               	b	<addr>
               	cbnz	x0, <addr>
               	b	<addr>
               	mov	x1, x2
               	b	<addr>
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	w0, #0x2
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<addressed_int>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<opted_out>:
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x21, #0x0               // =0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x0, #0x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	mov	x0, #0x25               // =37
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	mov	x0, x21
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	bl	<addr>
               	add	x20, x20, x0
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	add	x0, x20, x0
               	cmp	w0, #0x64
               	b.le	<addr>
               	mov	x0, #0x64               // =100
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	sxtw	x0, w0
               	b	<addr>
