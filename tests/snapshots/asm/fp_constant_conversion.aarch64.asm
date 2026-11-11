
fp_constant_conversion.aarch64:	file format elf64-littleaarch64

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

<check>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	q0, [sp, #0x40]
               	str	q1, [sp, #0x50]
               	str	q2, [sp, #0x60]
               	str	q3, [sp, #0x70]
               	str	q4, [sp, #0x80]
               	str	q5, [sp, #0x90]
               	str	q6, [sp, #0xa0]
               	str	q7, [sp, #0xb0]
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #-0x38             // =-56
               	str	w17, [x16, #0x18]
               	mov	x17, #-0x80             // =-128
               	str	w17, [x16, #0x1c]
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	mov	x1, x0
               	ldrsw	x4, [x29, #0x10]
               	cmp	w0, w4
               	b.ge	<addr>
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x4, x16
               	ldr	d0, [x4]
               	add	x4, x3, x0, lsl #3
               	ldr	d1, [x4]
               	fcmp	d0, d1
               	cset	x4, ne
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	ldrsw	x4, [x29, #0x10]
               	cmp	w0, w4
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x16, <addr>
               	ldr	s0, [x16, #0x28]
               	stur	s0, [x29, #-0x8]
               	mov	x0, #0x5                // =5
               	fmov	d0, #1.50000000
               	fmov	d1, #2.50000000
               	fmov	d2, #3.00000000
               	fmov	d3, #-7.00000000
               	mov	x16, #0x43f0000000000000 // =4895412794951729152
               	fmov	d4, x16
               	bl	<addr>
               	ldur	s0, [x29, #-0x8]
               	add	x1, x0, #0x1
               	adrp	x16, <addr>
               	ldr	s1, [x16, #0x28]
               	fcmp	s1, s0
               	csel	x0, x1, x0, ne
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
