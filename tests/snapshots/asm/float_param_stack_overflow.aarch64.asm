
float_param_stack_overflow.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x28]
               	str	x16, [sp, #0x10]
               	sub	sp, sp, #0x80
               	stp	d8, d9, [sp, #-0x30]!
               	str	d10, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	fmov	d9, d1
               	ldr	s1, [x29, #0x90]
               	ldr	s8, [x29, #0xa0]
               	mov	x0, #0x3f800000         // =1065353216
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s17, w1
               	fmul	s9, s9, s17
               	fmov	s17, w0
               	fmadd	s0, s0, s17, s9
               	mov	x0, #0x40800000         // =1082130432
               	fmov	s17, w0
               	fmadd	s0, s2, s17, s0
               	mov	x0, #0x41000000         // =1090519040
               	fmov	s17, w0
               	fmadd	s0, s3, s17, s0
               	mov	x0, #0x41800000         // =1098907648
               	fmov	s17, w0
               	fmadd	s0, s4, s17, s0
               	mov	x0, #0x42000000         // =1107296256
               	fmov	s17, w0
               	fmadd	s0, s5, s17, s0
               	mov	x0, #0x42800000         // =1115684864
               	fmov	s17, w0
               	fmadd	s0, s6, s17, s0
               	mov	x0, #0x43000000         // =1124073472
               	fmov	s17, w0
               	fmadd	s0, s7, s17, s0
               	mov	x0, #0x43800000         // =1132462080
               	fmov	s17, w0
               	fmadd	s0, s1, s17, s0
               	mov	x0, #0x44000000         // =1140850688
               	fmov	s17, w0
               	fmadd	s0, s8, s17, s0
               	fcvtzs	x0, s0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	add	sp, sp, #0xa0
               	ret

<main>:
               	str	d8, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
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
               	sxtw	x0, w0
               	cmp	x0, #0x3ff
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3fc00000         // =1069547520
               	mov	x2, #0x3f000000         // =1056964608
               	mov	x9, x0
               	sub	sp, sp, #0x10
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	fmov	d0, d8
               	fmov	d7, d8
               	fmov	d6, d8
               	fmov	d5, d8
               	fmov	d4, d8
               	fmov	d3, d8
               	fmov	d2, d8
               	fmov	d1, d8
               	blr	x9
               	add	sp, sp, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x37f
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	d8, [sp], #0x30
               	ret
