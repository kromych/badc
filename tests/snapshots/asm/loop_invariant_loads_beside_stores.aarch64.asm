
loop_invariant_loads_beside_stores.aarch64:	file format elf64-littleaarch64

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

<pull>:
               	mov	x5, #0x0                // =0
               	mov	x3, #0x38               // =56
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mul	x0, x5, x3
               	add	x1, x4, x0
               	add	x2, x5, #0x1
               	ldr	d5, [x1]
               	ldr	d6, [x1, #0x8]
               	ldr	d7, [x1, #0x10]
               	ldr	d0, [x1, #0x30]
               	cmp	w2, #0x5
               	b.ge	<addr>
               	mul	x0, x2, x3
               	add	x0, x4, x0
               	ldr	d1, [x0]
               	fsub	d2, d5, d1
               	ldr	d1, [x0, #0x8]
               	fsub	d3, d6, d1
               	ldr	d1, [x0, #0x10]
               	fsub	d4, d7, d1
               	ldr	d19, [x1, #0x18]
               	ldr	d1, [x0, #0x30]
               	fmsub	d19, d2, d1, d19
               	str	d19, [x1, #0x18]
               	ldr	d19, [x1, #0x20]
               	fmsub	d19, d3, d1, d19
               	str	d19, [x1, #0x20]
               	ldr	d19, [x1, #0x28]
               	fmsub	d1, d4, d1, d19
               	str	d1, [x1, #0x28]
               	ldr	d1, [x0, #0x18]
               	fmadd	d1, d2, d0, d1
               	str	d1, [x0, #0x18]
               	ldr	d1, [x0, #0x20]
               	fmadd	d1, d3, d0, d1
               	str	d1, [x0, #0x20]
               	ldr	d1, [x0, #0x28]
               	fmadd	d1, d4, d0, d1
               	str	d1, [x0, #0x28]
               	add	x2, x2, #0x1
               	cmp	w2, #0x5
               	b.lt	<addr>
               	add	x5, x5, #0x1
               	cmp	w5, #0x5
               	b.lt	<addr>
               	ret

<next_row>:
               	sxtw	x2, w0
               	cmp	w2, #0x0
               	b.lt	<addr>
               	cmp	w2, #0xe
               	b.le	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x4, x2, #0x1
               	mov	x5, #0xa                // =10
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x6, [x3, x4, lsl #3]
               	add	x2, x2, x6
               	mul	x6, x0, x5
               	sxtw	x6, w6
               	str	x6, [x3, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<odd_even>:
               	sxtw	x2, w0
               	cmp	w2, #0x0
               	b.lt	<addr>
               	cmp	w2, #0x7
               	b.le	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	lsl	x2, x2, #1
               	add	x4, x2, #0x1
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x5, [x3, x4, lsl #3]
               	add	x2, x2, x5
               	lsl	x5, x0, #1
               	str	x0, [x3, w5, sxtw #3]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<wrapped>:
               	sxtw	x3, w0
               	cmp	w3, #0x0
               	b.lt	<addr>
               	cmp	w3, #0x7
               	b.le	<addr>
               	mov	x0, #-0x1               // =-1
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x17, #0x38              // =56
               	mul	x3, x3, x17
               	add	x3, x4, x3
               	mov	x5, #0x38               // =56
               	add	x1, x1, #0x1
               	mul	x1, x1, x5
               	add	x4, x4, x1
               	mov	x1, x0
               	cmp	w0, w2
               	b.ge	<addr>
               	ldr	x5, [x3, #0x8]
               	add	x1, x1, x5
               	add	x5, x0, #0x64
               	sxtw	x5, w5
               	str	x5, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<zero_trip>:
               	mov	x2, #0x0                // =0
               	mov	x3, #0x38               // =56
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	movi	d0, #0000000000000000
               	cmp	w2, w1
               	b.ge	<addr>
               	ldr	d1, [x0, #0x30]
               	fadd	d0, d0, d1
               	mul	x5, x2, x3
               	add	x5, x4, x5
               	str	d0, [x5, #0x18]
               	add	x2, x2, #0x1
               	cmp	w2, w1
               	b.lt	<addr>
               	fcvtzs	x0, d0
               	ret

<through>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	movi	d0, #0000000000000000
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	d1, [x3, #0xa0]
               	fadd	d0, d0, d1
               	scvtf	d1, x0
               	str	d1, [x2]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	ret

<local_kept>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	add	x2, x2, #0x4
               	str	x2, [x3, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<local_escaped>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x3, x0
               	sub	x2, x29, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x0                // =0
               	add	x2, x2, #0x8
               	str	x2, [x3]
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldur	x4, [x29, #-0x8]
               	add	x2, x2, x4
               	ldr	x4, [x3]
               	str	x0, [x4]
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	mov	x3, #0x18               // =24
               	mov	x4, #0x38               // =56
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	mul	x1, x0, x4
               	add	x1, x6, x1
               	ldr	d0, [x1, #0x18]
               	mul	x2, x0, x3
               	add	x2, x5, x2
               	ldr	d1, [x2]
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x1, #0x20]
               	ldr	d1, [x2, #0x8]
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x1, #0x28]
               	ldr	d1, [x2, #0x10]
               	fcmp	d0, d1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0, #0x58]
               	str	x1, [x0, #0x60]
               	str	x1, [x0, #0x68]
               	str	x1, [x0, #0x70]
               	str	x1, [x0, #0x78]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	xzr, [x2]
               	mov	x0, #0x1                // =1
               	str	x0, [x2, #0x8]
               	mov	x0, #0x2                // =2
               	str	x0, [x2, #0x10]
               	mov	x0, #0x3                // =3
               	str	x0, [x2, #0x18]
               	mov	x1, #0x4                // =4
               	str	x1, [x2, #0x20]
               	mov	x1, #0x5                // =5
               	str	x1, [x2, #0x28]
               	mov	x1, #0x6                // =6
               	str	x1, [x2, #0x30]
               	mov	x1, #0x7                // =7
               	str	x1, [x2, #0x38]
               	mov	x1, #0x8                // =8
               	str	x1, [x2, #0x40]
               	mov	x3, #0x9                // =9
               	str	x3, [x2, #0x48]
               	mov	x3, #0xa                // =10
               	str	x3, [x2, #0x50]
               	mov	x3, #0xb                // =11
               	str	x3, [x2, #0x58]
               	mov	x3, #0xc                // =12
               	str	x3, [x2, #0x60]
               	mov	x3, #0xd                // =13
               	str	x3, [x2, #0x68]
               	mov	x3, #0xe                // =14
               	str	x3, [x2, #0x70]
               	mov	x3, #0xf                // =15
               	str	x3, [x2, #0x78]
               	bl	<addr>
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x9                // =9
               	str	x1, [x0, #0xb0]
               	mov	x0, #0x3                // =3
               	mov	x1, #0x6db9             // =28089
               	movk	x1, #0xb6db, lsl #16
               	movk	x1, #0xdb6d, lsl #32
               	movk	x1, #0x6db6, lsl #48
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x138
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0xa0
               	fmov	d0, #11.00000000
               	str	d0, [x0]
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	fmov	d1, #14.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x10
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
