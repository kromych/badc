
struct_array_member_brace_elision.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	fmov	s0, #1.00000000
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	fmov	s4, #2.00000000
               	fmov	s1, #3.00000000
               	fmov	s6, #4.00000000
               	fmov	s5, #5.00000000
               	fadd	s23, s0, s1
               	movi	d2, #0000000000000000
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s3, [x0]
               	fcmp	s3, s0
               	b.ne	<addr>
               	ldr	s3, [x0, #0x4]
               	fcmp	s3, s4
               	b.ne	<addr>
               	ldr	s3, [x0, #0x8]
               	fcmp	s3, s1
               	b.ne	<addr>
               	ldr	s3, [x0, #0xc]
               	fcmp	s3, s6
               	b.ne	<addr>
               	ldr	s3, [x0, #0x10]
               	fcmp	s3, s5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s3, [x0]
               	fcmp	s3, s0
               	b.ne	<addr>
               	ldr	s3, [x0, #0x4]
               	fcmp	s3, s4
               	b.ne	<addr>
               	ldr	s3, [x0, #0x8]
               	fcmp	s3, s1
               	b.ne	<addr>
               	ldr	s3, [x0, #0xc]
               	fcmp	s3, s6
               	b.ne	<addr>
               	ldr	s3, [x0, #0x10]
               	fcmp	s3, s5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fmov	s7, #1.00000000
               	fmov	s3, #2.00000000
               	fmov	s19, #3.00000000
               	fmov	s20, #4.00000000
               	fmov	s21, #5.00000000
               	ldr	s22, [x0]
               	fcmp	s22, s7
               	b.ne	<addr>
               	ldr	s22, [x0, #0x4]
               	fcmp	s22, s3
               	b.ne	<addr>
               	ldr	s22, [x0, #0x8]
               	fcmp	s22, s19
               	b.ne	<addr>
               	ldr	s22, [x0, #0xc]
               	fcmp	s22, s20
               	b.ne	<addr>
               	ldr	s20, [x0, #0x10]
               	fcmp	s20, s21
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldr	s20, [x0, #0x4]
               	fcmp	s20, s7
               	b.ne	<addr>
               	ldr	s20, [x0, #0x8]
               	fcmp	s20, s3
               	b.ne	<addr>
               	ldr	s3, [x0, #0xc]
               	fcmp	s3, s19
               	b.ne	<addr>
               	ldr	s19, [x0, #0x10]
               	movi	d3, #0000000000000000
               	fcmp	s19, s3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s19, [x0]
               	fcmp	s19, s3
               	b.ne	<addr>
               	ldr	s19, [x0, #0x4]
               	fcmp	s19, s3
               	b.ne	<addr>
               	ldr	s19, [x0, #0x8]
               	fcmp	s19, s3
               	b.ne	<addr>
               	ldr	s19, [x0, #0xc]
               	fcmp	s19, s3
               	b.ne	<addr>
               	ldr	s19, [x0, #0x10]
               	fcmp	s19, s3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	fmov	s19, #2.00000000
               	fmov	s20, #3.00000000
               	fmov	s21, #4.00000000
               	fmov	s22, #5.00000000
               	ldr	s3, [x0]
               	fcmp	s3, s7
               	b.ne	<addr>
               	ldr	s3, [x0, #0x4]
               	fcmp	s3, s19
               	b.ne	<addr>
               	ldr	s3, [x0, #0x8]
               	fcmp	s3, s20
               	b.ne	<addr>
               	ldr	s3, [x0, #0xc]
               	fcmp	s3, s21
               	b.ne	<addr>
               	ldr	s3, [x0, #0x10]
               	fcmp	s3, s22
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s3, #1.00000000
               	fcmp	s0, s3
               	b.ne	<addr>
               	fcmp	s4, s19
               	b.ne	<addr>
               	fcmp	s1, s20
               	b.ne	<addr>
               	fcmp	s6, s21
               	b.ne	<addr>
               	fcmp	s5, s22
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s6, #2.00000000
               	fmov	s7, #3.00000000
               	fmov	s19, #4.00000000
               	fmov	s20, #5.00000000
               	fcmp	s0, s3
               	b.ne	<addr>
               	fcmp	s4, s6
               	b.ne	<addr>
               	fcmp	s1, s7
               	b.ne	<addr>
               	fcmp	s23, s19
               	b.ne	<addr>
               	fcmp	s5, s20
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	s0, s3
               	b.ne	<addr>
               	fcmp	s4, s6
               	b.ne	<addr>
               	fcmp	s1, s7
               	b.ne	<addr>
               	movi	d0, #0000000000000000
               	fcmp	s2, s0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	s2, s0
               	b.ne	<addr>
               	fcmp	s2, s0
               	b.ne	<addr>
               	fcmp	s2, s0
               	b.ne	<addr>
               	fcmp	s2, s0
               	b.ne	<addr>
               	fcmp	s2, s0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
