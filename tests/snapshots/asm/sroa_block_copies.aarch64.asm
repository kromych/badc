
sroa_block_copies.aarch64:	file format elf64-littleaarch64

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

<from_ptr>:
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ret

<from_ptr_inl>:
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ret

<local_copy>:
               	add	x0, x0, x1
               	ret

<literal_ptr>:
               	mov	x2, #0x7                // =7
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	ret

<by_value>:
               	add	x0, x0, #0x1
               	ret

<nested>:
               	ldr	w1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldrb	w0, [x0, #0x18]
               	sxtw	x1, w1
               	add	x1, x2, x1
               	add	x0, x1, x0
               	ret

<union_one_width>:
               	ret

<union_two_widths>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x8
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x8]
               	ldr	x16, [x2]
               	str	x16, [x0]
               	ldur	x0, [x29, #-0x8]
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<bitfield_copy>:
               	and	x3, x1, #0xfff
               	lsl	x3, x3, #8
               	mov	x17, #0x8d              // =141
               	orr	x3, x3, x17
               	str	w3, [x0]
               	str	wzr, [x0, #0x4]
               	str	x1, [x0, #0x8]
               	ret

<padded_copy>:
               	and	x3, x1, #0xff
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	strb	w3, [x0]
               	strb	wzr, [x0, #0x1]
               	strh	wzr, [x0, #0x2]
               	str	wzr, [x0, #0x4]
               	str	x1, [x0, #0x8]
               	ret

<fam_copy>:
               	str	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ret

<self_assign>:
               	sub	x0, x0, x1
               	ret

<member_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x2, x29, #0x20
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	stur	x0, [x29, #-0x20]
               	stur	x1, [x29, #-0x18]
               	stur	x1, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	add	x0, x2, #0x10
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x20]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	ldur	x2, [x29, #-0x18]
               	add	x1, x1, x2
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<volatile_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	stur	x1, [x29, #-0x10]
               	add	x1, x1, #0x1
               	stur	x1, [x29, #-0x8]
               	ldr	x1, [x2]
               	ldr	x3, [x2, #0x8]
               	ldr	x4, [x2]
               	str	x4, [x0]
               	ldr	x2, [x2, #0x8]
               	str	x2, [x0, #0x8]
               	add	x0, x1, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<clobber>:
               	mov	x1, #-0x1               // =-1
               	str	x1, [x0]
               	mov	x1, #-0x2               // =-2
               	str	x1, [x0, #0x8]
               	ret

<escape_after_copy>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	stur	x1, [x29, #-0x10]
               	lsl	x1, x1, #1
               	stur	x1, [x29, #-0x8]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x20]
               	bl	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	ldr	x1, [x20]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<take>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<by_value_arg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	stur	x1, [x29, #-0x10]
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x8]
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_pair>:
               	mov	x1, #0x9                // =9
               	ret

<make_large>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x8, [x29, #-0x20]
               	sub	x1, x29, #0x18
               	stp	xzr, xzr, [x1]
               	str	xzr, [x1, #0x10]
               	stur	x0, [x29, #-0x18]
               	mov	x2, #0x1                // =1
               	stur	x2, [x29, #-0x10]
               	mov	x2, #0x2                // =2
               	stur	x2, [x29, #-0x8]
               	add	x0, x2, x0
               	stur	x0, [x29, #-0x8]
               	mov	x16, x1
               	ldur	x17, [x29, #-0x20]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<large_return_inlined>:
               	add	x0, x0, #0x3
               	add	x0, x0, #0x4
               	ret

<jump_back>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	brk	#0x1

<copy_across_setjmp>:
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x21, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	str	x21, [x20]
               	mov	x0, #0x5                // =5
               	str	x0, [x20, #0x8]
               	add	x0, x21, #0x5
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	bl	<addr>
               	brk	#0x1

<vla_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	add	x17, x1, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x2, sp
               	sub	x2, x2, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x2
               	sub	x1, x1, #0x1
               	mov	x3, #0x3                // =3
               	strb	w3, [x2, x1]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	ldrb	w1, [x2, x1]
               	add	x0, x0, x1
               	add	x0, x3, x0
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<big_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x3, x29, #0x80
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x3]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x3, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x3, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x3, #0x30]
               	ldp	x16, x17, [x1, #0x40]
               	stp	x16, x17, [x3, #0x40]
               	ldp	x16, x17, [x1, #0x50]
               	stp	x16, x17, [x3, #0x50]
               	ldp	x16, x17, [x1, #0x60]
               	stp	x16, x17, [x3, #0x60]
               	ldp	x16, x17, [x1, #0x70]
               	stp	x16, x17, [x3, #0x70]
               	stur	x2, [x29, #-0x68]
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x3, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x3, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x3, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x3, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	ldp	x16, x17, [x3, #0x50]
               	stp	x16, x17, [x0, #0x50]
               	ldp	x16, x17, [x3, #0x60]
               	stp	x16, x17, [x0, #0x60]
               	ldp	x16, x17, [x3, #0x70]
               	stp	x16, x17, [x0, #0x70]
               	ldr	x1, [x0, #0x18]
               	ldr	x0, [x0, #0x78]
               	add	x0, x1, x0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<array_member_copy>:
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	add	x1, x1, #0x5
               	str	x1, [x0, #0x8]
               	ret

<wide_copy>:
               	add	x3, x1, #0x1
               	str	x1, [x0]
               	str	xzr, [x0, #0x8]
               	str	xzr, [x0, #0x10]
               	str	xzr, [x0, #0x18]
               	str	xzr, [x0, #0x20]
               	str	xzr, [x0, #0x28]
               	str	xzr, [x0, #0x30]
               	str	xzr, [x0, #0x38]
               	str	xzr, [x0, #0x40]
               	str	xzr, [x0, #0x48]
               	str	xzr, [x0, #0x50]
               	str	xzr, [x0, #0x58]
               	str	xzr, [x0, #0x60]
               	str	xzr, [x0, #0x68]
               	str	xzr, [x0, #0x70]
               	str	x3, [x0, #0x78]
               	ret

<fp_copy>:
               	scvtf	d0, x1
               	fmov	d1, #0.50000000
               	str	d0, [x0]
               	str	d1, [x0, #0x8]
               	ret

<sub_object_copy>:
               	add	x2, x1, #0x2
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	ret

<chain_copy>:
               	str	x1, [x0]
               	str	x2, [x0, #0x8]
               	ret

<field_literals>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	wzr, [x29, #-0x8]
               	and	x1, x0, #0xff
               	stur	w1, [x29, #-0x8]
               	add	x0, x0, #0x1
               	ldur	w1, [x29, #-0x8]
               	and	w1, w1, #0xffff00ff
               	lsl	x0, x0, #8
               	and	x0, x0, #0xff00
               	orr	x0, x1, x0
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	and	w0, w0, #0xfffeffff
               	orr	x0, x0, #0x10000
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x290
               	stp	x20, x21, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	sub	x0, x29, #0x278
               	stp	xzr, xzr, [x0]
               	str	x20, [sp, #0x18]
               	add	x1, x20, #0x1
               	str	x1, [sp, #0x20]
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x278
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x268
               	mov	x1, x20
               	bl	<addr>
               	ldr	x0, [sp, #0x28]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldr	x0, [sp, #0x30]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x278
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	add	x2, x20, #0x1
               	cmp	x0, x2
               	b.ne	<addr>
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1a0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	str	w20, [sp, #0xf0]
               	mov	x1, #0x2                // =2
               	str	x1, [sp, #0xf8]
               	mov	x1, #0x3                // =3
               	str	x1, [sp, #0x100]
               	mov	x1, #0x78               // =120
               	strb	w1, [sp, #0x108]
               	bl	<addr>
               	add	x1, x20, #0x7a
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	lsl	x1, x20, #32
               	mov	x17, #0x9               // =9
               	orr	x1, x1, x17
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [sp, #0x10]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x258
               	mov	x1, x20
               	bl	<addr>
               	ldr	w0, [sp, #0x38]
               	and	x0, x0, #0x7
               	cmp	w0, #0x5
               	b.ne	<addr>
               	ldr	w0, [sp, #0x38]
               	asr	x0, x0, #3
               	and	x0, x0, #0x1f
               	cmp	w0, #0x11
               	b.ne	<addr>
               	ldr	w0, [sp, #0x38]
               	asr	x0, x0, #8
               	and	x0, x0, #0xfff
               	and	x1, x20, #0xfff
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x40]
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x248
               	mov	x1, x20
               	bl	<addr>
               	ldrb	w0, [sp, #0x48]
               	and	x1, x20, #0xff
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x50]
               	mov	x17, #0x3               // =3
               	mul	x1, x20, x17
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1b8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	mov	x1, x20
               	bl	<addr>
               	add	x1, x20, #0x2a
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x1, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	sub	x1, x20, #0x3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x78
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x238
               	mov	x1, x20
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x58]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldr	x0, [sp, #0x60]
               	add	x1, x20, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x228
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x20, x17
               	sub	x1, x1, #0x3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x218
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x20, x17
               	add	x1, x1, #0x4
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [sp, #0x78]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldr	x0, [sp, #0x80]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	stur	x1, [x29, #-0x8]
               	cmp	x0, x20
               	b.ne	<addr>
               	cmp	x1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	sub	x8, x29, #0x18
               	bl	<addr>
               	ldur	x0, [x29, #-0x18]
               	ldur	x1, [x29, #-0x10]
               	ldur	x2, [x29, #-0x8]
               	cmp	x0, x20
               	b.ne	<addr>
               	cmp	x1, #0x1
               	b.ne	<addr>
               	add	x0, x20, #0x2
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x7
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x208
               	mov	x1, x20
               	bl	<addr>
               	add	x1, x20, #0x5
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x278
               	mov	x1, x20
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x180
               	mov	x17, #0x0               // =0
               	mul	x0, x20, x17
               	str	x0, [sp, #0x110]
               	str	x20, [sp, #0x118]
               	lsl	x0, x20, #1
               	str	x0, [sp, #0x120]
               	mov	x17, #0x3               // =3
               	mul	x0, x20, x17
               	str	x0, [sp, #0x128]
               	lsl	x0, x20, #2
               	str	x0, [sp, #0x130]
               	mov	x17, #0x5               // =5
               	mul	x0, x20, x17
               	str	x0, [sp, #0x138]
               	mov	x17, #0x6               // =6
               	mul	x0, x20, x17
               	str	x0, [sp, #0x140]
               	mov	x17, #0x7               // =7
               	mul	x0, x20, x17
               	str	x0, [sp, #0x148]
               	lsl	x0, x20, #3
               	str	x0, [sp, #0x150]
               	mov	x17, #0x9               // =9
               	mul	x0, x20, x17
               	str	x0, [sp, #0x158]
               	mov	x17, #0xa               // =10
               	mul	x0, x20, x17
               	str	x0, [sp, #0x160]
               	mov	x17, #0xb               // =11
               	mul	x0, x20, x17
               	str	x0, [sp, #0x168]
               	mov	x17, #0xc               // =12
               	mul	x0, x20, x17
               	str	x0, [sp, #0x170]
               	mov	x17, #0xd               // =13
               	mul	x0, x20, x17
               	str	x0, [sp, #0x178]
               	mov	x17, #0xe               // =14
               	mul	x0, x20, x17
               	str	x0, [sp, #0x180]
               	mov	x17, #0xf               // =15
               	mul	x0, x20, x17
               	str	x0, [sp, #0x188]
               	sub	x0, x29, #0x100
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0xf               // =15
               	mul	x1, x20, x17
               	add	x1, x1, #0x5
               	cmp	x0, x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xf0]
               	lsl	x1, x20, #1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1f8
               	mov	x1, x20
               	bl	<addr>
               	ldr	x0, [sp, #0x98]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldr	x0, [sp, #0xa0]
               	add	x1, x20, #0x5
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	mov	x1, x20
               	bl	<addr>
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbnz	x0, <addr>
               	ldur	x0, [x29, #-0x8]
               	add	x1, x20, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1e8
               	mov	x1, x20
               	bl	<addr>
               	ldr	d0, [sp, #0xa8]
               	scvtf	d1, x20
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [sp, #0xb0]
               	fmov	d1, #0.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1d8
               	mov	x1, x20
               	bl	<addr>
               	ldr	x0, [sp, #0xb8]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldr	x0, [sp, #0xc0]
               	add	x1, x20, #0x2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1c8
               	mov	x2, #0x6                // =6
               	mov	x1, x20
               	bl	<addr>
               	ldr	x0, [sp, #0xc8]
               	cmp	x0, x20
               	b.ne	<addr>
               	ldr	x0, [sp, #0xd0]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x0, x20, #0xff
               	add	x1, x20, #0x1
               	lsl	x1, x1, #8
               	and	x1, x1, #0xff00
               	orr	x0, x0, x1
               	orr	x21, x0, #0x10000
               	mov	x0, x20
               	bl	<addr>
               	cmp	w0, w21
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x290
               	ldp	x29, x30, [sp], #0x10
               	ret
