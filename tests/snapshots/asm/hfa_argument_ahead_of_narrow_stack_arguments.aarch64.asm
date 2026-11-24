
hfa_argument_ahead_of_narrow_stack_arguments.aarch64:	file format elf64-littleaarch64

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

<f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	x8, [x29, #0x10]
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	cmp	x8, x9
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x8, [x8]
               	cmp	w8, #0x2a
               	b.ne	<addr>
               	ldrsw	x8, [x29, #0x18]
               	cmn	w8, #0x7
               	b.ne	<addr>
               	ldrsw	x8, [x29, #0x20]
               	cmp	w8, #0x9
               	b.ne	<addr>
               	ldrsw	x8, [x29, #0x28]
               	cmn	w8, #0xb
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	s4, #2.00000000
               	fmadd	s0, s1, s4, s0
               	fmov	s1, #3.00000000
               	fmadd	s0, s2, s1, s0
               	fmov	s1, #4.00000000
               	fmadd	s0, s3, s1, s0
               	fcvtzs	x8, s0
               	add	x0, x8, x0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	mov	x1, #0x0                // =0
               	mov	x2, #0x3                // =3
               	cmp	x0, #0x42
               	csel	x0, x1, x2, eq
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	fmov	s0, #1.00000000
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	fmov	s1, #2.00000000
               	ldur	s2, [x29, #-0x8]
               	fmul	s1, s1, s2
               	fmov	s2, #3.00000000
               	ldur	s3, [x29, #-0x8]
               	fmul	s2, s2, s3
               	fmov	s3, #4.00000000
               	ldur	s4, [x29, #-0x8]
               	fmul	s3, s3, s4
               	ldur	s4, [x29, #-0x8]
               	fcvtzs	x0, s4
               	lsl	x1, x0, #1
               	add	x2, x0, x0, lsl #1
               	lsl	x3, x0, #2
               	add	x4, x0, x0, lsl #2
               	mov	x17, #0x6               // =6
               	mul	x5, x0, x17
               	mov	x17, #0x7               // =7
               	mul	x6, x0, x17
               	lsl	x7, x0, #3
               	adrp	x8, <page>
               	add	x8, x8, <lo12>
               	str	x8, [sp]
               	mov	x16, #-0x7              // =-7
               	str	x16, [sp, #0x8]
               	mov	x16, #0x9               // =9
               	str	x16, [sp, #0x10]
               	mov	x16, #-0xb              // =-11
               	str	x16, [sp, #0x18]
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
