
fp_sign_bit_operations.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<bitsf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<off>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<absd>:
               	fabs	d0, d0
               	ret

<negd>:
               	fneg	d0, d0
               	ret

<nabsd>:
               	fabs	d0, d0
               	fneg	d0, d0
               	ret

<absf>:
               	fabs	s0, s0
               	ret

<negf>:
               	fneg	s0, s0
               	ret

<sum_abs>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	movi	d0, #0000000000000000
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	d1, [x2, x0, lsl #3]
               	fabs	d1, d1
               	ldr	d2, [x2, x0, lsl #3]
               	fneg	d2, d2
               	fsub	d1, d1, d2
               	fadd	d0, d0, d1
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x230
               	stp	x20, x21, [sp]
               	str	x22, [sp, #0x10]
               	mov	x22, #-0x8000000000000000 // =-9223372036854775808
               	mov	x20, #0x0               // =0
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21, x20, lsl #3]
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x1, d0
               	ldr	x0, [x21, x20, lsl #3]
               	and	x2, x0, #0x7fffffffffffffff
               	cmp	x1, x2
               	b.ne	<addr>
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	ldr	x1, [x21, x20, lsl #3]
               	eor	x1, x1, x22
               	cmp	x0, x1
               	b.ne	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	fmov	d0, x0
               	bl	<addr>
               	fmov	x0, d0
               	ldr	x1, [x21, x20, lsl #3]
               	orr	x1, x1, x22
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0xa
               	b.lo	<addr>
               	mov	x20, #0x0               // =0
               	adrp	x21, <addr>
               	add	x21, x21, <lo12>
               	ldr	w0, [x21, x20, lsl #2]
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	mov	x1, x0
               	ldr	w0, [x21, x20, lsl #2]
               	and	x2, x0, #0x7fffffff
               	cmp	w1, w2
               	b.ne	<addr>
               	bl	<addr>
               	bl	<addr>
               	bl	<addr>
               	ldr	w1, [x21, x20, lsl #2]
               	eor	x1, x1, #0x80000000
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x8
               	b.lo	<addr>
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x200
               	fmov	d0, #-0.50000000
               	fmov	d1, #0.25000000
               	tst	x0, #0x1
               	fcsel	d0, d0, d1, ne
               	scvtf	d1, x0
               	fmul	d0, d0, d1
               	str	d0, [x1, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	movi	d1, #0000000000000000
               	and	x1, x0, #0x1
               	cbz	x1, <addr>
               	fmov	d0, #0.50000000
               	scvtf	d2, x0
               	fmul	d0, d0, d2
               	fmov	d2, #-0.50000000
               	fmov	d3, #0.25000000
               	cmp	x1, #0x0
               	fcsel	d2, d2, d3, ne
               	b	<addr>
               	fmov	d0, #0.25000000
               	scvtf	d2, x0
               	fmul	d0, d0, d2
               	b	<addr>
               	scvtf	d3, x0
               	fmadd	d0, d2, d3, d0
               	fadd	d1, d1, d0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	mov	x1, #0x40               // =64
               	str	d1, [sp, #0x28]
               	bl	<addr>
               	ldr	d1, [sp, #0x28]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x230
               	ldp	x29, x30, [sp], #0x10
               	ret
