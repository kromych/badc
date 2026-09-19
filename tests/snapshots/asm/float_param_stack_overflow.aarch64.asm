
float_param_stack_overflow.aarch64:	file format elf64-littleaarch64

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

<wsum>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	ldr	s19, [x29, #0x10]
               	ldr	s20, [x29, #0x18]
               	fmov	s21, #1.00000000
               	fmov	s22, #2.00000000
               	fmul	s1, s1, s22
               	fmadd	s0, s0, s21, s1
               	fmov	s1, #4.00000000
               	fmadd	s0, s2, s1, s0
               	fmov	s1, #8.00000000
               	fmadd	s0, s3, s1, s0
               	fmov	s1, #16.00000000
               	fmadd	s0, s4, s1, s0
               	mov	x16, #0x42000000        // =1107296256
               	fmov	s1, w16
               	fmadd	s0, s5, s1, s0
               	mov	x16, #0x42800000        // =1115684864
               	fmov	s1, w16
               	fmadd	s0, s6, s1, s0
               	mov	x16, #0x43000000        // =1124073472
               	fmov	s1, w16
               	fmadd	s0, s7, s1, s0
               	mov	x16, #0x43800000        // =1132462080
               	fmov	s1, w16
               	fmadd	s0, s19, s1, s0
               	mov	x16, #0x44000000        // =1140850688
               	fmov	s1, w16
               	fmadd	s0, s20, s1, s0
               	fcvtzs	x0, s0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	d8, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	s8, [x0]
               	sub	sp, sp, #0x10
               	str	d8, [sp]
               	str	d8, [sp, #0x8]
               	fmov	d0, d8
               	fmov	d7, d8
               	fmov	d6, d8
               	fmov	d5, d8
               	fmov	d4, d8
               	fmov	d3, d8
               	fmov	d2, d8
               	fmov	d1, d8
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	w0, #0x3ff
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	fmov	s0, #1.50000000
               	fmov	s1, #0.50000000
               	sub	sp, sp, #0x10
               	str	d0, [sp]
               	str	d1, [sp, #0x8]
               	fmov	d0, d8
               	fmov	d7, d8
               	fmov	d6, d8
               	fmov	d5, d8
               	fmov	d4, d8
               	fmov	d3, d8
               	fmov	d2, d8
               	fmov	d1, d8
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	w0, #0x37f
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	d8, [sp], #0x20
               	ret
