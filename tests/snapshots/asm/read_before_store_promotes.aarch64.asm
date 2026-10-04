
read_before_store_promotes.aarch64:	file format elf64-littleaarch64

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

<maybe>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	b	<addr>

<self_init>:
               	mov	x0, #0x5                // =5
               	ret

<fp_maybe>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	fmov	d0, #1.50000000
               	cbz	x0, <addr>
               	ret
               	fmov	d0, #2.50000000
               	b	<addr>

<f32_maybe>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	fmov	s0, #0.25000000
               	cbz	x0, <addr>
               	ret
               	fmov	s0, #0.50000000
               	b	<addr>

<narrow_maybe>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #-0x3               // =-3
               	cbz	x0, <addr>
               	mov	x0, #-0x3               // =-3
               	ret
               	mov	x0, #0x7                // =7
               	b	<addr>

<u8_maybe>:
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x1, #0xc8               // =200
               	cbz	x0, <addr>
               	mov	x0, #0xc8               // =200
               	ret
               	mov	x0, #0x9                // =9
               	b	<addr>

<loop_first>:
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, #0x0
               	b.le	<addr>
               	add	x1, x1, x2
               	lsl	x2, x0, #1
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<probe>:
               	mov	x3, #0x9                // =9
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrh	w2, [x4, w2, uxtw #1]
               	cbz	w2, <addr>
               	mov	x0, #0x14               // =20
               	sub	x0, x0, x2
               	and	x0, x0, #0xffff
               	cmp	w0, w1
               	b.hi	<addr>
               	and	x2, x2, #0xf
               	eor	x5, x2, x3
               	cbz	w5, <addr>
               	ldrh	w2, [x4, w2, uxtw #1]
               	cbnz	w2, <addr>
               	mov	x0, #0x0                // =0
               	ret
               	ret

<self_loop>:
               	mov	x0, #0x0                // =0
               	mov	x3, #0x3                // =3
               	mov	x2, x0
               	mul	x1, x0, x3
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lo	<addr>
               	mov	x0, x2
               	ret

<inlined>:
               	cmp	w0, #0x2
               	b.le	<addr>
               	mov	x17, #0xa               // =10
               	mul	x1, x0, x17
               	cmp	w0, #0x2
               	b.le	<addr>
               	add	x0, x0, #0x3
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x1, x0
               	ret
               	mov	x1, #-0x1               // =-1
               	b	<addr>

<stack_arg>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x0, [x29, #0x18]
               	sub	x0, x0, #0x1
               	add	x0, x0, #0x2
               	sub	x0, x0, #0x2
               	add	x0, x0, #0x3
               	sub	x0, x0, #0x3
               	add	x0, x0, #0x4
               	sub	x0, x0, #0x4
               	add	x0, x0, #0x5
               	sub	x0, x0, #0x5
               	add	x0, x0, #0x6
               	sub	x0, x0, #0x6
               	add	x0, x0, #0x7
               	sub	x0, x0, #0x7
               	add	x0, x0, #0x8
               	sub	x1, x0, #0x8
               	ldr	x0, [x29, #0x10]
               	add	x1, x1, x0
               	sub	x0, x1, x0
               	ldp	x29, x30, [sp], #0x10
               	ret

<make>:
               	mov	x0, #0x28               // =40
               	ret

<field_of_result>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	fmov	d1, #1.50000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	fmov	d1, #2.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	fmov	s1, #0.25000000
               	fcmp	s0, s1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	fmov	s1, #0.50000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxth	x0, w0
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	sxth	x0, w0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	and	x0, x0, #0xff
               	mov	x17, #0xc8              // =200
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	and	x0, x0, #0xff
               	mov	x17, #0x9               // =9
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	mov	x1, #0x1e               // =30
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	mov	x17, #0xb               // =11
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #0x14               // =20
               	mov	x1, #0x5                // =5
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x14               // =20
               	mov	x1, #0x1e               // =30
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x27
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	w0, #0x5a
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	mov	x8, #0x9                // =9
               	mov	x9, #0x28               // =40
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	x0, #0x27
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	cmp	w0, #0x29
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
