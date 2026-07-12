
math_classify.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	lsr	x0, x0, #52
               	mov	x17, #0x7ff             // =2047
               	and	x0, x0, x17
               	sub	x1, x29, #0x8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xf, lsl #48
               	and	x1, x1, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	cmp	x0, #0x7ff
               	b.ne	<addr>
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<isnan>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<isinf>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x1
               	cset	x0, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<isfinite>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x2
               	cset	x0, ge
               	ldp	x29, x30, [sp], #0x10
               	ret

<signbit>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	str	d0, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	lsr	x0, x0, #63
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	d8, d9, [sp, #-0x60]!
               	str	d10, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fdiv	d8, d0, d0
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x0
               	fdiv	d9, d16, d0
               	fmov	d16, x0
               	fneg	d1, d16
               	fdiv	d10, d1, d0
               	fmov	d0, d8
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d9
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d9
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d10
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d9
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d8
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d9
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	fmov	d0, d10
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	fmov	d0, x0
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x60
               	ret
