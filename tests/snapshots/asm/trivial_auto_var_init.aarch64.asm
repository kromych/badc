
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
               	sub	x1, x29, #0x2, lsl #12  // =0x2000
               	add	x2, x1, #0x2, lsl #12   // =0x2000
               	mov	x0, x1
               	cmp	x0, x2
               	b.hs	<addr>
               	str	xzr, [x0]
               	add	x0, x0, #0x8
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, #0x2000             // =8192
               	add	x3, x1, x0
               	mov	x4, #0xaa               // =170
               	strb	w4, [x3]
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lo	<addr>
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	ldp	x29, x30, [sp], #0x10
               	ret

<mismatches>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	x2, x1
               	b.hs	<addr>
               	add	x4, x3, x2
               	ldrb	w4, [x4]
               	cbz	w4, <addr>
               	add	x0, x0, #0x1
               	add	x2, x2, #0x1
               	cmp	x2, x1
               	b.lo	<addr>
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
               	stur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalar_float>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	wzr, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalar_long_double>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<scalar_int128>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	add	sp, sp, #0x10
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
               	add	sp, sp, #0x1, lsl #12   // =0x1000
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_bytes>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x0, w0
               	lsl	x1, x0, #3
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	add	x2, x1, #0x7
               	and	x2, x2, #0xfffffffffffffff8
               	add	x3, x0, x2
               	mov	x2, x0
               	cmp	x2, x3
               	b.hs	<addr>
               	str	xzr, [x2]
               	add	x2, x2, #0x8
               	cmp	x2, x3
               	b.lo	<addr>
               	bl	<addr>
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<vla_odd>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, #0x5                // =5
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	add	x3, x0, #0x8
               	mov	x2, x0
               	cmp	x2, x3
               	b.hs	<addr>
               	str	xzr, [x2]
               	add	x2, x2, #0x8
               	cmp	x2, x3
               	b.lo	<addr>
               	bl	<addr>
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<loop_block>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	x1, x1, #0x1
               	cmp	w1, #0x2
               	b.lt	<addr>
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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
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
               	mov	x0, #0x0                // =0
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
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
