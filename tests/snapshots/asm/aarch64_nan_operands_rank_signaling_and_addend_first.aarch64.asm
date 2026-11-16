
aarch64_nan_operands_rank_signaling_and_addend_first.aarch64:	file format elf64-littleaarch64

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

<u2f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<f2u>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, #0x0               // =0
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	stur	d0, [x29, #-0x40]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x8]
               	stur	d0, [x29, #-0x38]
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x10]
               	stur	d0, [x29, #-0x30]
               	fmov	d0, #1.00000000
               	stur	d0, [x29, #-0x28]
               	stur	x20, [x29, #-0x20]
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d0, x16
               	stur	d0, [x29, #-0x18]
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	fadd	d0, d0, d1
               	fmov	x0, d0
               	mov	x17, #0x2               // =2
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	fmul	d0, d0, d1
               	fmov	x0, d0
               	mov	x17, #0x2               // =2
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x30]
               	fsub	d0, d0, d1
               	fmov	x0, d0
               	mov	x17, #0x1               // =1
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x30]
               	ldur	d1, [x29, #-0x40]
               	fdiv	d0, d0, d1
               	fmov	x0, d0
               	mov	x17, #0x3               // =3
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7fc0, lsl #16
               	bl	<addr>
               	stur	s0, [x29, #-0x10]
               	mov	x0, #0x2                // =2
               	movk	x0, #0xff80, lsl #16
               	bl	<addr>
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x10]
               	ldur	s1, [x29, #-0x8]
               	fadd	s0, s0, s1
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0xffc0, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	ldur	s0, [x29, #-0x8]
               	ldur	s1, [x29, #-0x10]
               	fmul	s0, s0, s1
               	bl	<addr>
               	mov	x17, #0x2               // =2
               	movk	x17, #0xffc0, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	orr	x20, x20, #0x2
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x28]
               	ldur	d2, [x29, #-0x30]
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	mov	x17, #0x3               // =3
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x38]
               	ldur	d2, [x29, #-0x30]
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	mov	x17, #0x2               // =2
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	ldur	d0, [x29, #-0x28]
               	ldur	d1, [x29, #-0x40]
               	ldur	d2, [x29, #-0x38]
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	mov	x17, #0x2               // =2
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x40]
               	ldur	d1, [x29, #-0x30]
               	ldur	d2, [x29, #-0x28]
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	mov	x17, #0x1               // =1
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	orr	x20, x20, #0x4
               	ldur	d0, [x29, #-0x18]
               	ldur	d1, [x29, #-0x20]
               	ldur	d2, [x29, #-0x30]
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	mov	x17, #0x7ff8000000000000 // =9221120237041090560
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	d0, [x29, #-0x20]
               	ldur	d1, [x29, #-0x18]
               	ldur	d2, [x29, #-0x40]
               	fmadd	d0, d0, d1, d2
               	fmov	x0, d0
               	mov	x17, #0x7ff8000000000000 // =9221120237041090560
               	cmp	x0, x17
               	b.eq	<addr>
               	orr	x20, x20, #0x8
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
