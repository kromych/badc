
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
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
               	mov	x2, x0
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	mov	x1, #0x5                // =5
               	str	w1, [x0]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	ldr	x0, [x0]
               	mov	w0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<bitfield_copy>:
               	mov	x3, #0x0                // =0
               	and	x2, x1, #0xfff
               	lsl	x2, x2, #8
               	mov	x17, #0x8d              // =141
               	orr	x2, x2, x17
               	str	w2, [x0]
               	str	w3, [x0, #0x4]
               	str	x1, [x0, #0x8]
               	ret

<padded_copy>:
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	and	x3, x2, #0xff
               	mov	x17, #0x3               // =3
               	mul	x2, x2, x17
               	strb	w3, [x0]
               	strb	w1, [x0, #0x1]
               	strh	w1, [x0, #0x2]
               	str	w1, [x0, #0x4]
               	str	x2, [x0, #0x8]
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
               	mov	x2, x0
               	sub	x0, x29, #0x20
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x2, [x0, #0x18]
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x1                // =1
               	str	x1, [x0, #0x10]
               	ldr	x2, [x0]
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	ldr	x3, [x0, #0x8]
               	add	x2, x2, x3
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	add	x0, x2, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<volatile_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	mov	x3, x1
               	sub	x0, x29, #0x10
               	mov	x4, #0x0                // =0
               	str	x4, [x0]
               	add	x1, x0, #0x8
               	str	x4, [x1]
               	str	x3, [x0]
               	add	x3, x3, #0x1
               	str	x3, [x1]
               	ldr	x3, [x0]
               	ldr	x4, [x1]
               	ldr	x5, [x0]
               	str	x5, [x2]
               	ldr	x0, [x1]
               	str	x0, [x2, #0x8]
               	add	x0, x3, x4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<clobber>:
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0, #0x8]
               	ret

<escape_after_copy>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	lsl	x1, x1, #1
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	ldr	x1, [x20]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret

<take>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	mov	x17, #0x3               // =3
               	mul	x1, x1, x17
               	ldr	x0, [x0, #0x8]
               	add	x0, x1, x0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<by_value_arg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_pair>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	mov	x1, #0x9                // =9
               	str	x1, [x0, #0x8]
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<make_large>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x20
               	str	x8, [x16]
               	mov	x1, x0
               	sub	x0, x29, #0x18
               	stp	xzr, xzr, [x0]
               	str	xzr, [x0, #0x10]
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x0, #0x8]
               	mov	x2, #0x2                // =2
               	str	x2, [x0, #0x10]
               	add	x1, x2, x1
               	str	x1, [x0, #0x10]
               	mov	x16, x0
               	sub	x17, x29, #0x20
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	uxtb	w0, w0
               	brk	#0x1

<copy_across_setjmp>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x21, x1
               	mov	x22, #0x5               // =5
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	str	x21, [x20]
               	str	x22, [x20, #0x8]
               	add	x0, x21, #0x5
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	bl	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<vla_copy>:
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
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
               	sub	x3, x1, #0x1
               	add	x4, x2, x3
               	mov	x5, #0x3                // =3
               	strb	w5, [x4]
               	ldr	x5, [x0]
               	ldr	x0, [x0, #0x8]
               	ldrb	w1, [x4]
               	add	x0, x0, x1
               	add	x0, x5, x0
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret

<big_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	mov	x3, x1
               	sub	x1, x29, #0x80
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x1]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x3, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x3, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x3, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x3, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [x3, #0x40]
               	str	x10, [x1, #0x40]
               	ldr	x10, [x3, #0x48]
               	str	x10, [x1, #0x48]
               	ldr	x10, [x3, #0x50]
               	str	x10, [x1, #0x50]
               	ldr	x10, [x3, #0x58]
               	str	x10, [x1, #0x58]
               	ldr	x10, [x3, #0x60]
               	str	x10, [x1, #0x60]
               	ldr	x10, [x3, #0x68]
               	str	x10, [x1, #0x68]
               	ldr	x10, [x3, #0x70]
               	str	x10, [x1, #0x70]
               	ldr	x10, [x3, #0x78]
               	str	x10, [x1, #0x78]
               	ldr	x10, [sp], #0x10
               	str	x2, [x1, #0x18]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x1, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x1, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x1, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x1, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x1, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x1, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x1, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x1, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [sp], #0x10
               	ldr	x1, [x0, #0x18]
               	ldr	x0, [x0, #0x78]
               	add	x0, x1, x0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret

<array_member_copy>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, x0
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	str	x1, [x0]
               	add	x1, x1, #0x5
               	str	x1, [x0, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x2]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<wide_copy>:
               	mov	x2, x1
               	mov	x1, #0x0                // =0
               	add	x3, x2, #0x1
               	str	x2, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	str	x1, [x0, #0x30]
               	str	x1, [x0, #0x38]
               	str	x1, [x0, #0x40]
               	str	x1, [x0, #0x48]
               	str	x1, [x0, #0x50]
               	str	x1, [x0, #0x58]
               	str	x1, [x0, #0x60]
               	str	x1, [x0, #0x68]
               	str	x1, [x0, #0x70]
               	str	x3, [x0, #0x78]
               	ret

<fp_copy>:
               	scvtf	d0, x1
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	str	d0, [x0]
               	fmov	d16, x1
               	str	d16, [x0, #0x8]
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
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	w1, w2
               	lsr	x3, x1, #0
               	and	x3, x3, #0xff
               	mov	x17, #0x0               // =0
               	orr	x3, x3, x17
               	str	w3, [x0]
               	add	x1, x1, #0x1
               	mov	w1, w1
               	ldr	w2, [x0]
               	and	w2, w2, #0xffff00ff
               	lsl	x1, x1, #8
               	mov	w1, w1
               	and	x1, x1, #0xff00
               	orr	x1, x2, x1
               	str	w1, [x0]
               	ldr	w1, [x0]
               	and	w1, w1, #0xfffeffff
               	orr	x1, x1, #0x10000
               	str	w1, [x0]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x2b0
               	str	x20, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	sub	x0, x29, #0x280
               	stp	xzr, xzr, [x0]
               	str	x20, [x0]
               	add	x1, x20, #0x1
               	str	x1, [x0, #0x8]
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x4                // =4
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x270
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x270
               	ldr	x1, [x0]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	ldr	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x290
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x290
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x0, x20, #0x1
               	cmp	x1, x0
               	b.ne	<addr>
               	cmp	x2, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x260
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	str	w20, [x0]
               	mov	x1, #0x2                // =2
               	str	x1, [x0, #0x8]
               	mov	x1, #0x3                // =3
               	str	x1, [x0, #0x10]
               	mov	x1, #0x78               // =120
               	strb	w1, [x0, #0x18]
               	bl	<addr>
               	add	x1, x20, #0x7a
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x240
               	lsl	x1, x20, #32
               	mov	x17, #0x9               // =9
               	orr	x1, x1, x17
               	bl	<addr>
               	cmp	x0, #0x5
               	b.ne	<addr>
               	sub	x0, x29, #0x240
               	ldrsw	x0, [x0]
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x238
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x238
               	ldr	w1, [x0]
               	and	x1, x1, #0x7
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldr	w1, [x0]
               	asr	x1, x1, #3
               	and	x1, x1, #0x1f
               	cmp	w1, #0x11
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	w1, [x0]
               	asr	x1, x1, #8
               	and	x1, x1, #0xfff
               	and	x2, x20, #0xfff
               	cmp	w1, w2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x20
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x228
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x228
               	ldrb	w1, [x0]
               	and	x2, x20, #0xff
               	cmp	w1, w2
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x1, x20, x17
               	cmp	x0, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x218
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [sp], #0x10
               	mov	x1, x20
               	bl	<addr>
               	add	x1, x20, #0x2a
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x3                // =3
               	mov	x0, x20
               	bl	<addr>
               	sub	x1, x20, #0x3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x78
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	mov	x1, x20
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x1
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x200
               	ldr	x1, [x0]
               	cmp	x1, x20
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	add	x1, x20, #0x1
               	cmp	x0, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1f0
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x20, x17
               	sub	x1, x1, #0x3
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1e0
               	mov	x1, x20
               	bl	<addr>
               	mov	x17, #0x3               // =3
               	mul	x1, x20, x17
               	add	x1, x1, #0x4
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x1e0
               	ldr	x1, [x0]
               	cmp	x1, x20
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x290
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x290
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cmp	x1, x20
               	b.ne	<addr>
               	cmp	x0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x11               // =17
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	sub	x8, x29, #0x298
               	bl	<addr>
               	sub	x0, x29, #0x298
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	cmp	x1, x20
               	b.ne	<addr>
               	cmp	x2, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	add	x0, x20, #0x2
               	cmp	x3, x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x12               // =18
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x20, #0x7
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x1d0
               	mov	x1, x20
               	bl	<addr>
               	add	x1, x20, #0x5
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x280
               	mov	x1, x20
               	bl	<addr>
               	lsl	x1, x20, #1
               	add	x1, x1, #0x4
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x1c0
               	add	x0, x1, #0x0
               	mov	x17, #0x0               // =0
               	mul	x2, x20, x17
               	str	x2, [x0]
               	lsr	x0, x20, #0
               	str	x0, [x1, #0x8]
               	lsl	x0, x20, #1
               	str	x0, [x1, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x0, x20, x17
               	str	x0, [x1, #0x18]
               	lsl	x0, x20, #2
               	str	x0, [x1, #0x20]
               	mov	x17, #0x5               // =5
               	mul	x0, x20, x17
               	str	x0, [x1, #0x28]
               	mov	x17, #0x6               // =6
               	mul	x0, x20, x17
               	str	x0, [x1, #0x30]
               	mov	x17, #0x7               // =7
               	mul	x0, x20, x17
               	str	x0, [x1, #0x38]
               	lsl	x0, x20, #3
               	str	x0, [x1, #0x40]
               	mov	x17, #0x9               // =9
               	mul	x0, x20, x17
               	str	x0, [x1, #0x48]
               	mov	x17, #0xa               // =10
               	mul	x0, x20, x17
               	str	x0, [x1, #0x50]
               	mov	x17, #0xb               // =11
               	mul	x0, x20, x17
               	str	x0, [x1, #0x58]
               	mov	x17, #0xc               // =12
               	mul	x0, x20, x17
               	str	x0, [x1, #0x60]
               	mov	x17, #0xd               // =13
               	mul	x0, x20, x17
               	str	x0, [x1, #0x68]
               	mov	x17, #0xe               // =14
               	mul	x0, x20, x17
               	str	x0, [x1, #0x70]
               	mov	x17, #0xf               // =15
               	mul	x0, x20, x17
               	str	x0, [x1, #0x78]
               	sub	x0, x29, #0x140
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0xf               // =15
               	mul	x1, x20, x17
               	add	x1, x1, #0x5
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x140
               	ldr	x0, [x0, #0x10]
               	lsl	x1, x20, #1
               	cmp	x0, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	ldr	x1, [x0]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	add	x1, x20, #0x5
               	cmp	x0, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb0
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0xb0
               	ldr	x1, [x0]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x1, [x0, #0x38]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x78]
               	add	x1, x20, #0x1
               	cmp	x0, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x18               // =24
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x30
               	ldr	d0, [x0]
               	scvtf	d1, x20
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	add	x1, x20, #0x2
               	cmp	x0, x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1a               // =26
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x2, #0x6                // =6
               	mov	x1, x20
               	bl	<addr>
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1b               // =27
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	w0, w20
               	and	x2, x20, #0xff
               	add	x1, x0, #0x1
               	mov	w1, w1
               	lsl	x1, x1, #8
               	and	x1, x1, #0xff00
               	orr	x1, x2, x1
               	orr	x20, x1, #0x10000
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	ldr	x20, [sp]
               	add	sp, sp, #0x2b0
               	ldp	x29, x30, [sp], #0x10
               	ret
