
two_address_operands.aarch64:	file format elf64-littleaarch64

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

<rsub>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	sub	x0, x1, x0
               	ret

<twice>:
               	lsl	x0, x0, #1
               	ret

<rsub_call>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x9, x1
               	mov	x0, x20
               	blr	x9
               	sub	x0, x20, x0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<fdiv_rev>:
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fmul	d0, d0, d17
               	fdiv	d0, d1, d0
               	ret

<fsub_rev>:
               	fmsub	d0, d0, d0, d1
               	ret

<fsub_rev_f>:
               	fmsub	s0, s0, s0, s1
               	ret

<ones>:
               	mov	x2, x0
               	mov	x3, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, w3
               	b.ge	<addr>
               	lsr	x4, x2, x0
               	and	x4, x4, #0x1
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<past_fourth>:
               	lsl	x0, x0, x1
               	add	x0, x0, x3
               	add	x0, x0, x2
               	ret

<all_live>:
               	asr	x2, x0, x1
               	mov	x17, #0x3e8             // =1000
               	mul	x2, x2, x17
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	add	x0, x0, x1
               	ret

<carried>:
               	mov	x4, x0
               	mov	x5, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	x1, x4
               	b.ge	<addr>
               	add	x1, x0, x3
               	lsl	x6, x5, x2
               	add	x0, x0, x6
               	cmp	x1, x4
               	b.lt	<addr>
               	mov	x0, x1
               	ret

<rotr>:
               	and	x2, x1, #0x3f
               	lsr	x2, x0, x2
               	mov	x3, #0x40               // =64
               	sub	x1, x3, x1
               	and	x1, x1, #0x3f
               	lsl	x0, x0, x1
               	orr	x0, x2, x0
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20]
               	add	x1, x20, #0x8
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x10
               	ldr	x0, [x0]
               	add	x1, x20, #0x18
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x20
               	ldr	x0, [x0]
               	add	x1, x20, #0x28
               	ldr	x1, [x1]
               	bl	<addr>
               	mov	x17, #0x5               // =5
               	movk	x17, #0x8000, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x28
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x17, #-0x5              // =-5
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x20, #0x20
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	add	x0, x0, #0x8
               	ldr	d1, [x0]
               	bl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x10
               	ldr	d0, [x1]
               	add	x0, x0, #0x18
               	ldr	d1, [x0]
               	bl	<addr>
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x18
               	ldr	d0, [x1]
               	add	x0, x0, #0x20
               	ldr	d1, [x0]
               	bl	<addr>
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x28
               	ldr	d0, [x1]
               	add	x0, x0, #0x30
               	ldr	d1, [x0]
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x18
               	ldr	d0, [x1]
               	fcvt	s0, d0
               	add	x0, x0, #0x20
               	ldr	d1, [x0]
               	fcvt	s1, d1
               	bl	<addr>
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #-0xf0f0f0f0f0f0f10 // =-1085102592571150096
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x40
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0x20
               	b.ne	<addr>
               	mov	x0, #0xff               // =255
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	bl	<addr>
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x40
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	add	x2, x0, #0x8
               	ldr	x2, [x2]
               	add	x3, x0, #0x10
               	ldr	x3, [x3]
               	add	x0, x0, #0x18
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x20
               	ldr	x1, [x1]
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x17, #0x5183            // =20867
               	movk	x17, #0x1, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x1, x0, #0x28
               	ldr	x1, [x1]
               	add	x2, x0, #0x30
               	ldr	x2, [x2]
               	ldr	x3, [x0]
               	add	x0, x0, #0x38
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x0
               	mov	x0, x16
               	bl	<addr>
               	cmp	x0, #0x71
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x48
               	ldr	x1, [x1]
               	mov	w1, w1
               	bl	<addr>
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x6789, lsl #16
               	movk	x17, #0x2345, lsl #32
               	movk	x17, #0xef01, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x50
               	ldr	x1, [x1]
               	mov	w1, w1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x38
               	ldr	x1, [x1]
               	mov	w1, w1
               	bl	<addr>
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
