
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
               	fmov	s1, #1.00000000
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	fmov	s0, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	s3, #4.00000000
               	fmov	s4, #5.00000000
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s5, [x0]
               	fcmp	s5, s1
               	b.ne	<addr>
               	ldr	s5, [x0, #0x4]
               	fcmp	s5, s0
               	b.ne	<addr>
               	ldr	s5, [x0, #0x8]
               	fcmp	s5, s2
               	b.ne	<addr>
               	ldr	s5, [x0, #0xc]
               	fcmp	s5, s3
               	b.ne	<addr>
               	ldr	s5, [x0, #0x10]
               	fcmp	s5, s4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s5, [x0]
               	fcmp	s5, s1
               	b.ne	<addr>
               	ldr	s5, [x0, #0x4]
               	fcmp	s5, s0
               	b.ne	<addr>
               	ldr	s5, [x0, #0x8]
               	fcmp	s5, s2
               	b.ne	<addr>
               	ldr	s5, [x0, #0xc]
               	fcmp	s5, s3
               	b.ne	<addr>
               	ldr	s5, [x0, #0x10]
               	fcmp	s5, s4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s5, [x0]
               	fcmp	s5, s1
               	b.ne	<addr>
               	ldr	s5, [x0, #0x4]
               	fcmp	s5, s0
               	b.ne	<addr>
               	ldr	s5, [x0, #0x8]
               	fcmp	s5, s2
               	b.ne	<addr>
               	ldr	s5, [x0, #0xc]
               	fcmp	s5, s3
               	b.ne	<addr>
               	ldr	s3, [x0, #0x10]
               	fcmp	s3, s4
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
               	ldr	s3, [x0, #0x4]
               	fcmp	s3, s1
               	b.ne	<addr>
               	ldr	s3, [x0, #0x8]
               	fcmp	s3, s0
               	b.ne	<addr>
               	ldr	s0, [x0, #0xc]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldr	s2, [x0, #0x10]
               	movi	d0, #0000000000000000
               	fcmp	s2, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s2, [x0]
               	fcmp	s2, s0
               	b.ne	<addr>
               	ldr	s2, [x0, #0x4]
               	fcmp	s2, s0
               	b.ne	<addr>
               	ldr	s2, [x0, #0x8]
               	fcmp	s2, s0
               	b.ne	<addr>
               	ldr	s2, [x0, #0xc]
               	fcmp	s2, s0
               	b.ne	<addr>
               	ldr	s2, [x0, #0x10]
               	fcmp	s2, s0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s0, #2.00000000
               	fmov	s2, #3.00000000
               	fmov	s3, #4.00000000
               	fmov	s4, #5.00000000
               	ldur	s5, [x29, #-0x18]
               	fcmp	s5, s1
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x14]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x10]
               	fcmp	s0, s2
               	b.ne	<addr>
               	ldur	s0, [x29, #-0xc]
               	fcmp	s0, s3
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8]
               	fcmp	s0, s4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
